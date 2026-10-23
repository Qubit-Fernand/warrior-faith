package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class xilianPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var xlp:xilianPanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var xlPanel:MovieClip = new XLShow();
      
      public static var clickNum:Number = 100;
      
      public static var tempTime:Number = 0;
      
      public static var clickOK:Boolean = false;
      
      public static var isPOne:Boolean = true;
      
      public static var moneyOK:Boolean = false;
      
      public function xilianPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(xlPanel);
      }
      
      public static function open(pp:Boolean) : void
      {
         Main.DuoKai_Fun();
         Main.allClosePanel();
         if(xlp == null)
         {
            xlp = new xilianPanel();
         }
         Main.stopXX = true;
         xlp.x = 0;
         xlp.y = 0;
         isPOne = pp;
         addListenerP1();
         Main._stage.addChild(xlp);
         xlp.visible = true;
         clickOK = false;
         noShow();
      }
      
      public static function close() : void
      {
         if(xlp == null)
         {
            xlp = new xilianPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         xlp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         xlPanel["waiting"].visible = false;
         xlPanel["xl_btn"].addEventListener(MouseEvent.CLICK,doXL);
         xlPanel["close"].addEventListener(MouseEvent.CLICK,closeXL);
         for(i = 0; i < 24; i++)
         {
            xlPanel["e" + i].mouseChildren = false;
            xlPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 6; i++)
         {
            xlPanel["s" + i].mouseChildren = false;
            xlPanel["s" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["s" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         xlPanel["s1_mc"].stop();
         xlPanel["s2_mc"].stop();
         xlPanel["select"].gotoAndStop(1);
         xlPanel["select"].visible = false;
         if(isPOne)
         {
            for(i = 0; i < 24; i++)
            {
               xlPanel["e" + i].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(i) != null && Main.player1.getBag().getEquipFromBag(i).getPosition() <= 7)
               {
                  xlPanel["e" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
                  xlPanel["e" + i].visible = true;
               }
               else
               {
                  xlPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 6; i++)
            {
               xlPanel["s" + i].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  xlPanel["s" + i].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
                  xlPanel["s" + i].visible = true;
               }
               else
               {
                  xlPanel["s" + i].visible = false;
               }
            }
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               xlPanel["e" + i].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(i) != null && Main.player2.getBag().getEquipFromBag(i).getPosition() <= 7)
               {
                  xlPanel["e" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
                  xlPanel["e" + i].visible = true;
               }
               else
               {
                  xlPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 6; i++)
            {
               xlPanel["s" + i].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  xlPanel["s" + i].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
                  xlPanel["s" + i].visible = true;
               }
               else
               {
                  xlPanel["s" + i].visible = false;
               }
            }
         }
         xlPanel["chose"].visible = false;
         xlPanel.point_txt.text = Shop4399.moneyAll.getValue();
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         xlPanel["close"].removeEventListener(MouseEvent.CLICK,closeXL);
         xlPanel["xl_btn"].removeEventListener(MouseEvent.CLICK,doXL);
         for(i = 0; i < 24; i++)
         {
            xlPanel["e" + i].mouseChildren = false;
            xlPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 6; i++)
         {
            xlPanel["s" + i].mouseChildren = false;
            xlPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
      }
      
      public static function closeXL(e:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         xlPanel.addChild(itemsTooltip);
         var overNum:uint = uint(overobj.name.substr(1,2));
         var str:String = overobj.name.substr(0,1);
         if(isPOne)
         {
            if(str == "e")
            {
               if(Main.player1.getBag().getEquipFromBag(overNum) != null)
               {
                  itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(overNum),1);
               }
            }
            else
            {
               itemsTooltip.slotTooltip(overNum,Main.player1.getEquipSlot());
            }
         }
         else if(str == "e")
         {
            if(Main.player2.getBag().getEquipFromBag(overNum) != null)
            {
               itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(overNum),2);
            }
         }
         else
         {
            itemsTooltip.slotTooltip(overNum,Main.player2.getEquipSlot());
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = xlPanel.mouseX + 10;
         itemsTooltip.y = xlPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function doXL(e:*) : *
      {
         var i:uint = 0;
         if(clickOK)
         {
            Api_4399_All.Money_down(InitData.XiLian_Money.getValue());
            moneyOK = true;
            xlPanel["waiting"].visible = true;
            xlPanel["s1_mc"].gotoAndPlay(1);
            xlPanel["s2_mc"].gotoAndPlay(1);
            xlPanel["xl_btn"].visible = false;
            for(i = 0; i < 24; i++)
            {
               xlPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
            }
            for(i = 0; i < 6; i++)
            {
               xlPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
            }
         }
      }
      
      public static function xlOK() : *
      {
         var i:uint = 0;
         if(moneyOK)
         {
            if(isPOne)
            {
               if(nameStr == "e")
               {
                  Main.player1.getBag().addEquipBag(Main.player1.getBag().delEquip(clickNum).reCreatEquip());
                  showAttrib2(Main.player1.getBag().getEquipFromBag(clickNum));
               }
               else
               {
                  Main.player1.getEquipSlot().addToSlot(Main.player1.getEquipSlot().delSlot(clickNum).reCreatEquip(),clickNum);
                  showAttrib2(Main.player1.getEquipSlot().getEquipFromSlot(clickNum));
               }
            }
            else if(nameStr == "e")
            {
               Main.player2.getBag().addEquipBag(Main.player2.getBag().delEquip(clickNum).reCreatEquip());
               showAttrib2(Main.player2.getBag().getEquipFromBag(clickNum));
            }
            else
            {
               Main.player2.getEquipSlot().addToSlot(Main.player2.getEquipSlot().delSlot(clickNum).reCreatEquip(),clickNum);
               showAttrib2(Main.player2.getEquipSlot().getEquipFromSlot(clickNum));
            }
            for(i = 0; i < 24; i++)
            {
               xlPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
            }
            for(i = 0; i < 6; i++)
            {
               xlPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
            }
            xlPanel["xl_btn"].visible = true;
            xlPanel["waiting"].visible = false;
            xlPanel["s1_mc"].gotoAndStop(1);
            xlPanel["s2_mc"].gotoAndStop(1);
            tempTime = 0;
            moneyOK = false;
            Main.Save();
         }
      }
      
      private static function noShow() : *
      {
         for(var i:uint = 0; i < 8; i++)
         {
            xlPanel["txt_" + i].visible = false;
            xlPanel["txtb_" + i].visible = false;
         }
      }
      
      private static function showAttrib(equip:Equip) : *
      {
         noShow();
         var Attribarr:Array = equip.showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               xlPanel["txt_" + temp1].text = Attribarr[i][1];
               xlPanel["txt_" + temp1].visible = true;
               temp1++;
            }
            else
            {
               xlPanel["txt_" + temp2].text = Attribarr[i][1];
               xlPanel["txt_" + temp2].visible = true;
               temp2++;
            }
         }
      }
      
      private static function showAttrib2(equip:Equip) : *
      {
         var Attribarr:Array = equip.showBaseAttrib();
         var temp1:uint = 0;
         var temp2:uint = 4;
         for(var i:uint = 0; i < Attribarr.length; i++)
         {
            if(Attribarr[i][0] == 1)
            {
               xlPanel["txtb_" + temp1].text = Attribarr[i][1];
               xlPanel["txtb_" + temp1].visible = true;
               temp1++;
            }
            else
            {
               xlPanel["txtb_" + temp2].text = Attribarr[i][1];
               xlPanel["txtb_" + temp2].visible = true;
               temp2++;
            }
         }
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(e:MouseEvent) : void
      {
         clickOK = true;
         clickObj = e.target as MovieClip;
         xlPanel["chose"].visible = true;
         xlPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         xlPanel["select"].gotoAndStop(clickObj.currentFrame);
         xlPanel["select"].visible = true;
         if(isPOne)
         {
            if(nameStr == "e")
            {
               showAttrib(Main.player1.getBag().getEquipFromBag(clickNum));
            }
            else
            {
               showAttrib(Main.player1.getEquipSlot().getEquipFromSlot(clickNum));
            }
         }
         else if(nameStr == "e")
         {
            showAttrib(Main.player2.getBag().getEquipFromBag(clickNum));
         }
         else
         {
            showAttrib(Main.player2.getEquipSlot().getEquipFromSlot(clickNum));
         }
      }
   }
}

