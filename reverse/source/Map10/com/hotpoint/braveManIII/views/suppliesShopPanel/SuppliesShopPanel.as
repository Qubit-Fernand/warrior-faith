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
      
      public static var ssp:SuppliesShopPanel;
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var dragObj:MovieClip;
      
      public static var clickObj:MovieClip;
      
      private static var oldNum:Number;
      
      private static var pointx:Number;
      
      private static var pointy:Number;
      
      public static var player1:PlayerData;
      
      public static var player2:PlayerData;
      
      private static var chosen:Supplies;
      
      private static var allSuppliesShopHandle:AllSuppliesShopHandle;
      
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
         player1 = Main.player1;
         player2 = Main.player2;
         itemsTooltip = new ItemsTooltip();
         allSuppliesShopHandle = new AllSuppliesShopHandle();
         this.addChild(suppliesShowPanel);
         if(player2 == null)
         {
            suppliesShowPanel["lock2P"].visible = true;
            suppliesShowPanel["buyMenu"]["buy1P"].x += 50;
            suppliesShowPanel["buyMenu"]["buy2P"].visible = false;
         }
         suppliesShowPanel["buyMenu"].visible = false;
         suppliesShowPanel["mySell"].visible = false;
      }
      
      private static function sellSure() : void
      {
         var num:int = 0;
         var str:String = null;
         num = int(clickObj.name.substr(3,2));
         str = clickObj.name.substr(0,2);
         if(str == "s1")
         {
            player1.addGold(player1.getBag().getSuppliesFromBag(num).getPrice());
            player1.getBag().delSupplies(num);
         }
         else
         {
            player2.addGold(player2.getBag().getSuppliesFromBag(num).getPrice());
            player2.getBag().delSupplies(num);
         }
         ShopItemsShow.suppliesShow();
         ShopItemsShow.informationShow();
         if(player2)
         {
            ShopItemsShow.suppliesShow2P();
            ShopItemsShow.informationShow2P();
         }
         suppliesShowPanel["isSell"].visible = false;
      }
      
      private static function buyTooltipOpen(e:MouseEvent) : void
      {
         suppliesShowPanel.addChild(itemsTooltip);
         itemsTooltip.x = suppliesShowPanel.mouseX;
         itemsTooltip.y = suppliesShowPanel.mouseY;
         itemsTooltip.suppliesTooltip(chosen);
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
            suppliesShowPanel["s1_" + i].mouseChildren = false;
            suppliesShowPanel["s1_" + i]["t_txt"].visible = false;
            suppliesShowPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s1_" + i].addEventListener(MouseEvent.CLICK,menuOpen);
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
         for(j = 0; j < 6; j++)
         {
            suppliesShowPanel["se_" + j].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["se_" + j].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
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
         var i:uint = 0;
         suppliesShowPanel["lock2P"].visible = false;
         suppliesShowPanel["buyMenu"]["buy2P"].visible = true;
         for(i = 0; i < 24; i++)
         {
            suppliesShowPanel["s2_" + i].mouseChildren = false;
            suppliesShowPanel["s2_" + i]["t_txt"].visible = false;
            suppliesShowPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s2_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s2_" + i].addEventListener(MouseEvent.CLICK,menuOpen);
         }
         ShopItemsShow.suppliesShow2P();
         ShopItemsShow.informationShow2P();
      }
      
      public static function setKey_3(e:MouseEvent) : *
      {
         var su:Supplies = null;
         var num:int = 0;
         var str:String = null;
         num = int(clickObj.name.substr(3,2));
         str = clickObj.name.substr(0,2);
         if(str == "s1")
         {
            su = player1.getBag().getSuppliesFromBag(oldNum);
            player1.getSuppliesSlot().setToSuppliesSlot(su,2);
         }
         else
         {
            su = player2.getBag().getSuppliesFromBag(oldNum);
            player2.getSuppliesSlot().setToSuppliesSlot(su,2);
         }
      }
      
      private static function setUp() : void
      {
         var amount:int = 0;
         amount = int(suppliesShowPanel["buyMenu"]["amount"].text);
         if(amount == 24)
         {
            amount = 1;
         }
         else
         {
            amount++;
         }
         suppliesShowPanel["buyMenu"]["amount"].text = amount;
      }
      
      private static function setDown() : void
      {
         var amount:* = 0;
         amount = int(suppliesShowPanel["buyMenu"]["amount"].text);
         if(amount == 1)
         {
            amount = 24;
         }
         else
         {
            amount--;
         }
         suppliesShowPanel["buyMenu"]["amount"].text = amount;
      }
      
      public static function setKey_1(e:MouseEvent) : *
      {
         var su:Supplies = null;
         var num:int = 0;
         var str:String = null;
         num = int(clickObj.name.substr(3,2));
         str = clickObj.name.substr(0,2);
         if(str == "s1")
         {
            su = player1.getBag().getSuppliesFromBag(oldNum);
            player1.getSuppliesSlot().setToSuppliesSlot(su,0);
         }
         else
         {
            su = player2.getBag().getSuppliesFromBag(oldNum);
            player2.getSuppliesSlot().setToSuppliesSlot(su,0);
         }
      }
      
      private static function DownHandler(e:MouseEvent) : void
      {
         suppliesShowPanel["mySell"].visible = false;
         if(itemsTooltip.visible = true)
         {
            itemsTooltip.visible = false;
            isDown = true;
         }
         dragObj = e.target as MovieClip;
         returnx = dragObj.x;
         returny = dragObj.y;
         pointx = suppliesShowPanel.mouseX;
         pointy = suppliesShowPanel.mouseY;
         oldNum = uint(dragObj.name.substr(3,2));
      }
      
      public static function setKey_2(e:MouseEvent) : *
      {
         var su:Supplies = null;
         var num:int = 0;
         var str:String = null;
         num = int(clickObj.name.substr(3,2));
         str = clickObj.name.substr(0,2);
         if(str == "s1")
         {
            su = player1.getBag().getSuppliesFromBag(oldNum);
            player1.getSuppliesSlot().setToSuppliesSlot(su,1);
         }
         else
         {
            su = player2.getBag().getSuppliesFromBag(oldNum);
            player2.getSuppliesSlot().setToSuppliesSlot(su,1);
         }
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
            suppliesShowPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s1_" + i].removeEventListener(MouseEvent.CLICK,menuOpen);
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
         for(j = 0; j < 6; j++)
         {
            suppliesShowPanel["se_" + j].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["se_" + j].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
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
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            suppliesShowPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            suppliesShowPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            suppliesShowPanel["s2_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            suppliesShowPanel["s2_" + i].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
      }
      
      private static function sellSupplies(e:MouseEvent) : void
      {
         var num:int = 0;
         var str:String = null;
         num = int(clickObj.name.substr(3,2));
         str = clickObj.name.substr(0,2);
         if(str == "s1")
         {
            if(player1.getBag().getSuppliesFromBag(num).getColor() == 1)
            {
               player1.addGold(player1.getBag().getSuppliesFromBag(num).getPrice());
               player1.getBag().delSupplies(num);
            }
            else
            {
               suppliesShowPanel.addChild(suppliesShowPanel["isSell"]);
               suppliesShowPanel["isSell"].visible = true;
            }
         }
         else if(player2.getBag().getSuppliesFromBag(num).getColor() == 1)
         {
            player2.addGold(player2.getBag().getSuppliesFromBag(num).getPrice());
            player2.getBag().delSupplies(num);
         }
         else
         {
            suppliesShowPanel.addChild(suppliesShowPanel["isSell"]);
            suppliesShowPanel["isSell"].visible = true;
         }
         ShopItemsShow.suppliesShow();
         ShopItemsShow.informationShow();
         if(player2)
         {
            ShopItemsShow.suppliesShow2P();
            ShopItemsShow.informationShow2P();
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
         yflag = suppliesShowPanel.y + 275;
         for(j = 0; j < 3; yflag += 50,j++)
         {
            bagNum = 8 * j;
            xflag = suppliesShowPanel.x + 253;
            if(suppliesShowPanel.mouseY > yflag && suppliesShowPanel.mouseY < yflag + 45)
            {
               i = 0;
               while(i < 8)
               {
                  if(suppliesShowPanel.mouseX > xflag && suppliesShowPanel.mouseX < xflag + 45)
                  {
                     bool = Boolean(allSuppliesShopHandle.suppliesHandle2P(dragObj,oldNum,bagNum));
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
         if(ssp == null)
         {
            ssp = new SuppliesShopPanel();
         }
         addListenerP1();
         if(player2)
         {
            addListenerP2();
         }
         ssp.x = 130;
         ssp.y = 30;
         Main._stage.addChild(ssp);
         ssp.visible = true;
      }
      
      private static function changeRight() : void
      {
         var numLeft:Number = NaN;
         var numRight:Number = NaN;
         numLeft = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
         numRight = Number(SuppliesShopPanel.suppliesShowPanel["pageNumR"].text);
         if(numLeft < numRight)
         {
            numLeft++;
            SuppliesShopPanel.suppliesShowPanel["pageNumL"].text = numLeft;
         }
         ShopItemsShow.shopSuppliesShow();
      }
      
      private static function changeLeft() : void
      {
         var numLeft:Number = NaN;
         numLeft = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
         if(numLeft > 1)
         {
            numLeft--;
            SuppliesShopPanel.suppliesShowPanel["pageNumL"].text = numLeft;
         }
         ShopItemsShow.shopSuppliesShow();
      }
      
      private static function menuClose(e:MouseEvent) : void
      {
         ++closeTimes;
         if(closeTimes >= 1)
         {
            suppliesShowPanel["mySell"].visible = false;
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
      
      private static function DragHandler(e:MouseEvent) : void
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
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = null;
         var overNum:uint = 0;
         var numLeft:Number = NaN;
         suppliesShowPanel["mySell"].visible = false;
         suppliesShowPanel.addChild(itemsTooltip);
         if(isDown == false)
         {
            overobj = e.target as MovieClip;
            overNum = uint(overobj.name.substr(3,2));
            itemsTooltip.x = suppliesShowPanel.mouseX;
            itemsTooltip.y = suppliesShowPanel.mouseY;
            if(suppliesShowPanel.mouseX > suppliesShowPanel.x + 230 && suppliesShowPanel.mouseY < suppliesShowPanel.y + 230)
            {
               if(player1.getBag().getSuppliesFromBag(overNum) != null)
               {
                  itemsTooltip.suppliesTooltip(player1.getBag().getSuppliesFromBag(overNum),1);
               }
            }
            else if(suppliesShowPanel.mouseX > suppliesShowPanel.x + 230 && suppliesShowPanel.mouseY > suppliesShowPanel.y + 230)
            {
               if(player2.getBag().getSuppliesFromBag(overNum) != null)
               {
                  itemsTooltip.suppliesTooltip(player2.getBag().getSuppliesFromBag(overNum),2);
               }
            }
            else
            {
               numLeft = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
               itemsTooltip.suppliesTooltip(shopSuppliesList[overNum + (numLeft - 1) * 6]);
            }
            itemsTooltip.visible = true;
         }
      }
      
      private static function shopListen(e:BtnEvent) : void
      {
         var numLeft:Number = NaN;
         var obj:MovieClip = null;
         numLeft = Number(SuppliesShopPanel.suppliesShowPanel["pageNumL"].text);
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
               buySuppliesMenu(0 + (numLeft - 1) * 6);
               break;
            case "se_1":
               buySuppliesMenu(1 + (numLeft - 1) * 6);
               break;
            case "se_2":
               buySuppliesMenu(2 + (numLeft - 1) * 6);
               break;
            case "se_3":
               buySuppliesMenu(3 + (numLeft - 1) * 6);
               break;
            case "se_4":
               buySuppliesMenu(4 + (numLeft - 1) * 6);
               break;
            case "se_5":
               buySuppliesMenu(5 + (numLeft - 1) * 6);
               break;
            case "buy1P":
               buySuppliesByPlayerData(player1);
               break;
            case "buy2P":
               buySuppliesByPlayerData(player2);
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
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(ssp == null)
         {
            ssp = new SuppliesShopPanel();
         }
         removeListenerP1();
         if(player2)
         {
            removeListenerP2();
         }
         suppliesShowPanel["mySell"].visible = false;
         ssp.visible = false;
      }
      
      private static function buySuppliesMenu(num:Number) : void
      {
         suppliesShowPanel["buyMenu"].visible = true;
         suppliesShowPanel.addChild(suppliesShowPanel["buyMenu"]);
         new MouseEvent(MouseEvent.CLICK);
         suppliesShowPanel["buyMenu"]["buyPic"].gotoAndStop(shopSuppliesList[num].getFrame());
         suppliesShowPanel["buyMenu"]["buyPic"]["t_txt"].visible = false;
         chosen = shopSuppliesList[num];
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
         yflag = suppliesShowPanel.y + 62;
         for(j = 0; j < 3; yflag += 50,j++)
         {
            bagNum = 8 * j;
            xflag = suppliesShowPanel.x + 253;
            if(suppliesShowPanel.mouseY > yflag && suppliesShowPanel.mouseY < yflag + 45)
            {
               i = 0;
               while(i < 8)
               {
                  if(suppliesShowPanel.mouseX > xflag && suppliesShowPanel.mouseX < xflag + 45)
                  {
                     bool = Boolean(allSuppliesShopHandle.suppliesHandle(dragObj,oldNum,bagNum));
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
      
      private static function buySuppliesByPlayerData(player:PlayerData) : void
      {
         var amount:int = 0;
         var i:* = 0;
         amount = int(suppliesShowPanel["buyMenu"]["amount"].text);
         if(player.getGold() < chosen.getPrice() * amount * 2)
         {
            ShortTip.open(16);
         }
         else
         {
            if(player.getBag().backSuppliesBagNum() != 0)
            {
               if(amount > player.getBag().backSuppliesBagNum())
               {
                  amount = int(player.getBag().backSuppliesBagNum());
               }
               for(i = amount; i > 0; i--)
               {
                  player.getBag().addSuppliesBag(chosen.getClone());
                  player.payGold(chosen.getPrice() * 2);
               }
            }
            else
            {
               ShortTip.open(3);
            }
            ShopItemsShow.suppliesShow();
            ShopItemsShow.informationShow();
            if(player2)
            {
               ShopItemsShow.suppliesShow2P();
               ShopItemsShow.informationShow2P();
            }
         }
         suppliesShowPanel["buyMenu"].visible = false;
      }
      
      private static function isDrag(xx:Number, yy:Number) : Boolean
      {
         if(isDown == true)
         {
            if(suppliesShowPanel.mouseX > xx + 1 || suppliesShowPanel.mouseX < xx - 1 || suppliesShowPanel.mouseY > yy + 1 || suppliesShowPanel.mouseY < yy - 1)
            {
               return true;
            }
         }
         return false;
      }
   }
}

