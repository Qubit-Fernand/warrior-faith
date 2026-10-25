package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.achievement.Achievement;
   
   public class AchSlot
   {
      
      private var _slotArr:Array = [];
      
      public function AchSlot()
      {
         super();
      }
      
      public static function creatSlot() : AchSlot
      {
         var _loc1_:AchSlot = new AchSlot();
         _loc1_.initSlotArr();
         return _loc1_;
      }
      
      private function initSlotArr() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 10)
         {
            _slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _slotArr;
      }
      
      public function addSlot(param1:Achievement) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 10)
         {
            if(_slotArr[_loc2_] == -1)
            {
               _slotArr[_loc2_] = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function getAc(param1:Number) : Achievement
      {
         if(_slotArr[param1] != -1)
         {
            return _slotArr[param1];
         }
         return null;
      }
      
      public function clearAc() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 10)
         {
            _slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
   }
}

