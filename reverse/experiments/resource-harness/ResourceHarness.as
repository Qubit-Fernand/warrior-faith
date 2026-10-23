package {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.events.UncaughtErrorEvent;
    import flash.net.SharedObject;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.Timer;
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;

    // Sequential import probe. Never adds library Loader/content to the stage,
    // never instantiates a definition, never accesses a game save or cloud API.
    [SWF(width="940", height="580", backgroundColor="#171a20", frameRate="27")]
    public class ResourceHarness extends Sprite {
        private const SAVE:String = "yzlr2_resource_probe";
        private const MAX_REPORT_BYTES:int = 90000;
        private var input:URLLoader = new URLLoader();
        private var current:Loader;
        private var domain:ApplicationDomain;
        private var timeout:Timer;
        private var store:SharedObject;
        private var report:Object;
        private var manifest:Object;
        private var row:Object;
        private var index:int = 0;
        private var token:int = 0;
        private var started:int = 0;
        private var done:Boolean = false;
        private var finishing:Boolean = false;
        private var persistence:String = "pending";
        private var display:TextField = new TextField();

        public function ResourceHarness() {
            display.defaultTextFormat = new TextFormat("_sans", 15, 0xddeeff);
            display.width = 920; display.height = 560; display.x = 10; display.y = 10;
            display.multiline = true; display.wordWrap = true; display.selectable = true;
            addChild(display);
            report = {schema:"yzlr2-resource-probe-v1", wrapper:loaderInfo.url,
                startedUTC:new Date().toUTCString(), runId:"pending", mode:"pending",
                complete:false, rows:[], fatal:[], persistError:"",
                scope:"standalone parent domain; no game Main; load/hasDefinition only"};
            // macOS projector may share this name under localhost across packages.
            // Export each completed result before running another package.
            try { store = SharedObject.getLocal(SAVE); }
            catch(error:Error) { persistence = "SO denied: " + error.message.substr(0,100); }
            input.addEventListener(Event.COMPLETE, manifestLoaded);
            input.addEventListener(IOErrorEvent.IO_ERROR, manifestFailed);
            input.addEventListener(SecurityErrorEvent.SECURITY_ERROR, manifestFailed);
            input.load(new URLRequest("probe-manifest.json"));
            show("Reading local probe manifest...");
        }
        private function manifestFailed(event:ErrorEvent):void {
            report.fatal.push(event.type + ": " + event.text.substr(0,160));
            done = true; persist(); show("Manifest failed; no modules loaded.");
        }
        private function manifestLoaded(event:Event):void {
            try {
                manifest = JSON.parse(String(input.data));
                if(manifest.schema != "yzlr2-resource-manifest-v1" || !(manifest.files is Array) || manifest.files.length != 162)
                    throw new Error("Invalid resource manifest");
                if(manifest.mode != "original" && manifest.mode != "rebuilt") throw new Error("Invalid probe mode");
                report.runId = String(manifest.runId); report.mode = String(manifest.mode);
                report.manifestId = String(manifest.manifestId); report.total = manifest.files.length;
                report.wrapperBuild = String(manifest.wrapperBuild);
                next();
            } catch(error:Error) {
                report.fatal.push(error.name + ": " + error.message.substr(0,160));
                done = true; persist(); show("Invalid manifest; probe stopped.");
            }
        }
        private function next():void {
            if(index >= manifest.files.length) {
                report.complete = true; report.finishedUTC = new Date().toUTCString();
                done = true; persist(); show("Finished all " + index + " resources."); return;
            }
            var spec:Object = manifest.files[index];
            var filename:String = String(spec.file);
            if(filename.indexOf("/") >= 0 || filename.indexOf("\\") >= 0 || filename.indexOf("..") >= 0 || filename.substr(-4) != ".swf") {
                report.fatal.push("Unsafe module filename"); done = true; persist(); return;
            }
            token++; finishing = false; started = getTimer();
            row = {m:String(spec.module), s:"loading", ms:0, t:"", n:-1, f:-1,
                expected:spec.symbols.length, missing:[], errors:[], errorCount:0,
                parent:false, completeEvent:false, initEvent:false};
            report.rows.push(row);
            current = new Loader();
            domain = new ApplicationDomain(ApplicationDomain.currentDomain);
            current.contentLoaderInfo.addEventListener(Event.INIT, initialized);
            current.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
            current.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, failed);
            current.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, failed);
            current.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaught);
            timeout = new Timer(12000,1); timeout.addEventListener(TimerEvent.TIMER_COMPLETE, timedOut); timeout.start();
            show("Loading " + (index+1) + "/162: " + row.m);
            try { current.load(new URLRequest("modules/" + filename),new LoaderContext(false,domain)); }
            catch(error:Error) { recordError("load_throw",error.name + ": " + error.message); finish("load_throw"); }
        }
        private function initialized(event:Event):void { row.initEvent = true; }
        private function loaded(event:Event):void {
            if(finishing) return;
            row.completeEvent = true;
            try {
                row.parent = current.contentLoaderInfo.applicationDomain.parentDomain === ApplicationDomain.currentDomain;
                var content:DisplayObject = current.content;
                row.t = getQualifiedClassName(content);
                if(content is DisplayObjectContainer) row.n = DisplayObjectContainer(content).numChildren;
                if(content is MovieClip) row.f = MovieClip(content).totalFrames;
                var spec:Object = manifest.files[index];
                var absent:int = 0;
                for each(var name:String in spec.symbols) {
                    if(!domain.hasDefinition(name)) {
                        absent++;
                        if(row.missing.length < 8) row.missing.push(name);
                    }
                }
                row.missingCount = absent;
                if(row.m == "Map0_v26" || row.m == "Enemy5_v2" || row.m == "Enemy16") {
                    row.tree = tree(content,0);
                    row.keyVisible = {};
                    for each(name in spec.keys) row.keyVisible[name] = domain.hasDefinition(name);
                }
            } catch(error:Error) { recordError("observe",error.name + ": " + error.message); }
            // Capture errors queued immediately after COMPLETE before disposing.
            var mine:int = token;
            setTimeout(function():void { if(mine == token && !finishing) finish("complete"); },150);
        }
        private function tree(object:DisplayObject,depth:int):Object {
            var r:Object = {type:getQualifiedClassName(object), name:object.name};
            if(object is MovieClip) r.frames = MovieClip(object).totalFrames;
            if(object is DisplayObjectContainer) {
                var c:DisplayObjectContainer = DisplayObjectContainer(object); r.children = c.numChildren;
                if(depth < 2) {
                    r.sample = [];
                    for(var i:int=0;i<Math.min(c.numChildren,6);i++) r.sample.push(tree(c.getChildAt(i),depth+1));
                }
            }
            return r;
        }
        private function failed(event:ErrorEvent):void { recordError(event.type,event.text); finish(event.type); }
        private function timedOut(event:TimerEvent):void { recordError("timeout","No COMPLETE within 12 seconds"); finish("timeout"); }
        private function uncaught(event:UncaughtErrorEvent):void {
            var text:String = "non-Error throwable";
            if(event.error is Error) text = Error(event.error).name + ": " + Error(event.error).message;
            else if(event.error is ErrorEvent) text = ErrorEvent(event.error).text;
            recordError("uncaught",text);
            // This is a diagnostic batch, not the game: record and continue.
            // The run retains errorCount and never counts this as a clean pass.
            event.preventDefault();
        }
        private function recordError(kind:String,text:String):void {
            if(!row) { report.fatal.push(kind + ": " + text.substr(0,120)); return; }
            row.errorCount++;
            if(row.errors.length < 2) row.errors.push(kind + ": " + text.substr(0,120));
        }
        private function finish(status:String):void {
            if(finishing || done) return;
            finishing = true; timeout.stop(); row.ms = getTimer()-started;
            row.s = status == "complete" && (row.errorCount > 0 || row.missingCount > 0) ? "complete_with_issues" : status;
            try { current.unloadAndStop(true); }
            catch(error:Error) { recordError("unload",error.message); row.s = "unload_error"; }
            current.contentLoaderInfo.removeEventListener(Event.INIT,initialized);
            current.contentLoaderInfo.removeEventListener(Event.COMPLETE,loaded);
            current.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,failed);
            current.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,failed);
            current.contentLoaderInfo.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,uncaught);
            current = null; domain = null; index++; report.completed = index;
            persist(); show("Recorded " + index + "/162");
            setTimeout(next,50);
        }
        private function persist():void {
            if(!store) return;
            try {
                var text:String = JSON.stringify(report);
                var bytes:ByteArray = new ByteArray(); bytes.writeUTFBytes(text);
                if(bytes.length > MAX_REPORT_BYTES) {
                    report.persistError = "Report exceeds size budget; errors truncated";
                    for each(var r:Object in report.rows) {
                        if(r.errors.length > 0) r.errors = [String(r.errors[0]).substr(0,70)];
                        if(r.missing.length > 2) r.missing = r.missing.slice(0,2);
                    }
                    text = JSON.stringify(report);
                }
                store.data.json = text;
                persistence = String(store.flush());
            } catch(error:Error) { persistence = error.name + ": " + error.message.substr(0,100); }
        }
        private function show(message:String):void {
            display.text = "勇士的信仰 · resource import probe\n\n" + message +
                "\nMode: " + report.mode + "   Run: " + report.runId +
                "\nSO: " + SAVE + " (dedicated name; may be shared across packages)\nPersistence: " + persistence +
                "\n\nLibraries stay off stage. No arbitrary class construction.\nExport this result before starting the other package.\n" +
                (done ? "\nDONE. Read diagnostic SOL; completion alone is not a clean-pass claim." : "");
        }
    }
}
