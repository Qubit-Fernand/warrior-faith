package com.hotpoint.braveManIII.models.task
{
   public class NpcListData
   {
      
      private static var taskArrZx:Array = [];
      
      private static var taskArrTs:Array = [];
      
      private static var taskArrZz:Array = [];
      
      private static var taskArrXh:Array = [];
      
      private static var taskArrCw:Array = [];
      
      private static var oldTaskArr:Array = [];
      
      public function NpcListData()
      {
         super();
      }
      
      public static function saveTask() : Array
      {
         return [taskArrZx,taskArrTs,taskArrZz,oldTaskArr,taskArrXh,taskArrCw];
      }
      
      public static function clearTaskArr() : void
      {
         taskArrZx = [];
         taskArrTs = [];
         taskArrZz = [];
         taskArrXh = [];
         taskArrCw = [];
         oldTaskArr = [];
      }
      
      public static function duTask(arr:Array) : void
      {
         var xxx:Array = null;
         var xxx2:Array = null;
         taskArrZx = arr[0];
         taskArrTs = arr[1];
         taskArrZz = arr[2];
         oldTaskArr = arr[3];
         if(arr.length < 5)
         {
            xxx = [];
            arr[4] = xxx;
         }
         if(arr.length < 6)
         {
            xxx2 = [];
            arr[5] = xxx2;
         }
         taskArrXh = arr[4];
         taskArrCw = arr[5];
      }
      
      public static function setTaskZx(arr:Array) : void
      {
         taskArrZx = arr;
      }
      
      public static function getTaskZx() : Array
      {
         return taskArrZx;
      }
      
      public static function setTaskTs(arr:Array) : void
      {
         taskArrTs = arr;
      }
      
      public static function getTaskTs() : Array
      {
         return taskArrTs;
      }
      
      public static function setTaskZz(arr:Array) : void
      {
         taskArrZz = arr;
      }
      
      public static function getTaskZz() : Array
      {
         return taskArrZz;
      }
      
      public static function setTaskCw(arr:Array) : void
      {
         taskArrCw = arr;
      }
      
      public static function getTaskCw() : Array
      {
         return taskArrCw;
      }
      
      public static function setTaskXh(arr:Array) : void
      {
         taskArrXh = arr;
      }
      
      public static function getTaskXh() : Array
      {
         return taskArrXh;
      }
      
      public static function getZxjs() : Array
      {
         var data:Task = null;
         var arr:Array = [];
         for(var i:uint = 0; i < taskArrZx.length; i++)
         {
            data = taskArrZx[i] as Task;
            if(data.getStata() == 1 || data.getStata() == 2)
            {
               arr.push(data);
            }
         }
         return arr;
      }
      
      public static function zxNoGo() : Boolean
      {
         var data:Task = null;
         var num:Number = 0;
         for(var i:uint = 0; i < taskArrZx.length; i++)
         {
            data = taskArrZx[i] as Task;
            if(data.getStata() == 1 || data.getStata() == 2)
            {
               num++;
            }
         }
         if(num < 5)
         {
            return true;
         }
         return false;
      }
      
      public static function tsNoGo() : Boolean
      {
         var data:Task = null;
         var num:Number = 0;
         var arr:Array = xhArr();
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i] as Task;
            if(data.getStata() == 1 || data.getStata() == 2)
            {
               num++;
            }
         }
         if(num < 5)
         {
            return true;
         }
         return false;
      }
      
      private static function xhArr() : Array
      {
         var data:Task = null;
         var arr:Array = [];
         for(var i:uint = 0; i < taskArrZz.length; i++)
         {
            data = taskArrZz[i] as Task;
            arr.push(data);
         }
         for(i = 0; i < taskArrTs.length; i++)
         {
            data = taskArrTs[i] as Task;
            arr.push(data);
         }
         for(i = 0; i < taskArrXh.length; i++)
         {
            data = taskArrXh[i] as Task;
            arr.push(data);
         }
         for(i = 0; i < taskArrCw.length; i++)
         {
            data = taskArrCw[i] as Task;
            arr.push(data);
         }
         return arr;
      }
      
      public static function getTsjs() : Array
      {
         var data:Task = null;
         var arr:Array = [];
         var aaa:Array = xhArr();
         for(var i:uint = 0; i < aaa.length; i++)
         {
            data = aaa[i] as Task;
            if(data.getStata() == 1 || data.getStata() == 2)
            {
               arr.push(data);
            }
         }
         return arr;
      }
      
      public static function clearTask(id:Number) : void
      {
         var data:Task = null;
         for(var i:uint = 0; i < taskArrZx.length; i++)
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
         for(i = 0; i < taskArrXh.length; i++)
         {
            data = taskArrXh[i] as Task;
            if(data != null)
            {
               if(data.getId() == id)
               {
                  taskArrXh.splice(i,1);
                  return;
               }
            }
         }
         for(i = 0; i < taskArrCw.length; i++)
         {
            data = taskArrCw[i] as Task;
            if(data != null)
            {
               if(data.getId() == id)
               {
                  taskArrCw.splice(i,1);
                  return;
               }
            }
         }
      }
      
      public static function otherUpdataTask() : void
      {
         clearOld();
         updataTask();
      }
      
      public static function updataTask() : void
      {
         var data:Task = null;
         for(var i:uint = 0; i < taskArrZx.length; i++)
         {
            data = taskArrZx[i] as Task;
            if(data != null)
            {
               if(data.getStata() == 3)
               {
                  data.setStata(0);
               }
            }
         }
         for(i = 0; i < taskArrZz.length; i++)
         {
            data = taskArrZz[i] as Task;
            if(data != null)
            {
               if(data.getStata() == 3)
               {
                  data.setStata(0);
               }
            }
         }
         for(i = 0; i < taskArrTs.length; i++)
         {
            data = taskArrTs[i] as Task;
            if(data != null)
            {
               if(data.getStata() == 3)
               {
                  data.setStata(0);
               }
            }
         }
         for(i = 0; i < taskArrXh.length; i++)
         {
            data = taskArrXh[i] as Task;
            if(data != null)
            {
               if(data.getStata() == 3 || data.getStata() == 1 || data.getStata() == 2)
               {
                  data.setStata(0);
               }
            }
         }
      }
      
      public static function byTaskStata(num:Number) : Number
      {
         var data:Task = null;
         var arr:Array = [];
         if(num == 1)
         {
            arr = taskArrZx;
         }
         else if(num == 2)
         {
            arr = taskArrTs;
         }
         else if(num == 3)
         {
            arr = taskArrZz;
         }
         else if(num == 4)
         {
            arr = taskArrXh;
         }
         var _loc4_:int = 0;
         var _loc5_:* = arr;
         for each(data in _loc5_)
         {
            if(data.getStata() == 2)
            {
               return 2;
            }
            if(data.getStata() == 1)
            {
               return 1;
            }
            return 3;
         }
         return 3;
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
         for each(data in taskArrXh)
         {
            if(data.getId() == id)
            {
               return data;
            }
         }
         for each(data in taskArrCw)
         {
            if(data.getId() == id)
            {
               return data;
            }
         }
         return null;
      }
      
      public static function setStata(id:Number, num:Number) : void
      {
         var task:Task = taskByIdAndStata(id);
         task.setStata(num);
      }
      
      public static function getStata(id:Number) : Number
      {
         var task:Task = taskByIdAndStata(id);
         trace(id + "选中",task.getName() + ":名字" + task.getStata());
         return task.getStata();
      }
      
      public static function setOldTask(task:Task) : void
      {
         oldTaskArr.push(task);
      }
      
      public static function getOldTask() : Array
      {
         return oldTaskArr;
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
      
      public static function clearXhOldTask() : void
      {
         if(oldTaskArr.length < 1)
         {
            return;
         }
         for(var i:uint = 0; i < oldTaskArr.length; i++)
         {
            if(oldTaskArr[i].getBranch() == 4)
            {
               trace("清除:" + oldTaskArr[i].getName());
               oldTaskArr.splice(i,1);
            }
         }
      }
      
      public static function clearOld() : void
      {
         var j:uint = 0;
         if(oldTaskArr.length < 1)
         {
            return;
         }
         if(taskArrXh.length < 1)
         {
            return;
         }
         for(var i:uint = 0; i < taskArrXh.length; i++)
         {
            for(j = 0; j < oldTaskArr.length; j++)
            {
               if(taskArrXh[i].getId() == oldTaskArr[j].getId())
               {
                  trace("清除:" + oldTaskArr[j].getName());
                  oldTaskArr.splice(j,1);
               }
            }
         }
         trace(oldTaskArr + ":回收站");
      }
   }
}

