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
            this._slotArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._slotArr;
      }
      
      public function addSlot(type:Achievement) : void
      {
         for(var i:uint = 0; i < 10; i++)
         {
            if(this._slotArr[i] == -1)
            {
               this._slotArr[i] = type;
               break;
            }
         }
      }
      
      public function getAc(num:Number) : Achievement
      {
         if(this._slotArr[num] != -1)
         {
            return this._slotArr[num];
         }
         return null;
      }
      
      public function clearAc() : void
      {
         for(var i:uint = 0; i < 10; i++)
         {
            this._slotArr[i] = -1;
         }
      }
   }
}

