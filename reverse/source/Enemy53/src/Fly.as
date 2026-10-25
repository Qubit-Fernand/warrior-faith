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
      
      public function onADDED_TO_STAGE(e:* = null) : *
      {
         var i:int = 0;
         var name:String = null;
         removeEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         for(i = 0; i < All.length; i++)
         {
            if(All[i] == this)
            {
               return;
            }
         }
         All[All.length] = this;
         var parentMC:MovieClip = this;
         while(parentMC != this._stage)
         {
            if(parentMC is Skin_WuQi && parentMC.parent is Player)
            {
               this.who = parentMC.parent;
               this.RL = (this.who as Player).RL;
               this.硬直 = this.who.skin.硬直;
               this.gongJi_hp = this.who.skin.hpXX.getValue();
               this.attTimes = this.who.skin.attTimes;
               this.runX = this.who.skin.runX;
               this.runY = this.who.skin.runY;
               this.runTime = this.who.skin.runTime;
               break;
            }
            if(parentMC is Fly && parentMC.parent is Fly)
            {
               this.who = parentMC.parent.who;
               this.硬直 = parentMC.parent.硬直;
               this.gongJi_hp = parentMC.parent.gongJi_hp;
               this.attTimes = parentMC.parent.attTimes;
               this.runX = parentMC.parent.runX;
               this.runY = parentMC.parent.runY;
               this.XXX = parentMC.parent.x;
               this.YYY = parentMC.parent.y;
               this.runTime = parentMC.parent.runTime;
               break;
            }
            if(parentMC is Skin_WuQi && parentMC.parent is Player2)
            {
               this.who = parentMC.parent;
               this.RL = (this.who as Player2).RL;
               this.硬直 = this.who.skin.硬直;
               this.gongJi_hp = this.who.skin.hpXX.getValue();
               this.attTimes = this.who.skin.attTimes;
               this.runX = this.who.skin.runX;
               this.runY = this.who.skin.runY;
               this.runTime = this.who.skin.runTime;
               break;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               this.who = parentMC.parent;
               this.RL = (this.who as Enemy).RL;
               this.硬直 = this.who.skin.硬直;
               this.attTimes = this.who.skin.attTimes;
               this.gongJi_hp = (parentMC as EnemySkin).hpX;
               this.runX = (parentMC as EnemySkin).runX;
               this.runY = (parentMC as EnemySkin).runY;
               this.runTime = (parentMC as EnemySkin).runTime;
               this.type = (parentMC as EnemySkin).type;
               this.space = (parentMC as EnemySkin).space;
               this.totalTime = (parentMC as EnemySkin).totalTime;
               this.numValue = (parentMC as EnemySkin).numValue;
               break;
            }
            if(parentMC is ChongWu)
            {
               this.RL = (parentMC as ChongWu).RL;
               this.who = parentMC;
               for(i in ChongWu.dataXml.宠物攻击)
               {
                  name = String(ChongWu.dataXml.宠物攻击[i].名称);
                  if(getQualifiedClassName(this) == name)
                  {
                     this.moveYN = String(ChongWu.dataXml.宠物攻击[i].独立).toString() == "true" ? true : false;
                     this.life = int(ChongWu.dataXml.宠物攻击[i].HP);
                     this.continuous = String(ChongWu.dataXml.宠物攻击[i].循环).toString() == "true" ? true : false;
                     this.cross = String(ChongWu.dataXml.宠物攻击[i].穿越).toString() == "true" ? true : false;
                     this.time = int(ChongWu.dataXml.宠物攻击[i].时间);
                     this.speedX = int(ChongWu.dataXml.宠物攻击[i].移动x);
                     this.speedY = int(ChongWu.dataXml.宠物攻击[i].移动y);
                     this.gongJi_hp = Number(ChongWu.dataXml.宠物攻击[i].攻击HP) * (parentMC as ChongWu).who.gongji.getValue() * (100 + Math.random() * 2) / 100;
                     this.runArr = [int(ChongWu.dataXml.宠物攻击[i].震退),int(ChongWu.dataXml.宠物攻击[i].挑高),int(ChongWu.dataXml.宠物攻击[i].持续)];
                     break;
                  }
               }
               break;
            }
            parentMC = parentMC.parent as MovieClip;
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
         var i:* = undefined;
         var name:String = null;
         for(i in FlyData.飞行道具)
         {
            name = String(FlyData.飞行道具[i].名称);
            if(getQualifiedClassName(this) == name)
            {
               this.life = int(FlyData.飞行道具[i].HP);
               this.continuous = String(FlyData.飞行道具[i].循环).toString() == "true" ? true : false;
               this.cross = String(FlyData.飞行道具[i].穿越).toString() == "true" ? true : false;
               this.time = int(FlyData.飞行道具[i].时间);
               this.speedX = int(FlyData.飞行道具[i].移动x);
               this.speedY = int(FlyData.飞行道具[i].移动y);
               return;
            }
         }
      }
      
      public function onENTER_FRAME(e:*) : *
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
      
      public function 震动(num:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(num);
         }
      }
   }
}

