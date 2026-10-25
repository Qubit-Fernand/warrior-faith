package src.Skin
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class Boss81 extends EnemySkin
   {
      
      public static var red:int = 0;
      
      public static var blue:int = 0;
      
      public static var benti:Boolean = true;
      
      private var hongshuijing:MovieClip = new 红水晶();
      
      private var lanshuijing:MovieClip = new 蓝水晶();
      
      internal var e1:Enemy;
      
      internal var e2:Enemy;
      
      public function Boss81()
      {
         super();
         GameData.过关条件 = 1;
         Play_Interface.BossLifeYN = true;
         e1 = new Enemy(5001);
         Main.world.moveChild_Enemy.addChild(e1);
         e1.x = 601;
         e2 = new Enemy(5002);
         e2.x = 501;
         Main.world.moveChild_Enemy.addChild(e2);
         red = 0;
         blue = 0;
         addEventListener(Event.ENTER_FRAME,hexin);
         addEventListener(Event.ENTER_FRAME,shuijing);
      }
      
      internal function shuijing(e:*) : *
      {
         if(red <= 0)
         {
            hongshuijing.gotoAndStop(1);
         }
         else if(red == 1)
         {
            hongshuijing.gotoAndStop(2);
         }
         else if(red == 2)
         {
            hongshuijing.gotoAndStop(3);
         }
         else if(red >= 3)
         {
            hongshuijing.gotoAndStop(4);
         }
         if(blue <= 0)
         {
            lanshuijing.gotoAndStop(1);
         }
         else if(blue == 1)
         {
            lanshuijing.gotoAndStop(2);
         }
         else if(blue == 2)
         {
            lanshuijing.gotoAndStop(3);
         }
         else if(blue >= 3)
         {
            lanshuijing.gotoAndStop(4);
         }
      }
      
      internal function hexin(e:*) : *
      {
         var e3:Enemy = null;
         if(Enemy.All.length <= 1)
         {
            e3 = new Enemy(5004);
            e3.x = 551;
            e3.y = 525;
            Main.world.moveChild_Enemy.addChild(e3);
            removeEventListener(Event.ENTER_FRAME,hexin);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(this.parent)
         {
            Play_Interface.bossIS = this.parent;
            this.parent.addChild(hongshuijing);
            hongshuijing.x = -500;
            this.parent.addChild(lanshuijing);
            lanshuijing.x = 500;
            e1.x = 601;
            e2.x = 501;
            this.parent.x = 551;
         }
      }
      
      override public function GoTo(str:String, timeX:int = 0) : *
      {
         var e1:Enemy = null;
         var e2:Enemy = null;
         var e3:Enemy = null;
         var e4:Enemy = null;
         var e5:Enemy = null;
         var e6:Enemy = null;
         var i:int = 0;
         otherGoTo(str);
         if((str == "攻击1" || str == "攻击2") && (!Boss81.benti || !Boss81you.youbian || !Boss81zuo.zuobian))
         {
            return;
         }
         if(str == "攻击2")
         {
            e1 = new Enemy(5006);
            e2 = new Enemy(5006);
            e3 = new Enemy(5006);
            e4 = new Enemy(5005);
            e5 = new Enemy(5005);
            e6 = new Enemy(5005);
            Main.world.moveChild_Enemy.addChild(e1);
            Main.world.moveChild_Enemy.addChild(e2);
            Main.world.moveChild_Enemy.addChild(e3);
            Main.world.moveChild_Enemy.addChild(e4);
            Main.world.moveChild_Enemy.addChild(e5);
            Main.world.moveChild_Enemy.addChild(e6);
            e1.x = Math.random() * 1000;
            e2.x = Math.random() * 1000;
            e3.x = Math.random() * 1000;
            e4.x = Math.random() * 1000;
            e5.x = Math.random() * 1000;
            e6.x = Math.random() * 1000;
            for(i = 0; i < e1.attack_TimeNum.length; i++)
            {
               e1.attack_TimeNum[i] = 0;
            }
            for(i = 0; i < e2.attack_TimeNum.length; i++)
            {
               e2.attack_TimeNum[i] = 0;
            }
            for(i = 0; i < e3.attack_TimeNum.length; i++)
            {
               e3.attack_TimeNum[i] = 0;
            }
            for(i = 0; i < e4.attack_TimeNum.length; i++)
            {
               e4.attack_TimeNum[i] = 0;
            }
            for(i = 0; i < e5.attack_TimeNum.length; i++)
            {
               e5.attack_TimeNum[i] = 0;
            }
            for(i = 0; i < e6.attack_TimeNum.length; i++)
            {
               e6.attack_TimeNum[i] = 0;
            }
         }
         if(str == "死亡")
         {
            red = 0;
            blue = 0;
         }
         if(str == "死亡" && runType != str)
         {
            runType = "死亡";
            gotoAndPlay(runType);
            return;
         }
         if(str == "被打")
         {
            runType = str;
            runOver = false;
            stopRun = false;
            gotoAndPlay(runType);
         }
         if((runOver || stopRun) && runType != str)
         {
            runType = str;
            runOver = false;
            gotoAndPlay(runType);
            frame = 0;
         }
         continuousTime = timeX;
      }
      
      override public function onENTER_FRAME(e:*) : *
      {
         if(this.currentFrame == this.totalFrames)
         {
            stop();
            (this.parent as Enemy).Dead();
            return;
         }
         if(runType == "runType" || runType == "攻击2")
         {
            benti = false;
         }
         else
         {
            benti = true;
         }
         if(continuousTime > 0)
         {
            --continuousTime;
         }
         else if(runType == "被打")
         {
            GoTo("站立");
         }
         GoToPlay();
      }
   }
}

