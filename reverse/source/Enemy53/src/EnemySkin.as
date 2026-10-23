package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class EnemySkin extends MovieClip
   {
      
      public static var EnemySkinXmlArr:Array = new Array();
      
      public var EnemySkinXml:XML = new XML();
      
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
      
      public var lexAdd:int = 1;
      
      public var runType:String = "";
      
      public var moveArr:Array = [];
      
      public function EnemySkin()
      {
         super();
         this.GoTo("站立");
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         this.otherggg();
      }
      
      public function otherggg() : *
      {
      }
      
      public function Over() : *
      {
         this.gotoAndStop(1);
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function onENTER_FRAME(e:*) : *
      {
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
      
      public function GoToPlay() : *
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
         var i:* = undefined;
         var name:String = null;
         var 名称:String = null;
         var 帧标签:String = null;
         var 当前帧:int = 0;
         this.moveArr = null;
         for(i in this.EnemySkinXml.怪物攻击)
         {
            name = getQualifiedClassName(this);
            名称 = String(this.EnemySkinXml.怪物攻击[i].名称);
            帧标签 = String(this.EnemySkinXml.怪物攻击[i].帧标签);
            当前帧 = int(String(this.EnemySkinXml.怪物攻击[i].当前帧));
            if(name == 名称 && this.runType == 帧标签 && this.frame == 当前帧)
            {
               this.continuous = false;
               this.stopRun = false;
               this.gravity = int(this.EnemySkinXml.怪物攻击[i].重力调整);
               this.moveArr = [int(this.EnemySkinXml.怪物攻击[i].移动参数.X),int(this.EnemySkinXml.怪物攻击[i].移动参数.Y),int(this.EnemySkinXml.怪物攻击[i].移动参数.持续)];
               this.hpX = int(this.EnemySkinXml.怪物攻击[i].伤害.hp) * this.parent.攻击力.getValue() * this.lexAdd;
               this.runX = int(this.EnemySkinXml.怪物攻击[i].伤害.震退);
               this.runY = int(this.EnemySkinXml.怪物攻击[i].伤害.挑高);
               this.runTime = int(this.EnemySkinXml.怪物攻击[i].伤害.持续);
               this.硬直 = int(this.EnemySkinXml.怪物攻击[i].特效.硬直);
               this.被攻击硬直 = int(this.EnemySkinXml.怪物攻击[i].被攻击硬直);
               this.attTimes = int(this.EnemySkinXml.怪物攻击[i].特效.攻击次数);
               this.type = int(this.EnemySkinXml.怪物攻击[i].特效.类型);
               this.space = int(this.EnemySkinXml.怪物攻击[i].特效.间隔);
               this.totalTime = int(this.EnemySkinXml.怪物攻击[i].特效.总计时);
               this.numValue = int(this.EnemySkinXml.怪物攻击[i].特效.数值);
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
      
      public function GoTo(str:String, timeX:int = 0) : *
      {
         this.otherGoTo(str);
         if(str == "死亡" && this.runType != str)
         {
            this.runType = "死亡";
            gotoAndPlay(this.runType);
            return;
         }
         if(str == "被打")
         {
            this.runType = str;
            this.runOver = false;
            this.stopRun = false;
            gotoAndPlay(this.runType);
         }
         if((this.runOver || this.stopRun) && this.runType != str)
         {
            this.runType = str;
            this.runOver = false;
            gotoAndPlay(this.runType);
            this.frame = 0;
         }
         this.continuousTime = timeX;
      }
      
      public function otherGoTo(str:String) : *
      {
      }
      
      public function 震动(num:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(num);
         }
      }
   }
}

