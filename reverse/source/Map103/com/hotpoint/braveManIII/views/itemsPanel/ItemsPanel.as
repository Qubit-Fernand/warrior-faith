package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   import src.*;
   
   public class ItemsPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var ip:ItemsPanel;
      
      public static var dragObj:MovieClip;
      
      public static var menuTooltip:MenuTooltip;
      
      private static var allBagHandle:AllBagHandle;
      
      public static var clickObj:MovieClip;
      
      private static var pointx:Number;
      
      private static var pointy:Number;
      
      public static var player1:PlayerData;
      
      public static var player2:PlayerData;
      
      public static var boolFlag:Boolean = false;
      
      public static var itemsPanel:MovieClip = new ItemsShow();
      
      public static var isDown:Boolean = false;
      
      public static var returnx:int = 0;
      
      public static var returny:int = 0;
      
      private static var oldNum:uint = 0;
      
      public static var itemsType:uint = 1;
      
      public static var itemsType2P:uint = 1;
      
      private static var openFlag:Boolean = false;
      
      private static var closeTimes:uint = 0;
      
      private static var myMenu:ContextMenu = new ContextMenu();
      
      public function ItemsPanel()
      {
         super();
         player1 = Main.player1;
         player2 = Main.player2;
         menuTooltip = new MenuTooltip();
         itemsTooltip = new ItemsTooltip();
         allBagHandle = new AllBagHandle();
         this.addChild(itemsPanel);
         if(player2)
         {
            itemsPanel["lock2P"].visible = true;
         }
      }
      
      private static function getPart(param1:Number) : uint
      {
         switch(param1)
         {
            case 1:
               return 0;
            case 2:
               return 1;
            case 3:
               return 3;
            case 4:
               return 4;
            case 5:
               return 2;
            case 6:
               return 2;
            case 7:
               return 2;
            default:
               return null;
         }
      }
      
      private static function isDrag(param1:Number, param2:Number) : Boolean
      {
         if(isDown == true)
         {
            if(itemsPanel.mouseX > param1 + 1 || itemsPanel.mouseX < param1 - 1 || itemsPanel.mouseY > param2 + 1 || itemsPanel.mouseY < param2 - 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function wearHandler2P(param1:MouseEvent) : void
      {
         var _loc2_:Equip = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(itemsType2P == 1)
         {
            dragObj = param1.target as MovieClip;
            oldNum = uint(dragObj.name.substr(3,2));
            _loc3_ = uint(getPart(player2.getBag().getEquipFromBag(oldNum).getPosition()));
            _loc4_ = uint(dragObj.currentFrame);
            if(player2.getBag().getEquipFromBag(oldNum).getDressLevel() <= player2.getLevel())
            {
               if(player2.getEquipSlot().getEquipFromSlot(_loc3_) == null)
               {
                  player2.getEquipSlot().addToSlot(player2.getBag().getEquipFromBag(oldNum),_loc3_);
                  player2.getBag().delEquip(oldNum);
               }
               else
               {
                  _loc2_ = player2.getEquipSlot().delSlot(_loc3_);
                  player2.getEquipSlot().addToSlot(player2.getBag().getEquipFromBag(oldNum),_loc3_);
                  player2.getBag().delEquip(oldNum);
                  player2.getBag().addToEquipBag(_loc2_,oldNum);
                  tooltipOpen(param1);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.LoadPlayerLvData();
            BagItemsShow.slotShow2P();
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
            openFlag = false;
            dragObj = null;
            menuTooltip.visible = false;
         }
         changeModel(player2);
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
            if(inItemsRange() == false && inEquipSlotRange() == false && inItemsRange2P() == false && inEquipSlotRange2P() == false)
            {
               dragObj.x = returnx;
               dragObj.y = returny;
            }
         }
         isDown = false;
         dragObj = null;
      }
      
      private static function menuTest() : Boolean
      {
         if(dragObj.x > returnx + 1 || dragObj.y > returny + 1 || dragObj.x < returnx - 1 || dragObj.y < returny - 1)
         {
            return false;
         }
         return true;
      }
      
      private static function inEquipSlotRange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(dragObj.name.substr(0,2) == "s2" || dragObj.name.substr(0,2) == "z2")
         {
            return false;
         }
         if(itemsPanel.mouseX < 280 && itemsPanel.mouseY < 250)
         {
            if(dragObj.name.substr(0,2) == "z1")
            {
               return false;
            }
            if(itemsType != 1)
            {
               return false;
            }
            _loc3_ = itemsPanel.x + 35;
            _loc4_ = 0;
            for(; _loc4_ < 2; _loc3_ += 185,_loc4_++)
            {
               _loc2_ = 3 * _loc4_;
               _loc5_ = itemsPanel.y + 66;
               if(itemsPanel.mouseX > _loc3_ && itemsPanel.mouseX < _loc3_ + 52)
               {
                  _loc6_ = 0;
                  while(_loc6_ < 3)
                  {
                     if(itemsPanel.mouseY > _loc5_ && itemsPanel.mouseY < _loc5_ + 52)
                     {
                        _loc1_ = Boolean(allBagHandle.slotHandle(dragObj,oldNum,_loc2_));
                        dragObj.x = returnx;
                        dragObj.y = returny;
                        return _loc1_;
                        break;
                     }
                     _loc2_++;
                     _loc5_ += 54;
                     _loc6_++;
                  }
               }
            }
            return false;
         }
         return false;
      }
      
      public static function addListenerP1() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            itemsPanel["s1_" + _loc1_].mouseChildren = false;
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.DOUBLE_CLICK,wearHandler);
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["s1_" + _loc1_].doubleClickEnabled = true;
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            itemsPanel["z1_" + _loc2_].mouseChildren = false;
            itemsPanel["z1_" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + _loc2_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc2_++;
         }
         itemsPanel.addEventListener(BtnEvent.DO_CLICK,clickListen);
         itemsPanel.addEventListener(BtnEvent.DO_CHANGE,bagListen);
         itemsPanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         itemsPanel.contextMenu = myMenu;
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            itemsPanel["g1_" + _loc3_].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g1_" + _loc3_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g1_" + _loc3_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc3_++;
         }
         itemsPanel.addEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         itemsPanel.addEventListener(MouseEvent.MOUSE_UP,UpHandler);
         itemsPanel.addEventListener(MouseEvent.CLICK,menuClose);
         menuTooltip.addListener();
         BagItemsShow.allHide();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.skillSlotShow();
         BagItemsShow.informationShow();
         allFalseP1();
         itemsPanel["bg1_1"].isClick = true;
         itemsPanel["isSell"].visible = false;
         itemsPanel["isAllSell"].visible = false;
         itemsPanel["sellMenu"].visible = false;
         itemsType = 1;
      }
      
      public static function addListenerP2() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            itemsPanel["s2_" + _loc1_].mouseChildren = false;
            itemsPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s2_" + _loc1_].addEventListener(MouseEvent.DOUBLE_CLICK,wearHandler2P);
            itemsPanel["s2_" + _loc1_].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["s2_" + _loc1_].doubleClickEnabled = true;
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            itemsPanel["z2_" + _loc2_].mouseChildren = false;
            itemsPanel["z2_" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z2_" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z2_" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z2_" + _loc2_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            itemsPanel["g2_" + _loc3_].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g2_" + _loc3_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g2_" + _loc3_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc3_++;
         }
         itemsPanel["lock2P"].visible = false;
         BagItemsShow.equipShow2P();
         BagItemsShow.slotShow2P();
         BagItemsShow.skillSlotShow2P();
         BagItemsShow.informationShow2P();
         allFalseP2();
         itemsPanel["bg2_1"].isClick = true;
         itemsType2P = 1;
      }
      
      private static function DownHandler(param1:MouseEvent) : void
      {
         menuTooltip.visible = false;
         itemsTooltip.visible = false;
         isDown = true;
         dragObj = param1.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = itemsPanel.mouseX;
         pointy = itemsPanel.mouseY;
         oldNum = uint(dragObj.name.substr(3,2));
      }
      
      private static function tooltipClose(param1:MouseEvent) : void
      {
         if(isDown == false)
         {
            itemsTooltip.visible = false;
         }
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.DOUBLE_CLICK,wearHandler);
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            itemsPanel["g1_" + _loc3_].removeEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g1_" + _loc3_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g1_" + _loc3_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc3_++;
         }
         itemsPanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         itemsPanel.contextMenu = myMenu;
         itemsPanel.removeEventListener(BtnEvent.DO_CLICK,clickListen);
         itemsPanel.removeEventListener(BtnEvent.DO_CHANGE,bagListen);
         itemsPanel.removeEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         itemsPanel.removeEventListener(MouseEvent.MOUSE_UP,UpHandler);
         itemsPanel.removeEventListener(MouseEvent.CLICK,menuClose);
         menuTooltip.removeListener();
      }
      
      public static function removeListenerP2() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            itemsPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s2_" + _loc1_].removeEventListener(MouseEvent.DOUBLE_CLICK,wearHandler2P);
            itemsPanel["s2_" + _loc1_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            itemsPanel["z2_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z2_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z2_" + _loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z2_" + _loc2_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            itemsPanel["g2_" + _loc3_].removeEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g2_" + _loc3_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g2_" + _loc3_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc3_++;
         }
      }
      
      private static function inItemsRange2P() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(dragObj.name.substr(0,2) == "s1" || dragObj.name.substr(0,2) == "z1")
         {
            return false;
         }
         _loc2_ = 0;
         _loc3_ = itemsPanel.y + 312;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = itemsPanel.x + 293;
            if(itemsPanel.mouseY > _loc3_ && itemsPanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(itemsPanel.mouseX > _loc5_ && itemsPanel.mouseX < _loc5_ + 45)
                  {
                     switch(itemsType2P)
                     {
                        case 1:
                           _loc1_ = Boolean(allBagHandle.equipHandle2P(dragObj,oldNum,_loc2_));
                           break;
                        case 2:
                           _loc1_ = Boolean(allBagHandle.suppliesHandle2P(dragObj,oldNum,_loc2_));
                           break;
                        case 3:
                           _loc1_ = Boolean(allBagHandle.gemHandle2P(dragObj,oldNum,_loc2_));
                           break;
                        case 4:
                           trace("b");
                           break;
                        case 5:
                           trace("c");
                     }
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return _loc1_;
                  }
                  _loc2_++;
                  _loc5_ += 48;
                  _loc6_++;
               }
            }
            _loc3_ += 50;
            _loc4_++;
         }
         return false;
      }
      
      private static function loseFocus(param1:Event = null) : *
      {
         if(dragObj)
         {
            UpHandler();
         }
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         boolFlag = true;
         if(ip == null)
         {
            ip = new ItemsPanel();
         }
         Main.stopXX = true;
         ip.x = 130;
         ip.y = 0;
         addListenerP1();
         if(player2)
         {
            addListenerP2();
         }
         Main._stage.addChild(ip);
         ip.visible = true;
      }
      
      private static function wearHandler(param1:MouseEvent) : void
      {
         var _loc2_:Equip = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(itemsType == 1)
         {
            dragObj = param1.target as MovieClip;
            oldNum = uint(dragObj.name.substr(3,2));
            _loc3_ = uint(getPart(player1.getBag().getEquipFromBag(oldNum).getPosition()));
            _loc4_ = uint(dragObj.currentFrame);
            if(player1.getBag().getEquipFromBag(oldNum).getDressLevel() <= player1.getLevel())
            {
               if(player1.getEquipSlot().getEquipFromSlot(_loc3_) == null)
               {
                  player1.getEquipSlot().addToSlot(player1.getBag().getEquipFromBag(oldNum),_loc3_);
                  player1.getBag().delEquip(oldNum);
               }
               else
               {
                  _loc2_ = player1.getEquipSlot().delSlot(_loc3_);
                  player1.getEquipSlot().addToSlot(player1.getBag().getEquipFromBag(oldNum),_loc3_);
                  player1.getBag().delEquip(oldNum);
                  player1.getBag().addToEquipBag(_loc2_,oldNum);
                  tooltipOpen(param1);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.LoadPlayerLvData();
            BagItemsShow.slotShow();
            BagItemsShow.equipShow();
            BagItemsShow.informationShow();
            openFlag = false;
            dragObj = null;
            menuTooltip.visible = false;
         }
         changeModel(player1);
      }
      
      private static function menuClose(param1:MouseEvent) : void
      {
         ++closeTimes;
         if(closeTimes > 1)
         {
            menuTooltip.visible = false;
            closeTimes = 0;
         }
      }
      
      private static function menuOpen(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         itemsTooltip.visible = false;
         clickObj = param1.target as MovieClip;
         _loc2_ = clickObj.name.substr(0,2);
         oldNum = int(clickObj.name.substr(3,2));
         if(openFlag == true)
         {
            if(_loc2_ == "s1")
            {
               menuTooltip.setItemsMenu(itemsType,oldNum,1);
               itemsPanel.addChild(menuTooltip);
               menuTooltip.x = clickObj.x + 30;
               menuTooltip.y = clickObj.y + 30;
               menuTooltip.visible = true;
               closeTimes = 0;
            }
            else if(_loc2_ == "s2")
            {
               menuTooltip.setItemsMenu(itemsType2P,oldNum,2);
               itemsPanel.addChild(menuTooltip);
               menuTooltip.x = clickObj.x + 30;
               menuTooltip.y = clickObj.y + 30;
               menuTooltip.visible = true;
               closeTimes = 0;
            }
            else if(_loc2_ == "z1")
            {
               if(oldNum != 2 && oldNum != 5)
               {
                  menuTooltip.setSlotMenu(oldNum,1);
                  itemsPanel.addChild(menuTooltip);
                  menuTooltip.x = clickObj.x + 30;
                  menuTooltip.y = clickObj.y + 30;
                  menuTooltip.visible = true;
                  closeTimes = 0;
               }
            }
            else if(_loc2_ == "z2")
            {
               if(oldNum != 2 && oldNum != 5)
               {
                  menuTooltip.setSlotMenu(oldNum,2);
                  itemsPanel.addChild(menuTooltip);
                  menuTooltip.x = clickObj.x + 30;
                  menuTooltip.y = clickObj.y + 30;
                  menuTooltip.visible = true;
                  closeTimes = 0;
               }
            }
         }
         if(_loc2_ == "g1")
         {
            menuTooltip.setSkillSlotMenu(oldNum,1);
            itemsPanel.addChild(menuTooltip);
            menuTooltip.x = clickObj.x + 20;
            menuTooltip.y = clickObj.y + 20;
            menuTooltip.visible = true;
            closeTimes = 0;
         }
         else if(_loc2_ == "g2")
         {
            menuTooltip.setSkillSlotMenu(oldNum,2);
            itemsPanel.addChild(menuTooltip);
            menuTooltip.x = clickObj.x + 20;
            menuTooltip.y = clickObj.y + 20;
            menuTooltip.visible = true;
            closeTimes = 0;
         }
         openFlag = false;
         clickObj = null;
      }
      
      public static function allFalseP1() : void
      {
         itemsPanel["bg1_1"].isClick = false;
         itemsPanel["bg1_2"].isClick = false;
         itemsPanel["bg1_3"].isClick = false;
         itemsPanel["bg1_4"].isClick = false;
         itemsPanel["bg1_5"].isClick = false;
      }
      
      public static function allFalseP2() : void
      {
         itemsPanel["bg2_1"].isClick = false;
         itemsPanel["bg2_2"].isClick = false;
         itemsPanel["bg2_3"].isClick = false;
         itemsPanel["bg2_4"].isClick = false;
         itemsPanel["bg2_5"].isClick = false;
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         menuTooltip.visible = false;
         itemsPanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = uint(_loc2_.name.substr(3,2));
            _loc4_ = _loc2_.name.substr(0,2);
            itemsTooltip.x = itemsPanel.mouseX;
            itemsTooltip.y = itemsPanel.mouseY;
            if(itemsPanel.mouseX > itemsPanel.x + 280 && itemsPanel.mouseY < itemsPanel.y + 270)
            {
               switch(itemsType)
               {
                  case 1:
                     if(player1.getBag().getEquipFromBag(_loc3_) != null)
                     {
                        itemsTooltip.equipTooltip(player1.getBag().getEquipFromBag(_loc3_),1);
                     }
                     break;
                  case 2:
                     if(player1.getBag().getSuppliesFromBag(_loc3_) != null)
                     {
                        itemsTooltip.suppliesTooltip(player1.getBag().getSuppliesFromBag(_loc3_),1);
                     }
                     break;
                  case 3:
                     if(player1.getBag().getGemFromBag(_loc3_) != null)
                     {
                        itemsTooltip.gemTooltip(player1.getBag().getGemFromBag(_loc3_),1);
                     }
                     break;
                  case 4:
                     trace("d");
                     break;
                  case 5:
                     if(player1.getBag().getQuestFromBag(_loc3_) != null)
                     {
                        itemsTooltip.questTooltip(player1.getBag().getQuestFromBag(_loc3_));
                     }
               }
            }
            else if(itemsPanel.mouseX < itemsPanel.x + 280 && itemsPanel.mouseY < itemsPanel.y + 270)
            {
               if(_loc4_ == "g1")
               {
                  if(player1.getEquipSkillSlot().getGemFromSkillSlot(_loc3_) != null)
                  {
                     itemsTooltip.gemTooltip(player1.getEquipSkillSlot().getGemFromSkillSlot(_loc3_));
                  }
               }
               else
               {
                  itemsTooltip.slotTooltip(_loc3_,player1.getEquipSlot());
               }
            }
            else if(itemsPanel.mouseX > itemsPanel.x + 280 && itemsPanel.mouseY > itemsPanel.y + 270)
            {
               switch(itemsType2P)
               {
                  case 1:
                     if(player2.getBag().getEquipFromBag(_loc3_) != null)
                     {
                        itemsTooltip.equipTooltip(player2.getBag().getEquipFromBag(_loc3_),2);
                     }
                     break;
                  case 2:
                     if(player2.getBag().getSuppliesFromBag(_loc3_) != null)
                     {
                        itemsTooltip.suppliesTooltip(player2.getBag().getSuppliesFromBag(_loc3_),2);
                     }
                     break;
                  case 3:
                     if(player2.getBag().getGemFromBag(_loc3_) != null)
                     {
                        itemsTooltip.gemTooltip(player2.getBag().getGemFromBag(_loc3_),2);
                     }
                     break;
                  case 4:
                     trace("d");
                     break;
                  case 5:
                     if(player2.getBag().getQuestFromBag(_loc3_) != null)
                     {
                        itemsTooltip.questTooltip(player2.getBag().getQuestFromBag(_loc3_));
                     }
               }
            }
            else if(_loc4_ == "g2")
            {
               if(player2.getEquipSkillSlot().getGemFromSkillSlot(_loc3_) != null)
               {
                  itemsTooltip.gemTooltip(player2.getEquipSkillSlot().getGemFromSkillSlot(_loc3_));
               }
            }
            else
            {
               itemsTooltip.slotTooltip(_loc3_,player2.getEquipSlot());
            }
            itemsTooltip.setTooltipPoint();
            itemsTooltip.visible = true;
         }
      }
      
      private static function DragHandler(param1:MouseEvent) : void
      {
         if(isDown == true)
         {
            if(isDrag(pointx,pointy) == true)
            {
               itemsPanel.addChild(dragObj);
               dragObj.x = itemsPanel.mouseX - 20;
               dragObj.y = itemsPanel.mouseY - 20;
               menuTooltip.visible = false;
               dragObj.startDrag();
            }
         }
      }
      
      private static function clickListen(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.target as MovieClip;
         switch(_loc2_.name)
         {
            case "closePanel":
               close();
         }
      }
      
      private static function inEquipSlotRange2P() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(dragObj.name.substr(0,2) == "s1" || dragObj.name.substr(0,2) == "z1")
         {
            return false;
         }
         if(dragObj.name.substr(0,2) == "z2")
         {
            return false;
         }
         if(itemsType2P != 1)
         {
            return false;
         }
         _loc3_ = itemsPanel.x + 35;
         _loc4_ = 0;
         for(; _loc4_ < 2; _loc3_ += 185,_loc4_++)
         {
            _loc2_ = 3 * _loc4_;
            _loc5_ = itemsPanel.y + 302;
            if(itemsPanel.mouseX > _loc3_ && itemsPanel.mouseX < _loc3_ + 52)
            {
               _loc6_ = 0;
               while(_loc6_ < 3)
               {
                  if(itemsPanel.mouseY > _loc5_ && itemsPanel.mouseY < _loc5_ + 52)
                  {
                     _loc1_ = Boolean(allBagHandle.slotHandle2P(dragObj,oldNum,_loc2_));
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return _loc1_;
                     break;
                  }
                  _loc2_++;
                  _loc5_ += 54;
                  _loc6_++;
               }
            }
         }
         return false;
      }
      
      public static function close() : void
      {
         boolFlag = false;
         if(ip == null)
         {
            ip = new ItemsPanel();
         }
         Main.stopXX = false;
         menuTooltip.visible = false;
         removeListenerP1();
         if(player2)
         {
            removeListenerP2();
         }
         ip.visible = false;
      }
      
      private static function inItemsRange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(dragObj.name.substr(0,2) == "s2" || dragObj.name.substr(0,2) == "z2")
         {
            return false;
         }
         _loc2_ = 0;
         _loc3_ = itemsPanel.y + 77;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = itemsPanel.x + 293;
            if(itemsPanel.mouseY > _loc3_ && itemsPanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(itemsPanel.mouseX > _loc5_ && itemsPanel.mouseX < _loc5_ + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           _loc1_ = Boolean(allBagHandle.equipHandle(dragObj,oldNum,_loc2_));
                           break;
                        case 2:
                           _loc1_ = Boolean(allBagHandle.suppliesHandle(dragObj,oldNum,_loc2_));
                           break;
                        case 3:
                           _loc1_ = Boolean(allBagHandle.gemHandle(dragObj,oldNum,_loc2_));
                           break;
                        case 4:
                           trace("b");
                           break;
                        case 5:
                           trace("c");
                     }
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return _loc1_;
                  }
                  _loc2_++;
                  _loc5_ += 48;
                  _loc6_++;
               }
            }
            _loc3_ += 50;
            _loc4_++;
         }
         return false;
      }
      
      public static function changeModel(param1:PlayerData) : void
      {
         if(param1.getEquipSlot().getEquipFromSlot(2).getPosition() == 5)
         {
            param1.skinArr[0] = 0;
         }
         else if(param1.getEquipSlot().getEquipFromSlot(2).getPosition() == 6)
         {
            param1.skinArr[0] = 1;
         }
         else if(param1.getEquipSlot().getEquipFromSlot(2).getPosition() == 7)
         {
            param1.skinArr[0] = 2;
         }
         if(param1.getEquipSlot().getEquipFromSlot(5).getPosition() == 5)
         {
            param1.skinArr[1] = 0;
         }
         else if(param1.getEquipSlot().getEquipFromSlot(5).getPosition() == 6)
         {
            param1.skinArr[1] = 1;
         }
         else if(param1.getEquipSlot().getEquipFromSlot(5).getPosition() == 7)
         {
            param1.skinArr[1] = 2;
         }
         if(param1 == Main.player1)
         {
            Main.player_1.newSkin();
         }
         else if(param1 == Main.player2)
         {
            Main.player_2.newSkin();
         }
      }
      
      private static function bagListen(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.target as MovieClip;
         switch(_loc2_.name)
         {
            case "bg1_1":
               itemsType = 1;
               allFalseP1();
               itemsPanel["bg1_1"].isClick = true;
               BagItemsShow.equipShow();
               break;
            case "bg1_2":
               itemsType = 2;
               allFalseP1();
               itemsPanel["bg1_2"].isClick = true;
               BagItemsShow.suppliesShow();
               break;
            case "bg1_3":
               itemsType = 3;
               allFalseP1();
               itemsPanel["bg1_3"].isClick = true;
               BagItemsShow.gemShow();
               break;
            case "bg1_4":
               itemsType = 4;
               allFalseP1();
               itemsPanel["bg1_4"].isClick = true;
               BagItemsShow.otherobjShow();
               break;
            case "bg1_5":
               itemsType = 5;
               allFalseP1();
               itemsPanel["bg1_5"].isClick = true;
               BagItemsShow.questShow();
               break;
            case "bg2_1":
               itemsType2P = 1;
               allFalseP2();
               itemsPanel["bg2_1"].isClick = true;
               BagItemsShow.equipShow2P();
               break;
            case "bg2_2":
               itemsType2P = 2;
               allFalseP2();
               itemsPanel["bg2_2"].isClick = true;
               BagItemsShow.suppliesShow2P();
               break;
            case "bg2_3":
               itemsType2P = 3;
               allFalseP2();
               itemsPanel["bg2_3"].isClick = true;
               BagItemsShow.gemShow2P();
               break;
            case "bg2_4":
               itemsType2P = 4;
               allFalseP2();
               itemsPanel["bg2_4"].isClick = true;
               BagItemsShow.otherobjShow2P();
               break;
            case "bg2_5":
               itemsType2P = 5;
               allFalseP2();
               itemsPanel["bg2_5"].isClick = true;
               BagItemsShow.questShow2P();
         }
      }
   }
}

