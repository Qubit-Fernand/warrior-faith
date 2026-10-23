package com.hotpoint.braveManIII.views.elvesPanel
{
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class ElvesPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var elp:ElvesPanel;
      
      public static var myplayer:PlayerData;
      
      public static var CZJLOK:Boolean = false;
      
      public static var blueOK:Boolean = false;
      
      public static var pinkOK:Boolean = false;
      
      public static var goldOK:Boolean = false;
      
      public static var elvesPanel:MovieClip = new JLShow();
      
      public static var clickNum:Number = 0;
      
      public static var changeNum:Number = 1;
      
      public static var typeTemp:Number = -1;
      
      public function ElvesPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(elvesPanel);
      }
      
      public static function open(param1:PlayerData) : void
      {
         Main.DuoKai_Fun();
         Main.allClosePanel();
         if(elp == null)
         {
            elp = new ElvesPanel();
         }
         myplayer = param1;
         Main.stopXX = true;
         elp.x = 0;
         elp.y = 0;
         addListenerP1();
         Main._stage.addChild(elp);
         elp.visible = true;
      }
      
      public static function close() : void
      {
         if(elp == null)
         {
            elp = new ElvesPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         elp.visible = false;
      }
      
      public static function closeJL(param1:*) : *
      {
         close();
      }
      
      public static function addListenerP1() : *
      {
         elvesPanel["elvesTip"].visible = false;
         elvesPanel["NoMoney_mc"].visible = false;
         elvesPanel["blueRMB"].visible = false;
         elvesPanel["pinkRMB"].visible = false;
         elvesPanel["goldRMB"].visible = false;
         elvesPanel["czRMB"].visible = false;
         elvesPanel["isfangsheng"].visible = false;
         elvesPanel["fanhui"].visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            elvesPanel["e" + _loc1_].mouseChildren = false;
            elvesPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            elvesPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            elvesPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            elvesPanel["e" + _loc1_].visible = false;
            _loc1_++;
         }
         elvesPanel["isfangsheng"]["yes_btn"].addEventListener(MouseEvent.CLICK,fsYES);
         elvesPanel["isfangsheng"]["no_btn"].addEventListener(MouseEvent.CLICK,fsNO);
         elvesPanel["fanhui"]["yes_btn"].addEventListener(MouseEvent.CLICK,fhYES);
         elvesPanel["fanhui"]["no_btn"].addEventListener(MouseEvent.CLICK,fhNO);
         elvesPanel["NoMoney_mc"]["yes_btn"].addEventListener(MouseEvent.CLICK,closeNORMB);
         elvesPanel["NoMoney_mc"]["addMoney_btn"].addEventListener(MouseEvent.CLICK,addMoney_btn);
         elvesPanel["blueRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,blueYES);
         elvesPanel["blueRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,blueNO);
         elvesPanel["pinkRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,pinkYES);
         elvesPanel["pinkRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,pinkNO);
         elvesPanel["goldRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,goldYES);
         elvesPanel["goldRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,goldNO);
         elvesPanel["czRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,czYES);
         elvesPanel["czRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,czNO);
         elvesPanel["xishou"].addEventListener(MouseEvent.CLICK,fanhui);
         elvesPanel["chongzhi"].addEventListener(MouseEvent.CLICK,chongzhi);
         elvesPanel["xishouNow"].addEventListener(MouseEvent.CLICK,xishouNow);
         elvesPanel["hp_btn"].addEventListener(MouseEvent.CLICK,hp_btn);
         elvesPanel["mp_btn"].addEventListener(MouseEvent.CLICK,mp_btn);
         elvesPanel["att_btn"].addEventListener(MouseEvent.CLICK,att_btn);
         elvesPanel["def_btn"].addEventListener(MouseEvent.CLICK,def_btn);
         elvesPanel["crit_btn"].addEventListener(MouseEvent.CLICK,crit_btn);
         elvesPanel["eInput"]["inputOK"].addEventListener(MouseEvent.CLICK,inputOK);
         elvesPanel["eInput"].visible = false;
         elvesPanel["blue"].addEventListener(MouseEvent.CLICK,blue);
         elvesPanel["pink"].addEventListener(MouseEvent.CLICK,pink);
         elvesPanel["gold"].addEventListener(MouseEvent.CLICK,gold);
         elvesPanel["zhaohuan"].addEventListener(MouseEvent.CLICK,zhaohuan);
         elvesPanel["fangsheng"].addEventListener(MouseEvent.CLICK,fangsheng);
         elvesPanel["close"].addEventListener(MouseEvent.CLICK,closeJL);
         if(myplayer.playerJL_Data)
         {
            clickNum = myplayer.getElvesSlot().backChoseElvesId(myplayer.playerJL_Data);
         }
         else
         {
            clickNum = myplayer.getElvesSlot().backElvesId();
         }
         showJL();
         showElvesAll();
         blueShow();
      }
      
      public static function removeListenerP1() : *
      {
      }
      
      private static function tooltipClose(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         elvesPanel.addChild(itemsTooltip);
         var _loc3_:uint = uint(_loc2_.name.substr(1,2));
         var _loc4_:String = _loc2_.name.substr(0,1);
         if(_loc4_ == "e")
         {
            if(myplayer.getBag().getEquipFromBag(_loc3_) != null)
            {
               itemsTooltip.equipTooltip(myplayer.getBag().getEquipFromBag(_loc3_),1);
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = elvesPanel.mouseX + 30;
         itemsTooltip.y = elvesPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      public static function inputOK(param1:*) : *
      {
         var _loc2_:int = 0;
         if(elvesPanel["eInput"]["input"].text > 0 && elvesPanel["eInput"]["input"].text <= myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint())
         {
            _loc2_ = int(elvesPanel["eInput"]["input"].text);
            switch(typeTemp)
            {
               case 0:
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setHP(_loc2_);
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint(-_loc2_);
                  break;
               case 1:
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setMP(_loc2_);
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint(-_loc2_);
                  break;
               case 2:
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setATT(_loc2_);
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint(-_loc2_);
                  break;
               case 3:
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setDEF(_loc2_);
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint(-_loc2_);
                  break;
               case 4:
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setCRIT(_loc2_);
                  myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint(-_loc2_);
            }
         }
         elvesPanel["eInput"].visible = false;
         showElvesAll();
      }
      
      public static function hp_btn(param1:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() < 100)
            {
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setHP();
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
            }
            else
            {
               elvesPanel["eInput"].visible = true;
               typeTemp = 0;
            }
         }
         showElvesAll();
      }
      
      public static function mp_btn(param1:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() < 100)
            {
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setMP();
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
            }
            else
            {
               elvesPanel["eInput"].visible = true;
               typeTemp = 1;
            }
         }
         showElvesAll();
      }
      
      public static function att_btn(param1:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() < 100)
            {
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setATT();
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
            }
            else
            {
               elvesPanel["eInput"].visible = true;
               typeTemp = 2;
            }
         }
         showElvesAll();
      }
      
      public static function def_btn(param1:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() < 100)
            {
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setDEF();
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
            }
            else
            {
               elvesPanel["eInput"].visible = true;
               typeTemp = 3;
            }
         }
         showElvesAll();
      }
      
      public static function crit_btn(param1:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() < 100)
            {
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setCRIT();
               myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
            }
            else
            {
               elvesPanel["eInput"].visible = true;
               typeTemp = 4;
            }
         }
         showElvesAll();
      }
      
      private static function tipClose(param1:*) : *
      {
         elvesPanel["elvesTip"].visible = false;
      }
      
      private static function tipOpen(param1:*) : *
      {
         var _loc2_:String = (param1.target as MovieClip).name.toString();
         switch(_loc2_)
         {
            case "jl0":
               elvesPanel["elvesTip"]["str_name"].text = myplayer.getElvesSlot().getElvesFromSlot(0).getName();
               setColor(myplayer.getElvesSlot().getElvesFromSlot(0).getColor());
               elvesPanel["elvesTip"]["sudu"].text = myplayer.getElvesSlot().getElvesFromSlot(0).getTimeBuff() + "秒";
               elvesPanel["elvesTip"]["blue"].text = myplayer.getElvesSlot().getElvesFromSlot(0).getBlueNum() + "件";
               elvesPanel["elvesTip"]["pink"].text = myplayer.getElvesSlot().getElvesFromSlot(0).getPinkNum() + "件";
               elvesPanel["elvesTip"]["gold"].text = myplayer.getElvesSlot().getElvesFromSlot(0).getGoldNum() + "件";
               break;
            case "jl1":
               elvesPanel["elvesTip"]["str_name"].text = myplayer.getElvesSlot().getElvesFromSlot(1).getName();
               setColor(myplayer.getElvesSlot().getElvesFromSlot(1).getColor());
               elvesPanel["elvesTip"]["sudu"].text = myplayer.getElvesSlot().getElvesFromSlot(1).getTimeBuff() + "秒";
               elvesPanel["elvesTip"]["blue"].text = myplayer.getElvesSlot().getElvesFromSlot(1).getBlueNum() + "件";
               elvesPanel["elvesTip"]["pink"].text = myplayer.getElvesSlot().getElvesFromSlot(1).getPinkNum() + "件";
               elvesPanel["elvesTip"]["gold"].text = myplayer.getElvesSlot().getElvesFromSlot(1).getGoldNum() + "件";
               break;
            case "jl2":
               elvesPanel["elvesTip"]["str_name"].text = myplayer.getElvesSlot().getElvesFromSlot(2).getName();
               setColor(myplayer.getElvesSlot().getElvesFromSlot(2).getColor());
               elvesPanel["elvesTip"]["sudu"].text = myplayer.getElvesSlot().getElvesFromSlot(2).getTimeBuff() + "秒";
               elvesPanel["elvesTip"]["blue"].text = myplayer.getElvesSlot().getElvesFromSlot(2).getBlueNum() + "件";
               elvesPanel["elvesTip"]["pink"].text = myplayer.getElvesSlot().getElvesFromSlot(2).getPinkNum() + "件";
               elvesPanel["elvesTip"]["gold"].text = myplayer.getElvesSlot().getElvesFromSlot(2).getGoldNum() + "件";
               break;
            case "jl3":
               elvesPanel["elvesTip"]["str_name"].text = myplayer.getElvesSlot().getElvesFromSlot(3).getName();
               setColor(myplayer.getElvesSlot().getElvesFromSlot(3).getColor());
               elvesPanel["elvesTip"]["sudu"].text = myplayer.getElvesSlot().getElvesFromSlot(3).getTimeBuff() + "秒";
               elvesPanel["elvesTip"]["blue"].text = myplayer.getElvesSlot().getElvesFromSlot(3).getBlueNum() + "件";
               elvesPanel["elvesTip"]["pink"].text = myplayer.getElvesSlot().getElvesFromSlot(3).getPinkNum() + "件";
               elvesPanel["elvesTip"]["gold"].text = myplayer.getElvesSlot().getElvesFromSlot(3).getGoldNum() + "件";
               break;
            case "jl4":
               elvesPanel["elvesTip"]["str_name"].text = myplayer.getElvesSlot().getElvesFromSlot(4).getName();
               setColor(myplayer.getElvesSlot().getElvesFromSlot(4).getColor());
               elvesPanel["elvesTip"]["sudu"].text = myplayer.getElvesSlot().getElvesFromSlot(4).getTimeBuff() + "秒";
               elvesPanel["elvesTip"]["blue"].text = myplayer.getElvesSlot().getElvesFromSlot(4).getBlueNum() + "件";
               elvesPanel["elvesTip"]["pink"].text = myplayer.getElvesSlot().getElvesFromSlot(4).getPinkNum() + "件";
               elvesPanel["elvesTip"]["gold"].text = myplayer.getElvesSlot().getElvesFromSlot(4).getGoldNum() + "件";
         }
         elvesPanel["elvesTip"].visible = true;
         elvesPanel.addChild(elvesPanel["elvesTip"]);
         elvesPanel["elvesTip"].x = elvesPanel.mouseX + 10;
      }
      
      private static function setColor(param1:int) : void
      {
         if(param1 == 1)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0xffffff");
         }
         if(param1 == 2)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0x0066ff");
         }
         if(param1 == 3)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0xFF33FF");
         }
         if(param1 == 4)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0xFF9900");
         }
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      public static function showJL() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            elvesPanel["jl" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tipClose);
            elvesPanel["jl" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tipOpen);
            elvesPanel["jl" + _loc1_].addEventListener(MouseEvent.CLICK,choseElves);
            if(myplayer.getElvesSlot().getElvesFromSlot(_loc1_))
            {
               elvesPanel["jl" + _loc1_].visible = true;
               elvesPanel["jl" + _loc1_].gotoAndStop(myplayer.getElvesSlot().getElvesFromSlot(_loc1_).getFrame());
            }
            else
            {
               elvesPanel["jl" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function showElvesAll() : *
      {
         if(myplayer.getElvesSlot().backElvesNum() == 0)
         {
            showAllFalse();
            return;
         }
         elvesPanel["hp_p"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getHP();
         elvesPanel["mp_p"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getMP();
         elvesPanel["att_p"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getATT();
         elvesPanel["def_p"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getDEF();
         elvesPanel["crit_p"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getCRIT();
         elvesPanel["allpoint"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint();
         elvesPanel["hp"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getHP() * 13.3);
         elvesPanel["mp"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getMP() * 8.8);
         elvesPanel["att"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getATT());
         elvesPanel["def"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getDEF() * 1.9);
         elvesPanel["crit"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getCRIT() * 7.3);
         elvesPanel["mygold"].text = myplayer.getGold();
         elvesPanel["killP"].text = myplayer.getKillPoint();
         elvesPanel["chose"].x = elvesPanel["jl" + clickNum].x - 12;
         elvesPanel["chose"].y = elvesPanel["jl" + clickNum].y - 2;
         elvesPanel["chose"].visible = true;
         elvesPanel["zhaohuan"].visible = true;
         elvesPanel["fangsheng"].visible = true;
         elvesPanel["chose"].visible = true;
         elvesPanel["select"].visible = true;
         elvesPanel["select"].gotoAndStop(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getFrame());
         showLV(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getLevel());
         elvesPanel["jyt"]["zd"].scaleX = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getEXP() / (myplayer.getElvesSlot().getElvesFromSlot(clickNum).getLevel() * 15);
         elvesPanel["exp_txt"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getEXP() + "/" + myplayer.getElvesSlot().getElvesFromSlot(clickNum).getLevel() * 15;
         if(changeNum == 1)
         {
            blueShow();
         }
         else if(changeNum == 2)
         {
            pinkShow();
         }
         else
         {
            goldShow();
         }
      }
      
      public static function showAllFalse() : *
      {
         elvesPanel["zhaohuan"].visible = false;
         elvesPanel["fangsheng"].visible = false;
         elvesPanel["shiwei"].visible = false;
         elvesPanel["gewei"].visible = false;
         elvesPanel["select"].visible = false;
         elvesPanel["chose"].visible = false;
      }
      
      public static function choseElves(param1:*) : *
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         clickNum = uint(_loc2_.name.substr(2,2));
         showElvesAll();
      }
      
      public static function selected(param1:*) : *
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Number = uint(_loc2_.name.substr(1,2));
         if(changeNum == 1 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquip() == null && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquipNum() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setBlueEquip(myplayer.getBag().delEquip(_loc3_));
            blueShow();
         }
         else if(changeNum == 2 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquip() == null && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquipNum() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setPinkEquip(myplayer.getBag().delEquip(_loc3_));
            pinkShow();
         }
         else if(changeNum == 3 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquip() == null && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquipNum() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setGoldEquip(myplayer.getBag().delEquip(_loc3_));
            goldShow();
         }
         else
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"吸收装备已达到上限，无法继续吸收");
         }
         showElvesAll();
      }
      
      private static function fanhui(param1:*) : *
      {
         elvesPanel["fanhui"].visible = true;
      }
      
      private static function fhYES(param1:*) : *
      {
         if(changeNum == 1 && Boolean(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquip()))
         {
            myplayer.getBag().addEquipBag(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquip());
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).delBlueEquip();
            blueShow();
         }
         if(changeNum == 2 && Boolean(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquip()))
         {
            myplayer.getBag().addEquipBag(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquip());
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).delPinkEquip();
            pinkShow();
         }
         if(changeNum == 3 && Boolean(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquip()))
         {
            myplayer.getBag().addEquipBag(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquip());
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).delGoldEquip();
            goldShow();
         }
         showElvesAll();
         elvesPanel["fanhui"].visible = false;
      }
      
      private static function fhNO(param1:*) : *
      {
         elvesPanel["fanhui"].visible = false;
      }
      
      private static function fsYES(param1:*) : *
      {
         if(myplayer == Main.player1)
         {
            if(Main.player_1.playerJL)
            {
               Main.player_1.playerJL.Close();
            }
         }
         if(myplayer == Main.player2)
         {
            if(Main.player_2.playerJL)
            {
               Main.player_2.playerJL.Close();
            }
         }
         myplayer.getElvesSlot().delElvesSlot(clickNum);
         elvesPanel["chose"].visible = true;
         clickNum = myplayer.getElvesSlot().backElvesId();
         showElvesAll();
         showJL();
         elvesPanel["isfangsheng"].visible = false;
         if(myplayer.getElvesSlot().backElvesNum() == 0)
         {
            close();
         }
      }
      
      private static function fsNO(param1:*) : *
      {
         elvesPanel["isfangsheng"].visible = false;
      }
      
      private static function fangsheng(param1:*) : *
      {
         elvesPanel["isfangsheng"].visible = true;
      }
      
      private static function zhaohuan(param1:*) : *
      {
         if(myplayer == Main.player1)
         {
            Main.player_1.NewJL(myplayer.getElvesSlot().getElvesFromSlot(clickNum));
         }
         else
         {
            Main.player_2.NewJL(myplayer.getElvesSlot().getElvesFromSlot(clickNum));
         }
      }
      
      private static function blue(param1:*) : *
      {
         blueShow();
      }
      
      private static function blueShow() : *
      {
         elvesPanel["blue"].visible = false;
         elvesPanel["pink"].visible = true;
         elvesPanel["gold"].visible = true;
         changeNum = 1;
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(Boolean(myplayer.getBag().getEquipFromBag(_loc2_)) && Boolean(myplayer.getBag().getEquipFromBag(_loc2_).getColor() == 2) && myplayer.getBag().getEquipFromBag(_loc2_).getDressLevel() >= myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueLV())
            {
               _loc1_++;
               elvesPanel["e" + _loc2_].visible = true;
               elvesPanel["e" + _loc2_].gotoAndStop(myplayer.getBag().getEquipFromBag(_loc2_).getFrame());
            }
            else
            {
               elvesPanel["e" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         if(_loc1_ == 0)
         {
            elvesPanel["tishi"].visible = true;
         }
         else
         {
            elvesPanel["tishi"].visible = false;
         }
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquip())
         {
            elvesPanel["xishou"].visible = true;
            elvesPanel["xishou"].gotoAndStop(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquip().getFrame());
         }
         else
         {
            elvesPanel["xishou"].visible = false;
         }
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquip() == null)
         {
            elvesPanel["time_txt"].text = int((1800 - myplayer.getElvesSlot().getElvesFromSlot(clickNum).getTimeBuff()) / 60) + ":" + (1800 - myplayer.getElvesSlot().getElvesFromSlot(clickNum).getTimeBuff()) % 60;
         }
         else
         {
            elvesPanel.addEventListener(Event.ENTER_FRAME,blueTime);
         }
         elvesPanel["color_txt"].text = "蓝色";
         ColorX(elvesPanel["color_txt"],"0x0066ff");
         elvesPanel["limit_txt"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquipNum() + "件" + myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueLV() + "级";
         elvesPanel["reward_txt"].text = "1点精灵点数。";
      }
      
      private static function blueTime(param1:*) : *
      {
         if(changeNum == 1)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueCD() < 0)
            {
               blueShow();
               showElvesAll();
               elvesPanel.removeEventListener(Event.ENTER_FRAME,blueTime);
            }
            else
            {
               elvesPanel["time_txt"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueCD() / 60) + ":" + myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueCD() % 60;
            }
         }
      }
      
      private static function pink(param1:*) : *
      {
         pinkShow();
      }
      
      private static function pinkShow() : *
      {
         elvesPanel["blue"].visible = true;
         elvesPanel["pink"].visible = false;
         elvesPanel["gold"].visible = true;
         changeNum = 2;
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(Boolean(myplayer.getBag().getEquipFromBag(_loc2_)) && Boolean(myplayer.getBag().getEquipFromBag(_loc2_).getColor() == 3) && myplayer.getBag().getEquipFromBag(_loc2_).getDressLevel() >= myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkLV())
            {
               _loc1_++;
               elvesPanel["e" + _loc2_].visible = true;
               elvesPanel["e" + _loc2_].gotoAndStop(myplayer.getBag().getEquipFromBag(_loc2_).getFrame());
            }
            else
            {
               elvesPanel["e" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         if(_loc1_ == 0)
         {
            elvesPanel["tishi"].visible = true;
         }
         else
         {
            elvesPanel["tishi"].visible = false;
         }
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquip())
         {
            elvesPanel["xishou"].visible = true;
            elvesPanel["xishou"].gotoAndStop(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquip().getFrame());
         }
         else
         {
            elvesPanel["xishou"].visible = false;
         }
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquip() == null)
         {
            elvesPanel["time_txt"].text = int((2400 - myplayer.getElvesSlot().getElvesFromSlot(clickNum).getTimeBuff()) / 60) + ":" + (2400 - myplayer.getElvesSlot().getElvesFromSlot(clickNum).getTimeBuff()) % 60;
         }
         else
         {
            elvesPanel.addEventListener(Event.ENTER_FRAME,pinkTime);
         }
         elvesPanel["color_txt"].text = "粉色";
         ColorX(elvesPanel["color_txt"],"0xFF33FF");
         elvesPanel["limit_txt"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquipNum() + "件" + myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkLV() + "级";
         elvesPanel["reward_txt"].text = "2点精灵点数。";
      }
      
      private static function pinkTime(param1:*) : *
      {
         if(changeNum == 2)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkCD() < 0)
            {
               pinkShow();
               showElvesAll();
               elvesPanel.removeEventListener(Event.ENTER_FRAME,pinkTime);
            }
            else
            {
               elvesPanel["time_txt"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkCD() / 60) + ":" + myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkCD() % 60;
            }
         }
      }
      
      private static function gold(param1:*) : *
      {
         goldShow();
      }
      
      private static function goldShow() : *
      {
         elvesPanel["blue"].visible = true;
         elvesPanel["pink"].visible = true;
         elvesPanel["gold"].visible = false;
         changeNum = 3;
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(Boolean(myplayer.getBag().getEquipFromBag(_loc2_)) && Boolean(myplayer.getBag().getEquipFromBag(_loc2_).getColor() >= 4) && myplayer.getBag().getEquipFromBag(_loc2_).getDressLevel() >= myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldLV())
            {
               _loc1_++;
               elvesPanel["e" + _loc2_].visible = true;
               elvesPanel["e" + _loc2_].gotoAndStop(myplayer.getBag().getEquipFromBag(_loc2_).getFrame());
            }
            else
            {
               elvesPanel["e" + _loc2_].visible = false;
            }
            _loc2_++;
         }
         if(_loc1_ == 0)
         {
            elvesPanel["tishi"].visible = true;
         }
         else
         {
            elvesPanel["tishi"].visible = false;
         }
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquip())
         {
            elvesPanel["xishou"].visible = true;
            elvesPanel["xishou"].gotoAndStop(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquip().getFrame());
         }
         else
         {
            elvesPanel["xishou"].visible = false;
         }
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquip() == null)
         {
            elvesPanel["time_txt"].text = int((2700 - myplayer.getElvesSlot().getElvesFromSlot(clickNum).getTimeBuff()) / 60) + ":" + (3000 - myplayer.getElvesSlot().getElvesFromSlot(clickNum).getTimeBuff()) % 60;
         }
         else
         {
            elvesPanel.addEventListener(Event.ENTER_FRAME,goldTime);
         }
         elvesPanel["color_txt"].text = "金色";
         ColorX(elvesPanel["color_txt"],"0xFF9900");
         elvesPanel["limit_txt"].text = myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquipNum() + "件" + myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldLV() + "级";
         elvesPanel["reward_txt"].text = "3点精灵点数。";
      }
      
      private static function goldTime(param1:*) : *
      {
         if(changeNum == 3)
         {
            if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldCD() < 0)
            {
               goldShow();
               showElvesAll();
               elvesPanel.removeEventListener(Event.ENTER_FRAME,goldTime);
            }
            else
            {
               elvesPanel["time_txt"].text = int(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldCD() / 60) + ":" + myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldCD() % 60;
            }
         }
      }
      
      private static function showLV(param1:Number) : *
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 < 10)
         {
            elvesPanel["shiwei"].gotoAndStop(param1);
            elvesPanel["gewei"].visible = false;
            elvesPanel["shiwei"].visible = true;
         }
         else
         {
            elvesPanel["gewei"].visible = true;
            _loc2_ = param1.toString();
            _loc3_ = int(_loc2_.substring(0,1));
            _loc4_ = int(_loc2_.substring(1,2));
            elvesPanel["shiwei"].gotoAndStop(_loc3_);
            if(_loc4_ == 0)
            {
               elvesPanel["gewei"].gotoAndStop(10);
            }
            else
            {
               elvesPanel["gewei"].gotoAndStop(_loc4_);
            }
         }
      }
      
      private static function closeNORMB(param1:*) : void
      {
         elvesPanel["NoMoney_mc"].visible = false;
      }
      
      private static function addMoney_btn(param1:*) : void
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      private static function xishouNow(param1:*) : *
      {
         if(changeNum == 1 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquipNum() > 0)
         {
            elvesPanel["blueRMB"].visible = true;
         }
         else if(changeNum == 2 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquipNum() > 0)
         {
            elvesPanel["pinkRMB"].visible = true;
         }
         else if(changeNum == 3 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquipNum() > 0)
         {
            elvesPanel["goldRMB"].visible = true;
         }
         else
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"吸收装备已达到上限，无法继续吸收");
         }
      }
      
      private static function chongzhi(param1:*) : *
      {
         elvesPanel["czRMB"].visible = true;
      }
      
      private static function czYES(param1:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 18)
         {
            Api_4399_All.BuyObj(InitData.BuyNum_50.getValue());
            CZJLOK = true;
            elvesPanel["czRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function czNO(param1:*) : *
      {
         elvesPanel["czRMB"].visible = false;
      }
      
      public static function chongzhiOK() : *
      {
         if(CZJLOK)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).resetAllPoint();
            CZJLOK = false;
            Main.Save();
            showElvesAll();
         }
      }
      
      private static function blueYES(param1:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 18)
         {
            Api_4399_All.BuyObj(InitData.blue.getValue());
            blueOK = true;
            elvesPanel["blueRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function blueNO(param1:*) : *
      {
         elvesPanel["blueRMB"].visible = false;
      }
      
      public static function blueXSOK() : *
      {
         if(blueOK)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).overBlueEquip();
            blueOK = false;
            Main.Save();
            showElvesAll();
            blueShow();
         }
      }
      
      private static function pinkYES(param1:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 36)
         {
            Api_4399_All.BuyObj(InitData.pink.getValue());
            pinkOK = true;
            elvesPanel["pinkRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function pinkNO(param1:*) : *
      {
         elvesPanel["pinkRMB"].visible = false;
      }
      
      public static function pinkXSOK() : *
      {
         if(pinkOK)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).overPinkEquip();
            pinkOK = false;
            Main.Save();
            showElvesAll();
            pinkShow();
         }
      }
      
      private static function goldYES(param1:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 80)
         {
            Api_4399_All.BuyObj(InitData.gold.getValue());
            goldOK = true;
            elvesPanel["goldRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function goldNO(param1:*) : *
      {
         elvesPanel["goldRMB"].visible = false;
      }
      
      public static function goldXSOK() : *
      {
         if(goldOK)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).overGoldEquip();
            goldOK = false;
            Main.Save();
            showElvesAll();
            goldShow();
         }
      }
   }
}

