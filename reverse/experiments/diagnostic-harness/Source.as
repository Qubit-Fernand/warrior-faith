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
        private var wrapperDomain:ApplicationDomain;
        private var loaderDomains:Dictionary = new Dictionary(true);
        private var domainParents:Dictionary = new Dictionary(true);

        public function Source() {
            if(stage) start();
            else addEventListener(Event.ADDED_TO_STAGE, start);
        }
        private function start(event:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, start);
            report = {schema:"yzlr2-diagnostic-v1", wrapperVersion:5, wrapper:loaderInfo.url,
                target:TARGET, startedUTC:new Date().toUTCString(),
                samples:[], errors:[], observerErrors:[], loaded:false, mode:"wrapper-not-direct-launch",
                resolveClassIdentities:false,
                fieldSemantics:{hpBaseMax:"Player.hp_Max",hpEffectiveMax:"Player.use_hp_Max",mpBaseMax:"Player.mp_Max",mpEffectiveMax:"Player.use_mp_Max"},
                domainIdentitySemantics:"Cached API object handles keyed by LoaderInfo; handle equality is not VM domain identity. Getter-created wrappers are not evidence of reload.",
                classResolutionWarning:"Opt-in getDefinition identity checks may initialize unused classes and advance VT random masking."};
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
            game.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaught);
            wrapperDomain = ApplicationDomain.currentDomain;
            domain = new ApplicationDomain(wrapperDomain);
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
                hp:number(read(object,"hp")), hpBaseMax:number(read(object,"hp_Max")), hpEffectiveMax:number(read(object,"use_hp_Max")),
                mp:number(read(object,"mp")), mpBaseMax:number(read(object,"mp_Max")), mpEffectiveMax:number(read(object,"use_mp_Max")),
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
        private function cachedDomain(info:LoaderInfo):ApplicationDomain {
            // Getter results can be fresh API wrappers. Cache once per existing LoaderInfo.
            if(!loaderDomains[info]) loaderDomains[info]=info.applicationDomain;
            return loaderDomains[info] as ApplicationDomain;
        }
        private function domainInfo(resource:ApplicationDomain):Object {
            if(!(resource in domainParents)) domainParents[resource]=resource.parentDomain;
            var parent:ApplicationDomain=domainParents[resource] as ApplicationDomain;
            var result:Object = {cachedHandle:identity(resource), sameHandleAsRequestedMain:resource===domain,
                cachedParentHandle:parent ? identity(parent) : null,availableDefinitions:{},sameAsMain:{}};
            for each(var name:String in ["src.Main","src.HitXX","src.Skin_ZhuangBei"]) {
                var available:Boolean = resource.hasDefinition(name);
                result.availableDefinitions[name]=available;
                result.sameAsMain[name] = resolveClassIdentities && available && domain.hasDefinition(name) ? resource.getDefinition(name)===domain.getDefinition(name) : null;
            }
            return result;
        }
        private function resources():Object {
            var result:Object = {requestedMainHandle:identity(domain),wrapperHandle:identity(wrapperDomain),domainIdentityIsSemantic:false,resolveClassIdentities:resolveClassIdentities,loaders:[],npcs:[],skinInstances:[]};
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
                    var resource:ApplicationDomain = cachedDomain(loader.contentLoaderInfo);
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
                        row=domainInfo(cachedDomain(loader.contentLoaderInfo));
                        row.collection="src.NewLoad.zhuangBeiSkin";row.skinIndex=skinIndex;row.fileIndex=fileIndex;
                        row.url=scalar(read(holder,"url"));row.rootClass=loader.content ? getQualifiedClassName(loader.content) : null;
                        row.rootChildren=loader.content is DisplayObjectContainer ? DisplayObjectContainer(loader.content).numChildren : null;
                        result.loaders.push(row);count++;
                    }
                }
                result.equipmentLoadersLimit=6;
            }
            // Observe existing stage instances only: never open NPC/VIP windows or reach private loadData.
            // Prioritize the existing world over unrelated menus/visual effects.
            // No reads of private fields, construction, child insertion or loader calls.
            var currentWorld:DisplayObject=read(main,"world") as DisplayObject;
            var queue:Array = []; var seen:Dictionary=new Dictionary(true); var visited:int = 0;
            if(currentWorld) {
                queue.push(currentWorld);
                for each(var field:String in ["MapData","MapData1","MapData2","moveChild"]) {
                    var branch:DisplayObject=read(currentWorld,field) as DisplayObject;
                    if(branch) queue.push(branch);
                }
                var worldContainer:DisplayObjectContainer=currentWorld as DisplayObjectContainer;
                if(worldContainer) for(var wi:int=0;wi<Math.min(worldContainer.numChildren,100);wi++) queue.push(worldContainer.getChildAt(wi));
            }
            queue.push(stage);
            result.scanPriority="existing-world-public-map-branches-then-stage";
            result.childLimitTruncated=false;
            while(queue.length>0 && visited<800) {
                var object:DisplayObject = queue.shift() as DisplayObject;
                if(!object || seen[object]) continue;
                seen[object]=true;visited++;
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
                        matchedResourceDomains:resolveClassIdentities ? matches : null,loaderInfoIdentity:identity(object.loaderInfo),cachedLoaderDomainHandle:identity(cachedDomain(object.loaderInfo))});
                }
                if(className=="Skin" && result.skinInstances.length<6) {
                    var skinDomain:ApplicationDomain=cachedDomain(object.loaderInfo);
                    result.skinInstances.push({instance:identity(object),cachedDomainHandle:identity(skinDomain),
                        classIdentity:identity(Object(object).constructor),url:object.loaderInfo.url});
                }
                var container:DisplayObjectContainer=object as DisplayObjectContainer;
                if(container && object!==indicator) {
                    if(container.numChildren>100) result.childLimitTruncated=true;
                    for(i=0;i<Math.min(container.numChildren,100);i++) queue.push(container.getChildAt(i));
                }
            }
            result.stageScanTruncated=queue.length>0;
            result.npcObservationComplete=false; // bounded scan never proves NPC absence or full domain correctness
            result.stageNodesScanned=visited;
            if(resolveClassIdentities && domain.hasDefinition("src.HitXX")) observedHitClass=domain.getDefinition("src.HitXX");
            array=read(observedHitClass,"AllHitXX") as Array;
            result.hitObjects=array ? array.length : null;
            result.hitClassPreviouslyObserved=observedHitClass!=null;
            return result;
        }
        // Only observed display objects of the already-open supplies shop are inspected.
        // No game class resolution, static fields, factories, text setters, or focus changes.
        private function textVisibility(object:DisplayObject):Object {
            var ancestors:Array=[]; var visible:Boolean=true; var alpha:Number=1;
            var current:DisplayObject=object; var reachedStage:Boolean=false;
            while(current && ancestors.length<24) {
                ancestors.unshift({name:current.name == null ? null : current.name.substr(0,80), className:getQualifiedClassName(current),
                    visible:current.visible,alpha:current.alpha});
                visible=visible && current.visible; alpha*=current.alpha;
                if(current===stage) { reachedStage=true; break; }
                current=current.parent;
            }
            return {ancestors:ancestors,ancestorVisible:visible,ancestorAlpha:alpha,
                attachedToStage:reachedStage,pathTruncated:current!=null && !reachedStage,
                visibilityComplete:reachedStage,
                visibilityMeaning:"Display-list visible/alpha only; no occlusion, mask or viewport guarantee"};
        }
        private function shopText():Object {
            var result:Object={scope:"existing stage-child SuppliesShopPanel and its SuppliesShopShow view only",panels:0,views:0,stageChildren:[],stageMetadataTruncated:false,targetLookupAttempts:0,
                visiblePanels:0,fields:[],stageChildrenScanned:0,nodesScanned:0,
                stageScanTruncated:false,scanTruncated:false,childLimitTruncated:false,
                fieldsTruncated:false,textTruncated:false,ancestorPathTruncated:false,passwordFieldsSkipped:0,
                limits:{stageChildren:160,panelNodes:300,childrenPerContainer:100,fields:16,
                    charsPerField:128,totalChars:1536,ancestorDepth:24}};
            if(!stage) return result;
            var queue:Array=[]; var fieldQueue:Array=[]; var seenFields:Dictionary=new Dictionary(true); var i:int; var j:int;
            result.stageScanTruncated=stage.numChildren>160;
            for(i=0;i<Math.min(stage.numChildren,160);i++) {
                var panel:DisplayObject=stage.getChildAt(i); result.stageChildrenScanned++;
                var panelClass:String=getQualifiedClassName(panel).replace("::",".");
                if(result.stageChildren.length<24) result.stageChildren.push({name:panel.name,className:panelClass,visible:panel.visible});
                else result.stageMetadataTruncated=true;
                if(panelClass!="com.hotpoint.braveManIII.views.suppliesShopPanel.SuppliesShopPanel" && panelClass!="SuppliesShopShow") continue;
                result.panels++;
                var visibility:Object=textVisibility(panel);
                if(visibility.pathTruncated) result.ancestorPathTruncated=true;
                if(!visibility.visibilityComplete || !visibility.ancestorVisible || visibility.ancestorAlpha<=0) continue;
                result.visiblePanels++; queue.push(panel);
                var views:Array=[];
                if(panelClass=="SuppliesShopShow") views.push(panel);
                else {
                    var panelContainer:DisplayObjectContainer=panel as DisplayObjectContainer;
                    if(panelContainer) {
                        if(panelContainer.numChildren>100) result.childLimitTruncated=true;
                        for(j=0;j<Math.min(panelContainer.numChildren,100);j++) {
                            var candidate:DisplayObject=panelContainer.getChildAt(j);
                            if(getQualifiedClassName(candidate)=="SuppliesShopShow") views.push(candidate);
                        }
                    }
                }
                for each(var view:DisplayObjectContainer in views) {
                    result.views++; result.targetLookupAttempts++;
                    // Native display lookup on an existing known view; no static game properties.
                    var menu:DisplayObjectContainer=view.getChildByName("buyMenu") as DisplayObjectContainer;
                    var amount:TextField=menu ? menu.getChildByName("amount") as TextField : null;
                    if(amount && !seenFields[amount]) { seenFields[amount]=true; fieldQueue.unshift(amount); }
                }
            }
            // Collect under the bounded panel scope first; prioritize amount before decorative text.
            while(queue.length && result.nodesScanned<300) {
                var node:DisplayObject=queue.shift() as DisplayObject; result.nodesScanned++;
                var tf:TextField=node as TextField;
                if(tf && !seenFields[tf]) { seenFields[tf]=true; if(tf.name=="amount") fieldQueue.unshift(tf); else fieldQueue.push(tf); }
                var container:DisplayObjectContainer=node as DisplayObjectContainer;
                if(container) {
                    if(container.numChildren>100) result.childLimitTruncated=true;
                    for(j=0;j<Math.min(container.numChildren,100);j++) queue.push(container.getChildAt(j));
                }
            }
            result.scanTruncated=queue.length>0;
            var total:int=0;
            for each(tf in fieldQueue) {
                visibility=textVisibility(tf);
                if(visibility.pathTruncated) result.ancestorPathTruncated=true;
                if(!visibility.visibilityComplete || !visibility.ancestorVisible || visibility.ancestorAlpha<=0) continue;
                if(tf.displayAsPassword) { result.passwordFieldsSkipped++; continue; }
                if(result.fields.length>=16 || total>=1536) { result.fieldsTruncated=true; continue; }
                var value:String=tf.text; var budget:int=Math.min(128,1536-total);
                var text:String=value.substr(0,budget); total+=text.length;
                var truncated:Boolean=text.length<value.length;
                if(truncated) result.textTruncated=true;
                result.fields.push({name:tf.name,role:tf.name=="amount" ? "shop-amount-candidate" : "shop-text",
                    targetAmount:tf.name=="amount" && tf.parent!=null && tf.parent.name=="buyMenu",
                    text:text,originalLength:value.length,textTruncated:truncated,
                    fieldType:tf.type,visibility:visibility});
            }
            result.charsCaptured=total;
            result.observationComplete=!(result.stageScanTruncated || result.scanTruncated ||
                result.childLimitTruncated || result.fieldsTruncated || result.textTruncated || result.ancestorPathTruncated);
            return result;
        }
        private function observerFailure(sample:Object, group:String, error:Error):void {
            sample.partial=true;
            sample.groupStatus[group]="error";
            var stack:String=error.getStackTrace();
            var detail:Object={sequence:sample.sequence,ms:getTimer(),group:group,errorID:error.errorID,
                text:(error.name+": "+error.message).substr(0,220),stack:stack ? stack.substr(0,500) : null};
            sample.groupErrors.push(detail);
            report.observerErrors.push(detail);
            while(report.observerErrors.length>8) report.observerErrors.shift();
            // Game UNCAUGHT_ERROR stays in report.errors, never evicted by observer failures.
        }
        private function observe(sample:Object, group:String, action:Function):void {
            try { sample[group]=action(); sample.groupStatus[group]=sample[group]==null ? "unavailable" : "ok"; }
            catch(error:Error) { sample[group]=null; observerFailure(sample,group,error); }
        }
        private function capture(reason:String):void {
            var now:int = getTimer();
            var sample:Object = {sequence:sequence++, ms:now, reason:reason,label:label,resolveClassIdentities:resolveClassIdentities,
                partial:false,groupStatus:{},groupErrors:[],frame:frames, observedFPS:now > previousTime ?
                    Math.round((frames-previousFrames)*10000/(now-previousTime))/10 : null};
            previousFrames = frames; previousTime = now;
            // Each group is isolated. A failing optional observer cannot discard the text snapshot.
            observe(sample,"uiText",shopText);
            observe(sample,"scene",function():Object {
                if(!main) return null;
                return {map:number(read(main,"gameNum")),room:number(read(main,"gameNum2")),
                    village:scalar(read(main,"Map0_YN")),loadedSave:scalar(read(main,"loadSaveOver"))};
            });
            if(sample.scene) {
                sample.map=sample.scene.map;sample.room=sample.scene.room;
                sample.village=sample.scene.village;sample.loadedSave=sample.scene.loadedSave;
            }
            observe(sample,"player1",function():Object {return player(read(main,"player_1"));});
            observe(sample,"player2",function():Object {return player(read(main,"player_2"));});
            observe(sample,"world",function():Object {return world(read(main,"world"));});
            var ready:Boolean=read(main,"loadSaveOver")===true && read(main,"world")!=null;
            observe(sample,"tasks",function():Object {return ready ? tasks() : null;});
            observe(sample,"inventory1",function():Object {return ready ? inventory(read(main,"player1")) : null;});
            observe(sample,"inventory2",function():Object {return ready && read(main,"P1P2")===true ? inventory(read(main,"player2")) : null;});
            observe(sample,"resources",function():Object {return ready ? resources() : null;});
            observe(sample,"availableDefinitions",function():Array {
                var definitions:Array=[];
                if(!domain) return definitions;
                for each(var name:String in ["src.Main","src.Player","src.Map","src.Skin","src.Enemy","src.GameData","src.Data","src.InData"])
                    if(domain.hasDefinition(name)) definitions.push(name);
                return definitions;
            });
            report.samples.push(sample);
            while(report.samples.length>24) report.samples.shift();
            persist();
            indicator.text="DIAGNOSTIC v5 | #"+sample.sequence+" | "+label+" | "+(sample.partial ? "PARTIAL | " : "")+persistence;
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
