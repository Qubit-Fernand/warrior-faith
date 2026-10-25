package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class upstarPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var usp:upstarPanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var clickNum:Number;
      
      public static var starNum:Number;
      
      public static var oldNum:Number;
      
      public static var usPanel:MovieClip = new USShow();
      
      public static var selbool:Boolean = false;
      
      public static var isPOne:Boolean = true;
      
      public function upstarPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(usPanel);
      }
      
      public static function open(pp:Boolean, str:String, star:Number, num:int) : void
      {
         Main.allClosePanel();
         starNum = star - 1;
         oldNum = num;
         if(usp == null)
         {
            usp = new upstarPanel();
         }
         usPanel["txt"].text = str;
         Main.stopXX = true;
         usp.x = 50;
         usp.y = 0;
         isPOne = pp;
         addListenerP1();
         Main._stage.addChild(usp);
         usp.visible = true;
      }
      
      public static function close() : void
      {
         selbool = false;
         if(usp == null)
         {
            usp = new upstarPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         usp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         usPanel["us_btn"].addEventListener(MouseEvent.CLICK,doUS);
         usPanel["close"].addEventListener(MouseEvent.CLICK,closeUS);
         for(i = 0; i < 24; i++)
         {
            usPanel["e" + i].mouseChildren = false;
            usPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            usPanel["s" + i].mouseChildren = false;
            usPanel["s" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["s" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         usPanel["select"].gotoAndStop(1);
         usPanel["select"].visible = false;
         if(isPOne)
         {
            for(i = 0; i < 24; i++)
            {
               usPanel["e" + i].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player1.getBag().getEquipFromBag(i).getStar() == starNum)
                  {
                     usPanel["e" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
                     usPanel["e" + i].visible = true;
                  }
                  else
                  {
                     usPanel["e" + i].visible = false;
                  }
               }
               else
               {
                  usPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               usPanel["s" + i].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  if(Main.player1.getEquipSlot().getEquipFromSlot(i).getStar() == starNum)
                  {
                     usPanel["s" + i].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
                     usPanel["s" + i].visible = true;
                  }
                  else
                  {
                     usPanel["s" + i].visible = false;
                  }
               }
               else
               {
                  usPanel["s" + i].visible = false;
               }
            }
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               usPanel["e" + i].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player2.getBag().getEquipFromBag(i).getStar() == starNum)
                  {
                     usPanel["e" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
                     usPanel["e" + i].visible = true;
                  }
                  else
                  {
                     usPanel["e" + i].visible = false;
                  }
               }
               else
               {
                  usPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               usPanel["s" + i].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  if(Main.player2.getEquipSlot().getEquipFromSlot(i).getStar() == starNum)
                  {
                     usPanel["s" + i].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
                     usPanel["s" + i].visible = true;
                  }
                  else
                  {
                     usPanel["s" + i].visible = false;
                  }
               }
               else
               {
                  usPanel["s" + i].visible = false;
               }
            }
         }
         usPanel["chose"].visible = false;
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         usPanel["close"].removeEventListener(MouseEvent.CLICK,closeUS);
         usPanel["us_btn"].removeEventListener(MouseEvent.CLICK,doUS);
         for(i = 0; i < 24; i++)
         {
            usPanel["e" + i].mouseChildren = false;
            usPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            usPanel["s" + i].mouseChildren = false;
            usPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
      }
      
      public static function closeUS(e:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         usPanel.addChild(itemsTooltip);
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
         itemsTooltip.x = usPanel.mouseX + 10;
         itemsTooltip.y = usPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function doUS(e:*) : *
      {
         if(selbool == false)
         {
            return;
         }
         if(isPOne)
         {
            if(nameStr == "e")
            {
               Main.player1.getBag().addEquipBag(Main.player1.getBag().delEquip(clickNum).upStarEquip());
            }
            else
            {
               Main.player1.getEquipSlot().addToSlot(Main.player1.getEquipSlot().delSlot(clickNum).upStarEquip(),clickNum);
            }
            Main.player1.getBag().delGem(oldNum,1);
         }
         else
         {
            if(nameStr == "e")
            {
               Main.player2.getBag().addEquipBag(Main.player2.getBag().delEquip(clickNum).upStarEquip());
            }
            else
            {
               Main.player2.getEquipSlot().addToSlot(Main.player2.getEquipSlot().delSlot(clickNum).upStarEquip(),clickNum);
            }
            Main.player2.getBag().delGem(oldNum,1);
         }
         ShortTip.open(35);
         close();
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(e:MouseEvent) : void
      {
         selbool = true;
         clickObj = e.target as MovieClip;
         usPanel["chose"].visible = true;
         usPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         usPanel["select"].gotoAndStop(clickObj.currentFrame);
         usPanel["select"].visible = true;
      }
   }
}

