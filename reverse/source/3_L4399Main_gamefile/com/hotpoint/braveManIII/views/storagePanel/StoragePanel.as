package com.hotpoint.braveManIII.views.storagePanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   import src.*;
   
   public class StoragePanel extends MovieClip
   {
      
      public static var storage:Storage;
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var dragObj:MovieClip;
      
      private static var pointx:Number;
      
      private static var pointy:Number;
      
      private static var allStorageHandle:AllStorageHandle;
      
      private static var oldNum:Number;
      
      public static var sp:StoragePanel;
      
      public static var storagePanel:MovieClip = new StorageShow();
      
      public static var returnx:Number = 0;
      
      public static var returny:Number = 0;
      
      public static var isDown:Boolean = false;
      
      private static var itemsType:Number = 1;
      
      private static var myMenu:ContextMenu = new ContextMenu();
      
      public function StoragePanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         allStorageHandle = new AllStorageHandle();
         this.addChild(storagePanel);
         if(Main.player2 == null)
         {
            storagePanel["lock2P"].visible = true;
         }
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(sp == null)
         {
            if(!storage)
            {
               storage = Storage.createStorage();
            }
            sp = new StoragePanel();
         }
         sp.x = 130;
         sp.y = 30;
         addListenerP1();
         if(Main.player2)
         {
            addListenerP2();
         }
         Main._stage.addChild(sp);
         sp.visible = true;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(sp == null)
         {
            if(!storage)
            {
               storage = Storage.createStorage();
            }
            sp = new StoragePanel();
         }
         removeListenerP1();
         if(Main.player2)
         {
            removeListenerP2();
         }
         sp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            storagePanel["s1_" + _loc1_].mouseChildren = false;
            storagePanel["s1_" + _loc1_]["t_txt"].visible = false;
            storagePanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s1_" + _loc1_].addEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
            storagePanel["s1_" + _loc1_].doubleClickEnabled = true;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 35)
         {
            storagePanel["kc_" + _loc1_].mouseChildren = false;
            storagePanel["kc_" + _loc1_]["t_txt"].visible = false;
            storagePanel["kc_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["kc_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["kc_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            _loc1_++;
         }
         storagePanel.addEventListener(BtnEvent.DO_CLICK,clickListen);
         storagePanel.addEventListener(BtnEvent.DO_CHANGE,ckListen);
         storagePanel.addEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         storagePanel.addEventListener(MouseEvent.MOUSE_UP,UpHandler);
         storagePanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         storagePanel.contextMenu = myMenu;
         StorageItemsShow.allHide();
         StorageItemsShow.equipShow();
         StorageItemsShow.equipStorageShow();
         StorageItemsShow.informationShow();
         allFalse();
         storagePanel["bg1_1"].isClick = true;
         storagePanel["mck_1"].isClick = true;
         itemsType = 1;
      }
      
      public static function addListenerP2() : *
      {
         storagePanel["lock2P"].visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            storagePanel["s2_" + _loc1_].mouseChildren = false;
            storagePanel["s2_" + _loc1_]["t_txt"].visible = false;
            storagePanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s2_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s2_" + _loc1_].addEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
            storagePanel["s2_" + _loc1_].doubleClickEnabled = true;
            _loc1_++;
         }
         storagePanel["bg2_1"].isClick = true;
         StorageItemsShow.equipShow2P();
         StorageItemsShow.informationShow2P();
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            storagePanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s1_" + _loc1_].removeEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 35)
         {
            storagePanel["kc_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["kc_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["kc_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            _loc1_++;
         }
         storagePanel.removeEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.removeEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         storagePanel.contextMenu = myMenu;
         storagePanel.removeEventListener(BtnEvent.DO_CLICK,clickListen);
         storagePanel.removeEventListener(BtnEvent.DO_CHANGE,ckListen);
         storagePanel.removeEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         storagePanel.removeEventListener(MouseEvent.MOUSE_UP,UpHandler);
      }
      
      public static function removeListenerP2() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            storagePanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s2_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s2_" + _loc1_].removeEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
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
      
      private static function clickListen(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         switch(_loc2_.name)
         {
            case "closePanel":
               close();
         }
      }
      
      private static function ckListen(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:uint = uint(_loc2_.name.substr(4,1));
         switch(_loc3_)
         {
            case 1:
               allFalse();
               storagePanel["bg1_1"].isClick = true;
               storagePanel["mck_1"].isClick = true;
               StorageItemsShow.equipShow();
               StorageItemsShow.equipStorageShow();
               if(Main.P1P2)
               {
                  storagePanel["bg2_1"].isClick = true;
                  StorageItemsShow.equipShow2P();
               }
               itemsType = 1;
               break;
            case 2:
               allFalse();
               storagePanel["bg1_2"].isClick = true;
               storagePanel["mck_2"].isClick = true;
               StorageItemsShow.suppliesShow();
               StorageItemsShow.suppliesStorageShow();
               if(Main.P1P2)
               {
                  storagePanel["bg2_2"].isClick = true;
                  StorageItemsShow.suppliesShow2P();
               }
               itemsType = 2;
               break;
            case 3:
               allFalse();
               storagePanel["bg1_3"].isClick = true;
               storagePanel["mck_3"].isClick = true;
               StorageItemsShow.gemShow();
               StorageItemsShow.gemStorageShow();
               if(Main.P1P2)
               {
                  storagePanel["bg2_3"].isClick = true;
                  StorageItemsShow.gemShow2P();
               }
               itemsType = 3;
               break;
            case 4:
               allFalse();
               storagePanel["bg1_4"].isClick = true;
               storagePanel["mck_4"].isClick = true;
               StorageItemsShow.otherobjShow();
               StorageItemsShow.otherobjStorageShow();
               if(Main.P1P2)
               {
                  storagePanel["bg2_4"].isClick = true;
                  StorageItemsShow.otherobjShow2P();
               }
               itemsType = 4;
         }
      }
      
      private static function allFalse() : void
      {
         storagePanel["bg1_1"].isClick = false;
         storagePanel["bg1_2"].isClick = false;
         storagePanel["bg1_3"].isClick = false;
         storagePanel["bg1_4"].isClick = false;
         storagePanel["bg2_1"].isClick = false;
         storagePanel["bg2_2"].isClick = false;
         storagePanel["bg2_3"].isClick = false;
         storagePanel["bg2_4"].isClick = false;
         storagePanel["mck_1"].isClick = false;
         storagePanel["mck_2"].isClick = false;
         storagePanel["mck_3"].isClick = false;
         storagePanel["mck_4"].isClick = false;
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         storagePanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            _loc2_ = param1.target as MovieClip;
            _loc3_ = uint(_loc2_.name.substr(3,2));
            itemsTooltip.x = storagePanel.mouseX;
            itemsTooltip.y = storagePanel.mouseY;
            if(storagePanel.mouseX > storagePanel.x + 290 && storagePanel.mouseY < storagePanel.y + 230)
            {
               switch(itemsType)
               {
                  case 1:
                     itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(_loc3_));
                     break;
                  case 2:
                     itemsTooltip.suppliesTooltip(Main.player1.getBag().getSuppliesFromBag(_loc3_));
                     break;
                  case 3:
                     itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(_loc3_));
                     break;
                  case 4:
                     itemsTooltip.otherTooltip(Main.player1.getBag().getOtherobjFromBag(_loc3_));
               }
            }
            else if(storagePanel.mouseX > storagePanel.x + 290 && storagePanel.mouseY > storagePanel.y + 230)
            {
               switch(itemsType)
               {
                  case 1:
                     itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(_loc3_),2);
                     break;
                  case 2:
                     itemsTooltip.suppliesTooltip(Main.player2.getBag().getSuppliesFromBag(_loc3_),2);
                     break;
                  case 3:
                     itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(_loc3_),2);
                     break;
                  case 4:
                     itemsTooltip.otherTooltip(Main.player2.getBag().getOtherobjFromBag(_loc3_));
               }
            }
            else
            {
               switch(itemsType)
               {
                  case 1:
                     itemsTooltip.equipTooltip(storage.getEquipFromStorage(_loc3_),3);
                     break;
                  case 2:
                     itemsTooltip.suppliesTooltip(storage.getSuppliesFromStorage(_loc3_),3);
                     break;
                  case 3:
                     itemsTooltip.gemTooltip(storage.getGemFromStorage(_loc3_),3);
                     break;
                  case 4:
                     itemsTooltip.otherTooltip(storage.getOtherobjFromStorage(_loc3_));
               }
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
      
      private static function isDrag(param1:Number, param2:Number) : Boolean
      {
         if(isDown == true)
         {
            if(storagePanel.mouseX > param1 + 1 || storagePanel.mouseX < param1 - 1 || storagePanel.mouseY > param2 + 1 || storagePanel.mouseY < param2 - 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function DragHandler(param1:MouseEvent) : void
      {
         if(isDown == true)
         {
            if(isDrag(pointx,pointy) == true)
            {
               storagePanel.addChild(dragObj);
               dragObj.x = storagePanel.mouseX - 20;
               dragObj.y = storagePanel.mouseY - 20;
               dragObj.startDrag();
            }
         }
      }
      
      private static function DownHandler(param1:MouseEvent) : void
      {
         if(itemsTooltip.visible = true)
         {
            itemsTooltip.visible = false;
            isDown = true;
         }
         dragObj = param1.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = storagePanel.mouseX;
         pointy = storagePanel.mouseY;
         oldNum = uint(dragObj.name.substr(3,2));
      }
      
      private static function UpHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:Boolean = false;
         if(dragObj)
         {
            dragObj.stopDrag();
            if(Main.P1P2)
            {
               _loc2_ = Boolean(inItemsRange2P());
            }
            else
            {
               _loc2_ = false;
            }
            if(inItemsRange() == false && _loc2_ == false && inStorageRange() == false)
            {
               dragObj.x = returnx;
               dragObj.y = returny;
            }
            isDown = false;
         }
         dragObj = null;
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
         var _loc3_:int = storagePanel.y + 62;
         var _loc4_:uint = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = storagePanel.x + 307;
            if(storagePanel.mouseY > _loc3_ && storagePanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(storagePanel.mouseX > _loc5_ && storagePanel.mouseX < _loc5_ + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           allStorageHandle.equipHandle(dragObj,oldNum,_loc2_);
                           break;
                        case 2:
                           allStorageHandle.suppliesHandle(dragObj,oldNum,_loc2_);
                           break;
                        case 3:
                           allStorageHandle.gemHandle(dragObj,oldNum,_loc2_);
                           break;
                        case 4:
                           allStorageHandle.otherHandle(dragObj,oldNum,_loc2_);
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
         var _loc3_:int = storagePanel.y + 275;
         var _loc4_:uint = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = 8 * _loc4_;
            _loc5_ = storagePanel.x + 307;
            if(storagePanel.mouseY > _loc3_ && storagePanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if(storagePanel.mouseX > _loc5_ && storagePanel.mouseX < _loc5_ + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           allStorageHandle.equipHandle2P(dragObj,oldNum,_loc2_);
                           break;
                        case 2:
                           allStorageHandle.suppliesHandle2P(dragObj,oldNum,_loc2_);
                           break;
                        case 3:
                           allStorageHandle.gemHandle2P(dragObj,oldNum,_loc2_);
                           break;
                        case 4:
                           allStorageHandle.otherHandle2P(dragObj,oldNum,_loc2_);
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
      
      private static function inStorageRange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = storagePanel.y + 61;
         var _loc4_:uint = 0;
         while(_loc4_ < 7)
         {
            _loc2_ = 5 * _loc4_;
            _loc5_ = storagePanel.x + 37;
            if(storagePanel.mouseY > _loc3_ && storagePanel.mouseY < _loc3_ + 45)
            {
               _loc6_ = 0;
               while(_loc6_ < 5)
               {
                  if(storagePanel.mouseX > _loc5_ && storagePanel.mouseX < _loc5_ + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           allStorageHandle.equipStorageHandle(dragObj,oldNum,_loc2_);
                           break;
                        case 2:
                           allStorageHandle.suppliesStorageHandle(dragObj,oldNum,_loc2_);
                           break;
                        case 3:
                           allStorageHandle.gemStorageHandle(dragObj,oldNum,_loc2_);
                           break;
                        case 4:
                           allStorageHandle.otherStorageHandle(dragObj,oldNum,_loc2_);
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
      
      private static function DoubleClick(param1:MouseEvent) : void
      {
         dragObj = param1.target as MovieClip;
         if(dragObj.name.substr(0,2) == "s1")
         {
            allStorageHandle.putInStorageHandle(itemsType,oldNum);
         }
         else
         {
            allStorageHandle.putInStorageHandle2P(itemsType,oldNum);
         }
         switch(itemsType)
         {
            case 1:
               StorageItemsShow.equipShow();
               if(Main.player2)
               {
                  StorageItemsShow.equipShow2P();
               }
               StorageItemsShow.equipStorageShow();
               break;
            case 2:
               StorageItemsShow.suppliesShow();
               if(Main.player2)
               {
                  StorageItemsShow.suppliesShow2P();
               }
               StorageItemsShow.suppliesStorageShow();
               break;
            case 3:
               StorageItemsShow.gemShow();
               if(Main.player2)
               {
                  StorageItemsShow.gemShow2P();
               }
               StorageItemsShow.gemStorageShow();
               break;
            case 4:
               StorageItemsShow.otherobjShow();
               if(Main.player2)
               {
                  StorageItemsShow.otherobjShow2P();
               }
               StorageItemsShow.otherobjStorageShow();
         }
         dragObj = null;
      }
   }
}

