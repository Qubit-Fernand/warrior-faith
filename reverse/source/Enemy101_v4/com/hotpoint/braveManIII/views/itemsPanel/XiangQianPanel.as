package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.repository.probability.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import src.*;
   
   public class XiangQianPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var xqp:XiangQianPanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var clickNum:Number;
      
      public static var equip:Equip;
      
      public static var gem:Gem;
      
      public static var oldNum:Number;
      
      public static var xqPanel:MovieClip = new XQShow();
      
      public static var bagType:Number = 1;
      
      public static var selbool:Boolean = false;
      
      public static var isPOne:Boolean = true;
      
      public function XiangQianPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(xqPanel);
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         if(xqp == null)
         {
            xqp = new XiangQianPanel();
         }
         Main.stopXX = true;
         xqp.x = 50;
         xqp.y = 0;
         isPOne = true;
         addListenerP1();
         if(Main.P1P2)
         {
            xqPanel["bagOne"].visible = true;
            xqPanel["bagTwo"].visible = true;
         }
         Main._stage.addChild(xqp);
         xqp.visible = true;
      }
      
      public static function close() : void
      {
         xqPanel["xuanze"].gotoAndStop(1);
         isPOne = true;
         bagType = 1;
         gem = null;
         equip = null;
         twoFalse();
         selbool = false;
         if(xqp == null)
         {
            xqp = new XiangQianPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         xqp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         isxqOK();
         xqPanel["bagOne"].isClick = true;
         xqPanel["s1_mc"].stop();
         xqPanel["s2_mc"].stop();
         xqPanel["gold"].text = Main.player1.getGold();
         xqPanel["usegold"].text = "";
         xqPanel["gemName"].text = "";
         xqPanel["equipName"].text = "";
         xqPanel["bagOne"].visible = false;
         xqPanel["bagTwo"].visible = false;
         xqPanel["xuanze"].mouseEnabled = false;
         xqPanel["isXQ"].visible = false;
         xqPanel["isXQ"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesXQ);
         xqPanel["isXQ"]["no_btn"].addEventListener(MouseEvent.CLICK,noXQ);
         xqPanel.addEventListener(BtnEvent.DO_CHANGE,bagListen);
         xqPanel["c1"].addEventListener(MouseEvent.CLICK,changeEquip);
         xqPanel["g1"].addEventListener(MouseEvent.CLICK,changeGem);
         xqPanel["xq_btn"].addEventListener(MouseEvent.CLICK,doXQ);
         xqPanel["close"].addEventListener(MouseEvent.CLICK,closexXQ);
         xqPanel["c1"].mouseChildren = false;
         xqPanel["c1"].addEventListener(MouseEvent.MOUSE_OVER,showE);
         xqPanel["c1"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         xqPanel["g1"].mouseChildren = false;
         xqPanel["g1"].addEventListener(MouseEvent.MOUSE_OVER,showG);
         xqPanel["g1"].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         for(var i:uint = 0; i < 24; i++)
         {
            xqPanel["e" + i].mouseChildren = false;
            xqPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            xqPanel["s" + i].mouseChildren = false;
            xqPanel["s" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["s" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         xqPanel["c1"].gotoAndStop(1);
         xqPanel["c1"].visible = false;
         xqPanel["g1"].visible = false;
         if(isPOne)
         {
            showEquipP1();
         }
         else
         {
            showEquipP2();
         }
         xqPanel["chose"].visible = false;
      }
      
      private static function showEquipP1() : *
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            xqPanel["e" + i].t_txt.text = "";
            if(Main.player1.getBag().getEquipFromBag(i) != null)
            {
               if(Main.player1.getBag().getEquipFromBag(i).getGrid() != -1)
               {
                  xqPanel["e" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
                  xqPanel["e" + i].visible = true;
               }
               else
               {
                  xqPanel["e" + i].visible = false;
               }
            }
            else
            {
               xqPanel["e" + i].visible = false;
            }
         }
         for(i = 0; i < 8; i++)
         {
            xqPanel["s" + i].t_txt.text = "";
            if(Main.player1.getEquipSlot().getEquipFromSlot(i) != null)
            {
               if(Main.player1.getEquipSlot().getEquipFromSlot(i).getGrid() != -1)
               {
                  xqPanel["s" + i].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
                  xqPanel["s" + i].visible = true;
               }
               else
               {
                  xqPanel["s" + i].visible = false;
               }
            }
            else
            {
               xqPanel["s" + i].visible = false;
            }
         }
      }
      
      private static function showEquipP2() : *
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            xqPanel["e" + i].t_txt.text = "";
            if(Main.player2.getBag().getEquipFromBag(i) != null)
            {
               if(Main.player2.getBag().getEquipFromBag(i).getGrid() != -1)
               {
                  xqPanel["e" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
                  xqPanel["e" + i].visible = true;
               }
               else
               {
                  xqPanel["e" + i].visible = false;
               }
            }
            else
            {
               xqPanel["e" + i].visible = false;
            }
         }
         for(i = 0; i < 8; i++)
         {
            xqPanel["s" + i].t_txt.text = "";
            if(Main.player2.getEquipSlot().getEquipFromSlot(i) != null)
            {
               if(Main.player2.getEquipSlot().getEquipFromSlot(i).getGrid() != -1)
               {
                  xqPanel["s" + i].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
                  xqPanel["s" + i].visible = true;
               }
               else
               {
                  xqPanel["s" + i].visible = false;
               }
            }
            else
            {
               xqPanel["s" + i].visible = false;
            }
         }
      }
      
      private static function showGemP1() : *
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            xqPanel["e" + i].t_txt.text = "";
            if(Main.player1.getBag().getGemFromBag(i) != null)
            {
               if(Main.player1.getBag().getGemFromBag(i).getType() == 3)
               {
                  xqPanel["e" + i].gotoAndStop(Main.player1.getBag().getGemFromBag(i).getFrame());
                  xqPanel["e" + i].visible = true;
                  if(Main.player1.getBag().getGemFromBag(i).getIsPile() == true)
                  {
                     xqPanel["e" + i].t_txt.text = Main.player1.getBag().getGemFromBag(i).getTimes();
                  }
               }
               else
               {
                  xqPanel["e" + i].visible = false;
               }
            }
            else
            {
               xqPanel["e" + i].visible = false;
            }
         }
         for(i = 0; i < 8; i++)
         {
            xqPanel["s" + i].visible = false;
         }
      }
      
      private static function showGemP2() : *
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            xqPanel["e" + i].t_txt.text = "";
            if(Main.player2.getBag().getGemFromBag(i) != null)
            {
               if(Main.player2.getBag().getGemFromBag(i).getType() == 3)
               {
                  xqPanel["e" + i].gotoAndStop(Main.player2.getBag().getGemFromBag(i).getFrame());
                  xqPanel["e" + i].visible = true;
                  if(Main.player2.getBag().getGemFromBag(i).getIsPile() == true)
                  {
                     xqPanel["e" + i].t_txt.text = Main.player2.getBag().getGemFromBag(i).getTimes();
                  }
               }
               else
               {
                  xqPanel["e" + i].visible = false;
               }
            }
            else
            {
               xqPanel["e" + i].visible = false;
            }
         }
         for(i = 0; i < 8; i++)
         {
            xqPanel["s" + i].visible = false;
         }
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         xqPanel["c1"].removeEventListener(MouseEvent.CLICK,changeEquip);
         xqPanel["g1"].removeEventListener(MouseEvent.CLICK,changeGem);
         xqPanel.removeEventListener(BtnEvent.DO_CHANGE,bagListen);
         xqPanel["close"].removeEventListener(MouseEvent.CLICK,closeXQ);
         xqPanel["c1"].removeEventListener(MouseEvent.MOUSE_OVER,showE);
         xqPanel["c1"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         xqPanel["g1"].removeEventListener(MouseEvent.MOUSE_OVER,showG);
         xqPanel["g1"].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
         for(i = 0; i < 24; i++)
         {
            xqPanel["e" + i].mouseChildren = false;
            xqPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            xqPanel["s" + i].mouseChildren = false;
            xqPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            xqPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            xqPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
      }
      
      public static function closeXQ(e:*) : *
      {
         close();
      }
      
      private static function showE(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         xqPanel.addChild(itemsTooltip);
         if(overobj.name == "c1")
         {
            if(equip)
            {
               itemsTooltip.equipTooltip(equip);
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = xqPanel.mouseX + 10;
         itemsTooltip.y = xqPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function showG(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         xqPanel.addChild(itemsTooltip);
         if(overobj.name == "g1")
         {
            if(gem)
            {
               itemsTooltip.gemTooltip(gem);
            }
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = xqPanel.mouseX + 10;
         itemsTooltip.y = xqPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         xqPanel.addChild(itemsTooltip);
         var overNum:uint = uint(overobj.name.substr(1,2));
         var str:String = overobj.name.substr(0,1);
         if(isPOne)
         {
            if(bagType == 1)
            {
               if(str == "e")
               {
                  if(Main.player1.getBag().getEquipFromBag(overNum) != null)
                  {
                     itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(overNum),1);
                  }
               }
               else if(str == "s")
               {
                  itemsTooltip.slotTooltip(overNum,Main.player1.getEquipSlot());
               }
            }
            else if(str == "e")
            {
               itemsTooltip.gemTooltip(Main.player1.getBag().getGemFromBag(overNum),1);
            }
         }
         else if(bagType == 1)
         {
            if(str == "e")
            {
               if(Main.player2.getBag().getEquipFromBag(overNum) != null)
               {
                  itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(overNum),2);
               }
            }
            else if(str == "s")
            {
               itemsTooltip.slotTooltip(overNum,Main.player2.getEquipSlot());
            }
         }
         else if(str == "e")
         {
            itemsTooltip.gemTooltip(Main.player2.getBag().getGemFromBag(overNum),2);
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = xqPanel.mouseX + 10;
         itemsTooltip.y = xqPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      public static function twoFalse() : void
      {
         xqPanel["bagTwo"].isClick = false;
         xqPanel["bagOne"].isClick = false;
      }
      
      private static function bagListen(e:BtnEvent) : void
      {
         var btn:MovieClip = e.target as MovieClip;
         xqPanel["chose"].visible = false;
         switch(btn.name)
         {
            case "bagOne":
               isPOne = true;
               bagType = 1;
               twoFalse();
               equip = null;
               gem = null;
               xqPanel["c1"].visible = false;
               xqPanel["g1"].visible = false;
               xqPanel["equipName"].text = "";
               xqPanel["gemName"].text = "";
               xqPanel["bagOne"].isClick = true;
               xqPanel["gold"].text = Main.player1.getGold();
               showEquipP1();
               break;
            case "bagTwo":
               twoFalse();
               bagType = 1;
               isPOne = false;
               equip = null;
               gem = null;
               xqPanel["c1"].visible = false;
               xqPanel["g1"].visible = false;
               xqPanel["equipName"].text = "";
               xqPanel["gemName"].text = "";
               xqPanel["bagTwo"].isClick = true;
               xqPanel["gold"].text = Main.player2.getGold();
               showEquipP2();
         }
      }
      
      private static function changeEquip(e:*) : *
      {
         xqPanel["chose"].visible = false;
         if(isPOne)
         {
            showEquipP1();
            xqPanel["xuanze"].gotoAndStop(1);
         }
         else
         {
            showEquipP2();
            xqPanel["xuanze"].gotoAndStop(1);
         }
         bagType = 1;
         xqPanel["c1"].visible = false;
         xqPanel["equipName"].text = "";
         xqPanel["usegold"].text = "";
         equip = null;
         isxqOK();
      }
      
      private static function changeGem(e:*) : *
      {
         xqPanel["chose"].visible = false;
         xqPanel["g1"].visible = false;
         xqPanel["gemName"].text = "";
         gem = null;
         isxqOK();
      }
      
      private static function isxqOK() : *
      {
         if(Boolean(equip) && Boolean(gem))
         {
            xqPanel["xq_btn"].visible = true;
         }
         else
         {
            xqPanel["xq_btn"].visible = false;
         }
      }
      
      private static function xiangQian() : *
      {
         xqPanel["xq_btn"].visible = true;
         if(Boolean(equip) && Boolean(gem))
         {
            if(isPOne)
            {
               if(Main.player1.getGold() < int(xqPanel["usegold"].text))
               {
                  ShortTip.open(16);
                  return;
               }
               equip.setInGem(gem);
               Main.player1.getBag().delGem(oldNum,1);
               Main.player1.payGold(int(xqPanel["usegold"].text));
               xqPanel["gold"].text = Main.player1.getGold();
               showEquipP1();
            }
            else
            {
               if(Main.player2.getGold() < int(xqPanel["usegold"].text))
               {
                  ShortTip.open(16);
                  return;
               }
               Main.player2.payGold(int(xqPanel["usegold"].text));
               equip.setInGem(gem);
               Main.player2.getBag().delGem(oldNum,1);
               xqPanel["gold"].text = Main.player2.getGold();
               showEquipP2();
            }
            xqPanel["usegold"].text = "";
            xqPanel["equipName"].text = "";
            xqPanel["gemName"].text = "";
            equip = null;
            gem = null;
            bagType = 1;
            xqPanel["c1"].visible = false;
            xqPanel["g1"].visible = false;
            ShortTip.open(2);
         }
         else
         {
            ShortTip.open(4);
         }
      }
      
      private static function doXQ(e:*) : *
      {
         xqPanel["chose"].visible = false;
         if(equip)
         {
            if(equip.getGrid() == 0)
            {
               xqPanel["isXQ"].visible = true;
            }
            else
            {
               xqPanel["s1_mc"].gotoAndPlay(1);
               xqPanel["s2_mc"].gotoAndPlay(1);
               xqPanel["xq_btn"].visible = false;
               setTimeout(xiangQian,2800);
            }
         }
      }
      
      private static function yesXQ(e:*) : *
      {
         xqPanel["s1_mc"].gotoAndPlay(1);
         xqPanel["s2_mc"].gotoAndPlay(1);
         xqPanel["xq_btn"].visible = false;
         setTimeout(xiangQian,2800);
         xqPanel["isXQ"].visible = false;
      }
      
      private static function noXQ(e:*) : *
      {
         xqPanel["isXQ"].visible = false;
      }
      
      private static function closexXQ(e:*) : *
      {
         close();
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(e:MouseEvent) : void
      {
         selbool = true;
         clickObj = e.target as MovieClip;
         xqPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         if(isPOne)
         {
            if(bagType == 1)
            {
               if(nameStr == "e")
               {
                  equip = Main.player1.getBag().getEquipFromBag(clickNum);
               }
               else
               {
                  equip = Main.player1.getEquipSlot().getEquipFromSlot(clickNum);
               }
               xqPanel["usegold"].text = GoldFactory.getMosaicGold(equip.getDropLevel());
               xqPanel["c1"].gotoAndStop(clickObj.currentFrame);
               xqPanel["c1"].visible = true;
               xqPanel["equipName"].text = equip.getName();
               setEquipColor(equip);
               showGemP1();
               xqPanel["xuanze"].gotoAndStop(2);
               bagType = 2;
            }
            else
            {
               if(nameStr == "e")
               {
                  oldNum = clickNum;
                  gem = Main.player1.getBag().getGemFromBag(clickNum);
                  xqPanel["g1"].gotoAndStop(clickObj.currentFrame);
                  xqPanel["g1"].visible = true;
                  xqPanel["gemName"].text = gem.getName();
                  setGemColor(gem);
               }
               xqPanel["chose"].visible = true;
            }
         }
         else if(bagType == 1)
         {
            if(nameStr == "e")
            {
               equip = Main.player2.getBag().getEquipFromBag(clickNum);
            }
            else
            {
               equip = Main.player2.getEquipSlot().getEquipFromSlot(clickNum);
            }
            xqPanel["usegold"].text = GoldFactory.getMosaicGold(equip.getDropLevel());
            xqPanel["c1"].gotoAndStop(clickObj.currentFrame);
            xqPanel["c1"].visible = true;
            xqPanel["equipName"].text = equip.getName();
            setEquipColor(equip);
            showGemP2();
            xqPanel["xuanze"].gotoAndStop(2);
            bagType = 2;
         }
         else
         {
            if(nameStr == "e")
            {
               oldNum = clickNum;
               gem = Main.player2.getBag().getGemFromBag(clickNum);
               xqPanel["g1"].gotoAndStop(clickObj.currentFrame);
               xqPanel["g1"].visible = true;
               xqPanel["gemName"].text = gem.getName();
               setGemColor(gem);
            }
            xqPanel["chose"].visible = true;
         }
         isxqOK();
      }
      
      private static function setGemColor(gem:Gem) : *
      {
         if(gem.getColor() == 1)
         {
            ColorX(xqPanel["gemName"],"0xffffff");
         }
         if(gem.getColor() == 2)
         {
            ColorX(xqPanel["gemName"],"0x0066ff");
         }
         if(gem.getColor() == 3)
         {
            ColorX(xqPanel["gemName"],"0xFF33FF");
         }
      }
      
      private static function setEquipColor(equip:Equip) : *
      {
         if(equip.getColor() == 1)
         {
            ColorX(xqPanel["equipName"],"0xffffff");
         }
         if(equip.getColor() == 2)
         {
            ColorX(xqPanel["equipName"],"0x0066ff");
         }
         if(equip.getColor() == 3)
         {
            ColorX(xqPanel["equipName"],"0xFF33FF");
         }
         if(equip.getColor() == 4)
         {
            ColorX(xqPanel["equipName"],"0xFF9900");
         }
         if(equip.getColor() == 5)
         {
            ColorX(xqPanel["equipName"],"0xFF9900");
         }
      }
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
   }
}

