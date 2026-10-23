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
         var pot1:uint = 0;
         var arr1:Array = null;
         var pot:uint = 0;
         var arr:Array = null;
         var equip:Equip = null;
         var nameId:String = e.target.name.substr(0,2);
         var id:Number = Number(String(e.target.name).substr(2));
         this.allObj = null;
         if(nameId != "s_")
         {
            this.mc_ss.visible = true;
            this.mc_ss.x = e.target.x;
            this.mc_ss.y = e.target.y;
            if(nameId == "b_")
            {
               if(this.strBag.getObj(id) != null)
               {
                  ob = (this.strBag.getObj(id) as Array)[0];
                  if(this.comSlot.addTj(ob))
                  {
                     if(state == 0)
                     {
                        if(stateTow == 1 && this.comSlot.getObj(1) != null && this.comSlot.getObj(1)[2] == 0)
                        {
                           data.getBag().addEquipBag(this.comSlot.getObj(1)[0]);
                           trace("槽里返回装备");
                        }
                        pot1 = uint(this.strBag.getObj(id)[1]);
                        arr1 = [data.getBag().delEquip(pot1),pot1];
                        this.comSlot.addBag(arr1,0);
                     }
                     else if(state == 1)
                     {
                        if(stateTow == 1 && this.comSlot.getObj(1) != null)
                        {
                           data.getBag().addGemBag(this.comSlot.getObj(1)[0]);
                        }
                        pot = uint(this.strBag.getObj(id)[1]);
                        arr = [data.getBag().delGem(pot,1),pot];
                        this.comSlot.addBag(arr,0);
                     }
                     this.allObj = this.comSlot.getObj(0)[0];
                  }
               }
            }
            else if(nameId == "p_")
            {
               if(ComData.getEquiping()[id] != null)
               {
                  arr = [];
                  equip = ComData.getEquiping()[id];
                  this.allObj = equip;
                  if(state == 0)
                  {
                     if(this.comSlot.getObj(0) != null)
                     {
                        if(this.comSlot.getObj(0)[2] != 1)
                        {
                           this.getChange(equip);
                        }
                        else if(this.comSlot.getObj(0)[1] != id)
                        {
                           this.getChange(equip);
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
                  arr = [equip,id];
                  if(this.comSlot.addTj(equip))
                  {
                     this.comSlot.addBag(arr,1);
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
            if(id == "0")
            {
               this.backGem();
               this.comSlot.clearBag();
               hc_0.text = "";
               hc_1.text = "";
               this.allObj = null;
            }
            else if(id == "1")
            {
               this.backGem(Number(id));
               this.allObj = this.comSlot.getObj(1)[0];
               this.comSlot.clearOnly(Number(id));
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
      
      private function getChange(equip:Equip) : void
      {
         if(ComData.towBo(equip.getId(),(this.comSlot.getObj(0)[0] as Equip).getId()))
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
      
      public function backGem(num:Number = -1) : void
      {
         if(num == -1)
         {
            this.backSlotOne();
            this.backSlotTow();
         }
         else if(num == 0)
         {
            this.backSlotOne();
         }
         else if(num == 1)
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
         for(var i:uint = 0; i < 4; i++)
         {
            this["s_" + i].visible = false;
            if(this.comSlot.getObj(i) != null && this.comSlot.getObj(i)[0] != null)
            {
               this["s_" + i].visible = true;
               this["s_" + i].howNum.text = "";
               this["s_" + i].gotoAndStop(this.comSlot.getObj(i)[0].getFrame());
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
         else if(nameId == "p_" && ComData.getEquiping() != null && ComData.getEquiping()[id] != null)
         {
            ob = ComData.getEquiping()[id];
         }
         else if(nameId == "s_" && this.comSlot.getObj(id) != null)
         {
            ob = (this.comSlot.getObj(id) as Array)[0];
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
            else if(ob is Otherobj)
            {
               this.tooltip.otherTooltip(ob as Otherobj);
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
         this.backGem();
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
         var gem:Gem = null;
         if(this.comSlot.getObj(1) != null)
         {
            gem = (this.comSlot.getObj(1) as Array)[0];
            data.getBag().delGem((this.comSlot.getObj(1) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
            {
               this.comSlot.clearOnly(1);
            }
         }
         if(this.comSlot.getObj(2) != null)
         {
            gem = (this.comSlot.getObj(2) as Array)[0];
            data.getBag().delGem((this.comSlot.getObj(2) as Array)[1],1);
            if(data.getBag().getGemById(gem.getId()) == null)
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
         var p1:Number = NaN;
         var who1:Number = NaN;
         var p2:Number = NaN;
         var who2:Number = NaN;
         var arr:Array = null;
         var p3:Number = NaN;
         if(this.comSlot.getObj(0) != null && this.comSlot.getObj(1) != null)
         {
            p1 = Number((this.comSlot.getObj(0) as Array)[1]);
            who1 = Number((this.comSlot.getObj(0) as Array)[2]);
            p2 = Number((this.comSlot.getObj(1) as Array)[1]);
            who2 = Number((this.comSlot.getObj(1) as Array)[2]);
            arr = ComData.getHcNum(this.allObj);
            p3 = Number((this.comSlot.getObj(2) as Array)[1]);
            if(who1 == 1)
            {
               data.getEquipSlot().delSlot(p1);
            }
            if(who2 == 1)
            {
               data.getEquipSlot().delSlot(p2);
            }
            data.getBag().delOtherById(63100,arr[0]);
            data.getBag().addEquipBag(this.comSlot.getObj(3)[0]);
            AchData.setHcNum(this.ps);
            AchData.setMadeById(3,(this.comSlot.getObj(3)[0] as Equip).getId(),this.ps,1);
            ShortTip.open(39);
         }
      }
      
      private function strGem() : void
      {
         var gem:Gem = null;
         var gemId:Number = NaN;
         if(this.comSlot.getObj(0) != null && this.comSlot.getObj(1) != null)
         {
            gem = this.comSlot.getObj(3)[0];
            gemId = gem.getId();
            if(data.getBag().canPutGemNum(gemId) > 0)
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
      }
      
      private function strName() : void
      {
         var ob:Object = null;
         for(var i:uint = 0; i < 4; i++)
         {
            this["strg_" + i].text = "";
            if(this.comSlot.getObj(i) != null && this.comSlot.getObj(i)[0] != null)
            {
               ob = (this.comSlot.getObj(i) as Array)[0];
               this["strg_" + i].text = ob.getName();
               if(ob.getColor() == 1)
               {
                  this["strg_" + i].setTextFormat(this.bai);
               }
               else if(ob.getColor() == 2)
               {
                  this["strg_" + i].setTextFormat(this.lan);
               }
               else if(ob.getColor() == 3)
               {
                  this["strg_" + i].setTextFormat(this.zi);
               }
               else if(ob.getColor() == 4)
               {
                  this["strg_" + i].setTextFormat(this.ch);
               }
            }
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

