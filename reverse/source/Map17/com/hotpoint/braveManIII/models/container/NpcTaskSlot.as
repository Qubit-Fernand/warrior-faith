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
         var npcSlot:NpcTaskSlot = new NpcTaskSlot();
         npcSlot.initSlotArr();
         return npcSlot;
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
      
      public function addSlot(type:Task) : void
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
      
      public function getTask(num:Number) : Task
      {
         if(_slotArr[num] != -1)
         {
            return _slotArr[num];
         }
         return null;
      }
      
      public function clearTask(num:Number) : void
      {
         if(_slotArr[num] != -1)
         {
            _slotArr[num] = -1;
         }
      }
   }
}

