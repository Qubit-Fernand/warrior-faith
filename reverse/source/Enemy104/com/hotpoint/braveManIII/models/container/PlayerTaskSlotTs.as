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
         var playerSlot:PlayerTaskSlotTs = null;
         playerSlot = new PlayerTaskSlotTs();
         playerSlot.initSlotArr();
         return playerSlot;
      }
      
      public function allclearTask() : void
      {
         var i:uint = 0;
         for(i = 0; i < 5; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function clearTask(num:Number) : void
      {
         if(_slotArr[num] != -1)
         {
            _slotArr[num] = -1;
         }
      }
      
      public function addSlot(type:Task) : void
      {
         var i:uint = 0;
         for(i = 0; i < 5; i++)
         {
            if(_slotArr[i] == -1)
            {
               _slotArr[i] = type;
               break;
            }
         }
      }
      
      private function initSlotArr() : void
      {
         var i:uint = 0;
         for(i = 0; i < 5; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function getTask(num:Number) : Task
      {
         if(_slotArr[num] != -1)
         {
            return _slotArr[num];
         }
         return null;
      }
      
      public function getSlotArr() : Array
      {
         return _slotArr;
      }
   }
}

