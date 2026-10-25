package com.hotpoint.braveManIII.views.strPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   import src.*;
   
   public class StrPanel extends MovieClip
   {
      
      private static var _instance:StrPanel;
      
      public static var data:PlayerData;
      
      public static var state:Number = 0;
      
      public static var stateTow:Number = 0;
      
      private var tooltip:ItemsTooltip;
      
      private var ps:Number = 1;
      
      private var oldStateTow:Number = 0;
      
      private var strBag:StrBag;
      
      private var strSlot:StrSlot;
      
      private var pro:VT;
      
      private var ranNum:VT;
      
      private var times:uint = 0;
      
      private var timer:Timer;
      
      private var stopTime:uint = 80;
      
      private var bo:Boolean = true;
      
      public function StrPanel()
      {
         super();
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(StrPanel._instance == null)
         {
            StrPanel._instance = new StrPanel();
            StrPanel._instance.strBag = StrBag.creatBag();
            StrPanel._instance.strSlot = StrSlot.creatSlot();
            StrPanel._instance.tooltip = new ItemsTooltip();
            StrPanel._instance.addEvent();
            StrPanel._instance.addTimeEvent();
         }
         Main._stage.addChild(StrPanel._instance);
         StrPanel._instance.visible = true;
         StrPanel._instance.initPanel();
         StrPanel._instance.addChild(StrPanel._instance.tooltip);
         StrPanel._instance.tooltip.visible = false;
         StrPanel._instance.x = 50;
         StrPanel._instance.y = 10;
         StrPanel._instance.mast_hc.visible = false;
      }
      
      public static function close() : void
      {
         if(StrPanel._instance != null)
         {
            if(StrPanel._instance.visible == true)
            {
               StrPanel._instance.visible = false;
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
         addBag(StrData.getEquipOrSkillGem());
         initFrame();
         this.mc_ss.visible = false;
         strSlot.clearBag();
         initFrameSlot();
         btnChange();
         btnStata(0,2,"pla_");
         btnStr();
         getPro();
         proText();
         s1_mc.gotoAndStop(1);
         s2_mc.gotoAndStop(1);
         strName();
         goldName();
         playerGold();
         QiangHuaJiaCheng();
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
         var _loc2_:uint = 0;
         var _loc3_:Equip = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = _loc1_;
            if((_loc1_ == 0 || _loc1_ == 1 || _loc1_ == 3 || _loc1_ == 4) && Main.water.getValue() != 1)
            {
               _loc2_ += 8;
            }
            _loc3_ = data.getEquipSlot().getEquipFromSlot(_loc2_);
            if(_loc3_ != null)
            {
               this["p_" + _loc1_].howNum.text = "";
               this["p_" + _loc1_].gotoAndStop(_loc3_.getFrame());
            }
            else
            {
               this["p_" + _loc1_].howNum.text = "";
               this["p_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
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
         var _loc6_:Equip = null;
         var _loc7_:Array = null;
         var _loc2_:String = param1.target.name.substr(0,2);
         var _loc3_:String = String(param1.target.name).substr(2);
         if(_loc2_ != "s_")
         {
            if(bo)
            {
               this.mc_ss.visible = true;
               this.mc_ss.x = param1.target.x;
               this.mc_ss.y = param1.target.y;
            }
            if(_loc2_ == "b_")
            {
               if(strBag.getObj(_loc3_) != null)
               {
                  _loc4_ = (strBag.getObj(_loc3_) as Array)[0];
                  if(strSlot.addTj(_loc4_))
                  {
                     strSlot.addBag(strBag.getObj(_loc3_),0);
                  }
               }
            }
            else if(_loc2_ == "p_")
            {
               if(data.getEquipSlot().getEquipFromSlot(_loc3_) != null)
               {
                  _loc5_ = uint(_loc3_);
                  if((_loc3_ == 0 || _loc3_ == 1 || _loc3_ == 3 || _loc3_ == 4) && Main.water.getValue() != 1)
                  {
                     _loc5_ += 8;
                  }
                  _loc6_ = data.getEquipSlot().getEquipFromSlot(_loc5_);
                  if(state == 1)
                  {
                     strSlot.clearBag();
                     state = 0;
                     stateTow = 0;
                  }
                  _loc7_ = [_loc6_,_loc5_];
                  if(strSlot.addTj(_loc6_))
                  {
                     strSlot.addBag(_loc7_,1);
                  }
               }
            }
         }
         else
         {
            strSlot.clearOnly(Number(_loc3_));
            this.mc_ss.visible = false;
         }
         initFrameSlot();
         changeBag();
         btnStr();
         getPro();
         proText();
         strName();
         goldName();
         playerGold();
      }
      
      private function proText() : void
      {
         if(pro.getValue() <= 0)
         {
            pro_text.text = "";
         }
         else
         {
            pro_text.text = String(pro.getValue()) + "%";
         }
      }
      
      private function changeBag() : void
      {
         if(strSlot.getObj(0) != null)
         {
            stateTow = 1;
         }
         else
         {
            stateTow = 0;
         }
         if(stateTow != oldStateTow)
         {
            this.mc_ss.visible = false;
            oldStateTow = stateTow;
         }
         addBag(StrData.getEquipOrSkillGem());
         btnChange();
         initFrame();
      }
      
      private function initFrameSlot() : void
      {
         var _loc2_:Array = null;
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            this["s_" + _loc1_].visible = false;
            if(strSlot.getObj(_loc1_) != null)
            {
               this["s_" + _loc1_].visible = true;
               _loc2_ = strSlot.getObj(_loc1_);
               this["s_" + _loc1_].howNum.text = "";
               this["s_" + _loc1_].gotoAndStop(_loc2_[0].getFrame());
            }
            _loc1_++;
         }
      }
      
      private function daoJuOver(param1:DaoJuEvent) : void
      {
         var _loc5_:uint = 0;
         var _loc2_:String = param1.target.name.substr(0,2);
         var _loc3_:String = param1.target.name.substr(2);
         var _loc4_:Object = null;
         if(_loc2_ == "b_" && strBag.getObj(_loc3_) != null)
         {
            _loc4_ = (strBag.getObj(_loc3_) as Array)[0];
         }
         else if(_loc2_ == "p_" && data.getEquipSlot().getEquipFromSlot(_loc3_) != null)
         {
            _loc5_ = uint(_loc3_);
            if((_loc3_ == 0 || _loc3_ == 1 || _loc3_ == 3 || _loc3_ == 4) && Main.water.getValue() != 1)
            {
               _loc5_ += 8;
            }
            _loc4_ = data.getEquipSlot().getEquipFromSlot(_loc5_);
         }
         else if(_loc2_ == "s_" && strSlot.getObj(_loc3_) != null)
         {
            _loc4_ = (strSlot.getObj(_loc3_) as Array)[0];
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
         strSlot.clearBag();
         addBag(StrData.getEquipOrSkillGem());
         btnChange();
         initFrame();
         initFrameSlot();
         getPro();
         proText();
         strName();
         goldName();
         QiangHuaJiaCheng();
         btnStr();
         this.mc_ss.visible = false;
      }
      
      private function btnStr() : void
      {
         this.strBtn.gotoAndStop(2);
         if(strSlot.getObj(0) != null && strSlot.getObj(1) != null)
         {
            if(state == 0)
            {
               if(data.getGold() >= StrData.getStrenthenGold((strSlot.getObj(0) as Array)[0]))
               {
                  this.strBtn.gotoAndStop(1);
               }
            }
            else if(state == 1)
            {
               if(data.getGold() >= StrData.getGemUpGold((strSlot.getObj(0) as Array)[0]))
               {
                  this.strBtn.gotoAndStop(1);
               }
            }
         }
      }
      
      private function getPro() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         pro.setValue(0);
         if(state == 0)
         {
            if(strSlot.getObj(0) != null && strSlot.getObj(1) != null)
            {
               if(strSlot.getObj(2) == null)
               {
                  pro.setValue(StrData.getEquipUpLevel((strSlot.getObj(0) as Array)[0],(strSlot.getObj(1) as Array)[0]));
               }
               else
               {
                  _loc1_ = Number(StrData.getEquipUpLevel((strSlot.getObj(0) as Array)[0],(strSlot.getObj(1) as Array)[0]));
                  _loc2_ = Number(StrData.getLuckGemPosition((strSlot.getObj(2) as Array)[0]));
                  pro.setValue(_loc1_ + _loc2_);
               }
            }
         }
         else if(state == 1)
         {
            if(strSlot.getObj(0) != null)
            {
               if(strSlot.getObj(2) == null)
               {
                  pro.setValue(StrData.getGemUpLevel((strSlot.getObj(0) as Array)[0]));
               }
               else
               {
                  _loc1_ = Number(StrData.getGemUpLevel((strSlot.getObj(0) as Array)[0]));
                  _loc2_ = Number(StrData.getLuckGemPosition((strSlot.getObj(2) as Array)[0]));
                  pro.setValue(_loc1_ + _loc2_);
               }
            }
         }
         if(pro.getValue() >= 100)
         {
            pro.setValue(100);
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
            if(Boolean(strSlot.addTj((strSlot.getObj(0) as Array)[0])) && Boolean(strSlot.addTj((strSlot.getObj(1) as Array)[0])))
            {
               if(Math.random() * ranNum.getValue() <= pro.getValue())
               {
                  addSx();
                  ShortTip.open(38);
                  AchData.setStrOkNum(ps);
               }
               else
               {
                  ShortTip.open(40);
                  AchData.setStrLostNum(ps);
               }
               removeGem();
               addBag(StrData.getEquipOrSkillGem());
               payGold();
            }
            else
            {
               stateTow = 0;
               strSlot.clearBag();
               addBag(StrData.getEquipOrSkillGem());
            }
            initFrameSlot();
            initFrame();
            getPro();
            proText();
            btnStr();
            strName();
            goldName();
            playerGold();
            QiangHuaJiaCheng();
            mast_hc.visible = false;
            Main.Save();
         }
      }
      
      private function removeGem() : void
      {
         var _loc1_:Gem = null;
         if(strSlot.getObj(1) != null)
         {
            _loc1_ = (strSlot.getObj(1) as Array)[0];
            data.getBag().delGem((strSlot.getObj(1) as Array)[1],1);
            if(data.getBag().getGemById(_loc1_.getId()) == null)
            {
               strSlot.clearOnly(1);
            }
         }
         if(strSlot.getObj(2) != null)
         {
            _loc1_ = (strSlot.getObj(2) as Array)[0];
            data.getBag().delGem((strSlot.getObj(2) as Array)[1],1);
            if(data.getBag().getGemById(_loc1_.getId()) == null)
            {
               strSlot.clearOnly(2);
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
         var _loc1_:Equip = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Gem = null;
         if(strSlot.getObj(0) != null && strSlot.getObj(1) != null)
         {
            _loc2_ = Number((strSlot.getObj(0) as Array)[1]);
            _loc3_ = Number((strSlot.getObj(0) as Array)[2]);
            _loc4_ = (strSlot.getObj(1) as Array)[0];
            if(_loc3_ == 0)
            {
               _loc1_ = data.getBag().getEquipFromBag(_loc2_);
            }
            else if(_loc3_ == 1)
            {
               _loc1_ = data.getEquipSlot().getEquipFromSlot(_loc2_);
            }
            StrData.strengthenOver(_loc1_,_loc4_);
         }
      }
      
      private function strGem() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Gem = null;
         var _loc3_:Gem = null;
         if(strSlot.getObj(0) != null && strSlot.getObj(1) != null)
         {
            _loc1_ = Number((strSlot.getObj(0) as Array)[1]);
            _loc2_ = (strSlot.getObj(0) as Array)[0];
            _loc3_ = StrData.strengthenSkillOver(_loc2_);
            data.getBag().delGem(_loc1_,1);
            data.getBag().addToGemBag(_loc3_,_loc1_);
            strSlot.addBag(new Array(_loc3_,_loc1_),0);
         }
      }
      
      private function strName() : void
      {
         var _loc1_:Object = null;
         str_name.text = "";
         if(strSlot.getObj(0) != null)
         {
            _loc1_ = (strSlot.getObj(0) as Array)[0];
            if(_loc1_ is Equip)
            {
               str_name.text = (_loc1_ as Equip).getName() + "+" + (_loc1_ as Equip).getReinforceLevel();
            }
            else if(_loc1_ is Gem)
            {
               str_name.text = (_loc1_ as Gem).getName() + "+" + (_loc1_ as Gem).getStrengthenLevel();
            }
         }
      }
      
      private function goldName() : void
      {
         gold_name.text = "";
         if(strSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               gold_name.text = StrData.getStrenthenGold((strSlot.getObj(0) as Array)[0]).toString();
            }
            else if(state == 1)
            {
               gold_name.text = StrData.getGemUpGold((strSlot.getObj(0) as Array)[0]).toString();
            }
         }
      }
      
      private function payGold() : void
      {
         if(strSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               data.payGold(StrData.getStrenthenGold((strSlot.getObj(0) as Array)[0]));
            }
            else if(state == 1)
            {
               data.payGold(StrData.getGemUpGold((strSlot.getObj(0) as Array)[0]));
            }
         }
      }
      
      private function playerGold() : void
      {
         player_gold.text = String(data.getGold());
      }
      
      private function QiangHuaJiaCheng() : *
      {
         var _loc1_:int = data.getEquipSlot().getSuitStrength();
         if(_loc1_ < 4)
         {
            strengthen.gotoAndStop(1);
            return;
         }
         switch(_loc1_)
         {
            case 4:
               strengthen.gotoAndStop(2);
               break;
            case 5:
               strengthen.gotoAndStop(3);
               break;
            case 6:
               strengthen.gotoAndStop(4);
               break;
            case 7:
               strengthen.gotoAndStop(5);
               break;
            case 8:
               strengthen.gotoAndStop(6);
               break;
            case 9:
               strengthen.gotoAndStop(7);
               break;
            case 10:
               strengthen.gotoAndStop(8);
         }
      }
   }
}

