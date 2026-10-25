package
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.net.SharedObject;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.setTimeout;
    import timelineprobe.ProbeClip;
    import timelineprobe.BuildInfo;

    public class TimelinePauseHost extends Sprite
    {
        private static const SO_NAME:String="yzlr2_timeline_helper_probe_v1";
        private var label:TextField=new TextField();
        private var report:Object={generation:BuildInfo.GENERATION,phase:"starting",runtimeExecuted:true,checks:[],samples:{},errors:[]};
        private var stopped:ProbeClip;
        private var running:ProbeClip;
        private var helper:Object;
        private var loader:Loader;
        private var baseStopped:int;
        private var baseRunning:int;
        private var stoppedAt:int;
        private var runningAt:int;
        private var missingBefore:Object;
        private var apiBefore:Object;
        private var failures:int=0;

        public function TimelinePauseHost()
        {
            super();
            // A direct projector can expose Stage before LoaderInfo is complete.
            // Reading swfVersion in the document constructor then raises Error 2099.
            loaderInfo.addEventListener(Event.COMPLETE,startWhenReady);
            addEventListener(Event.ENTER_FRAME,startWhenReady);
        }
        private function startWhenReady(e:Event):void
        {
            if(!stage)return;
            try {var readyVersion:uint=loaderInfo.swfVersion;}
            catch(error:Error)
            {
                if(error.errorID==2099)return;
                throw error;
            }
            loaderInfo.removeEventListener(Event.COMPLETE,startWhenReady);
            removeEventListener(Event.ENTER_FRAME,startWhenReady);
            start();
        }
        private function start():void
        {
            graphics.beginFill(0x14232E);graphics.drawRect(0,0,940,580);graphics.endFill();
            label.defaultTextFormat=new TextFormat("_sans",13,0xE9F1EF);label.width=910;label.height=560;
            label.x=15;label.y=12;label.multiline=true;label.wordWrap=true;label.selectable=true;addChild(label);
            report.hostVersion=loaderInfo.swfVersion;report.hostURL=loaderInfo.url;
            check("Direct host header is SWF9",loaderInfo.swfVersion==9);
            stopped=new ProbeClip();running=new ProbeClip();addChild(stopped);addChild(running);
            check("Both authored clips have four frames",stopped.totalFrames==4 && running.totalFrames==4);
            stopped.gotoAndStop(2);running.gotoAndPlay(1);
            missingBefore=hostMissingLabel();apiBefore=hostInspect(stopped);
            report.samples.hostMissingBefore=missingBefore;report.samples.hostApiBefore=apiBefore;
            check("SWF9 missing label does not throw before helper",missingBefore.threw===false);
            check("Direct SWF9 host cannot read playback API",apiBefore.supported===false);
            report.phase="settling authored first frame";paint();setTimeout(beginBaseline,100);
        }
        private function beginBaseline():void
        {
            baseStopped=stopped.enteredFrames;baseRunning=running.enteredFrames;
            report.phase="baseline";paint();setTimeout(baseline,400);
        }
        private function baseline():void
        {
            check("Stopped clip remains stopped in baseline",stopped.currentFrame==2 && stopped.enteredFrames==baseStopped);
            check("Playing clip executes native frame scripts",running.enteredFrames>baseRunning);
            loader=new Loader();addChild(loader);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaded);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadFailed);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadFailed);
            var context:LoaderContext=new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
            report.phase="loading SWF14 child helper";paint();
            loader.load(new URLRequest("TimelineHelper14.swf"),context);
        }
        private function loadFailed(e:Event):void {report.errors.push(e.toString());check("Child helper loads",false);finish();}
        private function loaded(e:Event):void
        {
            try
            {
                helper=Object(loader.content);report.samples.helperInfo=helper.info();
                check("Loaded helper header is SWF14",int(helper.info().version)==14);
                check("Helper has a child application domain",loader.contentLoaderInfo.applicationDomain!==ApplicationDomain.currentDomain && loader.contentLoaderInfo.applicationDomain.parentDomain===ApplicationDomain.currentDomain);
                check("Helper class does not leak into parent domain",!ApplicationDomain.currentDomain.hasDefinition("TimelineHelper"));
                var a:Object=helper.inspect(stopped);var b:Object=helper.inspect(running);
                report.samples.stoppedRead=a;report.samples.runningRead=b;
                check("SWF14 helper reads stopped false",a.supported===true && a.playing===false);
                check("SWF14 helper reads running true",b.supported===true && b.playing===true);
                var after:Object=hostMissingLabel();report.samples.hostMissingAfter=after;
                check("Host missing-label semantics preserved",after.threw===missingBefore.threw && after.threw===false);
                var apiAfter:Object=hostInspect(stopped);report.samples.hostApiAfter=apiAfter;
                check("Host API exposure unchanged",apiAfter.supported===apiBefore.supported);
                var helperLabel:ProbeClip=new ProbeClip();addChild(helperLabel);helperLabel.stop();
                var modern:Object=helper.missingLabel(helperLabel);report.samples.helperMissing=modern;removeChild(helperLabel);
                check("Helper label call yields a recognized result (see samples)",modern.threw===false || (modern.threw===true && int(modern.errorID)==2109));
                report.samples.freeze=helper.freeze(this,[stopped,running]);
                check("Freeze stops exactly one previously running clip",int(report.samples.freeze.stopped)==1 && report.samples.freeze.errors.length==0);
                report.samples.repeatFreeze=helper.freeze(this,[stopped,running]);
                check("Repeated freeze preserves original set",report.samples.repeatFreeze.repeated===true && int(report.samples.repeatFreeze.stopped)==1);
                report.samples.frameCountsAtFreeze={stopped:stopped.enteredFrames,running:running.enteredFrames};
                check("Helper sees running clip stopped immediately",helper.inspect(running).playing===false);
                report.phase="settling same-frame scripts after stop";paint();setTimeout(beginFrozenCheck,100);
            }
            catch(error:Error){unexpected(error);}
        }
        private function beginFrozenCheck():void
        {
            stoppedAt=stopped.enteredFrames;runningAt=running.enteredFrames;
            report.samples.frameCountsAfterStopSettle={stopped:stoppedAt,running:runningAt};
            report.phase="frozen 400ms";paint();setTimeout(frozenCheck,400);
        }
        private function frozenCheck():void
        {
            try
            {
                report.samples.frozenFrames={stopped:stopped.enteredFrames,running:running.enteredFrames};
                check("Stopped clip does not execute frames while frozen",stopped.enteredFrames==stoppedAt && stopped.currentFrame==2);
                check("Running clip does not execute frames while frozen",running.enteredFrames==runningAt);
                check("Resume plays exactly captured clip",int(helper.resume())==1);
                check("Repeated resume is a no-op",int(helper.resume())==0);
                report.phase="resumed 400ms";paint();setTimeout(resumedCheck,400);
            }
            catch(error:Error){unexpected(error);}
        }
        private function resumedCheck():void
        {
            try
            {
                check("Originally stopped clip never restarts",stopped.enteredFrames==stoppedAt && stopped.currentFrame==2);
                check("Originally running clip resumes frame scripts",running.enteredFrames>runningAt);
                helper.freeze(this,[running]);removeChild(running);
                check("Removed clip is not restarted by resume",int(helper.resume())==0 && helper.inspect(running).playing===false);
                finish();
            }
            catch(error:Error){unexpected(error);}
        }
        private function hostInspect(clip:MovieClip):Object
        {
            try {var state:*=Object(clip)["isPlaying"];return {supported:state is Boolean,value:state is Boolean?state:null};}
            catch(e:Error){return {supported:false,errorID:e.errorID};}
            return {supported:false,errorID:-1};
        }
        private function hostMissingLabel():Object
        {
            var clip:ProbeClip=new ProbeClip();addChild(clip);clip.gotoAndStop(2);
            var result:Object;
            try {clip.gotoAndStop("__missing_probe_label__");result={threw:false,frame:clip.currentFrame};}
            catch(e:Error){result={threw:true,errorID:e.errorID};}
            removeChild(clip);return result;
        }
        private function check(name:String,pass:Boolean):void
        {report.checks.push({name:name,pass:pass});if(!pass)failures++;}
        private function unexpected(e:Error):void
        {report.errors.push({error:e.toString(),id:e.errorID});check("No unexpected harness error",false);finish();}
        private function finish():void
        {report.phase="complete";report.pass=failures==0;report.failures=failures;paint();}
        private function paint():void
        {
            var out:String="ISOLATED TIMELINE PAUSE PROBE | direct SWF9 host + child SWF14 helper\n";
            out+="Phase: "+report.phase+" | "+report.checks.length+" checks | failures: "+failures+"\n";
            out+="Generation: "+BuildInfo.GENERATION+"\nDiagnostic SO: "+SO_NAME+" (no game save access)\n\n";
            for each(var c:Object in report.checks)out+=(c.pass?"PASS  ":"FAIL  ")+c.name+"\n";
            for each(var e:Object in report.errors)out+="ERROR "+String(e)+"\n";
            label.text=out;
            try {var store:SharedObject=SharedObject.getLocal(SO_NAME);store.data.report=report;report.flushStatus=store.flush();}
            catch(error:Error){label.appendText("\nDiagnostic flush failed: "+error.toString());}
        }
    }
}
