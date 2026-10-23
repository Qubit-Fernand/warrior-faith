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
      
      public static function creatTask(param1:Number) : Task
      {
         var _loc2_:Task = new Task();
         _loc2_._id = VT.createVT(param1);
         _loc2_._state = VT.createVT(0);
         _loc2_._level = VT.createVT(0);
         _loc2_._finishGold = VT.createVT(0);
         _loc2_._bett = VT.createVT(0);
         _loc2_._lianji = VT.createVT(0);
         _loc2_._mapId = VT.createVT(0);
         _loc2_._time = VT.createVT(0);
         _loc2_._overTimer = VT.createVT(0);
         _loc2_._tging = false;
         _loc2_.goodsedArr();
         _loc2_.initEnemyArr();
         return _loc2_;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = param1;
      }
      
      public function get state() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._state;
      }
      
      public function set state(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._state = param1;
      }
      
      public function get time() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._time;
      }
      
      public function set time(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._time = param1;
      }
      
      public function get lianji() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._lianji;
      }
      
      public function set lianji(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._lianji = param1;
      }
      
      public function get bett() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._bett;
      }
      
      public function set bett(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._bett = param1;
      }
      
      public function get mapId() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._mapId;
      }
      
      public function set mapId(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._mapId = param1;
      }
      
      public function get finishGold() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._finishGold;
      }
      
      public function set finishGold(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._finishGold = param1;
      }
      
      public function get level() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._level;
      }
      
      public function set level(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._level = param1;
      }
      
      public function get overTimer() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._overTimer;
      }
      
      public function set overTimer(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._overTimer = param1;
      }
      
      public function get enemyingArr() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._enemyingArr;
      }
      
      public function set enemyingArr(param1:Array) : void
      {
         this._enemyingArr = param1;
      }
      
      public function get sjArr() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._sjArr;
      }
      
      public function set sjArr(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._sjArr = param1;
      }
      
      public function get tging() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._tging;
      }
      
      public function set tging(param1:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._tging = param1;
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
      
      public function setOverTimer(param1:Number) : void
      {
         this._overTimer.setValue(param1);
      }
      
      public function getTg() : Boolean
      {
         return TaskFactioy.getTg(this._id.getValue());
      }
      
      public function getTging() : Boolean
      {
         return this._tging;
      }
      
      public function setTging(param1:Boolean) : void
      {
         this._tging = param1;
      }
      
      public function getFinishGold() : Number
      {
         return TaskFactioy.getFinishGold(this._id.getValue());
      }
      
      public function setFinishGold(param1:Number) : void
      {
         trace("存入的G币:" + param1);
         this._finishGold.setValue(param1);
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
      
      public function setLeveling(param1:Number) : void
      {
         trace("存入的级别:" + param1);
         this._level.setValue(param1);
      }
      
      public function getMapId() : Number
      {
         return TaskFactioy.getMapId(this._id.getValue());
      }
      
      public function setMaped(param1:Number) : void
      {
         trace(param1 + "已经存入的地图ID");
         this._mapId.setValue(param1);
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
      
      public function setTimer(param1:Number) : void
      {
         this._time.setValue(param1);
      }
      
      public function getTimered() : Number
      {
         return this._time.getValue();
      }
      
      public function getLianji() : Number
      {
         return TaskFactioy.getLianjiNum(this._id.getValue());
      }
      
      public function setLianjied(param1:Number) : void
      {
         this._lianji.setValue(param1);
      }
      
      public function getLianJied() : Number
      {
         return this._lianji.getValue();
      }
      
      public function getBett() : Number
      {
         return TaskFactioy.getFightNum(this._id.getValue());
      }
      
      public function setBetted(param1:Number) : void
      {
         this._bett.setValue(param1);
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
      
      public function setStata(param1:Number) : void
      {
         this._state.setValue(param1);
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function initEnemyArr() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:Array = this.getEnemyId();
         if(_loc1_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               this._enemyingArr[_loc2_] = 0;
               _loc2_++;
            }
         }
      }
      
      public function getSkillEnemyNum(param1:Number) : Number
      {
         var _loc3_:uint = 0;
         var _loc2_:Array = this.getEnemyId();
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(param1 == _loc2_[_loc3_])
               {
                  return this._enemyingArr[_loc3_];
               }
               _loc3_++;
            }
         }
         return -1;
      }
      
      public function getEnemyMaxNum(param1:Number) : Number
      {
         var _loc4_:uint = 0;
         var _loc2_:Array = this.getEnemyId();
         var _loc3_:Array = this.getEnemyNum();
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_loc2_[_loc4_] == param1)
               {
                  return _loc3_[_loc4_];
               }
               _loc4_++;
            }
         }
         return -1;
      }
      
      public function isEnemyId(param1:Number) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc2_:Array = this.getEnemyId();
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(param1 == _loc2_[_loc3_])
               {
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      public function addSkillEnemyNum(param1:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:Array = this.getEnemyId();
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_] == param1)
               {
                  ++this._enemyingArr[_loc3_];
                  trace("已经击杀:" + this._enemyingArr[_loc3_]);
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      public function getEnemyArr() : Array
      {
         return this._enemyingArr;
      }
      
      public function goodsedArr() : void
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         if(this.getGoodsId() != null)
         {
            _loc1_ = this.getGoodsId();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               this._sjArr[_loc2_] = 0;
               _loc2_++;
            }
         }
      }
      
      public function getGoodsedNum() : Array
      {
         return this._sjArr;
      }
      
      public function setGoodsed(param1:Array) : void
      {
         this._sjArr = param1;
      }
      
      public function isGoodsId(param1:Number) : Boolean
      {
         var _loc2_:Array = this.getGoodsId();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 == _loc2_[_loc3_])
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function isTgOk() : Boolean
      {
         var _loc1_:Boolean = this.getTg();
         if(_loc1_)
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
         var _loc4_:uint = 0;
         var _loc1_:Array = this.getEnemyId();
         var _loc2_:Array = this.getEnemyArr();
         var _loc3_:Array = this.getEnemyNum();
         if(_loc1_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               if(_loc2_[_loc4_] < _loc3_[_loc4_])
               {
                  trace(this.getName() + ":杀怪没满足");
                  return false;
               }
               _loc4_++;
            }
         }
         return true;
      }
      
      private function isGoodsOk() : Boolean
      {
         var _loc4_:uint = 0;
         var _loc1_:Array = this.getGoodsId();
         var _loc2_:Array = this.getGoodsNum();
         var _loc3_:Array = this.getGoodsedNum();
         if(_loc1_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               if(_loc2_[_loc4_] > _loc3_[_loc4_])
               {
                  trace(this.getName() + ":收集没满足");
                  return false;
               }
               _loc4_++;
            }
         }
         return true;
      }
      
      public function ismapOk() : Boolean
      {
         var _loc1_:Number = this.getMapId();
         trace(_loc1_ + "规定的地图ID");
         trace(this.getMaped() + "现在所处地图");
         if(_loc1_ != -1)
         {
            if(this.getMaped() == 0)
            {
               trace("在村庄没满足地图条件");
               return false;
            }
            if(_loc1_ != this.getMaped())
            {
               trace(this.getName() + ":地图条件没满足",this.getMaped(),_loc1_);
               return false;
            }
            trace("地图条件满足");
         }
         return true;
      }
      
      private function istimeOk() : Boolean
      {
         var _loc1_:Number = this.getTimer();
         if(_loc1_ != -1)
         {
            trace("已经存入的时间:+getTimered()" + this.getTimered());
            trace("规定时间:" + _loc1_);
            if(_loc1_ < this.getTimered())
            {
               if(this.getTging())
               {
                  this.setTging(false);
               }
               trace(this.getName() + ":时间没满足",this.getTimered(),_loc1_);
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
         var _loc1_:Number = this.getLianji();
         if(_loc1_ != -1)
         {
            if(_loc1_ > this.getLianJied())
            {
               trace(this.getName() + ":连击没满足",this.getLianJied(),_loc1_);
               return false;
            }
         }
         return true;
      }
      
      private function isbettOk() : Boolean
      {
         var _loc1_:Number = this.getBett();
         if(_loc1_ != -1)
         {
            if(this.getBetted() >= _loc1_)
            {
               if(this.getTging())
               {
                  this.setTging(false);
               }
               trace(this.getName() + ":被打数没满足",this.getBetted(),_loc1_);
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
         var _loc1_:Number = this.getFinishGold();
         if(_loc1_ != -1)
         {
            if(_loc1_ > this.getFinishGolded())
            {
               trace(this.getName() + ":G没满足");
               return false;
            }
         }
         return true;
      }
      
      private function islevelOk() : Boolean
      {
         var _loc1_:Number = this.getLevel();
         trace("任务规定级数:" + _loc1_);
         trace("角色现在级数:" + this.getLeveling());
         if(_loc1_ != -1)
         {
            if(_loc1_ > this.getLeveling())
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

