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
         return this._taskId.getValue();
      }
      
      public function getName() : String
      {
         return this._taskName;
      }
      
      public function getLevel() : Number
      {
         return this._level.getValue();
      }
      
      public function getTaskIntroduction() : String
      {
         return this._taskIntroduction;
      }
      
      public function getDemand() : String
      {
         return this._taskDemand;
      }
      
      public function getBigType() : Number
      {
         return this._bigType.getValue();
      }
      
      public function getSmallType() : Number
      {
         return this._smallType.getValue();
      }
      
      public function getWtr() : String
      {
         return this._wtr;
      }
      
      public function getMapId() : Number
      {
         return this._mapId.getValue();
      }
      
      public function getMapStar() : Number
      {
         return this._mapStar.getValue();
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
      
      public function getNpc() : Number
      {
         return this._npc.getValue();
      }
      
      public function getYhd() : Number
      {
         return this._yhd.getValue();
      }
      
      public function getPhb() : Number
      {
         return this._phb.getValue();
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
      
      public function getGl() : Array
      {
         return this._gl;
      }
      
      public function creatTask() : Task
      {
         return Task.creatTask(this._taskId.getValue());
      }
   }
}

