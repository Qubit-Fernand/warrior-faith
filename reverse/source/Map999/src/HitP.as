package src
{
   import flash.display.*;
   import flash.events.*;
   
   public class HitP extends MovieClip
   {
      
      public static var AllHitP:Array = [];
      
      public var who:Object;
      
      public var objArr:Array = [];
      
      public function HitP()
      {
         super();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      public static function HitPlayer() : *
      {
         var i:int = 0;
         var hitP:HitP = null;
         var i2:int = 0;
         var bool:Boolean = false;
         var i3:int = 0;
         var n:int = 0;
         if(HitP.AllHitP.length > 0)
         {
            for(i = 0; i < HitP.AllHitP.length; i++)
            {
               hitP = HitP.AllHitP[i] as HitP;
               if(hitP.who is Player)
               {
                  for(i2 = 0; i2 < Player.All.length; i2++)
                  {
                     bool = false;
                     for(i3 = 0; i3 < hitP.objArr.length; i3++)
                     {
                        if(Player.All[i2] == hitP.objArr[i3])
                        {
                           bool = true;
                           break;
                        }
                     }
                     if(Boolean(Player.All[i2].hit && (Player.All[i2] as Player).hp.getValue() > 0) && Boolean(!bool) && hitP.hitTestObject(Player.All[i2].hit))
                     {
                        (Player.All[i2] as Player).noHit = true;
                     }
                  }
               }
            }
         }
         else
         {
            for(n = 0; n < Player.All.length; n++)
            {
               (Player.All[n] as Player).noHit = false;
            }
         }
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         var i:int = 0;
         if(AllHitP)
         {
            for(i = 0; i < AllHitP.length; i++)
            {
               if(AllHitP[i] == this)
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
               who = parentMC.who;
               AllHitP[AllHitP.length] = this;
               return;
            }
            if(parentMC is Skin_WuQi && parentMC.parent is Player)
            {
               who = parentMC.parent;
               AllHitP[AllHitP.length] = this;
               return;
            }
            if(parentMC is Skin && parentMC.parent is Player)
            {
               who = parentMC.parent;
               AllHitP[AllHitP.length] = this;
               return;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               who = parentMC.parent;
               AllHitP[AllHitP.length] = this;
               return;
            }
            parentMC = parentMC.parent as MovieClip;
         }
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         var i:int = 0;
         if(AllHitP)
         {
            for(i = 0; i < AllHitP.length; i++)
            {
               if(AllHitP[i] == this)
               {
                  AllHitP.splice(i,1);
               }
            }
         }
         this.objArr = new Array();
      }
   }
}

