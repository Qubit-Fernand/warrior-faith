package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class BuffEffect extends MovieClip
   {
      
      public static var AllBuffArr:Array = [];
      
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
      
      private function dead() : *
      {
         var _loc1_:int = 0;
         this.removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         this.parent.removeChild(this);
         _loc1_ = 0;
         while(_loc1_ < AllBuffArr.length)
         {
            if(AllBuffArr[_loc1_] == this)
            {
               AllBuffArr.splice(_loc1_,1);
            }
            _loc1_++;
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
      
      public function onENTER_FRAME(param1:Event) : *
      {
         if(effectMC is Player)
         {
            realEffect();
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
                  tempNum = 1;
                  if(AllBuffArr.length > 3)
                  {
                     tempNum = (effectMC as Player).walk_power.getValue();
                  }
                  (effectMC as Player).walk_power.setValue((effectMC as Player).walk_power.getValue() - tempNum);
                  timeTemp = 0;
               }
               if(AllBuffArr.length > 3)
               {
                  isIce = true;
                  this.addChild(iceing);
                  (effectMC as Player).skin.GoTo("被打",72,true);
               }
            }
            else
            {
               (effectMC as Player).walk_power.setValue((effectMC as Player).walk_power.getValue() + tempNum);
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
         if(type == 1)
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
         if(type == 5)
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
         if(type == 2)
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
         if(type == 3)
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
         if(type == 4)
         {
            if(totalTime >= 0)
            {
               if(timeTemp == space)
               {
                  (castMC as Enemy).life = 0;
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
   }
}

