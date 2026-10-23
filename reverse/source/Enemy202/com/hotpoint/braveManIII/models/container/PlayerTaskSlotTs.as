package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.task.Task;
   
   public class PlayerTaskSlotTs
   {
      
      private var _slotArr:Array = [];
      
      public function PlayerTaskSlotTs()
      {
         super();
      }
      
      public static function creatSlot() : PlayerTaskSlotTs
      {
         var _loc1_:PlayerTaskSlotTs = new PlayerTaskSlotTs();
         _loc1_.initSlotArr();
         return _loc1_;
      }
      
      private function initSlotArr() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 5)
         {
            this._slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._slotArr;
      }
      
      public function addSlot(param1:Task) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            if(this._slotArr[_loc2_] == -1)
            {
               this._slotArr[_loc2_] = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function getTask(param1:Number) : Task
      {
         if(this._slotArr[param1] != -1)
         {
            return this._slotArr[param1];
         }
         return null;
      }
      
      public function clearTask(param1:Number) : void
      {
         if(this._slotArr[param1] != -1)
         {
            this._slotArr[param1] = -1;
         }
      }
      
      public function allclearTask() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 5)
         {
            this._slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
   }
}

