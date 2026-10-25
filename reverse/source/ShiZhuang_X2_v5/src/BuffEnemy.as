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
      
      private var timeTemp:int = 0;
      
      private var tempNum:Number = 0;
      
      private var poisoning:MovieClip = new Poisoning();
      
      private var iceing:MovieClip = new Iceing();
      
      private var iceBroken:MovieClip = new IceBroken();
      
      private var ghosting:MovieClip = new Ghosting();
      
      private var ruanni:MovieClip = new Ruanni();
      
      private var ruanniDead:MovieClip = new RuanniDead();
      
      private var burn:MovieClip = new Burn();
      
      public function BuffEnemy(mc:MovieClip, toMc:MovieClip)
      {
         super();
         type = (mc as HitXX).type;
         space = (mc as HitXX).space;
         totalTime = (mc as HitXX).totalTime;
         numValue = (mc as HitXX).numValue;
         timeTemp = (mc as HitXX).space;
         effectMC = toMc;
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
         if(type >= 100)
         {
            addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            (effectMC as Enemy).cengshu[(effectMC as Enemy).cengshu.length] = this;
         }
      }
      
      public function onENTER_FRAME(e:Event) : *
      {
         if(effectMC is Enemy)
         {
            realEffect();
         }
      }
      
      internal function bianXiao(e:Event) : *
      {
         effectMC.scaleX -= 0.05;
         effectMC.scaleY -= 0.05;
         if(effectMC.scaleX <= 0.5 && effectMC.scaleY <= 0.5)
         {
            removeEventListener(Event.ENTER_FRAME,bianXiao);
         }
      }
      
      internal function removeIceBroken(event:Event) : *
      {
         if(event.target.currentFrame == MovieClip(event.target).totalFrames)
         {
            effectMC.removeChild(iceBroken);
            event.target.removeEventListener(Event.ENTER_FRAME,removeIceBroken);
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
                        (effectMC as Enemy).skin.continuousTime = 81;
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
         if(type == 102)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  if((effectMC as Enemy).cengshu.length > 0)
                  {
                     isIce = true;
                     if((this.parent as Enemy).life.getValue() > 0)
                     {
                        this.addChild(iceing);
                        (effectMC as Enemy).skin.continuousTime = 81;
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
         for(var i:int = 0; i < (effectMC as Enemy).cengshu.length; i++)
         {
            if((effectMC as Enemy).cengshu[i] == this)
            {
               (effectMC as Enemy).cengshu.splice(i,1);
            }
         }
      }
   }
}

