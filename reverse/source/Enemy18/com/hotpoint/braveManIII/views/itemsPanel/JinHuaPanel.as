package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class JinHuaPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var jhp:JinHuaPanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var clickNum:Number;
      
      public static var starNum:Number;
      
      public static var mapNum:Number;
      
      public static var partNum:Number;
      
      public static var count:int;
      
      public static var arr:Array = [[1,63162,5],[1,63138,3],[1,63100,3],[1,63137,35]];
      
      public static var jhPanel:MovieClip = new JHShow();
      
      public static var selbool:Boolean = false;
      
      public static var isPOne:Boolean = true;
      
      public static var arr_cl:Array = [];
      
      public function JinHuaPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(jhPanel);
      }
      
      public static function open(pp:Boolean, map:int, part:int) : void
      {
         Main.allClosePanel();
         mapNum = map;
         partNum = part;
         if(jhp == null)
         {
            jhp = new JinHuaPanel();
         }
         Main.stopXX = true;
         jhp.x = 0;
         jhp.y = 0;
         isPOne = pp;
         addListenerP1();
         Main._stage.addChild(jhp);
         jhp.visible = true;
      }
      
      public static function close() : void
      {
         selbool = false;
         if(jhp == null)
         {
            jhp = new JinHuaPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         jhp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         jhPanel["jh_btn"].visible = false;
         jhPanel["jh_btn"].addEventListener(MouseEvent.CLICK,doJH);
         jhPanel["close"].addEventListener(MouseEvent.CLICK,closeJH);
         for(i = 0; i < 24; i++)
         {
            jhPanel["e" + i].mouseChildren = false;
            jhPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            jhPanel["s" + i].mouseChildren = false;
            jhPanel["s" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["s" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         jhPanel["select"].gotoAndStop(1);
         jhPanel["select"].visible = false;
         if(isPOne)
         {
            for(i = 0; i < 24; i++)
            {
               jhPanel["e" + i].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player1.getBag().getEquipFromBag(i).getPosition() == partNum && Main.player1.getBag().getEquipFromBag(i).getColor() == 5)
                  {
                     jhPanel["e" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
                     jhPanel["e" + i].visible = true;
                  }
                  else
                  {
                     jhPanel["e" + i].visible = false;
                  }
               }
               else
               {
                  jhPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               jhPanel["s" + i].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  if(Main.player1.getEquipSlot().getEquipFromSlot(i).getPosition() == partNum && Main.player1.getEquipSlot().getEquipFromSlot(i).getColor() == 5)
                  {
                     jhPanel["s" + i].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
                     jhPanel["s" + i].visible = true;
                  }
                  else
                  {
                     jhPanel["s" + i].visible = false;
                  }
               }
               else
               {
                  jhPanel["s" + i].visible = false;
               }
            }
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               jhPanel["e" + i].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player2.getBag().getEquipFromBag(i).getPosition() == partNum && Main.player2.getBag().getEquipFromBag(i).getColor() == 5)
                  {
                     jhPanel["e" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
                     jhPanel["e" + i].visible = true;
                  }
                  else
                  {
                     jhPanel["e" + i].visible = false;
                  }
               }
               else
               {
                  jhPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               jhPanel["s" + i].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  if(Main.player2.getEquipSlot().getEquipFromSlot(i).getPosition() == partNum && Main.player2.getEquipSlot().getEquipFromSlot(i).getColor() == 5)
                  {
                     jhPanel["s" + i].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
                     jhPanel["s" + i].visible = true;
                  }
                  else
                  {
                     jhPanel["s" + i].visible = false;
                  }
               }
               else
               {
                  jhPanel["s" + i].visible = false;
               }
            }
         }
         jhPanel["chose"].visible = false;
         otherShow();
      }
      
      public static function otherShow() : *
      {
         var i:uint = 0;
         var otherID:Number = NaN;
         count = 0;
         for(i = 0; i < arr.length; i++)
         {
            if(arr[i][0] == mapNum)
            {
               arr_cl.push(arr[i]);
            }
         }
         for(i = 0; i < 4; i++)
         {
            otherID = Number(arr_cl[i][1]);
            jhPanel["x" + i].gotoAndStop(OtherFactory.getFrame(otherID));
            jhPanel["n" + i].text = arr_cl[i][2];
            if(isPOne)
            {
               if(Main.player1.getBag().getOtherobjNum(otherID) >= arr_cl[i][2])
               {
                  jhPanel["c" + i].text = arr_cl[i][2];
                  ColorX(jhPanel["c" + i],"0xFFFF00");
                  ++count;
               }
               else
               {
                  jhPanel["c" + i].text = Main.player1.getBag().getOtherobjNum(otherID);
                  ColorX(jhPanel["c" + i],"0xFF0000");
               }
            }
            else if(Main.player2.getBag().getOtherobjNum(otherID) >= arr_cl[i][2])
            {
               jhPanel["c" + i].text = arr_cl[i][2];
               ColorX(jhPanel["c" + i],"0xFFFF00");
               ++count;
            }
            else
            {
               jhPanel["c" + i].text = Main.player2.getBag().getOtherobjNum(otherID);
               ColorX(jhPanel["c" + i],"0xFF0000");
            }
         }
      }
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         jhPanel["close"].removeEventListener(MouseEvent.CLICK,closeJH);
         jhPanel["jh_btn"].removeEventListener(MouseEvent.CLICK,doJH);
         for(i = 0; i < 24; i++)
         {
            jhPanel["e" + i].mouseChildren = false;
            jhPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            jhPanel["s" + i].mouseChildren = false;
            jhPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
      }
      
      public static function closeJH(e:*) : *
      {
         close();
      }
      
      public static function doJH(e:*) : *
      {
         var i:int = 0;
         if(isPOne)
         {
            if(nameStr == "e")
            {
               Main.player1.getBag().getEquipFromBag(clickNum).setBlessAttrib();
            }
            else
            {
               Main.player1.getEquipSlot().getEquipFromSlot(clickNum).setBlessAttrib();
            }
            for(i = 0; i < 4; i++)
            {
               Main.player1.getBag().delOtherById(arr_cl[i][1],arr_cl[i][2]);
            }
         }
         else
         {
            if(nameStr == "e")
            {
               Main.player2.getBag().getEquipFromBag(clickNum).setBlessAttrib();
            }
            else
            {
               Main.player2.getEquipSlot().getEquipFromSlot(clickNum).setBlessAttrib();
            }
            for(i = 0; i < 4; i++)
            {
               Main.player2.getBag().delOtherById(arr_cl[i][1],arr_cl[i][2]);
            }
         }
         ShortTip.open(43);
         close();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         jhPanel.addChild(itemsTooltip);
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
         itemsTooltip.x = jhPanel.mouseX + 10;
         itemsTooltip.y = jhPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(e:MouseEvent) : void
      {
         selbool = true;
         clickObj = e.target as MovieClip;
         jhPanel["chose"].visible = true;
         jhPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         jhPanel["select"].gotoAndStop(clickObj.currentFrame);
         jhPanel["select"].visible = true;
         if(count >= 4)
         {
            jhPanel["jh_btn"].visible = true;
         }
      }
   }
}

