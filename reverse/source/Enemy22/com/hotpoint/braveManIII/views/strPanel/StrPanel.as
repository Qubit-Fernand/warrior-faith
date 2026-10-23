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
         this.pro = VT.createVT(0);
         this.ranNum = VT.createVT(100);
         this.ps = 1;
         data = Main["player" + this.ps];
         state = 0;
         stateTow = 0;
         this.getEquipIng();
         this.p1orp2();
         this.addBag(StrData.getEquipOrSkillGem());
         this.initFrame();
         this.mc_ss.visible = false;
         this.strSlot.clearBag();
         this.initFrameSlot();
         this.btnChange();
         this.btnStata(0,2,"pla_");
         this.btnStr();
         this.getPro();
         this.proText();
         s1_mc.gotoAndStop(1);
         s2_mc.gotoAndStop(1);
         this.strName();
         this.goldName();
         this.playerGold();
         this.QiangHuaJiaCheng();
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
         var equip:Equip = null;
         for(var i:uint = 0; i < 8; i++)
         {
            if(data.getEquipSlot().getEquipFromSlot(i) != null)
            {
               equip = data.getEquipSlot().getEquipFromSlot(i);
               this["p_" + i].howNum.text = "";
               this["p_" + i].gotoAndStop(equip.getFrame());
            }
            else
            {
               this["p_" + i].howNum.text = "";
               this["p_" + i].gotoAndStop(1);
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
      
      private function btnStata(id:Number, num:Number, str:String) : void
      {
         this[str + id].isClick = true;
         for(var i:uint = 0; i < num; i++)
         {
            if(id != i)
            {
               this[str + i].isClick = false;
            }
         }
      }
      
      private function addBag(arr:Array) : void
      {
         var i:uint = 0;
         this.strBag.clearBag();
         if(arr != null)
         {
            for(i = 0; i < arr[0].length; i++)
            {
               this.strBag.addBag(arr[0][i],arr[1][i]);
            }
         }
      }
      
      private function initFrame() : void
      {
         var arr:Array = null;
         for(var i:uint = 0; i < 24; i++)
         {
            if(this.strBag.getObj(i) != null)
            {
               arr = this.strBag.getObj(i);
               this["b_" + i].howNum.text = "";
               this["b_" + i].gotoAndStop(arr[0].getFrame());
               if(arr[0] is Gem)
               {
                  if(arr[0].getIsPile())
                  {
                     this["b_" + i].howNum.text = arr[0].getTimes();
                  }
               }
            }
            else
            {
               this["b_" + i].gotoAndStop(1);
               this["b_" + i].howNum.text = "";
            }
         }
      }
      
      private function daoJuClick(e:DaoJuEvent) : void
      {
         var ob:Object = null;
         var arr:Array = null;
         var equip:Equip = null;
         var nameId:String = e.target.name.substr(0,2);
         var id:String = String(e.target.name).substr(2);
         if(nameId != "s_")
         {
            if(this.bo)
            {
               this.mc_ss.visible = true;
               this.mc_ss.x = e.target.x;
               this.mc_ss.y = e.target.y;
            }
            if(nameId == "b_")
            {
               if(this.strBag.getObj(id) != null)
               {
                  ob = (this.strBag.getObj(id) as Array)[0];
                  if(this.strSlot.addTj(ob))
                  {
                     this.strSlot.addBag(this.strBag.getObj(id),0);
                  }
               }
            }
            else if(nameId == "p_")
            {
               if(data.getEquipSlot().getEquipFromSlot(id) != null)
               {
                  arr = [];
                  equip = data.getEquipSlot().getEquipFromSlot(id);
                  if(state == 1)
                  {
                     this.strSlot.clearBag();
                     state = 0;
                     stateTow = 0;
                  }
                  arr = [equip,id];
                  if(this.strSlot.addTj(equip))
                  {
                     this.strSlot.addBag(arr,1);
                  }
               }
            }
         }
         else
         {
            this.strSlot.clearOnly(Number(id));
            this.mc_ss.visible = false;
         }
         this.initFrameSlot();
         this.changeBag();
         this.btnStr();
         this.getPro();
         this.proText();
         this.strName();
         this.goldName();
         this.playerGold();
      }
      
      private function proText() : void
      {
         if(this.pro.getValue() <= 0)
         {
            pro_text.text = "";
         }
         else
         {
            pro_text.text = String(this.pro.getValue()) + "%";
         }
      }
      
      private function changeBag() : void
      {
         if(this.strSlot.getObj(0) != null)
         {
            stateTow = 1;
         }
         else
         {
            stateTow = 0;
         }
         if(stateTow != this.oldStateTow)
         {
            this.mc_ss.visible = false;
            this.oldStateTow = stateTow;
         }
         this.addBag(StrData.getEquipOrSkillGem());
         this.btnChange();
         this.initFrame();
      }
      
      private function initFrameSlot() : void
      {
         var arr:Array = null;
         for(var i:uint = 0; i < 3; i++)
         {
            this["s_" + i].visible = false;
            if(this.strSlot.getObj(i) != null)
            {
               this["s_" + i].visible = true;
               arr = this.strSlot.getObj(i);
               this["s_" + i].howNum.text = "";
               this["s_" + i].gotoAndStop(arr[0].getFrame());
            }
         }
      }
      
      private function daoJuOver(e:DaoJuEvent) : void
      {
         var nameId:String = e.target.name.substr(0,2);
         var id:String = e.target.name.substr(2);
         var ob:Object = null;
         if(nameId == "b_" && this.strBag.getObj(id) != null)
         {
            ob = (this.strBag.getObj(id) as Array)[0];
         }
         else if(nameId == "p_" && data.getEquipSlot().getEquipFromSlot(id) != null)
         {
            ob = data.getEquipSlot().getEquipFromSlot(id);
         }
         else if(nameId == "s_" && this.strSlot.getObj(id) != null)
         {
            ob = (this.strSlot.getObj(id) as Array)[0];
         }
         if(ob != null)
         {
            this.tooltip.visible = true;
            this.tooltip.x = mouseX;
            this.tooltip.y = mouseY;
            if(ob is Equip)
            {
               this.tooltip.equipTooltip(ob as Equip);
            }
            else if(ob is Gem)
            {
               this.tooltip.gemTooltip(ob as Gem);
            }
         }
      }
      
      private function daoJuOut(e:DaoJuEvent) : void
      {
         this.tooltip.visible = false;
      }
      
      private function closeHandle(e:BtnEvent) : void
      {
         close();
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         this.timer.start();
         this.removeEvent();
         mast_hc.visible = true;
      }
      
      private function changeHandle(e:BtnEvent) : void
      {
         var nameId:String = e.target.name.substr(0,3);
         var id:String = e.target.name.substr(4,1);
         if(nameId == "str")
         {
            state = Number(id);
            stateTow = 0;
            this.oldStateTow = 0;
         }
         else if(nameId == "pla")
         {
            this.ps = Number(id) + 1;
            data = Main["player" + this.ps];
            this.btnStata(id,2,"pla_");
            state = 0;
            stateTow = 0;
            this.oldStateTow = 0;
            this.getEquipIng();
         }
         this.strSlot.clearBag();
         this.addBag(StrData.getEquipOrSkillGem());
         this.btnChange();
         this.initFrame();
         this.initFrameSlot();
         this.getPro();
         this.proText();
         this.strName();
         this.goldName();
         this.QiangHuaJiaCheng();
         this.btnStr();
         this.mc_ss.visible = false;
      }
      
      private function btnStr() : void
      {
         this.strBtn.gotoAndStop(2);
         if(this.strSlot.getObj(0) != null && this.strSlot.getObj(1) != null)
         {
            if(state == 0)
            {
               if(data.getGold() >= StrData.getStrenthenGold((this.strSlot.getObj(0) as Array)[0]))
               {
                  this.strBtn.gotoAndStop(1);
               }
            }
            else if(state == 1)
            {
               if(data.getGold() >= StrData.getGemUpGold((this.strSlot.getObj(0) as Array)[0]))
               {
                  this.strBtn.gotoAndStop(1);
               }
            }
         }
      }
      
      private function getPro() : void
      {
         var num1:Number = NaN;
         var num2:Number = NaN;
         this.pro.setValue(0);
         if(state == 0)
         {
            if(this.strSlot.getObj(0) != null && this.strSlot.getObj(1) != null)
            {
               if(this.strSlot.getObj(2) == null)
               {
                  this.pro.setValue(StrData.getEquipUpLevel((this.strSlot.getObj(0) as Array)[0],(this.strSlot.getObj(1) as Array)[0]));
               }
               else
               {
                  num1 = Number(StrData.getEquipUpLevel((this.strSlot.getObj(0) as Array)[0],(this.strSlot.getObj(1) as Array)[0]));
                  num2 = Number(StrData.getLuckGemPosition((this.strSlot.getObj(2) as Array)[0]));
                  this.pro.setValue(num1 + num2);
               }
            }
         }
         else if(state == 1)
         {
            if(this.strSlot.getObj(0) != null)
            {
               if(this.strSlot.getObj(2) == null)
               {
                  this.pro.setValue(StrData.getGemUpLevel((this.strSlot.getObj(0) as Array)[0]));
               }
               else
               {
                  num1 = Number(StrData.getGemUpLevel((this.strSlot.getObj(0) as Array)[0]));
                  num2 = Number(StrData.getLuckGemPosition((this.strSlot.getObj(2) as Array)[0]));
                  this.pro.setValue(num1 + num2);
               }
            }
         }
         if(this.pro.getValue() >= 100)
         {
            this.pro.setValue(100);
         }
      }
      
      private function onTimerHandle(e:TimerEvent) : void
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
            if(Boolean(this.strSlot.addTj((this.strSlot.getObj(0) as Array)[0])) && Boolean(this.strSlot.addTj((this.strSlot.getObj(1) as Array)[0])))
            {
               if(Math.random() * this.ranNum.getValue() <= this.pro.getValue())
               {
                  trace("强化成功");
                  this.addSx();
                  ShortTip.open(38);
                  AchData.setStrOkNum(this.ps);
               }
               else
               {
                  trace("强化失败");
                  ShortTip.open(40);
                  AchData.setStrLostNum(this.ps);
               }
               this.removeGem();
               this.addBag(StrData.getEquipOrSkillGem());
               this.payGold();
            }
            else
            {
               stateTow = 0;
               this.strSlot.clearBag();
               this.addBag(StrData.getEquipOrSkillGem());
               trace("归位");
            }
            this.initFrameSlot();
            this.initFrame();
            this.getPro();
            this.proText();
            this.btnStr();
            this.strName();
            this.goldName();
            this.playerGold();
            this.QiangHuaJiaCheng();
            mast_hc.visible = false;
            Main.Save();
         }
      }
      
      private function removeGem() : void
      {
         var gem:Gem = null;
         if(this.strSlot.getObj(1) != null)
         {
            gem = (this.strSlot.getObj(1) as Array)[0];
            data.getBag().delGem((this.strSlot.getObj(1) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
            {
               this.strSlot.clearOnly(1);
            }
         }
         if(this.strSlot.getObj(2) != null)
         {
            gem = (this.strSlot.getObj(2) as Array)[0];
            data.getBag().delGem((this.strSlot.getObj(2) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
            {
               this.strSlot.clearOnly(2);
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
         var equip:Equip = null;
         var point:Number = NaN;
         var who:Number = NaN;
         var gem:Gem = null;
         if(this.strSlot.getObj(0) != null && this.strSlot.getObj(1) != null)
         {
            point = Number((this.strSlot.getObj(0) as Array)[1]);
            who = Number((this.strSlot.getObj(0) as Array)[2]);
            gem = (this.strSlot.getObj(1) as Array)[0];
            trace(who + "who",point + "point");
            if(who == 0)
            {
               equip = data.getBag().getEquipFromBag(point);
            }
            else if(who == 1)
            {
               equip = data.getEquipSlot().getEquipFromSlot(point);
            }
            StrData.strengthenOver(equip,gem);
         }
      }
      
      private function strGem() : void
      {
         var point:Number = NaN;
         var oldGem:Gem = null;
         var gem:Gem = null;
         if(this.strSlot.getObj(0) != null && this.strSlot.getObj(1) != null)
         {
            point = Number((this.strSlot.getObj(0) as Array)[1]);
            oldGem = (this.strSlot.getObj(0) as Array)[0];
            gem = StrData.strengthenSkillOver(oldGem);
            data.getBag().delGem(point,1);
            data.getBag().addToGemBag(gem,point);
            this.strSlot.addBag(new Array(gem,point),0);
         }
      }
      
      private function strName() : void
      {
         var ob:Object = null;
         str_name.text = "";
         if(this.strSlot.getObj(0) != null)
         {
            ob = (this.strSlot.getObj(0) as Array)[0];
            if(ob is Equip)
            {
               str_name.text = (ob as Equip).getName() + "+" + (ob as Equip).getReinforceLevel();
            }
            else if(ob is Gem)
            {
               str_name.text = (ob as Gem).getName() + "+" + (ob as Gem).getStrengthenLevel();
            }
         }
      }
      
      private function goldName() : void
      {
         gold_name.text = "";
         if(this.strSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               gold_name.text = StrData.getStrenthenGold((this.strSlot.getObj(0) as Array)[0]).toString();
            }
            else if(state == 1)
            {
               gold_name.text = StrData.getGemUpGold((this.strSlot.getObj(0) as Array)[0]).toString();
            }
         }
      }
      
      private function payGold() : void
      {
         if(this.strSlot.getObj(0) != null)
         {
            if(state == 0)
            {
               data.payGold(StrData.getStrenthenGold((this.strSlot.getObj(0) as Array)[0]));
            }
            else if(state == 1)
            {
               data.payGold(StrData.getGemUpGold((this.strSlot.getObj(0) as Array)[0]));
            }
         }
      }
      
      private function playerGold() : void
      {
         player_gold.text = String(data.getGold());
      }
      
      private function QiangHuaJiaCheng() : *
      {
         var sLV:int = data.getEquipSlot().getSuitStrength();
         if(sLV < 4)
         {
            strengthen.gotoAndStop(1);
            return;
         }
         switch(sLV)
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

