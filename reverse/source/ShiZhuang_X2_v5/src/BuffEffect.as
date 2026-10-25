package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class BuffEffect extends MovieClip
   {
      
      public static var AllBuffArr:Array = [];
      
      public static var isIce:Boolean = false;
      
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
      
      private var tempV:int = 0;
      
      public function BuffEffect(mc:MovieClip, toMc:MovieClip)
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
         if(type != 0)
         {
            addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            AllBuffArr[AllBuffArr.length] = this;
         }
      }
      
      public function onENTER_FRAME(e:Event) : *
      {
         if(effectMC is Player)
         {
            realEffect();
         }
      }
      
      internal function removeRuanniDead(event:Event) : *
      {
         if(event.target.currentFrame == MovieClip(event.target).totalFrames)
         {
            effectMC.removeChild(ruanniDead);
            event.target.removeEventListener(Event.ENTER_FRAME,removeRuanniDead);
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
      
      internal function bianXiao(e:Event) : *
      {
         effectMC.scaleX -= 0.05;
         effectMC.scaleY -= 0.05;
         if(effectMC.scaleX <= 0.5 && effectMC.scaleY <= 0.5)
         {
            removeEventListener(Event.ENTER_FRAME,bianXiao);
         }
      }
      
      internal function zhongXie(e:Event) : *
      {
         if((castMC as Enemy).skin.runType == "被打")
         {
            (effectMC as Player).skin.GoTo("被打",20,true);
         }
      }
      
      private function realEffect() : *
      {
         var hpX:* = undefined;
         var hpHP:int = 0;
         --totalTime;
         if(type == 7)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  if(AllBuffArr.length > 3)
                  {
                     isIce = true;
                     this.addChild(iceing);
                     (effectMC as Player).skin.GoTo("被打",81,true);
                  }
                  timeTemp = 0;
               }
            }
            else
            {
               dead();
               if(AllBuffArr.length <= 0 && isIce == true)
               {
                  isIce = false;
                  effectMC.addChild(iceBroken);
                  iceBroken.gotoAndPlay(0);
                  iceBroken.addEventListener(Event.ENTER_FRAME,removeIceBroken);
               }
            }
         }
         else if(type == 6)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  if(AllBuffArr.length > 0)
                  {
                     isIce = true;
                     this.addChild(iceing);
                     (effectMC as Player).skin.GoTo("被打",81,true);
                  }
                  timeTemp = 0;
               }
            }
            else
            {
               dead();
               if(AllBuffArr.length <= 0 && isIce == true)
               {
                  isIce = false;
                  effectMC.addChild(iceBroken);
                  iceBroken.gotoAndPlay(0);
                  iceBroken.addEventListener(Event.ENTER_FRAME,removeIceBroken);
               }
            }
         }
         else if(type == 1)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  hpX = numValue;
                  if(hpX > 0)
                  {
                     hpHP = (effectMC as Player).hp.getValue() - hpX;
                     if(hpHP < 0)
                     {
                        (effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (effectMC as Player).hp.setValue(hpHP);
                     }
                  }
                  timeTemp = 0;
                  HPdown.Open(hpX,effectMC.x,effectMC.y - effectMC.height);
                  this.addChild(poisoning);
               }
            }
            else
            {
               this.removeChild(poisoning);
               dead();
            }
         }
         else if(type == 5)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  hpX = numValue;
                  if(hpX > 0)
                  {
                     hpHP = (effectMC as Player).hp.getValue() - hpX;
                     if(hpHP < 0)
                     {
                        (effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (effectMC as Player).hp.setValue(hpHP);
                     }
                  }
                  timeTemp = 0;
                  HPdown.Open(hpX,effectMC.x,effectMC.y - effectMC.height);
                  this.addChild(burn);
               }
            }
            else
            {
               this.removeChild(burn);
               dead();
            }
         }
         else if(type == 8)
         {
            if(totalTime >= 0)
            {
               (effectMC as Player).speedTemp.setValue(-4);
            }
            else
            {
               (effectMC as Player).speedTemp.setValue(0);
               dead();
            }
         }
         else if(type == 9)
         {
            if(totalTime >= 0)
            {
               if(tempV == 0)
               {
                  tempV = (effectMC as Player).mp.getValue();
               }
               (effectMC as Player).mp.setValue(1);
            }
            else
            {
               (effectMC as Player).mp.setValue(tempV);
               tempV = 0;
               dead();
            }
         }
         else if(type == 2)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  (effectMC as Player).skin.GoTo("被打",72,true);
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
         else if(type == 3)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  this.addEventListener(Event.ENTER_FRAME,zhongXie);
                  timeTemp = 0;
                  this.addChild(ghosting);
               }
            }
            else
            {
               this.removeEventListener(Event.ENTER_FRAME,zhongXie);
               dead();
            }
         }
         else if(type == 4)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  (castMC as Enemy).life.setValue(0);
                  (castMC as Enemy).Dead();
                  timeTemp = 0;
                  this.addChild(ruanni);
               }
            }
            else
            {
               effectMC.addChild(ruanniDead);
               ruanniDead.gotoAndPlay(0);
               ruanniDead.addEventListener(Event.ENTER_FRAME,removeRuanniDead);
               dead();
            }
         }
         ++timeTemp;
      }
      
      private function dead() : *
      {
         this.removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         this.parent.removeChild(this);
         for(var i:int = 0; i < AllBuffArr.length; i++)
         {
            if(AllBuffArr[i] == this)
            {
               AllBuffArr.splice(i,1);
            }
         }
      }
   }
}

