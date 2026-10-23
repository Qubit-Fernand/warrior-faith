package com.hotpoint.braveManIII.views.npcTaskPanel
{
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.task.*;
   import src.*;
   
   public class NpcTaskData
   {
      
      public function NpcTaskData()
      {
         super();
      }
      
      public static function playerLevelFun() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(Main.player2 == null)
         {
            _loc1_ = Number(Main.player1.getLevel());
         }
         else
         {
            _loc2_ = Number(Main.player1.getLevel());
            _loc3_ = Number(Main.player2.getLevel());
            if(_loc2_ <= _loc3_)
            {
               _loc1_ = _loc2_;
            }
            else if(_loc3_ <= _loc2_)
            {
               _loc1_ = _loc3_;
            }
         }
         return _loc1_;
      }
      
      public static function playerRebirth() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(Main.player2 == null)
         {
            _loc1_ = Boolean(Main.player1.isRebirth());
         }
         else
         {
            _loc2_ = Main.player1.isRebirth();
            _loc3_ = Main.player2.isRebirth();
            if(Boolean(_loc2_) && Boolean(_loc3_))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public static function whoPlayer() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(1);
         if(Main.player2 != null)
         {
            _loc1_.push(2);
         }
         return _loc1_;
      }
      
      public static function getOneTask() : Array
      {
         var _loc1_:Number = Number(NpcTaskPanel.npcNum);
         var _loc2_:Boolean = playerRebirth();
         var _loc3_:Array = NpcListData.getOldTask();
         return TaskFactioy.addZxTask(_loc1_,_loc2_,_loc3_);
      }
      
      public static function getTowTask() : Array
      {
         var _loc1_:Number = Number(NpcTaskPanel.npcNum);
         var _loc2_:Array = whoPlayer();
         var _loc3_:Array = NpcListData.getOldTask();
         return TaskFactioy.addTansferTask(_loc1_,_loc2_,_loc3_);
      }
      
      public static function getThreeTask() : Array
      {
         var _loc1_:Number = Number(NpcTaskPanel.npcNum);
         var _loc2_:Boolean = playerRebirth();
         var _loc3_:Array = NpcListData.getOldTask();
         return TaskFactioy.addOther(_loc1_);
      }
      
      public static function getFourTask() : Array
      {
         var _loc1_:Number = Number(NpcTaskPanel.npcNum);
         var _loc2_:Boolean = playerRebirth();
         var _loc3_:Array = NpcListData.getOldTask();
         return TaskFactioy.addXhTask(_loc1_,_loc2_,_loc3_);
      }
      
      public static function updateOne() : Array
      {
         return okTaskZx(getOneTask());
      }
      
      public static function updateTow() : Array
      {
         return okTaskZz(getTowTask());
      }
      
      public static function updateThree() : Array
      {
         return okTaskTs(getThreeTask());
      }
      
      public static function updateFour() : Array
      {
         return okTaskXh(getFourTask());
      }
      
      public static function updateCw() : Array
      {
         return okTaskCw(getOneTask());
      }
      
      public static function okTaskZx(param1:Array) : Array
      {
         var _loc3_:TaskBasicData = null;
         var _loc4_:Task = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(NpcListData.isOldTaskOk(_loc3_.getTaskId()))
            {
               if(NpcListData.getTaskZx().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(_loc3_.getTaskId()) != null)
                  {
                     _loc4_ = NpcListData.taskByIdAndStata(_loc3_.getTaskId());
                     if(_loc4_.getStata() != 0)
                     {
                        _loc2_.push(_loc4_);
                     }
                     else
                     {
                        _loc2_.push(_loc3_.creatTask());
                     }
                  }
                  else
                  {
                     _loc2_.push(_loc3_.creatTask());
                  }
               }
               else
               {
                  _loc2_.push(_loc3_.creatTask());
               }
            }
         }
         return _loc2_;
      }
      
      public static function okTaskCw(param1:Array) : Array
      {
         var _loc3_:TaskBasicData = null;
         var _loc4_:Task = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(NpcListData.isOldTaskOk(_loc3_.getTaskId()))
            {
               if(NpcListData.getTaskCw().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(_loc3_.getTaskId()) != null)
                  {
                     _loc4_ = NpcListData.taskByIdAndStata(_loc3_.getTaskId());
                     if(_loc4_.getStata() != 0)
                     {
                        _loc2_.push(_loc4_);
                     }
                     else
                     {
                        _loc2_.push(_loc3_.creatTask());
                     }
                  }
                  else
                  {
                     _loc2_.push(_loc3_.creatTask());
                  }
               }
               else
               {
                  _loc2_.push(_loc3_.creatTask());
               }
            }
         }
         return _loc2_;
      }
      
      public static function okTaskXh(param1:Array) : Array
      {
         var _loc3_:TaskBasicData = null;
         var _loc4_:Task = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(NpcListData.getTaskXh().length > 0)
            {
               if(NpcListData.taskByIdAndStata(_loc3_.getTaskId()) != null)
               {
                  _loc4_ = NpcListData.taskByIdAndStata(_loc3_.getTaskId());
                  if(_loc4_.getStata() != 0)
                  {
                     _loc2_.push(_loc4_);
                  }
                  else
                  {
                     _loc2_.push(_loc3_.creatTask());
                  }
               }
               else
               {
                  _loc2_.push(_loc3_.creatTask());
               }
            }
            else
            {
               _loc2_.push(_loc3_.creatTask());
            }
         }
         return _loc2_;
      }
      
      public static function levelOk(param1:Array) : Array
      {
         var _loc4_:Number = NaN;
         var _loc5_:Task = null;
         var _loc2_:Array = [];
         var _loc3_:Number = playerLevelFun();
         if(_loc3_ - 10 < 1)
         {
            _loc4_ = 1;
         }
         else
         {
            _loc4_ = _loc3_ - 10;
         }
         trace(_loc4_ + "到" + _loc3_ + "的任务才能出现");
         for each(_loc5_ in param1)
         {
            if(_loc5_.getStata() != 0)
            {
               _loc2_.push(_loc5_);
            }
            else if(_loc5_.getTaskLevel() != -1)
            {
               if(_loc5_.getDelet())
               {
                  if(_loc5_.getTaskLevel() >= _loc4_ && _loc5_.getTaskLevel() <= _loc3_)
                  {
                     _loc2_.push(_loc5_);
                  }
               }
               else if(_loc3_ >= _loc5_.getTaskLevel())
               {
                  _loc2_.push(_loc5_);
               }
            }
            else
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      public static function okTaskZz(param1:Array) : Array
      {
         var _loc3_:TaskBasicData = null;
         var _loc4_:Task = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(NpcListData.isOldTaskOk(_loc3_.getTaskId()))
            {
               if(NpcListData.getTaskZz().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(_loc3_.getTaskId()) != null)
                  {
                     _loc4_ = NpcListData.taskByIdAndStata(_loc3_.getTaskId());
                     if(_loc4_.getStata() != 0)
                     {
                        _loc2_.push(_loc4_);
                     }
                     else
                     {
                        _loc2_.push(_loc3_.creatTask());
                     }
                  }
                  else
                  {
                     _loc2_.push(_loc3_.creatTask());
                  }
               }
               else
               {
                  _loc2_.push(_loc3_.creatTask());
               }
            }
         }
         return _loc2_;
      }
      
      public static function okTaskTs(param1:Array) : Array
      {
         var _loc3_:TaskBasicData = null;
         var _loc4_:Task = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(NpcListData.isOldTaskOk(_loc3_.getTaskId()))
            {
               if(NpcListData.getTaskTs().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(_loc3_.getTaskId()) != null)
                  {
                     _loc4_ = NpcListData.taskByIdAndStata(_loc3_.getTaskId());
                     if(_loc4_.getStata() != 0)
                     {
                        _loc2_.push(_loc4_);
                     }
                     else
                     {
                        _loc2_.push(_loc3_.creatTask());
                     }
                  }
                  else
                  {
                     _loc2_.push(_loc3_.creatTask());
                  }
               }
               else
               {
                  _loc2_.push(_loc3_.creatTask());
               }
            }
         }
         return _loc2_;
      }
   }
}

