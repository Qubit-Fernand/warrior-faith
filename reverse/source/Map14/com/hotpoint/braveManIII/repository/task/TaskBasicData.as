package com.hotpoint.braveManIII.repository.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.task.*;
   
   public class TaskBasicData
   {
      
      private var _taskId:VT;
      
      private var _taskName:String;
      
      private var _level:VT;
      
      private var _deletet:Boolean;
      
      private var _branch:VT;
      
      private var _taskIntroduction:String;
      
      private var _taskDemand:String;
      
      private var _who:VT;
      
      private var _agin:Boolean;
      
      private var _rc:Boolean;
      
      private var _overTimer:VT;
      
      private var _mapId:VT;
      
      private var _enemyId:Array;
      
      private var _enemyName:Array;
      
      private var _enemyNum:Array;
      
      private var _goodsId:Array;
      
      private var _goodsNum:Array;
      
      private var _lianjiNum:VT;
      
      private var _fightNum:VT;
      
      private var _timeNum:VT;
      
      private var _finishGold:VT;
      
      private var _finishLevel:VT;
      
      private var _tg:Boolean;
      
      private var _beforeTaskId:VT;
      
      private var _rebirth:Boolean;
      
      private var _awardType:Array;
      
      private var _awardId:Array;
      
      private var _awardNum:Array;
      
      private var _gold:VT;
      
      private var _exp:VT;
      
      private var _playerStata:VT;
      
      public function TaskBasicData()
      {
         super();
      }
      
      public static function creatTaskBasicData(taskId:Number, taskName:String, level:Number, deletet:Boolean, branch:Number, taskIntroduction:String, taskDemand:String, who:Number, agin:Boolean, rc:Boolean, mapId:Number, enemyId:Array, enemyName:Array, enemyNum:Array, goodsId:Array, goodsNum:Array, lianjiNum:Number, fightNum:Number, timeNum:Number, finishGold:Number, finishLevel:Number, tg:Boolean, beforeTaskId:Number, rebirth:Boolean, awardType:Array, awardId:Array, awardNum:Array, gold:Number, exp:Number, playersData:Number) : TaskBasicData
      {
         var taskData:TaskBasicData = new TaskBasicData();
         taskData._taskId = VT.createVT(taskId);
         taskData._taskName = taskName;
         taskData._level = VT.createVT(level);
         taskData._deletet = deletet;
         taskData._branch = VT.createVT(branch);
         taskData._taskIntroduction = taskIntroduction;
         taskData._taskDemand = taskDemand;
         taskData._who = VT.createVT(who);
         taskData._agin = agin;
         taskData._rc = rc;
         taskData._mapId = VT.createVT(mapId);
         taskData._enemyId = enemyId;
         taskData._enemyName = enemyName;
         taskData._enemyNum = enemyNum;
         taskData._goodsId = goodsId;
         taskData._goodsNum = goodsNum;
         taskData._lianjiNum = VT.createVT(lianjiNum);
         taskData._fightNum = VT.createVT(fightNum);
         taskData._timeNum = VT.createVT(timeNum);
         taskData._finishGold = VT.createVT(finishGold);
         taskData._finishLevel = VT.createVT(finishLevel);
         taskData._tg = tg;
         taskData._beforeTaskId = VT.createVT(beforeTaskId);
         taskData._rebirth = rebirth;
         taskData._awardType = awardType;
         taskData._awardId = awardId;
         taskData._awardNum = awardNum;
         taskData._gold = VT.createVT(gold);
         taskData._exp = VT.createVT(exp);
         taskData._playerStata = VT.createVT(playersData);
         return taskData;
      }
      
      public function getTaskId() : Number
      {
         return _taskId.getValue();
      }
      
      public function getTaskName() : String
      {
         return _taskName;
      }
      
      public function getLevel() : Number
      {
         return _level.getValue();
      }
      
      public function getDeletet() : Boolean
      {
         return _deletet;
      }
      
      public function getBranch() : Number
      {
         return _branch.getValue();
      }
      
      public function getTaskIntroduction() : String
      {
         return _taskIntroduction;
      }
      
      public function getDemand() : String
      {
         return _taskDemand;
      }
      
      public function getWho() : Number
      {
         return _who.getValue();
      }
      
      public function isAgin() : Boolean
      {
         return _agin;
      }
      
      public function isRc() : Boolean
      {
         return _rc;
      }
      
      public function getMapId() : Number
      {
         return _mapId.getValue();
      }
      
      public function getEnemyId() : Array
      {
         return _enemyId;
      }
      
      public function getEnemyName() : Array
      {
         return _enemyName;
      }
      
      public function getEnemyNum() : Array
      {
         return _enemyNum;
      }
      
      public function getGoodsId() : Array
      {
         return _goodsId;
      }
      
      public function getGoodsNum() : Array
      {
         return _goodsNum;
      }
      
      public function getLianjiNum() : Number
      {
         return _lianjiNum.getValue();
      }
      
      public function getFightNum() : Number
      {
         return _fightNum.getValue();
      }
      
      public function getTimeNum() : Number
      {
         return _timeNum.getValue();
      }
      
      public function getFinishGold() : Number
      {
         return _finishGold.getValue();
      }
      
      public function getFinishLevel() : Number
      {
         return _finishLevel.getValue();
      }
      
      public function getTg() : Boolean
      {
         return _tg;
      }
      
      public function getBeforeTaskId() : Number
      {
         return _beforeTaskId.getValue();
      }
      
      public function getRebirth() : Boolean
      {
         return _rebirth;
      }
      
      public function getAwardType() : Array
      {
         return _awardType;
      }
      
      public function getAwardId() : Array
      {
         return _awardId;
      }
      
      public function getAwardNum() : Array
      {
         return _awardNum;
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function getExp() : Number
      {
         return _exp.getValue();
      }
      
      public function getPlayerStata() : Number
      {
         return _playerStata.getValue();
      }
      
      public function creatTask() : Task
      {
         return Task.creatTask(_taskId.getValue());
      }
   }
}

