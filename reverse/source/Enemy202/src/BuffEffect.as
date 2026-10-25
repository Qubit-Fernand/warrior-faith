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
      
      public function BuffEffect(param1:MovieClip, param2:MovieClip)
      {
         super();
         this.type = (param1 as HitXX).type;
         this.space = (param1 as HitXX).space;
         this.totalTime = (param1 as HitXX).totalTime;
         this.numValue = (param1 as HitXX).numValue;
         this.timeTemp = (param1 as HitXX).space;
         this.castMC = (param1 as HitXX).who;
         this.effectMC = param2;
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
         trace("type" + this.type);
         if(this.type != 0)
         {
            addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
            AllBuffArr[AllBuffArr.length] = this;
         }
      }
      
      public function onENTER_FRAME(param1:Event) : *
      {
         if(this.effectMC is Player)
         {
            this.realEffect();
         }
      }
      
      internal function removeRuanniDead(param1:Event) : *
      {
         if(param1.target.currentFrame == MovieClip(param1.target).totalFrames)
         {
            this.effectMC.removeChild(this.ruanniDead);
            param1.target.removeEventListener(Event.ENTER_FRAME,this.removeRuanniDead);
         }
      }
      
      internal function removeIceBroken(param1:Event) : *
      {
         if(param1.target.currentFrame == MovieClip(param1.target).totalFrames)
         {
            this.effectMC.removeChild(this.iceBroken);
            param1.target.removeEventListener(Event.ENTER_FRAME,this.removeIceBroken);
         }
      }
      
      internal function bianXiao(param1:Event) : *
      {
         this.effectMC.scaleX -= 0.05;
         this.effectMC.scaleY -= 0.05;
         if(this.effectMC.scaleX <= 0.5 && this.effectMC.scaleY <= 0.5)
         {
            removeEventListener(Event.ENTER_FRAME,this.bianXiao);
         }
      }
      
      internal function zhongXie(param1:Event) : *
      {
         if((this.castMC as Enemy).skin.runType == "被打")
         {
            (this.effectMC as Player).skin.GoTo("被打",20,true);
         }
      }
      
      private function realEffect() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         --this.totalTime;
         if(this.type == 7)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  if(AllBuffArr.length > 3)
                  {
                     isIce = true;
                     this.addChild(this.iceing);
                     (this.effectMC as Player).skin.GoTo("被打",81,true);
                  }
                  this.timeTemp = 0;
               }
            }
            else
            {
               this.dead();
               if(AllBuffArr.length <= 0 && isIce == true)
               {
                  isIce = false;
                  this.effectMC.addChild(this.iceBroken);
                  this.iceBroken.gotoAndPlay(0);
                  this.iceBroken.addEventListener(Event.ENTER_FRAME,this.removeIceBroken);
               }
            }
         }
         if(this.type == 6)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  if(AllBuffArr.length > 0)
                  {
                     isIce = true;
                     this.addChild(this.iceing);
                     (this.effectMC as Player).skin.GoTo("被打",81,true);
                  }
                  this.timeTemp = 0;
               }
            }
            else
            {
               this.dead();
               if(AllBuffArr.length <= 0 && isIce == true)
               {
                  isIce = false;
                  this.effectMC.addChild(this.iceBroken);
                  this.iceBroken.gotoAndPlay(0);
                  this.iceBroken.addEventListener(Event.ENTER_FRAME,this.removeIceBroken);
               }
            }
         }
         if(this.type == 1)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  _loc1_ = this.numValue;
                  if(_loc1_ > 0)
                  {
                     _loc2_ = (this.effectMC as Player).hp.getValue() - _loc1_;
                     if(_loc2_ < 0)
                     {
                        (this.effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (this.effectMC as Player).hp.setValue(_loc2_);
                     }
                  }
                  this.timeTemp = 0;
                  HPdown.Open(_loc1_,this.effectMC.x,this.effectMC.y - this.effectMC.height);
                  this.addChild(this.poisoning);
               }
            }
            else
            {
               this.removeChild(this.poisoning);
               this.dead();
            }
         }
         if(this.type == 5)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  _loc1_ = this.numValue;
                  if(_loc1_ > 0)
                  {
                     _loc2_ = (this.effectMC as Player).hp.getValue() - _loc1_;
                     if(_loc2_ < 0)
                     {
                        (this.effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (this.effectMC as Player).hp.setValue(_loc2_);
                     }
                  }
                  this.timeTemp = 0;
                  HPdown.Open(_loc1_,this.effectMC.x,this.effectMC.y - this.effectMC.height);
                  this.addChild(this.burn);
               }
            }
            else
            {
               this.removeChild(this.burn);
               this.dead();
            }
         }
         if(this.type == 2)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  (this.effectMC as Player).skin.GoTo("被打",72,true);
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
         if(this.type == 3)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  this.addEventListener(Event.ENTER_FRAME,this.zhongXie);
                  this.timeTemp = 0;
                  this.addChild(this.ghosting);
               }
            }
            else
            {
               this.removeEventListener(Event.ENTER_FRAME,this.zhongXie);
               this.dead();
            }
         }
         if(this.type == 4)
         {
            if(this.totalTime >= 0)
            {
               if(this.timeTemp == this.space)
               {
                  (this.castMC as Enemy).life.setValue(0);
                  (this.castMC as Enemy).Dead();
                  this.timeTemp = 0;
                  this.addChild(this.ruanni);
               }
            }
            else
            {
               this.effectMC.addChild(this.ruanniDead);
               this.ruanniDead.gotoAndPlay(0);
               this.ruanniDead.addEventListener(Event.ENTER_FRAME,this.removeRuanniDead);
               this.dead();
            }
         }
         ++this.timeTemp;
      }
      
      private function dead() : *
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
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

