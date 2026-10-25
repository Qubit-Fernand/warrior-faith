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
      
      public function StrengthenPanel(param1:PrivateClass)
      {
         super();
      }
      
      public static function open(param1:Number = 1) : void
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
         StrengthenPanel._instance.initAllBag(param1);
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
      
      public static function loseFocus(param1:Event = null) : void
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
         var _loc1_:Number = Main._stage.stageWidth / 2;
         var _loc2_:Number = Main._stage.stageHeight / 2;
         this.x = _loc1_ - this.width / 2;
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
      
      private function initAllBag(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            this.playerState = false;
         }
         else if(param1 == 2)
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
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            this["d1_" + _loc1_].stop();
            this["d2_" + _loc1_].stop();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this["qh_" + _loc1_].stop();
            this["qh_" + _loc1_].visible = false;
            this["hc_" + _loc1_].stop();
            this["hc_" + _loc1_].visible = false;
            _loc1_++;
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
         var _loc1_:uint = 0;
         if(!this.playerState)
         {
            this.playerEquipArr1 = this.bag1.getEquipBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.playerEquipArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(this.playerEquipArr1[_loc1_].getFrame());
                  this["d1_" + _loc1_].howNum.text = "";
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            this.playerEquipArr2 = this.bag2.getEquipBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.playerEquipArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(this.playerEquipArr2[_loc1_].getFrame());
                  this["d2_" + _loc1_].howNum.text = "";
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function gemUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!this.playerState)
         {
            this.playerGemArr1 = this.bag1.getGemBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.playerGemArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(this.playerGemArr1[_loc1_].getFrame());
                  this["d1_" + _loc1_].howNum.text = this.playerGemArr1[_loc1_].getTimes();
                  if(this.playerGemArr1[_loc1_].getTimes() <= 1)
                  {
                     this["d1_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            this.playerGemArr2 = this.bag2.getGemBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.playerGemArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(this.playerGemArr2[_loc1_].getFrame());
                  this["d2_" + _loc1_].howNum.text = this.playerGemArr2[_loc1_].getTimes();
                  if(this.playerGemArr2[_loc1_].getTimes() <= 1)
                  {
                     this["d2_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function supUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!this.playerState)
         {
            this.palyerSuppliesArr1 = this.bag1.getSuppliesBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.palyerSuppliesArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(this.palyerSuppliesArr1[_loc1_].getFrame());
                  this["d1_" + _loc1_].howNum.text = this.palyerSuppliesArr1[_loc1_].getTimes();
                  if(this.palyerSuppliesArr1[_loc1_].getTimes() <= 1)
                  {
                     this["d1_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            this.palyerSuppliesArr2 = this.bag2.getSuppliesBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.palyerSuppliesArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(this.palyerSuppliesArr2[_loc1_].getFrame());
                  this["d2_" + _loc1_].howNum.text = this.palyerSuppliesArr2[_loc1_].getTimes();
                  if(this.palyerSuppliesArr2[_loc1_].getTimes() <= 1)
                  {
                     this["d2_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function otherUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!this.playerState)
         {
            this.otherArr1 = this.bag1.getOtherobjBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.otherArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(this.otherArr1[_loc1_].getFrame());
                  this["d1_" + _loc1_].howNum.text = "";
                  this["d1_" + _loc1_].howNum.text = this.otherArr1[_loc1_].getTimes();
                  if(this.otherArr1[_loc1_].getTimes() <= 1)
                  {
                     this["d1_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            this.otherArr2 = this.bag2.getOtherobjBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.otherArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(this.otherArr2[_loc1_].getFrame());
                  this["d2_" + _loc1_].howNum.text = "";
                  this["d2_" + _loc1_].howNum.text = this.otherArr2[_loc1_].getTimes();
                  if(this.otherArr2[_loc1_].getTimes() <= 1)
                  {
                     this["d2_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function taskUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!this.playerState)
         {
            this.taskArr1 = this.bag1.getQuestBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.taskArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(this.taskArr1[_loc1_].getFrame());
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            this.taskArr2 = this.bag2.getQuestBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(this.taskArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(this.taskArr2[_loc1_].getFrame());
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function soltUpdate() : void
      {
         this.slotBagArr = this.slot.slotArr();
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            if(this.slotBagArr[_loc1_] != -1)
            {
               this["qh_" + _loc1_].visible = true;
               this["qh_" + _loc1_].howNum.text = "";
               this["qh_" + _loc1_].gotoAndStop(this.slotBagArr[_loc1_].getFrame());
               this["qhc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["qh_" + _loc1_].visible = false;
               this["qhc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      public function skillSoltUpdate() : void
      {
         this.skillSlotArr = this.skillSlot.slotArr();
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            if(this.skillSlotArr[_loc1_] != -1)
            {
               this["qh_" + _loc1_].visible = true;
               this["qh_" + _loc1_].howNum.text = "";
               this["qh_" + _loc1_].gotoAndStop(this.skillSlotArr[_loc1_].getFrame());
               this["qhc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["qh_" + _loc1_].visible = false;
               this["qhc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      public function sysSlotUpdate() : void
      {
         this.synthesisSlotArr = this.synthesisSlot.slotArr();
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            if(this.synthesisSlotArr[_loc1_] != -1)
            {
               this["hc_" + _loc1_].visible = true;
               this["hc_" + _loc1_].howNum.text = "";
               this["hc_" + _loc1_].gotoAndStop(this.synthesisSlotArr[_loc1_].getFrame());
               this["hcc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["hc_" + _loc1_].visible = false;
               this["hcc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      public function mosaicSlotUpdate() : void
      {
         this.mosaicSlotArr = this.mosaicSlot.slotArr();
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            if(this.mosaicSlotArr[_loc1_] != -1)
            {
               this["hc_" + _loc1_].visible = true;
               this["hc_" + _loc1_].howNum.text = "";
               this["hc_" + _loc1_].gotoAndStop(this.mosaicSlotArr[_loc1_].getFrame());
               this["hcc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["hc_" + _loc1_].visible = false;
               this["hcc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      public function deleteSlotUpdate() : void
      {
         this.deteleSlotArr = this.deteleSlot.slotArr();
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            if(this.deteleSlotArr[_loc1_] != -1)
            {
               this["hc_" + _loc1_].visible = true;
               this["hc_" + _loc1_].howNum.text = "";
               this["hc_" + _loc1_].gotoAndStop(this.deteleSlotArr[_loc1_].getFrame());
               this["hcc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["hc_" + _loc1_].visible = false;
               this["hcc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function outHandle(param1:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function overHandle(param1:BtnEvent) : void
      {
         var _loc2_:String = param1.target.name;
         tooltip.visible = true;
         if(_loc2_ == "prompt_1")
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
         if(_loc2_ == "prompt_2")
         {
            tooltip.gemTooltip(this.ptSlot.getProp(1),3);
         }
         tooltip.x = mouseX + 10;
         tooltip.y = mouseY;
         this.pointY(tooltip);
      }
      
      private function closeHandle(param1:BtnEvent) : void
      {
         var _loc2_:uint = uint(param1.target.id);
         var _loc3_:String = param1.target.parent.name;
         if(_loc3_ == "gold_mc")
         {
            if(_loc2_ == 1)
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
            if(_loc2_ == 2)
            {
               closeMast.visible = false;
               gold_mc.visible = false;
               this.closeData();
            }
         }
         else
         {
            if(_loc2_ == 3)
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
      
      private function daojuMessageOver(param1:DaoJuEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:String = _loc2_.name;
         var _loc4_:String = _loc3_.substr(1,1);
         var _loc5_:int = int(_loc3_.substr(3,2));
         switch(_loc4_)
         {
            case "1":
               if(this.bagState == 1)
               {
                  tooltip.equipTooltip(this.bag1.getEquipFromBag(_loc5_),3);
               }
               else if(this.bagState == 2)
               {
                  tooltip.suppliesTooltip(this.bag1.getSuppliesFromBag(_loc5_),3);
               }
               else if(this.bagState == 3)
               {
                  tooltip.gemTooltip(this.bag1.getGemFromBag(_loc5_),3);
               }
               else if(this.bagState == 4)
               {
                  tooltip.otherTooltip(this.bag1.getOtherobjFromBag(_loc5_));
               }
               break;
            case "2":
               if(this.bagState == 1)
               {
                  tooltip.equipTooltip(this.bag2.getEquipFromBag(_loc5_),3);
               }
               else if(this.bagState == 2)
               {
                  tooltip.suppliesTooltip(this.bag2.getSuppliesFromBag(_loc5_),3);
               }
               else if(this.bagState == 3)
               {
                  tooltip.gemTooltip(this.bag2.getGemFromBag(_loc5_),3);
               }
               else if(this.bagState == 4)
               {
                  tooltip.otherTooltip(this.bag2.getOtherobjFromBag(_loc5_));
               }
               break;
            case "h":
               if(this.strengState == 1)
               {
                  if(this.slot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.equipTooltip(this.slot.getProp(_loc5_),3);
                     }
                  }
                  if(this.slot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(this.slot.getProp(1),3);
                     }
                  }
                  if(this.slot.getProp(2) != -1)
                  {
                     if(_loc5_ == 2)
                     {
                        tooltip.gemTooltip(this.slot.getProp(2),3);
                     }
                  }
               }
               if(this.strengState == 2)
               {
                  if(this.skillSlot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.gemTooltip(this.skillSlot.getProp(_loc5_),3);
                     }
                  }
                  if(this.skillSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(this.skillSlot.getProp(_loc5_),3);
                     }
                  }
                  if(this.skillSlot.getProp(2) != -1)
                  {
                     if(_loc5_ == 2)
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
                     if(_loc5_ == 0)
                     {
                        tooltip.gemTooltip(this.synthesisSlot.getProp(_loc5_),3);
                     }
                  }
                  if(this.synthesisSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(this.synthesisSlot.getProp(_loc5_),3);
                     }
                  }
                  if(this.synthesisSlot.getProp(2) != -1)
                  {
                     if(_loc5_ == 2)
                     {
                        tooltip.otherTooltip(this.synthesisSlot.getProp(_loc5_));
                     }
                  }
               }
               if(this.synthesisState == 2)
               {
                  if(this.mosaicSlot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.equipTooltip(this.mosaicSlot.getProp(_loc5_),3);
                     }
                  }
                  if(this.mosaicSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(this.mosaicSlot.getProp(_loc5_),3);
                     }
                  }
               }
               if(this.synthesisState == 3)
               {
                  if(this.deteleSlot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.equipTooltip(this.deteleSlot.getProp(_loc5_),3);
                     }
                  }
                  if(this.deteleSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(this.deteleSlot.getProp(_loc5_),3);
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
      
      private function daojuMessageOut(param1:DaoJuEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function daojuMessageDown(param1:DaoJuEvent) : void
      {
         this.mouseuup = true;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:String = _loc2_.name;
         this.downName = _loc3_.substr(1,1);
         var _loc4_:Number = Number(_loc3_.substr(3,2));
         this.mouseDownBo = true;
         _loc2_.startDrag();
         tooltip.visible = false;
         targetMc = _loc2_;
         targetMc.id = _loc4_;
         oldX = _loc2_.x;
         oldY = _loc2_.y;
         _loc2_.x = mouseX - _loc2_.width / 2;
         _loc2_.y = mouseY - _loc2_.height / 2;
         childIndex = this.getChildIndex(_loc2_);
         this.addChildAt(_loc2_,numChildren - 2);
      }
      
      private function daojuMessageUp(param1:DaoJuEvent) : void
      {
         this.mouseuup = false;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:String = _loc2_.name;
         var _loc4_:String = _loc3_.substr(1,1);
         var _loc5_:int = int(_loc3_.substr(3,2));
         this.mouseDownBo = false;
         _loc2_.stopDrag();
         this.addChildAt(_loc2_,childIndex);
         if(!this.playerState)
         {
            if(_loc4_ == "1")
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
               if(_loc4_ == "h")
               {
                  this.strengthenLanMoveToBag(this.pcOnePointArr,this.bag1);
               }
               if(_loc4_ == "c")
               {
                  this.synthesisSlotLanMoveToBag(this.pcOnePointArr,this.bag1);
               }
            }
         }
         else if(_loc4_ == "2")
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
            if(_loc4_ == "h")
            {
               this.strengthenLanMoveToBag(this.pcTowPointArr,this.bag2);
            }
            if(_loc4_ == "c")
            {
               this.synthesisSlotLanMoveToBag(this.pcTowPointArr,this.bag2);
            }
         }
      }
      
      private function synthesisSlotLanMoveToBag(param1:Array, param2:Bag) : void
      {
         var _loc6_:Equip = null;
         var _loc7_:Equip = null;
         var _loc8_:Gem = null;
         var _loc9_:Gem = null;
         var _loc10_:Gem = null;
         var _loc3_:int = mouseX;
         var _loc4_:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         var _loc5_:uint = 0;
         for(; _loc5_ < 24; _loc5_++)
         {
            if(!(_loc3_ >= param1[_loc5_][1] && _loc3_ <= param1[_loc5_][1] + pc2_0.width && (_loc4_ >= param1[_loc5_][2] && _loc4_ <= param1[_loc5_][2] + pc2_0.height)))
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
                        _loc6_ = this.mosaicSlot.getProp(targetMc.id);
                        this.strMove.equipMoveToBag(_loc6_,this.mosaicSlot,param2,targetMc.id,param1[_loc5_][0]);
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
                        _loc7_ = this.deteleSlot.getProp(targetMc.id);
                        this.strMove.equipMoveToBag(_loc7_,this.deteleSlot,param2,targetMc.id,param1[_loc5_][0]);
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
                        _loc8_ = this.synthesisSlot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(_loc8_,param2,this.synthesisSlot,targetMc.id,param1[_loc5_][0]);
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
                        _loc9_ = this.mosaicSlot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(_loc9_,param2,this.mosaicSlot,targetMc.id,param1[_loc5_][0]);
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
                        _loc10_ = this.deteleSlot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(_loc10_,param2,this.deteleSlot,targetMc.id,param1[_loc5_][0]);
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
                  if(!param2.addToOtherobjBag(this.synthesisSlot.getProp(2),param1[_loc5_][0]))
                  {
                     param2.addOtherobjBag(this.synthesisSlot.getProp(2));
                  }
                  this.synthesisSlot.delSlot(2);
                  this.otherUpdate();
                  this.sysSlotUpdate();
            }
         }
      }
      
      private function strengthenLanMoveToBag(param1:Array, param2:Bag) : void
      {
         var _loc6_:Equip = null;
         var _loc7_:Gem = null;
         var _loc8_:Gem = null;
         var _loc3_:int = mouseX;
         var _loc4_:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         var _loc5_:uint = 0;
         for(; _loc5_ < 24; _loc5_++)
         {
            if(!(_loc3_ >= param1[_loc5_][1] && _loc3_ <= param1[_loc5_][1] + pc2_0.width && (_loc4_ >= param1[_loc5_][2] && _loc4_ <= param1[_loc5_][2] + pc2_0.height)))
            {
               continue;
            }
            switch(this.bagState)
            {
               case 1:
                  if(this.slot.getPropEquip(targetMc.id))
                  {
                     _loc6_ = this.slot.getProp(targetMc.id);
                     this.strMove.equipMoveToBag(_loc6_,this.slot,param2,targetMc.id,param1[_loc5_][0]);
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
                        _loc7_ = this.slot.getProp(targetMc.id);
                        this.strMove.gemBackToBag(_loc7_,param2,this.slot,targetMc.id,param1[_loc5_][0]);
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
                     _loc8_ = this.skillSlot.getProp(targetMc.id);
                     if(this.skillSlot.getPropGem(targetMc.id))
                     {
                        this.strMove.gemBackToBag(_loc8_,param2,this.skillSlot,targetMc.id,param1[_loc5_][0]);
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
      
      private function sysOne(param1:Number, param2:Number, param3:Array, param4:Bag) : void
      {
         var _loc5_:Gem = null;
         var _loc6_:Gem = null;
         if(this.synthesisSlot.getProp(param2) == -1)
         {
            this.strMove.bagGemMoveToStr(param1,targetMc,param3,this.synthesisSlot,param4);
            this.gemUpdate();
            this.sysSlotUpdate();
         }
         else
         {
            _loc5_ = this.synthesisSlot.getProp(param2);
            _loc6_ = param4.getGemFromBag(targetMc.id);
            if(_loc5_.getType() == _loc6_.getType())
            {
               if(_loc5_.getType() == 1)
               {
                  if(_loc5_.getUseLevel() == _loc6_.getUseLevel())
                  {
                     this.strMove.bagGemMoveToStr(param1,targetMc,param3,this.synthesisSlot,param4);
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
                  this.strMove.bagGemMoveToStr(param1,targetMc,param3,this.synthesisSlot,param4);
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
      
      private function bagMoveTosynthesisSlot(param1:Array, param2:Array, param3:Array, param4:Bag) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         var _loc5_:int = mouseX;
         var _loc6_:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         var _loc7_:Bag = param4;
         var _loc8_:Array = [];
         if(this.synthesisState == 1)
         {
            _loc11_ = 0;
            for(; _loc11_ < 3; _loc11_++)
            {
               if(!(_loc5_ >= param1[_loc11_][1] && _loc5_ <= param1[_loc11_][1] + pc2_0.width && (_loc6_ >= param1[_loc11_][2] && _loc6_ <= param1[_loc11_][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(this.bagState)
               {
                  case 3:
                     _loc8_ = [0,1,3];
                     if(_loc7_.backGemBagNum() > 0)
                     {
                        if(_loc7_.getGemFromBag(targetMc.id).getType() == 0 || _loc7_.getGemFromBag(targetMc.id).getType() == 1 || _loc7_.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(_loc7_.getGemFromBag(targetMc.id).getColor() == 1)
                           {
                              if(param1[_loc11_][0] == 0)
                              {
                                 this.sysOne(0,1,_loc8_,_loc7_);
                                 if(this.synthesisSlot.getProp(0) != -1)
                                 {
                                    this.sysGl(100,0);
                                 }
                              }
                              if(param1[_loc11_][0] == 1)
                              {
                                 _loc8_ = [0,1,3];
                                 this.sysOne(1,0,_loc8_,_loc7_);
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
                     if(param1[_loc11_][0] == 2)
                     {
                        if(_loc7_.getOtherobjFromBag(targetMc.id) is Otherobj && _loc7_.getOtherobjFromBag(targetMc.id).getType() == 1)
                        {
                           if(this.synthesisSlot.getProp(2) == -1)
                           {
                              this.synthesisSlot.addToSlot(_loc7_.delOtherobj(targetMc.id),2);
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
            _loc11_ = 0;
            for(; _loc11_ < 2; _loc11_++)
            {
               if(!(_loc5_ >= param2[_loc11_][1] && _loc5_ <= param2[_loc11_][1] + pc2_0.width && (_loc6_ >= param2[_loc11_][2] && _loc6_ <= param2[_loc11_][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(this.bagState)
               {
                  case 1:
                     if(this.mosaicSlot.getProp(1) == -1)
                     {
                        if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           this.strMove.equipMoveTostrenthen(param1[_loc11_][0],targetMc.id,this.mosaicSlot,_loc7_);
                           this.equipUpdate();
                           this.mosaicSlotUpdate();
                        }
                        else
                        {
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              trace("无法继续镶嵌");
                              ShortTip.open(8);
                           }
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == -1)
                           {
                              trace("没有孔");
                              ShortTip.open(7);
                           }
                        }
                     }
                     else if(_loc7_.getEquipFromBag(targetMc.id).getDressLevel() >= this.mosaicSlot.getProp(1).getUseLevel())
                     {
                        if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           this.strMove.equipMoveTostrenthen(param1[_loc11_][0],targetMc.id,this.mosaicSlot,_loc7_);
                           this.equipUpdate();
                           this.mosaicSlotUpdate();
                        }
                        else
                        {
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              ShortTip.open(8);
                              trace("无法继续镶嵌");
                           }
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == -1)
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
                     if(param2[_loc11_][0] == 1)
                     {
                        _loc8_ = [3];
                        if(_loc7_.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(this.mosaicSlot.getProp(0) == -1)
                           {
                              this.strMove.bagGemMoveToStr(1,targetMc,_loc8_,this.mosaicSlot,_loc7_);
                              this.gemUpdate();
                              this.mosaicSlotUpdate();
                           }
                           else if(this.mosaicSlot.getProp(0).getDressLevel() >= _loc7_.getGemFromBag(targetMc.id).getUseLevel())
                           {
                              this.strMove.bagGemMoveToStr(1,targetMc,_loc8_,this.mosaicSlot,_loc7_);
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
            _loc11_ = 0;
            for(; _loc11_ < 2; _loc11_++)
            {
               if(!(_loc5_ >= param3[_loc11_][1] && _loc5_ <= param3[_loc11_][1] + pc2_0.width && (_loc6_ >= param3[_loc11_][2] && _loc6_ <= param3[_loc11_][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(this.bagState)
               {
                  case 1:
                     if(_loc7_.backGemBagNum() > 0)
                     {
                        if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 0)
                        {
                           this.strMove.equipMoveTostrenthen(param3[_loc11_][0],targetMc.id,this.deteleSlot,_loc7_);
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
                     if(param3[_loc11_][0] == 1)
                     {
                        _loc8_ = [2];
                        if(_loc7_.getGemFromBag(targetMc.id).getType() == 2)
                        {
                           this.strMove.bagGemMoveToStr(1,targetMc,_loc8_,this.deteleSlot,_loc7_);
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
      
      private function strenthenGl(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 + param2;
         this.probability.setValue(_loc3_);
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
      
      private function sysGl(param1:Number, param2:Number) : *
      {
         var _loc3_:Number = param1 + param2;
         this.sysProbability.setValue(_loc3_);
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
      
      private function strengthenEquipOne(param1:Number, param2:Bag) : void
      {
         var _loc3_:Gem = null;
         var _loc4_:Equip = null;
         if(this.slot.getProp(1) == -1)
         {
            this.strMove.equipMoveTostrenthen(param1,targetMc.id,this.slot,param2);
            this.soltUpdate();
            this.equipUpdate();
         }
         else
         {
            _loc3_ = this.slot.getProp(1);
            _loc4_ = param2.getEquipFromBag(targetMc.id);
            if(_loc4_.getReinforceLevel() < _loc3_.getUseLevel())
            {
               this.strMove.equipMoveTostrenthen(param1,targetMc.id,this.slot,param2);
               this.soltUpdate();
               this.equipUpdate();
               this.equipProbability.setValue(this.strMove.getEquipUpLevel(this.slot.getProp(0),_loc3_));
               this.strenthenGl(this.equipProbability.getValue(),this.luckGemProbaprobability.getValue());
            }
            else
            {
               trace("宝石使用等级不符合当前武器");
               ShortTip.open(24);
            }
         }
      }
      
      private function strengthenEquipTow(param1:Number, param2:Array, param3:Bag) : void
      {
         var _loc4_:Equip = null;
         var _loc5_:Gem = null;
         if(this.slot.getProp(0) == -1)
         {
            this.strMove.bagGemMoveToStr(param1,targetMc,param2,this.slot,param3);
            this.soltUpdate();
            this.gemUpdate();
         }
         else
         {
            _loc4_ = this.slot.getProp(0);
            _loc5_ = param3.getGemFromBag(targetMc.id);
            if(_loc5_.getType() == 1)
            {
               if(_loc4_.getReinforceLevel() < _loc5_.getUseLevel())
               {
                  this.strMove.bagGemMoveToStr(param1,targetMc,param2,this.slot,param3);
                  this.soltUpdate();
                  this.gemUpdate();
                  this.equipProbability.setValue(this.strMove.getEquipUpLevel(_loc4_,this.slot.getProp(1)));
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
               this.strMove.bagGemMoveToStr(param1,targetMc,param2,this.slot,param3);
               this.soltUpdate();
               this.gemUpdate();
            }
         }
      }
      
      private function bagMoveToStrengthenLan(param1:Array, param2:Bag) : void
      {
         var _loc3_:int = mouseX;
         var _loc4_:int = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         var _loc5_:Bag = param2 as Bag;
         var _loc6_:Array = [];
         var _loc7_:uint = 0;
         while(_loc7_ < 3)
         {
            if(_loc3_ >= param1[_loc7_][1] && _loc3_ <= param1[_loc7_][1] + pc2_0.width && (_loc4_ >= param1[_loc7_][2] && _loc4_ <= param1[_loc7_][2] + pc2_0.height))
            {
               if(this.strengState == 1)
               {
                  switch(this.bagState)
                  {
                     case 1:
                        if(param1[_loc7_][0] == 0)
                        {
                           if(_loc5_.getEquipFromBag(targetMc.id).getDressLevel() < 50)
                           {
                              if(_loc5_.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 this.strengthenEquipOne(0,_loc5_);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(_loc5_.getEquipFromBag(targetMc.id).getColor() == 1 || _loc5_.getEquipFromBag(targetMc.id).getColor() == 2)
                           {
                              if(_loc5_.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 this.strengthenEquipOne(0,_loc5_);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(_loc5_.getEquipFromBag(targetMc.id).getReinforceLevel() < 10)
                           {
                              this.strengthenEquipOne(0,_loc5_);
                           }
                           else
                           {
                              trace("强化等级满");
                              ShortTip.open(5);
                           }
                        }
                        break;
                     case 3:
                        if(param1[_loc7_][0] == 1)
                        {
                           _loc6_ = [1];
                           if(_loc5_.backGemBagNum() > 0)
                           {
                              if(_loc5_.getGemFromBag(targetMc.id).getType() == 1)
                              {
                                 this.strengthenEquipTow(1,_loc6_,_loc5_);
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
                        if(param1[_loc7_][0] == 2)
                        {
                           _loc6_ = [2];
                           if(_loc5_.backGemBagNum() > 0)
                           {
                              if(_loc5_.getGemFromBag(targetMc.id).getType() == 2)
                              {
                                 this.strengthenEquipTow(2,_loc6_,_loc5_);
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
                     if(param1[_loc7_][0] == 0)
                     {
                        _loc6_ = [4];
                        if(_loc5_.backGemBagNum() > 0)
                        {
                           if(_loc5_.getGemFromBag(targetMc.id).getType() == 4)
                           {
                              if(_loc5_.getGemFromBag(targetMc.id).getStrengthenLevel() < 4)
                              {
                                 this.strMove.bagGemMoveToStr(0,targetMc,_loc6_,this.skillSlot,_loc5_);
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
                     if(param1[_loc7_][0] == 1)
                     {
                        _loc6_ = [0];
                        if(_loc5_.backGemBagNum() > 0)
                        {
                           if(_loc5_.getGemFromBag(targetMc.id).getType() == 0)
                           {
                              this.strMove.bagGemMoveToStr(1,targetMc,_loc6_,this.skillSlot,_loc5_);
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
                     if(param1[_loc7_][0] == 2)
                     {
                        _loc6_ = [2];
                        if(_loc5_.backGemBagNum() > 0)
                        {
                           if(_loc5_.getGemFromBag(targetMc.id).getType() == 2)
                           {
                              this.strMove.bagGemMoveToStr(2,targetMc,_loc6_,this.skillSlot,_loc5_);
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
            _loc7_++;
         }
      }
      
      private function bagMoveInit(param1:Array, param2:Bag) : void
      {
         var _loc3_:int = targetMc.x + targetMc.width / 2;
         var _loc4_:int = targetMc.y + targetMc.height / 2;
         targetMc.x = oldX;
         targetMc.y = oldY;
         var _loc5_:uint = 0;
         for(; _loc5_ < 24; _loc5_++)
         {
            if(!(_loc3_ >= param1[_loc5_][1] && _loc3_ <= param1[_loc5_][1] + pc2_0.width && (_loc4_ >= param1[_loc5_][2] && _loc4_ <= param1[_loc5_][2] + pc2_0.height)))
            {
               continue;
            }
            switch(this.bagState)
            {
               case 1:
                  param2.equipBagMove(targetMc.id,param1[_loc5_][0]);
                  this.equipUpdate();
                  break;
               case 2:
                  param2.suppliesBagMove(targetMc.id,param1[_loc5_][0]);
                  this.supUpdate();
                  break;
               case 3:
                  param2.gemBagMove(targetMc.id,param1[_loc5_][0]);
                  this.gemUpdate();
                  break;
               case 4:
                  param2.otherobjBagMove(targetMc.id,param1[_loc5_][0]);
                  this.otherUpdate();
                  break;
               case 5:
                  param2.questBagMove(targetMc.id,param1[_loc5_][0]);
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
         var _loc1_:uint = 0;
         var _loc2_:Otherobj = null;
         var _loc3_:Otherobj = null;
         this.synthesisSlotArr = this.synthesisSlot.slotArr();
         if(!this.playerState)
         {
            _loc1_ = 0;
            while(_loc1_ < 2)
            {
               if(this.synthesisSlotArr[_loc1_] != -1)
               {
                  this.strMove.gemBackToBag(this.synthesisSlotArr[_loc1_],this.bag1,this.synthesisSlot,_loc1_);
               }
               _loc1_++;
            }
            if(this.synthesisSlot.getProp(2) != -1)
            {
               _loc2_ = this.synthesisSlot.getProp(2);
               this.synthesisSlot.delSlot(2);
               this.bag1.addOtherobjBag(_loc2_);
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 2)
            {
               if(this.synthesisSlotArr[_loc1_] != -1)
               {
                  this.strMove.gemBackToBag(this.synthesisSlotArr[_loc1_],this.bag2,this.synthesisSlot,_loc1_);
               }
               _loc1_++;
            }
            if(this.synthesisSlot.getProp(2) != -1)
            {
               _loc3_ = this.synthesisSlot.getProp(2);
               this.synthesisSlot.delSlot(2);
               this.bag2.addOtherobjBag(_loc3_);
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
         var _loc1_:uint = 0;
         this.skillSlotArr = this.skillSlot.slotArr();
         if(!this.playerState)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               if(this.skillSlotArr[_loc1_] != -1)
               {
                  this.strMove.gemBackToBag(this.skillSlotArr[_loc1_],this.bag1,this.skillSlot,_loc1_);
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               if(this.skillSlotArr[_loc1_] != -1)
               {
                  this.strMove.gemBackToBag(this.skillSlotArr[_loc1_],this.bag2,this.skillSlot,_loc1_);
               }
               _loc1_++;
            }
         }
      }
      
      private function synpoint1() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            this.mosaicPointArr[_loc1_] = [_loc1_,this["hcc_" + _loc1_].x,this["hcc_" + _loc1_].y];
            _loc1_++;
         }
      }
      
      private function synpoint2() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            this.deletePointArr[_loc1_] = [_loc1_,this["hcc_" + _loc1_].x,this["hcc_" + _loc1_].y];
            _loc1_++;
         }
      }
      
      private function clickHandle(param1:BtnEvent) : void
      {
         switch(param1.id)
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
         var _loc1_:uint = 1;
         while(_loc1_ <= 4)
         {
            this["p1_" + _loc1_].isClick = false;
            this["p2_" + _loc1_].isClick = false;
            _loc1_++;
         }
      }
      
      private function btnIsClick(param1:Number) : void
      {
         var _loc2_:uint = 0;
         if(!this.playerState)
         {
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               this["p1_" + _loc2_].isClick = false;
               _loc2_++;
            }
            this["p1_" + param1].isClick = true;
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               this["p2_" + _loc2_].isClick = false;
               _loc2_++;
            }
            this["p2_" + param1].isClick = true;
         }
      }
      
      private function changHandle(param1:BtnEvent) : void
      {
         var _loc2_:* = param1.target.name.substr(1,1);
         this.bagState = param1.id;
         switch(param1.id)
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
            if(param1.id == 6)
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
            if(param1.id == 7)
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
            if(param1.id == 8)
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
            if(param1.id == 9)
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
            if(param1.id == 10)
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
      
      private function goldSf(param1:Number) : void
      {
         var _loc2_:Number = int(param1);
         trace("面板显示的金币:" + _loc2_);
         var _loc3_:String = _loc2_.toString();
         var _loc4_:uint = 0;
         while(_loc4_ < 5)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + _loc4_].visible = false;
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + _loc5_].visible = true;
               if(_loc3_.charAt(_loc5_) != "0")
               {
                  this.gold_mc.num_mc["num_" + _loc5_].gotoAndStop(_loc3_.charAt(_loc5_));
               }
               else
               {
                  this.gold_mc.num_mc["num_" + _loc5_].gotoAndStop(10);
               }
            }
            _loc5_++;
         }
      }
      
      private function onTimerSys(param1:TimerEvent) : void
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
      
      private function onTimer(param1:TimerEvent) : void
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
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            this["d2_" + _loc1_].visible = false;
            p2Gold.text = "";
            _loc1_++;
         }
      }
      
      private function noInitPone() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            this["d1_" + _loc1_].visible = false;
            p1Gold.text = "";
            _loc1_++;
         }
      }
      
      private function strengthenBagCao() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            this.pcOnePointArr[_loc1_] = [_loc1_,this["pc1_" + _loc1_].x,this["pc1_" + _loc1_].y];
            this.pcTowPointArr[_loc1_] = [_loc1_,this["pc2_" + _loc1_].x,this["pc2_" + _loc1_].y];
            _loc1_++;
         }
      }
      
      private function strengthenLanCao() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            this.strengLanPointArr[_loc1_] = [_loc1_,this["qhc_" + _loc1_].x,this["qhc_" + _loc1_].y];
            this.synthesisPointArr[_loc1_] = [_loc1_,this["hcc_" + _loc1_].x,this["hcc_" + _loc1_].y];
            _loc1_++;
         }
      }
      
      private function pointY(param1:MovieClip) : void
      {
         var _loc2_:Point = new Point(param1.x,param1.y);
         _loc2_ = this.localToGlobal(_loc2_);
         if(_loc2_.y + param1.height > 580)
         {
            param1.y = 580 - param1.height - 80;
         }
         if(_loc2_.y < 0)
         {
            param1.y = 0;
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
