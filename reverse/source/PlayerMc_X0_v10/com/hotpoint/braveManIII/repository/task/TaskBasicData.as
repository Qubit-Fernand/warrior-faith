package com.hotpoint.braveManIII.repository.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.task.*;
   
   public class TaskBasicData
   {
      
      private var _taskId:VT;
      
      private var _taskName:String;
      
      private var _level:VT;
      
      private var _taskIntroduction:String;
      
      private var _taskDemand:String;
      
      private var _bigType:VT;
      
      private var _smallType:VT;
      
      private var _wtr:String;
      
      private var _beforeTaskId:VT;
      
      private var _rebirth:Boolean;
      
      private var _mapId:VT;
      
      private var _mapStar:VT;
      
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
      
      private var _npc:VT;
      
      private var _yhd:VT;
      
      private var _phb:VT;
      
      private var _awardType:Array;
      
      private var _awardId:Array;
      
      private var _awardNum:Array;
      
      private var _gold:VT;
      
      private var _exp:VT;
      
      private var _playerStata:VT;
      
      private var _gl:Array;
      
      public function TaskBasicData()
      {
         super();
      }
      
      public static function creatTaskBasicData(param1:Number, param2:String, param3:Number, param4:String, param5:String, param6:Number, param7:Number, param8:String, param9:Number, param10:Boolean, param11:Number, param12:Number, param13:String, param14:String, param15:String, param16:String, param17:String, param18:Number, param19:Number, param20:Number, param21:Number, param22:Number, param23:Boolean, param24:Number, param25:Number, param26:Number, param27:String, param28:String, param29:String, param30:Number, param31:Number, param32:Number, param33:String) : TaskBasicData
      {
         var _loc34_:TaskBasicData = new TaskBasicData();
         _loc34_._taskId = VT.createVT(param1);
         _loc34_._taskName = param2;
         _loc34_._level = VT.createVT(param3);
         _loc34_._taskIntroduction = param4;
         _loc34_._taskDemand = param5;
         _loc34_._bigType = VT.createVT(param6);
         _loc34_._smallType = VT.createVT(param7);
         _loc34_._wtr = param8;
         _loc34_._beforeTaskId = VT.createVT(param9);
         _loc34_._rebirth = param10;
         _loc34_._mapId = VT.createVT(param11);
         _loc34_._mapStar = VT.createVT(param12);
         _loc34_._enemyId = strToArr(param13);
         _loc34_._enemyName = strToArr(param14);
         _loc34_._enemyNum = strToArr(param15);
         _loc34_._goodsId = strToArr(param16);
         _loc34_._goodsNum = strToArr(param17);
         _loc34_._lianjiNum = VT.createVT(param18);
         _loc34_._fightNum = VT.createVT(param19);
         _loc34_._timeNum = VT.createVT(param20);
         _loc34_._finishGold = VT.createVT(param21);
         _loc34_._finishLevel = VT.createVT(param22);
         _loc34_._tg = param23;
         _loc34_._npc = VT.createVT(param24);
         _loc34_._yhd = VT.createVT(param25);
         _loc34_._phb = VT.createVT(param26);
         _loc34_._awardType = strToArr(param27);
         _loc34_._awardId = strToArr(param28);
         _loc34_._awardNum = strToArr(param29);
         _loc34_._gold = VT.createVT(param30);
         _loc34_._exp = VT.createVT(param31);
         _loc34_._playerStata = VT.createVT(param32);
         _loc34_._gl = strToArr(param33);
         return _loc34_;
      }
      
      private static function strToArr(param1:String) : Array
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(Number(_loc2_[_loc4_]))
            {
               _loc3_.push(VT.createVT(Number(_loc2_[_loc4_])));
            }
            else
            {
               _loc3_.push(String(_loc2_[_loc4_]));
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getId() : Number
      {
         return _taskId.getValue();
      }
      
      public function getName() : String
      {
         return _taskName;
      }
      
      public function getLevel() : Number
      {
         return _level.getValue();
      }
      
      public function getTaskIntroduction() : String
      {
         return _taskIntroduction;
      }
      
      public function getDemand() : String
      {
         return _taskDemand;
      }
      
      public function getBigType() : Number
      {
         return _bigType.getValue();
      }
      
      public function getSmallType() : Number
      {
         return _smallType.getValue();
      }
      
      public function getWtr() : String
      {
         return _wtr;
      }
      
      public function getMapId() : Number
      {
         return _mapId.getValue();
      }
      
      public function getMapStar() : Number
      {
         return _mapStar.getValue();
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
      
      public function getNpc() : Number
      {
         return _npc.getValue();
      }
      
      public function getYhd() : Number
      {
         return _yhd.getValue();
      }
      
      public function getPhb() : Number
      {
         return _phb.getValue();
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
      
      public function getGl() : Array
      {
         return _gl;
      }
      
      public function creatTask() : Task
      {
         return Task.creatTask(_taskId.getValue());
      }
   }
}

