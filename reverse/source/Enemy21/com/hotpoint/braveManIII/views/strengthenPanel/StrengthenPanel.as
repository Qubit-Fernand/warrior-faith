package com.hotpoint.braveManIII.views.strengthenPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import src.*;
   
   public class StrengthenPanel extends MovieClip
   {
      
      private static var targetMc:MovieClip;
      
      private static var oldX:int;
      
      private static var oldY:int;
      
      public static var tooltip:ItemsTooltip;
      
      private static var childIndex:Number;
      
      private static var _instance:StrengthenPanel;
      
      private var playerState:Boolean = true;
      
      private var player1:PlayerData;
      
      private var player2:PlayerData;
      
      private var bag1:Bag;
      
      private var bag2:Bag;
      
      private var bagState:uint = 1;
      
      private var strengState:uint = 1;
      
      private var synthesisState:* = 1;
      
      private var playerGemArr1:Array = [];
      
      private var playerGemArr2:Array = [];
      
      private var playerEquipArr1:Array = [];
      
      private var playerEquipArr2:Array = [];
      
      private var palyerSuppliesArr1:Array = [];
      
      private var palyerSuppliesArr2:Array = [];
      
      private var pcOnePointArr:Array = [];
      
      private var pcTowPointArr:Array = [];
      
      private var strengLanPointArr:Array = [];
      
      private var slot:StrengthenSlot;
      
      private var skillSlot:SkillSlot;
      
      private var synthesisSlot:StrengthenSynthesisSlot;
      
      private var mosaicSlot:StrengthenMosaicSlot;
      
      private var deteleSlot:StrengthenDeleteSlot;
      
      private var synthesisSlotArr:* = [];
      
      private var mosaicSlotArr:* = [];
      
      private var deteleSlotArr:* = [];
      
      private var skillSlotArr:Array = [];
      
      private var slotBagArr:Array = [];
      
      private var mosaicPointArr:Array = [];
      
      private var deletePointArr:Array = [];
      
      private var synthesisPointArr:Array = [];
      
      private var mouseDownBo:Boolean;
      
      private var strMove:StrenthenPanlMove;
      
      private var downName:String;
      
      private var luckGemProbaprobability:VT;
      
      private var luckGemProbaprobability2:VT;
      
      private var equipProbability:VT;
      
      private var skillProbability:VT;
      
      private var probability:VT;
      
      private var deleteProbability:VT;
      
      private var sysProbability:VT;
      
      private var times:int = 0;
      
      private var timer:Timer;
      
      private var timerSys:Timer;
      
      private var timerUi:Timer;
      
      private var timesSys:int = 0;
      
      private var okMove:Boolean = true;
      
      private var okMove1:Boolean = true;
      
      private var randomNum:int = Math.random() * 100;
      
      private var stopTime:int = 80;
      
      private var taskArr1:Array = [];
      
      private var taskArr2:Array = [];
      
      private var other:Otherobj;
      
      private var otherArr1:Array = [];
      
      private var otherArr2:Array = [];
      
      private var ptSlot:promptSlot;
      
      private var mouseuup:Boolean;
      
      private var typeNum:Number;
      
      private var oldgold:Number;
      
      private var myMenu:ContextMenu = new ContextMenu();
      
      public function StrengthenPanel(pvt:PrivateClass)
      {
         super();
      }
      
      public static function open(num:Number = 1) : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(StrengthenPanel._instance == null)
         {
            StrengthenPanel._instance = new StrengthenPanel(new PrivateClass());
            StrengthenPanel._instance.initMc();
         }
         StrengthenPanel._instance.x = 100;
         StrengthenPanel._instance.y = 50;
         Main._stage.addChild(StrengthenPanel._instance);
         StrengthenPanel._instance.visible = true;
         StrengthenPanel._instance.initAllBag(num);
         StrengthenPanel._instance.closeMast.visible = false;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(StrengthenPanel._instance != null)
         {
            if(StrengthenPanel._instance.visible == true)
            {
               StrengthenPanel._instance.visible = false;
               StrengthenPanel._instance.closeMc();
               StrengthenPanel._instance.closeEvent();
               StrengthenPanel._instance.closeData();
            }
         }
      }
      
      public static function loseFocus(e:Event = null) : void
      {
         if(targetMc)
         {
            targetMc.stopDrag();
            targetMc.x = oldX;
            targetMc.y = oldY;
            _instance.addChildAt(targetMc,childIndex);
         }
      }
      
      public function closeMc() : void
      {
         prompt.visible = false;
         gold_mc.visible = false;
         an1.visible = false;
         an2.visible = false;
      }
      
      private function setXY() : void
      {
         trace("设置坐标");
         var stageWidth:Number = Main._stage.stageWidth / 2;
         var stageHeight:Number = Main._stage.stageHeight / 2;
         this.x = stageWidth - this.width / 2;
         this.y = 60;
      }
      
      private function initMc() : void
      {
         keyMc = new KeyMc();
         this.addChild(keyMc);
         keyMc.x = 285.5;
         keyMc.y = 39.95;
         keyMc.visible = false;
         this.addChildAt(keyMc,numChildren - 3);
         help = new Help_mc();
         help.x = 126;
         help.y = 69;
         this.addChild(help);
         help.visible = false;
         this.addChildAt(help,numChildren - 1);
         prompt = new PromptMc();
         this.addChild(prompt);
         prompt.visible = false;
         gold_mc.visible = false;
         this.addChildAt(gold_mc,numChildren - 1);
         tooltip = new ItemsTooltip();
         this.addChild(tooltip);
         tooltip.visible = false;
         an1.visible = false;
         an2.visible = false;
         this.slot = StrengthenSlot.creatStrengThenSlot();
         this.skillSlot = SkillSlot.creatStriengSkill();
         this.synthesisSlot = StrengthenSynthesisSlot.creatSynthesisSlot();
         this.mosaicSlot = StrengthenMosaicSlot.creatMosaicSlot();
         this.deteleSlot = StrengthenDeleteSlot.creatDeleteSlot();
         this.ptSlot = promptSlot.creatDeleteSlot();
         this.strMove = StrenthenPanlMove.creatMove();
      }
      
      private function initAllBag(num:Number = 1) : void
      {
         if(num == 1)
         {
            this.playerState = false;
         }
         else if(num == 2)
         {
            this.playerState = true;
         }
         this.equipProbability = VT.createVT(0);
         this.skillProbability = VT.createVT(0);
         this.luckGemProbaprobability = VT.createVT(0);
         this.luckGemProbaprobability2 = VT.createVT(0);
         this.deleteProbability = VT.createVT(0);
         this.sysProbability = VT.createVT(0);
         this.probability = VT.createVT(0);
         this.bagState = 1;
         mast_one.visible = true;
         mast_tow.visible = true;
         this.btnGlinit();
         s1_mc.stop();
         s2_mc.stop();
         s3_mc.stop();
         s4_mc.stop();
         str_one.isClick = true;
         sys_one.isClick = true;
         this.initP1orP2();
         this.strengthenBagCao();
         this.strengthenLanCao();
         this.initEvent();
         this.allstop();
      }
      
      private function allstop() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            this["d1_" + i].stop();
            this["d2_" + i].stop();
         }
         for(i = 0; i < 3; i++)
         {
            this["qh_" + i].stop();
            this["qh_" + i].visible = false;
            this["hc_" + i].stop();
            this["hc_" + i].visible = false;
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,this.changHandle);
         this.addEventListener(BtnEvent.DO_CLICK,this.clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,this.closeHandle);
         this.addEventListener(BtnEvent.DO_OVER,this.overHandle);
         this.addEventListener(BtnEvent.DO_OUT,this.outHandle);
         this.addEventListener(Event.DEACTIVATE,loseFocus);
         this.myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         this.contextMenu = this.myMenu;
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         this.timer = new Timer(1);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.timerSys = new Timer(1);
         this.timerSys.addEventListener(TimerEvent.TIMER,this.onTimerSys);
         this.addClick();
      }
      
      private function closeEvent() : void
      {
         this.removeEventListener(BtnEvent.DO_CHANGE,this.changHandle);
         this.removeEventListener(BtnEvent.DO_CLOSE,this.closeHandle);
         this.removeEventListener(BtnEvent.DO_OVER,this.overHandle);
         this.removeEventListener(BtnEvent.DO_OUT,this.outHandle);
         this.removeEventListener(BtnEvent.DO_CLICK,this.clickHandle);
         this.removeEventListener(Event.DEACTIVATE,loseFocus);
         this.myMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.removeEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         this.removeClick();
      }
      
      private function initP1orP2() : void
      {
         if(!this.playerState)
         {
            this.player1 = Main.player1;
            this.bag1 = this.player1.getBag();
            this.equipUpdate();
            this.btnIsClick(1);
            this.noInitPtow();
            keyMc.visible = true;
            keyMc.y = 252.65;
            mast_one.visible = false;
            p1Gold.text = this.player1.getGold().toString();
         }
         else
         {
            this.player2 = Main.player2;
            this.bag2 = this.player2.getBag();
            this.equipUpdate();
            this.btnIsClick(1);
            this.noInitPone();
            keyMc.visible = true;
            keyMc.y = 39.95;
            mast_tow.visible = false;
            p2Gold.text = this.player2.getGold().toString();
         }
      }
      
      public function equipUpdate() : void
      {
         var i:uint = 0;
         if(!this.playerState)
         {
            this.playerEquipArr1 = this.bag1.getEquipBag();
            for(i = 0; i < 24; i++)
            {
               if(this.playerEquipArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(this.playerEquipArr1[i].getFrame());
                  this["d1_" + i].howNum.text = "";
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            this.playerEquipArr2 = this.bag2.getEquipBag();
            for(i = 0; i < 24; i++)
            {
               if(this.playerEquipArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(this.playerEquipArr2[i].getFrame());
                  this["d2_" + i].howNum.text = "";
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function gemUpdate() : void
      {
         var i:uint = 0;
         if(!this.playerState)
         {
            this.playerGemArr1 = this.bag1.getGemBag();
            for(i = 0; i < 24; i++)
            {
               if(this.playerGemArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(this.playerGemArr1[i].getFrame());
                  this["d1_" + i].howNum.text = this.playerGemArr1[i].getTimes();
                  if(this.playerGemArr1[i].getTimes() <= 1)
                  {
                     this["d1_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            this.playerGemArr2 = this.bag2.getGemBag();
            for(i = 0; i < 24; i++)
            {
               if(this.playerGemArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(this.playerGemArr2[i].getFrame());
                  this["d2_" + i].howNum.text = this.playerGemArr2[i].getTimes();
                  if(this.playerGemArr2[i].getTimes() <= 1)
                  {
                     this["d2_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function supUpdate() : void
      {
         var i:uint = 0;
         if(!this.playerState)
         {
            this.palyerSuppliesArr1 = this.bag1.getSuppliesBag();
            for(i = 0; i < 24; i++)
            {
               if(this.palyerSuppliesArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(this.palyerSuppliesArr1[i].getFrame());
                  this["d1_" + i].howNum.text = this.palyerSuppliesArr1[i].getTimes();
                  if(this.palyerSuppliesArr1[i].getTimes() <= 1)
                  {
                     this["d1_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            this.palyerSuppliesArr2 = this.bag2.getSuppliesBag();
            for(i = 0; i < 24; i++)
            {
               if(this.palyerSuppliesArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(this.palyerSuppliesArr2[i].getFrame());
                  this["d2_" + i].howNum.text = this.palyerSuppliesArr2[i].getTimes();
                  if(this.palyerSuppliesArr2[i].getTimes() <= 1)
                  {
                     this["d2_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function otherUpdate() : void
      {
         var i:uint = 0;
         if(!this.playerState)
         {
            this.otherArr1 = this.bag1.getOtherobjBag();
            for(i = 0; i < 24; i++)
            {
               if(this.otherArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(this.otherArr1[i].getFrame());
                  this["d1_" + i].howNum.text = "";
                  this["d1_" + i].howNum.text = this.otherArr1[i].getTimes();
                  if(this.otherArr1[i].getTimes() <= 1)
                  {
                     this["d1_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            this.otherArr2 = this.bag2.getOtherobjBag();
            for(i = 0; i < 24; i++)
            {
               if(this.otherArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(this.otherArr2[i].getFrame());
                  this["d2_" + i].howNum.text = "";
                  this["d2_" + i].howNum.text = this.otherArr2[i].getTimes();
                  if(this.otherArr2[i].getTimes() <= 1)
                  {
                     this["d2_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function taskUpdate() : void
      {
         var i:uint = 0;
         if(!this.playerState)
         {
            this.taskArr1 = this.bag1.getQuestBag();
            for(i = 0; i < 24; i++)
            {
               if(this.taskArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(this.taskArr1[i].getFrame());
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            this.taskArr2 = this.bag2.getQuestBag();
            for(i = 0; i < 24; i++)
            {
               if(this.taskArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(this.taskArr2[i].getFrame());
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function soltUpdate() : void
      {
         this.slotBagArr = this.slot.slotArr();
         for(var i:uint = 0; i < 3; i++)
         {
            if(this.slotBagArr[i] != -1)
            {
               this["qh_" + i].visible = true;
               this["qh_" + i].howNum.text = "";
               this["qh_" + i].gotoAndStop(this.slotBagArr[i].getFrame());
               this["qhc_" + i].gotoAndStop(2);
            }
            else
            {
               this["qh_" + i].visible = false;
               this["qhc_" + i].gotoAndStop(1);
            }
         }
      }
      
      public function skillSoltUpdate() : void
      {
         this.skillSlotArr = this.skillSlot.slotArr();
         for(var i:uint = 0; i < 3; i++)
         {
            if(this.skillSlotArr[i] != -1)
            {
               this["qh_" + i].visible = true;
               this["qh_" + i].howNum.text = "";
               this["qh_" + i].gotoAndStop(this.skillSlotArr[i].getFrame());
               this["qhc_" + i].gotoAndStop(2);
            }
            else
            {
               this["qh_" + i].visible = false;
               this["qhc_" + i].gotoAndStop(1);
            }
         }
      }
      
      public function sysSlotUpdate() : void
      {
         this.synthesisSlotArr = this.synthesisSlot.slotArr();
         for(var i:uint = 0; i < 3; i++)
         {
            if(this.synthesisSlotArr[i] != -1)
            {
               this["hc_" + i].visible = true;
               this["hc_" + i].howNum.text = "";
               this["hc_" + i].gotoAndStop(this.synthesisSlotArr[i].getFrame());
               this["hcc_" + i].gotoAndStop(2);
            }
            else
            {
               this["hc_" + i].visible = false;
               this["hcc_" + i].gotoAndStop(1);
            }
         }
      }
      
      public function mosaicSlotUpdate() : void
      {
         this.mosaicSlotArr = this.mosaicSlot.slotArr();
         for(var i:uint = 0; i < 2; i++)
         {
            if(this.mosaicSlotArr[i] != -1)
            {
               this["hc_" + i].visible = true;
               this["hc_" + i].howNum.text = "";
               this["hc_" + i].gotoAndStop(this.mosaicSlotArr[i].getFrame());
               this["hcc_" + i].gotoAndStop(2);
            }
            else
            {
               this["hc_" + i].visible = false;
               this["hcc_" + i].gotoAndStop(1);
            }
         }
      }
      
      public function deleteSlotUpdate() : void
      {
         this.deteleSlotArr = this.deteleSlot.slotArr();
         for(var i:uint = 0; i < 2; i++)
         {
            if(this.deteleSlotArr[i] != -1)
            {
               this["hc_" + i].visible = true;
               this["hc_" + i].howNum.text = "";
               this["hc_" + i].gotoAndStop(this.deteleSlotArr[i].getFrame());
               this["hcc_" + i].gotoAndStop(2);
            }
            else
            {
               this["hc_" + i].visible = false;
               this["hcc_" + i].gotoAndStop(1);
            }
         }
      }
      
      private function outHandle(e:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function overHandle(e:BtnEvent) : void
      {
         var nameStr:String = e.target.name;
         tooltip.visible = true;
         if(nameStr == "prompt_1")
         {
            if(this.ptSlot.getPropEquip(0))
            {
               tooltip.equipTooltip(this.ptSlot.getProp(0),3);
            }
            if(this.ptSlot.getPropGem(0))
            {
               tooltip.gemTooltip(this.ptSlot.getProp(0),3);
            }
         }
         if(nameStr == "prompt_2")
         {
            tooltip.gemTooltip(this.ptSlot.getProp(1),3);
         }
         tooltip.x = mouseX + 10;
         tooltip.y = mouseY;
         this.pointY(tooltip);
      }
      
      private function closeHandle(e:BtnEvent) : void
      {
         var id:uint = uint(e.target.id);
         var mc_name:String = e.target.parent.name;
         if(mc_name == "gold_mc")
         {
            if(id == 1)
            {
               gold_mc.visible = false;
               if(!this.playerState)
               {
                  if(this.player1.payGold(this.oldgold))
                  {
                     p1Gold.text = this.player1.getGold().toString();
                     if(this.typeNum == 1)
                     {
                        this.okMove = false;
                        this.timer.start();
                        s1_mc.gotoAndPlay(2);
                        s2_mc.gotoAndPlay(2);
                     }
                     if(this.typeNum == 2)
                     {
                        this.timesSys = 0;
                        this.okMove1 = false;
                        this.timerSys.start();
                        s3_mc.gotoAndPlay(2);
                        s4_mc.gotoAndPlay(2);
                     }
                     this.removeClick();
                  }
                  else
                  {
                     trace("金币不足");
                     closeMast.visible = false;
                     ShortTip.open(16);
                     this.closeData();
                  }
               }
               else if(this.player2.payGold(this.oldgold))
               {
                  p2Gold.text = this.player2.getGold().toString();
                  if(this.typeNum == 1)
                  {
                     this.okMove = false;
                     this.timer.start();
                     s1_mc.gotoAndPlay(2);
                     s2_mc.gotoAndPlay(2);
                  }
                  if(this.typeNum == 2)
                  {
                     this.timesSys = 0;
                     this.okMove1 = false;
                     this.timerSys.start();
                     s3_mc.gotoAndPlay(2);
                     s4_mc.gotoAndPlay(2);
                  }
                  this.removeClick();
               }
               else
               {
                  trace("金币不足");
                  closeMast.visible = false;
                  ShortTip.open(16);
                  this.closeData();
               }
            }
            if(id == 2)
            {
               closeMast.visible = false;
               gold_mc.visible = false;
               this.closeData();
            }
         }
         else
         {
            if(id == 3)
            {
               close();
            }
            prompt.visible = false;
         }
      }
      
      private function closeData() : void
      {
         this.strToBagSty();
         this.strGemToBagSty();
         this.synthesisToBagSty();
         this.mosToBagSty();
         this.deleteToBagSty();
         this.closeStrengGl();
         this.closeSysGl();
         this.equipUpdate();
         this.soltUpdate();
         this.btnIsClick(1);
         this.bagState = 1;
         this.strengState = 1;
         textMc.gotoAndStop(1);
         str_tow.isClick = false;
         this.synthesisState = 1;
         this.hc_2.visible = true;
         this.hcc_2.visible = true;
         this.x3_mc.visible = true;
         this.hc_0.x = 56.15;
         this.hcc_0.x = 53.7;
         this.x1_mc.x = 50.35;
         this.hc_1.x = 132.15;
         this.hcc_1.x = 129.7;
         this.x2_mc.x = 126.35;
         this.sysSlotUpdate();
         this.syn_mc.gotoAndStop(1);
         this.syn_mc.hc.h2.gotoAndStop(1);
         sys_tow.isClick = false;
         sys_three.isClick = false;
         sys_one.isClick = true;
         this.times = 0;
         this.timer.stop();
         this.okMove = true;
         this.timesSys = 0;
         this.timerSys.stop();
         this.okMove1 = true;
         an1.visible = false;
         an2.visible = false;
      }
      
      private function daojuMessageOver(e:DaoJuEvent) : void
      {
         var mc:MovieClip = e.target as MovieClip;
         var nameStr:String = mc.name;
         var nameId:String = nameStr.substr(1,1);
         var id:int = int(nameStr.substr(3,2));
         switch(nameId)
         {
            case "1":
               if(this.bagState == 1)
               {
                  tooltip.equipTooltip(this.bag1.getEquipFromBag(id),3);
               }
               else if(this.bagState == 2)
               {
                  tooltip.suppliesTooltip(this.bag1.getSuppliesFromBag(id),3);
               }
               else if(this.bagState == 3)
               {
                  tooltip.gemTooltip(this.bag1.getGemFromBag(id),3);
               }
               else if(this.bagState == 4)
               {
                  tooltip.otherTooltip(this.bag1.getOtherobjFromBag(id));
               }
               break;
            case "2":
               if(this.bagState == 1)
               {
                  tooltip.equipTooltip(this.bag2.getEquipFromBag(id),3);
               }
               else if(this.bagState == 2)
               {
                  tooltip.suppliesTooltip(this.bag2.getSuppliesFromBag(id),3);
               }
               else if(this.bagState == 3)
               {
                  tooltip.gemTooltip(this.bag2.getGemFromBag(id),3);
               }
               else if(this.bagState == 4)
               {
                  tooltip.otherTooltip(this.bag2.getOtherobjFromBag(id));
               }
               break;
            case "h":
               if(this.strengState == 1)
               {
                  if(this.slot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.equipTooltip(this.slot.getProp(id),3);
                     }
                  }
                  if(this.slot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(this.slot.getProp(1),3);
                     }
                  }
                  if(this.slot.getProp(2) != -1)
                  {
                     if(id == 2)
                     {
                        tooltip.gemTooltip(this.slot.getProp(2),3);
                     }
                  }
               }
               if(this.strengState == 2)
               {
                  if(this.skillSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.gemTooltip(this.skillSlot.getProp(id),3);
                     }
                  }
                  if(this.skillSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(this.skillSlot.getProp(id),3);
                     }
                  }
                  if(this.skillSlot.getProp(2) != -1)
                  {
                     if(id == 2)
                     {
                        tooltip.gemTooltip(this.skillSlot.getProp(2),3);
                     }
                  }
               }
               break;
            case "c":
               if(this.synthesisState == 1)
               {
                  if(this.synthesisSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.gemTooltip(this.synthesisSlot.getProp(id),3);
                     }
                  }
                  if(this.synthesisSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(this.synthesisSlot.getProp(id),3);
                     }
                  }
                  if(this.synthesisSlot.getProp(2) != -1)
                  {
                     if(id == 2)
                     {
                        tooltip.otherTooltip(this.synthesisSlot.getProp(id));
                     }
                  }
               }
               if(this.synthesisState == 2)
               {
                  if(this.mosaicSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.equipTooltip(this.mosaicSlot.getProp(id),3);
                     }
                  }
                  if(this.mosaicSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(this.mosaicSlot.getProp(id),3);
                     }
                  }
               }
               if(this.synthesisState == 3)
               {
                  if(this.deteleSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.equipTooltip(this.deteleSlot.getProp(id),3);
                     }
                  }
                  if(this.deteleSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(this.deteleSlot.getProp(id),3);
                     }
                  }
               }
         }
         if(!this.mouseDownBo)
         {
            tooltip.visible = true;
         }
         tooltip.x = mouseX + 10;
         tooltip.y = mouseY;
         this.pointY(tooltip);
         this.addChildAt(tooltip,numChildren - 1);
      }
      
      private function daojuMessageOut(e:DaoJuEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function daojuMessageDown(e:DaoJuEvent) : void
      {
         this.mouseuup = true;
         var mc:MovieClip = e.target as MovieClip;
         var nameStr:String = mc.name;
         this.downName = nameStr.substr(1,1);
         var id:Number = Number(nameStr.substr(3,2));
         this.mouseDownBo = true;
         mc.startDrag();
         tooltip.visible = false;
         targetMc = mc;
         targetMc.id = id;
         oldX = mc.x;
         oldY = mc.y;
         mc.x = mouseX - mc.width / 2;
         mc.y = mouseY - mc.height / 2;
         childIndex = this.getChildIndex(mc);
         this.addChildAt(mc,numChildren - 2);
      }
      
      private function daojuMessageUp(e:DaoJuEvent) : void
      {
         this.mouseuup = false;
         var mc:MovieClip = e.target as MovieClip;
         var nameStr:String = mc.name;
         var nameId:String = nameStr.substr(1,1);
         var id:int = int(nameStr.substr(3,2));
         this.mouseDownBo = false;
         mc.stopDrag();
         this.addChildAt(mc,childIndex);
         if(!this.playerState)
         {
            if(nameId == "1")
            {
               if(mouseX > this.pc1_0.x)
               {
                  this.bagMoveInit(this.pcOnePointArr,this.bag1);
               }
               else if(mouseY < qhc_1.y + qhc_1.height)
               {
                  this.bagMoveToStrengthenLan(this.strengLanPointArr,this.bag1);
               }
               else
               {
                  this.bagMoveTosynthesisSlot(this.synthesisPointArr,this.mosaicPointArr,this.deletePointArr,this.bag1);
               }
            }
            else
            {
               if(nameId == "h")
               {
                  this.strengthenLanMoveToBag(this.pcOnePointArr,this.bag1);
               }
               if(nameId == "c")
               {
                  this.synthesisSlotLanMoveToBag(this.pcOnePointArr,this.bag1);
               }
            }
         }
         else if(nameId == "2")
         {
            if(mouseX > this.pc2_0.x)
            {
               this.bagMoveInit(this.pcTowPointArr,this.bag2);
            }
            else if(mouseY < qhc_1.y + qhc_1.height)
            {
               this.bagMoveToStrengthenLan(this.strengLanPointArr,this.bag2);
            }
            else
            {
               this.bagMoveTosynthesisSlot(this.synthesisPointArr,this.mosaicPointArr,this.deletePointArr,this.bag2);
            }
         }
         else
         {
            if(nameId == "h")
            {
               this.strengthenLanMoveToBag(this.pcTowPointArr,this.bag2);
            }
            if(nameId == "c")
            {
               this.synthesisSlotLanMoveToBag(this.pcTowPointArr,this.bag2);
            }
         }
      }
      
      private function synthesisSlotLanMoveToBag(pcPoint:Array, bag:Bag) : void
      {
         var equip1:Equip = null;
         var equip2:Equip = null;
         var gem:Gem = null;
         var gem1:Gem = null;
         var gem2:Gem = null;
         var targetX:int = mouseX;
         var targetY:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         for(var i:uint = 0; i < 24; i++)
         {
            if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
            {
               continue;
            }
            switch(this.bagState)
            {
               case 1:
                  if(this.synthesisState == 2)
                  {
                     if(this.mosaicSlot.getPropEquip(targetMc.id))
                     {
                        equip1 = this.mosaicSlot.getProp(targetMc.id);
                        this.strMove.equipMoveToBag(equip1,this.mosaicSlot,bag,targetMc.id,pcPoint[i][0]);
                        this.equipUpdate();
                        this.mosaicSlotUpdate();
                        if(this.mosaicSlot.getProp(0) == -1)
                        {
                           this.sysGl(0,0);
                        }
                     }
                  }
                  if(this.synthesisState == 3)
                  {
                     if(this.deteleSlot.getPropEquip(targetMc.id))
                     {
                        equip2 = this.deteleSlot.getProp(targetMc.id);
                        this.strMove.equipMoveToBag(equip2,this.deteleSlot,bag,targetMc.id,pcPoint[i][0]);
                        this.equipUpdate();
                        this.deleteSlotUpdate();
                        this.deleteProbability.setValue(0);
                        if(this.deteleSlot.getProp(0) == -1)
                        {
                           this.sysGl(this.deleteProbability.getValue(),this.luckGemProbaprobability2.getValue());
                        }
                     }
                  }
                  break;
               case 3:
                  if(this.synthesisState == 1)
                  {
                     if(this.synthesisSlot.getPropGem(targetMc.id))
                     {
                        gem = this.synthesisSlot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(gem,bag,this.synthesisSlot,targetMc.id,pcPoint[i][0]);
                        this.gemUpdate();
                        this.sysSlotUpdate();
                        if(this.synthesisSlot.getProp(0) == -1 && this.synthesisSlot.getProp(1) == -1)
                        {
                           this.sysGl(0,0);
                        }
                     }
                  }
                  if(this.synthesisState == 2)
                  {
                     if(this.mosaicSlot.getPropGem(targetMc.id))
                     {
                        gem1 = this.mosaicSlot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(gem1,bag,this.mosaicSlot,targetMc.id,pcPoint[i][0]);
                        this.gemUpdate();
                        this.mosaicSlotUpdate();
                        if(this.mosaicSlot.getProp(0) == -1)
                        {
                           this.sysGl(0,0);
                        }
                     }
                  }
                  if(this.synthesisState == 3)
                  {
                     if(this.deteleSlot.getPropGem(targetMc.id))
                     {
                        gem2 = this.deteleSlot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(gem2,bag,this.deteleSlot,targetMc.id,pcPoint[i][0]);
                        this.gemUpdate();
                        this.deleteSlotUpdate();
                        if(this.deteleSlot.getProp(1) == -1)
                        {
                           this.luckGemProbaprobability2.setValue(0);
                           this.sysGl(this.deleteProbability.getValue(),this.luckGemProbaprobability2.getValue());
                        }
                     }
                  }
                  break;
               case 4:
                  if(!bag.addToOtherobjBag(this.synthesisSlot.getProp(2),pcPoint[i][0]))
                  {
                     bag.addOtherobjBag(this.synthesisSlot.getProp(2));
                  }
                  this.synthesisSlot.delSlot(2);
                  this.otherUpdate();
                  this.sysSlotUpdate();
            }
         }
      }
      
      private function strengthenLanMoveToBag(pcPoint:Array, bag:Bag) : void
      {
         var equip1:Equip = null;
         var gem:Gem = null;
         var gem2:Gem = null;
         var targetX:int = mouseX;
         var targetY:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         for(var i:uint = 0; i < 24; i++)
         {
            if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
            {
               continue;
            }
            switch(this.bagState)
            {
               case 1:
                  if(this.slot.getPropEquip(targetMc.id))
                  {
                     equip1 = this.slot.getProp(targetMc.id);
                     this.strMove.equipMoveToBag(equip1,this.slot,bag,targetMc.id,pcPoint[i][0]);
                     this.equipUpdate();
                     this.soltUpdate();
                     this.equipProbability.setValue(0);
                     this.strenthenGl(this.equipProbability.getValue(),this.luckGemProbaprobability.getValue());
                  }
                  break;
               case 3:
                  if(this.strengState == 1)
                  {
                     if(this.slot.getPropGem(targetMc.id))
                     {
                        gem = this.slot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(gem,bag,this.slot,targetMc.id,pcPoint[i][0]);
                        this.gemUpdate();
                        this.soltUpdate();
                        if(this.slot.getProp(1) == -1)
                        {
                           this.equipProbability.setValue(0);
                           this.strenthenGl(this.equipProbability.getValue(),this.luckGemProbaprobability.getValue());
                        }
                        if(this.slot.getProp(2) == -1)
                        {
                           this.luckGemProbaprobability.setValue(0);
                           this.strenthenGl(this.equipProbability.getValue(),this.luckGemProbaprobability.getValue());
                        }
                     }
                  }
                  if(this.strengState == 2)
                  {
                     gem2 = this.skillSlot.getProp(targetMc.id);
                     if(this.skillSlot.getPropGem(targetMc.id))
                     {
                        this.strMove.gemBackToBag(gem2,bag,this.skillSlot,targetMc.id,pcPoint[i][0]);
                        this.gemUpdate();
                        this.skillSoltUpdate();
                        if(this.skillSlot.getProp(0) == -1)
                        {
                           this.skillProbability.setValue(0);
                           this.strenthenGl(this.skillProbability.getValue(),this.luckGemProbaprobability.getValue());
                        }
                        if(this.skillSlot.getProp(2) == -1)
                        {
                           this.luckGemProbaprobability.setValue(0);
                           this.strenthenGl(this.skillProbability.getValue(),this.luckGemProbaprobability.getValue());
                        }
                     }
                  }
                  break;
               case 4:
                  break;
               case 5:
            }
         }
      }
      
      private function sysOne(pointNum:Number, prop:Number, typeArr:Array, bag:Bag) : void
      {
         var gem1:Gem = null;
         var gem2:Gem = null;
         if(this.synthesisSlot.getProp(prop) == -1)
         {
            this.strMove.bagGemMoveToStr(pointNum,targetMc,typeArr,this.synthesisSlot,bag);
            this.gemUpdate();
            this.sysSlotUpdate();
         }
         else
         {
            gem1 = this.synthesisSlot.getProp(prop);
            gem2 = bag.getGemFromBag(targetMc.id);
            if(gem1.getType() == gem2.getType())
            {
               if(gem1.getType() == 1)
               {
                  if(gem1.getUseLevel() == gem2.getUseLevel())
                  {
                     this.strMove.bagGemMoveToStr(pointNum,targetMc,typeArr,this.synthesisSlot,bag);
                     this.gemUpdate();
                     this.sysSlotUpdate();
                  }
                  else
                  {
                     ShortTip.open(23);
                     trace("宝石使用等级不同");
                  }
               }
               else
               {
                  this.strMove.bagGemMoveToStr(pointNum,targetMc,typeArr,this.synthesisSlot,bag);
                  this.gemUpdate();
                  this.sysSlotUpdate();
               }
            }
            else
            {
               trace("类型不同");
               ShortTip.open(4);
            }
         }
      }
      
      private function bagMoveTosynthesisSlot(pcPoint:Array, pcPoint1:Array, pcPointwk:Array, _bag:Bag) : void
      {
         var pointX:Number = NaN;
         var pointY:Number = NaN;
         var i:uint = 0;
         var targetX:int = mouseX;
         var targetY:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         var bag:Bag = _bag;
         var myarr:Array = [];
         if(this.synthesisState == 1)
         {
            for(i = 0; i < 3; i++)
            {
               if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(this.bagState)
               {
                  case 3:
                     myarr = [0,1,3];
                     if(bag.backGemBagNum() > 0)
                     {
                        if(bag.getGemFromBag(targetMc.id).getType() == 0 || bag.getGemFromBag(targetMc.id).getType() == 1 || bag.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(bag.getGemFromBag(targetMc.id).getColor() == 1)
                           {
                              if(pcPoint[i][0] == 0)
                              {
                                 this.sysOne(0,1,myarr,bag);
                                 if(this.synthesisSlot.getProp(0) != -1)
                                 {
                                    this.sysGl(100,0);
                                 }
                              }
                              if(pcPoint[i][0] == 1)
                              {
                                 myarr = [0,1,3];
                                 this.sysOne(1,0,myarr,bag);
                              }
                           }
                           else
                           {
                              trace("放入一级宝石");
                              ShortTip.open(9);
                           }
                        }
                        else
                        {
                           ShortTip.open(4);
                           trace("放入宝石不符合");
                        }
                     }
                     else
                     {
                        trace("请清空背包");
                        ShortTip.open(3);
                     }
                     break;
                  case 4:
                     if(pcPoint[i][0] == 2)
                     {
                        if(bag.getOtherobjFromBag(targetMc.id) is Otherobj && bag.getOtherobjFromBag(targetMc.id).getType() == 1)
                        {
                           if(this.synthesisSlot.getProp(2) == -1)
                           {
                              this.synthesisSlot.addToSlot(bag.delOtherobj(targetMc.id),2);
                              this.otherUpdate();
                              this.sysSlotUpdate();
                           }
                        }
                     }
               }
            }
         }
         if(this.synthesisState == 2)
         {
            for(i = 0; i < 2; i++)
            {
               if(!(targetX >= pcPoint1[i][1] && targetX <= pcPoint1[i][1] + pc2_0.width && (targetY >= pcPoint1[i][2] && targetY <= pcPoint1[i][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(this.bagState)
               {
                  case 1:
                     if(this.mosaicSlot.getProp(1) == -1)
                     {
                        if(bag.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           this.strMove.equipMoveTostrenthen(pcPoint[i][0],targetMc.id,this.mosaicSlot,bag);
                           this.equipUpdate();
                           this.mosaicSlotUpdate();
                        }
                        else
                        {
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              trace("无法继续镶嵌");
                              ShortTip.open(8);
                           }
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == -1)
                           {
                              trace("没有孔");
                              ShortTip.open(7);
                           }
                        }
                     }
                     else if(bag.getEquipFromBag(targetMc.id).getDressLevel() >= this.mosaicSlot.getProp(1).getUseLevel())
                     {
                        if(bag.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           this.strMove.equipMoveTostrenthen(pcPoint[i][0],targetMc.id,this.mosaicSlot,bag);
                           this.equipUpdate();
                           this.mosaicSlotUpdate();
                        }
                        else
                        {
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              ShortTip.open(8);
                              trace("无法继续镶嵌");
                           }
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == -1)
                           {
                              ShortTip.open(7);
                              trace("没有孔");
                           }
                        }
                     }
                     else
                     {
                        trace("等级不符合");
                        ShortTip.open(22);
                     }
                     if(this.mosaicSlot.getProp(0) != -1)
                     {
                        this.sysGl(100,0);
                     }
                     break;
                  case 3:
                     if(pcPoint1[i][0] == 1)
                     {
                        myarr = [3];
                        if(bag.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(this.mosaicSlot.getProp(0) == -1)
                           {
                              this.strMove.bagGemMoveToStr(1,targetMc,myarr,this.mosaicSlot,bag);
                              this.gemUpdate();
                              this.mosaicSlotUpdate();
                           }
                           else if(this.mosaicSlot.getProp(0).getDressLevel() >= bag.getGemFromBag(targetMc.id).getUseLevel())
                           {
                              this.strMove.bagGemMoveToStr(1,targetMc,myarr,this.mosaicSlot,bag);
                              this.gemUpdate();
                              this.mosaicSlotUpdate();
                           }
                           else
                           {
                              ShortTip.open(22);
                              trace("等级不符合");
                           }
                        }
                        else
                        {
                           ShortTip.open(4);
                        }
                     }
               }
            }
         }
         if(this.synthesisState == 3)
         {
            for(i = 0; i < 2; i++)
            {
               if(!(targetX >= pcPointwk[i][1] && targetX <= pcPointwk[i][1] + pc2_0.width && (targetY >= pcPointwk[i][2] && targetY <= pcPointwk[i][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(this.bagState)
               {
                  case 1:
                     if(bag.backGemBagNum() > 0)
                     {
                        if(bag.getEquipFromBag(targetMc.id).getGrid() == 0)
                        {
                           this.strMove.equipMoveTostrenthen(pcPointwk[i][0],targetMc.id,this.deteleSlot,bag);
                           this.equipUpdate();
                           this.deleteSlotUpdate();
                        }
                        else
                        {
                           trace("装备已挖空或无孔");
                           ShortTip.open(2);
                        }
                        if(this.deteleSlot.getProp(0) != -1)
                        {
                           if(this.deteleSlot.getProp(0).getGemSlot() != null)
                           {
                              this.deleteProbability.setValue(this.strMove.getEquipOuitGem(this.deteleSlot.getProp(0).getGemSlot()));
                              this.sysGl(this.deleteProbability.getValue(),this.luckGemProbaprobability2.getValue());
                           }
                        }
                     }
                     else
                     {
                        trace("请清空背包");
                        ShortTip.open(3);
                     }
                     break;
                  case 3:
                     if(pcPointwk[i][0] == 1)
                     {
                        myarr = [2];
                        if(bag.getGemFromBag(targetMc.id).getType() == 2)
                        {
                           this.strMove.bagGemMoveToStr(1,targetMc,myarr,this.deteleSlot,bag);
                           this.gemUpdate();
                           this.deleteSlotUpdate();
                           if(this.deteleSlot.getProp(1) != -1)
                           {
                              this.luckGemProbaprobability2.setValue(this.strMove.getLuckGemPosition(this.deteleSlot.getProp(1)));
                              this.sysGl(this.deleteProbability.getValue(),this.luckGemProbaprobability2.getValue());
                           }
                        }
                        else
                        {
                           trace("类型不同");
                           ShortTip.open(4);
                        }
                     }
               }
            }
         }
      }
      
      private function strenthenGl(p1:Number, p2:Number) : void
      {
         var num:Number = p1 + p2;
         this.probability.setValue(num);
         if(this.probability.getValue() >= 100)
         {
            this.probability.setValue(100);
         }
         if(this.probability.getValue() <= 0)
         {
            this.probability.setValue(0);
         }
         if(this.probability.getValue() <= 0)
         {
            strengEquipText.text = "";
         }
         else
         {
            strengEquipText.text = this.probability.getValue().toString() + "%";
         }
      }
      
      private function sysGl(p1:Number, p2:Number) : *
      {
         var num:Number = p1 + p2;
         this.sysProbability.setValue(num);
         if(this.sysProbability.getValue() >= 100)
         {
            this.sysProbability.setValue(100);
         }
         if(this.sysProbability.getValue() <= 0)
         {
            this.sysProbability.setValue(0);
         }
         if(this.sysProbability.getValue() <= 0)
         {
            syspText.text = "";
         }
         else
         {
            syspText.text = this.sysProbability.getValue().toString() + "%";
         }
      }
      
      private function closeStrengGl() : void
      {
         this.equipProbability.setValue(0);
         this.skillProbability.setValue(0);
         this.luckGemProbaprobability.setValue(0);
         this.probability.setValue(0);
         strengEquipText.text = "";
      }
      
      private function closeSysGl() : void
      {
         this.deleteProbability.setValue(0);
         this.luckGemProbaprobability2.setValue(0);
         this.sysProbability.setValue(0);
         syspText.text = "";
      }
      
      private function strengthenEquipOne(pointSlot:Number, bag:Bag) : void
      {
         var gem:Gem = null;
         var equip:Equip = null;
         if(this.slot.getProp(1) == -1)
         {
            this.strMove.equipMoveTostrenthen(pointSlot,targetMc.id,this.slot,bag);
            this.soltUpdate();
            this.equipUpdate();
         }
         else
         {
            gem = this.slot.getProp(1);
            equip = bag.getEquipFromBag(targetMc.id);
            if(equip.getReinforceLevel() < gem.getUseLevel())
            {
               this.strMove.equipMoveTostrenthen(pointSlot,targetMc.id,this.slot,bag);
               this.soltUpdate();
               this.equipUpdate();
               this.equipProbability.setValue(this.strMove.getEquipUpLevel(this.slot.getProp(0),gem));
               this.strenthenGl(this.equipProbability.getValue(),this.luckGemProbaprobability.getValue());
            }
            else
            {
               trace("宝石使用等级不符合当前武器");
               ShortTip.open(24);
            }
         }
      }
      
      private function strengthenEquipTow(pointSlot:Number, typeArr:Array, bag:Bag) : void
      {
         var equip:Equip = null;
         var gem:Gem = null;
         if(this.slot.getProp(0) == -1)
         {
            this.strMove.bagGemMoveToStr(pointSlot,targetMc,typeArr,this.slot,bag);
            this.soltUpdate();
            this.gemUpdate();
         }
         else
         {
            equip = this.slot.getProp(0);
            gem = bag.getGemFromBag(targetMc.id);
            if(gem.getType() == 1)
            {
               if(equip.getReinforceLevel() < gem.getUseLevel())
               {
                  this.strMove.bagGemMoveToStr(pointSlot,targetMc,typeArr,this.slot,bag);
                  this.soltUpdate();
                  this.gemUpdate();
                  this.equipProbability.setValue(this.strMove.getEquipUpLevel(equip,this.slot.getProp(1)));
                  this.strenthenGl(this.equipProbability.getValue(),this.luckGemProbaprobability.getValue());
               }
               else
               {
                  trace("宝石使用等级不符合当前武器");
                  ShortTip.open(24);
               }
            }
            else
            {
               this.strMove.bagGemMoveToStr(pointSlot,targetMc,typeArr,this.slot,bag);
               this.soltUpdate();
               this.gemUpdate();
            }
         }
      }
      
      private function bagMoveToStrengthenLan(pcPoint:Array, _bag:Bag) : void
      {
         var targetX:int = mouseX;
         var targetY:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         var bag:Bag = _bag as Bag;
         var myarr:Array = [];
         for(var i:uint = 0; i < 3; i++)
         {
            if(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height))
            {
               if(this.strengState == 1)
               {
                  switch(this.bagState)
                  {
                     case 1:
                        if(pcPoint[i][0] == 0)
                        {
                           if(bag.getEquipFromBag(targetMc.id).getDressLevel() < 50)
                           {
                              if(bag.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 this.strengthenEquipOne(0,bag);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(bag.getEquipFromBag(targetMc.id).getColor() == 1 || bag.getEquipFromBag(targetMc.id).getColor() == 2)
                           {
                              if(bag.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 this.strengthenEquipOne(0,bag);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(bag.getEquipFromBag(targetMc.id).getReinforceLevel() < 10)
                           {
                              this.strengthenEquipOne(0,bag);
                           }
                           else
                           {
                              trace("强化等级满");
                              ShortTip.open(5);
                           }
                        }
                        break;
                     case 3:
                        if(pcPoint[i][0] == 1)
                        {
                           myarr = [1];
                           if(bag.backGemBagNum() > 0)
                           {
                              if(bag.getGemFromBag(targetMc.id).getType() == 1)
                              {
                                 this.strengthenEquipTow(1,myarr,bag);
                              }
                              else
                              {
                                 ShortTip.open(4);
                              }
                           }
                           else
                           {
                              ShortTip.open(3);
                           }
                        }
                        if(pcPoint[i][0] == 2)
                        {
                           myarr = [2];
                           if(bag.backGemBagNum() > 0)
                           {
                              if(bag.getGemFromBag(targetMc.id).getType() == 2)
                              {
                                 this.strengthenEquipTow(2,myarr,bag);
                                 if(this.slot.getType(2) == 2)
                                 {
                                    this.luckGemProbaprobability.setValue(this.strMove.getLuckGemPosition(this.slot.getProp(2)));
                                    this.strenthenGl(this.equipProbability.getValue(),this.luckGemProbaprobability.getValue());
                                 }
                              }
                              else
                              {
                                 ShortTip.open(4);
                              }
                           }
                           else
                           {
                              ShortTip.open(3);
                           }
                        }
                  }
               }
               if(this.strengState == 2)
               {
                  if(this.bagState == 3)
                  {
                     if(pcPoint[i][0] == 0)
                     {
                        myarr = [4];
                        if(bag.backGemBagNum() > 0)
                        {
                           if(bag.getGemFromBag(targetMc.id).getType() == 4)
                           {
                              if(bag.getGemFromBag(targetMc.id).getStrengthenLevel() < 4)
                              {
                                 this.strMove.bagGemMoveToStr(0,targetMc,myarr,this.skillSlot,bag);
                                 this.skillSoltUpdate();
                                 this.gemUpdate();
                                 if(this.skillSlot.getType(0) == 4)
                                 {
                                    this.skillProbability.setValue(this.strMove.getGemUpLevel(this.skillSlot.getProp(0)));
                                    this.strenthenGl(this.skillProbability.getValue(),this.luckGemProbaprobability.getValue());
                                 }
                              }
                              else
                              {
                                 trace("强化等级已满");
                                 ShortTip.open(5);
                              }
                           }
                           else
                           {
                              ShortTip.open(4);
                           }
                        }
                        else
                        {
                           ShortTip.open(3);
                        }
                     }
                     if(pcPoint[i][0] == 1)
                     {
                        myarr = [0];
                        if(bag.backGemBagNum() > 0)
                        {
                           if(bag.getGemFromBag(targetMc.id).getType() == 0)
                           {
                              this.strMove.bagGemMoveToStr(1,targetMc,myarr,this.skillSlot,bag);
                              this.skillSoltUpdate();
                              this.gemUpdate();
                           }
                           else
                           {
                              ShortTip.open(4);
                           }
                        }
                        else
                        {
                           ShortTip.open(3);
                        }
                     }
                     if(pcPoint[i][0] == 2)
                     {
                        myarr = [2];
                        if(bag.backGemBagNum() > 0)
                        {
                           if(bag.getGemFromBag(targetMc.id).getType() == 2)
                           {
                              this.strMove.bagGemMoveToStr(2,targetMc,myarr,this.skillSlot,bag);
                              this.skillSoltUpdate();
                              this.gemUpdate();
                              if(this.skillSlot.getType(2) == 2)
                              {
                                 this.luckGemProbaprobability.setValue(this.strMove.getLuckGemPosition(this.skillSlot.getProp(2)));
                                 this.strenthenGl(this.skillProbability.getValue(),this.luckGemProbaprobability.getValue());
                              }
                           }
                           else
                           {
                              ShortTip.open(4);
                           }
                        }
                        else
                        {
                           ShortTip.open(3);
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function bagMoveInit(pcPoint:Array, bag:Bag) : void
      {
         var targetX:int = targetMc.x + targetMc.width / 2;
         var targetY:int = targetMc.y + targetMc.height / 2;
         targetMc.x = oldX;
         targetMc.y = oldY;
         for(var i:uint = 0; i < 24; i++)
         {
            if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
            {
               continue;
            }
            switch(this.bagState)
            {
               case 1:
                  bag.equipBagMove(targetMc.id,pcPoint[i][0]);
                  this.equipUpdate();
                  break;
               case 2:
                  bag.suppliesBagMove(targetMc.id,pcPoint[i][0]);
                  this.supUpdate();
                  break;
               case 3:
                  bag.gemBagMove(targetMc.id,pcPoint[i][0]);
                  this.gemUpdate();
                  break;
               case 4:
                  bag.otherobjBagMove(targetMc.id,pcPoint[i][0]);
                  this.otherUpdate();
                  break;
               case 5:
                  bag.questBagMove(targetMc.id,pcPoint[i][0]);
                  this.taskUpdate();
            }
         }
      }
      
      private function strToBagSty() : void
      {
         if(!this.playerState)
         {
            if(this.slot.getProp(0) != -1)
            {
               this.strMove.equipMoveToBag(this.slot.getProp(0),this.slot,this.bag1);
               this.slot.addToSlot(-1,0);
            }
            if(this.slot.getProp(1) != -1)
            {
               this.strMove.gemBackToBag(this.slot.getProp(1),this.bag1,this.slot,1);
            }
            if(this.slot.getProp(2) != -1)
            {
               this.strMove.gemBackToBag(this.slot.getProp(2),this.bag1,this.slot,2);
            }
         }
         else
         {
            if(this.slot.getProp(0) != -1)
            {
               this.strMove.equipMoveToBag(this.slot.getProp(0),this.slot,this.bag2);
               this.slot.addToSlot(-1,0);
            }
            if(this.slot.getProp(1) != -1)
            {
               this.strMove.gemBackToBag(this.slot.getProp(1),this.bag2,this.slot,1);
            }
            if(this.slot.getProp(2) != -1)
            {
               this.strMove.gemBackToBag(this.slot.getProp(2),this.bag2,this.slot,2);
            }
         }
      }
      
      private function synthesisToBagSty() : void
      {
         var i:uint = 0;
         var ob:Otherobj = null;
         var ob2:Otherobj = null;
         this.synthesisSlotArr = this.synthesisSlot.slotArr();
         if(!this.playerState)
         {
            for(i = 0; i < 2; i++)
            {
               if(this.synthesisSlotArr[i] != -1)
               {
                  this.strMove.gemBackToBag(this.synthesisSlotArr[i],this.bag1,this.synthesisSlot,i);
               }
            }
            if(this.synthesisSlot.getProp(2) != -1)
            {
               ob = this.synthesisSlot.getProp(2);
               this.synthesisSlot.delSlot(2);
               this.bag1.addOtherobjBag(ob);
            }
         }
         else
         {
            for(i = 0; i < 2; i++)
            {
               if(this.synthesisSlotArr[i] != -1)
               {
                  this.strMove.gemBackToBag(this.synthesisSlotArr[i],this.bag2,this.synthesisSlot,i);
               }
            }
            if(this.synthesisSlot.getProp(2) != -1)
            {
               ob2 = this.synthesisSlot.getProp(2);
               this.synthesisSlot.delSlot(2);
               this.bag2.addOtherobjBag(ob2);
            }
         }
      }
      
      private function mosToBagSty() : void
      {
         if(!this.playerState)
         {
            if(this.mosaicSlot.getProp(0) != -1)
            {
               this.strMove.equipMoveToBag(this.mosaicSlot.getProp(0),this.mosaicSlot,this.bag1);
            }
            if(this.mosaicSlot.getProp(1) != -1)
            {
               this.strMove.gemBackToBag(this.mosaicSlot.getProp(1),this.bag1,this.mosaicSlot,1);
            }
         }
         else
         {
            if(this.mosaicSlot.getProp(0) != -1)
            {
               this.strMove.equipMoveToBag(this.mosaicSlot.getProp(0),this.mosaicSlot,this.bag2);
            }
            if(this.mosaicSlot.getProp(1) != -1)
            {
               this.strMove.gemBackToBag(this.mosaicSlot.getProp(1),this.bag2,this.mosaicSlot,1);
            }
         }
      }
      
      private function deleteToBagSty() : void
      {
         if(!this.playerState)
         {
            if(this.deteleSlot.getProp(0) != -1)
            {
               this.strMove.equipMoveToBag(this.deteleSlot.getProp(0),this.deteleSlot,this.bag1);
            }
            if(this.deteleSlot.getProp(1) != -1)
            {
               this.strMove.gemBackToBag(this.deteleSlot.getProp(1),this.bag1,this.deteleSlot,1);
            }
         }
         else
         {
            if(this.deteleSlot.getProp(0) != -1)
            {
               this.strMove.equipMoveToBag(this.deteleSlot.getProp(0),this.deteleSlot,this.bag2);
               this.deleteSlotUpdate();
               this.equipUpdate();
            }
            if(this.deteleSlot.getProp(1) != -1)
            {
               this.strMove.gemBackToBag(this.deteleSlot.getProp(1),this.bag2,this.deteleSlot,1);
            }
         }
      }
      
      private function strGemToBagSty() : void
      {
         var i:uint = 0;
         this.skillSlotArr = this.skillSlot.slotArr();
         if(!this.playerState)
         {
            for(i = 0; i < 3; i++)
            {
               if(this.skillSlotArr[i] != -1)
               {
                  this.strMove.gemBackToBag(this.skillSlotArr[i],this.bag1,this.skillSlot,i);
               }
            }
         }
         else
         {
            for(i = 0; i < 3; i++)
            {
               if(this.skillSlotArr[i] != -1)
               {
                  this.strMove.gemBackToBag(this.skillSlotArr[i],this.bag2,this.skillSlot,i);
               }
            }
         }
      }
      
      private function synpoint1() : void
      {
         for(var i:uint = 0; i < 2; i++)
         {
            this.mosaicPointArr[i] = [i,this["hcc_" + i].x,this["hcc_" + i].y];
         }
      }
      
      private function synpoint2() : void
      {
         for(var i:uint = 0; i < 2; i++)
         {
            this.deletePointArr[i] = [i,this["hcc_" + i].x,this["hcc_" + i].y];
         }
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         switch(e.id)
         {
            case 11:
               this.beginStrengthen();
               break;
            case 12:
               this.beginSynthesis();
               break;
            case 13:
               help.visible = true;
               break;
            case 14:
               help.gotoAndStop(1);
               break;
            case 15:
               help.gotoAndStop(3);
               break;
            case 16:
               help.gotoAndStop(4);
               break;
            case 17:
               help.gotoAndStop(5);
               break;
            case 18:
               help.visible = false;
               break;
            case 19:
               help.gotoAndStop(2);
         }
      }
      
      private function btnGlinit() : void
      {
         for(var i:uint = 1; i <= 4; i++)
         {
            this["p1_" + i].isClick = false;
            this["p2_" + i].isClick = false;
         }
      }
      
      private function btnIsClick(num:Number) : void
      {
         var i:uint = 0;
         if(!this.playerState)
         {
            for(i = 1; i <= 4; i++)
            {
               this["p1_" + i].isClick = false;
            }
            this["p1_" + num].isClick = true;
         }
         else
         {
            for(i = 1; i <= 4; i++)
            {
               this["p2_" + i].isClick = false;
            }
            this["p2_" + num].isClick = true;
         }
      }
      
      private function changHandle(e:BtnEvent) : void
      {
         var nameStr:* = e.target.name.substr(1,1);
         this.bagState = e.id;
         switch(e.id)
         {
            case 1:
               this.btnIsClick(1);
               this.equipUpdate();
               break;
            case 2:
               this.btnIsClick(2);
               this.supUpdate();
               break;
            case 3:
               this.btnIsClick(3);
               this.gemUpdate();
               break;
            case 4:
               this.btnIsClick(4);
               this.otherUpdate();
               break;
            case 5:
               this.btnIsClick(5);
               this.taskUpdate();
         }
         if(this.okMove)
         {
            if(e.id == 6)
            {
               this.strengState = 1;
               this.bagState = 1;
               textMc.gotoAndStop(1);
               str_tow.isClick = false;
               this.closeStrengGl();
               this.btnIsClick(1);
               this.strGemToBagSty();
               this.soltUpdate();
               this.equipUpdate();
               this.skillProbability.setValue(0);
            }
            if(e.id == 7)
            {
               this.strengState = 2;
               this.bagState = 3;
               textMc.gotoAndStop(2);
               str_one.isClick = false;
               this.closeStrengGl();
               this.btnIsClick(3);
               this.strToBagSty();
               this.skillSoltUpdate();
               this.gemUpdate();
               this.equipProbability.setValue(0);
            }
         }
         if(this.okMove1)
         {
            if(e.id == 8)
            {
               this.synthesisState = 1;
               this.bagState = 3;
               this.hc_2.visible = true;
               this.hcc_2.visible = true;
               this.x3_mc.visible = true;
               this.hc_0.x = 56.15;
               this.hcc_0.x = 53.7;
               this.x1_mc.x = 50.35;
               this.hc_1.x = 132.15;
               this.hcc_1.x = 129.7;
               this.x2_mc.x = 126.35;
               this.syn_mc.gotoAndStop(1);
               this.syn_mc.hc.h2.gotoAndStop(1);
               sys_tow.isClick = false;
               sys_three.isClick = false;
               this.closeSysGl();
               this.btnIsClick(3);
               this.mosToBagSty();
               this.deleteToBagSty();
               this.gemUpdate();
               this.sysSlotUpdate();
            }
            if(e.id == 9)
            {
               this.synthesisState = 2;
               this.bagState = 1;
               this.hc_2.visible = false;
               this.hcc_2.visible = false;
               this.x3_mc.visible = false;
               this.hc_0.x = 72;
               this.hcc_0.x = 70;
               this.x1_mc.x = 66.82;
               this.hc_1.x = 184;
               this.hcc_1.x = 182;
               this.x2_mc.x = 178.5;
               this.syn_mc.gotoAndStop(2);
               this.syn_mc.hc.h2.gotoAndStop(2);
               sys_three.isClick = false;
               sys_one.isClick = false;
               this.synpoint1();
               this.closeSysGl();
               this.btnIsClick(1);
               this.synthesisToBagSty();
               this.mosaicSlotUpdate();
               this.deleteToBagSty();
               this.equipUpdate();
            }
            if(e.id == 10)
            {
               this.synthesisState = 3;
               this.bagState = 1;
               this.hc_2.visible = false;
               this.hcc_2.visible = false;
               this.x3_mc.visible = false;
               this.hc_0.x = 72;
               this.hcc_0.x = 70;
               this.x1_mc.x = 66.82;
               this.hc_1.x = 184;
               this.hcc_1.x = 182;
               this.x2_mc.x = 178.5;
               this.syn_mc.gotoAndStop(3);
               this.syn_mc.hc.h2.gotoAndStop(3);
               sys_tow.isClick = false;
               sys_one.isClick = false;
               this.synpoint2();
               this.closeSysGl();
               this.btnIsClick(1);
               this.synthesisToBagSty();
               this.mosToBagSty();
               this.deleteSlotUpdate();
               this.equipUpdate();
            }
         }
      }
      
      private function beginSynthesis() : void
      {
         switch(this.synthesisState)
         {
            case 1:
               this.synthesisCondition();
               break;
            case 2:
               this.mosCondition();
               break;
            case 3:
               this.deCondition();
         }
      }
      
      private function beginStrengthen() : void
      {
         switch(this.strengState)
         {
            case 1:
               this.strengthenEquipCondition();
               break;
            case 2:
               this.strengthenGemCondition();
         }
      }
      
      private function deCondition() : void
      {
         if(this.deteleSlot.getProp(0) != -1)
         {
            closeMast.visible = true;
            this.typeNum = 2;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(1);
               this.goldSf(this.strMove.getDeleteGold(this.deteleSlot.getProp(0)));
               this.oldgold = this.strMove.getDeleteGold(this.deteleSlot.getProp(0));
            }
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      private function mosCondition() : void
      {
         if(this.mosaicSlot.getProp(0) != -1 && this.mosaicSlot.getProp(1) != -1)
         {
            closeMast.visible = true;
            this.typeNum = 2;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(3);
               this.goldSf(this.strMove.getMosicGold(this.mosaicSlot.getProp(0),this.mosaicSlot.getProp(1)));
               this.oldgold = this.strMove.getMosicGold(this.mosaicSlot.getProp(0),this.mosaicSlot.getProp(1));
               trace("镶嵌用的金币:" + this.oldgold);
            }
         }
         else
         {
            trace("放入必备物品");
            ShortTip.open(6);
         }
      }
      
      private function synthesisCondition() : void
      {
         if(this.synthesisSlot.getProp(0) != -1 && this.synthesisSlot.getProp(1) != -1 && this.synthesisSlot.getProp(2) != -1)
         {
            closeMast.visible = true;
            this.timesSys = 0;
            this.okMove1 = false;
            this.timerSys.start();
            s3_mc.gotoAndPlay(2);
            s4_mc.gotoAndPlay(2);
            this.removeClick();
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      private function strengthenGemCondition() : void
      {
         if(this.skillSlot.getProp(0) != -1 && this.skillSlot.getProp(1) != -1)
         {
            closeMast.visible = true;
            this.typeNum = 1;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(2);
               this.goldSf(this.strMove.getGemUpGold(this.skillSlot.getProp(0)));
               this.oldgold = this.strMove.getGemUpGold(this.skillSlot.getProp(0));
            }
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      private function strengthenEquipCondition() : void
      {
         if(this.slot.getProp(0) != -1 && this.slot.getProp(1) != -1)
         {
            this.typeNum = 1;
            closeMast.visible = true;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(2);
               this.goldSf(this.strMove.getStrenthenGold(this.slot.getProp(0)));
               this.oldgold = this.strMove.getStrenthenGold(this.slot.getProp(0));
            }
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      private function goldSf(goldNum:Number) : void
      {
         var gold:Number = int(goldNum);
         trace("面板显示的金币:" + gold);
         var goldStr:String = gold.toString();
         for(var j:uint = 0; j < 5; j++)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + j].visible = false;
            }
         }
         for(var i:int = 0; i < goldStr.length; i++)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + i].visible = true;
               if(goldStr.charAt(i) != "0")
               {
                  this.gold_mc.num_mc["num_" + i].gotoAndStop(goldStr.charAt(i));
               }
               else
               {
                  this.gold_mc.num_mc["num_" + i].gotoAndStop(10);
               }
            }
         }
      }
      
      private function onTimerSys(e:TimerEvent) : void
      {
         ++this.timesSys;
         an1.visible = true;
         an2.visible = true;
         if(this.timesSys == this.stopTime)
         {
            an1.visible = false;
            an2.visible = false;
            this.timesSys = 0;
            this.timerSys.stop();
            s3_mc.gotoAndStop(1);
            s4_mc.gotoAndStop(1);
            this.okMove1 = true;
            this.addClick();
            if(this.synthesisState == 1)
            {
               this.bagState = 3;
               this.btnIsClick(3);
               if(!this.playerState)
               {
                  this.strMove.strengthenHcOver(this.sysProbability.getValue(),this.synthesisSlot,this.bag1,prompt,this.ptSlot,closeMast);
               }
               else
               {
                  this.strMove.strengthenHcOver(this.sysProbability.getValue(),this.synthesisSlot,this.bag2,prompt,this.ptSlot,closeMast);
               }
               this.sysSlotUpdate();
               this.gemUpdate();
               this.closeSysGl();
            }
            if(this.synthesisState == 2)
            {
               this.bagState = 1;
               this.btnIsClick(1);
               this.strMove.strengthenXqOver(this.sysProbability.getValue(),this.mosaicSlot,prompt,this.ptSlot,closeMast);
               this.strMove.strengThenOverMoveEquip(this.playerState,this.mosaicSlot,this.bag1,this.bag2);
               this.mosaicSlotUpdate();
               this.equipUpdate();
               this.closeSysGl();
            }
            if(this.synthesisState == 3)
            {
               this.bagState = 1;
               this.btnIsClick(1);
               if(!this.playerState)
               {
                  this.strMove.strengthenWkOver(this.sysProbability.getValue(),this.deteleSlot,this.bag1,prompt,this.ptSlot,closeMast);
               }
               else
               {
                  this.strMove.strengthenWkOver(this.sysProbability.getValue(),this.deteleSlot,this.bag2,prompt,this.ptSlot,closeMast);
               }
               this.deleteSlotUpdate();
               this.equipUpdate();
               this.closeSysGl();
               Main.Save();
            }
         }
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         ++this.times;
         an1.visible = true;
         an2.visible = true;
         if(this.times == this.stopTime)
         {
            an1.visible = false;
            an2.visible = false;
            this.times = 0;
            this.timer.stop();
            this.okMove = true;
            s1_mc.gotoAndStop(1);
            s2_mc.gotoAndStop(1);
            this.addClick();
            if(this.strengState == 1)
            {
               this.equipProbability.setValue(0);
               this.bagState = 1;
               this.btnIsClick(1);
               this.strMove.strengthenOver(this.probability.getValue(),this.slot.getProp(0),this.slot.getProp(1),this.slot,prompt,this.ptSlot,closeMast);
               this.strMove.strengThenOverMoveEquip(this.playerState,this.slot,this.bag1,this.bag2);
               this.soltUpdate();
               this.equipUpdate();
               this.closeStrengGl();
            }
            if(this.strengState == 2)
            {
               this.skillProbability.setValue(0);
               this.bagState = 3;
               this.btnIsClick(3);
               if(this.playerState)
               {
                  this.strMove.strengthenSkillOver(this.probability.getValue(),this.skillSlot,this.bag2,prompt,this.ptSlot,closeMast);
               }
               else
               {
                  this.strMove.strengthenSkillOver(this.probability.getValue(),this.skillSlot,this.bag1,prompt,this.ptSlot,closeMast);
               }
               this.skillSoltUpdate();
               this.gemUpdate();
               this.closeStrengGl();
            }
            Main.Save();
         }
      }
      
      private function removeClick() : void
      {
         this.removeEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,this.daojuMessageOver);
         this.removeEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,this.daojuMessageOut);
         this.removeEventListener(DaoJuEvent.DAOJU_DOWN_MESSAGE,this.daojuMessageDown);
         this.removeEventListener(DaoJuEvent.DAOJU_UP_MESSAGE,this.daojuMessageUp);
      }
      
      private function addClick() : void
      {
         this.addEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,this.daojuMessageOver);
         this.addEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,this.daojuMessageOut);
         this.addEventListener(DaoJuEvent.DAOJU_DOWN_MESSAGE,this.daojuMessageDown);
         this.addEventListener(DaoJuEvent.DAOJU_UP_MESSAGE,this.daojuMessageUp);
      }
      
      private function noInitPtow() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            this["d2_" + i].visible = false;
            p2Gold.text = "";
         }
      }
      
      private function noInitPone() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            this["d1_" + i].visible = false;
            p1Gold.text = "";
         }
      }
      
      private function strengthenBagCao() : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            this.pcOnePointArr[i] = [i,this["pc1_" + i].x,this["pc1_" + i].y];
            this.pcTowPointArr[i] = [i,this["pc2_" + i].x,this["pc2_" + i].y];
         }
      }
      
      private function strengthenLanCao() : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            this.strengLanPointArr[i] = [i,this["qhc_" + i].x,this["qhc_" + i].y];
            this.synthesisPointArr[i] = [i,this["hcc_" + i].x,this["hcc_" + i].y];
         }
      }
      
      private function pointY(mc:MovieClip) : void
      {
         var myPoint:Point = new Point(mc.x,mc.y);
         myPoint = this.localToGlobal(myPoint);
         if(myPoint.y + mc.height > 580)
         {
            mc.y = 580 - mc.height - 80;
         }
         if(myPoint.y < 0)
         {
            mc.y = 0;
         }
      }
   }
}

class PrivateClass
{
   
   public function PrivateClass()
   {
      super();
   }
}
