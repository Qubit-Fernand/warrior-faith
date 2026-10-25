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
      
      public static function open(param1:Boolean, param2:String, param3:Number, param4:int) : void
      {
         Main.allClosePanel();
         starNum = param3 - 1;
         oldNum = param4;
         if(usp == null)
         {
            usp = new upstarPanel();
         }
         usPanel["txt"].text = param2;
         Main.stopXX = true;
         usp.x = 50;
         usp.y = 0;
         isPOne = param1;
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
         var _loc1_:uint = 0;
         usPanel["us_btn"].addEventListener(MouseEvent.CLICK,doUS);
         usPanel["close"].addEventListener(MouseEvent.CLICK,closeUS);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            usPanel["e" + _loc1_].mouseChildren = false;
            usPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            usPanel["s" + _loc1_].mouseChildren = false;
            usPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["s" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         usPanel["select"].gotoAndStop(1);
         usPanel["select"].visible = false;
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               usPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(_loc1_) != null)
               {
                  if(Main.player1.getBag().getEquipFromBag(_loc1_).getStar() == starNum)
                  {
                     usPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
                     usPanel["e" + _loc1_].visible = true;
                  }
                  else
                  {
                     usPanel["e" + _loc1_].visible = false;
                  }
               }
               else
               {
                  usPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               usPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_) != null)
               {
                  if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getStar() == starNum)
                  {
                     usPanel["s" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                     usPanel["s" + _loc1_].visible = true;
                  }
                  else
                  {
                     usPanel["s" + _loc1_].visible = false;
                  }
               }
               else
               {
                  usPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               usPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(_loc1_) != null)
               {
                  if(Main.player2.getBag().getEquipFromBag(_loc1_).getStar() == starNum)
                  {
                     usPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
                     usPanel["e" + _loc1_].visible = true;
                  }
                  else
                  {
                     usPanel["e" + _loc1_].visible = false;
                  }
               }
               else
               {
                  usPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               usPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_) != null)
               {
                  if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getStar() == starNum)
                  {
                     usPanel["s" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                     usPanel["s" + _loc1_].visible = true;
                  }
                  else
                  {
                     usPanel["s" + _loc1_].visible = false;
                  }
               }
               else
               {
                  usPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         usPanel["chose"].visible = false;
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         usPanel["close"].removeEventListener(MouseEvent.CLICK,closeUS);
         usPanel["us_btn"].removeEventListener(MouseEvent.CLICK,doUS);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            usPanel["e" + _loc1_].mouseChildren = false;
            usPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["e" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            usPanel["s" + _loc1_].mouseChildren = false;
            usPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            usPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            usPanel["s" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
      }
      
      public static function closeUS(param1:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         usPanel.addChild(itemsTooltip);
         var _loc3_:uint = uint(_loc2_.name.substr(1,2));
         var _loc4_:String = _loc2_.name.substr(0,1);
         if(isPOne)
         {
            if(_loc4_ == "e")
            {
               if(Main.player1.getBag().getEquipFromBag(_loc3_) != null)
               {
                  itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(_loc3_),1);
               }
            }
            else
            {
               itemsTooltip.slotTooltip(_loc3_,Main.player1.getEquipSlot());
            }
         }
         else if(_loc4_ == "e")
         {
            if(Main.player2.getBag().getEquipFromBag(_loc3_) != null)
            {
               itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(_loc3_),2);
            }
         }
         else
         {
            itemsTooltip.slotTooltip(_loc3_,Main.player2.getEquipSlot());
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = usPanel.mouseX + 10;
         itemsTooltip.y = usPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function doUS(param1:*) : *
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
      
      private static function tooltipClose(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(param1:MouseEvent) : void
      {
         selbool = true;
         clickObj = param1.target as MovieClip;
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

