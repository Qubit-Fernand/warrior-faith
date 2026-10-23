package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.task.Task;
   
   public class TaskSlot
   {
      
      private var _arr:Array = [];
      
      public function TaskSlot()
      {
         super();
      }
      
      public static function creatSlot() : TaskSlot
      {
         var taskSlot:TaskSlot = new TaskSlot();
         taskSlot.initSlotArr();
         return taskSlot;
      }
      
      private function initSlotArr() : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            _arr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _arr;
      }
      
      public function addTask(task:Task) : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            if(_arr[i] == -1)
            {
               _arr[i] = task;
               break;
            }
         }
      }
      
      public function getTask(num:Number) : Task
      {
         if(_arr[num] != -1)
         {
            return _arr[num];
         }
         return null;
      }
      
      public function clearTask() : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            _arr[i] = -1;
         }
      }
   }
}

