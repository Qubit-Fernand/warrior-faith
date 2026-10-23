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
         var i:uint = 0;
         for(i = 0; i <= 2; i++)
         {
            if(Boolean(Main.player1) && Boolean(Main.player1.isTransfer(i)))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function tbo2() : Boolean
      {
         var i:uint = 0;
         for(i = 0; i <= 2; i++)
         {
            if(Boolean(Main.player2) && Boolean(Main.player2.isTransfer(i)))
            {
               return true;
            }
         }
         return false;
      }
      
      public static function open() : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
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
         Main.stopXX = false;
         if(SetTransferPanel._instance == null)
         {
            SetTransferPanel._instance = new SetTransferPanel();
         }
         SetTransferPanel._instance.visible = false;
      }
      
      private function kkk(arr:Array) : void
      {
         for(i = 0; i < arr.length; ++i)
         {
            this["b_" + i].gotoAndStop(arr[i] + 1);
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
         var arr:Array = null;
         var zy1:Array = null;
         var i:uint = 0;
         arr = [];
         zy1 = Main.player1.getPickSkill();
         for(i = 0; i < zy1.length; i++)
         {
            if(zy1[i])
            {
               arr.push(i);
            }
         }
         return arr;
      }
      
      private function current(mc:MovieClip) : void
      {
         if(mc.currentFrame == 1)
         {
         }
         if(mc.currentFrame == 2)
         {
         }
         if(mc.currentFrame == 3)
         {
         }
         xxx = mc.currentFrame;
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
         var arr:Array = null;
         var zy2:Array = null;
         var i:uint = 0;
         arr = [];
         zy2 = Main.player2.getPickSkill();
         for(i = 0; i < zy2.length; i++)
         {
            if(zy2[i])
            {
               arr.push(i);
            }
         }
         return arr;
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
      
      private function closeHanle(e:BtnEvent) : void
      {
         this.visible = false;
         close();
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
      
      private function clickHandle(e:BtnEvent) : void
      {
         var arr:Array = null;
         arr = [];
         switch(e.id)
         {
            case 1:
               stata = 1;
               xxx = 0;
               arr = pickSkill1();
               kkk(arr);
               break;
            case 2:
               stata = 2;
               xxx = 0;
               arr = pickSkill2();
               kkk(arr);
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
         var arr:Array = null;
         arr = [];
         if(Main.player2 == null)
         {
            arr = pickSkill1();
         }
         else if(Main.player2 != null)
         {
            if(tbo1())
            {
               arr = pickSkill2();
            }
            else if(tbo2())
            {
               arr = pickSkill1();
            }
            else if(!tbo1() && !tbo2())
            {
               if(Main.player1.getLevel() < 25)
               {
                  arr = pickSkill2();
               }
               else
               {
                  arr = pickSkill1();
               }
            }
         }
         kkk(arr);
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

