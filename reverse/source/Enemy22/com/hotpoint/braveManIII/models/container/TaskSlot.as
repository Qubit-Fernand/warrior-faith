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
            this._arr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._arr;
      }
      
      public function addTask(task:Task) : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            if(this._arr[i] == -1)
            {
               this._arr[i] = task;
               break;
            }
         }
      }
      
      public function getTask(num:Number) : Task
      {
         if(this._arr[num] != -1)
         {
            return this._arr[num];
         }
         return null;
      }
      
      public function clearTask() : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            this._arr[i] = -1;
         }
      }
   }
}

