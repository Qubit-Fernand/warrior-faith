package src.epilogue
{
    import com.BasicKey;
    import com.hotpoint.braveManIII.models.task.Task;
    import com.hotpoint.braveManIII.views.taskPanel.TaskData;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getTimer;
    import src.Door;
    import src.GameData;
    import src.HitXX;
    import src.Main;
    import src.Player;
    import src.epilogue.battle.ChapterEncounter;
    import src.epilogue.battle.ChapterDockEncounter;
    import src.epilogue.scene.ChapterScenery;
    import src.epilogue.scene.ChapterBackdrop;
    import src.epilogue.scene.ChapterNavigation;
    import src.epilogue.ui.EpilogueView;
    import src.epilogue.ui.WorldTimelinePause;

    /** Source-level chapter integration. No loading/injecting an external game SWF. */
    public class ChapterController
    {
        public static var current:ChapterController;
        public static var paused:Boolean=false;
        public static var inArena:Boolean=false;
        private static var requestedScene:String="";
        private static const ARENA_MAP:int=81;
        private static const WIDTH:Number=1600;
        private static const FLOOR:Number=450;
        private var view:EpilogueView;
        private var scenery:ChapterScenery;
        private var backdrop:ChapterBackdrop;
        private var navigation:ChapterNavigation;
        private var encounter:ChapterEncounter;
        private var dock:ChapterDockEncounter;
        private var pendingDockChange:Boolean=false;
        private var mentorSearchTime:Number=0;
        private var marker:Sprite;
        private var mentor:DisplayObject;
        private var prompt:TextField;
        private var nearest:Object;
        private var lastTick:int;
        private var dead:Boolean=false;
        private var disposed:Boolean=false;
        private var resumeNextFrame:Boolean=false;
        private var scene:String="";
        private var pendingAction:Function;
        private var actionTime:Number=0;
        private var interactionHeld:Boolean=false;
        private var pendingVictory:Boolean=false;
        private var transitioning:Boolean=false;
        private var timelinePause:WorldTimelinePause=new WorldTimelinePause();

        public static function get available():Boolean{return current!=null;}
        public static function get loadingChapter():Boolean{return requestedScene!="";}
        public static function onGameStart():void
        {
            var loaded:Boolean=ChapterState.resumePending;
            ChapterState.resumePending=false;
            inArena=requestedScene!="" && Main.gameNum.getValue()==ARENA_MAP;
            var target:String=requestedScene;requestedScene="";
            if(!inArena && !loaded)ChapterState.value.inChapter=false;
            if(Main.gameNum.getValue()!=0 && !inArena)return;
            current=new ChapterController(inArena?target:"");
            if(loaded && ChapterState.value.inChapter && !ChapterState.unsupported)
                current.resumeNextFrame=true;
        }
        public static function beforeWorldRemoved():void
        {
            if(current)current.dispose();
            current=null;paused=false;inArena=false;
        }
        public static function pauseRequest():void {if(current)current.pauseMenu();}
        public static function snapshot():Object
        {
            return {chapter:ChapterState.exported(),inArena:inArena,paused:paused,
                scene:current?current.scene:"",battle:current&&current.encounter?current.encounter.snapshot:null,
                dock:current&&current.dock?current.dock.snapshot:null,mentor:current&&current.mentor?getQualifiedClassName(current.mentor):null};
        }
        private function get state():Object{return ChapterState.value;}
        public function ChapterController(location:String)
        {
            scene=location;
            Main.allClosePanel();
            view=new EpilogueView(940,580);
            Main._stage.addChild(view);
            view.onJournalRequest=journal;
            view.onPauseRequest=pauseMenu;
            prompt=new TextField();prompt.defaultTextFormat=new TextFormat("_sans",15,0xFFF0BF,true);
            prompt.width=500;prompt.height=28;prompt.x=220;prompt.y=498;
            prompt.background=true;prompt.backgroundColor=0x18383D;
            prompt.visible=false;
            prompt.selectable=false;prompt.mouseEnabled=false;
            Main._stage.addChild(prompt);
            if(scene!="")setupArena();else setupVillage();
            lastTick=getTimer();
            Main._stage.addEventListener(Event.ENTER_FRAME,tick);
            Main._stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown,false,9000);
            Main._stage.addEventListener(KeyboardEvent.KEY_UP,keyUp,false,9000);
            Main._stage.addEventListener(Event.DEACTIVATE,deactivate);
            updateObjective();
        }
        private function setupVillage():void
        {
            mentor=findMentor(Main.world);
            marker=new Sprite();
            marker.graphics.lineStyle(2,0xF9D48A);marker.graphics.beginFill(0x246879,.93);
            marker.graphics.drawCircle(0,0,18);marker.graphics.endFill();
            var letter:TextField=new TextField();letter.defaultTextFormat=new TextFormat("_sans",21,0xFFF1C4,true);
            letter.text="!";letter.x=-5;letter.y=-15;letter.width=22;letter.height=30;letter.mouseEnabled=false;
            marker.addChild(letter);
            if(mentor)placeMarker();
            else {marker.x=320;marker.y=170;}
            marker.buttonMode=true;marker.addEventListener(MouseEvent.CLICK,mentorClick);
            Main.world.addChild(marker);
            marker.visible=mentor!=null && (unlocked() || int(state.stage)>0);
            if(state.ending!="")
            {
                scenery=new ChapterScenery("village_"+state.ending,WIDTH,523);
                Main.world.moveChild_Back.addChild(scenery);scenery.setProgress(state);
            }
        }
        private function findMentor(container:DisplayObjectContainer):DisplayObject
        {
            for(var i:int=0;i<container.numChildren;i++)
            {
                var child:DisplayObject=container.getChildAt(i);
                var type:String=getQualifiedClassName(child).replace("::", ".");
                if(type=="src.npc.技能" || type=="src.npc.技能2")return child;
                if(child is DisplayObjectContainer)
                {var found:DisplayObject=findMentor(child as DisplayObjectContainer);if(found)return found;}
            }
            return null;
        }
        private function placeMarker():void
        {
            var b:Rectangle=mentor.getBounds(Main.world);
            marker.x=b.x+b.width/2;marker.y=b.y-30;
            marker.visible=unlocked() || int(state.stage)>0;
        }
        private function unlocked():Boolean {return TaskData.isOldById(110117);}
        private function mentorClick(event:MouseEvent):void
        {
            if(marker && marker.visible){event.stopImmediatePropagation();talkMentor();}
        }
        private function talkMentor():void
        {
            if(view.modalOpen)return;
            if(ChapterState.unsupported){notice("此角色的终章保存格式较新，请用对应版本打开。");return;}
            if(!unlocked() && int(state.stage)==0){notice("完成并提交【主线70】再战奥加后，奥古斯汀会收到新的消息。");return;}
            if(Main.P1P2){notice("《归光之约》当前为单人章节。请使用单人角色存档进入；双人角色进度不会被更改。");return;}
            if(state.ending!="")
            {dialogue("post_"+state.ending,function():void{journal();});return;}
            if(int(state.stage)==0)
            {
                dialogue("intro",function():void{state.stage=1;state.scene="dock";ChapterState.record("dock");checkpoint();travel("dock");});
            }
            else
            {
                modalPause();
                view.showChoice("归光之约","已保存当前章节进度。继续旅途会从本段的安全检查点出发。",[
                    {label:"继续旅途",description:"接续已完成的交互；未胜的首领重新开始。",action:function():void{resume();travel(String(state.scene));}},
                    {label:"稍后再来",description:"留在村庄。",action:resume}]);
            }
        }
        private function setupArena():void
        {
            state.inChapter=true;state.scene=scene;
            closeDoors(Main.world);
            Main.world.stopYn=true;Main.world.stopX_1=0;Main.world.stopX_2=WIDTH;
            Main.world._width=WIDTH;Main.world.x=0;
            // Chapter art spans the complete collision arena, including both camera edges.
            // Only this instance of the chapter arena hides the original foreground decoration.
            backdrop=new ChapterBackdrop(scene);Main.world.moveChild_Back.addChild(backdrop);
            if(Main.world["map_3"] is DisplayObject)Main.world["map_3"].visible=false;
            var floor:MovieClip=new MovieClip();floor.graphics.beginFill(0x263C41,0);
            floor.graphics.drawRect(0,FLOOR,WIDTH,130);floor.graphics.endFill();
            Main.world.moveChild_Back.addChild(floor);Main.world.MapData=floor;
            Main.world.MapData1=new MovieClip();Main.world.MapData2=new MovieClip();
            Main.player_1.x=150;Main.player_1.y=FLOOR-1;Player.一起信春哥();
            // The original revival uses a large sentinel until its next update. Dialogue pauses
            // that update, so set the same real maxima before displaying the chapter intro.
            Main.player_1.hp.setValue(Main.player_1.use_hp_Max.getValue());
            Main.player_1.mp.setValue(Main.player_1.use_mp_Max.getValue());
            scenery=new ChapterScenery(scene,WIDTH,FLOOR);
            Main.world.moveChild_Back.addChild(scenery);scenery.setProgress(state);
            if(scene=="dock")
            {
                navigation=new ChapterNavigation(WIDTH,FLOOR);
                Main.world.moveChild_Back.addChild(navigation);navigation.setProgress(state);
                dock=new ChapterDockEncounter(WIDTH,FLOOR,{player:Main.player_1,
                    bridgeOpen:Boolean(state.bridgeOpen),dockRelays:int(state.dockRelays)});
                Main.world.moveChild_Enemy.addChild(dock);
                dock.addEventListener(ChapterDockEncounter.CHANGED,dockChanged);
                dialogue("dock_arrival");
            }
            else if(scene=="warden" && !state.boss1Defeated)dialogue("warden_intro",startEncounter);
            else if(scene=="regent" && !state.boss2Defeated)dialogue("regent_intro",startEncounter);
            else if(scene=="regent")
            {
                ChapterState.record("choice");
                if(state.ending!="")dialogue("ending_"+state.ending,returnVillage);
            }
            syncTasks();
        }
        private function closeDoors(parent:DisplayObjectContainer):void
        {
            for(var i:int=0;i<parent.numChildren;i++)
            {var child:DisplayObject=parent.getChildAt(i);if(child is Door)Door(child).Close();
             else if(child is DisplayObjectContainer)closeDoors(child as DisplayObjectContainer);}
        }
        private function startEncounter():void
        {
            resume();
            encounter=new ChapterEncounter(scene,WIDTH,FLOOR,{player:Main.player_1,
                beaconPrepared:Boolean(state.beaconPrepared),releasePrepared:Boolean(state.releasePrepared)});
            Main.world.moveChild_Enemy.addChild(encounter);
            encounter.addEventListener(ChapterEncounter.DEFEATED,bossDefeated);
            encounter.addEventListener(ChapterEncounter.PHASE_CHANGED,bossPhase);
        }
        private function dockChanged(event:Event):void {pendingDockChange=true;}
        private function applyDockChange():void
        {
            pendingDockChange=false;
            var newlyOpened:Boolean=!state.bridgeOpen && dock.bridgeBroken;
            state.bridgeOpen=dock.bridgeBroken;state.dockRelays=dock.relays;
            if(newlyOpened)ChapterState.record("bridge");
            scenery.setProgress(state);checkpoint();updateObjective();
            if(newlyOpened)animateChange(1.1,function():void{dialogue("bridge_open");});
        }
        private function bossPhase(event:Event):void
        {
            if(scene=="regent" && encounter.phase==2)dialogue("regent_phase2");
        }
        private function bossDefeated(event:Event):void
        {
            pendingVictory=true; // Complete outside the hit-scan event stack.
        }
        private function applyVictory():void
        {
            pendingVictory=false;view.hideBoss();
            if(scene=="warden")
            {
                state.boss1Defeated=true;state.stage=3;ChapterState.record("devices");
                scenery.setProgress(state);checkpoint();
                dialogue("warden_defeat",function():void{dialogue("devices");});
            }
            else
            {
                state.boss2Defeated=true;state.stage=5;ChapterState.record("choice");
                scenery.setProgress(state);checkpoint();dialogue("regent_defeat");
            }
            updateObjective();
        }
        private function tick(event:Event):void
        {
            if(disposed || transitioning)return;
            var now:int=getTimer();var dt:Number=Math.min(.05,Math.max(0,(now-lastTick)/1000));lastTick=now;
            if(resumeNextFrame){resumeNextFrame=false;travel(String(state.scene));return;}
            if(pendingVictory){applyVictory();return;}
            if(pendingDockChange){applyDockChange();return;}
            if(!inArena && !mentor){mentorSearchTime+=dt;if(mentorSearchTime>.5){mentorSearchTime=0;mentor=findMentor(Main.world);if(mentor)placeMarker();}}
            paused=view.modalOpen || pendingAction!=null;
            prompt.visible=false;
            if(encounter)encounter.setPaused(paused);
            if(dock)dock.setPaused(paused);
            if(scenery && !view.modalOpen)scenery.update(dt);
            if(pendingAction!=null)
            {
                if(view.modalOpen)return;
                actionTime-=dt;
                if(actionTime<=0 && !scenery.animating){var done:Function=pendingAction;pendingAction=null;resume();done();}
                return;
            }
            if(paused){prompt.text="";return;}
            if(inArena)
            {
                state.elapsedSeconds=Number(state.elapsedSeconds)+dt;
                if(Main.player_1.hp.getValue()<=0){failure();return;}
                if(encounter && !encounter.finished)
                {
                    encounter.update(dt);
                    if(disposed)return;
                    var b:Object=encounter.snapshot;
                    view.setBoss(b.name,b.hp,b.maxHp,"阶段 "+b.phase,b.hint);
                    prompt.text="";return;
                }
                if(dock)dock.update(dt);
                if(scene=="dock" && !state.bridgeOpen && Main.player_1.x>430)Main.player_1.x=430;
            }
            updateInteraction();
        }
        private function updateInteraction():void
        {
            nearest=null;
            var points:Array=scenery?scenery.interactionPoints():[];
            if(navigation)points=points.concat(navigation.interactionPoints());
            if(!inArena && marker && marker.visible)points.push({id:"mentor",label:state.ending!=""?"与故人交谈":"奥古斯汀的新消息",x:marker.x,radius:130});
            var best:Number=99999;
            for each(var point:Object in points)
            {
                var distance:Number=Math.abs(Main.player_1.x-Number(point.x));
                if(distance<Number(point.radius || 95) && distance<best){nearest=point;best=distance;}
            }
            prompt.text=nearest?"E  ·  "+nearest.label:"";
            prompt.visible=nearest!=null;
        }
        private function keyDown(event:KeyboardEvent):void
        {
            if(disposed || transitioning || view.modalOpen)return;
            if(pendingAction!=null && event.keyCode==13){event.stopImmediatePropagation();scenery.settle();actionTime=0;return;}
            if(event.keyCode==27){event.stopImmediatePropagation();pauseMenu();return;}
            if(event.keyCode==69 && !interactionHeld && !paused)
            {interactionHeld=true;event.stopImmediatePropagation();if(nearest)interact(String(nearest.id));}
        }
        private function keyUp(event:KeyboardEvent):void {if(event.keyCode==69)interactionHeld=false;}
        private function deactivate(event:Event):void
        {interactionHeld=false;clearInput();if(inArena && !view.modalOpen)pauseMenu();}
        private function interact(id:String):void
        {
            if(id=="mentor" || id=="post"){talkMentor();return;}
            if(scene=="dock")
            {
                if(id.indexOf("nav")==0 && navigation && int(state.rescuedGroups)==2 && !state.calibrationDone)
                {
                    var navIndex:int=int(id.substr(3));
                    if(navIndex!=int(state.navigationSteps))return;
                    state.navigationTurns[navIndex]=(int(state.navigationTurns[navIndex])+1)%4;
                    if(ChapterNavigation.correct(navIndex,int(state.navigationTurns[navIndex])))state.navigationSteps=navIndex+1;
                    navigation.setProgress(state);checkpoint();updateObjective();return;
                }
                if(id=="bridge" && !state.bridgeOpen)
                {notice("用攻击击碎铜色桥锁，渡桥才能落下。");}
                else if(id=="group1" && (int(state.dockRelays)&1)==0){notice("先击破居民旁的扫波继电器；金色地波可以跳过。");}
                else if(id=="group2" && (int(state.dockRelays)&2)==0){notice("先击破居民旁的光锚继电器；光柱落下前离开紫色标记。");}
                else if(id=="group1" && state.bridgeOpen && int(state.rescuedGroups)==0)
                {state.rescuedGroups=1;ChapterState.record("rescue");animateChange(2.2,function():void{checkpoint();dialogue("rescue_one");});}
                else if(id=="group2" && int(state.rescuedGroups)==1)
                {state.rescuedGroups=2;animateChange(2.2,function():void{checkpoint();dialogue("rescue_two");});}
                else if(id=="compass" && int(state.rescuedGroups)==2 && !state.calibrationDone && int(state.navigationSteps)<3)
                {notice("航标还没有对齐。沿码头找潮线、三纹船帆和回光，把三座盘校准后再确认罗盘。");}
                else if(id=="compass" && int(state.rescuedGroups)==2 && !state.calibrationDone)
                {state.calibrationDone=true;navigation.setProgress(state);state.stage=2;ChapterState.record("calibration");animateChange(1.2,function():void{checkpoint();dialogue("calibration");});}
                else if(id=="exit" && state.calibrationDone){ChapterState.record("warden");checkpoint();travel("warden");}
                else notice("先放下渡桥，带两组居民脱离封锁，再检查船上的航标。");
            }
            else if(scene=="warden" && state.boss1Defeated)
            {
                if(id=="beacon" || id=="release")prepareDevice(id);
                else if(id=="exit")
                {
                    if(!state.beaconPrepared && !state.releasePrepared){notice("至少检查并修复一种归光装置，才能沿着光流找到王座。");return;}
                    state.stage=4;ChapterState.record("regent");checkpoint();travel("regent");
                }
            }
            else if(scene=="regent" && state.boss2Defeated)
            {
                if(id=="return_warden"){travel("warden");return;}
                if(id.indexOf("ritual")==0){advanceRitual(int(id.substr(6)));return;}
                if(id=="beacon" || id=="release")chooseEnding(id);
            }
            updateObjective();
        }
        private function prepareDevice(id:String):void
        {
            var key:String=id=="beacon"?"beaconPrepared":"releasePrepared";
            if(state[key]){notice(id=="beacon"?"灯塔已修复：最终战受到的伤害降低，结局时可留下自愿回应的通道。":"解缚环已修复：最终战可获得更长反击窗口，结局时可解除全部神力束缚。");return;}
            state[key]=true;animateChange(1.2,function():void{checkpoint();notice(id=="beacon"?"归航灯塔重新亮起。它会保护进入王座的人，但最后留下与否仍由女神决定。":"解缚环开始转动。它将松开王座的束缚；最终选择前仍可修复另一装置。");});
        }
        private function chooseEnding(id:String):void
        {
            if(state.ending!="")return;
            if(state.endingChoice!="" && int(state.endingNodes)>0){notice("已开始归光仪式，请依次完成三个节点；未点亮第一节点前可重新选择装置。");return;}
            var available:Boolean=id=="beacon"?Boolean(state.beaconPrepared):Boolean(state.releasePrepared);
            if(!available){notice("这座装置尚未准备。回到司灯遗址修复它后再来；王座已败的进度会保留。");return;}
            modalPause();
            view.showChoice(id=="beacon"?"留下长明之约":"把光还给每个人",
                id=="beacon"?"女神自愿留下回应的通道，村民共同守护灯塔。此选择会写入本角色的结局。":"解除神力的所有束缚。女神像熄灭，居民自己点起窗灯。此选择会写入本角色的结局。",[
                {label:"确认这个结局",description:"完成场景仪式并保存结果。",action:function():void{resume();finishEnding(id);}},
                {label:"再想一想",description:"可以走到另一装置检查。",action:resume}]);
        }
        private function finishEnding(id:String):void
        {
            state.endingChoice=id;state.endingNodes=0;
            scenery.setProgress(state);checkpoint();updateObjective();
        }
        private function advanceRitual(number:int):void
        {
            if(!state.endingChoice || number!=int(state.endingNodes)+1)return;
            state.endingNodes=number;
            scenery.setProgress(state);updateObjective();
            if(number<3){checkpoint();return;}
            var id:String=String(state.endingChoice);
            state.ending=id;state.stage=6;
            if(state.seenEndings.indexOf(id)<0)state.seenEndings.push(id);
            ChapterState.record(id);
            // One transaction object: world state and inventory reward are saved together.
            if(!state.rewardClaims.returnLight)
            {Main.player1.addGold(50000);state.rewardClaims.returnLight={ending:id,gold:50000};}
            checkpoint();
            animateChange(2.5,function():void{dialogue("ending_"+id,returnVillage);});
        }
        private function animateChange(seconds:Number,after:Function):void
        {
            clearInput();paused=true;timelinePause.freeze(Main.world);scenery.setProgress(state);
            if(navigation)navigation.setProgress(state);
            actionTime=seconds;pendingAction=after;prompt.text="";
        }
        private function failure():void
        {
            if(dead)return;dead=true;state.deaths=int(state.deaths)+1;modalPause();
            view.showFailure("倒下不会推进剧情。已完成的救援和机关会保留；本场首领将从第一阶段重新开始。",
                function():void{resume();travel(scene);},function():void{resume();returnVillage();});
        }
        private function pauseMenu():void
        {
            if(view.modalOpen || disposed || transitioning)return;
            modalPause();view.showPause(resume,journal,returnVillage);
        }
        private function journal():void
        {
            modalPause();var entries:Array=[];
            var keys:Array=state.journal.concat();if(keys.length==0)keys.push("not_unlocked");
            for each(var key:String in keys)if(ChapterContent.DATA.journal[key])entries.push(ChapterContent.DATA.journal[key]);
            view.showJournal(entries,resume);
        }
        private function dialogue(key:String,after:Function=null):void
        {
            if(!ChapterContent.DATA.dialogues[key])throw new Error("Missing chapter dialogue: "+key);
            modalPause();
            view.showDialogue(ChapterContent.DATA.dialogues[key],function():void{
                state.seenDialogues[key]=true;resume();if(after!=null)after();
            },Boolean(state.seenDialogues[key]));
        }
        private function notice(text:String):void
        {modalPause();view.showDialogue([{speaker:"旅途记录",text:text,portrait:"hero"}],resume,true);}
        private function modalPause():void
        {paused=true;timelinePause.freeze(Main.world);clearInput();interactionHeld=false;prompt.text="";if(encounter)encounter.setPaused(true);if(dock)dock.setPaused(true);}
        private function resume():void
        {paused=pendingAction!=null || transitioning;if(!paused)timelinePause.resume();clearInput();interactionHeld=false;lastTick=getTimer();if(encounter)encounter.setPaused(paused);
            if(dock)dock.setPaused(paused);}
        private function clearInput():void
        {
            BasicKey.clearPressed();
            if(Main.player_1)Main.player_1.clearChapterInput();
            if(Main.player_2)Main.player_2.clearChapterInput();
        }
        private function checkpoint():void
        {syncTasks();Main.Save2(false);trace("CHAPTER_CHECKPOINT",state.stage,state.scene,state.ending);}
        private function syncTasks():void
        {
            for each(var task:Task in TaskData.taskArr)
            {
                var id:int=task.getId();if(id<190001 || id>190003)continue;
                var done:Boolean=id==190001?Boolean(state.calibrationDone):id==190002?Boolean(state.boss1Defeated):state.ending!="";
                var active:Boolean=id==190001?int(state.stage)>=1:id==190002?int(state.stage)>=2:int(state.stage)>=4;
                task.setState(done?3:active?1:0);task.setOldTime(done?1:0);
            }
        }
        private function updateObjective():void
        {
            var objective:String="";
            if(!inArena)objective=state.ending!=""?"故人仍在村庄等你":unlocked()?"寻找奥古斯汀身旁的信标":"完成并提交【主线70】再战奥加";
            else if(scene=="dock")objective=!state.bridgeOpen?"攻击桥锁，放下封锁渡桥":int(state.dockRelays)!=3?"击破继电器，再带居民撤离":int(state.rescuedGroups)<2?"救出居民 "+state.rescuedGroups+" / 2":!state.calibrationDone?(int(state.navigationSteps)<3?"观察线索，校准航标 "+state.navigationSteps+" / 3":"三盘已亮，前往旧罗盘确认"):"沿新方位前往司灯遗址";
            else if(scene=="warden")objective=!state.boss1Defeated?"击破供能灯座，关闭司灯":"修复归光装置，再进入王座";
            else objective=!state.boss2Defeated?"切断输光臂，击败窃光王座":state.endingChoice!=""?"完成归光仪式 "+state.endingNodes+" / 3":"走近归光装置，决定最后的归途";
            view.setObjective("归光之约",objective,inArena?"E 交互 · Esc 暂停 · 进度自动保存":"同人最终章 · 独立存档");
        }
        private function travel(destination:String):void
        {
            if(transitioning)return;
            transitioning=true;pendingAction=null;modalPause();
            state.inChapter=true;state.scene=destination;checkpoint();
            requestedScene=destination;clearInput();Main.allClosePanel();
            Main.gameNum.setValue(ARENA_MAP);Main.gameNum2.setValue(1);GameData.gameLV=1;
            Main._this.Loading();
        }
        private function returnVillage():void
        {
            if(transitioning)return;
            transitioning=true;pendingAction=null;modalPause();
            state.inChapter=false;checkpoint();requestedScene="";
            Main.gameNum.setValue(0);Main.gameNum2.setValue(0);Main._this.Loading();
        }
        private function dispose():void
        {
            if(disposed)return;disposed=true;
            Main._stage.removeEventListener(Event.ENTER_FRAME,tick);
            Main._stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
            Main._stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
            Main._stage.removeEventListener(Event.DEACTIVATE,deactivate);
            if(marker){marker.removeEventListener(MouseEvent.CLICK,mentorClick);if(marker.parent)marker.parent.removeChild(marker);}
            if(encounter){encounter.removeEventListener(ChapterEncounter.DEFEATED,bossDefeated);encounter.removeEventListener(ChapterEncounter.PHASE_CHANGED,bossPhase);encounter.dispose();}
            if(dock){dock.removeEventListener(ChapterDockEncounter.CHANGED,dockChanged);dock.dispose();}
            if(scenery)scenery.dispose();
            if(backdrop)backdrop.dispose();
            if(navigation)navigation.dispose();
            view.dispose();if(view.parent)view.parent.removeChild(view);
            if(prompt.parent)prompt.parent.removeChild(prompt);
            pendingAction=null;timelinePause.clear();clearInput();
        }
    }
}
