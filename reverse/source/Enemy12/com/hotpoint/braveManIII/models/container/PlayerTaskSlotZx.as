package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.task.Task;
   
   public class PlayerTaskSlotZx
   {
      
      private var _slotArr:Array = [];
      
      public function PlayerTaskSlotZx()
      {
         super();
      }
      
      public static function creatSlot() : PlayerTaskSlotZx
      {
         var playerSlot:PlayerTaskSlotZx = null;
         playerSlot = new PlayerTaskSlotZx();
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
         trace("清除:" + num);
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

