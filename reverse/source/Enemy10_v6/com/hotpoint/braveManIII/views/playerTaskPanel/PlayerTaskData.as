package com.hotpoint.braveManIII.views.playerTaskPanel
{
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.task.*;
   import src.*;
   
   public class PlayerTaskData
   {
      
      private static var bo:Boolean;
      
      public static var taskArrZx:Array = [];
      
      public static var taskArrTs:Array = [];
      
      public static var zxTaskNum:Number = 5;
      
      public static var tsTaskNum:Number = 5;
      
      public function PlayerTaskData()
      {
         super();
      }
      
      public static function getTaskZx() : Array
      {
         taskArrZx = NpcListData.getZxjs();
         return taskArrZx;
      }
      
      public static function getTaskTs() : Array
      {
         taskArrTs = NpcListData.getTsjs();
         return taskArrTs;
      }
      
      public static function allTaskArr() : Array
      {
         var allArr:Array = [];
         var all1:Array = getTaskZx();
         var all2:Array = getTaskTs();
         for(var i:uint = 0; i < all1.length; i++)
         {
            allArr.push(all1[i]);
         }
         for(i = 0; i < all2.length; i++)
         {
            allArr.push(all2[i]);
         }
         return allArr;
      }
      
      public static function isTaskById(id:Number) : Boolean
      {
         var data:Task = null;
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getId() == id)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function clearTask(id:Number) : void
      {
         var data:Task = null;
         for(var i:uint = 0; i < zxTaskNum; i++)
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
         for(i = 0; i < tsTaskNum; i++)
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
      
      public static function noZxTask() : Boolean
      {
         if(taskArrZx.length < 1)
         {
            return false;
         }
         return true;
      }
      
      public static function noTsTask() : Boolean
      {
         if(taskArrTs.length < 1)
         {
            return false;
         }
         return true;
      }
      
      public static function addEnemyNum(enemyId:Number) : void
      {
         var data:Task = null;
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getEnemyId() != null)
            {
               if(data.isEnemyId(enemyId))
               {
                  if(data.getSkillEnemyNum(enemyId) < data.getEnemyMaxNum(enemyId))
                  {
                     data.addSkillEnemyNum(enemyId);
                  }
               }
            }
         }
      }
      
      public static function addGoodsNum() : void
      {
         var data:Task = null;
         var numArr:Array = null;
         var numArr1:Array = null;
         var allArr:Array = null;
         var i:uint = 0;
         var arr:Array = allTaskArr();
         trace("检查收集");
         for each(data in arr)
         {
            trace(data.getGoodsId() + "是否有收集");
            if(data.getGoodsId() != null)
            {
               numArr = [];
               numArr1 = [];
               allArr = [];
               if(data.getWho() == 1)
               {
                  numArr = goodsNum(data.getGoodsId(),Main.player1.getBag(),data.getId());
                  data.setGoodsed(numArr);
               }
               else if(data.getWho() == 2)
               {
                  numArr1 = goodsNum(data.getGoodsId(),Main.player2.getBag(),data.getId());
                  data.setGoodsed(numArr1);
               }
               else if(data.getWho() == 3)
               {
                  numArr = goodsNum(data.getGoodsId(),Main.player1.getBag(),data.getId());
                  if(Main.P1P2)
                  {
                     numArr1 = goodsNum(data.getGoodsId(),Main.player2.getBag(),data.getId());
                     for(i = 0; i < numArr.length; i++)
                     {
                        allArr.push(numArr[i] + numArr1[i]);
                        data.setGoodsed(allArr);
                     }
                  }
                  else
                  {
                     trace("写入收集:" + numArr);
                     data.setGoodsed(numArr);
                  }
               }
            }
         }
      }
      
      public static function goodsNum(arr:Array, bag:Bag, id:Number) : Array
      {
         var numArr:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(id != 210002)
            {
               numArr.push(bag.fallQusetBag(arr[i]));
            }
            else
            {
               numArr.push(bag.getOtherobjNum(arr[i]));
            }
            trace(arr[i] + ":收集的物品_________");
         }
         trace(numArr + "已经收集的数量");
         return numArr;
      }
      
      public static function getAddBag(taskId:Number) : Boolean
      {
         var arr1:Array = [-1,-1,-1,-1];
         var arr2:Array = [-1,-1,-1,-1];
         var arrNum:Array = TaskFactioy.getGoodsIdAndNan(taskId);
         for(var i:uint = 0; i < arrNum.length; i++)
         {
            if(Main.player1.getBag().fallQusetBag(arrNum[i][0]) >= arrNum[i][1])
            {
               arr1[i] = 1;
            }
            if(Main.P1P2)
            {
               if(Main.player2.getBag().fallQusetBag(arrNum[i][0]) >= arrNum[i][1])
               {
                  arr2[i] = 1;
               }
            }
         }
         if(Main.P1P2 == false)
         {
            for(i = 0; i < arrNum.length; i++)
            {
               if(arr1[i] == -1)
               {
                  return false;
               }
            }
         }
         else
         {
            for(i = 0; i < arrNum.length; i++)
            {
               if(arr1[i] == -1 || arr2[i] == -1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function addMapId(mapId:Number) : void
      {
         var data:Task = null;
         trace("存入的地图ID:" + mapId);
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getMapId() != -1)
            {
               if(mapId != 0)
               {
                  data.setMaped(mapId);
               }
            }
         }
      }
      
      public static function addTime(time:Number) : void
      {
         var data:Task = null;
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getTimer() != -1)
            {
               if(data.ismapOk())
               {
                  if(data.isTgOk())
                  {
                     trace("地图条件满足才存入时间");
                     data.setTimer(time);
                  }
                  else
                  {
                     data.setMaped(0);
                     data.setTimer(0);
                     trace("没通关,地图设置为不符合,时间为0");
                  }
               }
               else
               {
                  data.setTimer(0);
                  data.setTging(false);
               }
            }
         }
      }
      
      public static function addLj(num:Number) : void
      {
         var data:Task = null;
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getLianji() != -1)
            {
               if(data.ismapOk())
               {
                  data.setLianjied(num);
               }
               else
               {
                  data.setLianjied(0);
               }
            }
         }
      }
      
      public static function addBett(num:Number) : void
      {
         var data:Task = null;
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getBett() != -1)
            {
               if(data.ismapOk())
               {
                  data.setBetted(num);
               }
               else
               {
                  data.setBetted(0);
               }
            }
         }
      }
      
      public static function addGold() : void
      {
         var data:Task = null;
         var g1:Number = NaN;
         var g2:Number = NaN;
         trace("对比金币");
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getFinishGold() != -1)
            {
               if(data.getWho() == 1)
               {
                  data.setFinishGold(Main.player1.getGold());
               }
               else if(data.getWho() == 2)
               {
                  data.setFinishGold(Main.player2.getGold());
               }
               else if(data.getWho() == 3)
               {
                  g1 = Number(Main.player1.getGold());
                  if(Main.P1P2)
                  {
                     g2 = Number(Main.player2.getGold());
                     if(g1 <= g2)
                     {
                        data.setFinishGold(g1);
                     }
                     else
                     {
                        data.setFinishGold(g2);
                     }
                     trace("存入",g1,g2);
                  }
                  else
                  {
                     data.setFinishGold(g1);
                  }
               }
            }
         }
      }
      
      public static function addLevel() : void
      {
         var data:Task = null;
         var l1:Number = NaN;
         var l2:Number = NaN;
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getLevel() != -1)
            {
               if(data.getWho() == 1)
               {
                  data.setLeveling(Main.player1.getLevel());
               }
               else if(data.getWho() == 2)
               {
                  data.setLeveling(Main.player2.getLevel());
               }
               else if(data.getWho() == 3)
               {
                  trace("等级需求_共同的任务");
                  l1 = Number(Main.player1.getLevel());
                  if(Main.P1P2)
                  {
                     trace("2玩家");
                     l2 = Number(Main.player2.getLevel());
                     if(l1 <= l2)
                     {
                        data.setLeveling(l1);
                     }
                     else
                     {
                        data.setLeveling(l2);
                     }
                  }
                  else
                  {
                     trace("1玩家L1" + l1);
                     data.setLeveling(l1);
                  }
               }
            }
         }
      }
      
      public static function addTg() : void
      {
         var data:Task = null;
         if(Main.gameNum == 0)
         {
            return;
         }
         var arr:Array = allTaskArr();
         for each(data in arr)
         {
            if(data.getTg())
            {
               data.setTging(true);
            }
         }
      }
      
      public static function addTaskData() : void
      {
         trace(Main.gameNum + ":Main.gameNumgameNumgameNumgameNum");
         addMapId(Main.gameNum);
         addLevel();
         addGold();
         addGoodsNum();
         addLj(WinShow.txt_2);
         addBett(WinShow.txt_3);
         addTime(WinShow.txt_1);
      }
   }
}

