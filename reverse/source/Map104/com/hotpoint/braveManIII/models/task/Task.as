package com.hotpoint.braveManIII.models.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.task.*;
   import flash.utils.*;
   
   public class Task
   {
      
      private var _finishGold:VT;
      
      private var _lianji:VT;
      
      private var _overTimer:VT;
      
      private var _level:VT;
      
      private var _sjArr:Array = [];
      
      private var _state:VT;
      
      private var _mapId:VT;
      
      private var _tging:Boolean = false;
      
      private var _time:VT;
      
      private var _id:VT;
      
      private var _bett:VT;
      
      private var _enemyingArr:Array = [];
      
      public function Task()
      {
         super();
      }
      
      public static function creatTask(id:Number) : Task
      {
         var task:Task = null;
         task = new Task();
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
      
      public function getName() : String
      {
         return TaskFactioy.getTaskName(_id.getValue());
      }
      
      public function get bett() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _bett;
      }
      
      public function set bett(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _bett = value;
      }
      
      public function set level(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _level = value;
      }
      
      private function isgoldOk() : Boolean
      {
         var g:Number = NaN;
         trace("任务完成的G币:" + getFinishGold(),"现在有的G币:" + getFinishGolded());
         g = getFinishGold();
         if(g != -1)
         {
            if(g > getFinishGolded())
            {
               trace(getName() + ":G没满足");
               return false;
            }
         }
         return true;
      }
      
      public function setLianjied(num:Number) : void
      {
         _lianji.setValue(num);
      }
      
      public function setTimer(time:Number) : void
      {
         _time.setValue(time);
      }
      
      public function isAgin() : Boolean
      {
         return TaskFactioy.isAgin(_id.getValue());
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function clearKong() : void
      {
         initEnemyArr();
         goodsedArr();
         _time.setValue(0);
         _lianji.setValue(0);
         _tging = false;
         _bett.setValue(0);
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _id;
      }
      
      private function islevelOk() : Boolean
      {
         var level:Number = NaN;
         level = -1;
         if(level != -1)
         {
            if(level > getLeveling())
            {
               trace(getName() + ":级别没满足");
               return false;
            }
         }
         return true;
      }
      
      public function getLianJied() : Number
      {
         return _lianji.getValue();
      }
      
      public function getLianji() : Number
      {
         return TaskFactioy.getLianjiNum(_id.getValue());
      }
      
      public function set state(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _state = value;
      }
      
      public function set finishGold(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _finishGold = value;
      }
      
      private function islianjiOk() : Boolean
      {
         var lj:Number = NaN;
         lj = getLianji();
         if(lj != -1)
         {
            if(lj > getLianJied())
            {
               trace(getName() + ":连击没满足",getLianJied(),lj);
               return false;
            }
         }
         return true;
      }
      
      public function get lianji() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _lianji;
      }
      
      public function getOverTimer() : Number
      {
         return _overTimer.getValue();
      }
      
      public function addSkillEnemyNum(id:Number) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         arr = getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(arr[i] == id)
               {
                  ++_enemyingArr[i];
                  trace("已经击杀:" + _enemyingArr[i]);
                  break;
               }
            }
         }
      }
      
      public function getEnemyArr() : Array
      {
         return _enemyingArr;
      }
      
      public function set mapId(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _mapId = value;
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = value;
      }
      
      public function isEnemyId(enemyId:Number) : Boolean
      {
         var arr:Array = null;
         var i:uint = 0;
         arr = getEnemyId();
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
      
      private function istimeOk() : Boolean
      {
         var time:Number = NaN;
         time = getTimer();
         if(time != -1)
         {
            if(time < getTimered())
            {
               if(getTging())
               {
                  setTging(false);
               }
               trace(getName() + ":时间没满足",getTimered(),time);
               return false;
            }
            if(!getTging())
            {
               trace(getName() + ":时间满足了,但是没通关");
               return false;
            }
         }
         return true;
      }
      
      public function getAwardPlayerDate() : Number
      {
         return TaskFactioy.getPlayerDtate(_id.getValue());
      }
      
      public function getDemand() : String
      {
         return TaskFactioy.getTaskDemand(_id.getValue());
      }
      
      public function getDelet() : Boolean
      {
         return TaskFactioy.getDelet(_id.getValue());
      }
      
      public function getMaped() : Number
      {
         return _mapId.getValue();
      }
      
      public function getTaskLevel() : Number
      {
         return TaskFactioy.getTaskLevel(_id.getValue());
      }
      
      public function setStata(num:Number) : void
      {
         _state.setValue(num);
      }
      
      public function setTging(bo:Boolean) : void
      {
         _tging = bo;
      }
      
      private function isGoodsOk() : Boolean
      {
         var arr0:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         var i:uint = 0;
         arr0 = getGoodsId();
         arr1 = getGoodsNum();
         arr2 = getGoodsedNum();
         if(arr0 != null)
         {
            for(i = 0; i < arr0.length; i++)
            {
               if(arr1[i] > arr2[i])
               {
                  trace(getName() + ":收集没满足");
                  return false;
               }
            }
         }
         return true;
      }
      
      public function getAwardTypeAndId() : Array
      {
         return TaskFactioy.getAwardTypeAndId(_id.getValue());
      }
      
      public function getLeveling() : Number
      {
         return _level.getValue();
      }
      
      public function set lianji(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _lianji = value;
      }
      
      public function getEnemyNum() : Array
      {
         return TaskFactioy.getEnemyNum(_id.getValue());
      }
      
      public function getAwardNum() : Array
      {
         return TaskFactioy.getAwardNum(_id.getValue());
      }
      
      public function setLeveling(num:Number) : void
      {
         _level.setValue(num);
      }
      
      public function getTg() : Boolean
      {
         return TaskFactioy.getTg(_id.getValue());
      }
      
      public function getTimered() : Number
      {
         return _time.getValue();
      }
      
      public function ismapOk() : Boolean
      {
         var mapNum:Number = NaN;
         mapNum = getMapId();
         if(mapNum != -1)
         {
            if(getMaped() != 0)
            {
               if(mapNum != getMaped())
               {
                  trace(getName() + ":地图条件没满足",getMaped(),mapNum);
                  return false;
               }
            }
         }
         return true;
      }
      
      public function getBett() : Number
      {
         return TaskFactioy.getFightNum(_id.getValue());
      }
      
      public function get level() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _level;
      }
      
      public function isGoodsId(gId:Number) : Boolean
      {
         var arr:Array = null;
         var i:uint = 0;
         arr = getGoodsId();
         for(i = 0; i < arr.length; i++)
         {
            if(gId == arr[i])
            {
               return true;
            }
         }
         return false;
      }
      
      public function getAwardType() : Array
      {
         return TaskFactioy.getAwardType(_id.getValue());
      }
      
      public function getFinishGold() : Number
      {
         return TaskFactioy.getFinishGold(_id.getValue());
      }
      
      public function getEnemyId() : Array
      {
         return TaskFactioy.getEnemyId(_id.getValue());
      }
      
      public function setOverTimer(t:Number) : void
      {
         _overTimer.setValue(t);
      }
      
      public function getIntroduction() : String
      {
         return TaskFactioy.getTaskIntroduction(_id.getValue());
      }
      
      public function get state() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _state;
      }
      
      public function get finishGold() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _finishGold;
      }
      
      public function setFinishGold(num:Number) : void
      {
         trace("存入的G币:" + num);
         _finishGold.setValue(num);
      }
      
      public function getTimer() : Number
      {
         return TaskFactioy.getTimeNum(_id.getValue());
      }
      
      public function getSkillEnemyNum(enemyId:Number) : Number
      {
         var arr:Array = null;
         var i:uint = 0;
         arr = getEnemyId();
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
      
      public function set time(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _time = value;
      }
      
      public function get mapId() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _mapId;
      }
      
      public function getBranch() : Number
      {
         return TaskFactioy.getTaskBranch(_id.getValue());
      }
      
      public function getWho() : Number
      {
         return TaskFactioy.getWho(_id.getValue());
      }
      
      public function set overTimer(value:Number) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _overTimer = value;
      }
      
      public function setGoodsed(arr:Array) : void
      {
         _sjArr = arr;
      }
      
      public function setMaped(num:Number) : void
      {
         _mapId.setValue(num);
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
      
      public function getGoodsNum() : Array
      {
         return TaskFactioy.getGoodsNum(_id.getValue());
      }
      
      public function getGoodsedNum() : Array
      {
         return _sjArr;
      }
      
      public function get time() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _time;
      }
      
      public function getLevel() : Number
      {
         return TaskFactioy.getFinishiLevel(_id.getValue());
      }
      
      public function get overTimer() : Number
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _overTimer;
      }
      
      public function getGold() : Number
      {
         return TaskFactioy.getGold(_id.getValue());
      }
      
      public function getStata() : Number
      {
         return _state.getValue();
      }
      
      public function getBetted() : Number
      {
         return _bett.getValue();
      }
      
      public function getTging() : Boolean
      {
         return _tging;
      }
      
      public function getGoodsId() : Array
      {
         return TaskFactioy.getGoodsId(_id.getValue());
      }
      
      public function getEidAndNum() : Array
      {
         return TaskFactioy.getEenmyIdAndNan(_id.getValue());
      }
      
      public function getMapId() : Number
      {
         return TaskFactioy.getMapId(_id.getValue());
      }
      
      public function setBetted(num:Number) : void
      {
         _bett.setValue(num);
      }
      
      public function getExp() : Number
      {
         return TaskFactioy.getExp(_id.getValue());
      }
      
      public function initEnemyArr() : void
      {
         var arr:Array = null;
         var i:uint = 0;
         arr = getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               _enemyingArr[i] = 0;
            }
         }
      }
      
      public function getGidAndNum() : Array
      {
         return TaskFactioy.getGoodsIdAndNan(_id.getValue());
      }
      
      public function istaskOk() : Boolean
      {
         if(Boolean(isbettOk()) && Boolean(isEnemyOk()) && Boolean(isgoldOk()) && Boolean(isGoodsOk()) && Boolean(islevelOk()) && Boolean(islianjiOk()) && ismapOk() && Boolean(istimeOk()) && Boolean(isTgOk()))
         {
            trace(getName() + ":此任务完成");
            return true;
         }
         trace(getName() + ":此任务没完成");
         return false;
      }
      
      public function getFinishGolded() : Number
      {
         return _finishGold.getValue();
      }
      
      private function isbettOk() : Boolean
      {
         var bt:Number = NaN;
         bt = getBett();
         if(bt != -1)
         {
            if(getBetted() >= bt)
            {
               if(getTging())
               {
                  setTging(false);
               }
               trace(getName() + ":被打数没满足",getBetted(),bt);
               return false;
            }
            if(!getTging())
            {
               trace(getName() + ":被打数满足了,但是没通关");
               return false;
            }
         }
         return true;
      }
      
      public function getEnemyMaxNum(eId:Number) : Number
      {
         var arr:Array = null;
         var arr1:Array = null;
         var i:uint = 0;
         arr = getEnemyId();
         arr1 = getEnemyNum();
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
      
      private function isTgOk() : Boolean
      {
         var bo:Boolean = false;
         bo = getTg();
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
         var arr0:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         var i:uint = 0;
         arr0 = getEnemyId();
         arr1 = getEnemyArr();
         arr2 = getEnemyNum();
         if(arr0 != null)
         {
            for(i = 0; i < arr0.length; i++)
            {
               if(arr1[i] != arr2[i])
               {
                  trace(getName() + ":杀怪没满足");
                  return false;
               }
            }
         }
         return true;
      }
      
      public function isRc() : Boolean
      {
         return TaskFactioy.isRc(_id.getValue());
      }
   }
}

