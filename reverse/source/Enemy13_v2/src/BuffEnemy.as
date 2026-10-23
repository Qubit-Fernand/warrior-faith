package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class BuffEnemy extends MovieClip
   {
      
      public static var AllBuff:Array = [];
      
      public var isIce:Boolean = false;
      
      private var type:int;
      
      private var space:int;
      
      private var totalTime:int;
      
      private var numValue:int;
      
      private var effectMC:MovieClip;
      
      private var castMC:MovieClip;
      
      private var timeTemp:int = 0;
      
      private var tempNum:Number = 0;
      
      private var poisoning:MovieClip = new Poisoning();
      
      private var iceing:MovieClip = new Iceing();
      
      private var iceBroken:MovieClip = new IceBroken();
      
      private var ghosting:MovieClip = new Ghosting();
      
      private var ruanni:MovieClip = new Ruanni();
      
      private var ruanniDead:MovieClip = new RuanniDead();
      
      private var burn:MovieClip = new Burn();
      
      public function BuffEnemy(param1:MovieClip, param2:MovieClip)
      {
         super();
         type = (param1 as HitXX).type;
         space = (param1 as HitXX).space;
         totalTime = (param1 as HitXX).totalTime;
         numValue = (param1 as HitXX).numValue;
         timeTemp = (param1 as HitXX).space;
         castMC = (param1 as HitXX).who;
         effectMC = param2;
         effectMC.addChild(this);
         this.x = 0;
         this.y = 0;
         poisoning.x = this.x;
         poisoning.y = this.y;
         iceing.x = this.x;
         iceing.y = this.y;
         iceBroken.x = this.x;
         iceBroken.y = this.y;
         ghosting.x = this.x;
         ghosting.y = this.y;
         ruanni.x = this.x;
         ruanni.y = this.y;
         ruanniDead.x = this.x;
         ruanniDead.y = this.y;
         burn.x = this.x;
         burn.y = this.y;
         trace("type=======" + type);
         if(type >= 100)
         {
            addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            (effectMC as Enemy).cengshu[(effectMC as Enemy).cengshu.length] = this;
         }
      }
      
      public function onENTER_FRAME(param1:Event) : *
      {
         if(effectMC is Enemy)
         {
            realEffect();
         }
      }
      
      internal function bianXiao(param1:Event) : *
      {
         effectMC.scaleX -= 0.05;
         effectMC.scaleY -= 0.05;
         if(effectMC.scaleX <= 0.5 && effectMC.scaleY <= 0.5)
         {
            removeEventListener(Event.ENTER_FRAME,bianXiao);
         }
      }
      
      internal function removeIceBroken(param1:Event) : *
      {
         if(param1.target.currentFrame == MovieClip(param1.target).totalFrames)
         {
            effectMC.removeChild(iceBroken);
            param1.target.removeEventListener(Event.ENTER_FRAME,removeIceBroken);
         }
      }
      
      private function realEffect() : *
      {
         --totalTime;
         if(type == 100)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  this.addEventListener(Event.ENTER_FRAME,bianXiao);
                  timeTemp = 0;
               }
            }
            else
            {
               effectMC.scaleX = 1;
               effectMC.scaleY = 1;
               dead();
            }
         }
         if(type == 101)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  if((effectMC as Enemy).cengshu.length > 3)
                  {
                     isIce = true;
                     if((this.parent as Enemy).life.getValue() > 0)
                     {
                        this.addChild(iceing);
                        (effectMC as Enemy).skin.GoTo("被打",81);
                     }
                  }
                  timeTemp = 0;
               }
            }
            else
            {
               dead();
               if((effectMC as Enemy).cengshu.length <= 0 && isIce == true)
               {
                  isIce = false;
                  effectMC.addChild(iceBroken);
                  iceBroken.gotoAndPlay(0);
                  iceBroken.addEventListener(Event.ENTER_FRAME,removeIceBroken);
               }
            }
         }
      }
      
      private function dead() : *
      {
         this.removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         this.parent.removeChild(this);
         var _loc1_:int = 0;
         while(_loc1_ < (effectMC as Enemy).cengshu.length)
         {
            if((effectMC as Enemy).cengshu[_loc1_] == this)
            {
               (effectMC as Enemy).cengshu.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
   }
}

