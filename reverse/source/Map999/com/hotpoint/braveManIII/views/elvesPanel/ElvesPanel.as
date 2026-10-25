package com.hotpoint.braveManIII.views.elvesPanel
{
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
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
      
      public function ElvesPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(elvesPanel);
      }
      
      public static function open(pp:PlayerData) : void
      {
         Main.allClosePanel();
         if(elp == null)
         {
            elp = new ElvesPanel();
         }
         myplayer = pp;
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
      
      public static function closeJL(e:*) : *
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
         for(var i:uint = 0; i < 24; i++)
         {
            elvesPanel["e" + i].mouseChildren = false;
            elvesPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            elvesPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            elvesPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
            elvesPanel["e" + i].visible = false;
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
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         elvesPanel.addChild(itemsTooltip);
         var overNum:uint = uint(overobj.name.substr(1,2));
         var str:String = overobj.name.substr(0,1);
         if(str == "e")
         {
            if(myplayer.getBag().getEquipFromBag(overNum) != null)
            {
               itemsTooltip.equipTooltip(myplayer.getBag().getEquipFromBag(overNum),1);
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = elvesPanel.mouseX + 30;
         itemsTooltip.y = elvesPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      public static function hp_btn(e:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setHP();
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
         }
         showElvesAll();
      }
      
      public static function mp_btn(e:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setMP();
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
         }
         showElvesAll();
      }
      
      public static function att_btn(e:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setATT();
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
         }
         showElvesAll();
      }
      
      public static function def_btn(e:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setDEF();
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
         }
         showElvesAll();
      }
      
      public static function crit_btn(e:*) : *
      {
         if(myplayer.getElvesSlot().getElvesFromSlot(clickNum).getAllPoint() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setCRIT();
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setAllPoint();
         }
         showElvesAll();
      }
      
      private static function tipClose(e:*) : *
      {
         elvesPanel["elvesTip"].visible = false;
      }
      
      private static function tipOpen(e:*) : *
      {
         var str:String = (e.target as MovieClip).name.toString();
         switch(str)
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
      
      private static function setColor(color:int) : void
      {
         if(color == 1)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0xffffff");
         }
         if(color == 2)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0x0066ff");
         }
         if(color == 3)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0xFF33FF");
         }
         if(color == 4)
         {
            ColorX(elvesPanel["elvesTip"]["str_name"],"0xFF9900");
         }
      }
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      public static function showJL() : *
      {
         for(var i:int = 0; i < 5; i++)
         {
            elvesPanel["jl" + i].addEventListener(MouseEvent.MOUSE_OUT,tipClose);
            elvesPanel["jl" + i].addEventListener(MouseEvent.MOUSE_OVER,tipOpen);
            elvesPanel["jl" + i].addEventListener(MouseEvent.CLICK,choseElves);
            if(myplayer.getElvesSlot().getElvesFromSlot(i))
            {
               elvesPanel["jl" + i].visible = true;
               elvesPanel["jl" + i].gotoAndStop(myplayer.getElvesSlot().getElvesFromSlot(i).getFrame());
            }
            else
            {
               elvesPanel["jl" + i].visible = false;
            }
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
      
      public static function choseElves(e:*) : *
      {
         var clickObj:MovieClip = e.target as MovieClip;
         clickNum = uint(clickObj.name.substr(2,2));
         showElvesAll();
      }
      
      public static function selected(e:*) : *
      {
         var clickObj:MovieClip = e.target as MovieClip;
         var num:Number = uint(clickObj.name.substr(1,2));
         if(changeNum == 1 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquip() == null && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueEquipNum() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setBlueEquip(myplayer.getBag().delEquip(num));
            blueShow();
         }
         else if(changeNum == 2 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquip() == null && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkEquipNum() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setPinkEquip(myplayer.getBag().delEquip(num));
            pinkShow();
         }
         else if(changeNum == 3 && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquip() == null && myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldEquipNum() > 0)
         {
            myplayer.getElvesSlot().getElvesFromSlot(clickNum).setGoldEquip(myplayer.getBag().delEquip(num));
            goldShow();
         }
         else
         {
            ShortTip.open(45);
         }
         showElvesAll();
      }
      
      private static function fanhui(e:*) : *
      {
         elvesPanel["fanhui"].visible = true;
      }
      
      private static function fhYES(e:*) : *
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
      
      private static function fhNO(e:*) : *
      {
         elvesPanel["fanhui"].visible = false;
      }
      
      private static function fsYES(e:*) : *
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
         clickNum = myplayer.getElvesSlot().backElvesId();
         myplayer.getElvesSlot().delElvesSlot(clickNum);
         elvesPanel["chose"].visible = true;
         showElvesAll();
         showJL();
         elvesPanel["isfangsheng"].visible = false;
         if(myplayer.getElvesSlot().backElvesNum() == 0)
         {
            close();
         }
      }
      
      private static function fsNO(e:*) : *
      {
         elvesPanel["isfangsheng"].visible = false;
      }
      
      private static function fangsheng(e:*) : *
      {
         elvesPanel["isfangsheng"].visible = true;
      }
      
      private static function zhaohuan(e:*) : *
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
      
      private static function blue(e:*) : *
      {
         blueShow();
      }
      
      private static function blueShow() : *
      {
         elvesPanel["blue"].visible = false;
         elvesPanel["pink"].visible = true;
         elvesPanel["gold"].visible = true;
         changeNum = 1;
         for(var i:uint = 0; i < 24; i++)
         {
            if(Boolean(myplayer.getBag().getEquipFromBag(i)) && Boolean(myplayer.getBag().getEquipFromBag(i).getColor() == 2) && myplayer.getBag().getEquipFromBag(i).getDressLevel() >= myplayer.getElvesSlot().getElvesFromSlot(clickNum).getBlueLV())
            {
               elvesPanel["e" + i].visible = true;
               elvesPanel["e" + i].gotoAndStop(myplayer.getBag().getEquipFromBag(i).getFrame());
            }
            else
            {
               elvesPanel["e" + i].visible = false;
            }
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
      
      private static function blueTime(e:*) : *
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
      
      private static function pink(e:*) : *
      {
         pinkShow();
      }
      
      private static function pinkShow() : *
      {
         elvesPanel["blue"].visible = true;
         elvesPanel["pink"].visible = false;
         elvesPanel["gold"].visible = true;
         changeNum = 2;
         for(var i:uint = 0; i < 24; i++)
         {
            if(Boolean(myplayer.getBag().getEquipFromBag(i)) && Boolean(myplayer.getBag().getEquipFromBag(i).getColor() == 3) && myplayer.getBag().getEquipFromBag(i).getDressLevel() >= myplayer.getElvesSlot().getElvesFromSlot(clickNum).getPinkLV())
            {
               elvesPanel["e" + i].visible = true;
               elvesPanel["e" + i].gotoAndStop(myplayer.getBag().getEquipFromBag(i).getFrame());
            }
            else
            {
               elvesPanel["e" + i].visible = false;
            }
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
      
      private static function pinkTime(e:*) : *
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
      
      private static function gold(e:*) : *
      {
         goldShow();
      }
      
      private static function goldShow() : *
      {
         elvesPanel["blue"].visible = true;
         elvesPanel["pink"].visible = true;
         elvesPanel["gold"].visible = false;
         changeNum = 3;
         for(var i:uint = 0; i < 24; i++)
         {
            if(Boolean(myplayer.getBag().getEquipFromBag(i)) && Boolean(myplayer.getBag().getEquipFromBag(i).getColor() >= 4) && myplayer.getBag().getEquipFromBag(i).getDressLevel() >= myplayer.getElvesSlot().getElvesFromSlot(clickNum).getGoldLV())
            {
               elvesPanel["e" + i].visible = true;
               elvesPanel["e" + i].gotoAndStop(myplayer.getBag().getEquipFromBag(i).getFrame());
            }
            else
            {
               elvesPanel["e" + i].visible = false;
            }
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
      
      private static function goldTime(e:*) : *
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
      
      private static function showLV(level:Number) : *
      {
         var str:String = null;
         var left:int = 0;
         var right:int = 0;
         if(level < 10)
         {
            elvesPanel["shiwei"].gotoAndStop(level);
            elvesPanel["gewei"].visible = false;
            elvesPanel["shiwei"].visible = true;
         }
         else
         {
            elvesPanel["gewei"].visible = true;
            str = level.toString();
            left = int(str.substring(0,1));
            right = int(str.substring(1,2));
            elvesPanel["shiwei"].gotoAndStop(left);
            if(right == 0)
            {
               elvesPanel["gewei"].gotoAndStop(10);
            }
            else
            {
               elvesPanel["gewei"].gotoAndStop(right);
            }
         }
      }
      
      private static function closeNORMB(e:*) : void
      {
         elvesPanel["NoMoney_mc"].visible = false;
      }
      
      private static function addMoney_btn(e:*) : void
      {
         if(Main.serviceHold)
         {
            PayMoneyVar.instance.money = 100;
            Main.serviceHold.payMoney_As3(PayMoneyVar.instance);
         }
      }
      
      private static function xishouNow(e:*) : *
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
            ShortTip.open(45);
         }
      }
      
      private static function chongzhi(e:*) : *
      {
         elvesPanel["czRMB"].visible = true;
      }
      
      private static function czYES(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 18)
         {
            Api_4399_All.Money_down(InitData.BuyNum_50.getValue());
            CZJLOK = true;
            elvesPanel["czRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function czNO(e:*) : *
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
      
      private static function blueYES(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 18)
         {
            Api_4399_All.Money_down(InitData.blue.getValue());
            blueOK = true;
            elvesPanel["blueRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function blueNO(e:*) : *
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
      
      private static function pinkYES(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 36)
         {
            Api_4399_All.Money_down(InitData.pink.getValue());
            pinkOK = true;
            elvesPanel["pinkRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function pinkNO(e:*) : *
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
      
      private static function goldYES(e:*) : *
      {
         if(Shop4399.moneyAll.getValue() >= 80)
         {
            Api_4399_All.Money_down(InitData.gold.getValue());
            goldOK = true;
            elvesPanel["goldRMB"].visible = false;
         }
         else
         {
            elvesPanel["NoMoney_mc"].visible = true;
         }
      }
      
      private static function goldNO(e:*) : *
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

