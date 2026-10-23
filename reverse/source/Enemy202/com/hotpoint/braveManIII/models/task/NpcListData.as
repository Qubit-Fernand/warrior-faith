package com.hotpoint.braveManIII.models.task
{
   import src.tool.*;
   
   public class NpcListData
   {
      
      private static var taskArrZx:Array = [];
      
      private static var taskArrTs:Array = [];
      
      private static var taskArrZz:Array = [];
      
      private static var taskArrXh:Array = [];
      
      private static var taskArrCw:Array = [];
      
      public static var oldTaskArr:Array = [];
      
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
      
      public static function duTask(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Task = null;
         taskArrZx = param1[0];
         taskArrTs = param1[1];
         taskArrZz = param1[2];
         oldTaskArr = param1[3];
         if(param1.length < 5)
         {
            _loc3_ = [];
            param1[4] = _loc3_;
         }
         if(param1.length < 6)
         {
            _loc4_ = [];
            param1[5] = _loc4_;
         }
         taskArrXh = param1[4];
         taskArrCw = param1[5];
         var _loc2_:uint = 0;
         while(_loc2_ < oldTaskArr.length)
         {
            _loc5_ = oldTaskArr[_loc2_] as Task;
            if(_loc5_.getId() == 420001)
            {
               oldTaskArr.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < taskArrXh.length)
         {
            _loc5_ = taskArrXh[_loc2_] as Task;
            if(_loc5_.getId() == 420001)
            {
               taskArrXh.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      public static function setTaskZx(param1:Array) : void
      {
         taskArrZx = param1;
      }
      
      public static function getTaskZx() : Array
      {
         return taskArrZx;
      }
      
      public static function setTaskTs(param1:Array) : void
      {
         taskArrTs = param1;
      }
      
      public static function getTaskTs() : Array
      {
         return taskArrTs;
      }
      
      public static function setTaskZz(param1:Array) : void
      {
         taskArrZz = param1;
      }
      
      public static function getTaskZz() : Array
      {
         return taskArrZz;
      }
      
      public static function setTaskCw(param1:Array) : void
      {
         taskArrCw = param1;
      }
      
      public static function getTaskCw() : Array
      {
         return taskArrCw;
      }
      
      public static function setTaskXh(param1:Array) : void
      {
         taskArrXh = param1;
      }
      
      public static function getTaskXh() : Array
      {
         return taskArrXh;
      }
      
      public static function getZxjs() : Array
      {
         var _loc3_:Task = null;
         var _loc1_:Array = [];
         var _loc2_:uint = 0;
         while(_loc2_ < taskArrZx.length)
         {
            _loc3_ = taskArrZx[_loc2_] as Task;
            if(_loc3_.getStata() == 1 || _loc3_.getStata() == 2)
            {
               _loc1_.push(_loc3_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function zxNoGo() : Boolean
      {
         var _loc3_:Task = null;
         var _loc1_:Number = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < taskArrZx.length)
         {
            _loc3_ = taskArrZx[_loc2_] as Task;
            if(_loc3_.getStata() == 1 || _loc3_.getStata() == 2)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ < 5)
         {
            return true;
         }
         return false;
      }
      
      public static function tsNoGo() : Boolean
      {
         var _loc4_:Task = null;
         var _loc1_:Number = 0;
         var _loc2_:Array = xhArr();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as Task;
            if(_loc4_.getStata() == 1 || _loc4_.getStata() == 2)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         if(_loc1_ < 5)
         {
            return true;
         }
         return false;
      }
      
      private static function xhArr() : Array
      {
         var _loc1_:Task = null;
         var _loc2_:Array = [];
         var _loc3_:uint = 0;
         while(_loc3_ < taskArrZz.length)
         {
            _loc1_ = taskArrZz[_loc3_] as Task;
            _loc2_.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < taskArrTs.length)
         {
            _loc1_ = taskArrTs[_loc3_] as Task;
            _loc2_.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < taskArrXh.length)
         {
            _loc1_ = taskArrXh[_loc3_] as Task;
            _loc2_.push(_loc1_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < taskArrCw.length)
         {
            _loc1_ = taskArrCw[_loc3_] as Task;
            _loc2_.push(_loc1_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getTsjs() : Array
      {
         var _loc1_:Task = null;
         var _loc2_:Array = [];
         var _loc3_:Array = xhArr();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc4_] as Task;
            if(_loc1_.getStata() == 1 || _loc1_.getStata() == 2)
            {
               _loc2_.push(_loc1_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function clearTask(param1:Number) : void
      {
         var _loc2_:Task = null;
         var _loc3_:uint = 0;
         while(_loc3_ < taskArrZx.length)
         {
            _loc2_ = taskArrZx[_loc3_] as Task;
            if(_loc2_ != null)
            {
               if(_loc2_.getId() == param1)
               {
                  taskArrZx.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < taskArrZz.length)
         {
            _loc2_ = taskArrZz[_loc3_] as Task;
            if(_loc2_ != null)
            {
               if(_loc2_.getId() == param1)
               {
                  taskArrZz.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < taskArrTs.length)
         {
            _loc2_ = taskArrTs[_loc3_] as Task;
            if(_loc2_ != null)
            {
               if(_loc2_.getId() == param1)
               {
                  taskArrTs.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < taskArrXh.length)
         {
            _loc2_ = taskArrXh[_loc3_] as Task;
            if(_loc2_ != null)
            {
               if(_loc2_.getId() == param1)
               {
                  taskArrXh.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < taskArrCw.length)
         {
            _loc2_ = taskArrCw[_loc3_] as Task;
            if(_loc2_ != null)
            {
               if(_loc2_.getId() == param1)
               {
                  taskArrCw.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
      }
      
      public static function otherUpdataTask() : void
      {
         clearOld();
         updataTask();
      }
      
      public static function updataTask() : void
      {
         var _loc1_:Task = null;
         var _loc2_:uint = 0;
         while(_loc2_ < taskArrZx.length)
         {
            _loc1_ = taskArrZx[_loc2_] as Task;
            if(_loc1_ != null)
            {
               if(_loc1_.getStata() == 3)
               {
                  _loc1_.setStata(0);
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < taskArrZz.length)
         {
            _loc1_ = taskArrZz[_loc2_] as Task;
            if(_loc1_ != null)
            {
               if(_loc1_.getStata() == 3)
               {
                  _loc1_.setStata(0);
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < taskArrTs.length)
         {
            _loc1_ = taskArrTs[_loc2_] as Task;
            if(_loc1_ != null)
            {
               if(_loc1_.getStata() == 3)
               {
                  _loc1_.setStata(0);
               }
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < taskArrXh.length)
         {
            _loc1_ = taskArrXh[_loc2_] as Task;
            if(_loc1_ != null)
            {
               if(_loc1_.getStata() == 3 || _loc1_.getStata() == 1 || _loc1_.getStata() == 2)
               {
                  _loc1_.setStata(0);
               }
            }
            _loc2_++;
         }
      }
      
      public static function byTaskStata(param1:Number) : Number
      {
         var _loc2_:Task = null;
         var _loc3_:Array = [];
         if(param1 == 1)
         {
            _loc3_ = taskArrZx;
         }
         else if(param1 == 2)
         {
            _loc3_ = taskArrTs;
         }
         else if(param1 == 3)
         {
            _loc3_ = taskArrZz;
         }
         else if(param1 == 4)
         {
            _loc3_ = taskArrXh;
         }
         var _loc4_:int = 0;
         var _loc5_:* = _loc3_;
         for each(_loc2_ in _loc5_)
         {
            if(_loc2_.getStata() == 2)
            {
               return 2;
            }
            if(_loc2_.getStata() == 1)
            {
               return 1;
            }
            return 3;
         }
         return 3;
      }
      
      public static function taskByIdAndStata(param1:Number) : Task
      {
         var _loc2_:Task = null;
         for each(_loc2_ in taskArrZx)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in taskArrZz)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in taskArrTs)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in taskArrXh)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in taskArrCw)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function setStata(param1:Number, param2:Number) : void
      {
         var _loc3_:Task = taskByIdAndStata(param1);
         _loc3_.setStata(param2);
      }
      
      public static function getStata(param1:Number) : Number
      {
         var _loc2_:Task = taskByIdAndStata(param1);
         trace(param1 + "选中",_loc2_.getName() + ":名字" + _loc2_.getStata());
         return _loc2_.getStata();
      }
      
      public static function setOldTask(param1:Task) : void
      {
         oldTaskArr.push(param1);
      }
      
      public static function getOldTask() : Array
      {
         return oldTaskArr;
      }
      
      public static function isOldTaskOk(param1:Number) : Boolean
      {
         var _loc2_:Task = null;
         if(oldTaskArr.length < 1)
         {
            return true;
         }
         for each(_loc2_ in oldTaskArr)
         {
            if(_loc2_.getId() == param1)
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
         var _loc1_:uint = 0;
         while(_loc1_ < oldTaskArr.length)
         {
            if((oldTaskArr[_loc1_] as Task).getBranch() == 4)
            {
               trace("清除:" + oldTaskArr[_loc1_].getName());
               oldTaskArr.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public static function clearOld() : void
      {
         var _loc2_:uint = 0;
         if(oldTaskArr.length < 1)
         {
            return;
         }
         if(taskArrXh.length < 1)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < taskArrXh.length)
         {
            _loc2_ = 0;
            while(_loc2_ < oldTaskArr.length)
            {
               if(taskArrXh[_loc1_].getId() == oldTaskArr[_loc2_].getId())
               {
                  trace("清除:" + oldTaskArr[_loc2_].getName());
                  oldTaskArr.splice(_loc2_,1);
               }
               _loc2_++;
            }
            _loc1_++;
         }
         trace(oldTaskArr + ":回收站");
      }
      
      public static function getZxInOld() : Number
      {
         var _loc3_:Task = null;
         var _loc1_:Number = 0;
         var _loc2_:Array = oldTaskArr;
         if(_loc2_.length > 0)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.getBranch() == 1)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public static function getCwInOld() : Number
      {
         var _loc3_:Task = null;
         var _loc1_:Number = 0;
         var _loc2_:Array = oldTaskArr;
         if(_loc2_.length > 0)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_.getBranch() == 5)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
   }
}

