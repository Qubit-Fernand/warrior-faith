package src
{
   import flash.display.*;
   import src.epilogue.ui.TrackedMovieClip;
   import src.epilogue.ChapterController;
   import flash.events.*;
   import flash.utils.*;
   import src.other.*;
   
   public class Fly extends TrackedMovieClip
   {
      
      public static var FlyData:XML;
      
      public static var All:Array = [];
      
      public var life:int = -1;
      
      public var hit:HitXX;
      
      public var time:int = -1;
      
      public var continuous:Boolean;
      
      public var speedX:int;
      
      public var speedY:int;
      
      public var moveYN:Boolean = true;
      
      public var objArr:Array = [];
      
      public var gongJi_hp:Number;
      
      public var runArr:Array = [];
      
      public var cross:Boolean;
      
      public var 硬直:int;
      
      public var runX:int;
      
      public var runY:int;
      
      public var runTime:int;
      
      public var who:Object;
      
      public var getWho:Object;
      
      public var _stage:MovieClip;
      
      public var RL:Boolean;
      
      public var over:Boolean;
      
      public var attTimes:int;
      
      public var type:int = 0;
      
      public var space:int;
      
      public var totalTime:int;
      
      public var numValue:int;
      
      private var XXX:int;
      
      private var YYY:int;
      
      public function Fly()
      {
         super();
         getData();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function onADDED_TO_STAGE(param1:* = null) : *
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         _loc2_ = 0;
         while(_loc2_ < All.length)
         {
            if(All[_loc2_] == this)
            {
               return;
            }
            _loc2_++;
         }
         All[All.length] = this;
         var _loc3_:MovieClip = this;
         while(_loc3_ != _stage)
         {
            if(_loc3_ is Skin_WuQi && _loc3_.parent is Player)
            {
               who = _loc3_.parent;
               this.RL = (who as Player).RL;
               硬直 = who.skin.硬直;
               gongJi_hp = who.skin.hpXX.getValue();
               attTimes = who.skin.attTimes;
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(_loc3_ is Fly && _loc3_.parent is Fly)
            {
               who = _loc3_.parent.who;
               硬直 = _loc3_.parent.硬直;
               gongJi_hp = _loc3_.parent.gongJi_hp;
               attTimes = _loc3_.parent.attTimes;
               runX = _loc3_.parent.runX;
               runY = _loc3_.parent.runY;
               XXX = _loc3_.parent.x;
               YYY = _loc3_.parent.y;
               runTime = _loc3_.parent.runTime;
               break;
            }
            if(_loc3_ is Skin_WuQi && _loc3_.parent is Player2)
            {
               who = _loc3_.parent;
               this.RL = (who as Player2).RL;
               硬直 = who.skin.硬直;
               gongJi_hp = who.skin.hpXX.getValue();
               attTimes = who.skin.attTimes;
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(_loc3_ is EnemySkin && _loc3_.parent is Enemy)
            {
               who = _loc3_.parent;
               this.RL = (who as Enemy).RL;
               硬直 = who.skin.硬直;
               attTimes = who.skin.attTimes;
               gongJi_hp = (_loc3_ as EnemySkin).hpX;
               runX = (_loc3_ as EnemySkin).runX;
               runY = (_loc3_ as EnemySkin).runY;
               runTime = (_loc3_ as EnemySkin).runTime;
               type = (_loc3_ as EnemySkin).type;
               space = (_loc3_ as EnemySkin).space;
               totalTime = (_loc3_ as EnemySkin).totalTime;
               numValue = (_loc3_ as EnemySkin).numValue;
               break;
            }
            if(_loc3_ is ChongWu)
            {
               this.RL = (_loc3_ as ChongWu).RL;
               who = _loc3_;
               for(_loc2_ in ChongWu.dataXml.宠物攻击)
               {
                  _loc4_ = String(ChongWu.dataXml.宠物攻击[_loc2_].名称);
                  if(getQualifiedClassName(this) == _loc4_)
                  {
                     moveYN = String(ChongWu.dataXml.宠物攻击[_loc2_].独立).toString() == "true" ? true : false;
                     life = int(ChongWu.dataXml.宠物攻击[_loc2_].HP);
                     continuous = String(ChongWu.dataXml.宠物攻击[_loc2_].循环).toString() == "true" ? true : false;
                     cross = String(ChongWu.dataXml.宠物攻击[_loc2_].穿越).toString() == "true" ? true : false;
                     time = int(ChongWu.dataXml.宠物攻击[_loc2_].时间);
                     speedX = int(ChongWu.dataXml.宠物攻击[_loc2_].移动x);
                     speedY = int(ChongWu.dataXml.宠物攻击[_loc2_].移动y);
                     gongJi_hp = Number(ChongWu.dataXml.宠物攻击[_loc2_].攻击HP) * (_loc3_ as ChongWu).who.gongji.getValue() * (100 + Math.random() * 2) / 100;
                     runArr = [int(ChongWu.dataXml.宠物攻击[_loc2_].震退),int(ChongWu.dataXml.宠物攻击[_loc2_].挑高),int(ChongWu.dataXml.宠物攻击[_loc2_].持续)];
                     break;
                  }
               }
               break;
            }
            _loc3_ = _loc3_.parent as MovieClip;
         }
         if(moveYN)
         {
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
            if(!(this is Boss108_FlyXX))
            {
               Main.world.moveChild_Other.addChild(this);
            }
            otherXXXXX();
         }
      }
      
      private function otherXXXXX() : *
      {
         if(getQualifiedClassName(this) == "猎犬火焰")
         {
            this.y = YYY + 50;
            this.x = XXX;
         }
         if(getQualifiedClassName(this) == "宠3毒雾")
         {
            this.y = 0;
            this.scaleX = 1;
            this.x = this.who.x;
         }
         else if(getQualifiedClassName(this) == "宠3猫头鹰")
         {
            this.y = 500;
            this.x = this.who.x + Math.random() * 800 - 400;
         }
      }
      
      public function getData() : *
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
      
      public function onENTER_FRAME(param1:*) : *
      {
         if(ChapterController.paused) return;
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
         otherXX();
      }
      
      public function otherXX() : *
      {
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
         if(this.x > Main.world._width + 400 || this.x < -400)
         {
            life = 0;
         }
      }
      
      public function Dead() : *
      {
         stop();
         All.splice(this);
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         if(this.who is Player2 || this.who is Player || this.who is Enemy || this.who is ChongWu)
         {
            this.parent.removeChild(this);
         }
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

