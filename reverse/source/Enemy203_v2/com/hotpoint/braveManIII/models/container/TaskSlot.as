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
         var _loc1_:TaskSlot = new TaskSlot();
         _loc1_.initSlotArr();
         return _loc1_;
      }
      
      private function initSlotArr() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 15)
         {
            this._arr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._arr;
      }
      
      public function addTask(param1:Task) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 15)
         {
            if(this._arr[_loc2_] == -1)
            {
               this._arr[_loc2_] = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function getTask(param1:Number) : Task
      {
         if(this._arr[param1] != -1)
         {
            return this._arr[param1];
         }
         return null;
      }
      
      public function clearTask() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 15)
         {
            this._arr[_loc1_] = -1;
            _loc1_++;
         }
      }
   }
}

