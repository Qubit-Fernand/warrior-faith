package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class upgradePanel extends MovieClip
   {
      
      public static var myplayer:PlayerData;
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var ugp:upgradePanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var clickNum:Number;
      
      public static var ugPanel:MovieClip = new JJShow();
      
      private static var ee:Equip = null;
      
      private static var ee_over:Equip = null;
      
      public static var arr_cl:Array = [];
      
      public static var arr:Array = [[1,63202,1],[1,63138,3],[1,63100,3],[1,63156,50],[2,63202,1],[2,63138,3],[2,63100,3],[2,63156,50],[3,63202,1],[3,63138,3],[3,63100,3],[3,63156,50],[4,63202,1],[4,63138,3],[4,63100,3],[4,63156,50]];
      
      public function upgradePanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(ugPanel);
      }
      
      public static function open(param1:PlayerData) : void
      {
         Main.allClosePanel();
         myplayer = param1;
         if(ugp == null)
         {
            ugp = new upgradePanel();
         }
         Main.stopXX = true;
         ugp.x = 0;
         ugp.y = 0;
         addListenerP1();
         Main._stage.addChild(ugp);
         ugp.visible = true;
      }
      
      public static function close() : void
      {
         ee_over = null;
         ee = null;
         if(ugp == null)
         {
            ugp = new upgradePanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         ugp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         ugPanel["us_btn"].addEventListener(MouseEvent.CLICK,doUS);
         ugPanel["close"].addEventListener(MouseEvent.CLICK,closeUS);
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            ugPanel["e" + _loc1_].mouseChildren = false;
            ugPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            ugPanel["s" + _loc1_].mouseChildren = false;
            ugPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["s" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         ugPanel["chosed"].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
         ugPanel["chosed"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         ugPanel["jh_over"].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
         ugPanel["jh_over"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         ugPanel["jh_over"].mouseChildren = false;
         ugPanel["chosed"].mouseChildren = false;
         ugPanel["chosed"].gotoAndStop(1);
         ugPanel["chosed"].visible = false;
         showEE();
         noShowCL();
         ugPanel["chose"].visible = false;
      }
      
      public static function showEE() : *
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ugPanel["e" + _loc1_].t_txt.text = "";
            if(myplayer.getBag().getEquipFromBag(_loc1_) != null)
            {
               if(myplayer.getBag().getEquipFromBag(_loc1_).getSuitId() >= 21 && myplayer.getBag().getEquipFromBag(_loc1_).getSuitId() <= 25)
               {
                  ugPanel["e" + _loc1_].gotoAndStop(myplayer.getBag().getEquipFromBag(_loc1_).getFrame());
                  ugPanel["e" + _loc1_].visible = true;
               }
               else
               {
                  ugPanel["e" + _loc1_].visible = false;
               }
            }
            else
            {
               ugPanel["e" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            ugPanel["s" + _loc1_].t_txt.text = "";
            if(myplayer.getEquipSlot().getEquipFromSlot(_loc1_) != null)
            {
               if(myplayer.getEquipSlot().getEquipFromSlot(_loc1_).getSuitId() >= 21 && myplayer.getEquipSlot().getEquipFromSlot(_loc1_).getSuitId() <= 25)
               {
                  ugPanel["s" + _loc1_].gotoAndStop(myplayer.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                  ugPanel["s" + _loc1_].visible = true;
               }
               else
               {
                  ugPanel["s" + _loc1_].visible = false;
               }
            }
            else
            {
               ugPanel["s" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         ugPanel["close"].removeEventListener(MouseEvent.CLICK,closeUS);
         ugPanel["us_btn"].removeEventListener(MouseEvent.CLICK,doUS);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            ugPanel["e" + _loc1_].mouseChildren = false;
            ugPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["e" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            ugPanel["s" + _loc1_].mouseChildren = false;
            ugPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["s" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         ugPanel["chosed"].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
         ugPanel["chosed"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         ugPanel["jh_over"].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
         ugPanel["jh_over"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
      }
      
      public static function closeUS(param1:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         ugPanel.addChild(itemsTooltip);
         if(_loc2_)
         {
            _loc3_ = uint(_loc2_.name.substr(1,2));
            _loc4_ = _loc2_.name.substr(0,1);
            if(_loc4_ == "e")
            {
               if(myplayer.getBag().getEquipFromBag(_loc3_) != null)
               {
                  itemsTooltip.equipTooltip(myplayer.getBag().getEquipFromBag(_loc3_),1);
               }
            }
            else if(_loc4_ == "s")
            {
               itemsTooltip.slotTooltip(_loc3_,myplayer.getEquipSlot());
            }
            else if(_loc4_ == "c")
            {
               itemsTooltip.equipTooltip(ee,1);
            }
            else if(_loc4_ == "j")
            {
               itemsTooltip.equipTooltip(ee_over,1);
            }
            itemsTooltip.visible = true;
            itemsTooltip.x = ugPanel.mouseX + 10;
            itemsTooltip.y = ugPanel.mouseY;
            itemsTooltip.setTooltipPoint();
         }
      }
      
      private static function doUS(param1:*) : *
      {
         if(nameStr == "e")
         {
            myplayer.getBag().delEquip(clickNum);
            myplayer.getBag().addEquipBag(ee_over);
         }
         else
         {
            myplayer.getEquipSlot().delSlot(clickNum);
            myplayer.getEquipSlot().addToSlot(ee_over,clickNum);
         }
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            myplayer.getBag().delOtherById(arr_cl[_loc2_][1],arr_cl[_loc2_][2]);
            _loc2_++;
         }
         ugPanel["us_btn"].visible = false;
         showEE();
         showCL();
      }
      
      private static function tooltipClose(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(param1:MouseEvent) : void
      {
         clickObj = param1.target as MovieClip;
         ugPanel["chose"].visible = true;
         ugPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         if(nameStr == "e")
         {
            ee = myplayer.getBag().getEquipFromBag(clickNum);
         }
         else
         {
            ee = myplayer.getEquipSlot().getEquipFromSlot(clickNum);
         }
         ugPanel["chosed"].gotoAndStop(ee.getFrame());
         ugPanel["chosed"].visible = true;
         showCL();
      }
      
      private static function showCL() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         arr_cl = [];
         count = 0;
         _loc1_ = 0;
         while(_loc1_ < arr.length)
         {
            if(arr[_loc1_][0] == ee.getPosition())
            {
               arr_cl.push(arr[_loc1_]);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = Number(arr_cl[_loc1_][1]);
            ugPanel["x" + _loc1_].gotoAndStop(OtherFactory.getFrame(_loc2_));
            ugPanel["x" + _loc1_].visible = true;
            ugPanel["n" + _loc1_].text = arr_cl[_loc1_][2];
            ugPanel["c" + _loc1_].visible = true;
            ugPanel["n" + _loc1_].visible = true;
            if(myplayer.getBag().getOtherobjNum(_loc2_) >= arr_cl[_loc1_][2])
            {
               ugPanel["c" + _loc1_].text = arr_cl[_loc1_][2];
               ColorX(ugPanel["c" + _loc1_],"0xFFFF00");
               ++count;
            }
            else
            {
               ugPanel["c" + _loc1_].text = myplayer.getBag().getOtherobjNum(_loc2_);
               ColorX(ugPanel["c" + _loc1_],"0xFF0000");
            }
            _loc1_++;
         }
         if(count >= 4)
         {
            ugPanel["us_btn"].visible = true;
         }
         else
         {
            ugPanel["us_btn"].visible = false;
         }
         ee_over = ee.jinhuaEquip();
         ugPanel["jh_over"].gotoAndStop(ee_over.getFrame());
         ugPanel["jh_over"].visible = true;
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      private static function noShowCL() : *
      {
         var _loc1_:uint = 0;
         if(!ee)
         {
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               ugPanel["x" + _loc1_].visible = false;
               ugPanel["n" + _loc1_].visible = false;
               ugPanel["c" + _loc1_].visible = false;
               _loc1_++;
            }
         }
         ugPanel["jh_over"].visible = false;
         ugPanel["us_btn"].visible = false;
         ugPanel["chosed"].visible = false;
      }
   }
}

