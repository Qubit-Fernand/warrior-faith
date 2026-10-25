package src
{
   import flash.display.*;
   import flash.events.*;
   
   public class HitF extends MovieClip
   {
      
      public static var AllHitF:Array = [];
      
      public var who:Object;
      
      public var objArr:Array = [];
      
      public function HitF()
      {
         super();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onREMOVED_FROM_STAGE);
      }
      
      public static function HitFly() : *
      {
         var hitF:HitF = null;
         var i2:int = 0;
         var bool:Boolean = false;
         var i3:int = 0;
         for(var i:int = 0; i < HitF.AllHitF.length; i++)
         {
            hitF = HitF.AllHitF[i] as HitF;
            if(hitF.who is Player)
            {
               for(i2 = 0; i2 < Fly.All.length; i2++)
               {
                  bool = false;
                  for(i3 = 0; i3 < hitF.objArr.length; i3++)
                  {
                     if(Fly.All[i2] == hitF.objArr[i3])
                     {
                        bool = true;
                        break;
                     }
                  }
                  if(Boolean(Fly.All[i2].hit && Fly.All[i2].life != 0) && Boolean(!bool) && hitF.hitTestObject(Fly.All[i2].hit))
                  {
                     (Fly.All[i2] as Fly).life = 0;
                  }
               }
            }
         }
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         var i:int = 0;
         if(AllHitF)
         {
            for(i = 0; i < AllHitF.length; i++)
            {
               if(AllHitF[i] == this)
               {
                  return;
               }
            }
         }
         var parentMC:MovieClip = this.parent as MovieClip;
         while(parentMC != _stage)
         {
            if(parentMC is Fly)
            {
               this.who = parentMC.who;
               AllHitF[AllHitF.length] = this;
               return;
            }
            if(parentMC is Skin_WuQi && parentMC.parent is Player)
            {
               this.who = parentMC.parent;
               AllHitF[AllHitF.length] = this;
               return;
            }
            if(parentMC is Skin && parentMC.parent is Player)
            {
               this.who = parentMC.parent;
               AllHitF[AllHitF.length] = this;
               return;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               this.who = parentMC.parent;
               AllHitF[AllHitF.length] = this;
               return;
            }
            parentMC = parentMC.parent as MovieClip;
         }
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         var i:int = 0;
         if(AllHitF)
         {
            for(i = 0; i < AllHitF.length; i++)
            {
               if(AllHitF[i] == this)
               {
                  AllHitF.splice(i,1);
               }
            }
         }
         this.objArr = new Array();
      }
   }
}

