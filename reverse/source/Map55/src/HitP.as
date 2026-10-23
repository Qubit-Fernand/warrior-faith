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
         var _loc1_:int = 0;
         var _loc2_:HitP = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(HitP.AllHitP.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < HitP.AllHitP.length)
            {
               _loc2_ = HitP.AllHitP[_loc1_] as HitP;
               if(_loc2_.who is Player)
               {
                  _loc3_ = 0;
                  while(_loc3_ < Player.All.length)
                  {
                     _loc4_ = false;
                     _loc5_ = 0;
                     while(_loc5_ < _loc2_.objArr.length)
                     {
                        if(Player.All[_loc3_] == _loc2_.objArr[_loc5_])
                        {
                           _loc4_ = true;
                           break;
                        }
                        _loc5_++;
                     }
                     if(Boolean(Player.All[_loc3_].hit && (Player.All[_loc3_] as Player).hp.getValue() > 0) && Boolean(!_loc4_) && _loc2_.hitTestObject(Player.All[_loc3_].hit))
                     {
                        (Player.All[_loc3_] as Player).noHit = true;
                     }
                     _loc3_++;
                  }
               }
               _loc1_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < Player.All.length)
            {
               (Player.All[_loc6_] as Player).noHit = false;
               _loc6_++;
            }
         }
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc3_:int = 0;
         if(AllHitP)
         {
            _loc3_ = 0;
            while(_loc3_ < AllHitP.length)
            {
               if(AllHitP[_loc3_] == this)
               {
                  return;
               }
               _loc3_++;
            }
         }
         var _loc2_:MovieClip = this.parent as MovieClip;
         while(_loc2_ != _stage)
         {
            if(_loc2_ is Fly)
            {
               who = _loc2_.who;
               AllHitP[AllHitP.length] = this;
               return;
            }
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               AllHitP[AllHitP.length] = this;
               return;
            }
            if(_loc2_ is Skin && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               AllHitP[AllHitP.length] = this;
               return;
            }
            if(_loc2_ is EnemySkin && _loc2_.parent is Enemy)
            {
               who = _loc2_.parent;
               AllHitP[AllHitP.length] = this;
               return;
            }
            _loc2_ = _loc2_.parent as MovieClip;
         }
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         var _loc2_:int = 0;
         if(AllHitP)
         {
            _loc2_ = 0;
            while(_loc2_ < AllHitP.length)
            {
               if(AllHitP[_loc2_] == this)
               {
                  AllHitP.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
         this.objArr = new Array();
      }
   }
}

