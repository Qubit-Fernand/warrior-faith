package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class Fly extends MovieClip
   {
      
      public static var FlyData:XML;
      
      public var 硬直:int;
      
      public var life:int = -1;
      
      public var space:int;
      
      public var _stage:MovieClip;
      
      public var objArr:Array = [];
      
      public var runTime:int;
      
      public var continuous:Boolean;
      
      public var attTimes:int;
      
      public var runY:int;
      
      public var totalTime:int;
      
      public var runX:int;
      
      public var cross:Boolean;
      
      public var hit:HitXX;
      
      public var RL:Boolean;
      
      public var type:int = 0;
      
      public var who:Object;
      
      public var time:int = -1;
      
      public var numValue:int;
      
      public var runArr:Array = [];
      
      public var over:Boolean;
      
      public var gongJi_hp:Number;
      
      public var speedX:int;
      
      public var speedY:int;
      
      public function Fly()
      {
         super();
         getData();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function onENTER_FRAME(param1:*) : *
      {
         if(over && this.currentLabel != "结束")
         {
            Dead();
            return;
         }
         if(!over && life == 0)
         {
            life = -1;
            gotoAndPlay("结束");
            continuous = false;
            over = true;
         }
         if(!over && time != -1)
         {
            --time;
            if(time == -1)
            {
               time = -1;
               gotoAndPlay("结束");
               continuous = false;
               over = true;
            }
         }
         if(continuous && this.currentLabel != "运行")
         {
            gotoAndPlay("运行");
         }
         else if(!continuous && this.currentLabel != "运行")
         {
            over = true;
         }
         if(!over)
         {
            Move();
         }
      }
      
      public function Move() : *
      {
         this.y += speedY;
         if(RL)
         {
            this.x += speedX;
         }
         else
         {
            this.x -= speedX;
         }
         if(this.x > 2000 || this.x < -400)
         {
            life = 0;
         }
      }
      
      public function onADDED_TO_STAGE(param1:* = null) : *
      {
         var _loc2_:MovieClip = null;
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         _loc2_ = this;
         while(_loc2_ != _stage)
         {
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               this.RL = (who as Player).RL;
               硬直 = who.skin.硬直;
               gongJi_hp = who.skin.hpX;
               attTimes = who.skin.attTimes;
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(_loc2_ is EnemySkin && _loc2_.parent is Enemy)
            {
               who = _loc2_.parent;
               this.RL = (who as Enemy).RL;
               硬直 = who.skin.硬直;
               attTimes = who.skin.attTimes;
               gongJi_hp = (_loc2_ as EnemySkin).hpX;
               runX = (_loc2_ as EnemySkin).runX;
               runY = (_loc2_ as EnemySkin).runY;
               runTime = (_loc2_ as EnemySkin).runTime;
               type = (_loc2_ as EnemySkin).type;
               space = (_loc2_ as EnemySkin).space;
               totalTime = (_loc2_ as EnemySkin).totalTime;
               numValue = (_loc2_ as EnemySkin).numValue;
               break;
            }
            _loc2_ = _loc2_.parent as MovieClip;
         }
         Main.world.moveChild_Other.addChild(this);
         this.y += who.y;
         if(this.RL)
         {
            scaleX *= -1;
            this.x = who.x - this.x;
         }
         else
         {
            scaleX *= 1;
            this.x = who.x + this.x;
         }
      }
      
      private function getData() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         for(_loc1_ in FlyData.飞行道具)
         {
            _loc2_ = String(FlyData.飞行道具[_loc1_].名称);
            if(getQualifiedClassName(this) == _loc2_)
            {
               life = int(FlyData.飞行道具[_loc1_].HP);
               continuous = String(FlyData.飞行道具[_loc1_].循环).toString() == "true" ? true : false;
               cross = String(FlyData.飞行道具[_loc1_].穿越).toString() == "true" ? true : false;
               time = int(FlyData.飞行道具[_loc1_].时间);
               speedX = int(FlyData.飞行道具[_loc1_].移动x);
               speedY = int(FlyData.飞行道具[_loc1_].移动y);
               return;
            }
         }
      }
      
      public function Dead() : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         if(this.who is Player || this.who is Enemy)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

