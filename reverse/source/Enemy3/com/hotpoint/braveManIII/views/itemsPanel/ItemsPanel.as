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
      
      private static function getPart(num:Number) : uint
      {
         switch(num)
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
      
      private static function isDrag(xx:Number, yy:Number) : Boolean
      {
         if(isDown == true)
         {
            if(itemsPanel.mouseX > xx + 1 || itemsPanel.mouseX < xx - 1 || itemsPanel.mouseY > yy + 1 || itemsPanel.mouseY < yy - 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function wearHandler2P(e:MouseEvent) : void
      {
         var equip:Equip = null;
         var id:uint = 0;
         var temp:uint = 0;
         if(itemsType2P == 1)
         {
            dragObj = e.target as MovieClip;
            oldNum = uint(dragObj.name.substr(3,2));
            id = uint(getPart(player2.getBag().getEquipFromBag(oldNum).getPosition()));
            temp = uint(dragObj.currentFrame);
            if(player2.getBag().getEquipFromBag(oldNum).getDressLevel() <= player2.getLevel())
            {
               if(player2.getEquipSlot().getEquipFromSlot(id) == null)
               {
                  player2.getEquipSlot().addToSlot(player2.getBag().getEquipFromBag(oldNum),id);
                  player2.getBag().delEquip(oldNum);
               }
               else
               {
                  equip = player2.getEquipSlot().delSlot(id);
                  player2.getEquipSlot().addToSlot(player2.getBag().getEquipFromBag(oldNum),id);
                  player2.getBag().delEquip(oldNum);
                  player2.getBag().addToEquipBag(equip,oldNum);
                  tooltipOpen(e);
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
      
      private static function UpHandler(e:MouseEvent = null) : void
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
         var bool:Boolean = false;
         var slotNum:uint = 0;
         var xflag:int = 0;
         var j:uint = 0;
         var yflag:int = 0;
         var i:uint = 0;
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
            xflag = itemsPanel.x + 35;
            for(j = 0; j < 2; xflag += 185,j++)
            {
               slotNum = 3 * j;
               yflag = itemsPanel.y + 66;
               if(itemsPanel.mouseX > xflag && itemsPanel.mouseX < xflag + 52)
               {
                  i = 0;
                  while(i < 3)
                  {
                     if(itemsPanel.mouseY > yflag && itemsPanel.mouseY < yflag + 52)
                     {
                        bool = Boolean(allBagHandle.slotHandle(dragObj,oldNum,slotNum));
                        dragObj.x = returnx;
                        dragObj.y = returny;
                        return bool;
                        break;
                     }
                     slotNum++;
                     yflag += 54;
                     i++;
                  }
               }
            }
            return false;
         }
         return false;
      }
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         var j:uint = 0;
         var n:uint = 0;
         for(i = 0; i < 24; i++)
         {
            itemsPanel["s1_" + i].mouseChildren = false;
            itemsPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + i].addEventListener(MouseEvent.DOUBLE_CLICK,wearHandler);
            itemsPanel["s1_" + i].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["s1_" + i].doubleClickEnabled = true;
         }
         for(j = 0; j < 6; j++)
         {
            itemsPanel["z1_" + j].mouseChildren = false;
            itemsPanel["z1_" + j].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + j].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + j].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + j].addEventListener(MouseEvent.CLICK,menuOpen);
         }
         itemsPanel.addEventListener(BtnEvent.DO_CLICK,clickListen);
         itemsPanel.addEventListener(BtnEvent.DO_CHANGE,bagListen);
         itemsPanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         itemsPanel.contextMenu = myMenu;
         for(n = 0; n < 2; n++)
         {
            itemsPanel["g1_" + n].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g1_" + n].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g1_" + n].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
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
         itemsPanel["sellMenu"].visible = false;
         itemsType = 1;
      }
      
      public static function addListenerP2() : *
      {
         var i:uint = 0;
         var j:uint = 0;
         var n:uint = 0;
         for(i = 0; i < 24; i++)
         {
            itemsPanel["s2_" + i].mouseChildren = false;
            itemsPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s2_" + i].addEventListener(MouseEvent.DOUBLE_CLICK,wearHandler2P);
            itemsPanel["s2_" + i].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["s2_" + i].doubleClickEnabled = true;
         }
         for(j = 0; j < 6; j++)
         {
            itemsPanel["z2_" + j].mouseChildren = false;
            itemsPanel["z2_" + j].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z2_" + j].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z2_" + j].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z2_" + j].addEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(n = 0; n < 2; n++)
         {
            itemsPanel["g2_" + n].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g2_" + n].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g2_" + n].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
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
      
      private static function DownHandler(e:MouseEvent) : void
      {
         menuTooltip.visible = false;
         itemsTooltip.visible = false;
         isDown = true;
         dragObj = e.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = itemsPanel.mouseX;
         pointy = itemsPanel.mouseY;
         oldNum = uint(dragObj.name.substr(3,2));
      }
      
      private static function tooltipClose(e:MouseEvent) : void
      {
         if(isDown == false)
         {
            itemsTooltip.visible = false;
         }
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         var j:uint = 0;
         var n:uint = 0;
         for(i = 0; i < 24; i++)
         {
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.DOUBLE_CLICK,wearHandler);
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(j = 0; j < 6; j++)
         {
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(n = 0; n < 2; n++)
         {
            itemsPanel["g1_" + n].removeEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g1_" + n].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g1_" + n].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
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
         var i:uint = 0;
         var j:uint = 0;
         var n:uint = 0;
         for(i = 0; i < 24; i++)
         {
            itemsPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s2_" + i].removeEventListener(MouseEvent.DOUBLE_CLICK,wearHandler2P);
            itemsPanel["s2_" + i].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(j = 0; j < 6; j++)
         {
            itemsPanel["z2_" + j].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z2_" + j].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z2_" + j].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z2_" + j].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(n = 0; n < 2; n++)
         {
            itemsPanel["g2_" + n].removeEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g2_" + n].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g2_" + n].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         }
      }
      
      private static function inItemsRange2P() : Boolean
      {
         var bool:Boolean = false;
         var bagNum:uint = 0;
         var yflag:int = 0;
         var j:uint = 0;
         var xflag:int = 0;
         var i:uint = 0;
         if(dragObj.name.substr(0,2) == "s1" || dragObj.name.substr(0,2) == "z1")
         {
            return false;
         }
         bagNum = 0;
         yflag = itemsPanel.y + 312;
         for(j = 0; j < 3; j++)
         {
            bagNum = 8 * j;
            xflag = itemsPanel.x + 293;
            if(itemsPanel.mouseY > yflag && itemsPanel.mouseY < yflag + 45)
            {
               for(i = 0; i < 8; i++)
               {
                  if(itemsPanel.mouseX > xflag && itemsPanel.mouseX < xflag + 45)
                  {
                     switch(itemsType2P)
                     {
                        case 1:
                           bool = Boolean(allBagHandle.equipHandle2P(dragObj,oldNum,bagNum));
                           break;
                        case 2:
                           bool = Boolean(allBagHandle.suppliesHandle2P(dragObj,oldNum,bagNum));
                           break;
                        case 3:
                           bool = Boolean(allBagHandle.gemHandle2P(dragObj,oldNum,bagNum));
                           break;
                        case 4:
                           trace("b");
                           break;
                        case 5:
                           trace("c");
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
      
      private static function loseFocus(e:Event = null) : *
      {
         if(dragObj)
         {
            UpHandler();
         }
      }
      
      public static function open() : void
      {
         boolFlag = true;
         if(ip == null)
         {
            ip = new ItemsPanel();
         }
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
      
      private static function wearHandler(e:MouseEvent) : void
      {
         var equip:Equip = null;
         var id:uint = 0;
         var temp:uint = 0;
         if(itemsType == 1)
         {
            dragObj = e.target as MovieClip;
            oldNum = uint(dragObj.name.substr(3,2));
            id = uint(getPart(player1.getBag().getEquipFromBag(oldNum).getPosition()));
            temp = uint(dragObj.currentFrame);
            if(player1.getBag().getEquipFromBag(oldNum).getDressLevel() <= player1.getLevel())
            {
               if(player1.getEquipSlot().getEquipFromSlot(id) == null)
               {
                  player1.getEquipSlot().addToSlot(player1.getBag().getEquipFromBag(oldNum),id);
                  player1.getBag().delEquip(oldNum);
               }
               else
               {
                  equip = player1.getEquipSlot().delSlot(id);
                  player1.getEquipSlot().addToSlot(player1.getBag().getEquipFromBag(oldNum),id);
                  player1.getBag().delEquip(oldNum);
                  player1.getBag().addToEquipBag(equip,oldNum);
                  tooltipOpen(e);
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
      
      private static function menuClose(e:MouseEvent) : void
      {
         ++closeTimes;
         if(closeTimes > 1)
         {
            menuTooltip.visible = false;
            closeTimes = 0;
         }
      }
      
      private static function menuOpen(e:MouseEvent) : void
      {
         var str:String = null;
         itemsTooltip.visible = false;
         clickObj = e.target as MovieClip;
         str = clickObj.name.substr(0,2);
         oldNum = int(clickObj.name.substr(3,2));
         if(openFlag == true)
         {
            if(str == "s1")
            {
               menuTooltip.setItemsMenu(itemsType,oldNum,1);
               itemsPanel.addChild(menuTooltip);
               menuTooltip.x = clickObj.x + 30;
               menuTooltip.y = clickObj.y + 30;
               menuTooltip.visible = true;
               closeTimes = 0;
            }
            else if(str == "s2")
            {
               menuTooltip.setItemsMenu(itemsType2P,oldNum,2);
               itemsPanel.addChild(menuTooltip);
               menuTooltip.x = clickObj.x + 30;
               menuTooltip.y = clickObj.y + 30;
               menuTooltip.visible = true;
               closeTimes = 0;
            }
            else if(str == "z1")
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
            else if(str == "z2")
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
         if(str == "g1")
         {
            menuTooltip.setSkillSlotMenu(oldNum,1);
            itemsPanel.addChild(menuTooltip);
            menuTooltip.x = clickObj.x + 20;
            menuTooltip.y = clickObj.y + 20;
            menuTooltip.visible = true;
            closeTimes = 0;
         }
         else if(str == "g2")
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
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = null;
         var overNum:uint = 0;
         var str:String = null;
         menuTooltip.visible = false;
         itemsPanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            overobj = e.target as MovieClip;
            overNum = uint(overobj.name.substr(3,2));
            str = overobj.name.substr(0,2);
            itemsTooltip.x = itemsPanel.mouseX;
            itemsTooltip.y = itemsPanel.mouseY;
            if(itemsPanel.mouseX > itemsPanel.x + 280 && itemsPanel.mouseY < itemsPanel.y + 270)
            {
               switch(itemsType)
               {
                  case 1:
                     if(player1.getBag().getEquipFromBag(overNum) != null)
                     {
                        itemsTooltip.equipTooltip(player1.getBag().getEquipFromBag(overNum),1);
                     }
                     break;
                  case 2:
                     if(player1.getBag().getSuppliesFromBag(overNum) != null)
                     {
                        itemsTooltip.suppliesTooltip(player1.getBag().getSuppliesFromBag(overNum),1);
                     }
                     break;
                  case 3:
                     if(player1.getBag().getGemFromBag(overNum) != null)
                     {
                        itemsTooltip.gemTooltip(player1.getBag().getGemFromBag(overNum),1);
                     }
                     break;
                  case 4:
                     trace("d");
                     break;
                  case 5:
                     if(player1.getBag().getQuestFromBag(overNum) != null)
                     {
                        itemsTooltip.questTooltip(player1.getBag().getQuestFromBag(overNum));
                     }
               }
            }
            else if(itemsPanel.mouseX < itemsPanel.x + 280 && itemsPanel.mouseY < itemsPanel.y + 270)
            {
               if(str == "g1")
               {
                  if(player1.getEquipSkillSlot().getGemFromSkillSlot(overNum) != null)
                  {
                     itemsTooltip.gemTooltip(player1.getEquipSkillSlot().getGemFromSkillSlot(overNum));
                  }
               }
               else
               {
                  itemsTooltip.slotTooltip(overNum,player1.getEquipSlot());
               }
            }
            else if(itemsPanel.mouseX > itemsPanel.x + 280 && itemsPanel.mouseY > itemsPanel.y + 270)
            {
               switch(itemsType2P)
               {
                  case 1:
                     if(player2.getBag().getEquipFromBag(overNum) != null)
                     {
                        itemsTooltip.equipTooltip(player2.getBag().getEquipFromBag(overNum),2);
                     }
                     break;
                  case 2:
                     if(player2.getBag().getSuppliesFromBag(overNum) != null)
                     {
                        itemsTooltip.suppliesTooltip(player2.getBag().getSuppliesFromBag(overNum),2);
                     }
                     break;
                  case 3:
                     if(player2.getBag().getGemFromBag(overNum) != null)
                     {
                        itemsTooltip.gemTooltip(player2.getBag().getGemFromBag(overNum),2);
                     }
                     break;
                  case 4:
                     trace("d");
                     break;
                  case 5:
                     if(player2.getBag().getQuestFromBag(overNum) != null)
                     {
                        itemsTooltip.questTooltip(player2.getBag().getQuestFromBag(overNum));
                     }
               }
            }
            else if(str == "g2")
            {
               if(player2.getEquipSkillSlot().getGemFromSkillSlot(overNum) != null)
               {
                  itemsTooltip.gemTooltip(player2.getEquipSkillSlot().getGemFromSkillSlot(overNum));
               }
            }
            else
            {
               itemsTooltip.slotTooltip(overNum,player2.getEquipSlot());
            }
            itemsTooltip.setTooltipPoint();
            itemsTooltip.visible = true;
         }
      }
      
      private static function DragHandler(e:MouseEvent) : void
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
      
      private static function clickListen(e:BtnEvent) : void
      {
         var btn:MovieClip = null;
         btn = e.target as MovieClip;
         switch(btn.name)
         {
            case "closePanel":
               close();
         }
      }
      
      private static function inEquipSlotRange2P() : Boolean
      {
         var bool:Boolean = false;
         var slotNum:uint = 0;
         var xflag:int = 0;
         var j:uint = 0;
         var yflag:int = 0;
         var i:uint = 0;
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
         xflag = itemsPanel.x + 35;
         for(j = 0; j < 2; xflag += 185,j++)
         {
            slotNum = 3 * j;
            yflag = itemsPanel.y + 302;
            if(itemsPanel.mouseX > xflag && itemsPanel.mouseX < xflag + 52)
            {
               i = 0;
               while(i < 3)
               {
                  if(itemsPanel.mouseY > yflag && itemsPanel.mouseY < yflag + 52)
                  {
                     bool = Boolean(allBagHandle.slotHandle2P(dragObj,oldNum,slotNum));
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return bool;
                     break;
                  }
                  slotNum++;
                  yflag += 54;
                  i++;
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
         var bool:Boolean = false;
         var bagNum:uint = 0;
         var yflag:int = 0;
         var j:uint = 0;
         var xflag:int = 0;
         var i:uint = 0;
         if(dragObj.name.substr(0,2) == "s2" || dragObj.name.substr(0,2) == "z2")
         {
            return false;
         }
         bagNum = 0;
         yflag = itemsPanel.y + 77;
         for(j = 0; j < 3; j++)
         {
            bagNum = 8 * j;
            xflag = itemsPanel.x + 293;
            if(itemsPanel.mouseY > yflag && itemsPanel.mouseY < yflag + 45)
            {
               for(i = 0; i < 8; i++)
               {
                  if(itemsPanel.mouseX > xflag && itemsPanel.mouseX < xflag + 45)
                  {
                     switch(itemsType)
                     {
                        case 1:
                           bool = Boolean(allBagHandle.equipHandle(dragObj,oldNum,bagNum));
                           break;
                        case 2:
                           bool = Boolean(allBagHandle.suppliesHandle(dragObj,oldNum,bagNum));
                           break;
                        case 3:
                           bool = Boolean(allBagHandle.gemHandle(dragObj,oldNum,bagNum));
                           break;
                        case 4:
                           trace("b");
                           break;
                        case 5:
                           trace("c");
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
      
      public static function changeModel(pp:PlayerData) : void
      {
         if(pp.getEquipSlot().getEquipFromSlot(2).getPosition() == 5)
         {
            pp.skinArr[0] = 0;
         }
         else if(pp.getEquipSlot().getEquipFromSlot(2).getPosition() == 6)
         {
            pp.skinArr[0] = 1;
         }
         else if(pp.getEquipSlot().getEquipFromSlot(2).getPosition() == 7)
         {
            pp.skinArr[0] = 2;
         }
         if(pp.getEquipSlot().getEquipFromSlot(5).getPosition() == 5)
         {
            pp.skinArr[1] = 0;
         }
         else if(pp.getEquipSlot().getEquipFromSlot(5).getPosition() == 6)
         {
            pp.skinArr[1] = 1;
         }
         else if(pp.getEquipSlot().getEquipFromSlot(5).getPosition() == 7)
         {
            pp.skinArr[1] = 2;
         }
         if(pp == Main.player1)
         {
            Main.player_1.newSkin();
         }
         else if(pp == Main.player2)
         {
            Main.player_2.newSkin();
         }
      }
      
      private static function bagListen(e:BtnEvent) : void
      {
         var btn:MovieClip = null;
         btn = e.target as MovieClip;
         switch(btn.name)
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

