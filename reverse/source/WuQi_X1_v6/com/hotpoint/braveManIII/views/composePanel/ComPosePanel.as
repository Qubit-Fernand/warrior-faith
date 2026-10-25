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
      
      public static function getSlotXX() : Array
      {
         return _instance.comSlot.getObj(0);
      }
      
      public static function close() : void
      {
         if(ComPosePanel._instance != null)
         {
            if(ComPosePanel._instance.visible == true)
            {
               ComPosePanel._instance.backGem();
               ComPosePanel._instance.comSlot.clearBag();
               ComPosePanel._instance.visible = false;
            }
         }
      }
      
      private function initPanel() : void
      {
         pro = VT.createVT(0);
         ranNum = VT.createVT(100);
         ps = 1;
         data = Main["player" + ps];
         state = 0;
         stateTow = 0;
         getEquipIng();
         p1orp2();
         addBag(ComData.getNeedStae());
         initFrame();
         this.mc_ss.visible = false;
         comSlot.clearBag();
         initFrameSlot();
         btnChange();
         btnStata(0,2,"pla_");
         btnStr();
         s1_mc.gotoAndStop(1);
         s2_mc.gotoAndStop(1);
         strName();
         goldName();
         playerGold();
         getNumOther();
      }
      
      private function p1orp2() : void
      {
         pla_0.visible = false;
         pla_1.visible = false;
         if(Main.P1P2)
         {
            pla_0.visible = true;
            pla_1.visible = true;
            btnStata(0,2,"pla_");
         }
      }
      
      private function addEvent() : void
      {
         this.addEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,daoJuOver);
         this.addEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,daoJuOut);
         this.addEventListener(DaoJuEvent.DAOJU_CLICK_MESSAGE,daoJuClick);
         this.addEventListener(BtnEvent.DO_CHANGE,changeHandle);
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,closeHandle);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,daoJuOver);
         this.removeEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,daoJuOut);
         this.removeEventListener(DaoJuEvent.DAOJU_CLICK_MESSAGE,daoJuClick);
         this.removeEventListener(BtnEvent.DO_CHANGE,changeHandle);
         this.removeEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.removeEventListener(BtnEvent.DO_CLOSE,closeHandle);
      }
      
      private function addTimeEvent() : void
      {
         timer = new Timer(1);
         timer.addEventListener(TimerEvent.TIMER,onTimerHandle);
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
         btnStata(state,2,"str_");
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
         strBag.clearBag();
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1[0].length)
            {
               strBag.addBag(param1[0][_loc2_],param1[1][_loc2_]);
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
            if(strBag.getObj(_loc1_) != null)
            {
               _loc2_ = strBag.getObj(_loc1_);
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
         allObj = null;
         if(_loc2_ != "s_")
         {
            this.mc_ss.visible = true;
            this.mc_ss.x = param1.target.x;
            this.mc_ss.y = param1.target.y;
            if(_loc2_ == "b_")
            {
               if(strBag.getObj(_loc3_) != null)
               {
                  _loc4_ = (strBag.getObj(_loc3_) as Array)[0];
                  if(comSlot.addTj(_loc4_))
                  {
                     if(state == 0)
                     {
                        if(stateTow == 1 && comSlot.getObj(1) != null && comSlot.getObj(1)[2] == 0)
                        {
                           data.getBag().addEquipBag(comSlot.getObj(1)[0]);
                        }
                        _loc5_ = uint(strBag.getObj(_loc3_)[1]);
                        _loc6_ = [data.getBag().delEquip(_loc5_),_loc5_];
                        comSlot.addBag(_loc6_,0);
                     }
                     else if(state == 1)
                     {
                        if(stateTow == 1 && comSlot.getObj(1) != null)
                        {
                           data.getBag().addGemBag(comSlot.getObj(1)[0]);
                        }
                        _loc7_ = uint(strBag.getObj(_loc3_)[1]);
                        _loc8_ = [data.getBag().delGem(_loc7_,1),_loc7_];
                        comSlot.addBag(_loc8_,0);
                     }
                     allObj = comSlot.getObj(0)[0];
                  }
               }
            }
            else if(_loc2_ == "p_")
            {
               if(ComData.getEquiping()[_loc3_] != null)
               {
                  _loc8_ = [];
                  _loc9_ = ComData.getEquiping()[_loc3_];
                  allObj = _loc9_;
                  if(state == 0)
                  {
                     if(comSlot.getObj(0) != null)
                     {
                        if(comSlot.getObj(0)[2] != 1)
                        {
                           getChange(_loc9_);
                        }
                        else if(comSlot.getObj(0)[1] != _loc3_)
                        {
                           getChange(_loc9_);
                        }
                     }
                  }
                  else if(state == 1)
                  {
                     backGem();
                     comSlot.clearBag();
                     state = 0;
                     stateTow = 0;
                  }
                  _loc8_ = [_loc9_,_loc3_];
                  if(comSlot.addTj(_loc9_))
                  {
                     comSlot.addBag(_loc8_,1);
                  }
               }
            }
            if(allObj != null)
            {
               finishVisible();
            }
         }
         else
         {
            if(_loc3_ == "0")
            {
               backGem();
               comSlot.clearBag();
               hc_0.text = "";
               hc_1.text = "";
               allObj = null;
            }
            else if(_loc3_ == "1")
            {
               backGem(Number(_loc3_));
               allObj = comSlot.getObj(1)[0];
               comSlot.clearOnly(Number(_loc3_));
            }
            this.mc_ss.visible = false;
         }
         initFrameSlot();
         changeBag();
         btnStr();
         strName();
         goldName();
         playerGold();
      }
      
      private function getChange(param1:Equip) : void
      {
         if(ComData.towBo(param1.getId(),(comSlot.getObj(0)[0] as Equip).getId()))
         {
            backSlotTow();
         }
         else
         {
            backSlotOne();
            backSlotTow();
            comSlot.clearBag();
         }
      }
      
      private function backSlotTow() : void
      {
         if(comSlot.getObj(1) != null)
         {
            if(comSlot.getObj(1)[2] == 0)
            {
               if(comSlot.getObj(1)[0] is Equip)
               {
                  data.getBag().addEquipBag(comSlot.getObj(1)[0]);
               }
               else if(comSlot.getObj(1)[0] is Gem)
               {
                  data.getBag().addGemBag(comSlot.getObj(1)[0]);
               }
            }
         }
      }
      
      private function backSlotOne() : void
      {
         if(comSlot.getObj(0) != null)
         {
            if(comSlot.getObj(0)[2] == 0)
            {
               if(comSlot.getObj(0)[0] is Equip)
               {
                  data.getBag().addEquipBag(comSlot.getObj(0)[0]);
               }
               else if(comSlot.getObj(0)[0] is Gem)
               {
                  data.getBag().addGemBag(comSlot.getObj(0)[0]);
               }
            }
         }
      }
      
      private function finishVisible() : void
      {
         if(state == 0)
         {
            getFinsih();
            getHc();
         }
         else if(state == 1)
         {
            getGemFinish();
            getHcGem();
         }
      }
      
      private function getHc() : void
      {
         if(ComData.getThreeIdById1(allObj) != null)
         {
            comSlot.addHcSlot(ComData.getThreeIdById1(allObj));
         }
         getNumOther();
      }
      
      private function getHcGem() : void
      {
         if(ComData.gethcOther() != null)
         {
            comSlot.addHcSlot(ComData.gethcOther());
         }
         getNumOther();
      }
      
      private function getNumOther() : void
      {
         if(comSlot.getObj(2) != null)
         {
            if(state == 0)
            {
               this["hc_" + 0].text = ComData.getHcNum(allObj)[0].toString();
               this["hc_" + 1].text = ComData.getHcNum(allObj)[1].toString();
               if(ComData.getHcNum(allObj)[1] >= ComData.getHcNum(allObj)[0])
               {
                  this["hc_" + 1].setTextFormat(bai);
               }
               else
               {
                  this["hc_" + 1].setTextFormat(hong);
               }
            }
            else if(state == 1)
            {
               this["hc_" + 0].text = String(1);
               this["hc_" + 1].text = ComData.gethcOtherNum().toString();
               if(ComData.gethcOtherNum() >= 1)
               {
                  this["hc_" + 1].setTextFormat(bai);
               }
               else
               {
                  this["hc_" + 1].setTextFormat(hong);
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
         if(ComData.getFinish(allObj) != null)
         {
            comSlot.addFishSlot(ComData.getFinish(allObj)[0]);
         }
      }
      
      public function getGemFinish() : void
      {
         if(comSlot.getObj(0) != null && comSlot.getObj(1) != null)
         {
            comSlot.addFishSlot(ComData.gemFinish(comSlot.getObj(0)[0],comSlot.getObj(1)[0]));
         }
      }
      
      public function backGem(param1:Number = -1) : void
      {
         if(param1 == -1)
         {
            backSlotOne();
            backSlotTow();
         }
         else if(param1 == 0)
         {
            backSlotOne();
         }
         else if(param1 == 1)
         {
            backSlotTow();
         }
      }
      
      private function changeBag() : void
      {
         if(comSlot.getObj(0) != null)
         {
            stateTow = 1;
            if(allObj != null)
            {
               addBag(ComData.getNeedStae(allObj));
            }
         }
         else
         {
            stateTow = 0;
            addBag(ComData.getNeedStae());
         }
         if(stateTow != oldStateTow)
         {
            this.mc_ss.visible = false;
            oldStateTow = stateTow;
         }
         btnChange();
         initFrame();
      }
      
      private function initFrameSlot() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["s_" + _loc1_].visible = false;
            if(comSlot.getObj(_loc1_) != null && comSlot.getObj(_loc1_)[0] != null)
            {
               this["s_" + _loc1_].visible = true;
               this["s_" + _loc1_].howNum.text = "";
               this["s_" + _loc1_].gotoAndStop(comSlot.getObj(_loc1_)[0].getFrame());
            }
            _loc1_++;
         }
      }
      
      private function daoJuOver(param1:DaoJuEvent) : void
      {
         var _loc2_:String = param1.target.name.substr(0,2);
         var _loc3_:String = param1.target.name.substr(2);
         var _loc4_:Object = null;
         if(_loc2_ == "b_" && strBag.getObj(_loc3_) != null)
         {
            _loc4_ = (strBag.getObj(_loc3_) as Array)[0];
         }
         else if(_loc2_ == "p_" && ComData.getEquiping() != null && ComData.getEquiping()[_loc3_] != null)
         {
            _loc4_ = ComData.getEquiping()[_loc3_];
         }
         else if(_loc2_ == "s_" && comSlot.getObj(_loc3_) != null)
         {
            _loc4_ = (comSlot.getObj(_loc3_) as Array)[0];
         }
         if(_loc4_ != null)
         {
            tooltip.visible = true;
            tooltip.x = mouseX;
            tooltip.y = mouseY;
            if(_loc4_ is Equip)
            {
               tooltip.equipTooltip(_loc4_ as Equip);
            }
            else if(_loc4_ is Gem)
            {
               tooltip.gemTooltip(_loc4_ as Gem);
            }
            else if(_loc4_ is Otherobj)
            {
               tooltip.otherTooltip(_loc4_ as Otherobj);
            }
         }
      }
      
      private function daoJuOut(param1:DaoJuEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function closeHandle(param1:BtnEvent) : void
      {
         close();
      }
      
      private function clickHandle(param1:BtnEvent) : void
      {
         timer.start();
         removeEvent();
         mast_hc.visible = true;
      }
      
      private function changeHandle(param1:BtnEvent) : void
      {
         var _loc2_:String = param1.target.name.substr(0,3);
         var _loc3_:String = param1.target.name.substr(4,1);
         backGem();
         if(_loc2_ == "str")
         {
            state = Number(_loc3_);
            stateTow = 0;
            oldStateTow = 0;
         }
         else if(_loc2_ == "pla")
         {
            ps = Number(_loc3_) + 1;
            data = Main["player" + ps];
            btnStata(_loc3_,2,"pla_");
            state = 0;
            stateTow = 0;
            oldStateTow = 0;
            getEquipIng();
         }
         comSlot.clearBag();
         addBag(ComData.getNeedStae());
         btnChange();
         initFrame();
         initFrameSlot();
         strName();
         goldName();
         btnStr();
         getNumOther();
         this.mc_ss.visible = false;
      }
      
      private function btnStr() : void
      {
         if(state == 0)
         {
            if(comSlot.getObj(0) != null && comSlot.getObj(1) != null && ComData.getHcNum(allObj) != null && ComData.getHcNum(allObj)[1] >= ComData.getHcNum(allObj)[0])
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
            if(comSlot.getObj(0) != null && comSlot.getObj(1) != null && ComData.gethcOtherNum() >= 1)
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
         ++times;
         s1_mc.gotoAndPlay(2);
         s2_mc.gotoAndPlay(2);
         if(times >= stopTime)
         {
            timer.stop();
            s1_mc.gotoAndStop(1);
            s2_mc.gotoAndStop(1);
            times = 0;
            addEvent();
            addSx();
            payGold();
            stateTow = 0;
            allObj = null;
            addBag(ComData.getNeedStae());
            comSlot.clearBag();
            initFrameSlot();
            initFrame();
            getEquipIng();
            btnStr();
            strName();
            playerGold();
            getNumOther();
            goldName();
            oldStateTow = 0;
            this.mc_ss.visible = false;
            mast_hc.visible = false;
         }
      }
      
      private function removeGem() : void
      {
         var _loc1_:Gem = null;
         if(comSlot.getObj(1) != null)
         {
            _loc1_ = (comSlot.getObj(1) as Array)[0];
            data.getBag().delGem((comSlot.getObj(1) as Array)[1],1);
            if(data.getBag().getGemById(_loc1_.getId()) == null)
            {
               comSlot.clearOnly(1);
            }
         }
         if(comSlot.getObj(2) != null)
         {
            _loc1_ = (comSlot.getObj(2) as Array)[0];
            data.getBag().delGem((comSlot.getObj(2) as Array)[1],1);
            if(data.getBag().getGemById(_loc1_.getId()) == null)
            {
               comSlot.clearOnly(2);
            }
         }
      }
      
      private function addSx() : void
      {
         if(state == 0)
         {
            strEquip();
         }
         else if(state == 1)
         {
            strGem();
         }
      }
      
      private function strEquip() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Array = null;
         var _loc6_:Number = NaN;
         if(comSlot.getObj(0) != null && comSlot.getObj(1) != null)
         {
            _loc1_ = Number((comSlot.getObj(0) as Array)[1]);
            _loc2_ = Number((comSlot.getObj(0) as Array)[2]);
            _loc3_ = Number((comSlot.getObj(1) as Array)[1]);
            _loc4_ = Number((comSlot.getObj(1) as Array)[2]);
            _loc5_ = ComData.getHcNum(allObj);
            _loc6_ = Number((comSlot.getObj(2) as Array)[1]);
            if(_loc2_ == 1)
            {
               data.getEquipSlot().delSlot(_loc1_);
            }
            if(_loc4_ == 1)
            {
               data.getEquipSlot().delSlot(_loc3_);
            }
            data.getBag().delOtherById(63100,_loc5_[0]);
            data.getBag().addEquipBag(comSlot.getObj(3)[0]);
            AchData.setHcNum(ps);
            AchData.setMadeById(3,(comSlot.getObj(3)[0] as Equip).getId(),ps,1);
            ShortTip.open(39);
         }
      }
      
      private function strGem() : void
      {
         var _loc1_:Gem = null;
         var _loc2_:Number = NaN;
         if(comSlot.getObj(0) != null && comSlot.getObj(1) != null)
         {
            _loc1_ = comSlot.getObj(3)[0];
            _loc2_ = _loc1_.getId();
            if(data.getBag().canPutGemNum(_loc2_) > 0)
            {
               data.getBag().delOtherById(63100,1);
               data.getBag().addGemBag(comSlot.getObj(3)[0]);
               ShortTip.open(39);
               AchData.setHcNum(ps);
               AchData.setMadeById(3,(comSlot.getObj(3)[0] as Gem).getId(),ps,1);
               JiHua_Interface.ppp2_7 = true;
            }
            else
            {
               data.getBag().addGemBag(comSlot.getObj(0)[0]);
               data.getBag().addGemBag(comSlot.getObj(1)[0]);
               ShortTip.open(3);
            }
         }
      }
      
      private function strName() : void
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this["strg_" + _loc1_].text = "";
            if(comSlot.getObj(_loc1_) != null && comSlot.getObj(_loc1_)[0] != null)
            {
               _loc2_ = (comSlot.getObj(_loc1_) as Array)[0];
               this["strg_" + _loc1_].text = _loc2_.getName();
               if(_loc2_.getColor() == 1)
               {
                  this["strg_" + _loc1_].setTextFormat(bai);
               }
               else if(_loc2_.getColor() == 2)
               {
                  this["strg_" + _loc1_].setTextFormat(lan);
               }
               else if(_loc2_.getColor() == 3)
               {
                  this["strg_" + _loc1_].setTextFormat(zi);
               }
               else if(_loc2_.getColor() == 4)
               {
                  this["strg_" + _loc1_].setTextFormat(ch);
               }
            }
            _loc1_++;
         }
      }
      
      private function goldName() : void
      {
         gold_name.text = "";
         if(comSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               if(comSlot.getObj(0) != null)
               {
                  gold_name.text = ComData.getPlayGod(comSlot.getObj(0)[0]);
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
         if(comSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               data.payGold(ComData.getPlayGod(allObj));
            }
         }
      }
      
      private function playerGold() : void
      {
         player_gold.text = String(data.getGold());
      }
   }
}

