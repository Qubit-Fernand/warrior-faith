package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.make.Make;
   
   public class MakeBookSlot
   {
      
      private var _slotArr:Array = [];
      
      public function MakeBookSlot()
      {
         super();
      }
      
      public static function creatSlot() : MakeBookSlot
      {
         var _loc1_:MakeBookSlot = new MakeBookSlot();
         _loc1_.initSlotArr();
         return _loc1_;
      }
      
      private function initSlotArr() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            _slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _slotArr;
      }
      
      public function addSlot(param1:Make) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 4)
         {
            if(_slotArr[_loc2_] == -1)
            {
               _slotArr[_loc2_] = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function getMake(param1:Number) : Make
      {
         if(_slotArr[param1] != -1)
         {
            return _slotArr[param1];
         }
         return null;
      }
      
      public function clearMake() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            _slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
   }
}

