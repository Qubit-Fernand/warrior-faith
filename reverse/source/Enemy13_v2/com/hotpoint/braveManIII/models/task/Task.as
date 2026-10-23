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
         initEnemyed();
         initGooded();
         _time = VT.createVT(0);
         _lianji = VT.createVT(0);
         _tg = false;
         _bett = VT.createVT(0);
         _mapId = VT.createVT(0);
         _mapStar = VT.createVT(0);
         _state = VT.createVT(0);
         _overTimer = VT.createVT(0);
         _isOld = VT.createVT(0);
      }
      
      public function intGk() : void
      {
         _time = VT.createVT(0);
         _lianji = VT.createVT(0);
         _tg = false;
         _bett = VT.createVT(0);
      }
      
      public function clearData() : void
      {
         initEnemyed();
         initGooded();
         _time = VT.createVT(0);
         _lianji = VT.createVT(0);
         _tg = false;
         _bett = VT.createVT(0);
         _mapId = VT.createVT(0);
         _mapStar = VT.createVT(0);
      }
      
      private function initEnemyed() : void
      {
         var _loc1_:Array = getEnemyId();
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            _enemyedArr[_loc2_] = 0;
            _loc2_++;
         }
      }
      
      private function initGooded() : void
      {
         var _loc1_:Array = getGoodsId();
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_.length)
         {
            _sjArr[_loc2_] = 0;
            _loc2_++;
         }
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return TaskFactory.getName(_id.getValue());
      }
      
      public function getLevel() : Number
      {
         return TaskFactory.getLevel(_id.getValue());
      }
      
      public function getTaskIntroduction() : String
      {
         return TaskFactory.getTaskIntroduction(_id.getValue());
      }
      
      public function getDemand() : String
      {
         return TaskFactory.getDemand(_id.getValue());
      }
      
      public function getBigType() : Number
      {
         return TaskFactory.getBigType(_id.getValue());
      }
      
      public function getSmallType() : Number
      {
         return TaskFactory.getSmallType(_id.getValue());
      }
      
      public function getWtr() : String
      {
         return TaskFactory.getWtr(_id.getValue());
      }
      
      public function getBeforeTaskId() : Number
      {
         return TaskFactory.getBeforeTaskId(_id.getValue());
      }
      
      public function getRebirth() : Boolean
      {
         return TaskFactory.getRebirth(_id.getValue());
      }
      
      public function getMapId() : Number
      {
         return TaskFactory.getMapId(_id.getValue());
      }
      
      public function getMapStar() : Number
      {
         return TaskFactory.getMapStar(_id.getValue());
      }
      
      public function getEnemyId() : Array
      {
         return TaskFactory.getEnemyId(_id.getValue());
      }
      
      public function getEnemyName() : Array
      {
         return TaskFactory.getEnemyName(_id.getValue());
      }
      
      public function getEnemyNum() : Array
      {
         return TaskFactory.getEnemyNum(_id.getValue());
      }
      
      public function getEenemyedNum() : Array
      {
         return _enemyedArr;
      }
      
      public function getGoodsId() : Array
      {
         return TaskFactory.getGoodsId(_id.getValue());
      }
      
      public function getGoodsNum() : Array
      {
         return TaskFactory.getGoodsNum(_id.getValue());
      }
      
      public function getGoodsedNum() : Array
      {
         return _sjArr;
      }
      
      public function getLianjiNum() : Number
      {
         return TaskFactory.getLianjiNum(_id.getValue());
      }
      
      public function getFightNum() : Number
      {
         return TaskFactory.getFightNum(_id.getValue());
      }
      
      public function getTime() : Number
      {
         return TaskFactory.getTime(_id.getValue());
      }
      
      public function getFinishGold() : Number
      {
         return TaskFactory.getFinishGold(_id.getValue());
      }
      
      public function getFinishLevel() : Number
      {
         return TaskFactory.getFinishLevel(_id.getValue());
      }
      
      public function getTg() : Boolean
      {
         return TaskFactory.getTg(_id.getValue());
      }
      
      public function getNpc() : Number
      {
         return TaskFactory.getNpc(_id.getValue());
      }
      
      public function getYhd() : Number
      {
         return TaskFactory.getYhd(_id.getValue());
      }
      
      public function getPhb() : Number
      {
         return TaskFactory.getPhb(_id.getValue());
      }
      
      public function getAwardId() : Array
      {
         return TaskFactory.getAwardId(_id.getValue());
      }
      
      public function getAwardType() : Array
      {
         return TaskFactory.getAwardType(_id.getValue());
      }
      
      public function getAwardNum() : Array
      {
         return TaskFactory.getAwardNum(_id.getValue());
      }
      
      public function getAwardGold() : Number
      {
         return TaskFactory.getAwardGold(_id.getValue());
      }
      
      public function getAwardExp() : Number
      {
         return TaskFactory.getAwardExp(_id.getValue());
      }
      
      public function getAwardPs() : Number
      {
         return TaskFactory.getAwardPs(_id.getValue());
      }
      
      public function getAwardGl() : Array
      {
         return TaskFactory.getAwardGl(_id.getValue());
      }
      
      public function getState() : Number
      {
         return _state.getValue();
      }
      
      public function setState(param1:Number) : void
      {
         trace("设置了任务状态:________________________________________",param1);
         _state.setValue(param1);
      }
      
      public function getOldTime() : Number
      {
         return _isOld.getValue();
      }
      
      public function setOldTime(param1:Number) : void
      {
         _isOld.setValue(param1);
      }
      
      public function setOverTime(param1:Number) : void
      {
         _overTimer.setValue(param1);
      }
      
      public function getOverTime() : Number
      {
         return _overTimer.getValue();
      }
      
      public function setMapId(param1:Number) : void
      {
         if(getMapId() != -1)
         {
            _mapId.setValue(param1);
         }
      }
      
      public function setMapStar(param1:Number) : void
      {
         if(getMapStar() != -1)
         {
            _mapStar.setValue(param1);
         }
      }
      
      public function setTg() : void
      {
         _tg = true;
      }
      
      public function setEnemyNum(param1:Number) : void
      {
         var _loc4_:uint = 0;
         var _loc2_:Array = getEnemyId();
         var _loc3_:Array = getEnemyNum();
         if(isMapStarOk())
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if(_loc2_[_loc4_].getValue() == param1)
               {
                  if(_enemyedArr[_loc4_] < _loc3_[_loc4_].getValue())
                  {
                     ++_enemyedArr[_loc4_];
                     break;
                  }
               }
               _loc4_++;
            }
         }
      }
      
      public function setGoodsed(param1:Array) : void
      {
         _sjArr = param1;
      }
      
      public function setGoods(param1:Number) : void
      {
         var _loc2_:Array = getGoodsId();
         var _loc3_:Array = getGoodsNum();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].getValue() == param1 && _sjArr[_loc4_] < _loc3_[_loc4_].getValue())
            {
               ++_sjArr[_loc4_];
               break;
            }
            _loc4_++;
         }
      }
      
      private function isMapIdOk() : Boolean
      {
         if(getMapId() == -1)
         {
            return true;
         }
         if(getMapId() == _mapId.getValue())
         {
            return true;
         }
         trace("地图ID没满足");
         return false;
      }
      
      public function isMapStarOk() : Boolean
      {
         if(getMapStar() == -1)
         {
            return true;
         }
         if(getMapStar() <= _mapStar.getValue())
         {
            return true;
         }
         trace("地图星级没满足");
         return false;
      }
      
      private function isTgOk() : Boolean
      {
         if(!getTg())
         {
            return true;
         }
         if(_tg)
         {
            return true;
         }
         trace("通关没满足");
         return false;
      }
      
      private function isTimeOk() : Boolean
      {
         if(getTime() == -1)
         {
            return true;
         }
         if(WinShow.txt_1 <= getTime())
         {
            return true;
         }
         trace("通关时间没满足");
         return false;
      }
      
      private function isLjOk() : Boolean
      {
         if(getLianjiNum() == -1)
         {
            return true;
         }
         trace(getLianjiNum(),WinShow.txt_2,"连击");
         if(WinShow.txt_2 >= getLianjiNum())
         {
            return true;
         }
         trace("连击数没满足");
         return false;
      }
      
      private function isBettOk() : Boolean
      {
         if(getFightNum() == -1)
         {
            return true;
         }
         if(WinShow.txt_3 <= getFightNum())
         {
            return true;
         }
         trace("被击打数没满足");
         return false;
      }
      
      private function isPlayerLevelOk() : Boolean
      {
         if(getFinishLevel() == -1)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player1.getLevel() >= Main.player2.getLevel())
            {
               if(Main.player1.getLevel() >= getFinishLevel())
               {
                  return true;
               }
            }
            else if(Main.player2.getLevel() >= getFinishLevel())
            {
               return true;
            }
         }
         if(Main.player1.getLevel() >= getFinishLevel())
         {
            return true;
         }
         trace("角色等级没满足");
         return false;
      }
      
      private function isPlayerGoldOk() : Boolean
      {
         if(getFinishGold() == -1)
         {
            return true;
         }
         if(Main.P1P2)
         {
            if(Main.player1.getGold() >= Main.player2.getGold())
            {
               if(Main.player1.getGold() >= getFinishGold())
               {
                  return true;
               }
            }
            else if(Main.player2.getGold() >= getFinishGold())
            {
               return true;
            }
         }
         if(Main.player1.getGold() >= getFinishGold())
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
         var _loc1_:Array = getEnemyId();
         var _loc2_:Array = getEnemyNum();
         if(_loc1_[0].getValue() == -1)
         {
            return true;
         }
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(_enemyedArr[_loc4_] < _loc2_[_loc4_].getValue())
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
         var _loc1_:Array = getGoodsId();
         var _loc2_:Array = getGoodsNum();
         if(_loc1_[0].getValue() == -1)
         {
            return true;
         }
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(_sjArr[_loc4_] < _loc2_[_loc4_].getValue())
            {
               _loc3_ = false;
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
         var _loc1_:Number = getYhd();
         var _loc2_:Number = getNpc();
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
         if(getPhb() == -1)
         {
            return true;
         }
         if(PK_UI.whoNumX.getValue() <= getPhb())
         {
            return true;
         }
         return false;
      }
      
      public function isTaskOk() : void
      {
         if(Boolean(isMapIdOk()) && isMapStarOk() && Boolean(isBettOk()) && Boolean(isEnemyOk()) && Boolean(isGoodsOk()) && Boolean(isPlayerGoldOk()) && Boolean(isPlayerLevelOk()) && Boolean(isTimeOk()) && Boolean(isLjOk()) && Boolean(isTgOk()) && Boolean(yhdOk()) && Boolean(phbOk()))
         {
            setState(2);
            Play_Interface.TiShiShow(true);
         }
      }
      
      public function setEneSave(param1:Array) : void
      {
         _enemyedArr = param1;
      }
   }
}

