package com.hotpoint.braveManIII.views.setTransfer
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.views.makePanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import src.*;
   
   public class SetTransferPanel extends MovieClip
   {
      
      private static var _instance:SetTransferPanel;
      
      private var stata:Number = 1;
      
      private var xxx:Number = 0;
      
      public function SetTransferPanel()
      {
         super();
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
      
      public static function tbo1() : Boolean
      {
         for(var i:uint = 0; i <= 2; i++)
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
         for(var i:uint = 0; i <= 2; i++)
         {
            if(Boolean(Main.player2) && Boolean(Main.player2.isTransfer(i)))
            {
               return true;
            }
         }
         return false;
      }
      
      public function init() : void
      {
         this.updataStata();
         this.p1orP2();
         this.initData();
         this.addBtnEvent();
         kk_mc.visible = false;
      }
      
      private function initData() : void
      {
         var arr:Array = [];
         if(Main.player2 == null)
         {
            arr = this.pickSkill1();
         }
         else if(Main.player2 != null)
         {
            if(tbo1())
            {
               arr = this.pickSkill2();
            }
            else if(tbo2())
            {
               arr = this.pickSkill1();
            }
            else if(!tbo1() && !tbo2())
            {
               if(Main.player1.getLevel() < 25)
               {
                  arr = this.pickSkill2();
               }
               else
               {
                  arr = this.pickSkill1();
               }
            }
         }
         this.kkk(arr);
      }
      
      private function addBtnEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CLICK,this.clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,this.closeHanle);
         this.addEventListener(BtnEvent.DO_OVER,this.overHandle);
         this.addEventListener(BtnEvent.DO_OUT,this.outHandle);
      }
      
      private function overHandle(e:BtnEvent) : void
      {
         PropertyScreen.open(null,false,Main._stage.mouseX,Main._stage.mouseY,"打败神秘副本的BOSS 鳄鱼公爵 有几率掉落(修复第一块女神碎片后可开启该副本)");
      }
      
      private function outHandle(e:BtnEvent) : void
      {
         PropertyScreen.close();
      }
      
      private function closeHanle(e:BtnEvent) : void
      {
         this.visible = false;
         close();
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         var arr:Array = [];
         switch(e.id)
         {
            case 1:
               this.stata = 1;
               this.xxx = 0;
               arr = this.pickSkill1();
               this.kkk(arr);
               break;
            case 2:
               this.stata = 2;
               this.xxx = 0;
               arr = this.pickSkill2();
               this.kkk(arr);
               break;
            case 3:
               this.current(MovieClip(b_0));
               break;
            case 4:
               this.current(MovieClip(b_1));
               break;
            case 5:
               this.okPanel();
         }
      }
      
      private function okPanel() : void
      {
         this.visible = false;
         if(this.xxx != 0)
         {
            if(this.stata == 1)
            {
               if(Main.player1.getBag().fallQusetBag(84115))
               {
                  if(Main.player1.getGold() > 8000)
                  {
                     trace("p1转职成功");
                     TransferOkPanel.open();
                     Main.player1.payGold(8000);
                     Main.player1.setTransfer(this.xxx - 1);
                     Main.player1.getBag().clearQuest(84115);
                     this.gg();
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
            else if(this.stata == 2)
            {
               if(Main.player2.getBag().fallQusetBag(84115))
               {
                  if(Main.player2.getGold() > 8000)
                  {
                     trace("p2转职成功");
                     TransferOkPanel.open();
                     Main.player2.payGold(8000);
                     Main.player2.setTransfer(this.xxx - 1);
                     trace("转职后:" + tbo2());
                     Main.player2.getBag().clearQuest(84115);
                     this.gg();
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
      
      private function updataStata() : void
      {
         if(Main.player_2 != null)
         {
            if(tbo1() || Main.player1.getLevel() < 25)
            {
               this.stata = 2;
            }
            else if(tbo2() || Main.player2.getLevel() < 25)
            {
               this.stata = 1;
            }
            else if(!tbo1() || !tbo2())
            {
               this.stata = 1;
            }
         }
         else
         {
            this.stata = 1;
         }
         trace("stata:" + this.stata);
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
         this.xxx = mc.currentFrame;
         trace(this.xxx + "xxx");
         this.kk_mc.visible = true;
      }
      
      private function kkk(arr:Array) : void
      {
         for(i = 0; i < arr.length; ++i)
         {
            this["b_" + i].gotoAndStop(arr[i] + 1);
         }
      }
      
      private function pickSkill1() : Array
      {
         var arr:Array = [];
         var zy1:Array = Main.player1.getPickSkill();
         for(var i:uint = 0; i < zy1.length; i++)
         {
            if(zy1[i])
            {
               arr.push(i);
            }
         }
         return arr;
      }
      
      private function pickSkill2() : Array
      {
         var arr:Array = [];
         var zy2:Array = Main.player2.getPickSkill();
         for(var i:uint = 0; i < zy2.length; i++)
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
   }
}

