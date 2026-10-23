package com.hotpoint.braveManIII.views.suppliesShopPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   import flash.utils.*;
   import src.*;
   
   public class SuppliesShopPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var dragObj:MovieClip;
      
      public static var clickObj:MovieClip;
      
      private static var pointx:Number;
      
      private static var pointy:Number;
      
      private static var oldNum:Number;
      
      private static var allSuppliesShopHandle:AllSuppliesShopHandle;
      
      private static var chosen:Supplies;
      
      public static var ssp:SuppliesShopPanel;
      
      public static var suppliesShowPanel:MovieClip = new SuppliesShopShow();
      
      public static var isDown:Boolean = false;
      
      public static var returnx:Number = 0;
      
      public static var returny:Number = 0;
      
      public static var shopSuppliesList:Array = SuppliesFactory.createSuppliesByShop();
      
      private static var closeTimes:uint = 0;
      
      private static var openFlag:Boolean = false;
      
      private static var myMenu:ContextMenu = new ContextMenu();
      
      public function SuppliesShopPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         allSuppliesShopHandle = new AllSuppliesShopHandle();
         this.addChild(suppliesShowPanel);
         if(!Main.P1P2)
         {
            suppliesShowPanel["lock2P"].visible = true;
            suppliesShowPanel["buyMenu"]["buy1P"].x += 50;
            suppliesShowPanel["buyMenu"]["buy2P"].visible = false;
         }
         suppliesShowPanel["buyMenu"].visible = false;
         suppliesShowPanel["mySell"].visible = false;
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(ssp == null)
         {
            ssp = new SuppliesShopPanel();
         }
         addListenerP1();
         if(Main.P1P2)
         {
            addListenerP2();
         }
         ssp.x = 130;
         ssp.y = 30;
         Main._stage.addChild(ssp);
         ssp.visible = true;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(ssp == null)
         {
            ssp = new SuppliesShopPanel();
         }
         removeListenerP1();
         if(Main.P1P2)
         {
            removeListenerP2();
         }
         suppliesShowPanel["mySell"].visible = false;
         ssp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            suppliesShowPanel["s1_" + _loc1_].mouseChildren = false;
            suppliesShowPanel["s1_" + _loc1_]["t_txt"].visible = false;
            suppliesShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         suppliesShowPanel.addEventListener(BtnEvent.DO_CLICK,shopListen);
         suppliesShowPanel.addEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         suppliesShowPanel.addEventListener(MouseEvent.MOUSE_UP,UpHandler);
         suppliesShowPanel.addEventListener(MouseEvent.CLICK,menuClose);
         suppliesShowPanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         suppliesShowPanel.contextMenu = myMenu;
         var _loc2_:uint = 0;
         while(_loc2_ < 6)
         {
            suppliesShowPanel["se_" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["se_" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc2_++;
         }
         suppliesShowPanel["buyMenu"]["buyPic"].addEventListener(MouseEvent.MOUSE_OVER,buyTooltipOpen);
         suppliesShowPanel["buyMenu"]["buyPic"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         suppliesShowPanel["mySell"]["sell_btn"].addEventListener(MouseEvent.CLICK,sellSupplies);
         suppliesShowPanel["mySell"]["key_btn1"].addEventListener(MouseEvent.CLICK,setKey_1);
         suppliesShowPanel["mySell"]["key_btn2"].addEventListener(MouseEvent.CLICK,setKey_2);
         suppliesShowPanel["mySell"]["key_btn3"].addEventListener(MouseEvent.CLICK,setKey_3);
         suppliesShowPanel["isSell"].visible = false;
         ShopItemsShow.allHide();
         ShopItemsShow.shopSuppliesShow();
         ShopItemsShow.suppliesShow();
         ShopItemsShow.informationShow();
      }
      
      public static function addListenerP2() : *
      {
         suppliesShowPanel["lock2P"].visible = false;
         suppliesShowPanel["buyMenu"]["buy2P"].visible = true;
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            suppliesShowPanel["s2_" + _loc1_].mouseChildren = false;
            suppliesShowPanel["s2_" + _loc1_]["t_txt"].visible = false;
            suppliesShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         ShopItemsShow.suppliesShow2P();
         ShopItemsShow.informationShow2P();
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            suppliesShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         suppliesShowPanel.removeEventListener(BtnEvent.DO_CLICK,shopListen);
         suppliesShowPanel.removeEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         suppliesShowPanel.removeEventListener(MouseEvent.MOUSE_UP,UpHandler);
         suppliesShowPanel.removeEventListener(MouseEvent.CLICK,menuClose);
         suppliesShowPanel.removeEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.removeEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         suppliesShowPanel.contextMenu = myMenu;
         var _loc2_:uint = 0;
         while(_loc2_ < 6)
         {
            suppliesShowPanel["se_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["se_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc2_++;
         }
         suppliesShowPanel["buyMenu"]["buyPic"].removeEventListener(MouseEvent.MOUSE_OVER,buyTooltipOpen);
         suppliesShowPanel["buyMenu"]["buyPic"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         suppliesShowPanel["mySell"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sellSupplies);
         suppliesShowPanel["mySell"]["key_btn1"].removeEventListener(MouseEvent.CLICK,setKey_1);
         suppliesShowPanel["mySell"]["key_btn2"].removeEventListener(MouseEvent.CLICK,setKey_2);
         suppliesShowPanel["mySell"]["key_btn3"].removeEventListener(MouseEvent.CLICK,setKey_3);
      }
      
      public static function removeListenerP2() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            suppliesShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
      }
      
      private static function loseFocus(param1:Event = null) : *
      {
         if(dragObj)
         {
            UpHandler();
         }
      }
      
      private static function sellSupplies(param1:MouseEvent) : void
      {
         var _loc2_:int = int(clickObj.name.substr(3,2));
         var _loc3_:String = clickObj.name.substr(0,2);
         if(_loc3_ == "s1")
         {
            if(Main.player1.getBag().getSuppliesFromBag(_loc2_).getColor() == 1)
            {
               Main.player1.addGold(Main.player1.getBag().getSuppliesFromBag(_loc2_).getPrice());
               Main.player1.getBag().delSupplies(_loc2_);
            }
            else
            {
               suppliesShowPanel.addChild(suppliesShowPanel["isSell"]);
               suppliesShowPanel["isSell"].visible = true;
            }
         }
         else if(Main.player2.getBag().getSuppliesFromBag(_loc2_).getColor() == 1)
         {
            Main.player2.addGold(Main.player2.getBag().getSuppliesFromBag(_loc2_).getPrice());
            Main.player2.getBag().delSupplies(_loc2_);
         }
         else
         {
            suppliesShowPanel.addChild(suppliesShowPanel["isSell"]);
            suppliesShowPanel["isSell"].visible = true;
         }
         ShopItemsShow.suppliesShow();
         ShopItemsShow.informationShow();
         if(Main.P1P2)
         {
            ShopItemsShow.suppliesShow2P();
            ShopItemsShow.informationShow2P();
         }
      }
      
      private static function sellSure() : void
      {
         var _loc1_:int = int(clickObj.name.substr(3,2));
         var _loc2_:String = clickObj.name.substr(0,2);
         if(_loc2_ == "s1")
         {
            Main.player1.addGold(Main.player1.getBag().getSuppliesFromBag(_loc1_).getPrice());
            Main.player1.getBag().delSupplies(_loc1_);
         }
         else
         {
            Main.player2.addGold(Main.player2.getBag().getSuppliesFromBag(_loc1_).getPrice());
            Main.player2.getBag().delSupplies(_loc1_);
         }
         ShopItemsShow.suppliesShow();
         ShopItemsShow.informationShow();
         if(Main.P1P2)
         {
            ShopItemsShow.suppliesShow2P();
            ShopItemsShow.informationShow2P();
         }
         suppliesShowPanel["isSell"].visible = false;
      }
      
      private static function goNext() : void
      {
         if(openFlag == true)
         {
            suppliesShowPanel.addChild(suppliesShowPanel["mySell"]);
            suppliesShowPanel["mySell"].visible = true;
            suppliesShowPanel["mySell"].x = clickObj.x + 50;
            suppliesShowPanel["mySell"].y = clickObj.y + 60;
         }
         openFlag = false;
      }
      
      private static function menuOpen(param1:MouseEvent) : void
      {
         itemsTooltip.visible = false;
         clickObj = param1.target as MovieClip;
         var _loc2_:int = int(clickObj.name.substr(3,2));
         setTimeout(goNext,150);
      }
      
      private static function menuClose(param1:MouseEvent) : void
      {
         ++closeTimes;
         if(closeTimes >= 1)
         {
            suppliesShowPanel["mySell"].visible = false;
            closeTimes = 0;
         }
      }
      
      private static function shopListen(param1:BtnEvent) : void
      {
         var _loc2_:Number = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
         var _loc3_:MovieClip = param1.target as MovieClip;
         switch(_loc3_.name)
         {
            case "leftPage":
               changeLeft();
               break;
            case "rightPage":
               changeRight();
               break;
            case "se_0":
               buySuppliesMenu(0 + (_loc2_ - 1) * 6);
               break;
            case "se_1":
               buySuppliesMenu(1 + (_loc2_ - 1) * 6);
               break;
            case "se_2":
               buySuppliesMenu(2 + (_loc2_ - 1) * 6);
               break;
            case "se_3":
               buySuppliesMenu(3 + (_loc2_ - 1) * 6);
               break;
            case "se_4":
               buySuppliesMenu(4 + (_loc2_ - 1) * 6);
               break;
            case "se_5":
               buySuppliesMenu(5 + (_loc2_ - 1) * 6);
               break;
            case "buy1P":
               buySuppliesByPlayerData(Main.player1);
               break;
            case "buy2P":
               buySuppliesByPlayerData(Main.player2);
               break;
            case "up":
               setUp();
               break;
            case "down":
               setDown();
               break;
            case "yesBtn":
               sellSure();
               break;
            case "noBtn":
               suppliesShowPanel["isSell"].visible = false;
               break;
            case "closePanel":
               close();
               break;
            case "closeBuyNum":
               suppliesShowPanel["buyMenu"].visible = false;
         }
      }
      
      private static function setUp() : void
      {
         var _loc1_:int = int(suppliesShowPanel["buyMenu"]["amount"].text);
         if(_loc1_ == 24)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_++;
         }
         suppliesShowPanel["buyMenu"]["amount"].text = _loc1_;
      }
      
      private static function setDown() : void
      {
         var _loc1_:* = int(suppliesShowPanel["buyMenu"]["amount"].text);
         if(_loc1_ == 1)
         {
            _loc1_ = 24;
         }
         else
         {
            _loc1_--;
         }
         suppliesShowPanel["buyMenu"]["amount"].text = _loc1_;
      }
      
      private static function buySuppliesByPlayerData(param1:PlayerData) : void
      {
         var _loc3_:* = 0;
         var _loc2_:int = int(suppliesShowPanel["buyMenu"]["amount"].text);
         if(param1.getGold() < chosen.getPrice() * _loc2_ * 2)
         {
            ShortTip.open(16);
         }
         else
         {
            if(param1.getBag().backSuppliesBagNum() != 0)
            {
               if(_loc2_ > param1.getBag().backSuppliesBagNum())
               {
                  _loc2_ = int(param1.getBag().backSuppliesBagNum());
               }
               _loc3_ = _loc2_;
               while(_loc3_ > 0)
               {
                  param1.getBag().addSuppliesBag(chosen.getClone());
                  param1.payGold(chosen.getPrice() * 2);
                  _loc3_--;
               }
            }
            else
            {
               ShortTip.open(3);
            }
            ShopItemsShow.suppliesShow();
            ShopItemsShow.informationShow();
            if(Main.P1P2)
            {
               ShopItemsShow.suppliesShow2P();
               ShopItemsShow.informationShow2P();
            }
         }
         suppliesShowPanel["buyMenu"].visible = false;
      }
      
      private static function buySuppliesMenu(param1:Number) : void
      {
         suppliesShowPanel["buyMenu"].visible = true;
         suppliesShowPanel.addChild(suppliesShowPanel["buyMenu"]);
         new MouseEvent(MouseEvent.CLICK);
         suppliesShowPanel["buyMenu"]["buyPic"].gotoAndStop(shopSuppliesList[param1].getFrame());
         suppliesShowPanel["buyMenu"]["buyPic"]["t_txt"].visible = false;
         chosen = shopSuppliesList[param1];
      }
      
      private static function changeLeft() : void
      {
         var _loc1_:Number = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
         if(_loc1_ > 1)
         {
            _loc1_--;
            SuppliesShopPanel.suppliesShowPanel["pageNumL"].text = _loc1_;
         }
         ShopItemsShow.shopSuppliesShow();
      }
      
      private static function changeRight() : void
      {
         var _loc1_:Number = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
         var _loc2_:Number = Number(SuppliesShopPanel.suppliesShowPanel["pageNumR"].text);
         if(_loc1_ < _loc2_)
         {
            _loc1_++;
            SuppliesShopPanel.suppliesShowPanel["pageNumL"].text = _loc1_;
         }
         ShopItemsShow.shopSuppliesShow();
      }
      
      private static function buyTooltipOpen(param1:MouseEvent) : void
      {
         suppliesShowPanel.addChild(itemsTooltip);
         itemsTooltip.x = suppliesShowPanel.mouseX;
         itemsTooltip.y = suppliesShowPanel.mouseY;
         itemsTooltip.suppliesTooltip(chosen);
         itemsTooltip.visible = true;
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         suppliesShowPanel["mySell"].visible = false;
         suppliesShowPanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = uint(_loc2_.name.substr(3,2));
            itemsTooltip.x = suppliesShowPanel.mouseX;
            itemsTooltip.y = suppliesShowPanel.mouseY;
            if(suppliesShowPanel.mouseX > suppliesShowPanel.x + 230 && suppliesShowPanel.mouseY < suppliesShowPanel.y + 230)
            {
               if(Main.player1.getBag().getSuppliesFromBag(_loc3_) != null)
               {
                  itemsTooltip.suppliesTooltip(Main.player1.getBag().getSuppliesFromBag(_loc3_),1);
               }
            }
            else if(suppliesShowPanel.mouseX > suppliesShowPanel.x + 230 && suppliesShowPanel.mouseY > suppliesShowPanel.y + 230)
            {
               if(Main.player2.getBag().getSuppliesFromBag(_loc3_) != null)
               {
                  itemsTooltip.suppliesTooltip(Main.player2.getBag().getSuppliesFromBag(_loc3_),2);
               }
            }
            else
            {
               _loc4_ = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
               itemsTooltip.suppliesTooltip(shopSuppliesList[_loc3_ + (_loc4_ - 1) * 6]);
            }
            itemsTooltip.visible = true;
         }
      }
      
      private static function tooltipClose(param1:MouseEvent) : void
      {
         if(isDown == false)
         {
            itemsTooltip.visible = false;
         }
      }
      
      private static function DownHandler(param1:MouseEvent) : void
      {
         suppliesShowPanel["mySell"].visible = false;
         if(itemsTooltip.visible = true)
         {
            itemsTooltip.visible = false;
            isDown = true;
         }
         dragObj = param1.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = suppliesShowPanel.mouseX;
         pointy = suppliesShowPanel.mouseY;
         oldNum = uint(dragObj.name.substr(3,2));
      }
      
      private static function DragHandler(param1:MouseEvent) : void
      {
         if(isDown == true)
         {
            if(isDrag(pointx,pointy) == true)
            {
               suppliesShowPanel["mySell"].visible = false;
               suppliesShowPanel.addChild(dragObj);
               dragObj.x = suppliesShowPanel.mouseX - 30;
               dragObj.y = suppliesShowPanel.mouseY - 30;
               dragObj.startDrag();
            }
         }
      }
      
      private static function isDrag(param1:Number, param2:Number) : Boolean
      {
         if(isDown == true)
         {
            if(suppliesShowPanel.mouseX > param1 + 1 || suppliesShowPanel.mouseX < param1 - 1 || suppliesShowPanel.mouseY > param2 + 1 || suppliesShowPanel.mouseY < param2 - 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function UpHandler(param1:MouseEvent = null) : void
      {
         if(dragObj)
         {
            dragObj.stopDrag();
            if(menuTest() == true)
            {
               openFlag = true;
            }
            else
            {
               openFlag = false;
            }
            if(inItemsRange() == false && inItemsRange2P() == false)
            {
               dragObj.x = returnx;
               dragObj.y = returny;
            }
            isDown = false;
         }
         dragObj = null;
      }
      
      private static function menuTest() : Boolean
      {
         if(dragObj.x > returnx + 20 || dragObj.y > returny + 20 || dragObj.x < returnx - 20 || dragObj.y < returny - 20)
         {
            return false;
         }
         return true;
      }
      
      private static function inItemsRange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(dragObj.name.substr(0,2) == "s2")
         {
            return false;
         }
         var _loc2_:uint = 0;
         var _loc3_:int = suppliesShowPanel.y + 62;
         var _loc4_:uint = 0;
         for(; _loc4_ < 3; _loc3_ += 50,_loc4_++)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = suppliesShowPanel.x + 253;
            if(suppliesShowPanel.mouseY > _loc3_ && suppliesShowPanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(suppliesShowPanel.mouseX > _loc5_ && suppliesShowPanel.mouseX < _loc5_ + 45)
                  {
                     _loc1_ = Boolean(allSuppliesShopHandle.suppliesHandle(dragObj,oldNum,_loc2_));
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return _loc1_;
                     break;
                  }
                  _loc2_++;
                  _loc5_ += 48;
                  _loc6_++;
               }
            }
         }
         return false;
      }
      
      private static function inItemsRange2P() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(dragObj.name.substr(0,2) == "s1")
         {
            return false;
         }
         var _loc2_:uint = 0;
         var _loc3_:int = suppliesShowPanel.y + 275;
         var _loc4_:uint = 0;
         for(; _loc4_ < 3; _loc3_ += 50,_loc4_++)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = suppliesShowPanel.x + 253;
            if(suppliesShowPanel.mouseY > _loc3_ && suppliesShowPanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(suppliesShowPanel.mouseX > _loc5_ && suppliesShowPanel.mouseX < _loc5_ + 45)
                  {
                     _loc1_ = Boolean(allSuppliesShopHandle.suppliesHandle2P(dragObj,oldNum,_loc2_));
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return _loc1_;
                     break;
                  }
                  _loc2_++;
                  _loc5_ += 48;
                  _loc6_++;
               }
            }
         }
         return false;
      }
      
      public static function setKey_1(param1:MouseEvent) : *
      {
         var _loc2_:Supplies = null;
         var _loc3_:int = int(clickObj.name.substr(3,2));
         var _loc4_:String = clickObj.name.substr(0,2);
         if(_loc4_ == "s1")
         {
            _loc2_ = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(_loc2_,0);
         }
         else
         {
            _loc2_ = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(_loc2_,0);
         }
      }
      
      public static function setKey_2(param1:MouseEvent) : *
      {
         var _loc2_:Supplies = null;
         var _loc3_:int = int(clickObj.name.substr(3,2));
         var _loc4_:String = clickObj.name.substr(0,2);
         if(_loc4_ == "s1")
         {
            _loc2_ = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(_loc2_,1);
         }
         else
         {
            _loc2_ = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(_loc2_,1);
         }
      }
      
      public static function setKey_3(param1:MouseEvent) : *
      {
         var _loc2_:Supplies = null;
         var _loc3_:int = int(clickObj.name.substr(3,2));
         var _loc4_:String = clickObj.name.substr(0,2);
         if(_loc4_ == "s1")
         {
            _loc2_ = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(_loc2_,2);
         }
         else
         {
            _loc2_ = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(_loc2_,2);
         }
      }
   }
}

