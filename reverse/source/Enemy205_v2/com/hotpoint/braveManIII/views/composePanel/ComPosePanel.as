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
         var i:uint = 0;
         var equip:Equip = null;
         if(ComData.getEquiping() != null)
         {
            for(i = 0; i < 8; i++)
            {
               if(ComData.getEquiping()[i] != null)
               {
                  equip = ComData.getEquiping()[i];
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
         else
         {
            for(i = 0; i < 8; i++)
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
         var pot1:uint = 0;
         var arr1:Array = null;
         var pot:uint = 0;
         var arr:Array = null;
         var equip:Equip = null;
         var nameId:String = e.target.name.substr(0,2);
         var id:Number = Number(String(e.target.name).substr(2));
         allObj = null;
         if(nameId != "s_")
         {
            this.mc_ss.visible = true;
            this.mc_ss.x = e.target.x;
            this.mc_ss.y = e.target.y;
            if(nameId == "b_")
            {
               if(strBag.getObj(id) != null)
               {
                  ob = (strBag.getObj(id) as Array)[0];
                  if(comSlot.addTj(ob))
                  {
                     if(state == 0)
                     {
                        if(stateTow == 1 && comSlot.getObj(1) != null && comSlot.getObj(1)[2] == 0)
                        {
                           data.getBag().addEquipBag(comSlot.getObj(1)[0]);
                        }
                        pot1 = uint(strBag.getObj(id)[1]);
                        arr1 = [data.getBag().delEquip(pot1),pot1];
                        comSlot.addBag(arr1,0);
                     }
                     else if(state == 1)
                     {
                        if(stateTow == 1 && comSlot.getObj(1) != null)
                        {
                           data.getBag().addGemBag(comSlot.getObj(1)[0]);
                        }
                        pot = uint(strBag.getObj(id)[1]);
                        arr = [data.getBag().delGem(pot,1),pot];
                        comSlot.addBag(arr,0);
                     }
                     allObj = comSlot.getObj(0)[0];
                  }
               }
            }
            else if(nameId == "p_")
            {
               if(ComData.getEquiping()[id] != null)
               {
                  arr = [];
                  equip = ComData.getEquiping()[id];
                  allObj = equip;
                  if(state == 0)
                  {
                     if(comSlot.getObj(0) != null)
                     {
                        if(comSlot.getObj(0)[2] != 1)
                        {
                           getChange(equip);
                        }
                        else if(comSlot.getObj(0)[1] != id)
                        {
                           getChange(equip);
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
                  arr = [equip,id];
                  if(comSlot.addTj(equip))
                  {
                     comSlot.addBag(arr,1);
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
            if(id == "0")
            {
               backGem();
               comSlot.clearBag();
               hc_0.text = "";
               hc_1.text = "";
               allObj = null;
            }
            else if(id == "1")
            {
               backGem(Number(id));
               allObj = comSlot.getObj(1)[0];
               comSlot.clearOnly(Number(id));
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
      
      private function getChange(equip:Equip) : void
      {
         if(ComData.towBo(equip.getId(),(comSlot.getObj(0)[0] as Equip).getId()))
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
      
      public function backGem(num:Number = -1) : void
      {
         if(num == -1)
         {
            backSlotOne();
            backSlotTow();
         }
         else if(num == 0)
         {
            backSlotOne();
         }
         else if(num == 1)
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
         for(var i:uint = 0; i < 4; i++)
         {
            this["s_" + i].visible = false;
            if(comSlot.getObj(i) != null && comSlot.getObj(i)[0] != null)
            {
               this["s_" + i].visible = true;
               this["s_" + i].howNum.text = "";
               this["s_" + i].gotoAndStop(comSlot.getObj(i)[0].getFrame());
            }
         }
      }
      
      private function daoJuOver(e:DaoJuEvent) : void
      {
         var nameId:String = e.target.name.substr(0,2);
         var id:String = e.target.name.substr(2);
         var ob:Object = null;
         if(nameId == "b_" && strBag.getObj(id) != null)
         {
            ob = (strBag.getObj(id) as Array)[0];
         }
         else if(nameId == "p_" && ComData.getEquiping() != null && ComData.getEquiping()[id] != null)
         {
            ob = ComData.getEquiping()[id];
         }
         else if(nameId == "s_" && comSlot.getObj(id) != null)
         {
            ob = (comSlot.getObj(id) as Array)[0];
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
            else if(ob is Otherobj)
            {
               tooltip.otherTooltip(ob as Otherobj);
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
         backGem();
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
         var gem:Gem = null;
         if(comSlot.getObj(1) != null)
         {
            gem = (comSlot.getObj(1) as Array)[0];
            data.getBag().delGem((comSlot.getObj(1) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
            {
               comSlot.clearOnly(1);
            }
         }
         if(comSlot.getObj(2) != null)
         {
            gem = (comSlot.getObj(2) as Array)[0];
            data.getBag().delGem((comSlot.getObj(2) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
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
         var p1:Number = NaN;
         var who1:Number = NaN;
         var p2:Number = NaN;
         var who2:Number = NaN;
         var arr:Array = null;
         var p3:Number = NaN;
         if(comSlot.getObj(0) != null && comSlot.getObj(1) != null)
         {
            p1 = Number((comSlot.getObj(0) as Array)[1]);
            who1 = Number((comSlot.getObj(0) as Array)[2]);
            p2 = Number((comSlot.getObj(1) as Array)[1]);
            who2 = Number((comSlot.getObj(1) as Array)[2]);
            arr = ComData.getHcNum(allObj);
            p3 = Number((comSlot.getObj(2) as Array)[1]);
            if(who1 == 1)
            {
               data.getEquipSlot().delSlot(p1);
            }
            if(who2 == 1)
            {
               data.getEquipSlot().delSlot(p2);
            }
            data.getBag().delOtherById(63100,arr[0]);
            data.getBag().addEquipBag(comSlot.getObj(3)[0]);
            AchData.setHcNum(ps);
            AchData.setMadeById(3,(comSlot.getObj(3)[0] as Equip).getId(),ps,1);
            ShortTip.open(39);
         }
      }
      
      private function strGem() : void
      {
         var gem:Gem = null;
         var gemId:Number = NaN;
         if(comSlot.getObj(0) != null && comSlot.getObj(1) != null)
         {
            gem = comSlot.getObj(3)[0];
            gemId = gem.getId();
            if(data.getBag().canPutGemNum(gemId) > 0)
            {
               data.getBag().delOtherById(63100,1);
               data.getBag().addGemBag(comSlot.getObj(3)[0]);
               ShortTip.open(39);
               AchData.setHcNum(ps);
               AchData.setMadeById(3,(comSlot.getObj(3)[0] as Gem).getId(),ps,1);
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
         var ob:Object = null;
         for(var i:uint = 0; i < 4; i++)
         {
            this["strg_" + i].text = "";
            if(comSlot.getObj(i) != null && comSlot.getObj(i)[0] != null)
            {
               ob = (comSlot.getObj(i) as Array)[0];
               this["strg_" + i].text = ob.getName();
               if(ob.getColor() == 1)
               {
                  this["strg_" + i].setTextFormat(bai);
               }
               else if(ob.getColor() == 2)
               {
                  this["strg_" + i].setTextFormat(lan);
               }
               else if(ob.getColor() == 3)
               {
                  this["strg_" + i].setTextFormat(zi);
               }
               else if(ob.getColor() == 4)
               {
                  this["strg_" + i].setTextFormat(ch);
               }
            }
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

