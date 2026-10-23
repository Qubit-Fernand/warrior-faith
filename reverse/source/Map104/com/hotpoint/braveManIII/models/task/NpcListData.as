package com.hotpoint.braveManIII.models.task
{
   public class NpcListData
   {
      
      private static var taskArrZx:Array = [];
      
      private static var taskArrTs:Array = [];
      
      private static var taskArrZz:Array = [];
      
      private static var oldTaskArr:Array = [];
      
      public function NpcListData()
      {
         super();
      }
      
      public static function isOldTaskOk(id:Number) : Boolean
      {
         var data:Task = null;
         if(oldTaskArr.length < 1)
         {
            return true;
         }
         for each(data in oldTaskArr)
         {
            if(data.getId() == id)
            {
               return false;
            }
         }
         return true;
      }
      
      public static function getTaskTs() : Array
      {
         return taskArrTs;
      }
      
      public static function setTaskZx(arr:Array) : void
      {
         taskArrZx = arr;
      }
      
      public static function setTaskTs(arr:Array) : void
      {
         taskArrTs = arr;
      }
      
      public static function setTaskZz(arr:Array) : void
      {
         taskArrZz = arr;
      }
      
      public static function setStata(id:Number, num:Number) : void
      {
         var task:Task = null;
         task = taskByIdAndStata(id);
         task.setStata(num);
      }
      
      public static function taskByIdAndStata(id:Number) : Task
      {
         var data:Task = null;
         for each(data in taskArrZx)
         {
            if(data.getId() == id)
            {
               return data;
            }
         }
         for each(data in taskArrZz)
         {
            if(data.getId() == id)
            {
               return data;
            }
         }
         for each(data in taskArrTs)
         {
            if(data.getId() == id)
            {
               return data;
            }
         }
         return null;
      }
      
      public static function getOldTask() : Array
      {
         return oldTaskArr;
      }
      
      public static function setOldTask(task:Task) : void
      {
         oldTaskArr.push(task);
      }
      
      public static function clearTask(id:Number) : void
      {
         var data:Task = null;
         var i:uint = 0;
         for(i = 0; i < taskArrZx.length; i++)
         {
            data = taskArrZx[i] as Task;
            if(data != null)
            {
               if(data.getId() == id)
               {
                  taskArrZx.splice(i,1);
                  return;
               }
            }
         }
         for(i = 0; i < taskArrZz.length; i++)
         {
            data = taskArrZz[i] as Task;
            if(data != null)
            {
               if(data.getId() == id)
               {
                  taskArrZz.splice(i,1);
                  return;
               }
            }
         }
         for(i = 0; i < taskArrTs.length; i++)
         {
            data = taskArrTs[i] as Task;
            if(data != null)
            {
               if(data.getId() == id)
               {
                  taskArrTs.splice(i,1);
                  return;
               }
            }
         }
      }
      
      public static function getTaskZz() : Array
      {
         return taskArrZz;
      }
      
      public static function getStata(id:Number) : Number
      {
         var task:Task = null;
         task = taskByIdAndStata(id);
         return task.getStata();
      }
      
      public static function getTaskZx() : Array
      {
         return taskArrZx;
      }
      
      public static function getZxjs() : Array
      {
         var arr:Array = null;
         var i:uint = 0;
         var data:Task = null;
         arr = [];
         for(i = 0; i < taskArrZx.length; i++)
         {
            data = taskArrZx[i] as Task;
            if(data.getStata() == 1 || data.getStata() == 2)
            {
               arr.push(data);
            }
         }
         return arr;
      }
      
      public static function getTsjs() : Array
      {
         var data:Task = null;
         var arr:Array = null;
         var i:uint = 0;
         arr = [];
         for(i = 0; i < taskArrZz.length; i++)
         {
            data = taskArrZz[i] as Task;
            if(data.getStata() == 1 || data.getStata() == 2)
            {
               arr.push(data);
            }
         }
         return arr;
      }
   }
}

