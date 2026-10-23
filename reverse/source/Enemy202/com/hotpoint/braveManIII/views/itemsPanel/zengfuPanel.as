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
      
      public static function open(param1:Boolean, param2:String, param3:Number, param4:int) : void
      {
         Main.allClosePanel();
         skillId = param3;
         oldNum = param4;
         if(zfp == null)
         {
            zfp = new zengfuPanel();
         }
         Main.stopXX = true;
         zfp.x = 0;
         zfp.y = 0;
         isPOne = param1;
         zfPanel["zftxt"].text = param2;
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
         var _loc1_:uint = 0;
         zfPanel["isZF"]["yesZF"].addEventListener(MouseEvent.CLICK,yesZF);
         zfPanel["isZF"]["noZF"].addEventListener(MouseEvent.CLICK,noZF);
         zfPanel["zf_btn"].addEventListener(MouseEvent.CLICK,doZF);
         zfPanel["close"].addEventListener(MouseEvent.CLICK,closeZF);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            zfPanel["e" + _loc1_].mouseChildren = false;
            zfPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["e" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["e" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            zfPanel["s" + _loc1_].mouseChildren = false;
            zfPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["s" + _loc1_].addEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["s" + _loc1_].addEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         zfPanel["select"].gotoAndStop(1);
         zfPanel["select"].visible = false;
         if(isPOne)
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               zfPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player1.getBag().getEquipFromBag(_loc1_) != null)
               {
                  zfPanel["e" + _loc1_].gotoAndStop(Main.player1.getBag().getEquipFromBag(_loc1_).getFrame());
                  zfPanel["e" + _loc1_].visible = true;
               }
               else
               {
                  zfPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               zfPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_) != null)
               {
                  zfPanel["s" + _loc1_].gotoAndStop(Main.player1.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                  zfPanel["s" + _loc1_].visible = true;
               }
               else
               {
                  zfPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               zfPanel["e" + _loc1_].t_txt.text = "";
               if(Main.player2.getBag().getEquipFromBag(_loc1_) != null)
               {
                  zfPanel["e" + _loc1_].gotoAndStop(Main.player2.getBag().getEquipFromBag(_loc1_).getFrame());
                  zfPanel["e" + _loc1_].visible = true;
               }
               else
               {
                  zfPanel["e" + _loc1_].visible = false;
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 8)
            {
               zfPanel["s" + _loc1_].t_txt.text = "";
               if(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_) != null)
               {
                  zfPanel["s" + _loc1_].gotoAndStop(Main.player2.getEquipSlot().getEquipFromSlot(_loc1_).getFrame());
                  zfPanel["s" + _loc1_].visible = true;
               }
               else
               {
                  zfPanel["s" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         zfPanel["isZF"].visible = false;
         zfPanel["chose"].visible = false;
      }
      
      public static function removeListenerP1() : *
      {
         var _loc1_:uint = 0;
         zfPanel["isZF"]["yesZF"].removeEventListener(MouseEvent.CLICK,yesZF);
         zfPanel["isZF"]["noZF"].removeEventListener(MouseEvent.CLICK,noZF);
         zfPanel["close"].removeEventListener(MouseEvent.CLICK,closeZF);
         zfPanel["zf_btn"].removeEventListener(MouseEvent.CLICK,doZF);
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            zfPanel["e" + _loc1_].mouseChildren = false;
            zfPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["e" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["e" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            zfPanel["s" + _loc1_].mouseChildren = false;
            zfPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OVER,tooltipOpen);
            zfPanel["s" + _loc1_].removeEventListener(MouseEvent.MOUSE_OUT,tooltipClose);
            zfPanel["s" + _loc1_].removeEventListener(MouseEvent.CLICK,selected);
            _loc1_++;
         }
      }
      
      public static function closeZF(param1:*) : *
      {
         close();
      }
      
      private static function tooltipOpen(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         zfPanel.addChild(itemsTooltip);
         var _loc3_:uint = uint(_loc2_.name.substr(1,2));
         var _loc4_:String = _loc2_.name.substr(0,1);
         if(isPOne)
         {
            if(_loc4_ == "e")
            {
               if(Main.player1.getBag().getEquipFromBag(_loc3_) != null)
               {
                  itemsTooltip.equipTooltip(Main.player1.getBag().getEquipFromBag(_loc3_),1);
               }
            }
            else
            {
               itemsTooltip.slotTooltip(_loc3_,Main.player1.getEquipSlot());
            }
         }
         else if(_loc4_ == "e")
         {
            if(Main.player2.getBag().getEquipFromBag(_loc3_) != null)
            {
               itemsTooltip.equipTooltip(Main.player2.getBag().getEquipFromBag(_loc3_),2);
            }
         }
         else
         {
            itemsTooltip.slotTooltip(_loc3_,Main.player2.getEquipSlot());
         }
         itemsTooltip.visible = true;
         itemsTooltip.x = zfPanel.mouseX + 10;
         itemsTooltip.y = zfPanel.mouseY;
         itemsTooltip.setTooltipPoint();
      }
      
      private static function yesZF(param1:*) : *
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
      
      private static function noZF(param1:*) : *
      {
         zfPanel["isZF"].visible = false;
      }
      
      private static function doZF(param1:*) : *
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
                  AchData.setZfNum(1);
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
               AchData.setZfNum(1);
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
               AchData.setZfNum(2);
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
            AchData.setZfNum(2);
            close();
         }
         else
         {
            zfPanel["isZF"].visible = true;
         }
      }
      
      private static function tooltipClose(param1:*) : *
      {
         itemsTooltip.visible = false;
      }
      
      private static function selected(param1:MouseEvent) : void
      {
         clickObj = param1.target as MovieClip;
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

