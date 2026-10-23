package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.elvesPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.stampPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.titelPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   import src.*;
   
   public class ItemsPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var menuTooltip:MenuTooltip;
      
      public static var dragObj:MovieClip;
      
      public static var clickObj:MovieClip;
      
      private static var pointx:Number;
      
      private static var pointy:Number;
      
      private static var allBagHandle:AllBagHandle;
      
      public static var ip:ItemsPanel;
      
      public static var isPOne:Boolean = true;
      
      public static var boolFlag:Boolean = false;
      
      public static var itemsPanel:MovieClip = new ItemsShow();
      
      public static var isDown:Boolean = false;
      
      public static var returnx:int = 0;
      
      public static var returny:int = 0;
      
      private static var oldNum:uint = 0;
      
      public static var itemsType:uint = 1;
      
      private static var openFlag:Boolean = false;
      
      private static var closeTimes:uint = 0;
      
      private static var myMenu:ContextMenu = new ContextMenu();
      
      private static var fenjie_bool:Boolean = false;
      
      public function ItemsPanel()
      {
         super();
         menuTooltip = new MenuTooltip();
         itemsTooltip = new ItemsTooltip();
         allBagHandle = new AllBagHandle();
         this.addChild(itemsPanel);
         itemsPanel["bagOne"].visible = false;
         itemsPanel["bagTwo"].visible = false;
         itemsPanel["txt_1"].mouseChildren = itemsPanel["txt_1"].mouseEnabled = false;
      }
      
      public static function open() : void
      {
         timeXiuZheng();
         Main.allClosePanel();
         boolFlag = true;
         if(ip == null)
         {
            ip = new ItemsPanel();
         }
         Main.stopXX = true;
         ip.x = 50;
         ip.y = 0;
         Player.getEquipDataXX();
         addListenerP1();
         Main.player1.getBag().cheatTesting();
         Main.player1.getBag().cheatGem();
         Main.player1.getBag().cheatOther();
         if(Main.P1P2)
         {
            itemsPanel["bagOne"].visible = true;
            itemsPanel["bagTwo"].visible = true;
            Main.player2.getBag().cheatTesting();
            Main.player2.getBag().cheatGem();
            Main.player2.getBag().cheatOther();
         }
         Main._this.addChild(ip);
         ip.visible = true;
      }
      
      public static function close() : void
      {
         close_fenjie();
         boolFlag = false;
         if(ip == null)
         {
            ip = new ItemsPanel();
         }
         Main.player1.getBag().cheatGem();
         Main.player1.getBag().cheatOther();
         if(Main.P1P2)
         {
            Main.player2.getBag().cheatGem();
            Main.player2.getBag().cheatOther();
         }
         Main.stopXX = false;
         menuTooltip.visible = false;
         removeListenerP1();
         ip.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            itemsPanel["s1_" + _loc1_].mouseChildren = false;
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + _loc1_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         var _loc2_:uint = 3;
         while(_loc2_ < 11)
         {
            itemsPanel["str_" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,strengthenOpen);
            itemsPanel["str_" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,strengthenClose);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < 6)
         {
            itemsPanel["hz" + _loc3_].stop();
            itemsPanel["hz" + _loc3_].addEventListener(MouseEvent.MOUSE_OVER,hzOpen);
            itemsPanel["hz" + _loc3_].addEventListener(MouseEvent.MOUSE_OUT,hzClose);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            itemsPanel["k1_" + _loc4_].mouseChildren = false;
            itemsPanel["z1_" + _loc4_].mouseChildren = false;
            itemsPanel["z1_" + _loc4_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + _loc4_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + _loc4_].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + _loc4_].addEventListener(MouseEvent.CLICK,menuOpen);
            _loc4_++;
         }
         itemsPanel["jingling"].stop();
         itemsPanel["closePanel"].addEventListener(MouseEvent.CLICK,closeppp);
         itemsPanel["chenghao_btn"].addEventListener(MouseEvent.CLICK,chenghaoOpen);
         itemsPanel["jingling_btn"].addEventListener(MouseEvent.CLICK,jinglingOpen);
         itemsPanel["qianneng_btn"].addEventListener(MouseEvent.CLICK,qiannengOpen);
         itemsPanel.addEventListener(BtnEvent.DO_CHANGE,bagListen);
         itemsPanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         itemsPanel.contextMenu = myMenu;
         var _loc5_:uint = 0;
         while(_loc5_ < 2)
         {
            itemsPanel["g1_" + _loc5_].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g1_" + _loc5_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g1_" + _loc5_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc5_++;
         }
         itemsPanel["all_fenjie"].addEventListener(MouseEvent.CLICK,all_fenjie);
         itemsPanel.addEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         itemsPanel.addEventListener(MouseEvent.MOUSE_UP,UpHandler);
         itemsPanel.addEventListener(MouseEvent.CLICK,menuClose);
         menuTooltip.addListener();
         BagItemsShow.allHide();
         BagItemsShow.equipShow();
         BagItemsShow.badgeSlotShow();
         BagItemsShow.slotShow();
         BagItemsShow.skillSlotShow();
         BagItemsShow.informationShow();
         allFalse();
         itemsPanel["getFJ"].mouseEnabled = false;
         itemsPanel["all_fenjie"].visible = true;
         itemsPanel["bagOne"].isClick = true;
         itemsPanel["bg1_1"].isClick = true;
         itemsPanel["getFJ"].visible = false;
         itemsPanel["isFenJie"].visible = false;
         itemsPanel["isSell"].visible = false;
         itemsPanel["isAllSell"].visible = false;
         itemsPanel["sellMenu"].visible = false;
         itemsPanel["strengTip"].visible = false;
         itemsPanel["hzTip"].visible = false;
         itemsPanel["txtTop"].visible = false;
         itemsPanel["txtTop2"].visible = false;
         itemsType = 1;
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + _loc1_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc1_++;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < 8)
         {
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + _loc2_].removeEventListener(MouseEvent.CLICK,menuOpen);
            _loc2_++;
         }
         var _loc3_:uint = 3;
         while(_loc3_ < 11)
         {
            itemsPanel["str_" + _loc3_].removeEventListener(MouseEvent.MOUSE_OVER,strengthenOpen);
            itemsPanel["str_" + _loc3_].removeEventListener(MouseEvent.MOUSE_OUT,strengthenClose);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < 6)
         {
            itemsPanel["hz" + _loc4_].removeEventListener(MouseEvent.MOUSE_OVER,hzOpen);
            itemsPanel["hz" + _loc4_].removeEventListener(MouseEvent.MOUSE_OUT,hzClose);
            _loc4_++;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < 2)
         {
            itemsPanel["g1_" + _loc5_].removeEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g1_" + _loc5_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g1_" + _loc5_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            _loc5_++;
         }
         itemsPanel.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         itemsPanel.contextMenu = myMenu;
         itemsPanel.removeEventListener(BtnEvent.DO_CHANGE,bagListen);
         itemsPanel.removeEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         itemsPanel.removeEventListener(MouseEvent.MOUSE_UP,UpHandler);
         itemsPanel.removeEventListener(MouseEvent.CLICK,menuClose);
         menuTooltip.removeListener();
      }
      
      private static function chenghaoOpen(param1:*) : *
      {
         TitelPanel.open(isPOne);
      }
      
      private static function jinglingOpen(param1:*) : *
      {
         if(isPOne)
         {
            ElvesPanel.open(Main.player1);
         }
         else
         {
            ElvesPanel.open(Main.player2);
         }
      }
      
      private static function qiannengOpen(param1:*) : *
      {
         StampPanel.open(isPOne);
      }
      
      private static function loseFocus(param1:Event = null) : *
      {
         if(dragObj)
         {
            UpHandler();
         }
      }
      
      private static function all_fenjie(param1:MouseEvent) : void
      {
         if(fenjie_bool)
         {
            itemsPanel["mouseFJ"].x = 20000;
            Mouse.show();
            fenjie_bool = false;
            itemsPanel.removeEventListener(MouseEvent.MOUSE_MOVE,gensui);
         }
         else
         {
            fenjie_bool = true;
            itemsPanel.addEventListener(MouseEvent.MOUSE_MOVE,gensui);
         }
      }
      
      private static function close_fenjie() : void
      {
         fenjie_bool = false;
         Mouse.show();
         itemsPanel["mouseFJ"].x = 20000;
         itemsPanel.removeEventListener(MouseEvent.MOUSE_MOVE,gensui);
      }
      
      private static function gensui(param1:MouseEvent) : *
      {
         Mouse.hide();
         itemsPanel["mouseFJ"].x = itemsPanel.mouseX;
         itemsPanel["mouseFJ"].y = itemsPanel.mouseY;
         param1.updateAfterEvent();
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
      
      private static function menuTest() : Boolean
      {
         if(dragObj.x > returnx + 1 || dragObj.y > returny + 1 || dragObj.x < returnx - 1 || dragObj.y < returny - 1)
         {
            return false;
         }
         return true;
      }
      
      private static function hzClose(param1:MouseEvent) : *
      {
         itemsPanel["hzTip"].visible = false;
      }
      
      private static function hzOpen(param1:MouseEvent) : *
      {
         var _loc2_:uint = uint((param1.target as MovieClip).name.substr(2,1));
         if(isPOne)
         {
            if(Main.player1.getBadgeSlot().getBadgeFromSlot(_loc2_))
            {
               itemsPanel["hzTip"]["str_name"].text = Main.player1.getBadgeSlot().getBadgeFromSlot(_loc2_).getName();
               itemsPanel["hzTip"]["str_text"].text = Main.player1.getBadgeSlot().getBadgeFromSlot(_loc2_).getIntroduction();
            }
         }
         else if(Main.player2.getBadgeSlot().getBadgeFromSlot(_loc2_))
         {
            itemsPanel["hzTip"]["str_name"].text = Main.player2.getBadgeSlot().getBadgeFromSlot(_loc2_).getName();
            itemsPanel["hzTip"]["str_text"].text = Main.player2.getBadgeSlot().getBadgeFromSlot(_loc2_).getIntroduction();
         }
         itemsPanel["hzTip"].visible = true;
         itemsPanel.addChild(itemsPanel["hzTip"]);
         itemsPanel["hzTip"].x = itemsPanel.mouseX + 10;
         itemsPanel["hzTip"].y = itemsPanel.mouseY;
      }
      
      private static function strengthenClose(param1:MouseEvent) : *
      {
         itemsPanel["strengTip"].visible = false;
      }
      
      private static function strengthenOpen(param1:MouseEvent) : *
      {
         var _loc2_:String = (param1.target as MovieClip).name.toString();
         switch(_loc2_)
         {
            case "str_3":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉加成";
               itemsPanel["strengTip"]["str_text"].text = "除时装，翅膀以外的其他装备全部强化+4以上时，可获得额外属性加成";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
               break;
            case "str_4":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉+4";
               itemsPanel["strengTip"]["str_text"].text = "提高生命值10%";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
               break;
            case "str_5":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉+5";
               itemsPanel["strengTip"]["str_text"].text = "提高生命值15% 提高闪避值10%";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
               break;
            case "str_6":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉+6";
               itemsPanel["strengTip"]["str_text"].text = "提高生命值15% 提高闪避值15% 提升1点移动力";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
               break;
            case "str_7":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉+7";
               itemsPanel["strengTip"]["str_text"].text = "提高生命值15% 提高闪避值20% 提高防御力7% 提升1点移动力";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
               break;
            case "str_8":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉+8";
               itemsPanel["strengTip"]["str_text"].text = "提高生命值20% 提高闪避值25% 提高防御力7% 提升1点移动力";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
               break;
            case "str_9":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉+9";
               itemsPanel["strengTip"]["str_text"].text = "提高生命值20% 提高闪避值30% 提高防御力10% 提升1点移动力";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
               break;
            case "str_10":
               itemsPanel["strengTip"]["str_name"].text = "强化荣誉+10";
               itemsPanel["strengTip"]["str_text"].text = "提高生命值27% 提高闪避值35% 提高防御力15% 提高攻击力20% 提升2点移动力";
               itemsPanel["strengTip"].x = itemsPanel.mouseX + 10;
         }
         itemsPanel["strengTip"].visible = true;
         itemsPanel.addChild(itemsPanel["strengTip"]);
      }
      
      private static function menuOpen(param1:MouseEvent) : void
      {
         itemsTooltip.visible = false;
         clickObj = param1.target as MovieClip;
         var _loc2_:String = clickObj.name.substr(0,2);
         oldNum = int(clickObj.name.substr(3,2));
         if(fenjie_bool)
         {
            if(_loc2_ == "s1")
            {
               if(isPOne)
               {
                  MenuTooltip.whichDo = 1;
               }
               else
               {
                  MenuTooltip.whichDo = 2;
               }
               MenuTooltip.selectType = 1;
               MenuTooltip.oldNum = int(clickObj.name.substr(3,2));
               MenuTooltip.isFJ(param1);
            }
         }
         else
         {
            if(openFlag == true)
            {
               if(_loc2_ == "s1")
               {
                  if(isPOne)
                  {
                     menuTooltip.setItemsMenu(itemsType,oldNum,1);
                     itemsPanel.addChild(menuTooltip);
                     menuTooltip.x = clickObj.x + 30;
                     menuTooltip.y = clickObj.y + 30;
                     menuTooltip.visible = true;
                     closeTimes = 0;
                  }
                  else
                  {
                     menuTooltip.setItemsMenu(itemsType,oldNum,2);
                     itemsPanel.addChild(menuTooltip);
                     menuTooltip.x = clickObj.x + 30;
                     menuTooltip.y = clickObj.y + 30;
                     menuTooltip.visible = true;
                     closeTimes = 0;
                  }
               }
               else if(_loc2_ == "z1")
               {
                  if(isPOne)
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
                  else if(oldNum != 2 && oldNum != 5)
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
               if(isPOne)
               {
                  menuTooltip.setSkillSlotMenu(oldNum,1);
                  itemsPanel.addChild(menuTooltip);
                  menuTooltip.x = clickObj.x + 20;
                  menuTooltip.y = clickObj.y + 20;
                  menuTooltip.visible = true;
                  closeTimes = 0;
               }
               else
               {
                  menuTooltip.setSkillSlotMenu(oldNum,2);
                  itemsPanel.addChild(menuTooltip);
                  menuTooltip.x = clickObj.x + 20;
                  menuTooltip.y = clickObj.y + 20;
                  menuTooltip.visible = true;
                  closeTimes = 0;
               }
            }
            openFlag = false;
            clickObj = null;
         }
      }
      
      public static function allFalse() : void
      {
         itemsPanel["bg1_1"].isClick = false;
         itemsPanel["bg1_2"].isClick = false;
         itemsPanel["bg1_3"].isClick = false;
         itemsPanel["bg1_4"].isClick = false;
         itemsPanel["bg1_5"].isClick = false;
      }
      
      public static function twoFalse() : void
      {
         itemsPanel["bagTwo"].isClick = false;
         itemsPanel["bagOne"].isClick = false;
      }
      
      private static function closeppp(param1:*) : void
      {
         close();
         twoFalse();
         isPOne = true;
      }
      
      private static function bagListen(param1:BtnEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         close_fenjie();
         switch(_loc2_.name)
         {
            case "bg1_1":
               itemsType = 1;
               allFalse();
               itemsPanel["all_fenjie"].visible = true;
               itemsPanel["bg1_1"].isClick = true;
               if(isPOne)
               {
                  BagItemsShow.equipShow();
               }
               else
               {
                  BagItemsShow.equipShow2P();
               }
               break;
            case "bg1_2":
               itemsType = 2;
               allFalse();
               itemsPanel["all_fenjie"].visible = false;
               itemsPanel["bg1_2"].isClick = true;
               if(isPOne)
               {
                  BagItemsShow.suppliesShow();
               }
               else
               {
                  BagItemsShow.suppliesShow2P();
               }
               break;
            case "bg1_3":
               itemsType = 3;
               allFalse();
               itemsPanel["all_fenjie"].visible = false;
               itemsPanel["bg1_3"].isClick = true;
               if(isPOne)
               {
                  BagItemsShow.gemShow();
               }
               else
               {
                  BagItemsShow.gemShow2P();
               }
               break;
            case "bg1_4":
               itemsType = 4;
               allFalse();
               itemsPanel["all_fenjie"].visible = false;
               itemsPanel["bg1_4"].isClick = true;
               if(isPOne)
               {
                  BagItemsShow.otherobjShow();
               }
               else
               {
                  BagItemsShow.otherobjShow2P();
               }
               break;
            case "bg1_5":
               itemsType = 5;
               allFalse();
               itemsPanel["all_fenjie"].visible = false;
               itemsPanel["bg1_5"].isClick = true;
               if(isPOne)
               {
                  BagItemsShow.questShow();
               }
               else
               {
                  BagItemsShow.questShow2P();
               }
               break;
            case "bagOne":
               isPOne = true;
               twoFalse();
               itemsPanel["bagOne"].isClick = true;
               switch(itemsType)
               {
                  case 1:
                     BagItemsShow.equipShow();
                     break;
                  case 2:
                     BagItemsShow.suppliesShow();
                     break;
                  case 3:
                     BagItemsShow.gemShow();
                     break;
                  case 4:
                     BagItemsShow.otherobjShow();
                     break;
                  case 5:
                     BagItemsShow.questShow();
               }
               BagItemsShow.skillSlotShow();
               BagItemsShow.slotShow();
               BagItemsShow.badgeSlotShow();
               BagItemsShow.informationShow();
               break;
            case "bagTwo":
               isPOne = false;
               twoFalse();
               itemsPanel["bagTwo"].isClick = true;
               switch(itemsType)
               {
                  case 1:
                     BagItemsShow.equipShow2P();
                     break;
                  case 2:
                     BagItemsShow.suppliesShow2P();
                     break;
                  case 3:
                     BagItemsShow.gemShow2P();
                     break;
                  case 4:
                     BagItemsShow.otherobjShow2P();
                     break;
                  case 5:
                     BagItemsShow.questShow2P();
               }
               BagItemsShow.skillSlotShow2P();
               BagItemsShow.slotShow2P();
               BagItemsShow.badgeSlotShow2P();
               BagItemsShow.informationShow2P();
         }
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
            if(isPOne)
            {
               if(_loc4_ == "s1")
               {
                  switch(itemsType)
                  {
                     case 1:
                        if(Main.player1.getBag().getEquipFromBag(_loc3_) != null)
                        {
                           itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(_loc3_),1);
                        }
                        break;
                     case 2:
                        if(Main.player1.getBag().getSuppliesFromBag(_loc3_) != null)
                        {
                           itemsTooltip.suppliesTooltip(Main.player1.getBag().getSuppliesFromBag(_loc3_),1);
                        }
                        break;
                     case 3:
                        if(Main.player1.getBag().getGemFromBag(_loc3_) != null)
                        {
                           itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(_loc3_),1);
                        }
                        break;
                     case 4:
                        if(Main.player1.getBag().getOtherobjFromBag(_loc3_) != null)
                        {
                           itemsTooltip.otherTooltip(Main.player1.getBag().getOtherobjFromBag(_loc3_));
                        }
                        break;
                     case 5:
                        if(Main.player1.getBag().getQuestFromBag(_loc3_) != null)
                        {
                           itemsTooltip.questTooltip(Main.player1.getBag().getQuestFromBag(_loc3_));
                        }
                  }
               }
               else if(_loc4_ == "g1")
               {
                  if(Main.player1.getEquipSkillSlot().getGemFromSkillSlot(_loc3_) != null)
                  {
                     itemsTooltip.gemTooltip(Main.player1.getEquipSkillSlot().getGemFromSkillSlot(_loc3_));
                  }
               }
               else if(_loc4_ == "z1")
               {
                  itemsTooltip.slotTooltip(_loc3_,Main.player1.getEquipSlot());
               }
            }
            else if(_loc4_ == "s1")
            {
               switch(itemsType)
               {
                  case 1:
                     if(Main.player2.getBag().getEquipFromBag(_loc3_) != null)
                     {
                        itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(_loc3_),2);
                     }
                     break;
                  case 2:
                     if(Main.player2.getBag().getSuppliesFromBag(_loc3_) != null)
                     {
                        itemsTooltip.suppliesTooltip(Main.player2.getBag().getSuppliesFromBag(_loc3_),2);
                     }
                     break;
                  case 3:
                     if(Main.player2.getBag().getGemFromBag(_loc3_) != null)
                     {
                        itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(_loc3_),2);
                     }
                     break;
                  case 4:
                     if(Main.player2.getBag().getOtherobjFromBag(_loc3_) != null)
                     {
                        itemsTooltip.otherTooltip(Main.player2.getBag().getOtherobjFromBag(_loc3_));
                     }
                     break;
                  case 5:
                     if(Main.player2.getBag().getQuestFromBag(_loc3_) != null)
                     {
                        itemsTooltip.questTooltip(Main.player2.getBag().getQuestFromBag(_loc3_));
                     }
               }
            }
            else if(_loc4_ == "g1")
            {
               if(Main.player2.getEquipSkillSlot().getGemFromSkillSlot(_loc3_) != null)
               {
                  itemsTooltip.gemTooltip(Main.player2.getEquipSkillSlot().getGemFromSkillSlot(_loc3_));
               }
            }
            else if(_loc4_ == "z1")
            {
               itemsTooltip.slotTooltip(_loc3_,Main.player2.getEquipSlot());
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
            case 8:
               return 6;
            case 9:
               return 7;
            case 10:
               return 0;
            case 11:
               return 1;
            case 12:
               return 3;
            case 13:
               return 4;
            default:
               return null;
         }
      }
      
      private static function closeLight() : void
      {
         i = 0;
         while(i < 8)
         {
            itemsPanel["k1_" + i].visible = false;
            ++i;
         }
      }
      
      private static function dragEquip() : void
      {
         var _loc1_:uint = 0;
         if(itemsType != 1)
         {
            return;
         }
         var _loc2_:int = int(oldNum);
         if(Main.water.getValue() != 1 && (_loc2_ == 0 || _loc2_ == 1 || _loc2_ == 3 || _loc2_ == 4))
         {
            _loc2_ += 8;
         }
         var _loc3_:String = dragObj.name.substr(0,2);
         if(_loc3_ == "s1")
         {
            if(isPOne)
            {
               _loc1_ = uint(getPart(Main.player1.getBag().getEquipFromBag(oldNum).getPosition()));
            }
            else
            {
               _loc1_ = uint(getPart(Main.player2.getBag().getEquipFromBag(oldNum).getPosition()));
            }
         }
         else if(_loc3_ == "z1")
         {
            if(isPOne)
            {
               _loc1_ = uint(getPart(Main.player1.getEquipSlot().getEquipFromSlot(_loc2_).getPosition()));
            }
            else
            {
               _loc1_ = uint(getPart(Main.player2.getEquipSlot().getEquipFromSlot(_loc2_).getPosition()));
            }
         }
         ItemsPanel.itemsPanel["k1_" + _loc1_].visible = true;
         if(_loc1_ == 2)
         {
            ItemsPanel.itemsPanel["k1_5"].visible = true;
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
               dragEquip();
            }
         }
      }
      
      private static function DownHandler(param1:MouseEvent) : void
      {
         if(!fenjie_bool)
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
      }
      
      private static function isDrag(param1:Number, param2:Number) : Boolean
      {
         dragObj["diKuang"].visible = false;
         if(isDown == true)
         {
            if(itemsPanel.mouseX > param1 + 1 || itemsPanel.mouseX < param1 - 1 || itemsPanel.mouseY > param2 + 1 || itemsPanel.mouseY < param2 - 1)
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
            closeLight();
            if(menuTest() == true)
            {
               openFlag = true;
            }
            else
            {
               openFlag = false;
            }
            if(inItemsRange() == false && inEquipSlotRange() == false)
            {
               dragObj.x = returnx;
               dragObj.y = returny;
            }
         }
         isDown = false;
         dragObj = null;
      }
      
      private static function inEquipSlotRange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         if(itemsPanel.mouseX < 400)
         {
            if(dragObj.name.substr(0,2) == "z1")
            {
               return false;
            }
            if(itemsType != 1)
            {
               return false;
            }
            _loc3_ = itemsPanel.x + 20;
            _loc4_ = 6;
            _loc5_ = 0;
            while(_loc5_ < 2)
            {
               _loc2_ = 3 * _loc5_;
               _loc6_ = itemsPanel.y + 165;
               if(itemsPanel.mouseX > _loc3_ && itemsPanel.mouseX < _loc3_ + 66)
               {
                  _loc7_ = 0;
                  while(_loc7_ < 3)
                  {
                     if(itemsPanel.mouseY > 95 && itemsPanel.mouseY < 155)
                     {
                        if(isPOne)
                        {
                           _loc1_ = Boolean(allBagHandle.slotHandle(dragObj,oldNum,_loc4_));
                        }
                        else
                        {
                           _loc1_ = Boolean(allBagHandle.slotHandle2P(dragObj,oldNum,_loc4_));
                        }
                        dragObj.x = returnx;
                        dragObj.y = returny;
                        return _loc1_;
                     }
                     if(itemsPanel.mouseY > _loc6_ && itemsPanel.mouseY < _loc6_ + 63)
                     {
                        if(isPOne)
                        {
                           _loc1_ = Boolean(allBagHandle.slotHandle(dragObj,oldNum,_loc2_));
                        }
                        else
                        {
                           _loc1_ = Boolean(allBagHandle.slotHandle2P(dragObj,oldNum,_loc2_));
                        }
                        dragObj.x = returnx;
                        dragObj.y = returny;
                        return _loc1_;
                     }
                     _loc2_++;
                     _loc6_ += 69;
                     _loc7_++;
                  }
               }
               _loc4_++;
               _loc3_ += 296;
               _loc5_++;
            }
            return false;
         }
         return false;
      }
      
      private static function inItemsRange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = itemsPanel.y + 106;
         var _loc4_:uint = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = 4 * _loc4_;
            _loc5_ = itemsPanel.x + 445;
            if(itemsPanel.mouseY > _loc3_ && itemsPanel.mouseY < _loc3_ + 63)
            {
               _loc6_ = 0;
               while(_loc6_ < 4)
               {
                  if(itemsPanel.mouseX > _loc5_ && itemsPanel.mouseX < _loc5_ + 66)
                  {
                     if(isPOne)
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
                              _loc1_ = Boolean(allBagHandle.otherobjHandle(dragObj,oldNum,_loc2_));
                              break;
                           case 5:
                              trace("c");
                        }
                     }
                     else
                     {
                        switch(itemsType)
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
                              _loc1_ = Boolean(allBagHandle.otherobjHandle2P(dragObj,oldNum,_loc2_));
                              break;
                           case 5:
                              trace("c");
                        }
                     }
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return _loc1_;
                  }
                  _loc2_++;
                  _loc5_ += 78;
                  _loc6_++;
               }
            }
            _loc3_ += 69;
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
      
      public static function szcbTime() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(Boolean(Main.player1.getBag().getEquipFromBag(_loc1_)) && Boolean(Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() > 7) && Main.player1.getBag().getEquipFromBag(_loc1_).getPosition() < 10)
            {
               Main.player1.getBag().getEquipFromBag(_loc1_).setRemainingTime(Main.serverTime);
            }
            _loc1_++;
         }
         var _loc2_:int = 6;
         while(_loc2_ < 8)
         {
            if(Main.player1.getEquipSlot().getEquipFromSlot(_loc2_))
            {
               Main.player1.getEquipSlot().getEquipFromSlot(_loc2_).setRemainingTime(Main.serverTime);
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 35)
         {
            if(Boolean(StoragePanel.storage.getEquipFromStorage(_loc3_)) && Boolean(StoragePanel.storage.getEquipFromStorage(_loc3_).getPosition() > 7) && StoragePanel.storage.getEquipFromStorage(_loc3_).getPosition() < 10)
            {
               StoragePanel.storage.getEquipFromStorage(_loc3_).setRemainingTime(Main.serverTime);
            }
            _loc3_++;
         }
         Main.player_1.newSkin();
         if(Main.P1P2)
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(Boolean(Main.player2.getBag().getEquipFromBag(_loc1_)) && Boolean(Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() > 7) && Main.player2.getBag().getEquipFromBag(_loc1_).getPosition() < 10)
               {
                  Main.player2.getBag().getEquipFromBag(_loc1_).setRemainingTime(Main.serverTime);
               }
               _loc1_++;
            }
            _loc2_ = 6;
            while(_loc2_ < 8)
            {
               if(Main.player2.getEquipSlot().getEquipFromSlot(_loc2_))
               {
                  Main.player2.getEquipSlot().getEquipFromSlot(_loc2_).setRemainingTime(Main.serverTime);
               }
               _loc2_++;
            }
            Main.player_2.newSkin();
         }
      }
      
      public static function timeXiuZheng() : *
      {
         var _loc1_:int = 8;
         while(_loc1_ < 13)
         {
            if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_))
            {
               if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getRemainingTime() < 1)
               {
                  Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).setRemainingTimeNow();
               }
            }
            if(Main.P1P2)
            {
               if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_))
               {
                  if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getRemainingTime() < 1)
                  {
                     Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).setRemainingTimeNow();
                  }
               }
            }
            _loc1_++;
         }
      }
   }
}

