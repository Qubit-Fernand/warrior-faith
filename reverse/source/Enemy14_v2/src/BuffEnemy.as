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
      
      public function BuffEnemy(mc:MovieClip, toMc:MovieClip)
      {
         super();
         this.type = (mc as HitXX).type;
         this.space = (mc as HitXX).space;
         this.totalTime = (mc as HitXX).totalTime;
         this.numValue = (mc as HitXX).numValue;
         this.timeTemp = (mc as HitXX).space;
         this.castMC = (mc as HitXX).who;
         this.effectMC = toMc;
         this.effectMC.addChild(this);
         this.x = 0;
         this.y = 0;
         this.poisoning.x = this.x;
         this.poisoning.y = this.y;
         this.iceing.x = this.x;
         this.iceing.y = this.y;
         this.iceBroken.x = this.x;
         this.iceBroken.y = this.y;
         this.ghosting.x = this.x;
         this.ghosting.y = this.y;
         this.ruanni.x = this.x;
         this.ruanni.y = this.y;
         this.ruanniDead.x = this.x;
         this.ruanniDead.y = this.y;
         this.burn.x = this.x;
         this.burn.y = this.y;
         trace("type=======" + this.type);
         if(this.type >= 100)
         {
            addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
            (this.effectMC as Enemy).cengshu[(this.effectMC as Enemy).cengshu.length] = this;
         }
      }
      
      public function onENTER_FRAME(e:Event) : *
      {
         if(this.effectMC is Enemy)
         {
            this.realEffect();
         }
      }
      
      internal function bianXiao(e:Event) : *
      {
         this.effectMC.scaleX -= 0.05;
         this.effectMC.scaleY -= 0.05;
         if(this.effectMC.scaleX <= 0.5 && this.effectMC.scaleY <= 0.5)
         {
            removeEventListener(Event.ENTER_FRAME,this.bianXiao);
         }
      }
      
      internal function removeIceBroken(event:Event) : *
      {
         if(event.target.currentFrame == MovieClip(event.target).totalFrames)
         {
            this.effectMC.removeChild(this.iceBroken);
            event.target.removeEventListener(Event.ENTER_FRAME,this.removeIceBroken);
         }
      }
      
      private function realEffect() : *
      {
         --this.totalTime;
         if(this.type == 100)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  this.addEventListener(Event.ENTER_FRAME,this.bianXiao);
                  this.timeTemp = 0;
               }
            }
            else
            {
               this.effectMC.scaleX = 1;
               this.effectMC.scaleY = 1;
               this.dead();
            }
         }
         if(this.type == 101)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  if((this.effectMC as Enemy).cengshu.length > 3)
                  {
                     this.isIce = true;
                     if((this.parent as Enemy).life.getValue() > 0)
                     {
                        this.addChild(this.iceing);
                        (this.effectMC as Enemy).skin.GoTo("被打",81);
                     }
                  }
                  this.timeTemp = 0;
               }
            }
            else
            {
               this.dead();
               if((this.effectMC as Enemy).cengshu.length <= 0 && this.isIce == true)
               {
                  this.isIce = false;
                  this.effectMC.addChild(this.iceBroken);
                  this.iceBroken.gotoAndPlay(0);
                  this.iceBroken.addEventListener(Event.ENTER_FRAME,this.removeIceBroken);
               }
            }
         }
      }
      
      private function dead() : *
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         this.parent.removeChild(this);
         for(var i:int = 0; i < (this.effectMC as Enemy).cengshu.length; i++)
         {
            if((this.effectMC as Enemy).cengshu[i] == this)
            {
               (this.effectMC as Enemy).cengshu.splice(i,1);
            }
         }
      }
   }
}

