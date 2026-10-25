package src
{
   import flash.display.*;
   import flash.events.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol543")]
   public class HitF extends MovieClip
   {
      
      public static var AllHitF:Array = [];
      
      public var who:Object;
      
      public var objArr:Array = [];
      
      public function HitF()
      {
         super();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      public static function HitFly() : *
      {
         var _loc2_:HitF = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < HitF.AllHitF.length)
         {
            _loc2_ = HitF.AllHitF[_loc1_] as HitF;
            if(_loc2_.who is Player)
            {
               _loc3_ = 0;
               while(_loc3_ < Fly.All.length)
               {
                  _loc4_ = false;
                  _loc5_ = 0;
                  while(_loc5_ < _loc2_.objArr.length)
                  {
                     if(Fly.All[_loc3_] == _loc2_.objArr[_loc5_])
                     {
                        _loc4_ = true;
                        break;
                     }
                     _loc5_++;
                  }
                  if(Boolean(Fly.All[_loc3_].hit && Fly.All[_loc3_].life != 0) && Boolean(!_loc4_) && _loc2_.hitTestObject(Fly.All[_loc3_].hit))
                  {
                     (Fly.All[_loc3_] as Fly).life = 0;
                  }
                  _loc3_++;
               }
            }
            _loc1_++;
         }
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc3_:int = 0;
         if(AllHitF)
         {
            _loc3_ = 0;
            while(_loc3_ < AllHitF.length)
            {
               if(AllHitF[_loc3_] == this)
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
               AllHitF[AllHitF.length] = this;
               return;
            }
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               AllHitF[AllHitF.length] = this;
               return;
            }
            if(_loc2_ is Skin && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               AllHitF[AllHitF.length] = this;
               return;
            }
            if(_loc2_ is EnemySkin && _loc2_.parent is Enemy)
            {
               who = _loc2_.parent;
               AllHitF[AllHitF.length] = this;
               return;
            }
            _loc2_ = _loc2_.parent as MovieClip;
         }
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         var _loc2_:int = 0;
         if(AllHitF)
         {
            _loc2_ = 0;
            while(_loc2_ < AllHitF.length)
            {
               if(AllHitF[_loc2_] == this)
               {
                  AllHitF.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
         this.objArr = new Array();
      }
   }
}

