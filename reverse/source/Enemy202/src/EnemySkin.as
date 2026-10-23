package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class EnemySkin extends MovieClip
   {
      
      public static var EnemySkinXmlArr:Array = new Array();
      
      public static var EnemySkinXml:XML = new XML();
      
      public var thisXML:XML = new XML();
      
      public var id:int;
      
      public var frame:int;
      
      public var runOver:Boolean;
      
      public var continuous:Boolean;
      
      public var stopRun:Boolean;
      
      public var gravity:int;
      
      public var moveYN:Boolean;
      
      public var continuousTime:int;
      
      public var hpX:int;
      
      public var runX:int;
      
      public var runY:int;
      
      public var runTime:int;
      
      public var 硬直:Number;
      
      public var 被攻击硬直:Number;
      
      public var attTimes:int;
      
      public var type:int = 0;
      
      public var space:int;
      
      public var totalTime:int;
      
      public var numValue:int;
      
      public var runType:String = "";
      
      public var moveArr:Array = [];
      
      public function EnemySkin()
      {
         super();
         this.GoTo("站立");
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function Over() : *
      {
         this.gotoAndStop(1);
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function boss14() : *
      {
      }
      
      public function onENTER_FRAME(param1:*) : *
      {
         this.boss14();
         if(this.currentFrame == this.totalFrames)
         {
            stop();
            (this.parent as Enemy).Dead();
            return;
         }
         if(this.continuousTime > 0)
         {
            --this.continuousTime;
         }
         else if(this.runType == "被打")
         {
            this.GoTo("站立");
         }
         this.GoToPlay();
      }
      
      private function GoToPlay() : *
      {
         this.isRunOver();
         if(this.runOver)
         {
            if(this.continuous || this.continuousTime > 0)
            {
               gotoAndPlay(this.runType);
               this.runOver = false;
               this.frame = 0;
            }
            else
            {
               this.GoTo("站立");
            }
         }
         else
         {
            ++this.frame;
         }
         if(this.runType == "站立" || this.runType == "移动" || this.runType == "跳跃" || this.runType == "被打" || this.runType == "死亡")
         {
            this.InitFrame();
         }
         else
         {
            this.FindFrame();
         }
      }
      
      private function InitFrame() : *
      {
         this.continuous = true;
         this.stopRun = true;
         this.gravity = Enemy.EnemyXml.怪物[this.id].重力调整;
         this.被攻击硬直 = (this.parent as Enemy).硬直.getValue();
      }
      
      private function FindFrame() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         this.moveArr = null;
         for(_loc1_ in EnemySkinXml.怪物攻击)
         {
            _loc2_ = getQualifiedClassName(this);
            _loc3_ = String(EnemySkinXml.怪物攻击[_loc1_].名称);
            _loc4_ = String(EnemySkinXml.怪物攻击[_loc1_].帧标签);
            _loc5_ = int(String(EnemySkinXml.怪物攻击[_loc1_].当前帧));
            if(_loc2_ == _loc3_ && this.runType == _loc4_ && this.frame == _loc5_)
            {
               this.continuous = false;
               this.stopRun = false;
               this.gravity = int(EnemySkinXml.怪物攻击[_loc1_].重力调整);
               this.moveArr = [int(EnemySkinXml.怪物攻击[_loc1_].移动参数.X),int(EnemySkinXml.怪物攻击[_loc1_].移动参数.Y),int(EnemySkinXml.怪物攻击[_loc1_].移动参数.持续)];
               this.hpX = int(EnemySkinXml.怪物攻击[_loc1_].伤害.hp) * this.parent.攻击力.getValue();
               this.runX = int(EnemySkinXml.怪物攻击[_loc1_].伤害.震退);
               this.runY = int(EnemySkinXml.怪物攻击[_loc1_].伤害.挑高);
               this.runTime = int(EnemySkinXml.怪物攻击[_loc1_].伤害.持续);
               this.硬直 = int(EnemySkinXml.怪物攻击[_loc1_].特效.硬直);
               this.被攻击硬直 = int(EnemySkinXml.怪物攻击[_loc1_].被攻击硬直);
               this.attTimes = int(EnemySkinXml.怪物攻击[_loc1_].特效.攻击次数);
               this.type = int(EnemySkinXml.怪物攻击[_loc1_].特效.类型);
               this.space = int(EnemySkinXml.怪物攻击[_loc1_].特效.间隔);
               this.totalTime = int(EnemySkinXml.怪物攻击[_loc1_].特效.总计时);
               this.numValue = int(EnemySkinXml.怪物攻击[_loc1_].特效.数值);
               return;
            }
         }
      }
      
      public function isRunOver() : *
      {
         if(this.currentLabel != this.runType)
         {
            this.runOver = true;
         }
         else
         {
            this.runOver = false;
         }
      }
      
      public function GoTo(param1:String, param2:int = 0) : *
      {
         this.otherGoTo(param1);
         if(param1 == "死亡" && this.runType != param1)
         {
            this.runType = "死亡";
            gotoAndPlay(this.runType);
            return;
         }
         if(param1 == "被打")
         {
            this.runType = param1;
            this.runOver = false;
            this.stopRun = false;
            gotoAndPlay(this.runType);
         }
         if((this.runOver || this.stopRun) && this.runType != param1)
         {
            this.runType = param1;
            this.runOver = false;
            gotoAndPlay(this.runType);
            this.frame = 0;
         }
         this.continuousTime = param2;
      }
      
      public function otherGoTo(param1:String) : *
      {
      }
      
      public function 震动(param1:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(param1);
         }
      }
   }
}

