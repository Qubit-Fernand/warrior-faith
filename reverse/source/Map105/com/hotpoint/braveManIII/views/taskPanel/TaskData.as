package com.hotpoint.braveManIII.views.taskPanel
{
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.task.Task;
   import com.hotpoint.braveManIII.repository.task.*;
   import src.*;
   import src.tool.*;
   
   public class TaskData
   {
      
      public static var taskArr:Array = [];
      
      private static var playerIngTask:Array = [];
      
      private static var taskingArr:Array = [];
      
      private static var taskedArr:Array = [];
      
      private static var zxArr:Array = [];
      
      private static var xhArr:Array = [];
      
      private static var mrArr:Array = [];
      
      private static var jrArr:Array = [];
      
      private static var wtArr:Array = [];
      
      private static var oldArr:Array = [0,0,0,0,0,0];
      
      private static var currArr:Array = [0,0,0,0,0,0];
      
      public static var nowArr:Array = [0,0,0,0,0,0];
      
      public static var tsTaskArr:Array = [420008,420009,420010,420011,420012,420013,420014,420015,420016,420017,420018,420019,420020,420021,420022,420023,420024,420025,420026,420027,420028,420029,420030,420031,420032,420033,420034,420035,420036,420037,420038,420026,420027];
      
      public static var saveArr:Array = [];
      
      public function TaskData()
      {
         super();
      }
      
      public static function isTsTask(id:Number) : Boolean
      {
         for(var i:uint = 0; i < tsTaskArr.length; i++)
         {
            if(id == tsTaskArr[i])
            {
               return true;
            }
         }
         return false;
      }
      
      public static function initAllTask() : void
      {
         if(taskArr.length == 0)
         {
            taskArr = TaskFactory.allTask;
            duTask();
            yjPlayer();
         }
      }
      
      private static function yjPlayer() : void
      {
         taskingArr = taskIngFun();
         taskedArr = taskedFun();
         playerIngTask = statePlayer();
      }
      
      public static function otherUpdataTask() : void
      {
         var data:Task = null;
         for each(data in taskArr)
         {
            if(data.getSmallType() == 2)
            {
               data.initData();
               clearGoods(data,1);
            }
         }
      }
      
      public static function updateEd() : void
      {
         var data:Task = null;
         for each(data in taskArr)
         {
            if(data.getSmallType() == 2)
            {
               if(data.getState() == 3 && Main.serverTime.getValue() > data.getOverTime())
               {
                  otherUpdataTask();
                  break;
               }
            }
         }
      }
      
      public static function duTask() : void
      {
         var i:uint = 0;
         var j:uint = 0;
         var task:Task = null;
         var id:Number = NaN;
         if(saveArr.length != 0)
         {
            for(i = 1; i < saveArr.length; i++)
            {
               if(saveArr[i] != null)
               {
                  for(j = 0; j < taskArr.length; j++)
                  {
                     task = taskArr[j];
                     id = task.getId();
                     if(task.getSmallType() != 1)
                     {
                        if(i == id)
                        {
                           if(task.getSmallType() == 0)
                           {
                              if(saveArr[id][0] == 2)
                              {
                                 task.setState(0);
                              }
                              else
                              {
                                 task.setState(saveArr[id][0]);
                              }
                              task.setOldTime(saveArr[id][1]);
                              task.setGoodsed(saveArr[id][2]);
                              task.setEneSave(saveArr[id][3]);
                              task.setOverTime(saveArr[id][4]);
                           }
                           else
                           {
                              task.setState(saveArr[id][0]);
                              task.setOldTime(saveArr[id][1]);
                              task.setGoodsed(saveArr[id][2]);
                              task.setEneSave(saveArr[id][3]);
                              task.setOverTime(saveArr[id][4]);
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public static function duxx() : void
      {
         var task:Task = null;
         for(var i:uint = 0; i < taskArr.length; i++)
         {
            task = taskArr[i];
         }
      }
      
      public static function saveTask() : Array
      {
         var data:Task = null;
         var id:Number = NaN;
         var smallType:Number = NaN;
         for each(data in taskArr)
         {
            id = data.getId();
            smallType = data.getSmallType();
            if(!saveArr[id])
            {
               saveArr[id] = [];
            }
            if(smallType != 1)
            {
               saveArr[id] = [data.getState(),data.getOldTime(),data.getGoodsedNum(),data.getEenemyedNum(),data.getOverTime()];
            }
         }
         return saveArr;
      }
      
      public static function initTaskInState() : void
      {
         yjPlayer();
         var arr:Array = qzOk(reOk(levelOk(stateNpc())));
         mrArr = getSmallType(getBigType(arr,0),2);
         zxArr = getSmallType(getBigType(arr,0),0);
         xhArr = getSmallType(getBigType(arr,0),1);
         jrArr = getBigType(arr,2);
         wtArr = getBigType(arr,1);
         if(taskedArr != null)
         {
            currArr[0] = taskedArr.length;
         }
         else
         {
            currArr[0] = 0;
         }
         if(mrArr != null)
         {
            currArr[1] = mrArr.length;
         }
         else
         {
            currArr[1] = 0;
         }
         if(zxArr != null)
         {
            currArr[2] = zxArr.length;
         }
         else
         {
            currArr[2] = 0;
         }
         if(xhArr != null)
         {
            currArr[3] = xhArr.length;
         }
         else
         {
            currArr[3] = 0;
         }
         if(jrArr != null)
         {
            currArr[4] = jrArr.length;
         }
         else
         {
            currArr[4] = 0;
         }
         if(wtArr != null)
         {
            currArr[5] = wtArr.length;
         }
         else
         {
            currArr[5] = 0;
         }
      }
      
      public static function initNewText() : void
      {
         for(var i:uint = 0; i < 6; i++)
         {
            nowArr[i] = currArr[i] - oldArr[i];
         }
      }
      
      public static function setOldArr(num:Number) : void
      {
         oldArr[num] = currArr[num];
      }
      
      public static function clearOldTaskNum(task:Task) : void
      {
         if(task.getBigType() == 0)
         {
            if(task.getSmallType() == 0)
            {
               if(oldArr[2] > 0)
               {
                  --oldArr[2];
               }
            }
            else if(task.getSmallType() == 1)
            {
               if(oldArr[3] > 0)
               {
                  --oldArr[3];
               }
            }
            else if(task.getSmallType() == 2)
            {
               if(oldArr[1] > 0)
               {
                  --oldArr[1];
               }
            }
         }
         else if(task.getBigType() == 1)
         {
            if(oldArr[5] > 0)
            {
               --oldArr[5];
            }
         }
         else if(task.getBigType() == 2)
         {
            if(oldArr[4] > 0)
            {
               --oldArr[4];
            }
         }
      }
      
      public static function playerLevelFun() : Number
      {
         var l1:Number = NaN;
         var l2:Number = NaN;
         var level:Number = 0;
         if(!Main.P1P2)
         {
            level = Number(Main.player1.getLevel());
         }
         else
         {
            l1 = Number(Main.player1.getLevel());
            l2 = Number(Main.player2.getLevel());
            level = l1;
            if(l2 < l1)
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
         if(!Main.P1P2)
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
      
      public static function statePlayer() : Array
      {
         var data:Task = null;
         var arr:Array = [];
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               arr.push(data);
            }
         }
         if(taskedArr != null)
         {
            for each(data in taskedArr)
            {
               arr.unshift(data);
            }
         }
         if(arr.length == 0)
         {
            return null;
         }
         return arr;
      }
      
      public static function taskIngFun() : Array
      {
         var data:Task = null;
         if(taskArr.length == 0)
         {
            return null;
         }
         var arr:Array = [];
         for each(data in taskArr)
         {
            if(data.getState() == 1)
            {
               arr.push(data);
            }
         }
         if(arr.length == 0)
         {
            return null;
         }
         return arr;
      }
      
      public static function taskedFun() : Array
      {
         var data:Task = null;
         if(taskArr.length == 0)
         {
            return null;
         }
         var arr:Array = [];
         for each(data in taskArr)
         {
            if(data.getState() == 2)
            {
               arr.push(data);
            }
         }
         if(arr.length == 0)
         {
            return null;
         }
         return arr;
      }
      
      public static function stateNpc() : Array
      {
         var data:Task = null;
         if(taskArr.length == 0)
         {
            return null;
         }
         var arr:Array = [];
         for each(data in taskArr)
         {
            if(data.getSmallType() == 0)
            {
               if(data.getState() == 0 && data.getOldTime() == 0)
               {
                  arr.push(data);
               }
            }
            else if(data.getState() == 0)
            {
               arr.push(data);
            }
         }
         if(arr.length == 0)
         {
            return null;
         }
         return arr;
      }
      
      public static function levelOk(arr:Array) : Array
      {
         var data:Task = null;
         if(arr == null)
         {
            return null;
         }
         var larr:Array = [];
         var plevel:Number = playerLevelFun();
         for each(data in arr)
         {
            if(data.getLevel() <= plevel)
            {
               larr.push(data);
            }
         }
         if(larr.length == 0)
         {
            return null;
         }
         return larr;
      }
      
      public static function reOk(arr:Array) : Array
      {
         var data:Task = null;
         if(arr == null)
         {
            return null;
         }
         var rarr:Array = [];
         var bo:Boolean = playerRebirth();
         for each(data in arr)
         {
            if(data.getRebirth())
            {
               if(bo)
               {
                  rarr.push(data);
               }
            }
            else
            {
               rarr.push(data);
            }
         }
         if(rarr.length == 0)
         {
            return null;
         }
         return rarr;
      }
      
      public static function qzOk(arr:Array) : Array
      {
         var data:Task = null;
         if(arr == null)
         {
            return null;
         }
         var qarr:Array = [];
         for each(data in arr)
         {
            if(data.getBeforeTaskId() != -1)
            {
               if(isOldById(data.getBeforeTaskId()))
               {
                  qarr.push(data);
               }
            }
            else
            {
               qarr.push(data);
            }
         }
         if(qarr.length == 0)
         {
            return null;
         }
         return qarr;
      }
      
      public static function isOldById(id:Number) : Boolean
      {
         var data:Task = null;
         for each(data in taskArr)
         {
            if(data.getId() == id)
            {
               if(data.getOldTime() > 0)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function getBigType(arr:Array, num:Number) : Array
      {
         var data:Task = null;
         if(arr == null)
         {
            return null;
         }
         var arr1:Array = [];
         for each(data in arr)
         {
            if(data.getBigType() == num)
            {
               arr1.push(data);
            }
         }
         if(arr1.length == 0)
         {
            return null;
         }
         return arr1;
      }
      
      public static function getSmallType(arr:Array, num:Number) : Array
      {
         var data:Task = null;
         if(arr == null)
         {
            return null;
         }
         var arr1:Array = [];
         for each(data in arr)
         {
            if(data.getSmallType() == num)
            {
               arr1.push(data);
            }
         }
         if(arr1.length == 0)
         {
            return null;
         }
         return arr1;
      }
      
      public static function getArr(arr:Array, num:Number) : Array
      {
         if(arr == null)
         {
            return null;
         }
         var arr2:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr.length >= num)
            {
               arr2.push(arr.splice(0,num));
            }
            else if(arr.length > 0)
            {
               arr2.push(arr.splice(0));
               break;
            }
            i--;
         }
         return arr2;
      }
      
      public static function getTypeByBtn(num:Number = 0) : Array
      {
         var lastArr:Array = [];
         initTaskInState();
         if(num == 0)
         {
            lastArr = playerIngTask;
         }
         else if(num == 1)
         {
            lastArr = mrArr;
         }
         else if(num == 2)
         {
            lastArr = zxArr;
         }
         else if(num == 3)
         {
            lastArr = xhArr;
         }
         else if(num == 4)
         {
            lastArr = jrArr;
         }
         else if(num == 5)
         {
            lastArr = wtArr;
         }
         return getArr(lastArr,15);
      }
      
      public static function isOk() : void
      {
         var data:Task = null;
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               if(data.getState() != 2)
               {
                  data.isTaskOk();
               }
            }
         }
      }
      
      public static function isOkTow() : void
      {
         var data:Task = null;
         if(taskedArr != null)
         {
            for each(data in taskedArr)
            {
               if(data.getState() == 2 && isTsTask(data.getId()))
               {
                  data.isTaskOk();
               }
            }
         }
      }
      
      public static function initGk() : void
      {
         if(Main.gameNum.getValue() != 0)
         {
            if(Main.gameNum2.getValue() == 1)
            {
               if(taskingArr != null)
               {
                  setMapAndStar(Main.gameNum.getValue(),GameData.gameLV);
                  initAcData();
                  isOk();
               }
            }
         }
      }
      
      private static function initAcData() : void
      {
         var data:Task = null;
         for each(data in taskingArr)
         {
            data.intGk();
         }
      }
      
      private static function setMapAndStar(mapId:Number, mapStar:Number) : void
      {
         var data:Task = null;
         for each(data in taskingArr)
         {
            data.setMapId(mapId);
            data.setMapStar(mapStar);
         }
      }
      
      public static function setTg() : void
      {
         var data:Task = null;
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               data.setTg();
            }
         }
      }
      
      public static function setEnemyNum(id:Number) : void
      {
         var data:Task = null;
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               data.setEnemyNum(id);
            }
         }
      }
      
      public static function addGoods(id:Number) : void
      {
         var data:Task = null;
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               if(data.getGoodsId()[0].getValue() != -1)
               {
                  data.setGoods(id);
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
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               if((data.getId() == 210002 || isTsTask(data.getId())) && data.getGoodsId()[0].getValue() != -1)
               {
                  numArr = [];
                  numArr1 = [];
                  allArr = [];
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
                     data.setGoodsed(numArr);
                  }
               }
            }
         }
      }
      
      public static function addGoodsNumTow() : void
      {
         var data:Task = null;
         var numArr:Array = null;
         var numArr1:Array = null;
         var allArr:Array = null;
         var i:uint = 0;
         if(taskedArr != null)
         {
            for each(data in taskedArr)
            {
               if((data.getId() == 210002 || isTsTask(data.getId())) && data.getGoodsId()[0].getValue() != -1)
               {
                  numArr = [];
                  numArr1 = [];
                  allArr = [];
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
            if(id != 210002 && isTsTask(id) == false)
            {
               numArr.push(bag.fallQusetBag(arr[i].getValue()));
            }
            else
            {
               numArr.push(bag.getOtherobjNum(arr[i].getValue()));
            }
         }
         return numArr;
      }
      
      public static function getAddBag(taskId:Number) : Boolean
      {
         var arr1:Array = [];
         var arr2:Array = [];
         var task:Task = isTaskById(taskId);
         var arrId:Array = task.getGoodsId();
         var arrNum:Array = task.getGoodsNum();
         for(var i:uint = 0; i < arrId.length; i++)
         {
            arr1[i] = -1;
            arr2[i] = -1;
            if(Main.player1.getBag().fallQusetBag(arrId[i].getValue()) >= arrNum[i].getValue())
            {
               arr1[i] = 1;
            }
            if(Main.P1P2)
            {
               if(Main.player2.getBag().fallQusetBag(arrId[i].getValue()) >= arrNum[i].getValue())
               {
                  arr2[i] = 1;
               }
            }
         }
         if(!Main.P1P2)
         {
            for(i = 0; i < arrId.length; i++)
            {
               if(arr1[i] == -1)
               {
                  return false;
               }
            }
         }
         else
         {
            for(i = 0; i < arrId.length; i++)
            {
               if(arr1[i] == -1 || arr2[i] == -1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function isTaskById(id:Number) : Task
      {
         var data:Task = null;
         if(taskingArr == null)
         {
            return null;
         }
         for each(data in taskingArr)
         {
            if(id == data.getId())
            {
               if(data.isMapStarOk())
               {
                  return data;
               }
            }
         }
         return null;
      }
      
      public static function clearGold(task:Task) : void
      {
         if(task.getFinishGold() != -1)
         {
            Main.player1.payGold(task.getFinishGold());
            if(Main.P1P2)
            {
               Main.player2.payGold(task.getFinishGold());
            }
         }
      }
      
      public static function clearGoods(task:Task, type:Number = 0) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         var sl:Number = NaN;
         if(task.getGoodsId()[0].getValue() != -1)
         {
            arr = task.getGoodsId();
            for(i = 0; i < arr.length; i++)
            {
               sl = Number(task.getGoodsNum()[i].getValue());
               clearP1orP2(arr[i].getValue(),task.getId(),type,sl);
            }
         }
      }
      
      public static function clearP1orP2(id:Number, taskId:Number, type:Number, sl:Number = 0) : void
      {
         if(taskId != 210002 && isTsTask(taskId) == false)
         {
            Main.player1.getBag().clearQuest(id);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearQuest(id);
            }
         }
         else if(taskId == 210002)
         {
            if(type == 0)
            {
               Main.player1.getBag().clearOther(id);
               if(Main.P1P2)
               {
                  Main.player2.getBag().clearOther(id);
               }
            }
         }
         else if(type == 0)
         {
            trace("扣除特殊___",sl);
            Main.player1.getBag().delOtherById(id,sl);
            if(Main.P1P2)
            {
               Main.player2.getBag().delOtherById(id,sl);
            }
         }
      }
      
      public static function getZxInOld() : Number
      {
         var data:Task = null;
         var num:Number = 0;
         for each(data in taskArr)
         {
            if(data.getSmallType() == 0 && data.getOldTime() > 0)
            {
               num++;
            }
         }
         return num;
      }
      
      public static function isEnemyTaskOk() : void
      {
         var data:Task = null;
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               if(data.getState() != 2 && data.getEnemyId()[0].getValue() != -1)
               {
                  data.isTaskOk();
               }
            }
         }
      }
      
      public static function setOk(id:Number) : void
      {
         var data:Task = null;
         if(taskingArr != null)
         {
            for each(data in taskingArr)
            {
               if(id == data.getId())
               {
                  data.setState(2);
               }
            }
         }
      }
   }
}

