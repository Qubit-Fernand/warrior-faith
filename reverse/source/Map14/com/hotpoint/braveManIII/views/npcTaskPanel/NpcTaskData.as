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
         var level:Number = NaN;
         var l1:Number = NaN;
         var l2:Number = NaN;
         if(Main.player2 == null)
         {
            level = Number(Main.player1.getLevel());
         }
         else
         {
            l1 = Number(Main.player1.getLevel());
            l2 = Number(Main.player2.getLevel());
            if(l1 <= l2)
            {
               level = l1;
            }
            else if(l2 <= l1)
            {
               level = l2;
            }
         }
         return level;
      }
      
      public static function playerRebirth() : Boolean
      {
         var be:Boolean = false;
         var b1:* = undefined;
         var b2:* = undefined;
         if(Main.player2 == null)
         {
            be = Boolean(Main.player1.isRebirth());
         }
         else
         {
            b1 = Main.player1.isRebirth();
            b2 = Main.player2.isRebirth();
            if(Boolean(b1) && Boolean(b2))
            {
               be = true;
            }
         }
         return be;
      }
      
      public static function whoPlayer() : Array
      {
         var arr:Array = [];
         arr.push(1);
         if(Main.player2 != null)
         {
            arr.push(2);
         }
         return arr;
      }
      
      public static function getOneTask() : Array
      {
         var npc:Number = Number(NpcTaskPanel.npcNum);
         var rebirth:Boolean = playerRebirth();
         var oldArr:Array = NpcListData.getOldTask();
         return TaskFactioy.addZxTask(npc,rebirth,oldArr);
      }
      
      public static function getTowTask() : Array
      {
         var npc:Number = Number(NpcTaskPanel.npcNum);
         var whoArr:Array = whoPlayer();
         var oldArr:Array = NpcListData.getOldTask();
         return TaskFactioy.addTansferTask(npc,whoArr,oldArr);
      }
      
      public static function getThreeTask() : Array
      {
         var npc:Number = Number(NpcTaskPanel.npcNum);
         var rebirth:Boolean = playerRebirth();
         var oldArr:Array = NpcListData.getOldTask();
         return TaskFactioy.addOther(npc);
      }
      
      public static function getFourTask() : Array
      {
         var npc:Number = Number(NpcTaskPanel.npcNum);
         var rebirth:Boolean = playerRebirth();
         var oldArr:Array = NpcListData.getOldTask();
         return TaskFactioy.addXhTask(npc,rebirth,oldArr);
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
      
      public static function okTaskZx(arr:Array) : Array
      {
         var data:TaskBasicData = null;
         var task:Task = null;
         var t1:Array = [];
         for each(data in arr)
         {
            if(NpcListData.isOldTaskOk(data.getTaskId()))
            {
               if(NpcListData.getTaskZx().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(data.getTaskId()) != null)
                  {
                     task = NpcListData.taskByIdAndStata(data.getTaskId());
                     if(task.getStata() != 0)
                     {
                        t1.push(task);
                     }
                     else
                     {
                        t1.push(data.creatTask());
                     }
                  }
                  else
                  {
                     t1.push(data.creatTask());
                  }
               }
               else
               {
                  t1.push(data.creatTask());
               }
            }
         }
         return t1;
      }
      
      public static function okTaskCw(arr:Array) : Array
      {
         var data:TaskBasicData = null;
         var task:Task = null;
         var t1:Array = [];
         for each(data in arr)
         {
            if(NpcListData.isOldTaskOk(data.getTaskId()))
            {
               if(NpcListData.getTaskCw().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(data.getTaskId()) != null)
                  {
                     task = NpcListData.taskByIdAndStata(data.getTaskId());
                     if(task.getStata() != 0)
                     {
                        t1.push(task);
                     }
                     else
                     {
                        t1.push(data.creatTask());
                     }
                  }
                  else
                  {
                     t1.push(data.creatTask());
                  }
               }
               else
               {
                  t1.push(data.creatTask());
               }
            }
         }
         return t1;
      }
      
      public static function okTaskXh(arr:Array) : Array
      {
         var data:TaskBasicData = null;
         var task:Task = null;
         var t1:Array = [];
         for each(data in arr)
         {
            if(NpcListData.getTaskXh().length > 0)
            {
               if(NpcListData.taskByIdAndStata(data.getTaskId()) != null)
               {
                  task = NpcListData.taskByIdAndStata(data.getTaskId());
                  if(task.getStata() != 0)
                  {
                     t1.push(task);
                  }
                  else
                  {
                     t1.push(data.creatTask());
                  }
               }
               else
               {
                  t1.push(data.creatTask());
               }
            }
            else
            {
               t1.push(data.creatTask());
            }
         }
         return t1;
      }
      
      public static function levelOk(arr:Array) : Array
      {
         var losLevel:Number = NaN;
         var data:Task = null;
         var tarr:Array = [];
         var maxLevel:Number = playerLevelFun();
         if(maxLevel - 10 < 1)
         {
            losLevel = 1;
         }
         else
         {
            losLevel = maxLevel - 10;
         }
         trace(losLevel + "到" + maxLevel + "的任务才能出现");
         for each(data in arr)
         {
            if(data.getStata() != 0)
            {
               tarr.push(data);
            }
            else if(data.getTaskLevel() != -1)
            {
               if(data.getDelet())
               {
                  if(data.getTaskLevel() >= losLevel && data.getTaskLevel() <= maxLevel)
                  {
                     tarr.push(data);
                  }
               }
               else if(maxLevel >= data.getTaskLevel())
               {
                  tarr.push(data);
               }
            }
            else
            {
               tarr.push(data);
            }
         }
         return tarr;
      }
      
      public static function okTaskZz(arr:Array) : Array
      {
         var data:TaskBasicData = null;
         var task:Task = null;
         var t1:Array = [];
         for each(data in arr)
         {
            if(NpcListData.isOldTaskOk(data.getTaskId()))
            {
               if(NpcListData.getTaskZz().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(data.getTaskId()) != null)
                  {
                     task = NpcListData.taskByIdAndStata(data.getTaskId());
                     if(task.getStata() != 0)
                     {
                        t1.push(task);
                     }
                     else
                     {
                        t1.push(data.creatTask());
                     }
                  }
                  else
                  {
                     t1.push(data.creatTask());
                  }
               }
               else
               {
                  t1.push(data.creatTask());
               }
            }
         }
         return t1;
      }
      
      public static function okTaskTs(arr:Array) : Array
      {
         var data:TaskBasicData = null;
         var task:Task = null;
         var t1:Array = [];
         for each(data in arr)
         {
            if(NpcListData.isOldTaskOk(data.getTaskId()))
            {
               if(NpcListData.getTaskTs().length > 0)
               {
                  if(NpcListData.taskByIdAndStata(data.getTaskId()) != null)
                  {
                     task = NpcListData.taskByIdAndStata(data.getTaskId());
                     if(task.getStata() != 0)
                     {
                        t1.push(task);
                     }
                     else
                     {
                        t1.push(data.creatTask());
                     }
                  }
                  else
                  {
                     t1.push(data.creatTask());
                  }
               }
               else
               {
                  t1.push(data.creatTask());
               }
            }
         }
         return t1;
      }
   }
}

