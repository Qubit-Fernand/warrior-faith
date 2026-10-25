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
      
      public static function creatTaskBasicData(param1:Number, param2:String, param3:Number, param4:Boolean, param5:Number, param6:String, param7:String, param8:Number, param9:Boolean, param10:Boolean, param11:Number, param12:Array, param13:Array, param14:Array, param15:Array, param16:Array, param17:Number, param18:Number, param19:Number, param20:Number, param21:Number, param22:Boolean, param23:Number, param24:Boolean, param25:Array, param26:Array, param27:Array, param28:Number, param29:Number, param30:Number, param31:String) : TaskBasicData
      {
         var _loc32_:TaskBasicData = new TaskBasicData();
         _loc32_._taskId = VT.createVT(param1);
         _loc32_._taskName = param2;
         _loc32_._level = VT.createVT(param3);
         _loc32_._deletet = param4;
         _loc32_._branch = VT.createVT(param5);
         _loc32_._taskIntroduction = param6;
         _loc32_._taskDemand = param7;
         _loc32_._who = VT.createVT(param8);
         _loc32_._agin = param9;
         _loc32_._rc = param10;
         _loc32_._mapId = VT.createVT(param11);
         _loc32_._enemyId = param12;
         _loc32_._enemyName = param13;
         _loc32_._enemyNum = param14;
         _loc32_._goodsId = param15;
         _loc32_._goodsNum = param16;
         _loc32_._lianjiNum = VT.createVT(param17);
         _loc32_._fightNum = VT.createVT(param18);
         _loc32_._timeNum = VT.createVT(param19);
         _loc32_._finishGold = VT.createVT(param20);
         _loc32_._finishLevel = VT.createVT(param21);
         _loc32_._tg = param22;
         _loc32_._beforeTaskId = VT.createVT(param23);
         _loc32_._rebirth = param24;
         _loc32_._awardType = param25;
         _loc32_._awardId = param26;
         _loc32_._awardNum = param27;
         _loc32_._gold = VT.createVT(param28);
         _loc32_._exp = VT.createVT(param29);
         _loc32_._playerStata = VT.createVT(param30);
         _loc32_._url = param31;
         return _loc32_;
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

