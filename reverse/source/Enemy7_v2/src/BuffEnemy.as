package src
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   
   public class BuffEnemy extends MovieClip
   {
      
      public static var AllBuff:Array = [];
      
      public static var isIce:Boolean = false;
      
      private var space:int;
      
      private var ghosting:MovieClip = new Ghosting();
      
      private var tempNum:Number = 0;
      
      private var castMC:MovieClip;
      
      private var totalTime:int;
      
      private var timeTemp:int = 0;
      
      private var ruanni:MovieClip = new Ruanni();
      
      private var iceBroken:MovieClip = new IceBroken();
      
      private var ruanniDead:MovieClip = new RuanniDead();
      
      private var iceing:MovieClip = new Iceing();
      
      private var numValue:int;
      
      private var type:int;
      
      private var burn:MovieClip = new Burn();
      
      private var poisoning:MovieClip = new Poisoning();
      
      private var effectMC:MovieClip;
      
      public function BuffEnemy(mc:MovieClip, toMc:MovieClip)
      {
         super();
         type = (mc as HitXX).type;
         space = (mc as HitXX).space;
         totalTime = (mc as HitXX).totalTime;
         numValue = (mc as HitXX).numValue;
         timeTemp = (mc as HitXX).space;
         castMC = (mc as HitXX).who;
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
         trace("type=======" + type);
         if(type >= 100)
         {
            addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            AllBuff[AllBuff.length] = this;
         }
      }
      
      private function dead() : *
      {
         var i:int = 0;
         this.removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         this.parent.removeChild(this);
         for(i = 0; i < AllBuff.length; i++)
         {
            if(AllBuff[i] == this)
            {
               AllBuff.splice(i,1);
            }
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
      
      public function onENTER_FRAME(e:Event) : *
      {
         if(effectMC is Enemy)
         {
            realEffect();
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
      }
   }
}

