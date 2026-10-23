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
         var bookSlot:MakeBookSlot = new MakeBookSlot();
         bookSlot.initSlotArr();
         return bookSlot;
      }
      
      private function initSlotArr() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _slotArr;
      }
      
      public function addSlot(type:Make) : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            if(_slotArr[i] == -1)
            {
               _slotArr[i] = type;
               break;
            }
         }
      }
      
      public function getMake(num:Number) : Make
      {
         if(_slotArr[num] != -1)
         {
            return _slotArr[num];
         }
         return null;
      }
      
      public function clearMake() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            _slotArr[i] = -1;
         }
      }
   }
}

