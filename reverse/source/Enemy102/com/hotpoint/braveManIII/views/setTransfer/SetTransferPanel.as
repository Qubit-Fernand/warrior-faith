package com.hotpoint.braveManIII.views.setTransfer
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import src.*;
   
   public class SetTransferPanel extends MovieClip
   {
      
      private static var _instance:SetTransferPanel;
      
      private var xxx:Number = 0;
      
      private var stata:Number = 1;
      
      public function SetTransferPanel()
      {
         super();
      }
      
      public static function tbo1() : Boolean
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ <= 2)
         {
            if(Boolean(Main.player1) && Boolean(Main.player1.isTransfer(_loc1_)))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public static function tbo2() : Boolean
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ <= 2)
         {
            if(Boolean(Main.player2) && Boolean(Main.player2.isTransfer(_loc1_)))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public static function open() : void
      {
         if(SetTransferPanel._instance == null)
         {
            SetTransferPanel._instance = new SetTransferPanel();
         }
         SetTransferPanel._instance.x = 320;
         SetTransferPanel._instance.y = 110;
         SetTransferPanel._instance.init();
         SetTransferPanel._instance.visible = true;
         Main._stage.addChild(SetTransferPanel._instance);
      }
      
      public static function close() : void
      {
         if(SetTransferPanel._instance == null)
         {
            SetTransferPanel._instance = new SetTransferPanel();
         }
         SetTransferPanel._instance.visible = false;
      }
      
      private function kkk(param1:Array) : void
      {
         i = 0;
         while(i < param1.length)
         {
            this["b_" + i].gotoAndStop(param1[i] + 1);
            ++i;
         }
      }
      
      public function init() : void
      {
         updataStata();
         p1orP2();
         initData();
         addBtnEvent();
         kk_mc.visible = false;
      }
      
      private function addBtnEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,closeHanle);
      }
      
      private function pickSkill1() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         _loc1_ = [];
         _loc2_ = Main.player1.getPickSkill();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_])
            {
               _loc1_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function current(param1:MovieClip) : void
      {
         if(param1.currentFrame == 1)
         {
         }
         if(param1.currentFrame == 2)
         {
         }
         if(param1.currentFrame == 3)
         {
         }
         xxx = param1.currentFrame;
         trace(xxx + "xxx");
         this.kk_mc.visible = true;
      }
      
      private function okPanel() : void
      {
         this.visible = false;
         if(xxx != 0)
         {
            if(stata == 1)
            {
               if(Main.player1.getBag().fallQusetBag(84115))
               {
                  if(Main.player1.getGold() > 8000)
                  {
                     trace("p1转职成功");
                     TransferOkPanel.open();
                     Main.player1.payGold(8000);
                     Main.player1.setTransfer(xxx - 1);
                     Main.player1.getBag().clearQuest(84115);
                     gg();
                     Main.Save();
                  }
                  else
                  {
                     ShortTip.open(26);
                     trace("p1金币不足");
                  }
               }
               else
               {
                  ShortTip.open(26);
                  trace("物品不足");
               }
            }
            else if(stata == 2)
            {
               if(Main.player2.getBag().fallQusetBag(84115))
               {
                  if(Main.player2.getGold() > 8000)
                  {
                     trace("p2转职成功");
                     TransferOkPanel.open();
                     Main.player2.payGold(8000);
                     Main.player2.setTransfer(xxx - 1);
                     trace("转职后:" + tbo2());
                     Main.player2.getBag().clearQuest(84115);
                     gg();
                     Main.Save();
                  }
                  else
                  {
                     ShortTip.open(26);
                     trace("p2金币不足");
                  }
               }
               else
               {
                  ShortTip.open(26);
                  trace("p2物品不足");
               }
            }
         }
      }
      
      private function pickSkill2() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         _loc1_ = [];
         _loc2_ = Main.player2.getPickSkill();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_])
            {
               _loc1_.push(_loc3_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function p1orP2() : void
      {
         zhezhao1.visible = true;
         zhezhao2.visible = true;
         p1_btn.gotoAndStop(1);
         p2_btn.gotoAndStop(1);
         if(Main.player2 == null)
         {
            p2_btn.gotoAndStop(4);
         }
         if(!tbo1())
         {
            if(Main.player1.getLevel() >= 25)
            {
               zhezhao1.visible = false;
            }
            else
            {
               p1_btn.gotoAndStop(4);
            }
         }
         else
         {
            p1_btn.gotoAndStop(4);
         }
         if(Main.player2 != null)
         {
            if(!tbo2())
            {
               if(Main.player2.getLevel() >= 25)
               {
                  zhezhao2.visible = false;
               }
               else
               {
                  p2_btn.gotoAndStop(4);
               }
            }
            else
            {
               p2_btn.gotoAndStop(4);
            }
         }
      }
      
      private function closeHanle(param1:BtnEvent) : void
      {
         this.visible = false;
      }
      
      private function updataStata() : void
      {
         if(Main.player_2 != null)
         {
            if(tbo1() || Main.player1.getLevel() < 25)
            {
               stata = 2;
            }
            else if(tbo2() || Main.player2.getLevel() < 25)
            {
               stata = 1;
            }
         }
         else
         {
            stata = 1;
         }
         trace("stata:" + stata);
      }
      
      private function clickHandle(param1:BtnEvent) : void
      {
         var _loc2_:Array = null;
         _loc2_ = [];
         switch(param1.id)
         {
            case 1:
               stata = 1;
               xxx = 0;
               _loc2_ = pickSkill1();
               kkk(_loc2_);
               break;
            case 2:
               stata = 2;
               xxx = 0;
               _loc2_ = pickSkill2();
               kkk(_loc2_);
               break;
            case 3:
               current(MovieClip(b_0));
               break;
            case 4:
               current(MovieClip(b_1));
               break;
            case 5:
               okPanel();
         }
      }
      
      private function initData() : void
      {
         var _loc1_:Array = null;
         _loc1_ = [];
         if(Main.player2 == null)
         {
            _loc1_ = pickSkill1();
         }
         else if(Main.player2 != null)
         {
            if(tbo1())
            {
               _loc1_ = pickSkill2();
            }
            else if(tbo2())
            {
               _loc1_ = pickSkill1();
            }
            else if(!tbo1() && !tbo2())
            {
               if(Main.player1.getLevel() < 25)
               {
                  _loc1_ = pickSkill2();
               }
               else
               {
                  _loc1_ = pickSkill1();
               }
            }
         }
         kkk(_loc1_);
      }
      
      private function gg() : void
      {
         if(Main.player2 == null)
         {
            if(tbo1())
            {
               trace("p1转职");
               Main.world["转职"].visible = false;
            }
         }
         else if(Main.player2 != null)
         {
            if(tbo1() && tbo2())
            {
               Main.world["转职"].visible = false;
            }
            else if(tbo1() && !tbo2())
            {
               if(Main.player2.getLevel() < 25)
               {
                  Main.world["转职"].visible = false;
               }
            }
            else if(tbo2() && !tbo1())
            {
               if(Main.player1.getLevel() < 25)
               {
                  Main.world["转职"].visible = false;
               }
            }
         }
      }
   }
}

