package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import src.other.*;
   
   public class Fly extends MovieClip
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
         this.getData();
         this._stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function onADDED_TO_STAGE(param1:* = null) : *
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         removeEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
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
         while(_loc3_ != this._stage)
         {
            if(_loc3_ is Skin_WuQi && _loc3_.parent is Player)
            {
               this.who = _loc3_.parent;
               this.RL = (this.who as Player).RL;
               this.硬直 = this.who.skin.硬直;
               this.gongJi_hp = this.who.skin.hpXX.getValue();
               this.attTimes = this.who.skin.attTimes;
               this.runX = this.who.skin.runX;
               this.runY = this.who.skin.runY;
               this.runTime = this.who.skin.runTime;
               break;
            }
            if(_loc3_ is Fly && _loc3_.parent is Fly)
            {
               this.who = _loc3_.parent.who;
               this.硬直 = _loc3_.parent.硬直;
               this.gongJi_hp = _loc3_.parent.gongJi_hp;
               this.attTimes = _loc3_.parent.attTimes;
               this.runX = _loc3_.parent.runX;
               this.runY = _loc3_.parent.runY;
               this.XXX = _loc3_.parent.x;
               this.YYY = _loc3_.parent.y;
               this.runTime = _loc3_.parent.runTime;
               break;
            }
            if(_loc3_ is Skin_WuQi && _loc3_.parent is Player2)
            {
               this.who = _loc3_.parent;
               this.RL = (this.who as Player2).RL;
               this.硬直 = this.who.skin.硬直;
               this.gongJi_hp = this.who.skin.hpXX.getValue();
               this.attTimes = this.who.skin.attTimes;
               this.runX = this.who.skin.runX;
               this.runY = this.who.skin.runY;
               this.runTime = this.who.skin.runTime;
               break;
            }
            if(_loc3_ is EnemySkin && _loc3_.parent is Enemy)
            {
               this.who = _loc3_.parent;
               this.RL = (this.who as Enemy).RL;
               this.硬直 = this.who.skin.硬直;
               this.attTimes = this.who.skin.attTimes;
               this.gongJi_hp = (_loc3_ as EnemySkin).hpX;
               this.runX = (_loc3_ as EnemySkin).runX;
               this.runY = (_loc3_ as EnemySkin).runY;
               this.runTime = (_loc3_ as EnemySkin).runTime;
               this.type = (_loc3_ as EnemySkin).type;
               this.space = (_loc3_ as EnemySkin).space;
               this.totalTime = (_loc3_ as EnemySkin).totalTime;
               this.numValue = (_loc3_ as EnemySkin).numValue;
               break;
            }
            if(_loc3_ is ChongWu)
            {
               trace("getQualifiedClassName = " + getQualifiedClassName(this));
               this.RL = (_loc3_ as ChongWu).RL;
               this.who = _loc3_;
               for(_loc2_ in ChongWu.dataXml.宠物攻击)
               {
                  _loc4_ = String(ChongWu.dataXml.宠物攻击[_loc2_].名称);
                  if(getQualifiedClassName(this) == _loc4_)
                  {
                     this.moveYN = String(ChongWu.dataXml.宠物攻击[_loc2_].独立).toString() == "true" ? true : false;
                     this.life = int(ChongWu.dataXml.宠物攻击[_loc2_].HP);
                     this.continuous = String(ChongWu.dataXml.宠物攻击[_loc2_].循环).toString() == "true" ? true : false;
                     this.cross = String(ChongWu.dataXml.宠物攻击[_loc2_].穿越).toString() == "true" ? true : false;
                     this.time = int(ChongWu.dataXml.宠物攻击[_loc2_].时间);
                     this.speedX = int(ChongWu.dataXml.宠物攻击[_loc2_].移动x);
                     this.speedY = int(ChongWu.dataXml.宠物攻击[_loc2_].移动y);
                     this.gongJi_hp = Number(ChongWu.dataXml.宠物攻击[_loc2_].攻击HP) * (_loc3_ as ChongWu).who.gongji.getValue() * (100 + Math.random() * 2) / 100;
                     this.runArr = [int(ChongWu.dataXml.宠物攻击[_loc2_].震退),int(ChongWu.dataXml.宠物攻击[_loc2_].挑高),int(ChongWu.dataXml.宠物攻击[_loc2_].持续)];
                     break;
                  }
               }
               break;
            }
            _loc3_ = _loc3_.parent as MovieClip;
         }
         if(this.moveYN)
         {
            this.y += this.who.y;
            if(this.RL)
            {
               scaleX *= -1;
               this.x = this.who.x - this.x;
            }
            else
            {
               scaleX *= 1;
               this.x = this.who.x + this.x;
            }
            if(!(this is Boss108_FlyXX))
            {
               Main.world.moveChild_Other.addChild(this);
            }
            this.otherXXXXX();
         }
      }
      
      private function otherXXXXX() : *
      {
         if(getQualifiedClassName(this) == "猎犬火焰")
         {
            this.y = this.YYY + 50;
            this.x = this.XXX;
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
               this.life = int(FlyData.飞行道具[_loc1_].HP);
               this.continuous = String(FlyData.飞行道具[_loc1_].循环).toString() == "true" ? true : false;
               this.cross = String(FlyData.飞行道具[_loc1_].穿越).toString() == "true" ? true : false;
               this.time = int(FlyData.飞行道具[_loc1_].时间);
               this.speedX = int(FlyData.飞行道具[_loc1_].移动x);
               this.speedY = int(FlyData.飞行道具[_loc1_].移动y);
               return;
            }
         }
      }
      
      public function onENTER_FRAME(param1:*) : *
      {
         if(this.over && this.currentLabel != "结束")
         {
            this.Dead();
            return;
         }
         if(!this.over && this.life == 0)
         {
            this.life = -1;
            gotoAndPlay("结束");
            this.continuous = false;
            this.over = true;
         }
         if(!this.over && this.time != -1)
         {
            --this.time;
            if(this.time == -1)
            {
               this.time = -1;
               gotoAndPlay("结束");
               this.continuous = false;
               this.over = true;
            }
         }
         if(this.continuous && this.currentLabel != "运行")
         {
            gotoAndPlay("运行");
         }
         else if(!this.continuous && this.currentLabel != "运行")
         {
            this.over = true;
         }
         if(!this.over)
         {
            this.Move();
         }
         this.otherXX();
      }
      
      public function otherXX() : *
      {
      }
      
      public function Move() : *
      {
         this.y += this.speedY;
         if(this.RL)
         {
            this.x += this.speedX;
         }
         else
         {
            this.x -= this.speedX;
         }
         if(this.x > Main.world._width + 400 || this.x < -400)
         {
            this.life = 0;
         }
      }
      
      public function Dead() : *
      {
         stop();
         All.splice(this);
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
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

