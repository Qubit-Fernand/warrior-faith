package com.hotpoint.braveManIII.models.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.task.*;
   import src.*;
   
   public class Task
   {
      
      private var _id:VT;
      
      private var _state:VT;
      
      private var _isOld:VT;
      
      private var _sjArr:Array = [];
      
      private var _enemyedArr:Array = [];
      
      private var _overTimer:VT;
      
      private var _time:VT;
      
      private var _lianji:VT;
      
      private var _bett:VT;
      
      private var _mapId:VT;
      
      private var _mapStar:VT;
      
      private var _tg:Boolean = false;
      
      public function Task()
      {
         super();
      }
      
      public static function creatTask(param1:Number) : Task
      {
         var _loc2_:Task = new Task();
         _loc2_._id = VT.createVT(param1);
         _loc2_.initData();
         return _loc2_;
      }
      
      public function initData() : void
      {
         this.initEnemyed();
         this.initGooded();
         this._time = VT.createVT(0);
         this._lianji = VT.createVT(0);
         this._tg = false;
         this._bett = VT.createVT(0);
         this._mapId = VT.createVT(0);
         this._mapStar = VT.createVT(0);
         this._state = VT.createVT(0);
         this._overTimer = VT.createVT(0);
         this._isOld = VT.createVT(0);
      }
      
      public function intGk() : void
      {
         this._time = VT.createVT(0);
         this._lianji = VT.createVT(0);
         this._tg = false;
         this._bett = VT.createVT(0);
      }
      
      public function clearData() : void
      {
         this.initEnemyed();
         this.initGooded();
         this._time = VT.createVT(0);
         this._lianji = VT.createVT(0);
         this._tg = false;
         this._bett = VT.createVT(0);
         this._mapId = VT.createVT(0);
         this._mapStar = VT.createVT(0);
      }
      
      private function initEnemyed() : void
      {
         var _loc1_:Array = this.getEnemyId();
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            this._enemyedArr[_loc2_] = VT.createVT(0);
            _loc2_++;
         }
      }
      
      private function initGooded() : void
      {
         var _loc1_:Array = this.getGoodsId();
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            this._sjArr[_loc2_] = VT.createVT(0);
            _loc2_++;
         }
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return TaskFactory.getName(this._id.getValue());
      }
      
      public function getLevel() : Number
      {
         return TaskFactory.getLevel(this._id.getValue());
      }
      
      public function getTaskIntroduction() : String
      {
         return TaskFactory.getTaskIntroduction(this._id.getValue());
      }
      
      public function getDemand() : String
      {
         return TaskFactory.getDemand(this._id.getValue());
      }
      
      public function getBigType() : Number
      {
         return TaskFactory.getBigType(this._id.getValue());
      }
      
      public function getSmallType() : Number
      {
         return TaskFactory.getSmallType(this._id.getValue());
      }
      
      public function getWtr() : String
      {
         return TaskFactory.getWtr(this._id.getValue());
      }
      
      public function getBeforeTaskId() : Number
      {
         return TaskFactory.getBeforeTaskId(this._id.getValue());
      }
      
      public function getRebirth() : Boolean
      {
         return TaskFactory.getRebirth(this._id.getValue());
      }
      
      public function getMapId() : Number
      {
         return TaskFactory.getMapId(this._id.getValue());
      }
      
      public function getMapStar() : Number
      {
         return TaskFactory.getMapStar(this._id.getValue());
      }
      
      public function getEnemyId() : Array
      {
         return TaskFactory.getEnemyId(this._id.getValue());
      }
      
      public function getEnemyName() : Array
      {
         return TaskFactory.getEnemyName(this._id.getValue());
      }
      
      public function getEnemyNum() : Array
      {
         return TaskFactory.getEnemyNum(this._id.getValue());
      }
      
      public function getEenemyedNum() : Array
      {
         return this._enemyedArr;
      }
      
      public function getGoodsId() : Array
      {
         return TaskFactory.getGoodsId(this._id.getValue());
      }
      
      public function getGoodsNum() : Array
      {
         return TaskFactory.getGoodsNum(this._id.getValue());
      }
      
      public function getGoodsedNum() : Array
      {
         return this._sjArr;
      }
      
      public function getLianjiNum() : Number
      {
         return TaskFactory.getLianjiNum(this._id.getValue());
      }
      
      public function getFightNum() : Number
      {
         return TaskFactory.getFightNum(this._id.getValue());
      }
      
      public function getTime() : Number
      {
         return TaskFactory.getTime(this._id.getValue());
      }
      
      public function getFinishGold() : Number
      {
         return TaskFactory.getFinishGold(this._id.getValue());
      }
      
      public function getFinishLevel() : Number
      {
         return TaskFactory.getFinishLevel(this._id.getValue());
      }
      
      public function getTg() : Boolean
      {
         return TaskFactory.getTg(this._id.getValue());
      }
      
      public function getNpc() : Number
      {
         return TaskFactory.getNpc(this._id.getValue());
      }
      
      public function getYhd() : Number
      {
         return TaskFactory.getYhd(this._id.getValue());
      }
      
      public function getPhb() : Number
      {
         return TaskFactory.getPhb(this._id.getValue());
      }
      
      public function getAwardId() : Array
      {
         return TaskFactory.getAwardId(this._id.getValue());
      }
      
      public function getAwardType() : Array
      {
         return TaskFactory.getAwardType(this._id.getValue());
      }
      
      public function getAwardNum() : Array
      {
         return TaskFactory.getAwardNum(this._id.getValue());
      }
      
      public function getAwardGold() : Number
      {
         return TaskFactory.getAwardGold(this._id.getValue());
      }
      
      public function getAwardExp() : Number
      {
         return TaskFactory.getAwardExp(this._id.getValue());
      }
      
      public function getAwardPs() : Number
      {
         return TaskFactory.getAwardPs(this._id.getValue());
      }
      
      public function getAwardGl() : Array
      {
         return TaskFactory.getAwardGl(this._id.getValue());
      }
      
      public function getState() : Number
      {
         return this._state.getValue();
      }
      
      public function setState(param1:Number) : void
      {
         trace("设置了任务状态:________________________________________",param1);
         this._state.setValue(param1);
      }
      
      public function getOldTime() : Number
      {
         return this._isOld.getValue();
      }
      
      public function setOldTime(param1:Number) : void
      {
         this._isOld.setValue(param1);
      }
      
      public function setOverTime(param1:Number) : void
      {
         this._overTimer.setValue(param1);
      }
      
      public function getOverTime() : Number
      {
         return this._overTimer.getValue();
      }
      
      public function setMapId(param1:Number) : void
      {
         if(this.getMapId() != -1)
         {
            this._mapId.setValue(param1);
         }
      }
      
      public function setMapStar(param1:Number) : void
      {
         if(this.getMapStar() != -1)
         {
            this._mapStar.setValue(param1);
         }
      }
      
      public function setTg() : void
      {
         this._tg = true;
      }
      
      public function setEnemyNum(param1:Number) : void
      {
         var _loc4_:uint = 0;
         var _loc2_:Array = this.getEnemyId();
         var _loc3_:Array = this.getEnemyNum();
         if(this.isMapStarOk())
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_loc2_[_loc4_].getValue() == param1)
               {
                  if(this._enemyedArr[_loc4_].getValue() < _loc3_[_loc4_].getValue())
                  {
                     this._enemyedArr[_loc4_].setValue(this._enemyedArr[_loc4_].getValue() + 1);
                     break;
                  }
               }
               _loc4_++;
            }
         }
      }
      
      public function setGoodsed(param1:Array) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            if(!(param1[_loc2_] is VT))
            {
               param1[_loc2_] = VT.createVT(param1[_loc2_]);
            }
            _loc2_++;
         }
         this._sjArr = param1;
      }
      
      public function setGoods(param1:Number) : void
      {
         var _loc2_:Array = this.getGoodsId();
         var _loc3_:Array = this.getGoodsNum();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].getValue() == param1 && this._sjArr[_loc4_].getValue() < _loc3_[_loc4_].getValue())
            {
               this._sjArr[_loc4_].setValue(this._sjArr[_loc4_].getValue() + 1);
               break;
            }
            _loc4_++;
         }
      }
      
      private function isMapIdOk() : Boolean
      {
         if(this.getMapId() == -1)
         {
            return true;
         }
         if(this.getMapId() == this._mapId.getValue())
         {
            return true;
         }
         trace("地图ID没满足");
         return false;
      }
      
      public function isMapStarOk() : Boolean
      {
         if(this.getMapStar() == -1)
         {
            return true;
         }
         if(this.getMapStar() <= this._mapStar.getValue())
         {
            return true;
         }
         trace("地图星级没满足");
         return false;
      }
      
      private function isTgOk() : Boolean
      {
         if(!this.getTg())
         {
            return true;
         }
         if(this._tg)
         {
            return true;
         }
         trace("通关没满足");
         return false;
      }
      
      private function isTimeOk() : Boolean
      {
         if(this.getTime() == -1)
         {
            return true;
         }
         if(WinShow.txt_1 <= this.getTime())
         {
            return true;
         }
         trace("通关时间没满足");
         return false;
      }
      
      private function isLjOk() : Boolean
      {
         if(this.getLianjiNum() == -1)
         {
            return true;
         }
         trace(this.getLianjiNum(),WinShow.txt_2,"连击");
         if(WinShow.txt_2 >= this.getLianjiNum())
         {
            return true;
         }
         trace("连击数没满足");
         return false;
      }
      
      private function isBettOk() : Boolean
      {
         if(this.getFightNum() == -1)
         {
            return true;
         }
         if(WinShow.txt_3 <= this.getFightNum())
         {
            return true;
         }
         trace("被击打数没满足");
         return false;
      }
      
      private function isPlayerLevelOk() : Boolean
      {
         if(this.getFinishLevel() == -1)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player1.getLevel() >= Main.player2.getLevel())
            {
               if(Main.player1.getLevel() >= this.getFinishLevel())
               {
                  return true;
               }
            }
            else if(Main.player2.getLevel() >= this.getFinishLevel())
            {
               return true;
            }
         }
         if(Main.player1.getLevel() >= this.getFinishLevel())
         {
            return true;
         }
         trace("角色等级没满足");
         return false;
      }
      
      private function isPlayerGoldOk() : Boolean
      {
         if(this.getFinishGold() == -1)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player1.getGold() >= Main.player2.getGold())
            {
               if(Main.player1.getGold() >= this.getFinishGold())
               {
                  return true;
               }
            }
            else if(Main.player2.getGold() >= this.getFinishGold())
            {
               return true;
            }
         }
         if(Main.player1.getGold() >= this.getFinishGold())
         {
            return true;
         }
         trace("角色金币没满足");
         return false;
      }
      
      private function isEnemyOk() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         var _loc1_:Array = this.getEnemyId();
         var _loc2_:Array = this.getEnemyNum();
         if(_loc1_[0].getValue() == -1)
         {
            return true;
         }
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(this._enemyedArr[_loc4_].getValue() < _loc2_[_loc4_].getValue())
            {
               _loc3_ = false;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            trace("杀怪数量没满足");
         }
         return _loc3_;
      }
      
      private function isGoodsOk() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         var _loc1_:Array = this.getGoodsId();
         var _loc2_:Array = this.getGoodsNum();
         if(_loc1_[0].getValue() == -1)
         {
            return true;
         }
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(this._sjArr[_loc4_] is VT)
            {
               if(this._sjArr[_loc4_].getValue() < _loc2_[_loc4_].getValue())
               {
                  _loc3_ = false;
               }
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            trace("收集数量没满足");
         }
         return _loc3_;
      }
      
      private function yhdOk() : Boolean
      {
         var _loc1_:Number = this.getYhd();
         var _loc2_:Number = this.getNpc();
         if(_loc1_ == -1)
         {
            return true;
         }
         if(InitData.qinMiDu_Arr[_loc2_].getValue() >= _loc1_)
         {
            return true;
         }
         return false;
      }
      
      private function phbOk() : Boolean
      {
         if(this.getPhb() == -1)
         {
            return true;
         }
         if(PK_UI.whoNumX.getValue() <= this.getPhb())
         {
            return true;
         }
         return false;
      }
      
      public function isTaskOk() : void
      {
         if(Boolean(this.isMapIdOk()) && this.isMapStarOk() && Boolean(this.isBettOk()) && Boolean(this.isEnemyOk()) && Boolean(this.isGoodsOk()) && Boolean(this.isPlayerGoldOk()) && Boolean(this.isPlayerLevelOk()) && Boolean(this.isTimeOk()) && Boolean(this.isLjOk()) && Boolean(this.isTgOk()) && Boolean(this.yhdOk()) && Boolean(this.phbOk()))
         {
            this.setState(2);
            Play_Interface.TiShiShow(true);
         }
         else
         {
            this.setState(1);
         }
      }
      
      public function setEneSave(param1:Array) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            if(!(param1[_loc2_] is VT))
            {
               param1[_loc2_] = VT.createVT(param1[_loc2_]);
            }
            _loc2_++;
         }
         this._enemyedArr = param1;
      }
   }
}

