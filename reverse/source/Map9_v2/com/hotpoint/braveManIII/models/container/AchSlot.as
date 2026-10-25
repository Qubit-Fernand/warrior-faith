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
         var acSlot:AchSlot = new AchSlot();
         acSlot.initSlotArr();
         return acSlot;
      }
      
      private function initSlotArr() : void
      {
         for(var i:uint = 0; i < 10; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _slotArr;
      }
      
      public function addSlot(type:Achievement) : void
      {
         for(var i:uint = 0; i < 10; i++)
         {
            if(_slotArr[i] == -1)
            {
               _slotArr[i] = type;
               break;
            }
         }
      }
      
      public function getAc(num:Number) : Achievement
      {
         if(_slotArr[num] != -1)
         {
            return _slotArr[num];
         }
         return null;
      }
      
      public function clearAc() : void
      {
         for(var i:uint = 0; i < 10; i++)
         {
            _slotArr[i] = -1;
         }
      }
   }
}

