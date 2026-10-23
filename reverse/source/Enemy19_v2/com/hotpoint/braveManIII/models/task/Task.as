package com.hotpoint.braveManIII.models.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.task.*;
   
   public class Task
   {
      
      private var _id:VT;
      
      private var _state:VT;
      
      private var _sjArr:Array = [];
      
      private var _enemyingArr:Array = [];
      
      private var _overTimer:VT;
      
      private var _time:VT;
      
      private var _lianji:VT;
      
      private var _bett:VT;
      
      private var _mapId:VT;
      
      private var _finishGold:VT;
      
      private var _level:VT;
      
      private var _tging:Boolean = false;
      
      public function Task()
      {
         super();
      }
      
      public static function creatTask(id:Number) : Task
      {
         var task:Task = new Task();
         task._id = VT.createVT(id);
         task._state = VT.createVT(0);
         task._level = VT.createVT(0);
         task._finishGold = VT.createVT(0);
         task._bett = VT.createVT(0);
         task._lianji = VT.createVT(0);
         task._mapId = VT.createVT(0);
         task._time = VT.createVT(0);
         task._overTimer = VT.createVT(0);
         task._tging = false;
         task.goodsedArr();
         task.initEnemyArr();
         return task;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get state() : VT
      {
         return _state;
      }
      
      public function set state(value:VT) : void
      {
         _state = value;
      }
      
      public function get time() : VT
      {
         return _time;
      }
      
      public function set time(value:VT) : void
      {
         _time = value;
      }
      
      public function get lianji() : VT
      {
         return _lianji;
      }
      
      public function set lianji(value:VT) : void
      {
         _lianji = value;
      }
      
      public function get bett() : VT
      {
         return _bett;
      }
      
      public function set bett(value:VT) : void
      {
         _bett = value;
      }
      
      public function get mapId() : VT
      {
         return _mapId;
      }
      
      public function set mapId(value:VT) : void
      {
         _mapId = value;
      }
      
      public function get finishGold() : VT
      {
         return _finishGold;
      }
      
      public function set finishGold(value:VT) : void
      {
         _finishGold = value;
      }
      
      public function get level() : VT
      {
         return _level;
      }
      
      public function set level(value:VT) : void
      {
         _level = value;
      }
      
      public function get overTimer() : VT
      {
         return _overTimer;
      }
      
      public function set overTimer(value:VT) : void
      {
         _overTimer = value;
      }
      
      public function get enemyingArr() : Array
      {
         return _enemyingArr;
      }
      
      public function set enemyingArr(value:Array) : void
      {
         _enemyingArr = value;
      }
      
      public function get sjArr() : Array
      {
         return _sjArr;
      }
      
      public function set sjArr(value:Array) : void
      {
         _sjArr = value;
      }
      
      public function get tging() : Boolean
      {
         return _tging;
      }
      
      public function set tging(value:Boolean) : void
      {
         _tging = value;
      }
      
      public function getUrl() : String
      {
         return TaskFactioy.getUrl(_id.getValue());
      }
      
      public function getName() : String
      {
         return TaskFactioy.getTaskName(_id.getValue());
      }
      
      public function getBranch() : Number
      {
         return TaskFactioy.getTaskBranch(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return TaskFactioy.getTaskIntroduction(_id.getValue());
      }
      
      public function getDemand() : String
      {
         return TaskFactioy.getTaskDemand(_id.getValue());
      }
      
      public function isAgin() : Boolean
      {
         return TaskFactioy.isAgin(_id.getValue());
      }
      
      public function isRc() : Boolean
      {
         return TaskFactioy.isRc(_id.getValue());
      }
      
      public function getOverTimer() : Number
      {
         return _overTimer.getValue();
      }
      
      public function setOverTimer(t:Number) : void
      {
         _overTimer.setValue(t);
      }
      
      public function getTg() : Boolean
      {
         return TaskFactioy.getTg(_id.getValue());
      }
      
      public function getTging() : Boolean
      {
         return _tging;
      }
      
      public function setTging(bo:Boolean) : void
      {
         _tging = bo;
      }
      
      public function getFinishGold() : Number
      {
         return TaskFactioy.getFinishGold(_id.getValue());
      }
      
      public function setFinishGold(num:Number) : void
      {
         _finishGold.setValue(num);
      }
      
      public function getFinishGolded() : Number
      {
         return _finishGold.getValue();
      }
      
      public function getTaskLevel() : Number
      {
         return TaskFactioy.getTaskLevel(_id.getValue());
      }
      
      public function getDelet() : Boolean
      {
         return TaskFactioy.getDelet(_id.getValue());
      }
      
      public function getLevel() : Number
      {
         return TaskFactioy.getFinishiLevel(_id.getValue());
      }
      
      public function getLeveling() : Number
      {
         return _level.getValue();
      }
      
      public function setLeveling(num:Number) : void
      {
         _level.setValue(num);
      }
      
      public function getMapId() : Number
      {
         return TaskFactioy.getMapId(_id.getValue());
      }
      
      public function setMaped(num:Number) : void
      {
         _mapId.setValue(num);
      }
      
      public function getMaped() : Number
      {
         return _mapId.getValue();
      }
      
      public function getWho() : Number
      {
         return TaskFactioy.getWho(_id.getValue());
      }
      
      public function getEnemyId() : Array
      {
         return TaskFactioy.getEnemyId(_id.getValue());
      }
      
      public function getEnemyName() : Array
      {
         return TaskFactioy.getEnemyName(_id.getValue());
      }
      
      public function getEnemyNum() : Array
      {
         return TaskFactioy.getEnemyNum(_id.getValue());
      }
      
      public function getEidAndNum() : Array
      {
         return TaskFactioy.getEenmyIdAndNan(_id.getValue());
      }
      
      public function getGoodsId() : Array
      {
         return TaskFactioy.getGoodsId(_id.getValue());
      }
      
      public function getGoodsNum() : Array
      {
         return TaskFactioy.getGoodsNum(_id.getValue());
      }
      
      public function getGidAndNum() : Array
      {
         return TaskFactioy.getGoodsIdAndNan(_id.getValue());
      }
      
      public function getTimer() : Number
      {
         return TaskFactioy.getTimeNum(_id.getValue());
      }
      
      public function setTimer(time:Number) : void
      {
         _time.setValue(time);
      }
      
      public function getTimered() : Number
      {
         return _time.getValue();
      }
      
      public function getLianji() : Number
      {
         return TaskFactioy.getLianjiNum(_id.getValue());
      }
      
      public function setLianjied(num:Number) : void
      {
         _lianji.setValue(num);
      }
      
      public function getLianJied() : Number
      {
         return _lianji.getValue();
      }
      
      public function getBett() : Number
      {
         return TaskFactioy.getFightNum(_id.getValue());
      }
      
      public function setBetted(num:Number) : void
      {
         _bett.setValue(num);
      }
      
      public function getBetted() : Number
      {
         return _bett.getValue();
      }
      
      public function getGold() : Number
      {
         return TaskFactioy.getGold(_id.getValue());
      }
      
      public function getExp() : Number
      {
         return TaskFactioy.getExp(_id.getValue());
      }
      
      public function getAwardTypeAndId() : Array
      {
         return TaskFactioy.getAwardTypeAndId(_id.getValue());
      }
      
      public function getAwardNum() : Array
      {
         return TaskFactioy.getAwardNum(_id.getValue());
      }
      
      public function getAwardType() : Array
      {
         return TaskFactioy.getAwardType(_id.getValue());
      }
      
      public function getAwardPlayerDate() : Number
      {
         return TaskFactioy.getPlayerDtate(_id.getValue());
      }
      
      public function getStata() : Number
      {
         return _state.getValue();
      }
      
      public function setStata(num:Number) : void
      {
         _state.setValue(num);
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function initEnemyArr() : void
      {
         var i:uint = 0;
         var arr:Array = getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               _enemyingArr[i] = 0;
            }
         }
      }
      
      public function getSkillEnemyNum(enemyId:Number) : Number
      {
         var i:uint = 0;
         var arr:Array = getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(enemyId == arr[i])
               {
                  return _enemyingArr[i];
               }
            }
         }
         return -1;
      }
      
      public function getEnemyMaxNum(eId:Number) : Number
      {
         var i:uint = 0;
         var arr:Array = getEnemyId();
         var arr1:Array = getEnemyNum();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(arr[i] == eId)
               {
                  return arr1[i];
               }
            }
         }
         return -1;
      }
      
      public function isEnemyId(enemyId:Number) : Boolean
      {
         var i:uint = 0;
         var arr:Array = getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(enemyId == arr[i])
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function addSkillEnemyNum(id:Number) : void
      {
         var i:uint = 0;
         var arr:Array = getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(arr[i] == id)
               {
                  ++_enemyingArr[i];
                  break;
               }
            }
         }
      }
      
      public function getEnemyArr() : Array
      {
         return _enemyingArr;
      }
      
      public function goodsedArr() : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(getGoodsId() != null)
         {
            arr = getGoodsId();
            for(i = 0; i < arr.length; i++)
            {
               _sjArr[i] = 0;
            }
         }
      }
      
      public function getGoodsedNum() : Array
      {
         return _sjArr;
      }
      
      public function setGoodsed(arr:Array) : void
      {
         _sjArr = arr;
      }
      
      public function isGoodsId(gId:Number) : Boolean
      {
         var arr:Array = getGoodsId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            if(gId == arr[i])
            {
               return true;
            }
         }
         return false;
      }
      
      public function isTgOk() : Boolean
      {
         var bo:Boolean = getTg();
         if(bo)
         {
            if(!getTging())
            {
               return false;
            }
         }
         return true;
      }
      
      private function isEnemyOk() : Boolean
      {
         var i:uint = 0;
         var arr0:Array = getEnemyId();
         var arr1:Array = getEnemyArr();
         var arr2:Array = getEnemyNum();
         if(arr0 != null)
         {
            for(i = 0; i < arr0.length; i++)
            {
               if(arr1[i] < arr2[i])
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function isGoodsOk() : Boolean
      {
         var i:uint = 0;
         var arr0:Array = getGoodsId();
         var arr1:Array = getGoodsNum();
         var arr2:Array = getGoodsedNum();
         if(arr0 != null)
         {
            for(i = 0; i < arr0.length; i++)
            {
               if(arr1[i] > arr2[i])
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function ismapOk() : Boolean
      {
         var mapNum:Number = getMapId();
         if(mapNum != -1)
         {
            if(getMaped() == 0)
            {
               return false;
            }
            if(mapNum != getMaped())
            {
               return false;
            }
         }
         return true;
      }
      
      private function istimeOk() : Boolean
      {
         var time:Number = getTimer();
         if(time != -1)
         {
            if(time < getTimered())
            {
               if(getTging())
               {
                  setTging(false);
               }
               return false;
            }
            if(!getTging())
            {
               return false;
            }
         }
         return true;
      }
      
      private function islianjiOk() : Boolean
      {
         var lj:Number = getLianji();
         if(lj != -1)
         {
            if(lj > getLianJied())
            {
               return false;
            }
         }
         return true;
      }
      
      private function isbettOk() : Boolean
      {
         var bt:Number = getBett();
         if(bt != -1)
         {
            if(getBetted() >= bt)
            {
               if(getTging())
               {
                  setTging(false);
               }
               return false;
            }
            if(!getTging())
            {
               return false;
            }
         }
         return true;
      }
      
      private function isgoldOk() : Boolean
      {
         var g:Number = getFinishGold();
         if(g != -1)
         {
            if(g > getFinishGolded())
            {
               return false;
            }
         }
         return true;
      }
      
      private function islevelOk() : Boolean
      {
         var level:Number = getLevel();
         if(level != -1)
         {
            if(level > getLeveling())
            {
               return false;
            }
         }
         return true;
      }
      
      public function istaskOk() : Boolean
      {
         if(Boolean(isbettOk()) && Boolean(isEnemyOk()) && Boolean(isgoldOk()) && Boolean(isGoodsOk()) && Boolean(islevelOk()) && Boolean(islianjiOk()) && ismapOk() && Boolean(istimeOk()) && isTgOk())
         {
            return true;
         }
         return false;
      }
      
      public function clearKong() : void
      {
         initEnemyArr();
         goodsedArr();
         _time.setValue(0);
         _lianji.setValue(0);
         _tging = false;
         _bett.setValue(0);
         _mapId.setValue(0);
      }
   }
}

