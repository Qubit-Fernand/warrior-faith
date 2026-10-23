package com.hotpoint.braveManIII.views.composePanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import com.hotpoint.braveManIII.views.strPanel.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import src.*;
   
   public class ComPosePanel extends MovieClip
   {
      
      private static var _instance:ComPosePanel;
      
      public static var data:PlayerData;
      
      public static var state:Number = 0;
      
      public static var stateTow:Number = 0;
      
      private var tooltip:ItemsTooltip;
      
      private var ps:Number = 1;
      
      private var strBag:StrBag;
      
      private var comSlot:ComSlot;
      
      private var pro:VT;
      
      private var ranNum:VT;
      
      private var times:uint = 0;
      
      private var timer:Timer;
      
      private var stopTime:uint = 80;
      
      private var allObj:Object = null;
      
      private var hong:TextFormat;
      
      private var bai:TextFormat;
      
      private var lan:TextFormat;
      
      private var zi:TextFormat;
      
      private var ch:TextFormat;
      
      private var oldStateTow:Number = 0;
      
      public function ComPosePanel()
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(ComPosePanel._instance == null)
         {
            ComPosePanel._instance = new ComPosePanel();
            ComPosePanel._instance.strBag = StrBag.creatBag();
            ComPosePanel._instance.comSlot = ComSlot.creatSlot();
            ComPosePanel._instance.tooltip = new ItemsTooltip();
            ComPosePanel._instance.addEvent();
            ComPosePanel._instance.addTimeEvent();
            ComPosePanel._instance.hong = new TextFormat();
            ComPosePanel._instance.hong.color = 16711680;
            ComPosePanel._instance.bai = new TextFormat();
            ComPosePanel._instance.bai.color = 4294967295;
            ComPosePanel._instance.lan = new TextFormat();
            ComPosePanel._instance.lan.color = 26367;
            ComPosePanel._instance.zi = new TextFormat();
            ComPosePanel._instance.zi.color = 16711884;
            ComPosePanel._instance.ch = new TextFormat();
            ComPosePanel._instance.ch.color = 16737792;
         }
         Main._stage.addChild(ComPosePanel._instance);
         ComPosePanel._instance.visible = true;
         ComPosePanel._instance.initPanel();
         ComPosePanel._instance.addChild(ComPosePanel._instance.tooltip);
         ComPosePanel._instance.tooltip.visible = false;
         ComPosePanel._instance.x = 50;
         ComPosePanel._instance.y = 10;
         ComPosePanel._instance.mast_hc.visible = false;
      }
      
      public static function close() : void
      {
         if(ComPosePanel._instance != null)
         {
            ComPosePanel._instance.backGem();
            if(ComPosePanel._instance.visible == true)
            {
               ComPosePanel._instance.visible = false;
            }
         }
      }
      
      private function initPanel() : void
      {
         this.pro = VT.createVT(0);
         this.ranNum = VT.createVT(100);
         this.ps = 1;
         data = Main["player" + this.ps];
         state = 0;
         stateTow = 0;
         this.getEquipIng();
         this.p1orp2();
         this.addBag(ComData.getNeedStae());
         this.initFrame();
         this.mc_ss.visible = false;
         this.comSlot.clearBag();
         this.initFrameSlot();
         this.btnChange();
         this.btnStata(0,2,"pla_");
         this.btnStr();
         s1_mc.gotoAndStop(1);
         s2_mc.gotoAndStop(1);
         this.strName();
         this.goldName();
         this.playerGold();
         this.getNumOther();
      }
      
      private function p1orp2() : void
      {
         pla_0.visible = false;
         pla_1.visible = false;
         if(Main.P1P2)
         {
            pla_0.visible = true;
            pla_1.visible = true;
            this.btnStata(0,2,"pla_");
         }
      }
      
      private function addEvent() : void
      {
         this.addEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,this.daoJuOver);
         this.addEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,this.daoJuOut);
         this.addEventListener(DaoJuEvent.DAOJU_CLICK_MESSAGE,this.daoJuClick);
         this.addEventListener(BtnEvent.DO_CHANGE,this.changeHandle);
         this.addEventListener(BtnEvent.DO_CLICK,this.clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,this.closeHandle);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,this.daoJuOver);
         this.removeEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,this.daoJuOut);
         this.removeEventListener(DaoJuEvent.DAOJU_CLICK_MESSAGE,this.daoJuClick);
         this.removeEventListener(BtnEvent.DO_CHANGE,this.changeHandle);
         this.removeEventListener(BtnEvent.DO_CLICK,this.clickHandle);
         this.removeEventListener(BtnEvent.DO_CLOSE,this.closeHandle);
      }
      
      private function addTimeEvent() : void
      {
         this.timer = new Timer(1);
         this.timer.addEventListener(TimerEvent.TIMER,this.onTimerHandle);
      }
      
      private function getEquipIng() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Equip = null;
         if(ComData.getEquiping() != null)
         {
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               if(ComData.getEquiping()[_loc1_] != null)
               {
                  _loc2_ = ComData.getEquiping()[_loc1_];
                  this["p_" + _loc1_].howNum.text = "";
                  this["p_" + _loc1_].gotoAndStop(_loc2_.getFrame());
               }
               else
               {
                  this["p_" + _loc1_].howNum.text = "";
                  this["p_" + _loc1_].gotoAndStop(1);
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               this["p_" + _loc1_].howNum.text = "";
               this["p_" + _loc1_].gotoAndStop(1);
               _loc1_++;
            }
         }
      }
      
      private function btnChange() : void
      {
         str_0.type.gotoAndStop(1);
         str_1.type.gotoAndStop(1);
         this.btnStata(state,2,"str_");
         this["str_" + state].type.gotoAndStop(stateTow + 1);
      }
      
      private function btnStata(param1:Number, param2:Number, param3:String) : void
      {
         this[param3 + param1].isClick = true;
         var _loc4_:uint = 0;
         while(_loc4_ < param2)
         {
            if(param1 != _loc4_)
            {
               this[param3 + _loc4_].isClick = false;
            }
            _loc4_++;
         }
      }
      
      private function addBag(param1:Array) : void
      {
         var _loc2_:uint = 0;
         this.strBag.clearBag();
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1[0].length)
            {
               this.strBag.addBag(param1[0][_loc2_],param1[1][_loc2_]);
               _loc2_++;
            }
         }
      }
      
      private function initFrame() : void
      {
         var _loc2_:Array = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            if(this.strBag.getObj(_loc1_) != null)
            {
               _loc2_ = this.strBag.getObj(_loc1_);
               this["b_" + _loc1_].howNum.text = "";
               this["b_" + _loc1_].gotoAndStop(_loc2_[0].getFrame());
               if(_loc2_[0] is Gem)
               {
                  if(_loc2_[0].getIsPile())
                  {
                     this["b_" + _loc1_].howNum.text = _loc2_[0].getTimes();
                  }
               }
            }
            else
            {
               this["b_" + _loc1_].gotoAndStop(1);
               this["b_" + _loc1_].howNum.text = "";
            }
            _loc1_++;
         }
      }
      
      private function daoJuClick(param1:DaoJuEvent) : void
      {
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:Array = null;
         var _loc9_:Equip = null;
         var _loc2_:String = param1.target.name.substr(0,2);
         var _loc3_:Number = Number(String(param1.target.name).substr(2));
         this.allObj = null;
         if(_loc2_ != "s_")
         {
            this.mc_ss.visible = true;
            this.mc_ss.x = param1.target.x;
            this.mc_ss.y = param1.target.y;
            if(_loc2_ == "b_")
            {
               if(this.strBag.getObj(_loc3_) != null)
               {
                  _loc4_ = (this.strBag.getObj(_loc3_) as Array)[0];
                  if(this.comSlot.addTj(_loc4_))
                  {
                     if(state == 0)
                     {
                        if(stateTow == 1 && this.comSlot.getObj(1) != null && this.comSlot.getObj(1)[2] == 0)
                        {
                           data.getBag().addEquipBag(this.comSlot.getObj(1)[0]);
                           trace("槽里返回装备");
                        }
                        _loc5_ = uint(this.strBag.getObj(_loc3_)[1]);
                        _loc6_ = [data.getBag().delEquip(_loc5_),_loc5_];
                        this.comSlot.addBag(_loc6_,0);
                     }
                     else if(state == 1)
                     {
                        if(stateTow == 1 && this.comSlot.getObj(1) != null)
                        {
                           data.getBag().addGemBag(this.comSlot.getObj(1)[0]);
                        }
                        _loc7_ = uint(this.strBag.getObj(_loc3_)[1]);
                        _loc8_ = [data.getBag().delGem(_loc7_,1),_loc7_];
                        this.comSlot.addBag(_loc8_,0);
                     }
                     this.allObj = this.comSlot.getObj(0)[0];
                  }
               }
            }
            else if(_loc2_ == "p_")
            {
               if(ComData.getEquiping()[_loc3_] != null)
               {
                  _loc8_ = [];
                  _loc9_ = ComData.getEquiping()[_loc3_];
                  this.allObj = _loc9_;
                  if(state == 0)
                  {
                     if(this.comSlot.getObj(0) != null)
                     {
                        if(this.comSlot.getObj(0)[2] != 1)
                        {
                           this.getChange(_loc9_);
                        }
                        else if(this.comSlot.getObj(0)[1] != _loc3_)
                        {
                           this.getChange(_loc9_);
                        }
                     }
                  }
                  else if(state == 1)
                  {
                     this.backGem();
                     this.comSlot.clearBag();
                     state = 0;
                     stateTow = 0;
                  }
                  _loc8_ = [_loc9_,_loc3_];
                  if(this.comSlot.addTj(_loc9_))
                  {
                     this.comSlot.addBag(_loc8_,1);
                  }
               }
            }
            if(this.allObj != null)
            {
               this.finishVisible();
            }
         }
         else
         {
            if(_loc3_ == "0")
            {
               this.backGem();
               this.comSlot.clearBag();
               hc_0.text = "";
               hc_1.text = "";
               this.allObj = null;
            }
            else if(_loc3_ == "1")
            {
               this.backGem(Number(_loc3_));
               this.allObj = this.comSlot.getObj(1)[0];
               this.comSlot.clearOnly(Number(_loc3_));
            }
            this.mc_ss.visible = false;
         }
         this.initFrameSlot();
         this.changeBag();
         this.btnStr();
         this.strName();
         this.goldName();
         this.playerGold();
      }
      
      private function getChange(param1:Equip) : void
      {
         if(ComData.towBo(param1.getId(),(this.comSlot.getObj(0)[0] as Equip).getId()))
         {
            this.backSlotTow();
         }
         else
         {
            this.backSlotOne();
            this.backSlotTow();
            this.comSlot.clearBag();
         }
      }
      
      private function backSlotTow() : void
      {
         if(this.comSlot.getObj(1) != null)
         {
            if(this.comSlot.getObj(1)[2] == 0)
            {
               if(this.comSlot.getObj(1)[0] is Equip)
               {
                  data.getBag().addEquipBag(this.comSlot.getObj(1)[0]);
               }
               else if(this.comSlot.getObj(1)[0] is Gem)
               {
                  data.getBag().addGemBag(this.comSlot.getObj(1)[0]);
               }
            }
         }
      }
      
      private function backSlotOne() : void
      {
         if(this.comSlot.getObj(0) != null)
         {
            if(this.comSlot.getObj(0)[2] == 0)
            {
               if(this.comSlot.getObj(0)[0] is Equip)
               {
                  data.getBag().addEquipBag(this.comSlot.getObj(0)[0]);
               }
               else if(this.comSlot.getObj(0)[0] is Gem)
               {
                  data.getBag().addGemBag(this.comSlot.getObj(0)[0]);
               }
            }
         }
      }
      
      private function finishVisible() : void
      {
         if(state == 0)
         {
            this.getFinsih();
            this.getHc();
         }
         else if(state == 1)
         {
            this.getGemFinish();
            this.getHcGem();
         }
      }
      
      private function getHc() : void
      {
         if(ComData.getThreeIdById1(this.allObj) != null)
         {
            this.comSlot.addHcSlot(ComData.getThreeIdById1(this.allObj));
         }
         this.getNumOther();
      }
      
      private function getHcGem() : void
      {
         if(ComData.gethcOther() != null)
         {
            this.comSlot.addHcSlot(ComData.gethcOther());
         }
         this.getNumOther();
      }
      
      private function getNumOther() : void
      {
         if(this.comSlot.getObj(2) != null)
         {
            if(state == 0)
            {
               this["hc_" + 0].text = ComData.getHcNum(this.allObj)[0].toString();
               this["hc_" + 1].text = ComData.getHcNum(this.allObj)[1].toString();
               if(ComData.getHcNum(this.allObj)[1] >= ComData.getHcNum(this.allObj)[0])
               {
                  this["hc_" + 1].setTextFormat(this.bai);
               }
               else
               {
                  this["hc_" + 1].setTextFormat(this.hong);
               }
            }
            else if(state == 1)
            {
               this["hc_" + 0].text = String(1);
               this["hc_" + 1].text = ComData.gethcOtherNum().toString();
               if(ComData.gethcOtherNum() >= 1)
               {
                  this["hc_" + 1].setTextFormat(this.bai);
               }
               else
               {
                  this["hc_" + 1].setTextFormat(this.hong);
               }
            }
         }
         else
         {
            this["hc_" + 0].text = "";
            this["hc_" + 1].text = "";
         }
      }
      
      public function getFinsih() : void
      {
         if(ComData.getFinish(this.allObj) != null)
         {
            this.comSlot.addFishSlot(ComData.getFinish(this.allObj)[0]);
         }
      }
      
      public function getGemFinish() : void
      {
         if(this.comSlot.getObj(0) != null && this.comSlot.getObj(1) != null)
         {
            this.comSlot.addFishSlot(ComData.gemFinish(this.comSlot.getObj(0)[0],this.comSlot.getObj(1)[0]));
         }
      }
      
      public function backGem(param1:Number = -1) : void
      {
         if(param1 == -1)
         {
            this.backSlotOne();
            this.backSlotTow();
         }
         else if(param1 == 0)
         {
            this.backSlotOne();
         }
         else if(param1 == 1)
         {
            this.backSlotTow();
         }
      }
      
      private function changeBag() : void
      {
         if(this.comSlot.getObj(0) != null)
         {
            stateTow = 1;
            if(this.allObj != null)
            {
               this.addBag(ComData.getNeedStae(this.allObj));
            }
         }
         else
         {
            stateTow = 0;
            this.addBag(ComData.getNeedStae());
         }
         if(stateTow != this.oldStateTow)
         {
            this.mc_ss.visible = false;
            this.oldStateTow = stateTow;
         }
         this.btnChange();
         this.initFrame();
      }
      
      private function initFrameSlot() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["s_" + _loc1_].visible = false;
            if(this.comSlot.getObj(_loc1_) != null && this.comSlot.getObj(_loc1_)[0] != null)
            {
               this["s_" + _loc1_].visible = true;
               this["s_" + _loc1_].howNum.text = "";
               this["s_" + _loc1_].gotoAndStop(this.comSlot.getObj(_loc1_)[0].getFrame());
            }
            _loc1_++;
         }
      }
      
      private function daoJuOver(param1:DaoJuEvent) : void
      {
         var _loc2_:String = param1.target.name.substr(0,2);
         var _loc3_:String = param1.target.name.substr(2);
         var _loc4_:Object = null;
         if(_loc2_ == "b_" && this.strBag.getObj(_loc3_) != null)
         {
            _loc4_ = (this.strBag.getObj(_loc3_) as Array)[0];
         }
         else if(_loc2_ == "p_" && ComData.getEquiping() != null && ComData.getEquiping()[_loc3_] != null)
         {
            _loc4_ = ComData.getEquiping()[_loc3_];
         }
         else if(_loc2_ == "s_" && this.comSlot.getObj(_loc3_) != null)
         {
            _loc4_ = (this.comSlot.getObj(_loc3_) as Array)[0];
         }
         if(_loc4_ != null)
         {
            this.tooltip.visible = true;
            this.tooltip.x = mouseX;
            this.tooltip.y = mouseY;
            if(_loc4_ is Equip)
            {
               this.tooltip.equipTooltip(_loc4_ as Equip);
            }
            else if(_loc4_ is Gem)
            {
               this.tooltip.gemTooltip(_loc4_ as Gem);
            }
            else if(_loc4_ is Otherobj)
            {
               this.tooltip.otherTooltip(_loc4_ as Otherobj);
            }
         }
      }
      
      private function daoJuOut(param1:DaoJuEvent) : void
      {
         this.tooltip.visible = false;
      }
      
      private function closeHandle(param1:BtnEvent) : void
      {
         this.backGem();
         close();
      }
      
      private function clickHandle(param1:BtnEvent) : void
      {
         this.timer.start();
         this.removeEvent();
         mast_hc.visible = true;
      }
      
      private function changeHandle(param1:BtnEvent) : void
      {
         var _loc2_:String = param1.target.name.substr(0,3);
         var _loc3_:String = param1.target.name.substr(4,1);
         this.backGem();
         if(_loc2_ == "str")
         {
            state = Number(_loc3_);
            stateTow = 0;
            this.oldStateTow = 0;
         }
         else if(_loc2_ == "pla")
         {
            this.ps = Number(_loc3_) + 1;
            data = Main["player" + this.ps];
            this.btnStata(_loc3_,2,"pla_");
            state = 0;
            stateTow = 0;
            this.oldStateTow = 0;
            this.getEquipIng();
         }
         this.comSlot.clearBag();
         this.addBag(ComData.getNeedStae());
         this.btnChange();
         this.initFrame();
         this.initFrameSlot();
         this.strName();
         this.goldName();
         this.btnStr();
         this.getNumOther();
         this.mc_ss.visible = false;
      }
      
      private function btnStr() : void
      {
         if(state == 0)
         {
            if(this.comSlot.getObj(0) != null && this.comSlot.getObj(1) != null && ComData.getHcNum(this.allObj) != null && ComData.getHcNum(this.allObj)[1] >= ComData.getHcNum(this.allObj)[0])
            {
               this.strBtn.gotoAndStop(1);
            }
            else
            {
               this.strBtn.gotoAndStop(2);
            }
         }
         else if(state == 1)
         {
            if(this.comSlot.getObj(0) != null && this.comSlot.getObj(1) != null && ComData.gethcOtherNum() >= 1)
            {
               this.strBtn.gotoAndStop(1);
            }
            else
            {
               this.strBtn.gotoAndStop(2);
            }
         }
      }
      
      private function onTimerHandle(param1:TimerEvent) : void
      {
         ++this.times;
         s1_mc.gotoAndPlay(2);
         s2_mc.gotoAndPlay(2);
         if(this.times >= this.stopTime)
         {
            this.timer.stop();
            s1_mc.gotoAndStop(1);
            s2_mc.gotoAndStop(1);
            this.times = 0;
            this.addEvent();
            this.addSx();
            this.payGold();
            stateTow = 0;
            this.allObj = null;
            this.addBag(ComData.getNeedStae());
            this.comSlot.clearBag();
            this.initFrameSlot();
            this.initFrame();
            this.getEquipIng();
            this.btnStr();
            this.strName();
            this.playerGold();
            this.getNumOther();
            this.goldName();
            this.oldStateTow = 0;
            this.mc_ss.visible = false;
            mast_hc.visible = false;
         }
      }
      
      private function removeGem() : void
      {
         var _loc1_:Gem = null;
         if(this.comSlot.getObj(1) != null)
         {
            _loc1_ = (this.comSlot.getObj(1) as Array)[0];
            data.getBag().delGem((this.comSlot.getObj(1) as Array)[1],1);
            if(data.getBag().getGemById(_loc1_.getId()) == null)
            {
               this.comSlot.clearOnly(1);
            }
         }
         if(this.comSlot.getObj(2) != null)
         {
            _loc1_ = (this.comSlot.getObj(2) as Array)[0];
            data.getBag().delGem((this.comSlot.getObj(2) as Array)[1],1);
            if(data.getBag().getGemById(_loc1_.getId()) == null)
            {
               this.comSlot.clearOnly(2);
            }
         }
      }
      
      private function addSx() : void
      {
         if(state == 0)
         {
            this.strEquip();
         }
         else if(state == 1)
         {
            this.strGem();
         }
      }
      
      private function strEquip() : void
      {
         var _loc1_:Number = Number((this.comSlot.getObj(0) as Array)[1]);
         var _loc2_:Number = Number((this.comSlot.getObj(0) as Array)[2]);
         var _loc3_:Number = Number((this.comSlot.getObj(1) as Array)[1]);
         var _loc4_:Number = Number((this.comSlot.getObj(1) as Array)[2]);
         var _loc5_:Array = ComData.getHcNum(this.allObj);
         var _loc6_:Number = Number((this.comSlot.getObj(2) as Array)[1]);
         if(_loc2_ == 1)
         {
            data.getEquipSlot().delSlot(_loc1_);
         }
         if(_loc4_ == 1)
         {
            data.getEquipSlot().delSlot(_loc3_);
         }
         data.getBag().delOtherById(63100,_loc5_[0]);
         data.getBag().addEquipBag(this.comSlot.getObj(3)[0]);
         AchData.setHcNum(this.ps);
         AchData.setMadeById(3,(this.comSlot.getObj(3)[0] as Equip).getId(),this.ps,1);
         ShortTip.open(39);
      }
      
      private function strGem() : void
      {
         var _loc1_:Gem = this.comSlot.getObj(3)[0];
         var _loc2_:Number = _loc1_.getId();
         trace(data.getBag().canPutGemNum(_loc2_) + "_____背包数量");
         if(data.getBag().canPutGemNum(_loc2_) > 0)
         {
            data.getBag().delOtherById(63100,1);
            data.getBag().addGemBag(this.comSlot.getObj(3)[0]);
            ShortTip.open(39);
            AchData.setHcNum(this.ps);
            AchData.setMadeById(3,(this.comSlot.getObj(3)[0] as Gem).getId(),this.ps,1);
         }
         else
         {
            data.getBag().addGemBag(this.comSlot.getObj(0)[0]);
            data.getBag().addGemBag(this.comSlot.getObj(1)[0]);
            ShortTip.open(3);
         }
      }
      
      private function strName() : void
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["strg_" + _loc1_].text = "";
            if(this.comSlot.getObj(_loc1_) != null && this.comSlot.getObj(_loc1_)[0] != null)
            {
               _loc2_ = (this.comSlot.getObj(_loc1_) as Array)[0];
               this["strg_" + _loc1_].text = _loc2_.getName();
               if(_loc2_.getColor() == 1)
               {
                  this["strg_" + _loc1_].setTextFormat(this.bai);
               }
               else if(_loc2_.getColor() == 2)
               {
                  this["strg_" + _loc1_].setTextFormat(this.lan);
               }
               else if(_loc2_.getColor() == 3)
               {
                  this["strg_" + _loc1_].setTextFormat(this.zi);
               }
               else if(_loc2_.getColor() == 4)
               {
                  this["strg_" + _loc1_].setTextFormat(this.ch);
               }
            }
            _loc1_++;
         }
      }
      
      private function goldName() : void
      {
         gold_name.text = "";
         if(this.comSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               if(this.comSlot.getObj(0) != null)
               {
                  gold_name.text = ComData.getPlayGod(this.comSlot.getObj(0)[0]);
               }
               else
               {
                  gold_name.text = "";
               }
            }
            else if(state == 1)
            {
               gold_name.text = "0";
            }
         }
      }
      
      private function payGold() : void
      {
         if(this.comSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               data.payGold(ComData.getPlayGod(this.allObj));
            }
         }
      }
      
      private function playerGold() : void
      {
         player_gold.text = String(data.getGold());
      }
   }
}

