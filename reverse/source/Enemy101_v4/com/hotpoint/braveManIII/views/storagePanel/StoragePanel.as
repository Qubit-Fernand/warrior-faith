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
         for(var i:uint = 0; i < 24; i++)
         {
            storagePanel["s1_" + i].mouseChildren = false;
            storagePanel["s1_" + i]["t_txt"].visible = false;
            storagePanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s1_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s1_" + i].addEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
            storagePanel["s1_" + i].doubleClickEnabled = true;
         }
         for(i = 0; i < 35; i++)
         {
            storagePanel["kc_" + i].mouseChildren = false;
            storagePanel["kc_" + i]["t_txt"].visible = false;
            storagePanel["kc_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["kc_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["kc_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
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
         for(var i:uint = 0; i < 24; i++)
         {
            storagePanel["s2_" + i].mouseChildren = false;
            storagePanel["s2_" + i]["t_txt"].visible = false;
            storagePanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s2_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s2_" + i].addEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
            storagePanel["s2_" + i].doubleClickEnabled = true;
         }
         storagePanel["bg2_1"].isClick = true;
         StorageItemsShow.equipShow2P();
         StorageItemsShow.informationShow2P();
      }
      
      public static function removeListenerP1() : *
      {
         for(var i:uint = 0; i < 24; i++)
         {
            storagePanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s1_" + i].removeEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
         }
         for(i = 0; i < 35; i++)
         {
            storagePanel["kc_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["kc_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["kc_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
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
         for(var i:uint = 0; i < 24; i++)
         {
            storagePanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            storagePanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            storagePanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            storagePanel["s2_" + i].removeEventListener(MouseEvent.DOUBLE_CLICK,DoubleClick);
         }
      }
      
      private static function loseFocus(e:Event = null) : *
      {
         if(dragObj)
         {
            UpHandler();
         }
      }
      
      private static function clickListen(e:BtnEvent) : void
      {
         var btn:MovieClip = e.target as MovieClip;
         switch(btn.name)
         {
            case "closePanel":
               close();
         }
      }
      
      private static function ckListen(e:BtnEvent) : void
      {
         var btn:MovieClip = e.target as MovieClip;
         var btnNum:uint = uint(btn.name.substr(4,1));
         switch(btnNum)
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
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = null;
         var overNum:uint = 0;
         storagePanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            overobj = e.target as MovieClip;
            overNum = uint(overobj.name.substr(3,2));
            itemsTooltip.x = storagePanel.mouseX;
            itemsTooltip.y = storagePanel.mouseY;
            if(storagePanel.mouseX > storagePanel.x + 290 && storagePanel.mouseY < storagePanel.y + 230)
            {
               switch(itemsType)
               {
                  case 1:
                     itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(overNum));
                     break;
                  case 2:
                     itemsTooltip.suppliesTooltip(Main.player1.getBag().getSuppliesFromBag(overNum));
                     break;
                  case 3:
                     itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(overNum));
                     break;
                  case 4:
                     itemsTooltip.otherTooltip(Main.player1.getBag().getOtherobjFromBag(overNum));
               }
            }
            else if(storagePanel.mouseX > storagePanel.x + 290 && storagePanel.mouseY > storagePanel.y + 230)
            {
               switch(itemsType)
               {
                  case 1:
                     itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(overNum),2);
                     break;
                  case 2:
                     itemsTooltip.suppliesTooltip(Main.player2.getBag().getSuppliesFromBag(overNum),2);
                     break;
                  case 3:
                     itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(overNum),2);
                     break;
                  case 4:
                     itemsTooltip.otherTooltip(Main.player2.getBag().getOtherobjFromBag(overNum));
               }
            }
            else
            {
               switch(itemsType)
               {
                  case 1:
                     itemsTooltip.equipTooltip(storage.getEquipFromStorage(overNum),3);
                     break;
                  case 2:
                     itemsTooltip.suppliesTooltip(storage.getSuppliesFromStorage(overNum),3);
                     break;
                  case 3:
                     itemsTooltip.gemTooltip(storage.getGemFromStorage(overNum),3);
                     break;
                  case 4:
                     itemsTooltip.otherTooltip(storage.getOtherobjFromStorage(overNum));
               }
            }
            itemsTooltip.visible = true;
         }
      }
      
      private static function tooltipClose(e:MouseEvent) : void
      {
         if(isDown == false)
         {
            itemsTooltip.visible = false;
         }
      }
      
      private static function isDrag(xx:Number, yy:Number) : Boolean
      {
         if(isDown == true)
         {
            if(storagePanel.mouseX > xx + 1 || storagePanel.mouseX < xx - 1 || storagePanel.mouseY > yy + 1 || storagePanel.mouseY < yy - 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function DragHandler(e:MouseEvent) : void
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
      
      private static function DownHandler(e:MouseEvent) : void
      {
         if(itemsTooltip.visible = true)
         {
            itemsTooltip.visible = false;
            isDown = true;
         }
         dragObj = e.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = storagePanel.mouseX;
         pointy = storagePanel.mouseY;
         oldNum = uint(dragObj.name.substr(3,2));
      }
      
      private static function UpHandler(e:MouseEvent = null) : void
      {
         var bool2P:Boolean = false;
         if(dragObj)
         {
            dragObj.stopDrag();
            if(Main.P1P2)
            {
               bool2P = Boolean(inItemsRange2P());
            }
            else
            {
               bool2P = false;
            }
            if(inItemsRange() == false && bool2P == false && inStorageRange() == false)
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
         var bool:Boolean = false;
         var xflag:int = 0;
         var i:uint = 0;
         if(dragObj.name.substr(0,2) == "s2")
         {
            return false;
         }
         var bagNum:uint = 0;
         var yflag:int = storagePanel.y + 62;
         for(var j:uint = 0; j < 3; j++)
         {
            bagNum = 8 * j;
            xflag = storagePanel.x + 307;
            if(storagePanel.mouseY > yflag && storagePanel.mouseY < yflag + 45)
            {
               for(i = 0; i < 8; i++)
               {
                  if(storagePanel.mouseX > xflag && storagePanel.mouseX < xflag + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           allStorageHandle.equipHandle(dragObj,oldNum,bagNum);
                           break;
                        case 2:
                           allStorageHandle.suppliesHandle(dragObj,oldNum,bagNum);
                           break;
                        case 3:
                           allStorageHandle.gemHandle(dragObj,oldNum,bagNum);
                           break;
                        case 4:
                           allStorageHandle.otherHandle(dragObj,oldNum,bagNum);
                     }
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return bool;
                  }
                  bagNum++;
                  xflag += 48;
               }
            }
            yflag += 50;
         }
         return false;
      }
      
      private static function inItemsRange2P() : Boolean
      {
         var bool:Boolean = false;
         var xflag:int = 0;
         var i:uint = 0;
         if(dragObj.name.substr(0,2) == "s1")
         {
            return false;
         }
         var bagNum:uint = 0;
         var yflag:int = storagePanel.y + 275;
         for(var j:uint = 0; j < 3; j++)
         {
            bagNum = 8 * j;
            xflag = storagePanel.x + 307;
            if(storagePanel.mouseY > yflag && storagePanel.mouseY < yflag + 45)
            {
               for(i = 0; i < 8; i++)
               {
                  if(storagePanel.mouseX > xflag && storagePanel.mouseX < xflag + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           allStorageHandle.equipHandle2P(dragObj,oldNum,bagNum);
                           break;
                        case 2:
                           allStorageHandle.suppliesHandle2P(dragObj,oldNum,bagNum);
                           break;
                        case 3:
                           allStorageHandle.gemHandle2P(dragObj,oldNum,bagNum);
                           break;
                        case 4:
                           allStorageHandle.otherHandle2P(dragObj,oldNum,bagNum);
                     }
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return bool;
                  }
                  bagNum++;
                  xflag += 48;
               }
            }
            yflag += 50;
         }
         return false;
      }
      
      private static function inStorageRange() : Boolean
      {
         var bool:Boolean = false;
         var xflag:int = 0;
         var i:uint = 0;
         var stotageNum:uint = 0;
         var yflag:int = storagePanel.y + 61;
         for(var j:uint = 0; j < 7; j++)
         {
            stotageNum = 5 * j;
            xflag = storagePanel.x + 37;
            if(storagePanel.mouseY > yflag && storagePanel.mouseY < yflag + 45)
            {
               for(i = 0; i < 5; i++)
               {
                  if(storagePanel.mouseX > xflag && storagePanel.mouseX < xflag + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           allStorageHandle.equipStorageHandle(dragObj,oldNum,stotageNum);
                           break;
                        case 2:
                           allStorageHandle.suppliesStorageHandle(dragObj,oldNum,stotageNum);
                           break;
                        case 3:
                           allStorageHandle.gemStorageHandle(dragObj,oldNum,stotageNum);
                           break;
                        case 4:
                           allStorageHandle.otherStorageHandle(dragObj,oldNum,stotageNum);
                     }
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return bool;
                  }
                  stotageNum++;
                  xflag += 48;
               }
            }
            yflag += 50;
         }
         return false;
      }
      
      private static function DoubleClick(e:MouseEvent) : void
      {
         dragObj = e.target as MovieClip;
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

