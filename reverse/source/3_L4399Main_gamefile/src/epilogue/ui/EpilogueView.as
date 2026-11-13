package src.epilogue.ui
{
    import src.epilogue.scene.LanternCrossing;
    import src.epilogue.scene.LightCircuit;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.getTimer;

    /** Presentation only. The controller owns gameplay pause, persistence and input reset. */
    public class EpilogueView extends Sprite
    {
        public var onJournalRequest:Function;
        public var onPauseRequest:Function;
        public var inputAvailable:Function;
        private var canvas:Sprite = new Sprite();
        private var objectives:Sprite = new Sprite();
        private var bosses:Sprite = new Sprite();
        private var chrome:Sprite = new Sprite();
        private var modal:Sprite = new Sprite();
        private var permanentButtons:Array = [];
        private var buttons:Array = [];
        private var pages:Array = [];
        private var pageIndex:int = 0;
        private var selection:int = 0;
        private var kind:String = "";
        private var complete:Function;
        private var skipped:Function;
        private var skipAllowed:Boolean = false;
        private var body:TextField;
        private var pageLabel:TextField;
        private var nameLabel:TextField;
        private var portrait:PortraitArt;
        private var fullText:String = "";
        private var revealStart:int = 0;
        private var revealed:int = 0;
        private var keyStage:Stage;
        private var disposed:Boolean = false;
        private var objectiveSignature:String = "";
        private var bossSignature:String = "";
        private var keys:Object = {};
        private var pauseOpeningKeyHeld:Boolean = false;
        private var openingEscapeEvent:KeyboardEvent;
        private var nativeUISuspended:Boolean=false;
        private var downKeys:Object={};
        private var nativeHeldKeys:Object={};

        public function EpilogueView(width:Number = 940,height:Number = 580)
        {
            super();
            mouseEnabled=false;canvas.mouseEnabled=false;
            objectives.mouseEnabled=false;objectives.mouseChildren=false;
            bosses.mouseEnabled=false;bosses.mouseChildren=false;
            chrome.mouseEnabled=false;modal.mouseEnabled=false;
            addChild(canvas);canvas.addChild(objectives);canvas.addChild(bosses);
            canvas.addChild(chrome);canvas.addChild(modal);
            var journal:ChapterButton=new ChapterButton("旅途记录",96,30,requestJournal);
            journal.x=714;journal.y=16;chrome.addChild(journal);permanentButtons.push(journal);
            var pause:ChapterButton=new ChapterButton("暂停",78,30,requestPause);
            pause.x=822;pause.y=16;chrome.addChild(pause);permanentButtons.push(pause);
            addEventListener(Event.ADDED_TO_STAGE,added);
            addEventListener(Event.REMOVED_FROM_STAGE,removed);
            setSize(width,height);
        }
        public function get modalOpen():Boolean {return kind!="";}
        public function get dialogueOpen():Boolean {return kind=="dialogue";}
        public function setNativeUISuspended(value:Boolean):void
        {
            if(nativeUISuspended==value)return;
            nativeUISuspended=value;visible=!value;
            if(value)
            {
                // Remember keys held across the handoff, but never consume native UI keys.
                for(var key:String in downKeys)nativeHeldKeys[key]=true;
                keys={};pauseOpeningKeyHeld=false;openingEscapeEvent=null;
            }
        }
        public function isNativeHeldKey(code:uint):Boolean {return Boolean(nativeHeldKeys[code]);}
        private function inputAllowed():Boolean
        {return !disposed && (inputAvailable==null || Boolean(inputAvailable())) && !nativeUISuspended;}
        public function setSize(width:Number,height:Number):void
        {
            var s:Number=Math.min(Math.max(1,width)/940,Math.max(1,height)/580);
            canvas.scaleX=canvas.scaleY=s;canvas.x=(width-940*s)/2;canvas.y=(height-580*s)/2;
        }
        public function setObjective(chapter:String,objective:String,progress:String = ""):void
        {
            var signature:String=chapter+"\n"+objective+"\n"+progress;
            if(signature==objectiveSignature)return;
            objectiveSignature=signature;clearLayer(objectives);
            if(!chapter&&!objective)return;
            var p:Sprite=new Sprite();p.x=630;p.y=112;
            p.graphics.lineStyle(1,0xBD9A5B,.75);p.graphics.beginFill(0x182B30,.9);
            p.graphics.drawRoundRect(0,0,270,91,9,9);p.graphics.endFill();
            addText(p,chapter,12,0xE9C778,12,7,246,22,true);
            addText(p,objective,14,0xF2E9D1,12,29,246,43);
            addText(p,progress,11,0xBECEC2,12,70,246,18);
            objectives.addChild(p);
        }
        public function setBoss(name:String,hp:Number,maxHp:Number,phase:String = "",hint:String = ""):void
        {
            objectives.visible=false;
            var ratio:Number=maxHp>0?Math.max(0,Math.min(1,hp/maxHp)):0;
            var signature:String=name+"|"+Math.round(ratio*480)+"|"+phase+"|"+hint;
            if(signature==bossSignature)return;
            bossSignature=signature;clearLayer(bosses);
            var p:Sprite=new Sprite();p.x=230;p.y=51;
            p.graphics.beginFill(0x16262B,.92);p.graphics.drawRoundRect(0,0,470,hint?72:52,8,8);p.graphics.endFill();
            addText(p,name,15,0xF2DEAE,12,2,280,24,true);
            addText(p,phase,12,0xC6DAD5,290,4,168,21,false,"right");
            p.graphics.lineStyle(1,0xB69A63);p.graphics.beginFill(0x1B131D);
            p.graphics.drawRoundRect(12,29,446,12,6,6);p.graphics.endFill();
            if(ratio>0){p.graphics.lineStyle();p.graphics.beginFill(0xAC4859);p.graphics.drawRoundRect(14,31,442*ratio,8,4,4);p.graphics.endFill();}
            if(hint)addText(p,hint,12,0xE9CFA0,12,46,446,21);
            bosses.addChild(p);
        }
        public function hideBoss():void {bossSignature="";clearLayer(bosses);objectives.visible=true;}

        /** Page objects: {speaker,text,portrait?}; [speaker,text] is also accepted. */
        public function showDialogue(value:Array,onComplete:Function,canSkip:Boolean = false,onSkip:Function = null):void
        {
            closeModal();if(disposed)return;
            kind="dialogue";complete=onComplete;skipAllowed=canSkip;skipped=onSkip;
            pages=paginate(value,688,79,18);pageIndex=0;
            chrome.visible=false;
            if(pages.length==0){finishDialogue(false);return;}
            // Keep the world visible while blocking its pointer targets behind the card.
            inputShield();
            var card:Sprite=parchment(900,170);card.x=20;card.y=390;modal.addChild(card);
            card.addEventListener(MouseEvent.CLICK,dialogueClick);
            portrait=new PortraitArt("hero",96);portrait.x=32;portrait.y=414;modal.addChild(portrait);
            nameLabel=addText(modal,"",17,0x30484B,164,400,530,28,true);
            body=addText(modal,"",18,0x2D3336,164,434,688,79);
            pageLabel=addText(modal,"",11,0x756348,164,532,515,22);
            if(canSkip)addButton("跳过已读",112,28,784,523,skipDialogue);
            renderDialogue();
            addEventListener(Event.ENTER_FRAME,revealFrame);
        }
        public function showChoice(title:String,text:String,choices:Array):void
        {
            closeModal();if(disposed)return;
            kind="choice";chrome.visible=false;selection=0;
            var count:int=Math.min(5,choices?choices.length:0);
            var h:Number=Math.max(244,142+count*60);
            modalBackdrop();var p:Sprite=parchment(640,h);p.x=150;p.y=(580-h)/2;modal.addChild(p);
            addText(modal,title,23,0x30484B,179,p.y+20,582,38,true);
            addText(modal,text,15,0x4F4A3E,179,p.y+64,582,58);
            for(var i:int=0;i<count;i++) {
                var item:Object=choices[i];
                addButton(String(item.label),582,52,179,p.y+124+i*60,choiceHandler(item.action),item.description?String(item.description):"");
            }
            updateSelection();
        }
        public function showCrossing(route:LanternCrossing, save:Function, leave:Function):void
        {
            var selected:int = 0;
            var feedback:String = "浮桥只容两人。同行按慢者耗油，灯也要有人带回来。";
            var draw:Function;
            function personAction(bit:int):Function
            {
                return function():void {
                    var proposed:int = selected ^ bit;
                    if (proposed && !route.cost(proposed)) {
                        feedback = "木板承不住第三人。先让一人留在岸上。";
                    } else {
                        selected = proposed;
                        feedback = selected ? "这趟要用 " + route.cost(selected) + " 格灯油。" : "选出这趟提灯的人。";
                    }
                    var oldSelection:int = selection;
                    draw();
                    selection=oldSelection;updateSelection();
                };
            }
            draw = function():void {
                closeModal();
                kind = "crossing";
                chrome.visible = false;
                modalBackdrop();
                var board:Sprite = parchment(820,438);
                board.x = 60; board.y = 69; modal.addChild(board);
                addText(board,"暗道浮桥　·　渡灯系船",23,0x30484B,28,18,530,40,true);
                addText(board,"灯油  " + route.oil + " / " + LanternCrossing.OIL,18,0x754D1F,565,24,220,35,true,"right");
                addText(board,"把四人送到对岸，系住接应船的牵索。",16,0x4F4A3E,30,63,750,34);
                addText(board,route.lampAcross ? "码头" : "码头　◆ 提灯",17,0x365A54,46,108,270,32,true);
                addText(board,route.lampAcross ? "对岸　◆ 提灯" : "对岸",17,0x365A54,523,108,265,32,true);
                var g:Graphics = board.graphics;
                g.lineStyle(4,0x64969B);
                g.moveTo(369,117); g.lineTo(369,282); g.moveTo(450,117); g.lineTo(450,282);
                g.lineStyle(4,0x896C48);
                g.moveTo(349,190); g.lineTo(469,190); g.moveTo(349,217); g.lineTo(469,217);
                for (var plank:int=354;plank<470;plank+=12) {g.moveTo(plank,189);g.lineTo(plank,218);}
                for (var i:int=0;i<4;i++) {
                    var bit:int=1<<i;
                    var far:Boolean=(route.farBank & bit)!=0;
                    var name:String=LanternCrossing.NAMES[i] + "　" + LanternCrossing.COST[i] + " 格";
                    var px:int=far ? 573 : 105;
                    if ((route.available & bit)!=0) {
                        addButton(((selected & bit)!=0 ? "✓ " : "")+name,268,31,px,209+i*34,personAction(bit));
                    } else {
                        addText(modal,name,15,0x665D51,px+12,212+i*34,250,30);
                    }
                }
                addText(board,feedback,15,0x4F4A3E,35,290,751,40);
                addButton(route.lampAcross ? "提灯返回" : "提灯出发",220,42,104,413,function():void {
                    if (!route.cross(selected)) {
                        feedback = selected ? "剩下的灯油不够。退回上一趟，换一组人试试。" : "先选一至两名同行者。";
                        draw(); return;
                    }
                    selected=0;
                    feedback=route.lampAcross ? "灯到了对岸。谁来把它送回去？" : "灯回来了。下一趟让谁同行？";
                    if (route.finished) closeModal();
                    save(route.moves);
                    if (!route.finished) draw();
                });
                addButton("退回上一趟",210,42,352,413,function():void {
                    if (route.moves.length) {
                        route.undo();
                        save(route.moves);
                    }
                    selected=0;feedback="已回到上一次出发前。";draw();
                }).setEnabled(route.moves.length>0);
                addButton("收起航图",210,42,592,413,function():void {closeModal();leave();});
                updateSelection();
            };
            draw();
        }

        public function showLightCircuit(circuit:LightCircuit, changed:Function, finish:Function, leave:Function):void
        {
            var draw:Function;
            function mirrorAction(index:int):Function
            {
                return function():void {
                    circuit.rotate(index);
                    changed(circuit.mask);
                    draw();
                    selection=index;
                    updateSelection();
                };
            }
            draw = function():void {
                closeModal();
                kind="mirrors";
                chrome.visible=false;
                modalBackdrop();
                var board:Sprite=parchment(838,464);
                board.x=51;board.y=56;modal.addChild(board);
                var mode:Boolean=circuit.beacon;
                var names:Array=mode ? ["求援","回信"] : ["内扣","外扣"];
                var colors:Array=[0xFFD369,0x7DDAD8];
                addText(board,mode?"归航灯塔 · 往返信号":"解缚环 · 双扣释压",22,0x30484B,28,15,780,38,true);
                addText(board,mode?"把港口的求援送到塔顶，再把回应引回海面。":"让两束光分别托住内扣和外扣，灯芯才能完整取出。",16,0x4F4A3E,28,55,782,36);
                var g:Graphics=board.graphics;
                g.lineStyle(1,0x827352);
                g.beginFill(0x213C46);
                g.drawRoundRect(20,101,544,279,12,12);g.endFill();
                var sx:int=99,sy:int=170,step:int=65,row:int=44;
                for (var x:int=0;x<LightCircuit.WIDTH;x++) {
                    g.lineStyle(1,0x567078,.5);g.moveTo(sx+x*step,sy);g.lineTo(sx+x*step,sy+3*row);
                }
                for (var y:int=0;y<LightCircuit.HEIGHT;y++) {
                    g.moveTo(sx,sy+y*row);g.lineTo(sx+5*step,sy+y*row);
                }
                var ready:Boolean=true;
                for (var n:int=0;n<2;n++) {
                    var beam:Array=circuit.traceBeam(n);
                    var lit:Boolean=circuit.connected(n,beam);
                    ready=ready && lit;
                    var source:Point=circuit.sources[n];
                    var target:Point=circuit.receivers[n];
                    var offset:Number=n ? 2 : -2;
                    g.lineStyle(3,uint(colors[n]),.93);
                    g.moveTo(sx+source.x*step+offset,sy+source.y*row+offset);
                    for (var j:int=1;j<beam.length;j++)
                        g.lineTo(sx+beam[j].x*step+offset,sy+beam[j].y*row+offset);
                    g.beginFill(uint(colors[n]));g.drawCircle(sx+source.x*step,sy+source.y*row,5);g.endFill();
                    g.lineStyle(2,uint(colors[n]));g.beginFill(lit?uint(colors[n]):0x213C46);
                    g.drawRect(sx+target.x*step-6,sy+target.y*row-6,12,12);g.endFill();
                    addText(board,names[n]+(lit?"  已接通":"  待接通"),14,uint(colors[n]),35+n*180,106,170,24,true);
                }
                for (var i:int=0;i<circuit.mirrors.length;i++) {
                    var pt:Point=circuit.mirrors[i];
                    var mx:int=sx+pt.x*step,my:int=sy+pt.y*row;
                    var slant:int=(circuit.mask & (1<<i))!=0 ? 1 : -1;
                    g.lineStyle(1,0xB78A4B);g.beginFill(0x345665);g.drawCircle(mx,my,12);g.endFill();
                    g.lineStyle(3,0xFAEACC);g.moveTo(mx-8,my-8*slant);g.lineTo(mx+8,my+8*slant);
                    addText(board,String(i+1),12,0xFFF1BF,mx+12,my-23,24,22,true);
                    addButton("转动 "+(i+1)+" 号镜",211,37,650,161+i*46,mirrorAction(i));
                }
                addText(board,"● 光源　 □ 接收口　　 数字 1—5 转镜",14,0xE5DABA,36,350,475,26);
                addButton(mode?"点亮灯塔":"松开双扣",243,43,87,454,function():void {
                    if (!ready) return;
                    closeModal();
                    finish();
                }).setEnabled(ready);
                addButton("收起镜盘",184,43,667,454,function():void {closeModal();leave();});
                updateSelection();
            };
            draw();
        }

        public function showJournal(entries:Array,onClose:Function):void
        {
            closeModal();if(disposed)return;
            kind="journal";complete=onClose;chrome.visible=false;
            pages=paginate(entries,624,268,17);pageIndex=0;
            if(pages.length==0)pages=[{speaker:"尚未写下的旅途",text:"新的足迹，会留在这里。",portrait:"hero"}];
            modalBackdrop();var p:Sprite=parchment(714,438);p.x=113;p.y=70;modal.addChild(p);
            addText(modal,"旅途记录",24,0x30484B,143,89,600,38,true);
            nameLabel=addText(modal,"",16,0x6C5638,143,132,624,30,true);
            body=addText(modal,"",17,0x343B3D,143,171,624,268);
            pageLabel=addText(modal,"",12,0x756348,258,464,350,24,false,"center");
            addButton("上一页",100,30,143,458,previousJournal);
            addButton("下一页",100,30,617,458,nextJournal);
            addButton("关闭",78,30,727,88,finishJournal);
            renderJournal();
        }
        public function showPause(onResume:Function,onJournal:Function,onReturn:Function,onRetrySave:Function=null):void
        {
            var choices:Array=[
                {label:"继续旅程",description:"回到刚才的战场",action:onResume},
                {label:"翻阅旅途记录",description:"回看线索与已经发生的故事",action:onJournal},
                {label:"返回村庄",description:"结束本次挑战，保留已记录的剧情进度",action:onReturn}];
            if(onRetrySave!=null)choices.unshift({label:"重试保存",description:"当前进度尚未写入磁盘，请先重试。",action:onRetrySave});
            showChoice("篝火旁的片刻",onRetrySave!=null?"存档尚未写入磁盘。请重试保存，确认成功后再关闭游戏。":"旅途停在此处，准备好后再出发。",choices);
            kind="pause";complete=onResume;
        }
        public function showFailure(reason:String,onRetry:Function,onReturn:Function):void
        {
            showChoice("余火未熄",reason,[
                {label:"再次挑战",description:"从这一战的起点重新出发",action:onRetry},
                {label:"返回村庄",description:"整理装备，再来面对这场战斗",action:onReturn}]);
            kind="failure";
        }
        public function closeModal():void
        {
            var focusStage:Stage=stage ? stage : keyStage;
            removeEventListener(Event.ENTER_FRAME,revealFrame);
            for each(var b:ChapterButton in buttons)b.dispose();
            buttons=[];clearLayer(modal);pages=[];kind="";complete=null;skipped=null;
            body=null;pageLabel=null;nameLabel=null;portrait=null;fullText="";
            skipAllowed=false;chrome.visible=true;selection=0;
            // A clicked button may remain Stage.focus after removal, leaving
            // keyboard events on a detached target instead of the game's Stage.
            // Keep held-key suppression intact; only restore the focus target.
            if(focusStage)focusStage.focus=focusStage;
        }
        public function dispose():void
        {
            if(disposed)return;disposed=true;closeModal();
            removeEventListener(Event.ADDED_TO_STAGE,added);removeEventListener(Event.REMOVED_FROM_STAGE,removed);
            detachKeys();
            for each(var b:ChapterButton in permanentButtons)b.dispose();
            permanentButtons=[];onJournalRequest=null;onPauseRequest=null;inputAvailable=null;
            if(parent)parent.removeChild(this);
        }
        private function requestJournal():void {if(!modalOpen&&inputAllowed()&&onJournalRequest!=null)onJournalRequest();}
        private function requestPause():void {if(!modalOpen&&inputAllowed()&&onPauseRequest!=null)onPauseRequest();}
        private function added(e:Event):void
        {
            detachKeys();keyStage=stage;
            if(keyStage){
                keyStage.addEventListener(Event.DEACTIVATE,deactivated);
                keyStage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown,true,10000);
                keyStage.addEventListener(KeyboardEvent.KEY_UP,keyUp,true,10000);
                // Keyboard focus can be Stage itself, where capture listeners do not run.
                keyStage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown,false,10000);
                keyStage.addEventListener(KeyboardEvent.KEY_UP,keyUp,false,10000);
            }
        }
        private function removed(e:Event):void {detachKeys();}
        private function detachKeys():void
        {
            if(keyStage){
                keyStage.removeEventListener(Event.DEACTIVATE,deactivated);
                keyStage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown,true);
                keyStage.removeEventListener(KeyboardEvent.KEY_UP,keyUp,true);
                keyStage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown,false);
                keyStage.removeEventListener(KeyboardEvent.KEY_UP,keyUp,false);
                keyStage=null;
            }
            keys={};downKeys={};nativeHeldKeys={};pauseOpeningKeyHeld=false;openingEscapeEvent=null;
        }
        private function deactivated(e:Event):void {keys={};downKeys={};nativeHeldKeys={};pauseOpeningKeyHeld=false;openingEscapeEvent=null;}
        private function keyDown(e:KeyboardEvent):void
        {
            downKeys[e.keyCode]=true;
            if(!inputAllowed()){nativeHeldKeys[e.keyCode]=true;return;}
            if(nativeHeldKeys[e.keyCode])return;
            if(!modalOpen){
                if(e.keyCode==27){
                    // Capture and target/bubble can see the same event. Only a
                    // different event while held is an OS auto-repeat.
                    if(pauseOpeningKeyHeld && openingEscapeEvent!=e){e.stopImmediatePropagation();e.preventDefault();return;}
                    pauseOpeningKeyHeld=true;openingEscapeEvent=e;
                }
                // A held confirm key must not become a gameplay action after closing.
                if(keys[e.keyCode]){e.stopImmediatePropagation();e.preventDefault();}
                return;
            }
            e.stopImmediatePropagation();e.preventDefault();
            if(e.keyCode==27&&pauseOpeningKeyHeld)return;
            if(keys[e.keyCode])return;keys[e.keyCode]=true;
            if(kind=="dialogue"){
                if(e.keyCode==13||e.keyCode==32)advanceDialogue();
                else if(e.keyCode==27&&skipAllowed)finishDialogue(true);
            }else if(kind=="journal"){
                if(e.keyCode==37)previousJournal();else if(e.keyCode==39||e.keyCode==32)nextJournal();
                else if(e.keyCode==27||e.keyCode==13)finishJournal();
            }else{
                if(e.keyCode==38){selection=(selection+buttons.length-1)%Math.max(1,buttons.length);updateSelection();}
                else if(e.keyCode==40){selection=(selection+1)%Math.max(1,buttons.length);updateSelection();}
                else if((e.keyCode==13||e.keyCode==32)&&buttons.length>0)ChapterButton(buttons[selection]).activate();
                else if(e.keyCode>=49&&e.keyCode<49+buttons.length)ChapterButton(buttons[e.keyCode-49]).activate();
                else if(e.keyCode==27&&kind=="pause"){var resume:Function=complete;closeModal();if(resume!=null)resume();}
            }
        }
        private function keyUp(e:KeyboardEvent):void
        {
            // Always release our state, even while hidden or a native panel owns input.
            var nativeHeld:Boolean=Boolean(nativeHeldKeys[e.keyCode]);
            delete downKeys[e.keyCode];delete nativeHeldKeys[e.keyCode];
            if(e.keyCode==27){pauseOpeningKeyHeld=false;openingEscapeEvent=null;}
            var consumed:Boolean=Boolean(keys[e.keyCode]);delete keys[e.keyCode];
            if(!inputAllowed() || nativeHeld)return;
            if(modalOpen||consumed){e.stopImmediatePropagation();e.preventDefault();}
        }
        private function renderDialogue():void
        {
            var p:Object=pages[pageIndex];nameLabel.text=p.speaker;portrait.setIdentity(p.portrait);
            fullText=p.text;revealed=0;body.text="";revealStart=getTimer();
            pageLabel.text=(pageIndex+1)+" / "+pages.length+"     点击绢纸 / Enter / 空格继续";
        }
        private function revealFrame(e:Event):void
        {
            if(kind!="dialogue"||body==null)return;
            var count:int=Math.min(fullText.length,int((getTimer()-revealStart)/20)+1);
            if(count>revealed){revealed=count;body.text=fullText.substr(0,revealed);}
        }
        private function dialogueClick(e:MouseEvent):void {e.stopImmediatePropagation();advanceDialogue();}
        private function advanceDialogue():void
        {
            if(kind!="dialogue")return;
            if(revealed<fullText.length){revealed=fullText.length;body.text=fullText;return;}
            if(pageIndex+1<pages.length){pageIndex++;renderDialogue();}else finishDialogue(false);
        }
        private function skipDialogue():void {if(skipAllowed)finishDialogue(true);}
        private function finishDialogue(wasSkipped:Boolean):void
        {
            var callback:Function=complete;var notification:Function=wasSkipped?skipped:null;
            closeModal();if(notification!=null)notification();if(callback!=null)callback();
        }
        private function renderJournal():void
        {
            var p:Object=pages[pageIndex];nameLabel.text=p.speaker;body.text=p.text;
            pageLabel.text=(pageIndex+1)+" / "+pages.length+"   ← → 翻页 · Esc 关闭";
            ChapterButton(buttons[0]).setEnabled(pageIndex>0);
            ChapterButton(buttons[1]).setEnabled(pageIndex<pages.length-1);
        }
        private function previousJournal():void {if(kind=="journal"&&pageIndex>0){pageIndex--;renderJournal();}}
        private function nextJournal():void {if(kind=="journal"&&pageIndex<pages.length-1){pageIndex++;renderJournal();}}
        private function finishJournal():void {var callback:Function=complete;closeModal();if(callback!=null)callback();}
        private function choiceHandler(action:Function):Function
        {
            return function():void {if(!modalOpen)return;closeModal();if(action!=null)action();};
        }
        private function updateSelection():void
        {
            for(var i:int=0;i<buttons.length;i++)ChapterButton(buttons[i]).setSelected(i==selection);
        }
        private function addButton(label:String,w:Number,h:Number,x:Number,y:Number,action:Function,description:String = ""):ChapterButton
        {
            var b:ChapterButton=new ChapterButton(label,w,h,action,description);b.x=x;b.y=y;modal.addChild(b);buttons.push(b);return b;
        }
        private function addText(parent:Sprite,value:String,size:int,color:uint,x:Number,y:Number,w:Number,h:Number,bold:Boolean = false,align:String = "left"):TextField
        {
            var t:TextField=new TextField();var f:TextFormat=new TextFormat("PingFang SC",size,color,bold);
            f.leading=5;f.align=align;t.defaultTextFormat=f;t.selectable=false;t.multiline=true;t.wordWrap=true;t.mouseEnabled=false;
            t.x=x;t.y=y;t.width=w;t.height=h;t.text=value;parent.addChild(t);return t;
        }
        private function modalBackdrop():void
        {
            modal.graphics.beginFill(0x10222A,.47);modal.graphics.drawRect(0,0,940,580);modal.graphics.endFill();
            inputShield();
        }
        private function inputShield():void
        {
            var shield:Sprite=new Sprite();shield.graphics.beginFill(0,0);shield.graphics.drawRect(0,0,940,580);shield.graphics.endFill();
            shield.addEventListener(MouseEvent.CLICK,blockClick);
            shield.addEventListener(MouseEvent.MOUSE_DOWN,blockClick);
            shield.addEventListener(MouseEvent.MOUSE_UP,blockClick);
            shield.addEventListener(MouseEvent.MOUSE_WHEEL,blockClick);
            modal.addChild(shield);
        }
        private function blockClick(e:MouseEvent):void {e.stopImmediatePropagation();}
        private function parchment(w:Number,h:Number):Sprite
        {
            var p:Sprite=new Sprite();
            p.graphics.beginFill(0x08171D,.45);p.graphics.drawRoundRect(3,7,w,h,14,14);p.graphics.endFill();
            p.graphics.lineStyle(2,0x9E7B43);p.graphics.beginFill(0xE9DBB7);p.graphics.drawRoundRect(0,0,w,h,12,12);p.graphics.endFill();
            p.graphics.lineStyle(1,0xFFF4D6,.85);p.graphics.drawRoundRect(5,5,w-10,h-10,9,9);
            p.graphics.lineStyle(1,0xAA8A50,.4);p.graphics.drawRoundRect(10,10,w-20,h-20,6,6);
            for(var i:int=0;i<13;i++){
                var yy:Number=17+i*(h-34)/12;
                p.graphics.lineStyle(1,0x9A7F4D,.035);p.graphics.moveTo(18,yy);p.graphics.lineTo(w-18,yy+3);
            }
            for each(var xx:Number in [16,w-16])for each(var cy:Number in [16,h-16]){
                p.graphics.lineStyle(1,0x795C30);p.graphics.beginFill(0xC3A15B);p.graphics.moveTo(xx,cy-5);p.graphics.lineTo(xx+5,cy);p.graphics.lineTo(xx,cy+5);p.graphics.lineTo(xx-5,cy);p.graphics.lineTo(xx,cy-5);p.graphics.endFill();
            }
            return p;
        }
        private function clearLayer(layer:Sprite):void
        {
            layer.graphics.clear();
            while(layer.numChildren>0){
                var child:Object=layer.removeChildAt(layer.numChildren-1);
                child.removeEventListener(MouseEvent.CLICK,dialogueClick);child.removeEventListener(MouseEvent.CLICK,blockClick);
                child.removeEventListener(MouseEvent.MOUSE_DOWN,blockClick);child.removeEventListener(MouseEvent.MOUSE_UP,blockClick);
                child.removeEventListener(MouseEvent.MOUSE_WHEEL,blockClick);
            }
        }
        /** Measure actual device-font text; split long content rather than silently clipping it. */
        private function paginate(values:Array,w:Number,h:Number,size:int):Array
        {
            var result:Array=[];
            var measure:TextField=new TextField();var format:TextFormat=new TextFormat("PingFang SC",size);format.leading=5;
            measure.defaultTextFormat=format;measure.wordWrap=true;measure.multiline=true;measure.width=w;measure.height=10000;
            if(values==null)return result;
            for each(var raw:Object in values){
                if(raw==null)continue;
                var speaker:String="旅途记录";var text:String="";var face:String="hero";
                if(raw is String)text=String(raw);
                else if(raw is Array){speaker=String(raw[0]);text=String(raw[1]);face=speaker;}
                else {speaker=raw.speaker!=null?String(raw.speaker):(raw.title!=null?String(raw.title):speaker);text=raw.text!=null?String(raw.text):"";face=raw.portrait!=null?String(raw.portrait):speaker;}
                var start:int=0;
                if(text.length==0){result.push({speaker:speaker,text:"",portrait:face});continue;}
                while(start<text.length){
                    var end:int=start+1;var good:int=end;
                    while(end<=text.length){measure.text=text.substring(start,end);if(measure.textHeight>h-5)break;good=end;end++;}
                    // Prefer a sentence boundary near the last fitting line, without creating tiny pages.
                    if(good<text.length){
                        var cut:int=good;
                        while(cut>start+int((good-start)*.65)){
                            if("。！？；\n".indexOf(text.charAt(cut-1))>=0){good=cut;break;}cut--;
                        }
                    }
                    result.push({speaker:speaker,text:text.substring(start,good),portrait:face});start=good;
                }
            }
            return result;
        }
    }
}
