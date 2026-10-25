package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
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
      
      public static var arr:Array = [[1,63162,5],[1,63138,3],[1,63100,3],[1,63137,35],[2,63169,5],[2,63138,3],[2,63100,3],[2,63137,35],[3,63171,5],[3,63138,3],[3,63100,3],[3,63137,35],[4,63183,5],[4,63138,3],[4,63100,3],[4,63137,35],[5,63197,5],[5,63138,3],[5,63100,3],[5,63137,35],[6,63207,5],[6,63138,3],[6,63100,3],[6,63137,35]];
      
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
      
      public static function open(param1:Boolean, param2:int, param3:int) : void
      {
         Main.allClosePanel();
         mapNum = param2;
         partNum = param3;
         if(jhp == null)
         {
            jhp = new JinHuaPanel();
         }
         Main.stopXX = true;
         jhp.x = 0;
         jhp.y = 0;
         isPOne = param1;
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
         var _loc1_:uint = 0;
         jhPanel["jh_btn"].visible = false;
         jhPanel["jh_btn"].addEventListener(MouseEvent.CLICK,doJH);
         jhPanel["close"].addEventListener(MouseEvent.CLICK,closeJH);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            jhPanel["e" + _loc1_].mouseChildren = false;
            jhPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            jhPanel["s" + _loc1_].mouseChildren = false;
            jhPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["s" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         jhPanel["select"].gotoAndStop(1);
         jhPanel["select"].visible = false;
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               jhPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(_loc1_) != null)
               {
                  if(partNum == 5)
                  {
                     if(Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() >= partNum && Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() <= 7 && Main.player1.getBag().getEquipFromBag(_loc1_).getColor() == 5)
                     {
                        jhPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
                        jhPanel["e" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["e" + _loc1_].visible = false;
                     }
                  }
                  if(partNum == 8)
                  {
                     if(Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() >= partNum && Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() <= 9 && Main.player1.getBag().getEquipFromBag(_loc1_).getColor() == 5)
                     {
                        jhPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
                        jhPanel["e" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["e" + _loc1_].visible = false;
                     }
                  }
                  else if(Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() == partNum && Main.player1.getBag().getEquipFromBag(_loc1_).getColor() == 5)
                  {
                     jhPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
                     jhPanel["e" + _loc1_].visible = true;
                  }
                  else
                  {
                     jhPanel["e" + _loc1_].visible = false;
                  }
               }
               else
               {
                  jhPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               jhPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_) != null)
               {
                  if(partNum == 5)
                  {
                     if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() >= partNum && Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() <= 7 && Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getColor() == 5)
                     {
                        jhPanel["s" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                        jhPanel["s" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["s" + _loc1_].visible = false;
                     }
                  }
                  else if(partNum == 8)
                  {
                     if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() >= partNum && Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() <= 9 && Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getColor() == 5)
                     {
                        jhPanel["s" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                        jhPanel["s" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["s" + _loc1_].visible = false;
                     }
                  }
                  else if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() == partNum && Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getColor() == 5)
                  {
                     jhPanel["s" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                     jhPanel["s" + _loc1_].visible = true;
                  }
                  else
                  {
                     jhPanel["s" + _loc1_].visible = false;
                  }
               }
               else
               {
                  jhPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               jhPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(_loc1_) != null)
               {
                  if(partNum == 5)
                  {
                     if(Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() >= partNum && Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() <= 7 && Main.player2.getBag().getEquipFromBag(_loc1_).getColor() == 5)
                     {
                        jhPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
                        jhPanel["e" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["e" + _loc1_].visible = false;
                     }
                  }
                  else if(partNum == 8)
                  {
                     if(Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() >= partNum && Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() <= 9 && Main.player2.getBag().getEquipFromBag(_loc1_).getColor() == 5)
                     {
                        jhPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
                        jhPanel["e" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["e" + _loc1_].visible = false;
                     }
                  }
                  else if(Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() == partNum && Main.player2.getBag().getEquipFromBag(_loc1_).getColor() == 5)
                  {
                     jhPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
                     jhPanel["e" + _loc1_].visible = true;
                  }
                  else
                  {
                     jhPanel["e" + _loc1_].visible = false;
                  }
               }
               else
               {
                  jhPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               jhPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_) != null)
               {
                  if(partNum == 5)
                  {
                     if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() >= partNum && Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() <= 7 && Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getColor() == 5)
                     {
                        jhPanel["s" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                        jhPanel["s" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["s" + _loc1_].visible = false;
                     }
                  }
                  if(partNum == 8)
                  {
                     if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() >= partNum && Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() <= 9 && Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getColor() == 5)
                     {
                        jhPanel["s" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                        jhPanel["s" + _loc1_].visible = true;
                     }
                     else
                     {
                        jhPanel["s" + _loc1_].visible = false;
                     }
                  }
                  else if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getPosition() == partNum && Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getColor() == 5)
                  {
                     jhPanel["s" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                     jhPanel["s" + _loc1_].visible = true;
                  }
                  else
                  {
                     jhPanel["s" + _loc1_].visible = false;
                  }
               }
               else
               {
                  jhPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         jhPanel["chose"].visible = false;
         otherShow();
      }
      
      public static function otherShow() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         arr_cl = [];
         count = 0;
         _loc1_ = 0;
         while(_loc1_ < arr.length)
         {
            if(arr[_loc1_][0] == mapNum)
            {
               arr_cl.push(arr[_loc1_]);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = Number(arr_cl[_loc1_][1]);
            jhPanel["x" + _loc1_].gotoAndStop(OtherFactory.getFrame(_loc2_));
            jhPanel["n" + _loc1_].text = arr_cl[_loc1_][2];
            if(isPOne)
            {
               if(Main.player1.getBag().getOtherobjNum(_loc2_) >= arr_cl[_loc1_][2])
               {
                  jhPanel["c" + _loc1_].text = arr_cl[_loc1_][2];
                  ColorX(jhPanel["c" + _loc1_],"0xFFFF00");
                  ++count;
               }
               else
               {
                  jhPanel["c" + _loc1_].text = Main.player1.getBag().getOtherobjNum(_loc2_);
                  ColorX(jhPanel["c" + _loc1_],"0xFF0000");
               }
            }
            else if(Main.player2.getBag().getOtherobjNum(_loc2_) >= arr_cl[_loc1_][2])
            {
               jhPanel["c" + _loc1_].text = arr_cl[_loc1_][2];
               ColorX(jhPanel["c" + _loc1_],"0xFFFF00");
               ++count;
            }
            else
            {
               jhPanel["c" + _loc1_].text = Main.player2.getBag().getOtherobjNum(_loc2_);
               ColorX(jhPanel["c" + _loc1_],"0xFF0000");
            }
            _loc1_++;
         }
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         jhPanel["close"].removeEventListener(MouseEvent.CLICK,closeJH);
         jhPanel["jh_btn"].removeEventListener(MouseEvent.CLICK,doJH);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            jhPanel["e" + _loc1_].mouseChildren = false;
            jhPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["e" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            jhPanel["s" + _loc1_].mouseChildren = false;
            jhPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            jhPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            jhPanel["s" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
      }
      
      public static function closeJH(param1:*) : *
      {
         close();
      }
      
      public static function doJH(param1:*) : *
      {
         var _loc2_:int = 0;
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
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               Main.player1.getBag().delOtherById(arr_cl[_loc2_][1],arr_cl[_loc2_][2]);
               _loc2_++;
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
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               Main.player2.getBag().delOtherById(arr_cl[_loc2_][1],arr_cl[_loc2_][2]);
               _loc2_++;
            }
         }
         NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"装备祝福成功");
         close();
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         jhPanel.addChild(itemsTooltip);
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
         itemsTooltip.x = jhPanel.mouseX + 10;
         itemsTooltip.y = jhPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function tooltipClose(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(param1:MouseEvent) : void
      {
         selbool = true;
         clickObj = param1.target as MovieClip;
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

