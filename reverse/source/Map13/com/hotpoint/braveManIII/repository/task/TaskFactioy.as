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
      
      public static function getTaskDemandType(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getDemandType();
      }
      
      public static function getAwardType(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var arr1:Array = null;
         var arr:Array = null;
         var i:uint = 0;
         data = getTaskBayId(id);
         arr1 = [];
         arr = data.getAwardType();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               arr1.push(arr[i].getValue());
            }
         }
         return arr1;
      }
      
      public static function addWhoTask(arr:Array, whoArr:Array) : Array
      {
         var t1:Array = null;
         var i:uint = 0;
         var data:TaskBasicData = null;
         var j:uint = 0;
         t1 = [];
         for(i = 0; i < arr.length; i++)
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
      
      public static function getTaskBranch(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getBranch();
      }
      
      public static function addPickTask(arr:Array, pickArr:Array) : Array
      {
         var t1:Array = null;
         var i:uint = 0;
         var data:TaskBasicData = null;
         var j:uint = 0;
         t1 = [];
         for(i = 0; i < arr.length; i++)
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
      
      public static function getWho(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getWho();
      }
      
      public static function getFinishGold(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         if(data.getFinishGold() != -1)
         {
            return data.getFinishGold();
         }
         return -1;
      }
      
      public static function creantTaskArr(arr:Array) : Array
      {
         var t1:Array = null;
         var i:uint = 0;
         var data:TaskBasicData = null;
         t1 = [];
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
      
      public static function getEnemyId(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var eId:Array = null;
         var vtArr:Array = null;
         var i:uint = 0;
         data = getTaskBayId(id);
         eId = data.getEnemyId();
         vtArr = [];
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
      
      public static function isAgin(id:Number) : Boolean
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.isAgin();
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
      
      public static function addXhTask(branch:Number, rebirth:Boolean, oldBeforeTaskId:Array) : Array
      {
         var branchArr:Array = null;
         var rebirthArr:Array = null;
         var oldBeForArr:Array = null;
         trace(branch + "循环");
         branchArr = addBranchTask(branch);
         rebirthArr = addTaskRebirth(branchArr,rebirth);
         return addBeforeTask(rebirthArr,oldBeforeTaskId);
      }
      
      public static function getEenmyIdAndNan(id:Number) : Array
      {
         var eId:Array = null;
         var eNum:Array = null;
         var eArr:Array = null;
         var i:uint = 0;
         eId = getEnemyId(id);
         eNum = getEnemyNum(id);
         eArr = [];
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
      
      public static function addBeforeTask(arr:Array, oldBeforeTaskId:Array) : Array
      {
         var t1:Array = null;
         var i:uint = 0;
         t1 = [];
         for(i = 0; i < arr.length; i++)
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
      
      public static function getTaskName(id:Number) : String
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getTaskName();
      }
      
      public static function getAwardId(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var arr1:Array = null;
         var arr:Array = null;
         var i:uint = 0;
         data = getTaskBayId(id);
         arr1 = [];
         arr = data.getAwardId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               arr1.push(arr[i].getValue());
            }
         }
         return arr1;
      }
      
      public static function addTansferTask(branch:Number, who:Array, oldBeforeTaskId:Array) : Array
      {
         var branchArr:Array = null;
         var whoArr:Array = null;
         var oldBeForArr:Array = null;
         branchArr = addBranchTask(branch);
         whoArr = addWhoTask(branchArr,who);
         trace(whoArr + ":whoArrwhoArrwhoArrwhoArrwhoArr");
         oldBeForArr = addBeforeTask(whoArr,oldBeforeTaskId);
         trace("可以接的特殊任务" + oldBeForArr);
         return oldBeForArr;
      }
      
      public static function getTaskDemand(id:Number) : String
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getDemand();
      }
      
      public static function getTaskIntroduction(id:Number) : String
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getTaskIntroduction();
      }
      
      public static function getGoodsMaxNum(id:Number, fallId:Number) : Number
      {
         var arr:Array = null;
         var i:uint = 0;
         arr = getGoodsIdAndNan(id);
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
      
      public static function getTimeNum(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         if(data.getTimeNum() != -1)
         {
            return data.getTimeNum();
         }
         return -1;
      }
      
      public static function getDelet(id:Number) : Boolean
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getDeletet();
      }
      
      public static function getGoodsNum(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var gNum:Array = null;
         var vtArr:Array = null;
         var i:uint = 0;
         data = getTaskBayId(id);
         gNum = data.getGoodsNum();
         vtArr = [];
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
      
      public static function addBranchTask(branch:Number) : Array
      {
         var bArr:Array = null;
         var data:TaskBasicData = null;
         bArr = [];
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
      
      public static function getTaskLevel(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getLevel();
      }
      
      public static function getFightNum(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         if(data.getFightNum() != -1)
         {
            return data.getFightNum();
         }
         return -1;
      }
      
      public static function addTaskRebirth(arr:Array, rebirth:Boolean) : Array
      {
         var t1:Array = null;
         var i:uint = 0;
         var data:TaskBasicData = null;
         t1 = [];
         for(i = 0; i < arr.length; i++)
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
      
      public static function getAwardTypeAndId(id:Number) : Array
      {
         var tType:Array = null;
         var tId:Array = null;
         var arrArr:Array = null;
         var i:uint = 0;
         tType = getAwardType(id);
         tId = getAwardId(id);
         arrArr = [];
         if(tType != null)
         {
            for(i = 0; i < tType.length; i++)
            {
               arrArr[i] = [tType[i],tId[i]];
            }
         }
         return arrArr;
      }
      
      public static function getEnemyNum(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var eNum:Array = null;
         var vtArr:Array = null;
         var i:uint = 0;
         data = getTaskBayId(id);
         eNum = data.getEnemyNum();
         vtArr = [];
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
      
      public static function getGold(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getGold();
      }
      
      public static function getGoodsId(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var gId:Array = null;
         var vtArr:Array = null;
         var i:uint = 0;
         data = getTaskBayId(id);
         gId = data.getGoodsId();
         vtArr = [];
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
      
      public static function addTaskLevel(arr:Array, level:Number) : Array
      {
         var t1:Array = null;
         var maxLevel:uint = 0;
         var lowLevel:uint = 0;
         var i:uint = 0;
         var data:TaskBasicData = null;
         t1 = [];
         maxLevel = level;
         if(level - 10 >= 1)
         {
            lowLevel = level - 10;
         }
         else
         {
            lowLevel = 1;
         }
         for(i = 0; i < arr.length; i++)
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
      
      public static function getAwardNum(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var arr:Array = null;
         var arr1:Array = null;
         var i:uint = 0;
         data = getTaskBayId(id);
         arr = [];
         arr1 = data.getAwardNum();
         if(arr1 != null)
         {
            for(i = 0; i < arr1.length; i++)
            {
               arr.push(arr1[i].getValue());
            }
         }
         return arr;
      }
      
      public static function getMapId(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         if(data.getMapId() != -1)
         {
            return data.getMapId();
         }
         return -1;
      }
      
      public static function getFinishiLevel(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         if(data.getFinishLevel() != -1)
         {
            return data.getFinishLevel();
         }
         return -1;
      }
      
      public static function getLianjiNum(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         if(data.getLianjiNum() != -1)
         {
            return data.getLianjiNum();
         }
         return -1;
      }
      
      public static function getTg(id:Number) : Boolean
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getTg();
      }
      
      public static function getPlayerDtate(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getPlayerStata();
      }
      
      public static function getExp(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getExp();
      }
      
      public static function addOther(branch:Number) : Array
      {
         var taskArr:Array = null;
         var branchArr:Array = null;
         taskArr = [];
         branchArr = addBranchTask(branch);
         return branchArr;
      }
      
      public static function addZxTask(branch:Number, rebirth:Boolean, oldBeforeTaskId:Array) : Array
      {
         var branchArr:Array = null;
         var rebirthArr:Array = null;
         var oldBeForArr:Array = null;
         trace(branch + "分支");
         branchArr = addBranchTask(branch);
         rebirthArr = addTaskRebirth(branchArr,rebirth);
         return addBeforeTask(rebirthArr,oldBeforeTaskId);
      }
      
      public static function isRc(id:Number) : Boolean
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.isRc();
      }
      
      public static function creatTaskFactory() : TaskFactioy
      {
         var data:TaskFactioy = null;
         data = new TaskFactioy();
         data.creatLoard();
      }
      
      public static function getEnemyName(id:Number) : Array
      {
         var data:TaskBasicData = null;
         var eName:Array = null;
         data = getTaskBayId(id);
         eName = data.getEnemyName();
         if(eName.length > 0)
         {
            return eName;
         }
         return null;
      }
      
      public static function getGoodsIdAndNan(id:Number) : Array
      {
         var gId:Array = null;
         var gNum:Array = null;
         var grr:Array = null;
         var i:uint = 0;
         gId = getGoodsId(id);
         gNum = getGoodsNum(id);
         grr = [];
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
      
      public function getBeforeTaskId(id:Number) : Number
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getBeforeTaskId();
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      public function getTaskRebirth(id:Number) : Boolean
      {
         var data:TaskBasicData = null;
         data = getTaskBayId(id);
         return data.getRebirth();
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
            data = TaskBasicData.creatTaskBasicData(taskId,taskName,taskLevel,taskDe,taskBranch,taskIntroduction,taskDemand,who,agin,rc,mapId,e1,e3,e2,g1,g2,lianjiNum,fightNum,timeNum,finishGold,finishLevel,tg,beforeTaskId,rebirth,a1,a2,a3,gold,exp,playersDate);
            taskArr.push(data);
         }
      }
   }
}

