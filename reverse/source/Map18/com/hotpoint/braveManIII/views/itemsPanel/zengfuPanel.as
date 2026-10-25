package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class zengfuPanel extends MovieClip
   {
      
      public static var itemsTooltip:ItemsTooltip;
      
      public static var zfp:zengfuPanel;
      
      public static var clickObj:MovieClip;
      
      private static var nameStr:String;
      
      public static var clickNum:Number;
      
      public static var skillId:Number;
      
      public static var oldNum:Number;
      
      public static var zfPanel:MovieClip = new ZFShow();
      
      public static var isPOne:Boolean = true;
      
      public function zengfuPanel()
      {
         super();
         itemsTooltip = new ItemsTooltip();
         itemsTooltip.visible = false;
         this.addChild(zfPanel);
      }
      
      public static function open(pp:Boolean, skStr:String, skId:Number, num:int) : void
      {
         Main.allClosePanel();
         skillId = skId;
         oldNum = num;
         if(zfp == null)
         {
            zfp = new zengfuPanel();
         }
         Main.stopXX = true;
         zfp.x = 0;
         zfp.y = 0;
         isPOne = pp;
         zfPanel["zftxt"].text = skStr;
         addListenerP1();
         Main._stage.addChild(zfp);
         zfp.visible = true;
      }
      
      public static function close() : void
      {
         if(zfp == null)
         {
            zfp = new zengfuPanel();
         }
         Main.stopXX = false;
         removeListenerP1();
         zfp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         var i:uint = 0;
         zfPanel["isZF"]["yesZF"].addEventListener(MouseEvent.CLICK,yesZF);
         zfPanel["isZF"]["noZF"].addEventListener(MouseEvent.CLICK,noZF);
         zfPanel["zf_btn"].addEventListener(MouseEvent.CLICK,doZF);
         zfPanel["close"].addEventListener(MouseEvent.CLICK,closeZF);
         for(i = 0; i < 24; i++)
         {
            zfPanel["e" + i].mouseChildren = false;
            zfPanel["e" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["e" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["e" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            zfPanel["s" + i].mouseChildren = false;
            zfPanel["s" + i].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["s" + i].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["s" + i].addEventListener(MouseEvent.CLICK,selected);
         }
         zfPanel["select"].gotoAndStop(1);
         zfPanel["select"].visible = false;
         if(isPOne)
         {
            for(i = 0; i < 24; i++)
            {
               zfPanel["e" + i].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(i) != null)
               {
                  zfPanel["e" + i].gotoAndStop(Main.player1.getBag().getEquipFromBag(i).getFrame());
                  zfPanel["e" + i].visible = true;
               }
               else
               {
                  zfPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               zfPanel["s" + i].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  zfPanel["s" + i].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(i).getFrame());
                  zfPanel["s" + i].visible = true;
               }
               else
               {
                  zfPanel["s" + i].visible = false;
               }
            }
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               zfPanel["e" + i].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(i) != null)
               {
                  zfPanel["e" + i].gotoAndStop(Main.player2.getBag().getEquipFromBag(i).getFrame());
                  zfPanel["e" + i].visible = true;
               }
               else
               {
                  zfPanel["e" + i].visible = false;
               }
            }
            for(i = 0; i < 8; i++)
            {
               zfPanel["s" + i].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(i) != null)
               {
                  zfPanel["s" + i].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(i).getFrame());
                  zfPanel["s" + i].visible = true;
               }
               else
               {
                  zfPanel["s" + i].visible = false;
               }
            }
         }
         zfPanel["isZF"].visible = false;
         zfPanel["chose"].visible = false;
      }
      
      public static function removeListenerP1() : *
      {
         var i:uint = 0;
         zfPanel["isZF"]["yesZF"].removeEventListener(MouseEvent.CLICK,yesZF);
         zfPanel["isZF"]["noZF"].removeEventListener(MouseEvent.CLICK,noZF);
         zfPanel["close"].removeEventListener(MouseEvent.CLICK,closeZF);
         zfPanel["zf_btn"].removeEventListener(MouseEvent.CLICK,doZF);
         for(i = 0; i < 24; i++)
         {
            zfPanel["e" + i].mouseChildren = false;
            zfPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["e" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["e" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
         for(i = 0; i < 8; i++)
         {
            zfPanel["s" + i].mouseChildren = false;
            zfPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["s" + i].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["s" + i].removeEventListener(MouseEvent.CLICK,selected);
         }
      }
      
      public static function closeZF(e:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(e:MouseEvent) : void
      {
         var overobj:MovieClip = e.target as MovieClip;
         zfPanel.addChild(itemsTooltip);
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
         itemsTooltip.x = zfPanel.mouseX + 10;
         itemsTooltip.y = zfPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function yesZF(e:*) : *
      {
         if(isPOne)
         {
            if(nameStr == "e")
            {
               Main.player1.getBag().getEquipFromBag(clickNum).setNewSkill(skillId);
            }
            else
            {
               Main.player1.getEquipSlot().getEquipFromSlot(clickNum).setNewSkill(skillId);
            }
            Main.player1.getBag().delGem(oldNum,1);
            AchData.setZfNum(1);
         }
         else
         {
            if(nameStr == "e")
            {
               Main.player2.getBag().getEquipFromBag(clickNum).setNewSkill(skillId);
            }
            else
            {
               Main.player2.getEquipSlot().getEquipFromSlot(clickNum).setNewSkill(skillId);
            }
            Main.player2.getBag().delGem(oldNum,1);
            AchData.setZfNum(2);
         }
         ShortTip.open(33);
         close();
      }
      
      private static function noZF(e:*) : *
      {
         zfPanel["isZF"].visible = false;
      }
      
      private static function doZF(e:*) : *
      {
         if(isPOne)
         {
            if(nameStr == "e")
            {
               if(Main.player1.getBag().getEquipFromBag(clickNum).getNewSkill() == 0)
               {
                  Main.player1.getBag().getEquipFromBag(clickNum).setNewSkill(skillId);
                  Main.player1.getBag().delGem(oldNum,1);
                  ShortTip.open(33);
                  close();
               }
               else
               {
                  zfPanel["isZF"].visible = true;
               }
            }
            else if(Main.player1.getEquipSlot().getEquipFromSlot(clickNum).getNewSkill() == 0)
            {
               Main.player1.getEquipSlot().getEquipFromSlot(clickNum).setNewSkill(skillId);
               Main.player1.getBag().delGem(oldNum,1);
               ShortTip.open(33);
               close();
            }
            else
            {
               zfPanel["isZF"].visible = true;
            }
         }
         else if(nameStr == "e")
         {
            if(Main.player2.getBag().getEquipFromBag(clickNum).getNewSkill() == 0)
            {
               Main.player2.getBag().getEquipFromBag(clickNum).setNewSkill(skillId);
               Main.player2.getBag().delGem(oldNum,1);
               ShortTip.open(33);
               close();
            }
            else
            {
               zfPanel["isZF"].visible = true;
            }
         }
         else if(Main.player2.getEquipSlot().getEquipFromSlot(clickNum).getNewSkill() == 0)
         {
            Main.player2.getEquipSlot().getEquipFromSlot(clickNum).setNewSkill(skillId);
            Main.player2.getBag().delGem(oldNum,1);
            ShortTip.open(33);
            close();
         }
         else
         {
            zfPanel["isZF"].visible = true;
         }
      }
      
      private static function tooltipClose(e:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(e:MouseEvent) : void
      {
         clickObj = e.target as MovieClip;
         zfPanel["chose"].visible = true;
         zfPanel["chose"].x = clickObj.x - 2;
         --clickObj.y;
         clickNum = uint(clickObj.name.substr(1,2));
         nameStr = clickObj.name.substr(0,1);
         zfPanel["select"].gotoAndStop(clickObj.currentFrame);
         zfPanel["select"].visible = true;
      }
   }
}

