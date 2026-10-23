package com.hotpoint.braveManIII.models.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.task.*;
   import flash.utils.*;
   
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
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = value;
      }
      
      public function get state() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._state;
      }
      
      public function set state(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._state = value;
      }
      
      public function get time() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._time;
      }
      
      public function set time(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._time = value;
      }
      
      public function get lianji() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._lianji;
      }
      
      public function set lianji(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._lianji = value;
      }
      
      public function get bett() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._bett;
      }
      
      public function set bett(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._bett = value;
      }
      
      public function get mapId() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._mapId;
      }
      
      public function set mapId(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._mapId = value;
      }
      
      public function get finishGold() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._finishGold;
      }
      
      public function set finishGold(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._finishGold = value;
      }
      
      public function get level() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._level;
      }
      
      public function set level(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._level = value;
      }
      
      public function get overTimer() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._overTimer;
      }
      
      public function set overTimer(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._overTimer = value;
      }
      
      public function get enemyingArr() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._enemyingArr;
      }
      
      public function set enemyingArr(value:Array) : void
      {
         this._enemyingArr = value;
      }
      
      public function get sjArr() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._sjArr;
      }
      
      public function set sjArr(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._sjArr = value;
      }
      
      public function get tging() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._tging;
      }
      
      public function set tging(value:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._tging = value;
      }
      
      public function getUrl() : String
      {
         return TaskFactioy.getUrl(this._id.getValue());
      }
      
      public function getName() : String
      {
         return TaskFactioy.getTaskName(this._id.getValue());
      }
      
      public function getBranch() : Number
      {
         return TaskFactioy.getTaskBranch(this._id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return TaskFactioy.getTaskIntroduction(this._id.getValue());
      }
      
      public function getDemand() : String
      {
         return TaskFactioy.getTaskDemand(this._id.getValue());
      }
      
      public function isAgin() : Boolean
      {
         return TaskFactioy.isAgin(this._id.getValue());
      }
      
      public function isRc() : Boolean
      {
         return TaskFactioy.isRc(this._id.getValue());
      }
      
      public function getOverTimer() : Number
      {
         return this._overTimer.getValue();
      }
      
      public function setOverTimer(t:Number) : void
      {
         this._overTimer.setValue(t);
      }
      
      public function getTg() : Boolean
      {
         return TaskFactioy.getTg(this._id.getValue());
      }
      
      public function getTging() : Boolean
      {
         return this._tging;
      }
      
      public function setTging(bo:Boolean) : void
      {
         this._tging = bo;
      }
      
      public function getFinishGold() : Number
      {
         return TaskFactioy.getFinishGold(this._id.getValue());
      }
      
      public function setFinishGold(num:Number) : void
      {
         trace("存入的G币:" + num);
         this._finishGold.setValue(num);
      }
      
      public function getFinishGolded() : Number
      {
         return this._finishGold.getValue();
      }
      
      public function getTaskLevel() : Number
      {
         return TaskFactioy.getTaskLevel(this._id.getValue());
      }
      
      public function getDelet() : Boolean
      {
         return TaskFactioy.getDelet(this._id.getValue());
      }
      
      public function getLevel() : Number
      {
         return TaskFactioy.getFinishiLevel(this._id.getValue());
      }
      
      public function getLeveling() : Number
      {
         return this._level.getValue();
      }
      
      public function setLeveling(num:Number) : void
      {
         trace("存入的级别:" + num);
         this._level.setValue(num);
      }
      
      public function getMapId() : Number
      {
         return TaskFactioy.getMapId(this._id.getValue());
      }
      
      public function setMaped(num:Number) : void
      {
         trace(num + "已经存入的地图ID");
         this._mapId.setValue(num);
      }
      
      public function getMaped() : Number
      {
         return this._mapId.getValue();
      }
      
      public function getWho() : Number
      {
         return TaskFactioy.getWho(this._id.getValue());
      }
      
      public function getEnemyId() : Array
      {
         return TaskFactioy.getEnemyId(this._id.getValue());
      }
      
      public function getEnemyName() : Array
      {
         return TaskFactioy.getEnemyName(this._id.getValue());
      }
      
      public function getEnemyNum() : Array
      {
         return TaskFactioy.getEnemyNum(this._id.getValue());
      }
      
      public function getEidAndNum() : Array
      {
         return TaskFactioy.getEenmyIdAndNan(this._id.getValue());
      }
      
      public function getGoodsId() : Array
      {
         return TaskFactioy.getGoodsId(this._id.getValue());
      }
      
      public function getGoodsNum() : Array
      {
         return TaskFactioy.getGoodsNum(this._id.getValue());
      }
      
      public function getGidAndNum() : Array
      {
         return TaskFactioy.getGoodsIdAndNan(this._id.getValue());
      }
      
      public function getTimer() : Number
      {
         return TaskFactioy.getTimeNum(this._id.getValue());
      }
      
      public function setTimer(time:Number) : void
      {
         this._time.setValue(time);
      }
      
      public function getTimered() : Number
      {
         return this._time.getValue();
      }
      
      public function getLianji() : Number
      {
         return TaskFactioy.getLianjiNum(this._id.getValue());
      }
      
      public function setLianjied(num:Number) : void
      {
         this._lianji.setValue(num);
      }
      
      public function getLianJied() : Number
      {
         return this._lianji.getValue();
      }
      
      public function getBett() : Number
      {
         return TaskFactioy.getFightNum(this._id.getValue());
      }
      
      public function setBetted(num:Number) : void
      {
         this._bett.setValue(num);
      }
      
      public function getBetted() : Number
      {
         return this._bett.getValue();
      }
      
      public function getGold() : Number
      {
         return TaskFactioy.getGold(this._id.getValue());
      }
      
      public function getExp() : Number
      {
         return TaskFactioy.getExp(this._id.getValue());
      }
      
      public function getAwardTypeAndId() : Array
      {
         return TaskFactioy.getAwardTypeAndId(this._id.getValue());
      }
      
      public function getAwardNum() : Array
      {
         return TaskFactioy.getAwardNum(this._id.getValue());
      }
      
      public function getAwardType() : Array
      {
         return TaskFactioy.getAwardType(this._id.getValue());
      }
      
      public function getAwardPlayerDate() : Number
      {
         return TaskFactioy.getPlayerDtate(this._id.getValue());
      }
      
      public function getStata() : Number
      {
         return this._state.getValue();
      }
      
      public function setStata(num:Number) : void
      {
         this._state.setValue(num);
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function initEnemyArr() : void
      {
         var i:uint = 0;
         var arr:Array = this.getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               this._enemyingArr[i] = 0;
            }
         }
      }
      
      public function getSkillEnemyNum(enemyId:Number) : Number
      {
         var i:uint = 0;
         var arr:Array = this.getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(enemyId == arr[i])
               {
                  return this._enemyingArr[i];
               }
            }
         }
         return -1;
      }
      
      public function getEnemyMaxNum(eId:Number) : Number
      {
         var i:uint = 0;
         var arr:Array = this.getEnemyId();
         var arr1:Array = this.getEnemyNum();
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
         var arr:Array = this.getEnemyId();
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
         var arr:Array = this.getEnemyId();
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               if(arr[i] == id)
               {
                  ++this._enemyingArr[i];
                  trace("已经击杀:" + this._enemyingArr[i]);
                  break;
               }
            }
         }
      }
      
      public function getEnemyArr() : Array
      {
         return this._enemyingArr;
      }
      
      public function goodsedArr() : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(this.getGoodsId() != null)
         {
            arr = this.getGoodsId();
            for(i = 0; i < arr.length; i++)
            {
               this._sjArr[i] = 0;
            }
         }
      }
      
      public function getGoodsedNum() : Array
      {
         return this._sjArr;
      }
      
      public function setGoodsed(arr:Array) : void
      {
         this._sjArr = arr;
      }
      
      public function isGoodsId(gId:Number) : Boolean
      {
         var arr:Array = this.getGoodsId();
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
         var bo:Boolean = this.getTg();
         if(bo)
         {
            if(!this.getTging())
            {
               return false;
            }
         }
         return true;
      }
      
      private function isEnemyOk() : Boolean
      {
         var i:uint = 0;
         var arr0:Array = this.getEnemyId();
         var arr1:Array = this.getEnemyArr();
         var arr2:Array = this.getEnemyNum();
         if(arr0 != null)
         {
            for(i = 0; i < arr0.length; i++)
            {
               if(arr1[i] < arr2[i])
               {
                  trace(this.getName() + ":杀怪没满足");
                  return false;
               }
            }
         }
         return true;
      }
      
      private function isGoodsOk() : Boolean
      {
         var i:uint = 0;
         var arr0:Array = this.getGoodsId();
         var arr1:Array = this.getGoodsNum();
         var arr2:Array = this.getGoodsedNum();
         if(arr0 != null)
         {
            for(i = 0; i < arr0.length; i++)
            {
               if(arr1[i] > arr2[i])
               {
                  trace(this.getName() + ":收集没满足");
                  return false;
               }
            }
         }
         return true;
      }
      
      public function ismapOk() : Boolean
      {
         var mapNum:Number = this.getMapId();
         trace(mapNum + "规定的地图ID");
         trace(this.getMaped() + "现在所处地图");
         if(mapNum != -1)
         {
            if(this.getMaped() == 0)
            {
               trace("在村庄没满足地图条件");
               return false;
            }
            if(mapNum != this.getMaped())
            {
               trace(this.getName() + ":地图条件没满足",this.getMaped(),mapNum);
               return false;
            }
            trace("地图条件满足");
         }
         return true;
      }
      
      private function istimeOk() : Boolean
      {
         var time:Number = this.getTimer();
         if(time != -1)
         {
            trace("已经存入的时间:+getTimered()" + this.getTimered());
            trace("规定时间:" + time);
            if(time < this.getTimered())
            {
               if(this.getTging())
               {
                  this.setTging(false);
               }
               trace(this.getName() + ":时间没满足",this.getTimered(),time);
               return false;
            }
            if(!this.getTging())
            {
               trace(this.getName() + ":时间满足了,但是没通关");
               return false;
            }
         }
         return true;
      }
      
      private function islianjiOk() : Boolean
      {
         var lj:Number = this.getLianji();
         if(lj != -1)
         {
            if(lj > this.getLianJied())
            {
               trace(this.getName() + ":连击没满足",this.getLianJied(),lj);
               return false;
            }
         }
         return true;
      }
      
      private function isbettOk() : Boolean
      {
         var bt:Number = this.getBett();
         if(bt != -1)
         {
            if(this.getBetted() >= bt)
            {
               if(this.getTging())
               {
                  this.setTging(false);
               }
               trace(this.getName() + ":被打数没满足",this.getBetted(),bt);
               return false;
            }
            if(!this.getTging())
            {
               trace(this.getName() + ":被打数满足了,但是没通关");
               return false;
            }
         }
         return true;
      }
      
      private function isgoldOk() : Boolean
      {
         var g:Number = this.getFinishGold();
         if(g != -1)
         {
            if(g > this.getFinishGolded())
            {
               trace(this.getName() + ":G没满足");
               return false;
            }
         }
         return true;
      }
      
      private function islevelOk() : Boolean
      {
         var level:Number = this.getLevel();
         trace("任务规定级数:" + level);
         trace("角色现在级数:" + this.getLeveling());
         if(level != -1)
         {
            if(level > this.getLeveling())
            {
               trace(this.getName() + ":级别没满足");
               return false;
            }
         }
         return true;
      }
      
      public function istaskOk() : Boolean
      {
         if(Boolean(this.isbettOk()) && Boolean(this.isEnemyOk()) && Boolean(this.isgoldOk()) && Boolean(this.isGoodsOk()) && Boolean(this.islevelOk()) && Boolean(this.islianjiOk()) && this.ismapOk() && Boolean(this.istimeOk()) && this.isTgOk())
         {
            trace(this.getName() + ":此任务完成~~~~~~~~~~~~~~~~~~~~");
            return true;
         }
         trace(this.getName() + ":此任务没完成___________________");
         trace("*********");
         return false;
      }
      
      public function clearKong() : void
      {
         this.initEnemyArr();
         this.goodsedArr();
         this._time.setValue(0);
         this._lianji.setValue(0);
         this._tging = false;
         this._bett.setValue(0);
         this._mapId.setValue(0);
      }
   }
}

