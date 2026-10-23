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
         var xx:uint = 0;
         var equip:Equip = null;
         for(var i:uint = 0; i < 8; i++)
         {
            xx = i;
            if((i == 0 || i == 1 || i == 3 || i == 4) && Main.water.getValue() != 1)
            {
               xx += 8;
            }
            equip = data.getEquipSlot().getEquipFromSlot(xx);
            if(equip != null)
            {
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
         btnStata(state,2,"str_");
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
         strBag.clearBag();
         if(arr != null)
         {
            for(i = 0; i < arr[0].length; i++)
            {
               strBag.addBag(arr[0][i],arr[1][i]);
            }
         }
      }
      
      private function initFrame() : void
      {
         var arr:Array = null;
         for(var i:uint = 0; i < 24; i++)
         {
            if(strBag.getObj(i) != null)
            {
               arr = strBag.getObj(i);
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
         var xx:uint = 0;
         var equip:Equip = null;
         var arr:Array = null;
         var nameId:String = e.target.name.substr(0,2);
         var id:String = String(e.target.name).substr(2);
         if(nameId != "s_")
         {
            if(bo)
            {
               this.mc_ss.visible = true;
               this.mc_ss.x = e.target.x;
               this.mc_ss.y = e.target.y;
            }
            if(nameId == "b_")
            {
               if(strBag.getObj(id) != null)
               {
                  ob = (strBag.getObj(id) as Array)[0];
                  if(strSlot.addTj(ob))
                  {
                     strSlot.addBag(strBag.getObj(id),0);
                  }
               }
            }
            else if(nameId == "p_")
            {
               if(data.getEquipSlot().getEquipFromSlot(id) != null)
               {
                  xx = uint(id);
                  if((id == 0 || id == 1 || id == 3 || id == 4) && Main.water.getValue() != 1)
                  {
                     xx += 8;
                  }
                  equip = data.getEquipSlot().getEquipFromSlot(xx);
                  if(state == 1)
                  {
                     strSlot.clearBag();
                     state = 0;
                     stateTow = 0;
                  }
                  arr = [equip,xx];
                  if(strSlot.addTj(equip))
                  {
                     strSlot.addBag(arr,1);
                  }
               }
            }
         }
         else
         {
            strSlot.clearOnly(Number(id));
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
         var arr:Array = null;
         for(var i:uint = 0; i < 3; i++)
         {
            this["s_" + i].visible = false;
            if(strSlot.getObj(i) != null)
            {
               this["s_" + i].visible = true;
               arr = strSlot.getObj(i);
               this["s_" + i].howNum.text = "";
               this["s_" + i].gotoAndStop(arr[0].getFrame());
            }
         }
      }
      
      private function daoJuOver(e:DaoJuEvent) : void
      {
         var xx:uint = 0;
         var nameId:String = e.target.name.substr(0,2);
         var id:String = e.target.name.substr(2);
         var ob:Object = null;
         if(nameId == "b_" && strBag.getObj(id) != null)
         {
            ob = (strBag.getObj(id) as Array)[0];
         }
         else if(nameId == "p_" && data.getEquipSlot().getEquipFromSlot(id) != null)
         {
            xx = uint(id);
            if((id == 0 || id == 1 || id == 3 || id == 4) && Main.water.getValue() != 1)
            {
               xx += 8;
            }
            ob = data.getEquipSlot().getEquipFromSlot(xx);
         }
         else if(nameId == "s_" && strSlot.getObj(id) != null)
         {
            ob = (strSlot.getObj(id) as Array)[0];
         }
         if(ob != null)
         {
            tooltip.visible = true;
            tooltip.x = mouseX;
            tooltip.y = mouseY;
            if(ob is Equip)
            {
               tooltip.equipTooltip(ob as Equip);
            }
            else if(ob is Gem)
            {
               tooltip.gemTooltip(ob as Gem);
            }
         }
      }
      
      private function daoJuOut(e:DaoJuEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function closeHandle(e:BtnEvent) : void
      {
         close();
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         timer.start();
         removeEvent();
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
            oldStateTow = 0;
         }
         else if(nameId == "pla")
         {
            ps = Number(id) + 1;
            data = Main["player" + ps];
            btnStata(id,2,"pla_");
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
         var num1:Number = NaN;
         var num2:Number = NaN;
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
                  num1 = Number(StrData.getEquipUpLevel((strSlot.getObj(0) as Array)[0],(strSlot.getObj(1) as Array)[0]));
                  num2 = Number(StrData.getLuckGemPosition((strSlot.getObj(2) as Array)[0]));
                  pro.setValue(num1 + num2);
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
                  num1 = Number(StrData.getGemUpLevel((strSlot.getObj(0) as Array)[0]));
                  num2 = Number(StrData.getLuckGemPosition((strSlot.getObj(2) as Array)[0]));
                  pro.setValue(num1 + num2);
               }
            }
         }
         if(pro.getValue() >= 100)
         {
            pro.setValue(100);
         }
      }
      
      private function onTimerHandle(e:TimerEvent) : void
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
                  trace("强化成功");
                  addSx();
                  ShortTip.open(38);
                  AchData.setStrOkNum(ps);
               }
               else
               {
                  trace("强化失败");
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
               trace("归位");
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
         var gem:Gem = null;
         if(strSlot.getObj(1) != null)
         {
            gem = (strSlot.getObj(1) as Array)[0];
            data.getBag().delGem((strSlot.getObj(1) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
            {
               strSlot.clearOnly(1);
            }
         }
         if(strSlot.getObj(2) != null)
         {
            gem = (strSlot.getObj(2) as Array)[0];
            data.getBag().delGem((strSlot.getObj(2) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
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
         var equip:Equip = null;
         var point:Number = NaN;
         var who:Number = NaN;
         var gem:Gem = null;
         if(strSlot.getObj(0) != null && strSlot.getObj(1) != null)
         {
            point = Number((strSlot.getObj(0) as Array)[1]);
            who = Number((strSlot.getObj(0) as Array)[2]);
            gem = (strSlot.getObj(1) as Array)[0];
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
         if(strSlot.getObj(0) != null && strSlot.getObj(1) != null)
         {
            point = Number((strSlot.getObj(0) as Array)[1]);
            oldGem = (strSlot.getObj(0) as Array)[0];
            gem = StrData.strengthenSkillOver(oldGem);
            data.getBag().delGem(point,1);
            data.getBag().addToGemBag(gem,point);
            strSlot.addBag(new Array(gem,point),0);
         }
      }
      
      private function strName() : void
      {
         var ob:Object = null;
         str_name.text = "";
         if(strSlot.getObj(0) != null)
         {
            ob = (strSlot.getObj(0) as Array)[0];
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

