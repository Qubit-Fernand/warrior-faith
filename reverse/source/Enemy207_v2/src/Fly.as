package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
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
         getData();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function onADDED_TO_STAGE(e:* = null) : *
      {
         var i:int = 0;
         var name:String = null;
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         for(i = 0; i < All.length; i++)
         {
            if(All[i] == this)
            {
               return;
            }
         }
         All[All.length] = this;
         var parentMC:MovieClip = this;
         while(parentMC != _stage)
         {
            if(parentMC is Skin_WuQi && parentMC.parent is Player)
            {
               who = parentMC.parent;
               this.RL = (who as Player).RL;
               硬直 = who.skin.硬直;
               gongJi_hp = who.skin.hpXX.getValue();
               attTimes = who.skin.attTimes;
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(parentMC is Fly && parentMC.parent is Fly)
            {
               who = parentMC.parent.who;
               硬直 = parentMC.parent.硬直;
               gongJi_hp = parentMC.parent.gongJi_hp;
               attTimes = parentMC.parent.attTimes;
               runX = parentMC.parent.runX;
               runY = parentMC.parent.runY;
               XXX = parentMC.parent.x;
               YYY = parentMC.parent.y;
               runTime = parentMC.parent.runTime;
               break;
            }
            if(parentMC is Skin_WuQi && parentMC.parent is Player2)
            {
               who = parentMC.parent;
               this.RL = (who as Player2).RL;
               硬直 = who.skin.硬直;
               gongJi_hp = who.skin.hpXX.getValue();
               attTimes = who.skin.attTimes;
               runX = who.skin.runX;
               runY = who.skin.runY;
               runTime = who.skin.runTime;
               break;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               who = parentMC.parent;
               this.RL = (who as Enemy).RL;
               硬直 = who.skin.硬直;
               attTimes = who.skin.attTimes;
               gongJi_hp = (parentMC as EnemySkin).hpX;
               runX = (parentMC as EnemySkin).runX;
               runY = (parentMC as EnemySkin).runY;
               runTime = (parentMC as EnemySkin).runTime;
               type = (parentMC as EnemySkin).type;
               space = (parentMC as EnemySkin).space;
               totalTime = (parentMC as EnemySkin).totalTime;
               numValue = (parentMC as EnemySkin).numValue;
               break;
            }
            if(parentMC is ChongWu)
            {
               trace("getQualifiedClassName = " + getQualifiedClassName(this));
               this.RL = (parentMC as ChongWu).RL;
               who = parentMC;
               for(i in ChongWu.dataXml.宠物攻击)
               {
                  name = String(ChongWu.dataXml.宠物攻击[i].名称);
                  if(getQualifiedClassName(this) == name)
                  {
                     moveYN = String(ChongWu.dataXml.宠物攻击[i].独立).toString() == "true" ? true : false;
                     life = int(ChongWu.dataXml.宠物攻击[i].HP);
                     continuous = String(ChongWu.dataXml.宠物攻击[i].循环).toString() == "true" ? true : false;
                     cross = String(ChongWu.dataXml.宠物攻击[i].穿越).toString() == "true" ? true : false;
                     time = int(ChongWu.dataXml.宠物攻击[i].时间);
                     speedX = int(ChongWu.dataXml.宠物攻击[i].移动x);
                     speedY = int(ChongWu.dataXml.宠物攻击[i].移动y);
                     gongJi_hp = Number(ChongWu.dataXml.宠物攻击[i].攻击HP) * (parentMC as ChongWu).who.gongji.getValue() * (100 + Math.random() * 2) / 100;
                     runArr = [int(ChongWu.dataXml.宠物攻击[i].震退),int(ChongWu.dataXml.宠物攻击[i].挑高),int(ChongWu.dataXml.宠物攻击[i].持续)];
                     break;
                  }
               }
               break;
            }
            parentMC = parentMC.parent as MovieClip;
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
            Main.world.moveChild_Other.addChild(this);
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
            this.x = 0;
            this.scaleX = 1;
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
               life = int(FlyData.飞行道具[i].HP);
               continuous = String(FlyData.飞行道具[i].循环).toString() == "true" ? true : false;
               cross = String(FlyData.飞行道具[i].穿越).toString() == "true" ? true : false;
               time = int(FlyData.飞行道具[i].时间);
               speedX = int(FlyData.飞行道具[i].移动x);
               speedY = int(FlyData.飞行道具[i].移动y);
               return;
            }
         }
      }
      
      public function onENTER_FRAME(e:*) : *
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
      
      public function 震动(num:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(num);
         }
      }
   }
}

