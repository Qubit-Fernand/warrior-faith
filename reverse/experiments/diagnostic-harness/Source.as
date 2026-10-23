package {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    // Observation only. Task methods are a narrowly audited read-only whitelist.
    [SWF(width="940", height="580", backgroundColor="#333333", frameRate="27")]
    public class Source extends Sprite {
        private const TARGET:String = "3_L4399Main_gamefile.swf";
        private const SAVE:String = "yzlr2_diagnostic_probe";
        private const MAX_BYTES:int = 60000;
        private var game:Loader = new Loader();
        private var domain:ApplicationDomain;
        private var main:Object;
        private var clock:Timer = new Timer(1000);
        private var indicator:TextField = new TextField();
        private var store:SharedObject;
        private var report:Object;
        private var sequence:int = 0;
        private var frames:int = 0;
        private var previousFrames:int = 0;
        private var previousTime:int = 0;
        private var identities:Dictionary = new Dictionary(true);
        private var nextIdentity:int = 1;
        private var persistence:String = "starting";
        private var requestLoader:URLLoader = new URLLoader();
        private var requestBusy:Boolean = false;
        private var lastRequest:String = "";
        private var label:String = "run";
        private var resolveClassIdentities:Boolean = false;
        private var observedHitClass:Object;

        public function Source() {
            if(stage) start();
            else addEventListener(Event.ADDED_TO_STAGE, start);
        }
        private function start(event:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, start);
            report = {schema:"yzlr2-diagnostic-v1", wrapperVersion:2, wrapper:loaderInfo.url,
                target:TARGET, startedUTC:new Date().toUTCString(),
                samples:[], errors:[], loaded:false, mode:"wrapper-not-direct-launch",
                resolveClassIdentities:false, classResolutionWarning:"Opt-in getDefinition identity checks may initialize unused classes and advance VT random masking."};
            // Only this explicitly named diagnostic object is opened or written.
            try { store = SharedObject.getLocal(SAVE, "/"); }
            catch(error:Error) { persistence = "SO denied"; }
            addChild(game);
            indicator.defaultTextFormat = new TextFormat("_sans", 11, 0x00FF99);
            indicator.width = 480; indicator.height = 21;
            indicator.background = true; indicator.backgroundColor = 0x111111;
            indicator.selectable = false; indicator.mouseEnabled = false;
            addChild(indicator);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
            addEventListener(Event.ENTER_FRAME, countFrame);
            game.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
            game.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
            game.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
            game.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaught);
            domain = new ApplicationDomain(ApplicationDomain.currentDomain);
            clock.addEventListener(TimerEvent.TIMER, tick);
            requestLoader.addEventListener(Event.COMPLETE, requestComplete);
            requestLoader.addEventListener(IOErrorEvent.IO_ERROR, requestFailed);
            requestLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, requestFailed);
            previousTime = getTimer(); clock.start();
            game.load(new URLRequest(TARGET), new LoaderContext(false, domain));
            capture("start");
        }
        private function countFrame(event:Event):void { frames++; }
        private function tick(event:TimerEvent):void {
            capture("timer");
            if(!requestBusy) {
                requestBusy = true;
                try { requestLoader.load(new URLRequest("diagnostic-request.json")); }
                catch(error:Error) { requestBusy = false; }
            }
        }
        private function requestFailed(event:Event):void { requestBusy = false; }
        private function requestComplete(event:Event):void {
            requestBusy = false;
            try {
                var request:Object = JSON.parse(String(requestLoader.data));
                if(request.schema != "yzlr2-diagnostic-request-v1" || !(request.id is String) || request.id == lastRequest) return;
                lastRequest = request.id;
                if(request.resolveClassIdentities is Boolean) {
                    resolveClassIdentities=request.resolveClassIdentities;
                    report.resolveClassIdentities=resolveClassIdentities;
                }
                if(request.label is String) label = String(request.label).substr(0,64);
                if(request.snapshot === true) capture("label-request");
            } catch(error:Error) {}
        }
        private function keyDown(event:KeyboardEvent):void {
            if(event.keyCode == 119) capture("F8");
        }
        private function loaded(event:Event):void {
            report.loaded = true;
            report.loadedURL = game.contentLoaderInfo.url;
            report.documentClass = getQualifiedClassName(game.content);
            // The document constructor has already run; this lookup does not create an instance.
            if(domain.hasDefinition("src.Main")) main = domain.getDefinition("src.Main");
            capture("complete");
        }
        private function loadError(event:ErrorEvent):void { errorRecord(event.type, event.text); }
        private function uncaught(event:UncaughtErrorEvent):void {
            var text:String = "non-Error throwable";
            if(event.error is Error) text = Error(event.error).name + ": " + Error(event.error).message;
            else if(event.error is ErrorEvent) text = ErrorEvent(event.error).text;
            errorRecord("uncaught", text);
            // Deliberately do not preventDefault: debugger behavior remains visible.
        }
        private function errorRecord(kind:String, message:String):void {
            report.errors.push({ms:getTimer(), kind:kind, text:message.substr(0,220)});
            while(report.errors.length > 8) report.errors.shift();
            persist();
        }
        private function read(object:Object, key:String):* {
            try { if(object != null && key in object) return object[key]; }
            catch(error:Error) {}
            return null;
        }
        private function scalar(value:*):* {
            if(value is Boolean) return value;
            if(value is Number) return isFinite(Number(value)) ? value : null;
            if(value is String) return String(value).substr(0,100);
            return null;
        }
        private function number(value:*):* {
            if(value is Number) return scalar(value);
            if(value == null) return null;
            // VT.value getter is source-audited: it only returns _value.
            // Do not call game getValue(), toString(), or arbitrary accessors.
            if(getQualifiedClassName(value) != "com.hotpoint.braveManIII.models.common::VT") return null;
            var masked:Object = read(value, "value");
            var a:* = read(masked, "num"); var b:* = read(masked, "random");
            return a is Number && b is Number ? scalar(Number(a)-Number(b)) : null;
        }
        private function identity(object:Object):int {
            if(!identities[object]) identities[object] = nextIdentity++;
            return identities[object];
        }
        private function animation(skin:Object):Object {
            if(skin == null) return null;
            var result:Object = {type:scalar(read(skin,"runType")), frame:scalar(read(skin,"frame")),
                stop:scalar(read(skin,"stopRun")), over:scalar(read(skin,"runOver")),
                continuous:scalar(read(skin,"continuous")), className:getQualifiedClassName(skin)};
            var clip:MovieClip = skin as MovieClip;
            if(clip) { result.timelineFrame = clip.currentFrame; result.label = clip.currentLabel; }
            clip = read(skin,"playX") as MovieClip;
            if(clip) { result.playFrame = clip.currentFrame; result.playLabel = clip.currentLabel; }
            return result;
        }
        private function player(object:Object):Object {
            if(object == null) return null;
            return {identity:identity(object), className:getQualifiedClassName(object),
                x:scalar(read(object,"x")), y:scalar(read(object,"y")),
                hp:number(read(object,"hp")), hpMax:number(read(object,"hp_Max")),
                mp:number(read(object,"mp")), mpMax:number(read(object,"mp_Max")),
                facing:scalar(read(object,"RL")), noMove:scalar(read(object,"noMove")),
                animation:animation(read(object,"skin"))};
        }
        private function enemy(object:Object):Object {
            return {identity:identity(object), id:scalar(read(object,"id")),
                className:scalar(read(object,"className")),
                x:scalar(read(object,"x")), y:scalar(read(object,"y")),
                hp:number(read(object,"life")), hpMax:number(read(object,"lifeMAX")),
                over:scalar(read(object,"over")), animation:animation(read(object,"skin"))};
        }
        private function world(object:Object):Object {
            if(object == null) return null;
            var result:Object = {className:getQualifiedClassName(object),
                x:scalar(read(object,"x")), y:scalar(read(object,"y")),
                width:scalar(read(object,"_width")), nextNode:scalar(read(object,"nextNode")),
                stop:scalar(read(object,"stopYn")), runX:scalar(read(object,"runX")),
                runY:scalar(read(object,"runY")), enemies:[]};
            var map:Object = read(object,"MapData");
            if(map) result.mapClass = getQualifiedClassName(map);
            var container:DisplayObjectContainer = read(object,"moveChild_Enemy") as DisplayObjectContainer;
            if(container) {
                result.enemyChildren = container.numChildren;
                result.enemyChildrenTruncated = container.numChildren > 12;
                for(var i:int = 0; i < Math.min(container.numChildren,12); i++) {
                    var child:DisplayObject = container.getChildAt(i);
                    // Only known Enemy public fields; unrelated effects are not traversed.
                    if(getQualifiedClassName(child) == "src::Enemy") result.enemies.push(enemy(child));
                }
            }
            return result;
        }
        private function item(object:Object, slot:int, equipped:Boolean):Object {
            var id:* = number(read(object,equipped ? "base" : "id"));
            if(id == null) id = number(read(object,"base"));
            if(id == null) id = number(read(object,"fallId"));
            return {slot:slot, id:id, count:number(read(object,"times"))};
        }
        private function inventory(data:Object):Object {
            if(data == null) return null;
            var result:Object = {equipped:[], bags:{}};
            var slots:Array = read(read(data,"equipSlot"),"slot") as Array;
            var i:int;
            if(slots) for(i=0;i<Math.min(slots.length,13);i++) if(slots[i]) result.equipped.push(item(slots[i],i,true));
            var bag:Object = read(data,"bag");
            for each(var name:String in ["equipBag","suppliesBag","gemBag","questBag","otherobjBag"]) {
                var array:Array = read(bag,name) as Array;
                if(!array) continue;
                var entries:Array = []; var occupied:int = 0;
                for(i=0;i<Math.min(array.length,24);i++) if(array[i]) {
                    occupied++; if(entries.length<6) entries.push(item(array[i],i,name=="equipBag"));
                }
                result.bags[name] = {capacity:array.length, occupied:occupied,
                    scanTruncated:array.length>24, itemSummaryTruncated:occupied>6, items:entries};
            }
            return result;
        }
        private function numbers(array:Array):Array {
            var result:Array = [];
            if(array) for(var i:int=0;i<Math.min(array.length,6);i++) result.push(number(array[i]));
            return result;
        }
        private function tasks():Object {
            // Main.GameStart calls TaskData.initAllTask before AddMap; an existing world establishes prior use.
            var name:String = "com.hotpoint.braveManIII.views.taskPanel.TaskData";
            if(!domain.hasDefinition(name)) return {available:false};
            var array:Array = read(domain.getDefinition(name),"taskArr") as Array;
            if(!array) return {available:false};
            var result:Object = {available:true, scanned:Math.min(array.length,512), truncated:array.length>512, watched:[]};
            for(var i:int=0;i<Math.min(array.length,512);i++) {
                var task:Object = array[i];
                if(task == null || getQualifiedClassName(task)!="com.hotpoint.braveManIII.models.task::Task") continue;
                // Audited implementations: VT reads / direct array return only. No factory, saveTask, state updates.
                var id:Number = task.getId();
                if(id==110001 || id==110002) result.watched.push({id:id,state:task.getState(),
                    oldTime:task.getOldTime(),goods:numbers(task.getGoodsedNum()),enemies:numbers(task.getEenemyedNum())});
            }
            return result;
        }
        private function domainInfo(resource:ApplicationDomain):Object {
            var result:Object = {identity:identity(resource), isMain:resource===domain,
                parent:resource.parentDomain ? identity(resource.parentDomain) : null,availableDefinitions:{},sameAsMain:{}};
            for each(var name:String in ["src.Main","src.HitXX","src.Skin_ZhuangBei"]) {
                var available:Boolean = resource.hasDefinition(name);
                result.availableDefinitions[name]=available;
                result.sameAsMain[name] = resolveClassIdentities && available && domain.hasDefinition(name) ? resource.getDefinition(name)===domain.getDefinition(name) : null;
            }
            return result;
        }
        private function resources():Object {
            var result:Object = {mainDomain:identity(domain),wrapperDomain:identity(ApplicationDomain.currentDomain),resolveClassIdentities:resolveClassIdentities,loaders:[],npcs:[],skinInstances:[]};
            // Map and Player have existing instances; GameData.GetData already uses Enemy before AddMap.
            var collections:Array = [["src.Map","MapArr"],["src.Enemy","EnemyArr"],["src.Player","PlayerMcArr"]];
            if(resolveClassIdentities) collections=collections.concat([["src.Skin_ZhuangBei","PlayerMcArr"],["src.Skin_WuQi","PlayerMcArr"]]);
            var wanted:Array = ["src.npc.村长","src.npc.装备","src.npc.船长2"];
            var npcClasses:Object = {};
            for each(var spec:Array in collections) {
                if(!domain.hasDefinition(spec[0])) continue;
                var array:Array = read(domain.getDefinition(spec[0]),spec[1]) as Array;
                if(!array) continue;
                var collected:int = 0;
                var indices:Array=[];
                if(spec[0]=="src.Map") {
                    for each(var mapIndex:int in [int(number(read(main,"gameNum"))),0,9]) if(indices.indexOf(mapIndex)<0) indices.push(mapIndex);
                } else for(var k:int=0;k<Math.min(array.length,256);k++) indices.push(k);
                for(var i:int=0;i<indices.length && collected<3;i++) {
                    var index:int=indices[i];var holder:Object = array[index];
                    var loader:Loader = read(holder,"loader") as Loader;
                    if(!loader || loader.contentLoaderInfo.bytesTotal==0 || loader.contentLoaderInfo.bytesLoaded<loader.contentLoaderInfo.bytesTotal) continue;
                    var resource:ApplicationDomain = loader.contentLoaderInfo.applicationDomain;
                    var row:Object = domainInfo(resource); row.collection=spec.join(".");row.index=index;
                    row.rootClass=loader.content ? getQualifiedClassName(loader.content) : null;
                    row.rootChildren=loader.content is DisplayObjectContainer ? DisplayObjectContainer(loader.content).numChildren : null;
                    row.url=scalar(read(holder,"url"));result.loaders.push(row);collected++;
                    if(spec[0]=="src.Map") for each(var name:String in wanted) {
                        if(resource.hasDefinition(name)) {
                            if(!npcClasses[name]) npcClasses[name]=[];
                            npcClasses[name].push({type:resolveClassIdentities ? resource.getDefinition(name) : null,domain:identity(resource)});
                        }
                    }
                }
            }
            if(domain.hasDefinition("src.NewLoad")) {
                var equipment:Array=read(domain.getDefinition("src.NewLoad"),"zhuangBeiSkin") as Array;
                var count:int=0;
                if(equipment) for(var skinIndex:int=0;skinIndex<Math.min(equipment.length,3);skinIndex++) {
                    var files:Array=equipment[skinIndex] as Array;
                    if(!files) continue;
                    for(var fileIndex:String in files) {
                        if(count>=6) break;
                        holder=files[fileIndex];loader=read(holder,"loader") as Loader;
                        if(!loader || loader.contentLoaderInfo.bytesTotal==0 || loader.contentLoaderInfo.bytesLoaded<loader.contentLoaderInfo.bytesTotal) continue;
                        row=domainInfo(loader.contentLoaderInfo.applicationDomain);
                        row.collection="src.NewLoad.zhuangBeiSkin";row.skinIndex=skinIndex;row.fileIndex=fileIndex;
                        row.url=scalar(read(holder,"url"));row.rootClass=loader.content ? getQualifiedClassName(loader.content) : null;
                        row.rootChildren=loader.content is DisplayObjectContainer ? DisplayObjectContainer(loader.content).numChildren : null;
                        result.loaders.push(row);count++;
                    }
                }
                result.equipmentLoadersLimit=6;
            }
            // Observe existing stage instances only: never open NPC/VIP windows or reach private loadData.
            var queue:Array = [stage]; var visited:int = 0;
            while(queue.length>0 && visited<500) {
                var object:DisplayObject = queue.shift() as DisplayObject;visited++;
                var className:String = getQualifiedClassName(object).replace("::",".");
                if(className=="src.HitXX") observedHitClass=Object(object).constructor;
                if(wanted.indexOf(className)>=0 && result.npcs.length<12) {
                    var matches:Array=[];var candidates:Array=[];
                    if(npcClasses[className]) for each(var entry:Object in npcClasses[className]) {
                        candidates.push(entry.domain);
                        if(entry.type && Object(object).constructor===entry.type) matches.push(entry.domain);
                    }
                    result.npcs.push({className:className,instance:identity(object),visible:object.visible,
                        classIdentity:identity(Object(object).constructor),candidateResourceDomains:candidates,
                        matchedResourceDomains:resolveClassIdentities ? matches : null,loaderDomain:identity(object.loaderInfo.applicationDomain)});
                }
                if(className=="Skin" && result.skinInstances.length<6) {
                    var skinDomain:ApplicationDomain=object.loaderInfo.applicationDomain;
                    result.skinInstances.push({instance:identity(object),domain:identity(skinDomain),
                        classIdentity:identity(Object(object).constructor),url:object.loaderInfo.url});
                }
                var container:DisplayObjectContainer=object as DisplayObjectContainer;
                if(container && object!==indicator) for(i=0;i<Math.min(container.numChildren,100);i++) queue.push(container.getChildAt(i));
            }
            result.stageScanTruncated=queue.length>0;
            result.stageNodesScanned=visited;
            if(resolveClassIdentities && domain.hasDefinition("src.HitXX")) observedHitClass=domain.getDefinition("src.HitXX");
            array=read(observedHitClass,"AllHitXX") as Array;
            result.hitObjects=array ? array.length : null;
            result.hitClassPreviouslyObserved=observedHitClass!=null;
            return result;
        }
        private function capture(reason:String):void {
            try {
                var now:int = getTimer();
                var sample:Object = {sequence:sequence++, ms:now, reason:reason,label:label,resolveClassIdentities:resolveClassIdentities,
                    frame:frames, observedFPS:now > previousTime ?
                        Math.round((frames-previousFrames)*10000/(now-previousTime))/10 : null};
                previousFrames = frames; previousTime = now;
                if(main) {
                    sample.map = number(read(main,"gameNum"));
                    sample.room = number(read(main,"gameNum2"));
                    sample.village = scalar(read(main,"Map0_YN"));
                    sample.loadedSave = scalar(read(main,"loadSaveOver"));
                    sample.player1 = player(read(main,"player_1"));
                    sample.player2 = player(read(main,"player_2"));
                    sample.world = world(read(main,"world"));
                    if(read(main,"loadSaveOver") === true && read(main,"world") != null) {
                        sample.tasks=tasks();sample.inventory1=inventory(read(main,"player1"));
                        if(read(main,"P1P2")===true) sample.inventory2=inventory(read(main,"player2"));
                        sample.resources=resources();
                    }
                }
                var known:Array = ["src.Main","src.Player","src.Map","src.Skin","src.Enemy",
                    "src.GameData","src.Data","src.InData"];
                sample.availableDefinitions = [];
                for each(var name:String in known) if(domain.hasDefinition(name)) sample.availableDefinitions.push(name);
                report.samples.push(sample);
                while(report.samples.length > 24) report.samples.shift();
                persist();
                indicator.text = "DIAGNOSTIC | #"+sample.sequence+" | "+label+" | F8 | "+persistence;
            } catch(error:Error) { errorRecord("observer", error.name+": "+error.message); }
        }
        private function persist():void {
            if(!store) return;
            try {
                var encoded:String = JSON.stringify(report);
                var bytes:ByteArray = new ByteArray(); bytes.writeUTFBytes(encoded);
                while(bytes.length > MAX_BYTES && report.samples.length > 1) {
                    report.samples.shift(); encoded = JSON.stringify(report);
                    bytes.length = 0; bytes.writeUTFBytes(encoded);
                }
                if(bytes.length > MAX_BYTES) { persistence = "size limit"; return; }
                store.data.payload = encoded;
                persistence = store.flush() == SharedObjectFlushStatus.FLUSHED ? "saved" : "pending";
            } catch(error:Error) { persistence = "write denied"; }
        }
    }
}
