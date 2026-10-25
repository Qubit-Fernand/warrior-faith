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
      
      public static function creatTaskBasicData(taskId:Number, name:String, lv:Number, intro:String, dem:String, bType:Number, sType:Number, wtr:String, bf:Number, re:Boolean, mapId:Number, mapStar:Number, eId:String, eName:String, eNum:String, gId:String, gN:String, lj:Number, fn:Number, time:Number, fg:Number, fl:Number, tg:Boolean, npc:Number, yhd:Number, phb:Number, adType:String, adId:String, adN:String, gold:Number, exp:Number, ps:Number, gl:String) : TaskBasicData
      {
         var data:TaskBasicData = new TaskBasicData();
         data._taskId = VT.createVT(taskId);
         data._taskName = name;
         data._level = VT.createVT(lv);
         data._taskIntroduction = intro;
         data._taskDemand = dem;
         data._bigType = VT.createVT(bType);
         data._smallType = VT.createVT(sType);
         data._wtr = wtr;
         data._beforeTaskId = VT.createVT(bf);
         data._rebirth = re;
         data._mapId = VT.createVT(mapId);
         data._mapStar = VT.createVT(mapStar);
         data._enemyId = strToArr(eId);
         data._enemyName = strToArr(eName);
         data._enemyNum = strToArr(eNum);
         data._goodsId = strToArr(gId);
         data._goodsNum = strToArr(gN);
         data._lianjiNum = VT.createVT(lj);
         data._fightNum = VT.createVT(fn);
         data._timeNum = VT.createVT(time);
         data._finishGold = VT.createVT(fg);
         data._finishLevel = VT.createVT(fl);
         data._tg = tg;
         data._npc = VT.createVT(npc);
         data._yhd = VT.createVT(yhd);
         data._phb = VT.createVT(phb);
         data._awardType = strToArr(adType);
         data._awardId = strToArr(adId);
         data._awardNum = strToArr(adN);
         data._gold = VT.createVT(gold);
         data._exp = VT.createVT(exp);
         data._playerStata = VT.createVT(ps);
         data._gl = strToArr(gl);
         return data;
      }
      
      private static function strToArr(str:String) : Array
      {
         var arr:Array = str.split(",");
         var vtArr:Array = [];
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(Number(arr[i]))
            {
               vtArr.push(VT.createVT(Number(arr[i])));
            }
            else
            {
               vtArr.push(String(arr[i]));
            }
         }
         return vtArr;
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

