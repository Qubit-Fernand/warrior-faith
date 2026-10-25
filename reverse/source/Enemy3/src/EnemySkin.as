package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class EnemySkin extends MovieClip
   {
      
      public static var EnemySkinXml:XML = new XML();
      
      public var space:int;
      
      public var 硬直:Number;
      
      public var runTime:int;
      
      public var id:int;
      
      public var continuous:Boolean;
      
      public var stopRun:Boolean;
      
      public var attTimes:int;
      
      public var runX:int;
      
      public var runY:int;
      
      public var totalTime:int;
      
      public var hpX:int;
      
      public var gravity:int;
      
      public var 被攻击硬直:Number;
      
      public var frame:int;
      
      public var continuousTime:int;
      
      public var runType:String = "";
      
      public var numValue:int;
      
      public var type:int = 0;
      
      public var moveYN:Boolean;
      
      public var moveArr:Array = [];
      
      public var runOver:Boolean;
      
      public function EnemySkin()
      {
         super();
         GoTo("站立");
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function FindFrame() : *
      {
         var i:* = undefined;
         var name:String = null;
         var 名称:String = null;
         var frameX:String = null;
         var 帧标签:String = null;
         var 当前帧:int = 0;
         moveArr = null;
         for(i in EnemySkinXml.怪物攻击)
         {
            name = getQualifiedClassName(this);
            名称 = String(EnemySkinXml.怪物攻击[i].名称);
            frameX = this.currentLabel;
            帧标签 = String(EnemySkinXml.怪物攻击[i].帧标签);
            当前帧 = int(String(EnemySkinXml.怪物攻击[i].当前帧));
            if(name == 名称 && frameX == 帧标签)
            {
               continuous = false;
               stopRun = false;
               gravity = int(EnemySkinXml.怪物攻击[i].重力调整);
               moveArr = [int(EnemySkinXml.怪物攻击[i].移动参数.X),int(EnemySkinXml.怪物攻击[i].移动参数.Y),int(EnemySkinXml.怪物攻击[i].移动参数.持续)];
               hpX = int(EnemySkinXml.怪物攻击[i].伤害.hp) * this.parent.攻击力;
               runX = int(EnemySkinXml.怪物攻击[i].伤害.震退);
               runY = int(EnemySkinXml.怪物攻击[i].伤害.挑高);
               runTime = int(EnemySkinXml.怪物攻击[i].伤害.持续);
               硬直 = int(EnemySkinXml.怪物攻击[i].特效.硬直);
               被攻击硬直 = int(EnemySkinXml.怪物攻击[i].被攻击硬直);
               attTimes = int(EnemySkinXml.怪物攻击[i].特效.攻击次数);
               type = int(EnemySkinXml.怪物攻击[i].特效.类型);
               space = int(EnemySkinXml.怪物攻击[i].特效.间隔);
               totalTime = int(EnemySkinXml.怪物攻击[i].特效.总计时);
               numValue = int(EnemySkinXml.怪物攻击[i].特效.数值);
               return;
            }
         }
      }
      
      private function InitFrame() : *
      {
         continuous = true;
         stopRun = true;
         gravity = Enemy.EnemyXml.怪物[id].重力调整;
         被攻击硬直 = int(Enemy.EnemyXml.怪物[id].硬直);
      }
      
      public function Over() : *
      {
         this.gotoAndStop(1);
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function isRunOver() : *
      {
         if(this.currentLabel != runType)
         {
            runOver = true;
         }
         else
         {
            runOver = false;
         }
      }
      
      public function 震动(num:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(num);
         }
      }
      
      private function GoToPlay() : *
      {
         isRunOver();
         if(runOver)
         {
            if(continuous || continuousTime > 0)
            {
               gotoAndPlay(runType);
               runOver = false;
               frame = 0;
            }
            else
            {
               GoTo("站立");
            }
         }
         else
         {
            ++frame;
         }
         if(runType == "站立" || runType == "移动" || runType == "跳跃" || runType == "被打" || runType == "死亡")
         {
            InitFrame();
         }
         else
         {
            FindFrame();
         }
      }
      
      public function otherGoTo(str:String) : *
      {
      }
      
      public function GoTo(str:String, timeX:int = 0) : *
      {
         otherGoTo(str);
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
      
      public function onENTER_FRAME(e:*) : *
      {
         if(this.currentFrame == this.totalFrames)
         {
            stop();
            (this.parent as Enemy).Dead();
            return;
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

