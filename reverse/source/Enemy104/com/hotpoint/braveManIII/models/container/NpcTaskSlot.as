package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.task.Task;
   
   public class NpcTaskSlot
   {
      
      private var _slotArr:Array = [];
      
      public function NpcTaskSlot()
      {
         super();
      }
      
      public static function creatSlot() : NpcTaskSlot
      {
         var npcSlot:NpcTaskSlot = null;
         npcSlot = new NpcTaskSlot();
         npcSlot.initSlotArr();
         return npcSlot;
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
         for(i = 0; i < 10; i++)
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
         for(i = 0; i < 10; i++)
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

