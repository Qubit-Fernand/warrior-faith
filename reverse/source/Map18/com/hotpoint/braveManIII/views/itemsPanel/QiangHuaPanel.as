package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class QiangHuaPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var qhp:QiangHuaPanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var clickNum:Number;
      
      public static var starNum:Number;
      
      public static var oldNum:Number;
      
      public static var qhPanel:MovieClip = new QHShow();
      
      public static var selbool:Boolean = false;
      
      public static var isPOne:Boolean = true;
      
      public function QiangHuaPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(qhPanel);
      }
      
      public static function open(pp:Boolean, num:int) : void
      {
         Main.allClosePanel();
         oldNum = num;
         if(qhp == null)
         {
            qhp = new QiangHuaPanel();
         }
         Main.stopXX = true;
         qhp.x = 50;
         qhp.y = 0;
         isPOne = pp;
         addListenerP1();
         Main._stage.addChild(qhp);
         qhp.visible = true;
      }
      
      public static function close() : void
      {
         selbool = false;
         if(qhp == null)
         {
            qhp = new QiangHuaPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         qhp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         qhPanel["isQC"].visible = false;
         qhPanel["isQC"]["yesQC"].addEventListener(MouseEvent.CLICK,yesQC);
         qhPanel["isQC"]["noQC"].addEventListener(MouseEvent.CLICK,noQC);
         qhPanel["qc_btn"].addEventListener(MouseEvent.CLICK,doQH);
         qhPanel["close"].addEventListener(MouseEvent.CLICK,closeQH);
         for(i = 0; i < 24; i++)
         {
            qhPanel["e" + i].mouseChildren = false;
            qhPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            qhPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            qhPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            qhPanel["s" + i].mouseChildren = false;
            qhPanel["s" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            qhPanel["s" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            qhPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         qhPanel["select"].gotoAndStop(1);
         qhPanel["select"].visible = false;
         if(isPOne)
         {
            for(i = 0; i < 24; i++)
            {
               qhPanel["e" + i].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player1.getBag().getEquipFromBag(i).getReinforceLevel() > 0)
                  {
                     qhPanel["e" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
                     qhPanel["e" + i].visible = true;
                  }
                  else
                  {
                     qhPanel["e" + i].visible = false;
                  }
               }
               else
               {
                  qhPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               qhPanel["s" + i].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  if(Main.player1.getEquipSlot().getEquipFromSlot(i).getReinforceLevel() > 0)
                  {
                     qhPanel["s" + i].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
                     qhPanel["s" + i].visible = true;
                  }
                  else
                  {
                     qhPanel["s" + i].visible = false;
                  }
               }
               else
               {
                  qhPanel["s" + i].visible = false;
               }
            }
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               qhPanel["e" + i].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(i) != null)
               {
                  if(Main.player2.getBag().getEquipFromBag(i).getReinforceLevel() > 0)
                  {
                     qhPanel["e" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
                     qhPanel["e" + i].visible = true;
                  }
                  else
                  {
                     qhPanel["e" + i].visible = false;
                  }
               }
               else
               {
                  qhPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               qhPanel["s" + i].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  if(Main.player2.getEquipSlot().getEquipFromSlot(i).getReinforceLevel() > 0)
                  {
                     qhPanel["s" + i].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
                     qhPanel["s" + i].visible = true;
                  }
                  else
                  {
                     qhPanel["s" + i].visible = false;
                  }
               }
               else
               {
                  qhPanel["s" + i].visible = false;
               }
            }
         }
         qhPanel["chose"].visible = false;
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         qhPanel["close"].removeEventListener(MouseEvent.CLICK,closeQH);
         qhPanel["qc_btn"].removeEventListener(MouseEvent.CLICK,doQH);
         for(i = 0; i < 24; i++)
         {
            qhPanel["e" + i].mouseChildren = false;
            qhPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            qhPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            qhPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            qhPanel["s" + i].mouseChildren = false;
            qhPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            qhPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            qhPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
      }
      
      public static function closeQH(e:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         qhPanel.addChild(itemsTooltip);
         var overNum:uint = uint(overobj.name.substr(1,2));
         var str:String = overobj.name.substr(0,1);
         if(isPOne)
         {
            if(str == "e")
            {
               if(Main.player1.getBag().getEquipFromBag(overNum) != null)
               {
                  itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(overNum),1);
               }
            }
            else
            {
               itemsTooltip.slotTooltip(overNum,Main.player1.getEquipSlot());
            }
         }
         else if(str == "e")
         {
            if(Main.player2.getBag().getEquipFromBag(overNum) != null)
            {
               itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(overNum),2);
            }
         }
         else
         {
            itemsTooltip.slotTooltip(overNum,Main.player2.getEquipSlot());
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = qhPanel.mouseX + 10;
         itemsTooltip.y = qhPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function yesQC(e:*) : *
      {
         if(selbool == false)
         {
            return;
         }
         if(isPOne)
         {
            if(nameStr == "e")
            {
               Main.player1.getBag().getEquipFromBag(clickNum).reinforceClear();
            }
            else
            {
               Main.player1.getEquipSlot().getEquipFromSlot(clickNum).reinforceClear();
            }
            Main.player1.getBag().delOtherobj(oldNum,1);
         }
         else
         {
            if(nameStr == "e")
            {
               Main.player2.getBag().getEquipFromBag(clickNum).reinforceClear();
            }
            else
            {
               Main.player2.getEquipSlot().getEquipFromSlot(clickNum).reinforceClear();
            }
            Main.player2.getBag().delOtherobj(oldNum,1);
         }
         qhPanel["isQC"].visible = false;
         ShortTip.open(35);
         close();
      }
      
      private static function noQC(e:*) : *
      {
         qhPanel["isQC"].visible = false;
      }
      
      private static function doQH(e:*) : *
      {
         qhPanel["isQC"].visible = true;
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(e:MouseEvent) : void
      {
         selbool = true;
         clickObj = e.target as MovieClip;
         qhPanel["chose"].visible = true;
         qhPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         qhPanel["select"].gotoAndStop(clickObj.currentFrame);
         qhPanel["select"].visible = true;
      }
   }
}

