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
      
      public static function open(param1:Boolean) : void
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
         isPOne = param1;
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
         clickObj = null;
      }
      
      public static function addListenerP1() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         xlPanel["xilian_ZZ"].visible = false;
         xlPanel["waiting"].visible = false;
         xlPanel["xl_btn"].addEventListener(MouseEvent.CLICK,doXL);
         xlPanel["close"].addEventListener(MouseEvent.CLICK,closeXL);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            xlPanel["e" + _loc1_].mouseChildren = false;
            xlPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            xlPanel["s" + _loc1_].mouseChildren = false;
            xlPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["s" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         xlPanel["s1_mc"].stop();
         xlPanel["s2_mc"].stop();
         xlPanel["select"].gotoAndStop(1);
         xlPanel["select"].visible = false;
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               xlPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(_loc1_) != null && (Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() <= 7 || Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() >= 10))
               {
                  xlPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
                  xlPanel["e" + _loc1_].visible = true;
               }
               else
               {
                  xlPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               _loc2_ = int(_loc1_);
               if(Main.water.getValue() != 1 && (_loc2_ == 0 || _loc2_ == 1 || _loc2_ == 3 || _loc2_ == 4))
               {
                  _loc2_ += 8;
               }
               xlPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(_loc2_) != null)
               {
                  xlPanel["s" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc2_).getFrame());
                  xlPanel["s" + _loc1_].visible = true;
               }
               else
               {
                  xlPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               xlPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(_loc1_) != null && (Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() <= 7 || Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() >= 10))
               {
                  xlPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
                  xlPanel["e" + _loc1_].visible = true;
               }
               else
               {
                  xlPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               _loc2_ = int(_loc1_);
               if(Main.water.getValue() != 1 && (_loc2_ == 0 || _loc2_ == 1 || _loc2_ == 3 || _loc2_ == 4))
               {
                  _loc2_ += 8;
               }
               xlPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(_loc2_) != null)
               {
                  xlPanel["s" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc2_).getFrame());
                  xlPanel["s" + _loc1_].visible = true;
               }
               else
               {
                  xlPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         xlPanel["chose"].visible = false;
         xlPanel.point_txt.text = Shop4399.moneyAll.getValue();
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         xlPanel["close"].removeEventListener(MouseEvent.CLICK,closeXL);
         xlPanel["xl_btn"].removeEventListener(MouseEvent.CLICK,doXL);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            xlPanel["e" + _loc1_].mouseChildren = false;
            xlPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["e" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            xlPanel["s" + _loc1_].mouseChildren = false;
            xlPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xlPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xlPanel["s" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
      }
      
      public static function closeXL(param1:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         xlPanel.addChild(itemsTooltip);
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
         itemsTooltip.x = xlPanel.mouseX + 10;
         itemsTooltip.y = xlPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function doXL(param1:*) : *
      {
         var _loc2_:uint = 0;
         if(clickObj)
         {
            xlPanel["xl_btn"].visible = false;
            xlPanel["xilian_ZZ"].visible = true;
            if(isPOne)
            {
               if(Main.player1.getBag().getOtherobjNum(63210) > 0)
               {
                  moneyOK = true;
                  Main.player1.getBag().delOtherById(63210,1);
                  xlOK();
                  return;
               }
            }
            else if(Main.player2.getBag().getOtherobjNum(63210) > 0)
            {
               moneyOK = true;
               Main.player2.getBag().delOtherById(63210,1);
               xlOK();
               return;
            }
            if(clickOK)
            {
               Api_4399_All.BuyObj(InitData.XiLian_Money.getValue());
               moneyOK = true;
               xlPanel["waiting"].visible = true;
               xlPanel["s1_mc"].gotoAndPlay(1);
               xlPanel["s2_mc"].gotoAndPlay(1);
               xlPanel["xl_btn"].visible = false;
               _loc2_ = 0;
               while(_loc2_ < 24)
               {
                  xlPanel["e" + _loc2_].removeEventListener(MouseEvent.CLICK,selected);
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < 6)
               {
                  xlPanel["s" + _loc2_].removeEventListener(MouseEvent.CLICK,selected);
                  _loc2_++;
               }
            }
         }
      }
      
      public static function xlOK() : *
      {
         var _loc1_:uint = 0;
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
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               xlPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               xlPanel["s" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
               _loc1_++;
            }
            JiHua_Interface.ppp4_10 = true;
            xlPanel["waiting"].visible = false;
            xlPanel["s1_mc"].gotoAndStop(1);
            xlPanel["s2_mc"].gotoAndStop(1);
            tempTime = 0;
            moneyOK = false;
            juanShow();
            Main.Save();
         }
      }
      
      private static function juanShow() : *
      {
         if(isPOne)
         {
            xlPanel["juan_num"].text = "当前拥有" + Main.player1.getBag().getOtherobjNum(63210) + "张洗练卷";
         }
         else
         {
            xlPanel["juan_num"].text = "当前拥有" + Main.player2.getBag().getOtherobjNum(63210) + "张洗练卷";
         }
      }
      
      private static function noShow() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 8)
         {
            xlPanel["txt_" + _loc1_].visible = false;
            xlPanel["txtb_" + _loc1_].visible = false;
            _loc1_++;
         }
         juanShow();
      }
      
      private static function showAttrib(param1:Equip) : *
      {
         noShow();
         var _loc2_:Array = param1.showBaseAttrib();
         var _loc3_:uint = 0;
         var _loc4_:uint = 4;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc2_[_loc5_][0] == 1)
            {
               xlPanel["txt_" + _loc3_].text = _loc2_[_loc5_][1];
               xlPanel["txt_" + _loc3_].visible = true;
               _loc3_++;
            }
            else
            {
               xlPanel["txt_" + _loc4_].text = _loc2_[_loc5_][1];
               xlPanel["txt_" + _loc4_].visible = true;
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      private static function showAttrib2(param1:Equip) : *
      {
         var _loc2_:Array = param1.showBaseAttrib();
         var _loc3_:uint = 0;
         var _loc4_:uint = 4;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc2_[_loc5_][0] == 1)
            {
               xlPanel["txtb_" + _loc3_].text = _loc2_[_loc5_][1];
               xlPanel["txtb_" + _loc3_].visible = true;
               _loc3_++;
            }
            else
            {
               xlPanel["txtb_" + _loc4_].text = _loc2_[_loc5_][1];
               xlPanel["txtb_" + _loc4_].visible = true;
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      private static function tooltipClose(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(param1:MouseEvent) : void
      {
         clickOK = true;
         clickObj = param1.target as MovieClip;
         xlPanel["chose"].visible = true;
         xlPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         if(nameStr != "e" && Main.water.getValue() != 1 && (clickNum == 0 || clickNum == 1 || clickNum == 3 || clickNum == 4))
         {
            clickNum += 8;
         }
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

