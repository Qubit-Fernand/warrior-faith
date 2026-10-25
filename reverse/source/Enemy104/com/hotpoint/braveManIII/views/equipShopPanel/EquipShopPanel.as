package com.hotpoint.braveManIII.views.equipShopPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   import flash.utils.*;
   import src.*;
   
   public class EquipShopPanel extends MovieClip
   {
      
      public static var esp:EquipShopPanel;
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var dragObj:MovieClip;
      
      private static var allEquipShopHandle:AllEquipShopHandle;
      
      public static var clickObj:MovieClip;
      
      private static var oldNum:Number;
      
      private static var pointx:Number;
      
      private static var pointy:Number;
      
      private static var chosen:Equip;
      
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
      
      private static function isDrag(xx:Number, yy:Number) : Boolean
      {
         if(isDown == true)
         {
            if(equipShowPanel.mouseX > xx + 1 || equipShowPanel.mouseX < xx - 1 || equipShowPanel.mouseY > yy + 1 || equipShowPanel.mouseY < yy - 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function sellSure() : void
      {
         var num:int = 0;
         var str:String = null;
         num = int(clickObj.name.substr(3,2));
         str = clickObj.name.substr(0,2);
         if(str == "s1")
         {
            Main.player1.addGold(Main.player1.getBag().getEquipFromBag(num).getPrice());
            Main.player1.getBag().delEquip(num);
         }
         else
         {
            Main.player2.addGold(Main.player2.getBag().getEquipFromBag(num).getPrice());
            Main.player2.getBag().delEquip(num);
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
      
      private static function buyTooltipOpen(e:MouseEvent) : void
      {
         equipShowPanel.addChild(itemsTooltip);
         itemsTooltip.x = equipShowPanel.mouseX;
         itemsTooltip.y = equipShowPanel.mouseY;
         itemsTooltip.equipTooltip(chosen);
         itemsTooltip.visible = true;
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
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         var j:uint = 0;
         for(i = 0; i < 24; i++)
         {
            equipShowPanel["s1_" + i].mouseChildren = false;
            equipShowPanel["s1_" + i]["t_txt"].visible = false;
            equipShowPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s1_" + i].addEventListener(MouseEvent.CLICK,menuOpen);
         }
         equipShowPanel.addEventListener(BtnEvent.DO_CLICK,shopListen);
         equipShowPanel.addEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         equipShowPanel.addEventListener(MouseEvent.MOUSE_UP,UpHandler);
         equipShowPanel.addEventListener(MouseEvent.CLICK,menuClose);
         for(j = 0; j < 6; j++)
         {
            equipShowPanel["se_" + j].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["se_" + j].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
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
         var i:uint = 0;
         equipShowPanel["lock2P"].visible = false;
         equipShowPanel["buyMenu"]["buy2P"].visible = true;
         for(i = 0; i < 24; i++)
         {
            equipShowPanel["s2_" + i].mouseChildren = false;
            equipShowPanel["s2_" + i]["t_txt"].visible = false;
            equipShowPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s2_" + i].addEventListener(MouseEvent.CLICK,menuOpen);
         }
         ShopItemsShow.equipShow2P();
         ShopItemsShow.informationShow2P();
      }
      
      private static function setUp() : void
      {
         var amount:int = 0;
         amount = int(equipShowPanel["buyMenu"]["amount"].text);
         if(amount == 24)
         {
            amount = 1;
         }
         else
         {
            amount++;
         }
         equipShowPanel["buyMenu"]["amount"].text = amount;
      }
      
      private static function setDown() : void
      {
         var amount:* = 0;
         amount = int(equipShowPanel["buyMenu"]["amount"].text);
         if(amount == 1)
         {
            amount = 24;
         }
         else
         {
            amount--;
         }
         equipShowPanel["buyMenu"]["amount"].text = amount;
      }
      
      private static function DownHandler(e:MouseEvent) : void
      {
         equipShowPanel["mySell"].visible = false;
         if(itemsTooltip.visible = true)
         {
            itemsTooltip.visible = false;
            isDown = true;
         }
         dragObj = e.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = equipShowPanel.mouseX;
         pointy = equipShowPanel.mouseY;
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
         for(i = 0; i < 24; i++)
         {
            equipShowPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s1_" + i].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
         equipShowPanel.removeEventListener(BtnEvent.DO_CLICK,shopListen);
         equipShowPanel.removeEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         equipShowPanel.removeEventListener(MouseEvent.MOUSE_UP,UpHandler);
         equipShowPanel.removeEventListener(MouseEvent.CLICK,menuClose);
         equipShowPanel.removeEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.removeEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         for(j = 0; j < 6; j++)
         {
            equipShowPanel["se_" + j].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["se_" + j].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         }
         equipShowPanel["buyMenu"]["buyPic"].removeEventListener(MouseEvent.MOUSE_OVER,buyTooltipOpen);
         equipShowPanel["buyMenu"]["buyPic"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         equipShowPanel["mySell"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sellEquip);
      }
      
      public static function removeListenerP2() : *
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            equipShowPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            equipShowPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            equipShowPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            equipShowPanel["s2_" + i].removeEventListener(MouseEvent.CLICK,menuOpen);
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
         if(dragObj.name.substr(0,2) == "s1")
         {
            return false;
         }
         bagNum = 0;
         yflag = equipShowPanel.y + 275;
         for(j = 0; j < 3; yflag += 50,j++)
         {
            bagNum = 8 * j;
            xflag = equipShowPanel.x + 253;
            if(equipShowPanel.mouseY > yflag && equipShowPanel.mouseY < yflag + 45)
            {
               i = 0;
               while(i < 8)
               {
                  if(equipShowPanel.mouseX > xflag && equipShowPanel.mouseX < xflag + 45)
                  {
                     bool = Boolean(allEquipShopHandle.equipHandle2P(dragObj,oldNum,bagNum));
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return bool;
                     break;
                  }
                  bagNum++;
                  xflag += 48;
                  i++;
               }
            }
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
      
      private static function buyEquipByPlayerData(player:PlayerData) : void
      {
         var amount:int = 0;
         var i:* = 0;
         amount = int(equipShowPanel["buyMenu"]["amount"].text);
         if(player.getGold() < chosen.getPrice() * amount * 9)
         {
            ShortTip.open(16);
         }
         else
         {
            if(player.getBag().backequipBagNum() >= amount)
            {
               for(i = amount; i > 0; i--)
               {
                  player.getBag().addEquipBag(chosen.getClone());
                  player.payGold(chosen.getPrice() * 9);
               }
            }
            else
            {
               ShortTip.open(3);
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
      
      private static function changeRight() : void
      {
         var numLeft:Number = NaN;
         var numRight:Number = NaN;
         numLeft = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
         numRight = Number(EquipShopPanel.equipShowPanel["pageNumR"].text);
         if(numLeft < numRight)
         {
            numLeft++;
            EquipShopPanel.equipShowPanel["pageNumL"].text = numLeft;
         }
         ShopItemsShow.shopEquipShow();
      }
      
      private static function changeLeft() : void
      {
         var numLeft:Number = NaN;
         numLeft = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
         if(numLeft > 1)
         {
            numLeft--;
            EquipShopPanel.equipShowPanel["pageNumL"].text = numLeft;
         }
         ShopItemsShow.shopEquipShow();
      }
      
      private static function menuClose(e:MouseEvent) : void
      {
         ++closeTimes;
         if(closeTimes >= 1)
         {
            equipShowPanel["mySell"].visible = false;
            closeTimes = 0;
         }
      }
      
      private static function menuOpen(e:MouseEvent) : void
      {
         var num:int = 0;
         itemsTooltip.visible = false;
         clickObj = e.target as MovieClip;
         num = int(clickObj.name.substr(3,2));
         setTimeout(goNext,150);
      }
      
      private static function inItemsRange() : Boolean
      {
         var bool:Boolean = false;
         var bagNum:uint = 0;
         var yflag:int = 0;
         var j:uint = 0;
         var xflag:int = 0;
         var i:uint = 0;
         if(dragObj.name.substr(0,2) == "s2")
         {
            return false;
         }
         bagNum = 0;
         yflag = equipShowPanel.y + 62;
         for(j = 0; j < 3; yflag += 50,j++)
         {
            bagNum = 8 * j;
            xflag = equipShowPanel.x + 253;
            if(equipShowPanel.mouseY > yflag && equipShowPanel.mouseY < yflag + 45)
            {
               i = 0;
               while(i < 8)
               {
                  if(equipShowPanel.mouseX > xflag && equipShowPanel.mouseX < xflag + 45)
                  {
                     bool = Boolean(allEquipShopHandle.equipHandle(dragObj,oldNum,bagNum));
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return bool;
                     break;
                  }
                  bagNum++;
                  xflag += 48;
                  i++;
               }
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
               equipShowPanel["mySell"].visible = false;
               equipShowPanel.addChild(dragObj);
               dragObj.x = equipShowPanel.mouseX - 30;
               dragObj.y = equipShowPanel.mouseY - 30;
               dragObj.startDrag();
            }
         }
      }
      
      private static function buyEquipMenu(num:Number) : void
      {
         equipShowPanel["buyMenu"].visible = true;
         equipShowPanel.addChild(equipShowPanel["buyMenu"]);
         equipShowPanel["buyMenu"]["buyPic"].gotoAndStop(shopEquipList[num].getFrame());
         equipShowPanel["buyMenu"]["buyPic"]["t_txt"].visible = false;
         chosen = shopEquipList[num];
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = null;
         var overNum:uint = 0;
         var numLeft:Number = NaN;
         equipShowPanel["mySell"].visible = false;
         equipShowPanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            overobj = e.target as MovieClip;
            overNum = uint(overobj.name.substr(3,2));
            itemsTooltip.x = equipShowPanel.mouseX;
            itemsTooltip.y = equipShowPanel.mouseY;
            if(equipShowPanel.mouseX > equipShowPanel.x + 230 && equipShowPanel.mouseY < equipShowPanel.y + 230)
            {
               if(Main.player1.getBag().getEquipFromBag(overNum) != null)
               {
                  itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(overNum),1);
               }
            }
            else if(equipShowPanel.mouseX > equipShowPanel.x + 230 && equipShowPanel.mouseY > equipShowPanel.y + 230)
            {
               if(Main.player2.getBag().getEquipFromBag(overNum) != null)
               {
                  itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(overNum),2);
               }
            }
            else
            {
               numLeft = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
               itemsTooltip.equipTooltip(shopEquipList[overNum + (numLeft - 1) * 6]);
            }
            itemsTooltip.setTooltipPoint();
            itemsTooltip.visible = true;
         }
      }
      
      private static function closeBuy(e:MouseEvent) : void
      {
         equipShowPanel["buyMenu"].visible = false;
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
      
      private static function sellEquip(e:MouseEvent) : void
      {
         var num:int = 0;
         var str:String = null;
         num = int(clickObj.name.substr(3,2));
         str = clickObj.name.substr(0,2);
         if(str == "s1")
         {
            if(Main.player1.getBag().getEquipFromBag(num).getColor() == 1)
            {
               Main.player1.addGold(Main.player1.getBag().getEquipFromBag(num).getPrice());
               Main.player1.getBag().delEquip(num);
            }
            else
            {
               equipShowPanel.addChild(equipShowPanel["isSell"]);
               equipShowPanel["isSell"].visible = true;
            }
         }
         else if(Main.player2.getBag().getEquipFromBag(num).getColor() == 1)
         {
            Main.player2.addGold(Main.player2.getBag().getEquipFromBag(num).getPrice());
            Main.player2.getBag().delEquip(num);
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
      
      private static function shopListen(e:BtnEvent) : void
      {
         var numLeft:Number = NaN;
         var obj:MovieClip = null;
         numLeft = Number(EquipShopPanel.equipShowPanel["pageNumL"].text);
         obj = e.target as MovieClip;
         switch(obj.name)
         {
            case "leftPage":
               changeLeft();
               break;
            case "rightPage":
               changeRight();
               break;
            case "se_0":
               buyEquipMenu(0 + (numLeft - 1) * 6);
               break;
            case "se_1":
               buyEquipMenu(1 + (numLeft - 1) * 6);
               break;
            case "se_2":
               buyEquipMenu(2 + (numLeft - 1) * 6);
               break;
            case "se_3":
               buyEquipMenu(3 + (numLeft - 1) * 6);
               break;
            case "se_4":
               buyEquipMenu(4 + (numLeft - 1) * 6);
               break;
            case "se_5":
               buyEquipMenu(5 + (numLeft - 1) * 6);
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
   }
}

