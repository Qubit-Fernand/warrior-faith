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
      
      private var _url:String;
      
      public function TaskBasicData()
      {
         super();
      }
      
      public static function creatTaskBasicData(taskId:Number, taskName:String, level:Number, deletet:Boolean, branch:Number, taskIntroduction:String, taskDemand:String, who:Number, agin:Boolean, rc:Boolean, mapId:Number, enemyId:Array, enemyName:Array, enemyNum:Array, goodsId:Array, goodsNum:Array, lianjiNum:Number, fightNum:Number, timeNum:Number, finishGold:Number, finishLevel:Number, tg:Boolean, beforeTaskId:Number, rebirth:Boolean, awardType:Array, awardId:Array, awardNum:Array, gold:Number, exp:Number, playersData:Number, url:String) : TaskBasicData
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
         taskData._url = url;
         return taskData;
      }
      
      public function getTaskId() : Number
      {
         return this._taskId.getValue();
      }
      
      public function getTaskName() : String
      {
         return this._taskName;
      }
      
      public function getLevel() : Number
      {
         return this._level.getValue();
      }
      
      public function getDeletet() : Boolean
      {
         return this._deletet;
      }
      
      public function getBranch() : Number
      {
         return this._branch.getValue();
      }
      
      public function getTaskIntroduction() : String
      {
         return this._taskIntroduction;
      }
      
      public function getDemand() : String
      {
         return this._taskDemand;
      }
      
      public function getWho() : Number
      {
         return this._who.getValue();
      }
      
      public function isAgin() : Boolean
      {
         return this._agin;
      }
      
      public function isRc() : Boolean
      {
         return this._rc;
      }
      
      public function getMapId() : Number
      {
         return this._mapId.getValue();
      }
      
      public function getEnemyId() : Array
      {
         return this._enemyId;
      }
      
      public function getEnemyName() : Array
      {
         return this._enemyName;
      }
      
      public function getEnemyNum() : Array
      {
         return this._enemyNum;
      }
      
      public function getGoodsId() : Array
      {
         return this._goodsId;
      }
      
      public function getGoodsNum() : Array
      {
         return this._goodsNum;
      }
      
      public function getLianjiNum() : Number
      {
         return this._lianjiNum.getValue();
      }
      
      public function getFightNum() : Number
      {
         return this._fightNum.getValue();
      }
      
      public function getTimeNum() : Number
      {
         return this._timeNum.getValue();
      }
      
      public function getFinishGold() : Number
      {
         return this._finishGold.getValue();
      }
      
      public function getFinishLevel() : Number
      {
         return this._finishLevel.getValue();
      }
      
      public function getTg() : Boolean
      {
         return this._tg;
      }
      
      public function getBeforeTaskId() : Number
      {
         return this._beforeTaskId.getValue();
      }
      
      public function getRebirth() : Boolean
      {
         return this._rebirth;
      }
      
      public function getAwardType() : Array
      {
         return this._awardType;
      }
      
      public function getAwardId() : Array
      {
         return this._awardId;
      }
      
      public function getAwardNum() : Array
      {
         return this._awardNum;
      }
      
      public function getGold() : Number
      {
         return this._gold.getValue();
      }
      
      public function getExp() : Number
      {
         return this._exp.getValue();
      }
      
      public function getPlayerStata() : Number
      {
         return this._playerStata.getValue();
      }
      
      public function getUrl() : String
      {
         return this._url;
      }
      
      public function creatTask() : Task
      {
         return Task.creatTask(this._taskId.getValue());
      }
   }
}

