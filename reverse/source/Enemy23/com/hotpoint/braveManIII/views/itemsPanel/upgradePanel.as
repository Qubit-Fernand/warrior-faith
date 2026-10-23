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
      
      public static function open(pp:PlayerData) : void
      {
         Main.allClosePanel();
         myplayer = pp;
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
         for(var i:uint = 0; i < 24; i++)
         {
            ugPanel["e" + i].mouseChildren = false;
            ugPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            ugPanel["s" + i].mouseChildren = false;
            ugPanel["s" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["s" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
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
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            ugPanel["e" + i].t_txt.text = "";
            if(myplayer.getBag().getEquipFromBag(i) != null)
            {
               if(myplayer.getBag().getEquipFromBag(i).getSuitId() >= 21 && myplayer.getBag().getEquipFromBag(i).getSuitId() <= 25)
               {
                  ugPanel["e" + i].gotoAndStop(myplayer.getBag().getEquipFromBag(i).getFrame());
                  ugPanel["e" + i].visible = true;
               }
               else
               {
                  ugPanel["e" + i].visible = false;
               }
            }
            else
            {
               ugPanel["e" + i].visible = false;
            }
         }
         for(i = 0; i < 8; i++)
         {
            ugPanel["s" + i].t_txt.text = "";
            if(myplayer.getEquipSlot().getEquipFromSlot(i) != null)
            {
               if(myplayer.getEquipSlot().getEquipFromSlot(i).getSuitId() >= 21 && myplayer.getEquipSlot().getEquipFromSlot(i).getSuitId() <= 25)
               {
                  ugPanel["s" + i].gotoAndStop(myplayer.getEquipSlot().getEquipFromSlot(i).getFrame());
                  ugPanel["s" + i].visible = true;
               }
               else
               {
                  ugPanel["s" + i].visible = false;
               }
            }
            else
            {
               ugPanel["s" + i].visible = false;
            }
         }
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         ugPanel["close"].removeEventListener(MouseEvent.CLICK,closeUS);
         ugPanel["us_btn"].removeEventListener(MouseEvent.CLICK,doUS);
         for(i = 0; i < 24; i++)
         {
            ugPanel["e" + i].mouseChildren = false;
            ugPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            ugPanel["s" + i].mouseChildren = false;
            ugPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            ugPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            ugPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         ugPanel["chosed"].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
         ugPanel["chosed"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         ugPanel["jh_over"].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
         ugPanel["jh_over"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
      }
      
      public static function closeUS(e:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overNum:uint = 0;
         var str:String = null;
         var overobj:MovieClip = e.target as MovieClip;
         ugPanel.addChild(itemsTooltip);
         if(overobj)
         {
            overNum = uint(overobj.name.substr(1,2));
            str = overobj.name.substr(0,1);
            if(str == "e")
            {
               if(myplayer.getBag().getEquipFromBag(overNum) != null)
               {
                  itemsTooltip.equipTooltip(myplayer.getBag().getEquipFromBag(overNum),1);
               }
            }
            else if(str == "s")
            {
               itemsTooltip.slotTooltip(overNum,myplayer.getEquipSlot());
            }
            else if(str == "c")
            {
               itemsTooltip.equipTooltip(ee,1);
            }
            else if(str == "j")
            {
               itemsTooltip.equipTooltip(ee_over,1);
            }
            itemsTooltip.visible = true;
            itemsTooltip.x = ugPanel.mouseX + 10;
            itemsTooltip.y = ugPanel.mouseY;
            itemsTooltip.setTooltipPoint();
         }
      }
      
      private static function doUS(e:*) : *
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
         for(var i:int = 0; i < 4; i++)
         {
            myplayer.getBag().delOtherById(arr_cl[i][1],arr_cl[i][2]);
         }
         showEE();
         showCL();
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(e:MouseEvent) : void
      {
         clickObj = e.target as MovieClip;
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
         var i:uint = 0;
         var otherID:Number = NaN;
         arr_cl = [];
         count = 0;
         for(i = 0; i < arr.length; i++)
         {
            if(arr[i][0] == ee.getPosition())
            {
               arr_cl.push(arr[i]);
            }
         }
         for(i = 0; i < 4; i++)
         {
            otherID = Number(arr_cl[i][1]);
            ugPanel["x" + i].gotoAndStop(OtherFactory.getFrame(otherID));
            ugPanel["x" + i].visible = true;
            ugPanel["n" + i].text = arr_cl[i][2];
            ugPanel["c" + i].visible = true;
            ugPanel["n" + i].visible = true;
            if(myplayer.getBag().getOtherobjNum(otherID) >= arr_cl[i][2])
            {
               ugPanel["c" + i].text = arr_cl[i][2];
               ColorX(ugPanel["c" + i],"0xFFFF00");
               ++count;
            }
            else
            {
               ugPanel["c" + i].text = myplayer.getBag().getOtherobjNum(otherID);
               ColorX(ugPanel["c" + i],"0xFF0000");
            }
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
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      private static function noShowCL() : *
      {
         var i:uint = 0;
         if(!ee)
         {
            for(i = 0; i < 4; i++)
            {
               ugPanel["x" + i].visible = false;
               ugPanel["n" + i].visible = false;
               ugPanel["c" + i].visible = false;
            }
         }
         ugPanel["jh_over"].visible = false;
         ugPanel["us_btn"].visible = false;
         ugPanel["chosed"].visible = false;
      }
   }
}

