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
      
      public function BuffEffect(mc:MovieClip, toMc:MovieClip)
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
         trace("type" + this.type);
         if(this.type != 0)
         {
            addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
            AllBuffArr[AllBuffArr.length] = this;
         }
      }
      
      public function onENTER_FRAME(e:Event) : *
      {
         if(this.effectMC is Player)
         {
            this.realEffect();
         }
      }
      
      internal function removeRuanniDead(event:Event) : *
      {
         if(event.target.currentFrame == MovieClip(event.target).totalFrames)
         {
            this.effectMC.removeChild(this.ruanniDead);
            event.target.removeEventListener(Event.ENTER_FRAME,this.removeRuanniDead);
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
      
      internal function bianXiao(e:Event) : *
      {
         this.effectMC.scaleX -= 0.05;
         this.effectMC.scaleY -= 0.05;
         if(this.effectMC.scaleX <= 0.5 && this.effectMC.scaleY <= 0.5)
         {
            removeEventListener(Event.ENTER_FRAME,this.bianXiao);
         }
      }
      
      internal function zhongXie(e:Event) : *
      {
         if((this.castMC as Enemy).skin.runType == "被打")
         {
            (this.effectMC as Player).skin.GoTo("被打",20,true);
         }
      }
      
      private function realEffect() : *
      {
         var hpX:* = undefined;
         var hpHP:int = 0;
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
                  hpX = this.numValue;
                  if(hpX > 0)
                  {
                     hpHP = (this.effectMC as Player).hp.getValue() - hpX;
                     if(hpHP < 0)
                     {
                        (this.effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (this.effectMC as Player).hp.setValue(hpHP);
                     }
                  }
                  this.timeTemp = 0;
                  HPdown.Open(hpX,this.effectMC.x,this.effectMC.y - this.effectMC.height);
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
                  hpX = this.numValue;
                  if(hpX > 0)
                  {
                     hpHP = (this.effectMC as Player).hp.getValue() - hpX;
                     if(hpHP < 0)
                     {
                        (this.effectMC as Player).hp.setValue(0);
                     }
                     else
                     {
                        (this.effectMC as Player).hp.setValue(hpHP);
                     }
                  }
                  this.timeTemp = 0;
                  HPdown.Open(hpX,this.effectMC.x,this.effectMC.y - this.effectMC.height);
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

