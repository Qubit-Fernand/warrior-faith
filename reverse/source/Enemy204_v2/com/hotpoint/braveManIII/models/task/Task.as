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
      
      public static function creatTask(id:Number) : Task
      {
         var task:Task = new Task();
         task._id = VT.createVT(id);
         task.initData();
         return task;
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
         var arr:Array = getEnemyId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            _enemyedArr[i] = 0;
         }
      }
      
      private function initGooded() : void
      {
         var arr:Array = getGoodsId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            _sjArr[i] = 0;
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
      
      public function setState(num:Number) : void
      {
         _state.setValue(num);
      }
      
      public function getOldTime() : Number
      {
         return _isOld.getValue();
      }
      
      public function setOldTime(num:Number) : void
      {
         _isOld.setValue(num);
      }
      
      public function setOverTime(num:Number) : void
      {
         _overTimer.setValue(num);
      }
      
      public function getOverTime() : Number
      {
         return _overTimer.getValue();
      }
      
      public function setMapId(num:Number) : void
      {
         if(getMapId() != -1)
         {
            _mapId.setValue(num);
         }
      }
      
      public function setMapStar(num:Number) : void
      {
         if(getMapStar() != -1)
         {
            _mapStar.setValue(num);
         }
      }
      
      public function setTg() : void
      {
         _tg = true;
      }
      
      public function setEnemyNum(eId:Number) : void
      {
         var i:uint = 0;
         var eIdArr:Array = getEnemyId();
         var eNum:Array = getEnemyNum();
         if(isMapStarOk())
         {
            for(i = 0; i < eIdArr.length; i++)
            {
               if(eIdArr[i].getValue() == eId)
               {
                  if(_enemyedArr[i] < eNum[i].getValue())
                  {
                     ++_enemyedArr[i];
                     break;
                  }
               }
            }
         }
      }
      
      public function setGoodsed(arr:Array) : void
      {
         _sjArr = arr;
      }
      
      public function setGoods(id:Number) : void
      {
         var gId:Array = getGoodsId();
         var gNum:Array = getGoodsNum();
         for(var i:uint = 0; i < gId.length; i++)
         {
            if(gId[i].getValue() == id && _sjArr[i] < gNum[i].getValue())
            {
               ++_sjArr[i];
               break;
            }
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
         return false;
      }
      
      private function isLjOk() : Boolean
      {
         if(getLianjiNum() == -1)
         {
            return true;
         }
         if(WinShow.txt_2 >= getLianjiNum())
         {
            return true;
         }
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
         return false;
      }
      
      private function isEnemyOk() : Boolean
      {
         var bo:Boolean = false;
         var i:uint = 0;
         var arr:Array = getEnemyId();
         var eNum:Array = getEnemyNum();
         if(arr[0].getValue() == -1)
         {
            return true;
         }
         bo = true;
         for(i = 0; i < arr.length; i++)
         {
            if(_enemyedArr[i] < eNum[i].getValue())
            {
               bo = false;
            }
         }
         if(bo)
         {
         }
         return bo;
      }
      
      private function isGoodsOk() : Boolean
      {
         var bo:Boolean = false;
         var i:uint = 0;
         var arr:Array = getGoodsId();
         var gNum:Array = getGoodsNum();
         if(arr[0].getValue() == -1)
         {
            return true;
         }
         bo = true;
         for(i = 0; i < arr.length; i++)
         {
            if(_sjArr[i] < gNum[i].getValue())
            {
               bo = false;
            }
         }
         if(bo)
         {
         }
         return bo;
      }
      
      private function yhdOk() : Boolean
      {
         var yhd:Number = getYhd();
         var npc:Number = getNpc();
         if(yhd == -1)
         {
            return true;
         }
         if(InitData.qinMiDu_Arr[npc].getValue() >= yhd)
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
      
      public function setEneSave(arr:Array) : void
      {
         _enemyedArr = arr;
      }
   }
}

