package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.repository.probability.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import src.*;
   
   public class XiangQianPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var xqp:XiangQianPanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var clickNum:Number;
      
      public static var equip:Equip;
      
      public static var gem:Gem;
      
      public static var oldNum:Number;
      
      public static var xqPanel:MovieClip = new XQShow();
      
      public static var bagType:Number = 1;
      
      public static var selbool:Boolean = false;
      
      public static var isPOne:Boolean = true;
      
      public function XiangQianPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(xqPanel);
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(xqp == null)
         {
            xqp = new XiangQianPanel();
         }
         Main.stopXX = true;
         xqp.x = 50;
         xqp.y = 0;
         isPOne = true;
         addListenerP1();
         Main.player1.getBag().cheatGem();
         if(Main.P1P2)
         {
            xqPanel["bagOne"].visible = true;
            xqPanel["bagTwo"].visible = true;
         }
         Main._stage.addChild(xqp);
         xqp.visible = true;
      }
      
      public static function close() : void
      {
         xqPanel["xuanze"].gotoAndStop(1);
         isPOne = true;
         bagType = 1;
         gem = null;
         equip = null;
         twoFalse();
         selbool = false;
         if(xqp == null)
         {
            xqp = new XiangQianPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         xqp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         isxqOK();
         xqPanel["bagOne"].isClick = true;
         xqPanel["s1_mc"].stop();
         xqPanel["s2_mc"].stop();
         xqPanel["gold"].text = Main.player1.getGold();
         xqPanel["usegold"].text = "";
         xqPanel["gemName"].text = "";
         xqPanel["equipName"].text = "";
         xqPanel["bagOne"].visible = false;
         xqPanel["bagTwo"].visible = false;
         xqPanel["xuanze"].mouseEnabled = false;
         xqPanel["isXQ"].visible = false;
         xqPanel["isXQ"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesXQ);
         xqPanel["isXQ"]["no_btn"].addEventListener(MouseEvent.CLICK,noXQ);
         xqPanel.addEventListener(BtnEvent.DO_CHANGE,bagListen);
         xqPanel["c1"].addEventListener(MouseEvent.CLICK,changeEquip);
         xqPanel["g1"].addEventListener(MouseEvent.CLICK,changeGem);
         xqPanel["xq_btn"].addEventListener(MouseEvent.CLICK,doXQ);
         xqPanel["close"].addEventListener(MouseEvent.CLICK,closexXQ);
         xqPanel["c1"].mouseChildren = false;
         xqPanel["c1"].addEventListener(MouseEvent.MOUSE_OVER,showE);
         xqPanel["c1"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         xqPanel["g1"].mouseChildren = false;
         xqPanel["g1"].addEventListener(MouseEvent.MOUSE_OVER,showG);
         xqPanel["g1"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            xqPanel["e" + _loc1_].mouseChildren = false;
            xqPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            xqPanel["s" + _loc1_].mouseChildren = false;
            xqPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["s" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         xqPanel["c1"].gotoAndStop(1);
         xqPanel["c1"].visible = false;
         xqPanel["g1"].visible = false;
         if(isPOne)
         {
            showEquipP1();
         }
         else
         {
            showEquipP2();
         }
         xqPanel["chose"].visible = false;
      }
      
      private static function showEquipP1() : *
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            xqPanel["e" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getEquipFromBag(_loc1_) != null)
            {
               if(Main.player1.getBag().getEquipFromBag(_loc1_).getGrid() != -1)
               {
                  xqPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
                  xqPanel["e" + _loc1_].visible = true;
               }
               else
               {
                  xqPanel["e" + _loc1_].visible = false;
               }
            }
            else
            {
               xqPanel["e" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            xqPanel["s" + _loc1_].t_txt.text = "";
            if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_) != null)
            {
               if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getGrid() != -1)
               {
                  xqPanel["s" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                  xqPanel["s" + _loc1_].visible = true;
               }
               else
               {
                  xqPanel["s" + _loc1_].visible = false;
               }
            }
            else
            {
               xqPanel["s" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private static function showEquipP2() : *
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            xqPanel["e" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getEquipFromBag(_loc1_) != null)
            {
               if(Main.player2.getBag().getEquipFromBag(_loc1_).getGrid() != -1)
               {
                  xqPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
                  xqPanel["e" + _loc1_].visible = true;
               }
               else
               {
                  xqPanel["e" + _loc1_].visible = false;
               }
            }
            else
            {
               xqPanel["e" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            xqPanel["s" + _loc1_].t_txt.text = "";
            if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_) != null)
            {
               if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getGrid() != -1)
               {
                  xqPanel["s" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                  xqPanel["s" + _loc1_].visible = true;
               }
               else
               {
                  xqPanel["s" + _loc1_].visible = false;
               }
            }
            else
            {
               xqPanel["s" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private static function showGemP1() : *
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            xqPanel["e" + _loc1_].t_txt.text = "";
            if(Main.player1.getBag().getGemFromBag(_loc1_) != null)
            {
               if(Main.player1.getBag().getGemFromBag(_loc1_).getType() == 3)
               {
                  xqPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getGemFromBag(_loc1_).getFrame());
                  xqPanel["e" + _loc1_].visible = true;
                  if(Main.player1.getBag().getGemFromBag(_loc1_).getIsPile() == true)
                  {
                     xqPanel["e" + _loc1_].t_txt.text = Main.player1.getBag().getGemFromBag(_loc1_).getTimes();
                  }
               }
               else
               {
                  xqPanel["e" + _loc1_].visible = false;
               }
            }
            else
            {
               xqPanel["e" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            xqPanel["s" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private static function showGemP2() : *
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            xqPanel["e" + _loc1_].t_txt.text = "";
            if(Main.player2.getBag().getGemFromBag(_loc1_) != null)
            {
               if(Main.player2.getBag().getGemFromBag(_loc1_).getType() == 3)
               {
                  xqPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getGemFromBag(_loc1_).getFrame());
                  xqPanel["e" + _loc1_].visible = true;
                  if(Main.player2.getBag().getGemFromBag(_loc1_).getIsPile() == true)
                  {
                     xqPanel["e" + _loc1_].t_txt.text = Main.player2.getBag().getGemFromBag(_loc1_).getTimes();
                  }
               }
               else
               {
                  xqPanel["e" + _loc1_].visible = false;
               }
            }
            else
            {
               xqPanel["e" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            xqPanel["s" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         xqPanel["c1"].removeEventListener(MouseEvent.CLICK,changeEquip);
         xqPanel["g1"].removeEventListener(MouseEvent.CLICK,changeGem);
         xqPanel.removeEventListener(BtnEvent.DO_CHANGE,bagListen);
         xqPanel["close"].removeEventListener(MouseEvent.CLICK,closeXQ);
         xqPanel["c1"].removeEventListener(MouseEvent.MOUSE_OVER,showE);
         xqPanel["c1"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         xqPanel["g1"].removeEventListener(MouseEvent.MOUSE_OVER,showG);
         xqPanel["g1"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            xqPanel["e" + _loc1_].mouseChildren = false;
            xqPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["e" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            xqPanel["s" + _loc1_].mouseChildren = false;
            xqPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["s" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
      }
      
      public static function closeXQ(param1:*) : *
      {
         close();
      }
      
      private static function showE(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         xqPanel.addChild(itemsTooltip);
         if(_loc2_.name == "c1")
         {
            if(equip)
            {
               itemsTooltip.equipTooltip(equip);
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = xqPanel.mouseX + 10;
         itemsTooltip.y = xqPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function showG(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         xqPanel.addChild(itemsTooltip);
         if(_loc2_.name == "g1")
         {
            if(gem)
            {
               itemsTooltip.gemTooltip(gem);
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = xqPanel.mouseX + 10;
         itemsTooltip.y = xqPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         xqPanel.addChild(itemsTooltip);
         var _loc3_:uint = uint(_loc2_.name.substr(1,2));
         var _loc4_:String = _loc2_.name.substr(0,1);
         if(isPOne)
         {
            if(bagType == 1)
            {
               if(_loc4_ == "e")
               {
                  if(Main.player1.getBag().getEquipFromBag(_loc3_) != null)
                  {
                     itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(_loc3_),1);
                  }
               }
               else if(_loc4_ == "s")
               {
                  itemsTooltip.slotTooltip(_loc3_,Main.player1.getEquipSlot());
               }
            }
            else if(_loc4_ == "e")
            {
               itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(_loc3_),1);
            }
         }
         else if(bagType == 1)
         {
            if(_loc4_ == "e")
            {
               if(Main.player2.getBag().getEquipFromBag(_loc3_) != null)
               {
                  itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(_loc3_),2);
               }
            }
            else if(_loc4_ == "s")
            {
               itemsTooltip.slotTooltip(_loc3_,Main.player2.getEquipSlot());
            }
         }
         else if(_loc4_ == "e")
         {
            itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(_loc3_),2);
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = xqPanel.mouseX + 10;
         itemsTooltip.y = xqPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      public static function twoFalse() : void
      {
         xqPanel["bagTwo"].isClick = false;
         xqPanel["bagOne"].isClick = false;
      }
      
      private static function bagListen(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         xqPanel["chose"].visible = false;
         switch(_loc2_.name)
         {
            case "bagOne":
               isPOne = true;
               bagType = 1;
               twoFalse();
               equip = null;
               gem = null;
               xqPanel["c1"].visible = false;
               xqPanel["g1"].visible = false;
               xqPanel["equipName"].text = "";
               xqPanel["gemName"].text = "";
               xqPanel["bagOne"].isClick = true;
               xqPanel["gold"].text = Main.player1.getGold();
               showEquipP1();
               break;
            case "bagTwo":
               twoFalse();
               bagType = 1;
               isPOne = false;
               equip = null;
               gem = null;
               xqPanel["c1"].visible = false;
               xqPanel["g1"].visible = false;
               xqPanel["equipName"].text = "";
               xqPanel["gemName"].text = "";
               xqPanel["bagTwo"].isClick = true;
               xqPanel["gold"].text = Main.player2.getGold();
               showEquipP2();
         }
      }
      
      private static function changeEquip(param1:*) : *
      {
         xqPanel["chose"].visible = false;
         if(isPOne)
         {
            showEquipP1();
            xqPanel["xuanze"].gotoAndStop(1);
         }
         else
         {
            showEquipP2();
            xqPanel["xuanze"].gotoAndStop(1);
         }
         bagType = 1;
         xqPanel["c1"].visible = false;
         xqPanel["equipName"].text = "";
         xqPanel["usegold"].text = "";
         equip = null;
         isxqOK();
      }
      
      private static function changeGem(param1:*) : *
      {
         xqPanel["chose"].visible = false;
         xqPanel["g1"].visible = false;
         xqPanel["gemName"].text = "";
         gem = null;
         isxqOK();
      }
      
      private static function isxqOK() : *
      {
         if(Boolean(equip) && Boolean(gem))
         {
            xqPanel["xq_btn"].visible = true;
         }
         else
         {
            xqPanel["xq_btn"].visible = false;
         }
      }
      
      private static function xiangQian() : *
      {
         xqPanel["xq_btn"].visible = true;
         if(Boolean(equip) && Boolean(gem))
         {
            if(isPOne)
            {
               if(Main.player1.getGold() < int(xqPanel["usegold"].text))
               {
                  ShortTip.open(16);
                  return;
               }
               equip.setInGem(gem);
               Main.player1.getBag().delGem(oldNum,1);
               Main.player1.payGold(int(xqPanel["usegold"].text));
               AchData.setXqNum(1);
               xqPanel["gold"].text = Main.player1.getGold();
               showEquipP1();
            }
            else
            {
               if(Main.player2.getGold() < int(xqPanel["usegold"].text))
               {
                  ShortTip.open(16);
                  return;
               }
               Main.player2.payGold(int(xqPanel["usegold"].text));
               equip.setInGem(gem);
               Main.player2.getBag().delGem(oldNum,1);
               AchData.setXqNum(2);
               xqPanel["gold"].text = Main.player2.getGold();
               showEquipP2();
            }
            xqPanel["usegold"].text = "";
            xqPanel["equipName"].text = "";
            xqPanel["gemName"].text = "";
            equip = null;
            gem = null;
            bagType = 1;
            xqPanel["c1"].visible = false;
            xqPanel["g1"].visible = false;
            ShortTip.open(2);
         }
         else
         {
            ShortTip.open(4);
         }
      }
      
      private static function doXQ(param1:*) : *
      {
         xqPanel["chose"].visible = false;
         if(equip)
         {
            if(equip.getGrid() == 0)
            {
               xqPanel["isXQ"].visible = true;
            }
            else
            {
               xqPanel["s1_mc"].gotoAndPlay(1);
               xqPanel["s2_mc"].gotoAndPlay(1);
               xqPanel["xq_btn"].visible = false;
               setTimeout(xiangQian,2800);
            }
         }
      }
      
      private static function yesXQ(param1:*) : *
      {
         xqPanel["s1_mc"].gotoAndPlay(1);
         xqPanel["s2_mc"].gotoAndPlay(1);
         xqPanel["xq_btn"].visible = false;
         setTimeout(xiangQian,2800);
         xqPanel["isXQ"].visible = false;
      }
      
      private static function noXQ(param1:*) : *
      {
         xqPanel["isXQ"].visible = false;
      }
      
      private static function closexXQ(param1:*) : *
      {
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
         xqPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         if(isPOne)
         {
            if(bagType == 1)
            {
               if(nameStr == "e")
               {
                  equip = Main.player1.getBag().getEquipFromBag(clickNum);
               }
               else
               {
                  equip = Main.player1.getEquipSlot().getEquipFromSlot(clickNum);
               }
               xqPanel["usegold"].text = GoldFactory.getMosaicGold(equip.getDropLevel());
               xqPanel["c1"].gotoAndStop(clickObj.currentFrame);
               xqPanel["c1"].visible = true;
               xqPanel["equipName"].text = equip.getName();
               setEquipColor(equip);
               showGemP1();
               xqPanel["xuanze"].gotoAndStop(2);
               bagType = 2;
            }
            else
            {
               if(nameStr == "e")
               {
                  oldNum = clickNum;
                  gem = Main.player1.getBag().getGemFromBag(clickNum);
                  xqPanel["g1"].gotoAndStop(clickObj.currentFrame);
                  xqPanel["g1"].visible = true;
                  xqPanel["gemName"].text = gem.getName();
                  setGemColor(gem);
               }
               xqPanel["chose"].visible = true;
            }
         }
         else if(bagType == 1)
         {
            if(nameStr == "e")
            {
               equip = Main.player2.getBag().getEquipFromBag(clickNum);
            }
            else
            {
               equip = Main.player2.getEquipSlot().getEquipFromSlot(clickNum);
            }
            xqPanel["usegold"].text = GoldFactory.getMosaicGold(equip.getDropLevel());
            xqPanel["c1"].gotoAndStop(clickObj.currentFrame);
            xqPanel["c1"].visible = true;
            xqPanel["equipName"].text = equip.getName();
            setEquipColor(equip);
            showGemP2();
            xqPanel["xuanze"].gotoAndStop(2);
            bagType = 2;
         }
         else
         {
            if(nameStr == "e")
            {
               oldNum = clickNum;
               gem = Main.player2.getBag().getGemFromBag(clickNum);
               xqPanel["g1"].gotoAndStop(clickObj.currentFrame);
               xqPanel["g1"].visible = true;
               xqPanel["gemName"].text = gem.getName();
               setGemColor(gem);
            }
            xqPanel["chose"].visible = true;
         }
         isxqOK();
      }
      
      private static function setGemColor(param1:Gem) : *
      {
         if(param1.getColor() == 1)
         {
            ColorX(xqPanel["gemName"],"0xffffff");
         }
         if(param1.getColor() == 2)
         {
            ColorX(xqPanel["gemName"],"0x0066ff");
         }
         if(param1.getColor() == 3)
         {
            ColorX(xqPanel["gemName"],"0xFF33FF");
         }
      }
      
      private static function setEquipColor(param1:Equip) : *
      {
         if(param1.getColor() == 1)
         {
            ColorX(xqPanel["equipName"],"0xffffff");
         }
         if(param1.getColor() == 2)
         {
            ColorX(xqPanel["equipName"],"0x0066ff");
         }
         if(param1.getColor() == 3)
         {
            ColorX(xqPanel["equipName"],"0xFF33FF");
         }
         if(param1.getColor() == 4)
         {
            ColorX(xqPanel["equipName"],"0xFF9900");
         }
         if(param1.getColor() == 5)
         {
            ColorX(xqPanel["equipName"],"0xFF9900");
         }
         if(param1.getColor() == 6)
         {
            ColorX(xqPanel["equipName"],"0xCC3300");
         }
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
   }
}

