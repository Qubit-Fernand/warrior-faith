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
         for(var i:uint = 0; i < 24; i++)
         {
            itemsPanel["s1_" + i].mouseChildren = false;
            itemsPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + i].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + i].addEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(var s:uint = 3; s < 11; s++)
         {
            itemsPanel["str_" + s].addEventListener(MouseEvent.MOUSE_OVER,strengthenOpen);
            itemsPanel["str_" + s].addEventListener(MouseEvent.MOUSE_OUT,strengthenClose);
         }
         for(var k:uint = 0; k < 6; k++)
         {
            itemsPanel["hz" + k].stop();
            itemsPanel["hz" + k].addEventListener(MouseEvent.MOUSE_OVER,hzOpen);
            itemsPanel["hz" + k].addEventListener(MouseEvent.MOUSE_OUT,hzClose);
         }
         for(var j:uint = 0; j < 8; j++)
         {
            itemsPanel["k1_" + j].mouseChildren = false;
            itemsPanel["z1_" + j].mouseChildren = false;
            itemsPanel["z1_" + j].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + j].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + j].addEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + j].addEventListener(MouseEvent.CLICK,menuOpen);
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
         for(var n:uint = 0; n < 2; n++)
         {
            itemsPanel["g1_" + n].addEventListener(MouseEvent.CLICK,menuOpen);
            itemsPanel["g1_" + n].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["g1_" + n].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
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
         for(var i:uint = 0; i < 24; i++)
         {
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["s1_" + i].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(var j:uint = 0; j < 8; j++)
         {
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.MOUSE_DOWN,DownHandler);
            itemsPanel["z1_" + j].removeEventListener(MouseEvent.CLICK,menuOpen);
         }
         for(var s:uint = 3; s < 11; s++)
         {
            itemsPanel["str_" + s].removeEventListener(MouseEvent.MOUSE_OVER,strengthenOpen);
            itemsPanel["str_" + s].removeEventListener(MouseEvent.MOUSE_OUT,strengthenClose);
         }
         for(var k:uint = 0; k < 6; k++)
         {
            itemsPanel["hz" + k].removeEventListener(MouseEvent.MOUSE_OVER,hzOpen);
            itemsPanel["hz" + k].removeEventListener(MouseEvent.MOUSE_OUT,hzClose);
         }
         for(var n:uint = 0; n < 2; n++)
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
         itemsPanel.removeEventListener(BtnEvent.DO_CHANGE,bagListen);
         itemsPanel.removeEventListener(MouseEvent.MOUSE_MOVE,DragHandler);
         itemsPanel.removeEventListener(MouseEvent.MOUSE_UP,UpHandler);
         itemsPanel.removeEventListener(MouseEvent.CLICK,menuClose);
         menuTooltip.removeListener();
      }
      
      private static function chenghaoOpen(e:*) : *
      {
         TitelPanel.open(isPOne);
      }
      
      private static function jinglingOpen(e:*) : *
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
      
      private static function qiannengOpen(e:*) : *
      {
         StampPanel.open(isPOne);
      }
      
      private static function loseFocus(e:Event = null) : *
      {
         if(dragObj)
         {
            UpHandler();
         }
      }
      
      private static function all_fenjie(e:MouseEvent) : void
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
      
      private static function gensui(e:MouseEvent) : *
      {
         Mouse.hide();
         itemsPanel["mouseFJ"].x = itemsPanel.mouseX;
         itemsPanel["mouseFJ"].y = itemsPanel.mouseY;
         e.updateAfterEvent();
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
      
      private static function menuTest() : Boolean
      {
         if(dragObj.x > returnx + 1 || dragObj.y > returny + 1 || dragObj.x < returnx - 1 || dragObj.y < returny - 1)
         {
            return false;
         }
         return true;
      }
      
      private static function hzClose(e:MouseEvent) : *
      {
         itemsPanel["hzTip"].visible = false;
      }
      
      private static function hzOpen(e:MouseEvent) : *
      {
         var overNum:uint = uint((e.target as MovieClip).name.substr(2,1));
         if(isPOne)
         {
            if(Main.player1.getBadgeSlot().getBadgeFromSlot(overNum))
            {
               itemsPanel["hzTip"]["str_name"].text = Main.player1.getBadgeSlot().getBadgeFromSlot(overNum).getName();
               itemsPanel["hzTip"]["str_text"].text = Main.player1.getBadgeSlot().getBadgeFromSlot(overNum).getIntroduction();
            }
         }
         else if(Main.player2.getBadgeSlot().getBadgeFromSlot(overNum))
         {
            itemsPanel["hzTip"]["str_name"].text = Main.player2.getBadgeSlot().getBadgeFromSlot(overNum).getName();
            itemsPanel["hzTip"]["str_text"].text = Main.player2.getBadgeSlot().getBadgeFromSlot(overNum).getIntroduction();
         }
         itemsPanel["hzTip"].visible = true;
         itemsPanel.addChild(itemsPanel["hzTip"]);
         itemsPanel["hzTip"].x = itemsPanel.mouseX + 10;
         itemsPanel["hzTip"].y = itemsPanel.mouseY;
      }
      
      private static function strengthenClose(e:MouseEvent) : *
      {
         itemsPanel["strengTip"].visible = false;
      }
      
      private static function strengthenOpen(e:MouseEvent) : *
      {
         var str:String = (e.target as MovieClip).name.toString();
         switch(str)
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
      
      private static function menuOpen(e:MouseEvent) : void
      {
         itemsTooltip.visible = false;
         clickObj = e.target as MovieClip;
         var str:String = clickObj.name.substr(0,2);
         oldNum = int(clickObj.name.substr(3,2));
         if(fenjie_bool)
         {
            if(str == "s1")
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
               MenuTooltip.isFJ(e);
            }
         }
         else
         {
            if(openFlag == true)
            {
               if(str == "s1")
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
               else if(str == "z1")
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
            if(str == "g1")
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
      
      private static function closeppp(e:*) : void
      {
         close();
         twoFalse();
         isPOne = true;
      }
      
      private static function bagListen(e:BtnEvent) : void
      {
         var btn:MovieClip = e.target as MovieClip;
         close_fenjie();
         switch(btn.name)
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
            if(isPOne)
            {
               if(str == "s1")
               {
                  switch(itemsType)
                  {
                     case 1:
                        if(Main.player1.getBag().getEquipFromBag(overNum) != null)
                        {
                           itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(overNum),1);
                        }
                        break;
                     case 2:
                        if(Main.player1.getBag().getSuppliesFromBag(overNum) != null)
                        {
                           itemsTooltip.suppliesTooltip(Main.player1.getBag().getSuppliesFromBag(overNum),1);
                        }
                        break;
                     case 3:
                        if(Main.player1.getBag().getGemFromBag(overNum) != null)
                        {
                           itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(overNum),1);
                        }
                        break;
                     case 4:
                        if(Main.player1.getBag().getOtherobjFromBag(overNum) != null)
                        {
                           itemsTooltip.otherTooltip(Main.player1.getBag().getOtherobjFromBag(overNum));
                        }
                        break;
                     case 5:
                        if(Main.player1.getBag().getQuestFromBag(overNum) != null)
                        {
                           itemsTooltip.questTooltip(Main.player1.getBag().getQuestFromBag(overNum));
                        }
                  }
               }
               else if(str == "g1")
               {
                  if(Main.player1.getEquipSkillSlot().getGemFromSkillSlot(overNum) != null)
                  {
                     itemsTooltip.gemTooltip(Main.player1.getEquipSkillSlot().getGemFromSkillSlot(overNum));
                  }
               }
               else if(str == "z1")
               {
                  itemsTooltip.slotTooltip(overNum,Main.player1.getEquipSlot());
               }
            }
            else if(str == "s1")
            {
               switch(itemsType)
               {
                  case 1:
                     if(Main.player2.getBag().getEquipFromBag(overNum) != null)
                     {
                        itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(overNum),2);
                     }
                     break;
                  case 2:
                     if(Main.player2.getBag().getSuppliesFromBag(overNum) != null)
                     {
                        itemsTooltip.suppliesTooltip(Main.player2.getBag().getSuppliesFromBag(overNum),2);
                     }
                     break;
                  case 3:
                     if(Main.player2.getBag().getGemFromBag(overNum) != null)
                     {
                        itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(overNum),2);
                     }
                     break;
                  case 4:
                     if(Main.player2.getBag().getOtherobjFromBag(overNum) != null)
                     {
                        itemsTooltip.otherTooltip(Main.player2.getBag().getOtherobjFromBag(overNum));
                     }
                     break;
                  case 5:
                     if(Main.player2.getBag().getQuestFromBag(overNum) != null)
                     {
                        itemsTooltip.questTooltip(Main.player2.getBag().getQuestFromBag(overNum));
                     }
               }
            }
            else if(str == "g1")
            {
               if(Main.player2.getEquipSkillSlot().getGemFromSkillSlot(overNum) != null)
               {
                  itemsTooltip.gemTooltip(Main.player2.getEquipSkillSlot().getGemFromSkillSlot(overNum));
               }
            }
            else if(str == "z1")
            {
               itemsTooltip.slotTooltip(overNum,Main.player2.getEquipSlot());
            }
            itemsTooltip.setTooltipPoint();
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
         for(i = 0; i < 8; ++i)
         {
            itemsPanel["k1_" + i].visible = false;
         }
      }
      
      private static function dragEquip() : void
      {
         var id:uint = 0;
         if(itemsType != 1)
         {
            return;
         }
         var num:int = int(oldNum);
         if(Main.water.getValue() != 1 && (num == 0 || num == 1 || num == 3 || num == 4))
         {
            num += 8;
         }
         var str:String = dragObj.name.substr(0,2);
         if(str == "s1")
         {
            if(isPOne)
            {
               id = uint(getPart(Main.player1.getBag().getEquipFromBag(oldNum).getPosition()));
            }
            else
            {
               id = uint(getPart(Main.player2.getBag().getEquipFromBag(oldNum).getPosition()));
            }
         }
         else if(str == "z1")
         {
            if(isPOne)
            {
               id = uint(getPart(Main.player1.getEquipSlot().getEquipFromSlot(num).getPosition()));
            }
            else
            {
               id = uint(getPart(Main.player2.getEquipSlot().getEquipFromSlot(num).getPosition()));
            }
         }
         ItemsPanel.itemsPanel["k1_" + id].visible = true;
         if(id == 2)
         {
            ItemsPanel.itemsPanel["k1_5"].visible = true;
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
               dragEquip();
            }
         }
      }
      
      private static function DownHandler(e:MouseEvent) : void
      {
         if(!fenjie_bool)
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
      }
      
      private static function isDrag(xx:Number, yy:Number) : Boolean
      {
         dragObj["diKuang"].visible = false;
         if(isDown == true)
         {
            if(itemsPanel.mouseX > xx + 1 || itemsPanel.mouseX < xx - 1 || itemsPanel.mouseY > yy + 1 || itemsPanel.mouseY < yy - 1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function UpHandler(e:MouseEvent = null) : void
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
         var bool:Boolean = false;
         var slotNum:uint = 0;
         var xflag:int = 0;
         var NewTemp:int = 0;
         var j:uint = 0;
         var yflag:int = 0;
         var i:uint = 0;
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
            xflag = itemsPanel.x + 20;
            NewTemp = 6;
            for(j = 0; j < 2; j++)
            {
               slotNum = 3 * j;
               yflag = itemsPanel.y + 165;
               if(itemsPanel.mouseX > xflag && itemsPanel.mouseX < xflag + 66)
               {
                  for(i = 0; i < 3; i++)
                  {
                     if(itemsPanel.mouseY > 95 && itemsPanel.mouseY < 155)
                     {
                        if(isPOne)
                        {
                           bool = Boolean(allBagHandle.slotHandle(dragObj,oldNum,NewTemp));
                        }
                        else
                        {
                           bool = Boolean(allBagHandle.slotHandle2P(dragObj,oldNum,NewTemp));
                        }
                        dragObj.x = returnx;
                        dragObj.y = returny;
                        return bool;
                     }
                     if(itemsPanel.mouseY > yflag && itemsPanel.mouseY < yflag + 63)
                     {
                        if(isPOne)
                        {
                           bool = Boolean(allBagHandle.slotHandle(dragObj,oldNum,slotNum));
                        }
                        else
                        {
                           bool = Boolean(allBagHandle.slotHandle2P(dragObj,oldNum,slotNum));
                        }
                        dragObj.x = returnx;
                        dragObj.y = returny;
                        return bool;
                     }
                     slotNum++;
                     yflag += 69;
                  }
               }
               NewTemp++;
               xflag += 296;
            }
            return false;
         }
         return false;
      }
      
      private static function inItemsRange() : Boolean
      {
         var bool:Boolean = false;
         var xflag:int = 0;
         var i:uint = 0;
         var bagNum:uint = 0;
         var yflag:int = itemsPanel.y + 106;
         for(var j:uint = 0; j < 8; j++)
         {
            bagNum = 4 * j;
            xflag = itemsPanel.x + 445;
            if(itemsPanel.mouseY > yflag && itemsPanel.mouseY < yflag + 63)
            {
               for(i = 0; i < 4; i++)
               {
                  if(itemsPanel.mouseX > xflag && itemsPanel.mouseX < xflag + 66)
                  {
                     if(isPOne)
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
                              bool = Boolean(allBagHandle.otherobjHandle(dragObj,oldNum,bagNum));
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
                              bool = Boolean(allBagHandle.equipHandle2P(dragObj,oldNum,bagNum));
                              break;
                           case 2:
                              bool = Boolean(allBagHandle.suppliesHandle2P(dragObj,oldNum,bagNum));
                              break;
                           case 3:
                              bool = Boolean(allBagHandle.gemHandle2P(dragObj,oldNum,bagNum));
                              break;
                           case 4:
                              bool = Boolean(allBagHandle.otherobjHandle2P(dragObj,oldNum,bagNum));
                              break;
                           case 5:
                              trace("c");
                        }
                     }
                     dragObj.x = returnx;
                     dragObj.y = returny;
                     return bool;
                  }
                  bagNum++;
                  xflag += 78;
               }
            }
            yflag += 69;
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
      
      public static function szcbTime() : void
      {
         for(var i:int = 0; i < 24; i++)
         {
            if(Boolean(Main.player1.getBag().getEquipFromBag(i)) && Boolean(Main.player1.getBag().getEquipFromBag(i).getPosition() > 7) && Main.player1.getBag().getEquipFromBag(i).getPosition() < 10)
            {
               Main.player1.getBag().getEquipFromBag(i).setRemainingTime(Main.serverTime);
            }
         }
         for(var j:int = 6; j < 8; j++)
         {
            if(Main.player1.getEquipSlot().getEquipFromSlot(j))
            {
               Main.player1.getEquipSlot().getEquipFromSlot(j).setRemainingTime(Main.serverTime);
            }
         }
         for(var k:int = 0; k < 35; k++)
         {
            if(Boolean(StoragePanel.storage.getEquipFromStorage(k)) && Boolean(StoragePanel.storage.getEquipFromStorage(k).getPosition() > 7) && StoragePanel.storage.getEquipFromStorage(k).getPosition() < 10)
            {
               StoragePanel.storage.getEquipFromStorage(k).setRemainingTime(Main.serverTime);
            }
         }
         Main.player_1.newSkin();
         if(Main.P1P2)
         {
            for(i = 0; i < 24; i++)
            {
               if(Boolean(Main.player2.getBag().getEquipFromBag(i)) && Boolean(Main.player2.getBag().getEquipFromBag(i).getPosition() > 7) && Main.player2.getBag().getEquipFromBag(i).getPosition() < 10)
               {
                  Main.player2.getBag().getEquipFromBag(i).setRemainingTime(Main.serverTime);
               }
            }
            for(j = 6; j < 8; j++)
            {
               if(Main.player2.getEquipSlot().getEquipFromSlot(j))
               {
                  Main.player2.getEquipSlot().getEquipFromSlot(j).setRemainingTime(Main.serverTime);
               }
            }
            Main.player_2.newSkin();
         }
      }
      
      public static function timeXiuZheng() : *
      {
         for(var i:int = 8; i < 13; i++)
         {
            if(Main.player1.getEquipSlot().getEquipFromSlot(i))
            {
               if(Main.player1.getEquipSlot().getEquipFromSlot(i).getRemainingTime() < 1)
               {
                  Main.player1.getEquipSlot().getEquipFromSlot(i).setRemainingTimeNow();
               }
            }
            if(Main.P1P2)
            {
               if(Main.player2.getEquipSlot().getEquipFromSlot(i))
               {
                  if(Main.player2.getEquipSlot().getEquipFromSlot(i).getRemainingTime() < 1)
                  {
                     Main.player2.getEquipSlot().getEquipFromSlot(i).setRemainingTimeNow();
                  }
               }
            }
         }
      }
   }
}

