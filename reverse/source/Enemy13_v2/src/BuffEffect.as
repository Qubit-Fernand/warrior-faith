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
      
      public function BuffEffect(param1:MovieClip, param2:MovieClip)
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
         trace("type" + type);
         if(type != 0)
         {
            addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            AllBuffArr[AllBuffArr.length] = this;
         }
      }
      
      public function onENTER_FRAME(param1:Event) : *
      {
         if(effectMC is Player)
         {
            realEffect();
         }
      }
      
      internal function removeRuanniDead(param1:Event) : *
      {
         if(param1.target.currentFrame == MovieClip(param1.target).totalFrames)
         {
            effectMC.removeChild(ruanniDead);
            param1.target.removeEventListener(Event.ENTER_FRAME,removeRuanniDead);
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
      
      internal function bianXiao(param1:Event) : *
      {
         effectMC.scaleX -= 0.05;
         effectMC.scaleY -= 0.05;
         if(effectMC.scaleX <= 0.5 && effectMC.scaleY <= 0.5)
         {
            removeEventListener(Event.ENTER_FRAME,bianXiao);
         }
      }
      
      internal function zhongXie(param1:Event) : *
      {
         if((castMC as Enemy).skin.runType == "被打")
         {
            (effectMC as Player).skin.GoTo("被打",20,true);
         }
      }
      
      private function realEffect() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
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
                  _loc1_ = numValue;
                  if(_loc1_ > 0)
                  {
                     _loc2_ = (effectMC as Player).hp.getValue() - _loc1_;
                     if(_loc2_ < 0)
                     {
                        (effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (effectMC as Player).hp.setValue(_loc2_);
                     }
                  }
                  timeTemp = 0;
                  HPdown.Open(_loc1_,effectMC.x,effectMC.y - effectMC.height);
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
                  _loc1_ = numValue;
                  if(_loc1_ > 0)
                  {
                     _loc2_ = (effectMC as Player).hp.getValue() - _loc1_;
                     if(_loc2_ < 0)
                     {
                        (effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (effectMC as Player).hp.setValue(_loc2_);
                     }
                  }
                  timeTemp = 0;
                  HPdown.Open(_loc1_,effectMC.x,effectMC.y - effectMC.height);
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
               (effectMC as Player).mp.setValue(0);
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
         var _loc1_:int = 0;
         while(_loc1_ < AllBuffArr.length)
         {
            if(AllBuffArr[_loc1_] == this)
            {
               AllBuffArr.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
   }
}

