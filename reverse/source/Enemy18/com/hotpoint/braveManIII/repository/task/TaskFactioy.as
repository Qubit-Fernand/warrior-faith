package com.hotpoint.braveManIII.repository.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.task.*;
   
   public class TaskFactioy
   {
      
      public static var ii:uint;
      
      public static var myXml:XML = new XML();
      
      public static var taskArr:Array = [];
      
      public function TaskFactioy()
      {
         super();
      }
      
      public static function creatTaskFactory() : TaskFactioy
      {
         var data:TaskFactioy = new TaskFactioy();
         data.creatLoard();
      }
      
      public static function getTaskBayId(id:Number) : TaskBasicData
      {
         var tData:TaskBasicData = null;
         var data:TaskBasicData = null;
         for each(data in taskArr)
         {
            if(data.getTaskId() == id)
            {
               tData = data;
            }
         }
         if(tData == null)
         {
            throw new Error("找不到基础数据!id:" + id);
         }
         return tData;
      }
      
      public static function getUrl(id:Number) : String
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getUrl();
      }
      
      public static function getMapId(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         if(data.getMapId() != -1)
         {
            return data.getMapId();
         }
         return -1;
      }
      
      public static function getEnemyId(id:Number) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = getTaskBayId(id);
         var eId:Array = data.getEnemyId();
         var vtArr:Array = [];
         if(eId.length > 0)
         {
            for(i = 0; i < eId.length; i++)
            {
               vtArr.push(eId[i].getValue());
            }
            return vtArr;
         }
         return null;
      }
      
      public static function getEnemyName(id:Number) : Array
      {
         var data:TaskBasicData = getTaskBayId(id);
         var eName:Array = data.getEnemyName();
         if(eName.length > 0)
         {
            return eName;
         }
         return null;
      }
      
      public static function getEnemyNum(id:Number) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = getTaskBayId(id);
         var eNum:Array = data.getEnemyNum();
         var vtArr:Array = [];
         if(eNum.length > 0)
         {
            for(i = 0; i < eNum.length; i++)
            {
               vtArr.push(eNum[i].getValue());
            }
            return vtArr;
         }
         return null;
      }
      
      public static function getEenmyIdAndNan(id:Number) : Array
      {
         var i:uint = 0;
         var eId:Array = getEnemyId(id);
         var eNum:Array = getEnemyNum(id);
         var eArr:Array = [];
         if(eId.length > 0)
         {
            for(i = 0; i < eId.length; i++)
            {
               eArr[i] = [eId[i],eNum[i]];
            }
            return eArr;
         }
         return null;
      }
      
      public static function getGoodsId(id:Number) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = getTaskBayId(id);
         var gId:Array = data.getGoodsId();
         var vtArr:Array = [];
         if(gId.length > 0)
         {
            for(i = 0; i < gId.length; i++)
            {
               vtArr.push(gId[i].getValue());
            }
            return vtArr;
         }
         return null;
      }
      
      public static function getGoodsNum(id:Number) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = getTaskBayId(id);
         var gNum:Array = data.getGoodsNum();
         var vtArr:Array = [];
         if(gNum.length > 0)
         {
            for(i = 0; i < gNum.length; i++)
            {
               vtArr.push(gNum[i].getValue());
            }
            return vtArr;
         }
         return null;
      }
      
      public static function getGoodsIdAndNan(id:Number) : Array
      {
         var i:uint = 0;
         var gId:Array = getGoodsId(id);
         var gNum:Array = getGoodsNum(id);
         var grr:Array = [];
         if(gId.length > 0)
         {
            for(i = 0; i < gId.length; i++)
            {
               grr[i] = [gId[i],gNum[i]];
            }
            return grr;
         }
         return null;
      }
      
      public static function getGoodsMaxNum(id:Number, fallId:Number) : Number
      {
         var i:uint = 0;
         var arr:Array = getGoodsIdAndNan(id);
         if(arr.length > 0)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(arr[i][0] == fallId)
               {
                  return arr[i][1];
               }
            }
         }
         return -1;
      }
      
      public static function getLianjiNum(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         if(data.getLianjiNum() != -1)
         {
            return data.getLianjiNum();
         }
         return -1;
      }
      
      public static function getFightNum(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         if(data.getFightNum() != -1)
         {
            return data.getFightNum();
         }
         return -1;
      }
      
      public static function getTimeNum(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         if(data.getTimeNum() != -1)
         {
            return data.getTimeNum();
         }
         return -1;
      }
      
      public static function getFinishGold(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         if(data.getFinishGold() != -1)
         {
            return data.getFinishGold();
         }
         return -1;
      }
      
      public static function getFinishiLevel(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         if(data.getFinishLevel() != -1)
         {
            return data.getFinishLevel();
         }
         return -1;
      }
      
      public static function getTg(id:Number) : Boolean
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getTg();
      }
      
      public static function getTaskBranch(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getBranch();
      }
      
      public static function getTaskName(id:Number) : String
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getTaskName();
      }
      
      public static function getTaskLevel(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getLevel();
      }
      
      public static function getDelet(id:Number) : Boolean
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getDeletet();
      }
      
      public static function getTaskIntroduction(id:Number) : String
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getTaskIntroduction();
      }
      
      public static function getTaskDemand(id:Number) : String
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getDemand();
      }
      
      public static function getTaskDemandType(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getDemandType();
      }
      
      public static function getWho(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getWho();
      }
      
      public static function isAgin(id:Number) : Boolean
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.isAgin();
      }
      
      public static function isRc(id:Number) : Boolean
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.isRc();
      }
      
      public static function getAwardType(id:Number) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = getTaskBayId(id);
         var arr1:Array = [];
         var arr:Array = data.getAwardType();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               arr1.push(arr[i].getValue());
            }
         }
         return arr1;
      }
      
      public static function getAwardId(id:Number) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = getTaskBayId(id);
         var arr1:Array = [];
         var arr:Array = data.getAwardId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               arr1.push(arr[i].getValue());
            }
         }
         return arr1;
      }
      
      public static function getAwardNum(id:Number) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = getTaskBayId(id);
         var arr:Array = [];
         var arr1:Array = data.getAwardNum();
         if(arr1 != null)
         {
            for(i = 0; i < arr1.length; i++)
            {
               arr.push(arr1[i].getValue());
            }
         }
         return arr;
      }
      
      public static function getAwardTypeAndId(id:Number) : Array
      {
         var i:uint = 0;
         var tType:Array = getAwardType(id);
         var tId:Array = getAwardId(id);
         var arrArr:Array = [];
         if(tType != null)
         {
            for(i = 0; i < tType.length; i++)
            {
               arrArr[i] = [tType[i],tId[i]];
            }
         }
         return arrArr;
      }
      
      public static function getGold(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getGold();
      }
      
      public static function getExp(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getExp();
      }
      
      public static function getPlayerDtate(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getPlayerStata();
      }
      
      public static function addBranchTask(branch:Number) : Array
      {
         var data:TaskBasicData = null;
         var bArr:Array = [];
         for each(data in taskArr)
         {
            if(data.getBranch() == branch)
            {
               bArr.push(data);
            }
         }
         if(bArr.length < 1)
         {
            trace("没有满足主干分支的任务");
         }
         return bArr;
      }
      
      public static function addTaskLevel(arr:Array, level:Number) : Array
      {
         var lowLevel:uint = 0;
         var data:TaskBasicData = null;
         var t1:Array = [];
         var maxLevel:uint = level;
         if(level - 10 >= 1)
         {
            lowLevel = level - 10;
         }
         else
         {
            lowLevel = 1;
         }
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i] as TaskBasicData;
            if(data.getLevel() <= maxLevel && data.getLevel() >= lowLevel)
            {
               t1.push(data);
            }
         }
         if(t1.length < 1)
         {
            trace("没有满足角色级别的任务");
         }
         return t1;
      }
      
      public static function addTaskRebirth(arr:Array, rebirth:Boolean) : Array
      {
         var data:TaskBasicData = null;
         var t1:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i] as TaskBasicData;
            if(!data.getRebirth())
            {
               t1.push(data);
            }
            else if(rebirth)
            {
               t1.push(data);
            }
         }
         if(t1.length < 1)
         {
            trace("没有满足重生的任务");
         }
         return t1;
      }
      
      public static function addBeforeTask(arr:Array, oldBeforeTaskId:Array) : Array
      {
         var t1:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(arr[i].getBeforeTaskId() != -1)
            {
               if(!NpcListData.isOldTaskOk(arr[i].getBeforeTaskId()))
               {
                  t1.push(arr[i]);
               }
            }
            else if(arr[i].getBeforeTaskId() == -1)
            {
               t1.push(arr[i]);
            }
         }
         if(t1.length < 1)
         {
            trace("没有前置的任务");
         }
         return t1;
      }
      
      public static function addWhoTask(arr:Array, whoArr:Array) : Array
      {
         var data:TaskBasicData = null;
         var j:uint = 0;
         var t1:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i] as TaskBasicData;
            for(j = 0; j < whoArr.length; j++)
            {
               if(data.getWho() == 3)
               {
                  t1.push(data);
                  break;
               }
               if(data.getWho() == whoArr[j])
               {
                  t1.push(data);
                  break;
               }
            }
         }
         if(t1 == null)
         {
            trace("没角色符合");
         }
         return t1;
      }
      
      public static function addPickTask(arr:Array, pickArr:Array) : Array
      {
         var data:TaskBasicData = null;
         var j:uint = 0;
         var t1:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            data = arr[i] as TaskBasicData;
            for(j = 0; j < pickArr.length; j++)
            {
               if(data.getPickSkill() == pickArr[j])
               {
                  t1.push(data);
               }
            }
         }
         if(t1.length < 1)
         {
            trace("没有满足选择武器的任务");
         }
         return t1;
      }
      
      public static function addZxTask(branch:Number, rebirth:Boolean, oldBeforeTaskId:Array) : Array
      {
         trace(branch + "分支");
         var branchArr:Array = addBranchTask(branch);
         var rebirthArr:Array = addTaskRebirth(branchArr,rebirth);
         return addBeforeTask(rebirthArr,oldBeforeTaskId);
      }
      
      public static function addTansferTask(branch:Number, who:Array, oldBeforeTaskId:Array) : Array
      {
         var branchArr:Array = addBranchTask(branch);
         var whoArr:Array = addWhoTask(branchArr,who);
         trace(whoArr + ":whoArrwhoArrwhoArrwhoArrwhoArr");
         var oldBeForArr:Array = addBeforeTask(whoArr,oldBeforeTaskId);
         trace("可以接的特殊任务" + oldBeForArr);
         return oldBeForArr;
      }
      
      public static function addOther(branch:Number) : Array
      {
         var taskArr:Array = [];
         var branchArr:Array = addBranchTask(branch);
         return branchArr;
      }
      
      public static function addXhTask(branch:Number, rebirth:Boolean, oldBeforeTaskId:Array) : Array
      {
         trace(branch + "循环");
         var branchArr:Array = addBranchTask(branch);
         var rebirthArr:Array = addTaskRebirth(branchArr,rebirth);
         return addBeforeTask(rebirthArr,oldBeforeTaskId);
      }
      
      public static function creantTaskArr(arr:Array) : Array
      {
         var i:uint = 0;
         var data:TaskBasicData = null;
         var t1:Array = [];
         if(arr != "")
         {
            for(i = 0; i < arr.length; i++)
            {
               data = arr[i];
               t1.push(data.creatTask());
            }
         }
         return t1;
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var property:XML = null;
         var taskId:Number = NaN;
         var taskName:String = null;
         var taskLevel:Number = NaN;
         var taskDe:Boolean = false;
         var taskBranch:Number = NaN;
         var taskIntroduction:String = null;
         var taskDemand:String = null;
         var who:Number = NaN;
         var agin:Boolean = false;
         var rc:Boolean = false;
         var mapId:Number = NaN;
         var enemyId:XMLList = null;
         var enemyName:XMLList = null;
         var enemyNum:XMLList = null;
         var goodsId:XMLList = null;
         var goodsNum:XMLList = null;
         var lianjiNum:Number = NaN;
         var fightNum:Number = NaN;
         var timeNum:Number = NaN;
         var finishGold:Number = NaN;
         var finishLevel:Number = NaN;
         var tg:Boolean = false;
         var beforeTaskId:Number = NaN;
         var rebirth:Boolean = false;
         var awardType:XMLList = null;
         var awardId:XMLList = null;
         var awardNum:XMLList = null;
         var gold:Number = NaN;
         var exp:Number = NaN;
         var playersDate:Number = NaN;
         var url:String = null;
         var e1:Array = null;
         var e2:Array = null;
         var e3:Array = null;
         var g1:Array = null;
         var g2:Array = null;
         var a1:Array = null;
         var a2:Array = null;
         var a3:Array = null;
         var data:TaskBasicData = null;
         for each(property in myXml.任务)
         {
            taskId = Number(property.任务ID);
            taskName = String(property.任务名称);
            taskLevel = Number(property.任务级数);
            taskDe = (property.是否消失.toString() == "true") as Boolean;
            taskBranch = Number(property.任务分支);
            taskIntroduction = String(property.任务介绍);
            taskDemand = String(property.任务需求);
            who = Number(property.指定玩家);
            agin = (property.是否重生.toString() == "true") as Boolean;
            rc = (property.是否日常.toString() == "true") as Boolean;
            mapId = Number(property.完成条件.地图ID);
            enemyId = property.完成条件.杀怪.怪物ID;
            enemyName = property.完成条件.杀怪.怪物名字;
            enemyNum = property.完成条件.杀怪.怪物数量;
            goodsId = property.完成条件.搜集物品.物品ID;
            goodsNum = property.完成条件.搜集物品.物品数量;
            lianjiNum = Number(property.完成条件.连击数);
            fightNum = Number(property.完成条件.被击打数);
            timeNum = Number(property.完成条件.时间);
            finishGold = Number(property.完成条件.完成金币);
            finishLevel = Number(property.完成条件.完成等级);
            tg = (property.完成条件.通关.toString() == "true") as Boolean;
            beforeTaskId = Number(property.出现任务条件.前置任务ID);
            rebirth = (property.出现任务条件.重生.toString() == "true") as Boolean;
            awardType = property.奖励.奖励物品.奖励类型;
            awardId = property.奖励.奖励物品.奖励id;
            awardNum = property.奖励.奖励物品.奖励数量;
            gold = Number(property.奖励.金币);
            exp = Number(property.奖励.经验);
            playersDate = Number(property.奖励.奖励状态);
            url = String(property.论坛链接);
            e1 = [];
            e2 = [];
            e3 = [];
            g1 = [];
            g2 = [];
            a1 = [];
            a2 = [];
            a3 = [];
            for each(property in awardType)
            {
               if(property != -1)
               {
                  a1.push(VT.createVT(property));
               }
            }
            for each(property in awardId)
            {
               if(property != -1)
               {
                  a2.push(VT.createVT(property));
               }
            }
            for each(property in awardNum)
            {
               if(property != -1)
               {
                  a3.push(VT.createVT(property));
               }
            }
            for each(property in enemyId)
            {
               if(property != -1)
               {
                  e1.push(VT.createVT(property));
               }
            }
            for each(property in enemyName)
            {
               if(property != -1)
               {
                  e3.push(property);
               }
            }
            for each(property in enemyNum)
            {
               if(property != -1)
               {
                  e2.push(VT.createVT(property));
               }
            }
            for each(property in goodsId)
            {
               if(property != -1)
               {
                  g1.push(VT.createVT(property));
               }
            }
            for each(property in goodsNum)
            {
               if(property != -1)
               {
                  g2.push(VT.createVT(property));
               }
            }
            data = TaskBasicData.creatTaskBasicData(taskId,taskName,taskLevel,taskDe,taskBranch,taskIntroduction,taskDemand,who,agin,rc,mapId,e1,e3,e2,g1,g2,lianjiNum,fightNum,timeNum,finishGold,finishLevel,tg,beforeTaskId,rebirth,a1,a2,a3,gold,exp,playersDate,url);
            taskArr.push(data);
         }
      }
      
      public function getBeforeTaskId(id:Number) : Number
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getBeforeTaskId();
      }
      
      public function getTaskRebirth(id:Number) : Boolean
      {
         var data:TaskBasicData = getTaskBayId(id);
         return data.getRebirth();
      }
   }
}

