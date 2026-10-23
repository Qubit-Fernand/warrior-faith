package com.hotpoint.braveManIII.views.equipShopPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   import flash.utils.*;
   import src.*;
   
   public class EquipShopPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var dragObj:MovieClip;
      
      public static var clickObj:MovieClip;
      
      private static var pointx:Number;
      
      private static var pointy:Number;
      
      private static var oldNum:Number;
      
      private static var allEquipShopHandle:AllEquipShopHandle;
      
      private static var chosen:Equip;
      
      public static var esp:EquipShopPanel;
      
      public static var equipShowPanel:MovieClip = new EquipShopShow();
      
      public static var isDown:Boolean = false;
      
      public static var returnx:Number = 0;
      
      public static var returny:Number = 0;
      
      public static var shopEquipList:Array = EquipFactory.createEquipByShop();
      
      private static var closeTimes:uint = 0;
      
      private static var openFlag:Boolean = false;
      
      private static var myMenu:ContextMenu = new ContextMenu();
      
      public function EquipShopPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         allEquipShopHandle = new AllEquipShopHandle();
         this.addChild(equipShowPanel);
         if(!Main.P1P2)
         {
            equipShowPanel["lock2P"].visible = true;
            equipShowPanel["buyMenu"]["buy1P"].x += 50;
            equipShowPanel["buyMenu"]["buy2P"].visible = false;
         }
         equipShowPanel["buyMenu"].visible = false;
         equipShowPanel["mySell"].visible = false;
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(esp == null)
         {
            esp = new EquipShopPanel();
         }
         esp.x = 130;
         esp.y = 30;
         addListenerP1();
         if(Main.P1P2)
         {
            addListenerP2();
         }
         Main._stage.addChild(esp);
         esp.visible = true;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(esp == null)
         {
            esp = new EquipShopPanel();
         }
         removeListenerP1();
         if(Main.P1P2)
         {
            removeListenerP2();
         }
         equipShowPanel["mySell"].visible = false;
         esp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            equipShowPanel["s1_" + _loc1_].mouseChildren = false;
            equipShowPanel["s1_" + _loc1_]["t_txt"].visible = false;
            equipShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s1_" + _loc1_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         equipShowPanel.addEventListener(BtnEvent.DO_CLICK,shopListen);
         equipShowPanel.addEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         equipShowPanel.addEventListener(MouseEvent.MOUSE_UP,UpHandler);
         equipShowPanel.addEventListener(MouseEvent.CLICK,menuClose);
         var _loc2_:uint = 0;
         while(_loc2_ < 6)
         {
            equipShowPanel["se_" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["se_" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc2_++;
         }
         equipShowPanel["buyMenu"]["buyPic"].addEventListener(MouseEvent.MOUSE_OVER,buyTooltipOpen);
         equipShowPanel["buyMenu"]["buyPic"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         equipShowPanel["mySell"]["sell_btn"].addEventListener(MouseEvent.CLICK,sellEquip);
         equipShowPanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         equipShowPanel.contextMenu = myMenu;
         equipShowPanel["isSell"].visible = false;
         ShopItemsShow.allHide();
         ShopItemsShow.shopEquipShow();
         ShopItemsShow.equipShow();
         ShopItemsShow.informationShow();
      }
      
      public static function addListenerP2() : *
      {
         equipShowPanel["lock2P"].visible = false;
         equipShowPanel["buyMenu"]["buy2P"].visible = true;
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            equipShowPanel["s2_" + _loc1_].mouseChildren = false;
            equipShowPanel["s2_" + _loc1_]["t_txt"].visible = false;
            equipShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s2_" + _loc1_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         ShopItemsShow.equipShow2P();
         ShopItemsShow.informationShow2P();
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            equipShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s1_" + _loc1_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         equipShowPanel.removeEventListener(BtnEvent.DO_CLICK,shopListen);
         equipShowPanel.removeEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         equipShowPanel.removeEventListener(MouseEvent.MOUSE_UP,UpHandler);
         equipShowPanel.removeEventListener(MouseEvent.CLICK,menuClose);
         equipShowPanel.removeEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.removeEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         var _loc2_:uint = 0;
         while(_loc2_ < 6)
         {
            equipShowPanel["se_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["se_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc2_++;
         }
         equipShowPanel["buyMenu"]["buyPic"].removeEventListener(MouseEvent.MOUSE_OVER,buyTooltipOpen);
         equipShowPanel["buyMenu"]["buyPic"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         equipShowPanel["mySell"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sellEquip);
      }
      
      public static function removeListenerP2() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            equipShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s2_" + _loc1_].removeEventListener(MouseEvent.CLICK,menuOpen);
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
      
      private static function sellEquip(param1:MouseEvent) : void
      {
         var _loc2_:int = int(clickObj.name.substr(3,2));
         var _loc3_:String = clickObj.name.substr(0,2);
         if(_loc3_ == "s1")
         {
            if(Main.player1.getBag().getEquipFromBag(_loc2_).getColor() == 1)
            {
               Main.player1.addGold(Main.player1.getBag().getEquipFromBag(_loc2_).getPrice());
               Main.player1.getBag().delEquip(_loc2_);
            }
            else
            {
               equipShowPanel.addChild(equipShowPanel["isSell"]);
               equipShowPanel["isSell"].visible = true;
            }
         }
         else if(Main.player2.getBag().getEquipFromBag(_loc2_).getColor() == 1)
         {
            Main.player2.addGold(Main.player2.getBag().getEquipFromBag(_loc2_).getPrice());
            Main.player2.getBag().delEquip(_loc2_);
         }
         else
         {
            equipShowPanel.addChild(equipShowPanel["isSell"]);
            equipShowPanel["isSell"].visible = true;
         }
         ShopItemsShow.informationShow();
         ShopItemsShow.equipShow();
         if(Main.P1P2)
         {
            ShopItemsShow.informationShow2P();
            ShopItemsShow.equipShow2P();
         }
      }
      
      private static function sellSure() : void
      {
         var _loc1_:int = int(clickObj.name.substr(3,2));
         var _loc2_:String = clickObj.name.substr(0,2);
         if(_loc2_ == "s1")
         {
            Main.player1.addGold(Main.player1.getBag().getEquipFromBag(_loc1_).getPrice());
            Main.player1.getBag().delEquip(_loc1_);
         }
         else
         {
            Main.player2.addGold(Main.player2.getBag().getEquipFromBag(_loc1_).getPrice());
            Main.player2.getBag().delEquip(_loc1_);
         }
         ShopItemsShow.informationShow();
         ShopItemsShow.equipShow();
         if(Main.P1P2)
         {
            ShopItemsShow.informationShow2P();
            ShopItemsShow.equipShow2P();
         }
         equipShowPanel["isSell"].visible = false;
      }
      
      private static function goNext() : void
      {
         if(openFlag == true)
         {
            equipShowPanel.addChild(equipShowPanel["mySell"]);
            equipShowPanel["mySell"].visible = true;
            equipShowPanel["mySell"].x = clickObj.x + 50;
            equipShowPanel["mySell"].y = clickObj.y + 60;
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
            equipShowPanel["mySell"].visible = false;
            closeTimes = 0;
         }
      }
      
      private static function closeBuy(param1:MouseEvent) : void
      {
         equipShowPanel["buyMenu"].visible = false;
      }
      
      private static function shopListen(param1:BtnEvent) : void
      {
         var _loc2_:Number = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
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
               buyEquipMenu(0 + (_loc2_ - 1) * 6);
               break;
            case "se_1":
               buyEquipMenu(1 + (_loc2_ - 1) * 6);
               break;
            case "se_2":
               buyEquipMenu(2 + (_loc2_ - 1) * 6);
               break;
            case "se_3":
               buyEquipMenu(3 + (_loc2_ - 1) * 6);
               break;
            case "se_4":
               buyEquipMenu(4 + (_loc2_ - 1) * 6);
               break;
            case "se_5":
               buyEquipMenu(5 + (_loc2_ - 1) * 6);
               break;
            case "buy1P":
               buyEquipByPlayerData(Main.player1);
               break;
            case "buy2P":
               buyEquipByPlayerData(Main.player2);
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
               equipShowPanel["isSell"].visible = false;
               break;
            case "closePanel":
               close();
               break;
            case "closeBuyNum":
               equipShowPanel["buyMenu"].visible = false;
         }
      }
      
      private static function setUp() : void
      {
         var _loc1_:int = int(equipShowPanel["buyMenu"]["amount"].text);
         if(_loc1_ == 24)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_++;
         }
         equipShowPanel["buyMenu"]["amount"].text = _loc1_;
      }
      
      private static function setDown() : void
      {
         var _loc1_:* = int(equipShowPanel["buyMenu"]["amount"].text);
         if(_loc1_ == 1)
         {
            _loc1_ = 24;
         }
         else
         {
            _loc1_--;
         }
         equipShowPanel["buyMenu"]["amount"].text = _loc1_;
      }
      
      private static function buyEquipByPlayerData(param1:PlayerData) : void
      {
         var _loc3_:* = 0;
         var _loc2_:int = int(equipShowPanel["buyMenu"]["amount"].text);
         if(param1.getGold() < chosen.getPrice() * _loc2_ * 9)
         {
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"金币不足");
         }
         else
         {
            if(param1.getBag().backequipBagNum() >= _loc2_)
            {
               _loc3_ = _loc2_;
               while(_loc3_ > 0)
               {
                  param1.getBag().addEquipBag(chosen.getClone());
                  param1.payGold(chosen.getPrice() * 9);
                  _loc3_--;
               }
            }
            else
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"背包空间不足");
            }
            ShopItemsShow.equipShow();
            ShopItemsShow.informationShow();
            if(Main.P1P2)
            {
               ShopItemsShow.equipShow2P();
               ShopItemsShow.informationShow2P();
            }
         }
         equipShowPanel["buyMenu"].visible = false;
      }
      
      private static function buyEquipMenu(param1:Number) : void
      {
         equipShowPanel["buyMenu"].visible = true;
         equipShowPanel.addChild(equipShowPanel["buyMenu"]);
         equipShowPanel["buyMenu"]["buyPic"].gotoAndStop(shopEquipList[param1].getFrame());
         equipShowPanel["buyMenu"]["buyPic"]["t_txt"].visible = false;
         chosen = shopEquipList[param1];
      }
      
      private static function changeLeft() : void
      {
         var _loc1_:Number = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
         if(_loc1_ > 1)
         {
            _loc1_--;
            EquipShopPanel.equipShowPanel["pageNumL"].text = _loc1_;
         }
         ShopItemsShow.shopEquipShow();
      }
      
      private static function changeRight() : void
      {
         var _loc1_:Number = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
         var _loc2_:Number = Number(EquipShopPanel.equipShowPanel["pageNumR"].text);
         if(_loc1_ < _loc2_)
         {
            _loc1_++;
            EquipShopPanel.equipShowPanel["pageNumL"].text = _loc1_;
         }
         ShopItemsShow.shopEquipShow();
      }
      
      private static function buyTooltipOpen(param1:MouseEvent) : void
      {
         equipShowPanel.addChild(itemsTooltip);
         itemsTooltip.x = equipShowPanel.mouseX;
         itemsTooltip.y = equipShowPanel.mouseY;
         itemsTooltip.equipTooltip(chosen);
         itemsTooltip.visible = true;
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         equipShowPanel["mySell"].visible = false;
         equipShowPanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = uint(_loc2_.name.substr(3,2));
            itemsTooltip.x = equipShowPanel.mouseX;
            itemsTooltip.y = equipShowPanel.mouseY;
            if(equipShowPanel.mouseX > equipShowPanel.x + 230 && equipShowPanel.mouseY < equipShowPanel.y + 230)
            {
               if(Main.player1.getBag().getEquipFromBag(_loc3_) != null)
               {
                  itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(_loc3_),1);
               }
            }
            else if(equipShowPanel.mouseX > equipShowPanel.x + 230 && equipShowPanel.mouseY > equipShowPanel.y + 230)
            {
               if(Main.player2.getBag().getEquipFromBag(_loc3_) != null)
               {
                  itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(_loc3_),2);
               }
            }
            else
            {
               _loc4_ = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
               itemsTooltip.equipTooltip(shopEquipList[_loc3_ + (_loc4_ - 1) * 6]);
            }
            itemsTooltip.setTooltipPoint();
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
         equipShowPanel["mySell"].visible = false;
         if(itemsTooltip.visible = true)
         {
            itemsTooltip.visible = false;
            isDown = true;
         }
         dragObj = param1.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = equipShowPanel.mouseX;
         pointy = equipShowPanel.mouseY;
         oldNum = uint(dragObj.name.substr(3,2));
      }
      
      private static function DragHandler(param1:MouseEvent) : void
      {
         if(isDown == true)
         {
            if(isDrag(pointx,pointy) == true)
            {
               equipShowPanel["mySell"].visible = false;
               equipShowPanel.addChild(dragObj);
               dragObj.x = equipShowPanel.mouseX - 30;
               dragObj.y = equipShowPanel.mouseY - 30;
               dragObj.startDrag();
            }
         }
      }
      
      private static function isDrag(param1:Number, param2:Number) : Boolean
      {
         if(isDown == true)
         {
            if(equipShowPanel.mouseX > param1 + 1 || equipShowPanel.mouseX < param1 - 1 || equipShowPanel.mouseY > param2 + 1 || equipShowPanel.mouseY < param2 - 1)
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
         var _loc3_:int = equipShowPanel.y + 62;
         var _loc4_:uint = 0;
         for(; _loc4_ < 3; _loc3_ += 50,_loc4_++)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = equipShowPanel.x + 253;
            if(equipShowPanel.mouseY > _loc3_ && equipShowPanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(equipShowPanel.mouseX > _loc5_ && equipShowPanel.mouseX < _loc5_ + 45)
                  {
                     _loc1_ = Boolean(allEquipShopHandle.equipHandle(dragObj,oldNum,_loc2_));
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
         var _loc3_:int = equipShowPanel.y + 275;
         var _loc4_:uint = 0;
         for(; _loc4_ < 3; _loc3_ += 50,_loc4_++)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = equipShowPanel.x + 253;
            if(equipShowPanel.mouseY > _loc3_ && equipShowPanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(equipShowPanel.mouseX > _loc5_ && equipShowPanel.mouseX < _loc5_ + 45)
                  {
                     _loc1_ = Boolean(allEquipShopHandle.equipHandle2P(dragObj,oldNum,_loc2_));
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
   }
}

