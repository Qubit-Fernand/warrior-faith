package {
    import flash.display.*;
    import flash.events.*;
    import flash.geom.ColorTransform;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    [SWF(width="940",height="580",frameRate="27",backgroundColor="#111727")]
    public class Epilogue extends Sprite {
        private var game:Loader = new Loader();
        private var domain:ApplicationDomain;
        private var M:*, G:*, P:*, E:*;
        private var story:Object = JSON.parse(StoryData.JSON_TEXT);
        private var store:SharedObject;
        private var overlay:Sprite = new Sprite();
        private var modal:Sprite;
        private var hud:TextField;
        private var menuButton:Sprite;
        private var clock:Timer = new Timer(150);
        private var battle:int = -1;
        private var battleSlot:int = -1;
        private var loading:Boolean = false;
        private var loadStarted:int = 0;
        private var boss:Object;
        private var battleWorld:Object;
        private var previousBoss:Object;
        private var previousWorld:Object;
        private var seals:Array = [];
        private var sealLayer:Sprite;
        private var rage:Boolean = false;
        private var cooldown:int = 0;
        private var dialogPages:Array;
        private var dialogIndex:int = 0;
        private var dialogDone:Function;
        private var lastStatus:String = "";
        private var notice:String = "";
        private var nowSlot:int = -1;
        private var baselineFrameRate:Number = 27;

        public function Epilogue() {
            if(stage) boot(); else addEventListener(Event.ADDED_TO_STAGE,boot);
        }
        private function boot(e:Event=null):void {
            removeEventListener(Event.ADDED_TO_STAGE,boot);
            stage.scaleMode=StageScaleMode.NO_SCALE;stage.align=StageAlign.TOP_LEFT;
            addChild(game);stage.addChild(overlay);
            hud=text("正在装载终章……",16,0xF3D58A,500,54);hud.x=330;hud.y=12;overlay.addChild(hud);
            game.contentLoaderInfo.addEventListener(Event.COMPLETE,ready);
            game.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(e:IOErrorEvent):void {hud.text="加载失败，请通过“启动终章.command”启动。\n"+e.text;});
            game.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(e:SecurityErrorEvent):void {hud.text="本地资源未获读取权限："+e.text;});
            game.load(new URLRequest("终章核心.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
        }
        private function ready(e:Event):void {
            domain=game.contentLoaderInfo.applicationDomain;
            M=domain.getDefinition("src.Main") as Class;G=domain.getDefinition("src.GameData") as Class;
            P=domain.getDefinition("src.Player") as Class;E=domain.getDefinition("src.Enemy") as Class;
            store=SharedObject.getLocal("yzlr2_epilogue");
            if(!store.data.slots)store.data.slots={};
            menuButton=button("终章 · 归来的曙光",735,12,192,openJournal);overlay.addChild(menuButton);
            stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown,true,10000);
            stage.addEventListener(KeyboardEvent.KEY_UP,keyUp,true,10000);
            stage.addEventListener(Event.ENTER_FRAME,tick,false,10000);
            clock.addEventListener(TimerEvent.TIMER,tick);clock.start();
            game.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,onError);
            status("同人终章 · 先读取角色，再点击右上角进入");
        }
        private function state():Object {
            var key:String=String(M.saveNum);
            if(!store.data.slots[key])store.data.slots[key]={completed:0,ending:"",attempts:0};
            return store.data.slots[key];
        }
        private function persist():void {
            try {store.flush();} catch(e:Error){notice="终章进度暂未写入磁盘，请检查 Flash 本地存储。";}
        }
        private function status(s:String):void {if(s!=lastStatus){hud.text=s;lastStatus=s;}}
        private function tick(e:Event):void {
            if(!M)return;
            if(overlay.parent!=stage)stage.addChild(overlay);
            stage.setChildIndex(overlay,stage.numChildren-1);
            if(modal)return;
            if(!M.player1){status("同人终章 · 先读取角色，再点击右上角进入");return;}
            if(battle<0){status(notice || ("同人终章 · 已完成 "+state().completed+" / 3 场战斗"));return;}
            if(int(M.saveNum)!=battleSlot){abandon();return;}
            var chapter:Object=story.chapters[battle];
            if(loading) {
                if(getTimer()-loadStarted>25000){loading=false;battle=-1;showPanel("场景加载未完成","请退出播放器后重新打开终章。已完成的章节仍保留。",[{label:"知道了",action:closePanel}]);return;}
                if(M.world && M.world!=previousWorld && int(M.gameNum.getValue())==int(chapter.map)) {
                    battleWorld=M.world;loading=false;
                    G["刷怪总数"].setValue(0);G["怪物id"]=[];
                    P["一起信春哥"]();
                    G.BossIS=null;G.BOSSid.setValue(chapter.bossId);
                    if(E.All.length>0) {
                        for each(var existing:Object in E.All)if(existing.id==chapter.bossId){G.BossIS=existing;break;}
                    }
                    if(!G.BossIS)G.BOSS.setValue(4399);
                } else return;
            }
            if(M.world!=battleWorld || int(M.gameNum.getValue())!=int(chapter.map)){abandon();return;}
            if(M.player_1 && M.player_1.hp.getValue()<=0){
                var failed:int=battle;battle=-1;
                showPanel("这一次，先喘口气","终章进度已经保留。可以重试本战，或回到城镇。",[{label:"重新挑战",action:function():void{closePanel();startBattle(failed);}},{label:"返回城镇",action:returnTown}]);return;
            }
            if(!boss && G.BossIS && G.BossIS!=previousBoss && G.BossIS.id==chapter.bossId)configureBoss(G.BossIS,chapter);
            if(!boss)return;
            if(boss.life.getValue()<=0){completeBattle();return;}
            if(battle==2){
                drawSeals();
                if(remainingSeals()==0 && !rage && boss.life.getValue()<boss.lifeMAX.getValue()*0.5){rage=true;boss["攻击力"].setValue(chapter.attackMultiplier*1.35);boss.transform.colorTransform=new ColorTransform(1.2,0.55,0.65,1,35,0,0);}
            }
            var objective:String=chapter.objective;
            if(battle==2)objective=remainingSeals()>0?"靠近金色光环，按 E 破除黑印（剩余 "+remainingSeals()+"）":"黑印已破 · "+(rage?"暗黑王进入最后反扑":"击败暗黑王");
            status(chapter.title+"  |  "+chapter.enemy+"\n"+objective);
        }
        private function configureBoss(enemy:Object,chapter:Object):void {
            boss=enemy;boss.lifeMAX.setValue(chapter.hp);boss.life.setValue(chapter.hp);
            boss["攻击力"].setValue(chapter.attackMultiplier);boss["魔攻力"].setValue(0);
            boss["防御力"].setValue(120);boss["魔防力"].setValue(0);
            // Use the original AI/animation, with a distinct palette for the fan chapter.
            boss.transform.colorTransform=new ColorTransform(0.72,0.78,1.1,1,5,0,25);
            if(battle==2) {
                boss["防御力"].setValue(10000000);boss["魔防力"].setValue(10000000);
                boss.noMove=true;boss.skin.GoTo("站立");boss.skin.continuousTime=100000;
                var width:Number=M.world._width;
                seals=[{x:Math.max(400,width*0.28),done:false},{x:width*0.52,done:false},{x:width*0.76,done:false}];
                sealLayer=new Sprite();sealLayer.mouseEnabled=false;sealLayer.mouseChildren=false;
                M.world.moveChild_Other.addChild(sealLayer);
            }
        }
        private function remainingSeals():int {var n:int=0;for each(var s:Object in seals)if(!s.done)n++;return n;}
        private function drawSeals():void {
            if(!sealLayer)return;
            sealLayer.graphics.clear();
            for each(var s:Object in seals){
                sealLayer.graphics.lineStyle(3,s.done?0x6CE7C4:0xFFD06B,s.done?0.35:1);
                sealLayer.graphics.beginFill(s.done?0x6CE7C4:0xFFD06B,0.12);
                sealLayer.graphics.drawEllipse(s.x-48,468,96,20);sealLayer.graphics.endFill();
                if(!s.done){sealLayer.graphics.moveTo(s.x,468);sealLayer.graphics.lineTo(s.x,395);sealLayer.graphics.drawCircle(s.x,411,13);}
            }
        }
        private function keyDown(e:KeyboardEvent):void {
            if(M.player_1){store.data.keyDebug={code:e.keyCode,modal:!!modal,x:M.player_1.x,y:M.player_1.y,noMove:M.player_1.noMove,skin:M.player_1.skin.runType,frame:stage.frameRate,keys:M.player1._keyArr};persist();}
            if(modal){e.stopImmediatePropagation();e.preventDefault();return;}
            if(e.keyCode==69 && battle==2 && boss && remainingSeals()>0 && getTimer()>cooldown){
                cooldown=getTimer()+400;
                for each(var s:Object in seals)if(!s.done && Math.abs(M.player_1.x-s.x)<150){
                    s.done=true;M.player_1.hp.setValue(Math.min(M.player_1.hp_Max.getValue(),M.player_1.hp.getValue()+M.player_1.hp_Max.getValue()*0.2));
                    if(remainingSeals()==0){boss.noMove=false;boss.skin.continuousTime=0;boss["防御力"].setValue(120);boss["魔防力"].setValue(0);boss.transform.colorTransform=new ColorTransform(1,0.8,0.9);}
                    break;
                }
            }
        }
        private function keyUp(e:KeyboardEvent):void {if(modal){e.stopImmediatePropagation();e.preventDefault();}}
        private function startBattle(index:int):void {
            finishEffects(M.world);
            closePanel();notice="";battle=index;battleSlot=M.saveNum;boss=null;rage=false;seals=[];sealLayer=null;
            previousWorld=M.world;previousBoss=G.BossIS;loading=true;loadStarted=getTimer();
            state().attempts++;persist();
            M.allClosePanel();stage.frameRate=27;
            var chapter:Object=story.chapters[index];
            M.gameNum.setValue(chapter.map);M.gameNum2.setValue(chapter.room);G.gameLV=1;G.winYN=false;
            var maps:*=domain.getDefinition("src.Map");
            var loads:*=domain.getDefinition("src.Load");
            var cl:Class=domain.getDefinition("src.ClassLoader") as Class;
            if(!maps.MapArr[chapter.map]) {
                var asset:*=new cl(loads.mapArr[chapter.map],new LoaderContext(false,domain));
                maps.MapArr[chapter.map]=asset;
                asset.addEventListener(Event.COMPLETE,function(e:Event):void{
                    var am:*=asset.getClass("src.Main");
                    store.data.mapDebug={sameMain:am===M,stage:String(am._stage),mainStage:String(M._stage),mapClass:String(asset.getClass("src.Map")),sameMap:asset.getClass("src.Map")===maps};persist();
                    M._this.Loading();
                });
                status(chapter.title+" · 正在前往战场……");return;
            }
            M._this.Loading();status(chapter.title+" · 正在前往战场……");
        }
        private function completeBattle():void {
            finishEffects(M.world);
            var finished:int=battle;battle=-1;boss=null;
            state().completed=Math.max(int(state().completed),finished+1);persist();
            M.Save(false);
            dialog(story.chapters[finished].after,function():void {
                if(finished==2)chooseEnding();
                else showPanel("章节完成", "已记录进度。下一章："+story.chapters[finished+1].title,[
                    {label:"继续旅程",action:function():void{dialog(story.chapters[finished+1].before,function():void{startBattle(finished+1);});}},
                    {label:"回城休整",action:returnTown}]);
            });
        }
        private function abandon():void {battle=-1;boss=null;seals=[];sealLayer=null;loading=false;notice="已离开终章战斗 · 可从右上角重试当前章节";}
        private function returnTown():void {
            finishEffects(M.world);
            closePanel();abandon();notice="";M.gameNum.setValue(0);M.gameNum2.setValue(0);stage.frameRate=27;M._this.Loading();
        }
        private function openJournal():void {
            if(modal)return;
            if(!M.player1){showPanel(story.title,"先关闭更新说明，读取一个角色，再点击右上角的终章按钮。\n\n这是承接原版第 70 条主线的同人续写，建议使用第 1 槽位的 85 级体验角色。",[{label:"返回读档",action:closePanel}]);return;}
            if(loading)return;
            if(battle>=0){
                showPanel(story.chapters[battle].title,story.chapters[battle].objective+"\n\n战斗结束后自动记录章节进度；中途退出后从本战起点重试。",[{label:"继续战斗",action:closePanel},{label:"退出本战",action:returnTown}]);return;
            }
            var st:Object=state();var done:int=int(st.completed);var info:String="承接原版【主线70·再战奥加】的同人终章。\n三场战斗，两个结局。原角色战斗与新剧情在同一游戏中进行。\n\n";
            for(var i:int=0;i<3;i++)info+=(i<done?"✓ ":"○ ")+story.chapters[i].title+"\n";
            if(st.ending)info+="\n已达成："+story.endings[st.ending].title;
            var actions:Array=[];
            if(done<3)actions.push({label:done==0?"开始终章":"继续第 "+(done+1)+" 战",action:function():void {var pages:Array=done==0?story.intro.concat(story.chapters[0].before):story.chapters[done].before;dialog(pages,function():void{startBattle(done);});}});
            else actions.push({label:"回看结局",action:chooseEnding});
            if(done>0)actions.push({label:"重玩终章",action:function():void{dialog(story.intro.concat(story.chapters[0].before),function():void{startBattle(0);});}});
            actions.push({label:"返回游戏",action:closePanel});
            showPanel(story.subtitle+" · "+story.title,info,actions);
        }
        private function chooseEnding():void {
            showPanel("女神之灵的选择","黑印已经破碎，暗黑王的王座正在崩塌。\n\n格蕾丽丝望向你。她终于可以自己决定，如何使用这份力量。",[
                {label:"留下守护之光",action:function():void{ending("guardian");}},
                {label:"让神力归于大地",action:function():void{ending("dawn");}}]);
        }
        private function ending(key:String):void {
            dialog(story.endings[key].pages,function():void{
                state().ending=key;state().completed=3;persist();
                M.Map0_YN=false;M.water.setValue(1);M.Save(false);
                showPanel(story.endings[key].title,"终章完\n\n村庄的晨光已经归来。你可以继续冒险，也可以在终章日志中重读另一种结局。\n\n感谢你，把这一段旅程走到了最后。",[{label:"回到艾格林",action:returnTown}]);
            });
        }
        private function dialog(pages:Array,done:Function):void {
            dialogPages=pages;dialogIndex=0;dialogDone=done;dialogPage();
        }
        private function dialogPage():void {
            var p:Array=dialogPages[dialogIndex];
            showPanel(String(p[0]),String(p[1]),[{label:dialogIndex==dialogPages.length-1?"继续":"下一页  "+(dialogIndex+1)+" / "+dialogPages.length,action:function():void {
                dialogIndex++;if(dialogIndex<dialogPages.length)dialogPage();else{closePanel();dialogDone();}
            }}]);
        }
        private function text(s:String,size:int,color:uint,width:Number,height:Number):TextField {
            var t:TextField=new TextField();t.defaultTextFormat=new TextFormat("PingFang SC",size,color,false,null,null,null,null,null,null,null,7);
            t.text=s;t.width=width;t.height=height;t.multiline=true;t.wordWrap=true;t.selectable=false;t.mouseEnabled=false;return t;
        }
        private function button(label:String,x:Number,y:Number,w:Number,callback:Function):Sprite {
            var b:Sprite=new Sprite();b.x=x;b.y=y;b.buttonMode=true;b.mouseChildren=false;
            b.graphics.lineStyle(1,0xC69B53);b.graphics.beginFill(0x23384B,0.98);b.graphics.drawRoundRect(0,0,w,36,10);b.graphics.endFill();
            var t:TextField=text(label,15,0xF7DFAB,w-8,29);t.x=4;t.y=4;var f:TextFormat=t.defaultTextFormat;f.align="center";t.setTextFormat(f);b.addChild(t);
            b.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void{e.stopImmediatePropagation();callback();});return b;
        }
        private function showPanel(title:String,body:String,actions:Array):void {
            if(!modal){baselineFrameRate=stage.frameRate;modal=new Sprite();overlay.addChild(modal);}else while(modal.numChildren)modal.removeChildAt(0);
            modal.graphics.clear();modal.graphics.beginFill(0x060E1C,0.78);modal.graphics.drawRect(0,0,940,580);modal.graphics.endFill();
            modal.graphics.lineStyle(2,0xB89654);modal.graphics.beginFill(0x142333,0.99);modal.graphics.drawRoundRect(115,104,710,400,18);modal.graphics.endFill();
            var heading:TextField=text(title,25,0xF3D58A,630,50);heading.x=155;heading.y=132;modal.addChild(heading);
            var content:TextField=text(body,18,0xE4EAF1,630,250);content.x=155;content.y=192;modal.addChild(content);
            var total:Number=actions.length*190+(actions.length-1)*12;var start:Number=(940-total)/2;
            for(var i:int=0;i<actions.length;i++)modal.addChild(button(actions[i].label,start+i*202,452,190,actions[i].action));
            stage.frameRate=0;stage.focus=modal;stage.setChildIndex(overlay,stage.numChildren-1);
        }
        private function closePanel():void {
            if(modal && modal.parent)modal.parent.removeChild(modal);modal=null;stage.frameRate=baselineFrameRate>0?baselineFrameRate:27;
            if(M && M.world)stage.focus=M.world;
        }
        private function onError(e:UncaughtErrorEvent):void {
            notice="游戏出现运行错误，请重新进入；终章已完成进度保留。";
            if(store){store.data.lastError=String(e.error)+(e.error is Error?"\n"+Error(e.error).getStackTrace():"");persist();}
            if(store){store.data.errorState={world:String(M.world),worldParent:M.world?String(M.world.parent):"none",boss:String(G.BossIS),map:M.gameNum.getValue(),room:M.gameNum2.getValue(),load:domain.getDefinition("src.Load").All_Loaded};persist();}
            // Do not suppress original errors or turn a failed battle into completion.
        }
        private function finishEffects(container:DisplayObjectContainer):void {
            if(!container)return;
            for(var i:int=container.numChildren-1;i>=0;i--){
                var child:DisplayObject=container.getChildAt(i);
                // This original effect lacks REMOVED_FROM_STAGE cleanup and dereferences
                // parent.parent.parent. Its terminal frame unregisters its frame handler.
                if(getQualifiedClassName(child)=="src.other::Boss108_BaoZha" && child is MovieClip)MovieClip(child).gotoAndStop(40);
                if(child is DisplayObjectContainer)finishEffects(child as DisplayObjectContainer);
            }
        }
    }
}
