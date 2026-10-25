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
         var arr:Array = this.getEnemyId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            this._enemyedArr[i] = 0;
         }
      }
      
      private function initGooded() : void
      {
         var arr:Array = this.getGoodsId();
         for(var i:uint = 0; i < arr.length; i++)
         {
            this._sjArr[i] = 0;
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
      
      public function setState(num:Number) : void
      {
         trace("设置了任务状态:________________________________________",num);
         this._state.setValue(num);
      }
      
      public function getOldTime() : Number
      {
         return this._isOld.getValue();
      }
      
      public function setOldTime(num:Number) : void
      {
         this._isOld.setValue(num);
      }
      
      public function setOverTime(num:Number) : void
      {
         this._overTimer.setValue(num);
      }
      
      public function getOverTime() : Number
      {
         return this._overTimer.getValue();
      }
      
      public function setMapId(num:Number) : void
      {
         if(this.getMapId() != -1)
         {
            this._mapId.setValue(num);
         }
      }
      
      public function setMapStar(num:Number) : void
      {
         if(this.getMapStar() != -1)
         {
            this._mapStar.setValue(num);
         }
      }
      
      public function setTg() : void
      {
         this._tg = true;
      }
      
      public function setEnemyNum(eId:Number) : void
      {
         var i:uint = 0;
         var eIdArr:Array = this.getEnemyId();
         var eNum:Array = this.getEnemyNum();
         if(this.isMapStarOk())
         {
            for(i = 0; i < eIdArr.length; i++)
            {
               if(eIdArr[i].getValue() == eId)
               {
                  if(this._enemyedArr[i] < eNum[i].getValue())
                  {
                     ++this._enemyedArr[i];
                     break;
                  }
               }
            }
         }
      }
      
      public function setGoodsed(arr:Array) : void
      {
         this._sjArr = arr;
      }
      
      public function setGoods(id:Number) : void
      {
         var gId:Array = this.getGoodsId();
         var gNum:Array = this.getGoodsNum();
         for(var i:uint = 0; i < gId.length; i++)
         {
            if(gId[i].getValue() == id && this._sjArr[i] < gNum[i].getValue())
            {
               ++this._sjArr[i];
               break;
            }
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
         var bo:Boolean = false;
         var i:uint = 0;
         var arr:Array = this.getEnemyId();
         var eNum:Array = this.getEnemyNum();
         if(arr[0].getValue() == -1)
         {
            return true;
         }
         bo = true;
         for(i = 0; i < arr.length; i++)
         {
            if(this._enemyedArr[i] < eNum[i].getValue())
            {
               bo = false;
            }
         }
         if(!bo)
         {
            trace("杀怪数量没满足");
         }
         return bo;
      }
      
      private function isGoodsOk() : Boolean
      {
         var bo:Boolean = false;
         var i:uint = 0;
         var arr:Array = this.getGoodsId();
         var gNum:Array = this.getGoodsNum();
         if(arr[0].getValue() == -1)
         {
            return true;
         }
         bo = true;
         for(i = 0; i < arr.length; i++)
         {
            if(this._sjArr[i] < gNum[i].getValue())
            {
               bo = false;
            }
         }
         if(!bo)
         {
            trace("收集数量没满足");
         }
         return bo;
      }
      
      private function yhdOk() : Boolean
      {
         var yhd:Number = this.getYhd();
         var npc:Number = this.getNpc();
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
      }
      
      public function setEneSave(arr:Array) : void
      {
         this._enemyedArr = arr;
      }
   }
}

