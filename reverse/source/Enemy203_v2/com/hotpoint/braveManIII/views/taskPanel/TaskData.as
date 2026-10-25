package com.hotpoint.braveManIII.views.taskPanel
{
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.task.Task;
   import com.hotpoint.braveManIII.repository.task.*;
   import src.*;
   import src.tool.*;
   
   public class TaskData
   {
      
      public static var taskArr:Array = [];
      
      private static var playerIngTask:Array = [];
      
      private static var taskingArr:Array = [];
      
      private static var taskedArr:Array = [];
      
      private static var zxArr:Array = [];
      
      private static var xhArr:Array = [];
      
      private static var mrArr:Array = [];
      
      private static var jrArr:Array = [];
      
      private static var wtArr:Array = [];
      
      private static var oldArr:Array = [0,0,0,0,0,0];
      
      private static var currArr:Array = [0,0,0,0,0,0];
      
      public static var nowArr:Array = [0,0,0,0,0,0];
      
      public static var tsTaskArr:Array = [420008,420009,420010,420011,420012,420013,420014,420015,420016,420017,420018,420019,420020,420021,420022,420023,420024,420025,420026,420027,420028,420029,420030,420031,420032,420033,420034,420035,420036,420037,420038,420026,420027,110097];
      
      public static var saveArr:Array = [];
      
      public function TaskData()
      {
         super();
      }
      
      public static function isTsTask(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < tsTaskArr.length)
         {
            if(param1 == tsTaskArr[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public static function initAllTask() : void
      {
         if(taskArr.length == 0)
         {
            taskArr = TaskFactory.allTask;
            duTask();
            yjPlayer();
         }
      }
      
      private static function yjPlayer() : void
      {
         taskingArr = taskIngFun();
         taskedArr = taskedFun();
         playerIngTask = statePlayer();
      }
      
      public static function otherUpdataTask() : void
      {
         var _loc1_:Task = null;
         for each(_loc1_ in taskArr)
         {
            if(_loc1_.getSmallType() == 2)
            {
               _loc1_.initData();
               clearGoods(_loc1_,1);
            }
         }
      }
      
      public static function updateEd() : void
      {
         var _loc1_:Task = null;
         for each(_loc1_ in taskArr)
         {
            if(_loc1_.getSmallType() == 2)
            {
               if(_loc1_.getState() == 3 && Main.serverTime.getValue() > _loc1_.getOverTime())
               {
                  otherUpdataTask();
                  break;
               }
            }
         }
      }
      
      public static function duTask() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Task = null;
         var _loc4_:Number = NaN;
         if(saveArr.length != 0)
         {
            _loc1_ = 1;
            while(_loc1_ < saveArr.length)
            {
               if(saveArr[_loc1_] != null)
               {
                  _loc2_ = 0;
                  while(_loc2_ < taskArr.length)
                  {
                     _loc3_ = taskArr[_loc2_];
                     _loc4_ = _loc3_.getId();
                     if(_loc3_.getSmallType() != 1)
                     {
                        if(_loc1_ == _loc4_)
                        {
                           if(_loc3_.getSmallType() == 0)
                           {
                              if(saveArr[_loc4_][0] == 2)
                              {
                                 _loc3_.setState(0);
                              }
                              else
                              {
                                 _loc3_.setState(saveArr[_loc4_][0]);
                              }
                              _loc3_.setOldTime(saveArr[_loc4_][1]);
                              _loc3_.setGoodsed(saveArr[_loc4_][2]);
                              _loc3_.setEneSave(saveArr[_loc4_][3]);
                              _loc3_.setOverTime(saveArr[_loc4_][4]);
                           }
                           else
                           {
                              _loc3_.setState(saveArr[_loc4_][0]);
                              _loc3_.setOldTime(saveArr[_loc4_][1]);
                              _loc3_.setGoodsed(saveArr[_loc4_][2]);
                              _loc3_.setEneSave(saveArr[_loc4_][3]);
                              _loc3_.setOverTime(saveArr[_loc4_][4]);
                           }
                        }
                     }
                     _loc2_++;
                  }
               }
               _loc1_++;
            }
         }
      }
      
      public static function duxx() : void
      {
         var _loc2_:Task = null;
         var _loc1_:uint = 0;
         while(_loc1_ < taskArr.length)
         {
            _loc2_ = taskArr[_loc1_];
            _loc1_++;
         }
      }
      
      public static function saveTask() : Array
      {
         var _loc1_:Task = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         for each(_loc1_ in taskArr)
         {
            _loc2_ = _loc1_.getId();
            _loc3_ = _loc1_.getSmallType();
            if(!saveArr[_loc2_])
            {
               saveArr[_loc2_] = [];
            }
            if(_loc3_ != 1)
            {
               saveArr[_loc2_] = [_loc1_.getState(),_loc1_.getOldTime(),_loc1_.getGoodsedNum(),_loc1_.getEenemyedNum(),_loc1_.getOverTime()];
            }
         }
         return saveArr;
      }
      
      public static function initTaskInState() : void
      {
         yjPlayer();
         var _loc1_:Array = qzOk(reOk(levelOk(stateNpc())));
         mrArr = getSmallType(getBigType(_loc1_,0),2);
         zxArr = getSmallType(getBigType(_loc1_,0),0);
         xhArr = getSmallType(getBigType(_loc1_,0),1);
         jrArr = getBigType(_loc1_,2);
         wtArr = getBigType(_loc1_,1);
         if(taskedArr != null)
         {
            currArr[0] = taskedArr.length;
         }
         else
         {
            currArr[0] = 0;
         }
         if(mrArr != null)
         {
            currArr[1] = mrArr.length;
         }
         else
         {
            currArr[1] = 0;
         }
         if(zxArr != null)
         {
            currArr[2] = zxArr.length;
         }
         else
         {
            currArr[2] = 0;
         }
         if(xhArr != null)
         {
            currArr[3] = xhArr.length;
         }
         else
         {
            currArr[3] = 0;
         }
         if(jrArr != null)
         {
            currArr[4] = jrArr.length;
         }
         else
         {
            currArr[4] = 0;
         }
         if(wtArr != null)
         {
            currArr[5] = wtArr.length;
         }
         else
         {
            currArr[5] = 0;
         }
      }
      
      public static function initNewText() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            nowArr[_loc1_] = currArr[_loc1_] - oldArr[_loc1_];
            _loc1_++;
         }
      }
      
      public static function setOldArr(param1:Number) : void
      {
         oldArr[param1] = currArr[param1];
      }
      
      public static function clearOldTaskNum(param1:Task) : void
      {
         if(param1.getBigType() == 0)
         {
            if(param1.getSmallType() == 0)
            {
               if(oldArr[2] > 0)
               {
                  --oldArr[2];
               }
            }
            else if(param1.getSmallType() == 1)
            {
               if(oldArr[3] > 0)
               {
                  --oldArr[3];
               }
            }
            else if(param1.getSmallType() == 2)
            {
               if(oldArr[1] > 0)
               {
                  --oldArr[1];
               }
            }
         }
         else if(param1.getBigType() == 1)
         {
            if(oldArr[5] > 0)
            {
               --oldArr[5];
            }
         }
         else if(param1.getBigType() == 2)
         {
            if(oldArr[4] > 0)
            {
               --oldArr[4];
            }
         }
      }
      
      public static function playerLevelFun() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:Number = 0;
         if(!Main.P1P2)
         {
            _loc1_ = Number(Main.player1.getLevel());
         }
         else
         {
            _loc2_ = Number(Main.player1.getLevel());
            _loc3_ = Number(Main.player2.getLevel());
            _loc1_ = _loc2_;
            if(_loc3_ < _loc2_)
            {
               _loc1_ = _loc3_;
            }
         }
         return _loc1_;
      }
      
      public static function playerRebirth() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!Main.P1P2)
         {
            _loc1_ = Boolean(Main.player1.isRebirth());
         }
         else
         {
            _loc2_ = Main.player1.isRebirth();
            _loc3_ = Main.player2.isRebirth();
            if(Boolean(_loc2_) && Boolean(_loc3_))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public static function statePlayer() : Array
      {
         var _loc2_:Task = null;
         var _loc1_:Array = [];
         if(taskingArr != null)
         {
            for each(_loc2_ in taskingArr)
            {
               _loc1_.push(_loc2_);
            }
         }
         if(taskedArr != null)
         {
            for each(_loc2_ in taskedArr)
            {
               _loc1_.unshift(_loc2_);
            }
         }
         if(_loc1_.length == 0)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function taskIngFun() : Array
      {
         var _loc2_:Task = null;
         if(taskArr.length == 0)
         {
            return null;
         }
         var _loc1_:Array = [];
         for each(_loc2_ in taskArr)
         {
            if(_loc2_.getState() == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length == 0)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function taskedFun() : Array
      {
         var _loc2_:Task = null;
         if(taskArr.length == 0)
         {
            return null;
         }
         var _loc1_:Array = [];
         for each(_loc2_ in taskArr)
         {
            if(_loc2_.getState() == 2)
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length == 0)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function stateNpc() : Array
      {
         var _loc2_:Task = null;
         if(taskArr.length == 0)
         {
            return null;
         }
         var _loc1_:Array = [];
         for each(_loc2_ in taskArr)
         {
            if(_loc2_.getSmallType() == 0)
            {
               if(_loc2_.getState() == 0 && _loc2_.getOldTime() == 0)
               {
                  _loc1_.push(_loc2_);
               }
            }
            else if(_loc2_.getState() == 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         if(_loc1_.length == 0)
         {
            return null;
         }
         return _loc1_;
      }
      
      public static function levelOk(param1:Array) : Array
      {
         var _loc4_:Task = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Array = [];
         var _loc3_:Number = playerLevelFun();
         for each(_loc4_ in param1)
         {
            if(_loc4_.getLevel() <= _loc3_)
            {
               _loc2_.push(_loc4_);
            }
         }
         if(_loc2_.length == 0)
         {
            return null;
         }
         return _loc2_;
      }
      
      public static function reOk(param1:Array) : Array
      {
         var _loc4_:Task = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Array = [];
         var _loc3_:Boolean = playerRebirth();
         for each(_loc4_ in param1)
         {
            if(_loc4_.getRebirth())
            {
               if(_loc3_)
               {
                  _loc2_.push(_loc4_);
               }
            }
            else
            {
               _loc2_.push(_loc4_);
            }
         }
         if(_loc2_.length == 0)
         {
            return null;
         }
         return _loc2_;
      }
      
      public static function qzOk(param1:Array) : Array
      {
         var _loc3_:Task = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc3_.getBeforeTaskId() != -1)
            {
               if(isOldById(_loc3_.getBeforeTaskId()))
               {
                  _loc2_.push(_loc3_);
               }
            }
            else
            {
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length == 0)
         {
            return null;
         }
         return _loc2_;
      }
      
      public static function isOldById(param1:Number) : Boolean
      {
         var _loc2_:Task = null;
         for each(_loc2_ in taskArr)
         {
            if(_loc2_.getId() == param1)
            {
               if(_loc2_.getOldTime() > 0)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function getBigType(param1:Array, param2:Number) : Array
      {
         var _loc4_:Task = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            if(_loc4_.getBigType() == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         if(_loc3_.length == 0)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function getSmallType(param1:Array, param2:Number) : Array
      {
         var _loc4_:Task = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Array = [];
         for each(_loc4_ in param1)
         {
            if(_loc4_.getSmallType() == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         if(_loc3_.length == 0)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function getArr(param1:Array, param2:Number) : Array
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(param1.length >= param2)
            {
               _loc3_.push(param1.splice(0,param2));
            }
            else if(param1.length > 0)
            {
               _loc3_.push(param1.splice(0));
               break;
            }
            _loc4_ = --_loc4_ + 1;
         }
         return _loc3_;
      }
      
      public static function getTypeByBtn(param1:Number = 0) : Array
      {
         var _loc2_:Array = [];
         initTaskInState();
         if(param1 == 0)
         {
            _loc2_ = playerIngTask;
         }
         else if(param1 == 1)
         {
            _loc2_ = mrArr;
         }
         else if(param1 == 2)
         {
            _loc2_ = zxArr;
         }
         else if(param1 == 3)
         {
            _loc2_ = xhArr;
         }
         else if(param1 == 4)
         {
            _loc2_ = jrArr;
         }
         else if(param1 == 5)
         {
            _loc2_ = wtArr;
         }
         return getArr(_loc2_,15);
      }
      
      public static function isOk() : void
      {
         var _loc1_:Task = null;
         if(taskingArr != null)
         {
            for each(_loc1_ in taskingArr)
            {
               if(_loc1_.getState() != 2)
               {
                  _loc1_.isTaskOk();
               }
            }
         }
      }
      
      public static function isOkTow() : void
      {
         var _loc1_:Task = null;
         if(taskedArr != null)
         {
            for each(_loc1_ in taskedArr)
            {
               if(_loc1_.getState() == 2 && isTsTask(_loc1_.getId()))
               {
                  _loc1_.isTaskOk();
               }
            }
         }
      }
      
      public static function initGk() : void
      {
         if(Main.gameNum.getValue() != 0)
         {
            if(Main.gameNum2.getValue() == 1)
            {
               if(taskingArr != null)
               {
                  setMapAndStar(Main.gameNum.getValue(),GameData.gameLV);
                  initAcData();
                  isOk();
               }
            }
         }
      }
      
      private static function initAcData() : void
      {
         var _loc1_:Task = null;
         for each(_loc1_ in taskingArr)
         {
            _loc1_.intGk();
         }
      }
      
      private static function setMapAndStar(param1:Number, param2:Number) : void
      {
         var _loc3_:Task = null;
         for each(_loc3_ in taskingArr)
         {
            _loc3_.setMapId(param1);
            _loc3_.setMapStar(param2);
         }
      }
      
      public static function setTg() : void
      {
         var _loc1_:Task = null;
         if(taskingArr != null)
         {
            for each(_loc1_ in taskingArr)
            {
               _loc1_.setTg();
            }
         }
      }
      
      public static function setEnemyNum(param1:Number) : void
      {
         var _loc2_:Task = null;
         if(taskingArr != null)
         {
            for each(_loc2_ in taskingArr)
            {
               _loc2_.setEnemyNum(param1);
            }
         }
      }
      
      public static function addGoods(param1:Number) : void
      {
         var _loc2_:Task = null;
         if(taskingArr != null)
         {
            for each(_loc2_ in taskingArr)
            {
               if(_loc2_.getGoodsId()[0].getValue() != -1)
               {
                  _loc2_.setGoods(param1);
               }
            }
         }
      }
      
      public static function addGoodsNum() : void
      {
         var _loc1_:Task = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         if(taskingArr != null)
         {
            for each(_loc1_ in taskingArr)
            {
               if((_loc1_.getId() == 210002 || isTsTask(_loc1_.getId())) && _loc1_.getGoodsId()[0].getValue() != -1)
               {
                  _loc2_ = [];
                  _loc3_ = [];
                  _loc4_ = [];
                  _loc2_ = goodsNum(_loc1_.getGoodsId(),Main.player1.getBag(),_loc1_.getId());
                  if(Main.P1P2)
                  {
                     _loc3_ = goodsNum(_loc1_.getGoodsId(),Main.player2.getBag(),_loc1_.getId());
                     _loc5_ = 0;
                     while(_loc5_ < _loc2_.length)
                     {
                        _loc4_.push(_loc2_[_loc5_] + _loc3_[_loc5_]);
                        _loc1_.setGoodsed(_loc4_);
                        _loc5_++;
                     }
                  }
                  else
                  {
                     _loc1_.setGoodsed(_loc2_);
                  }
               }
            }
         }
      }
      
      public static function addGoodsNumTow() : void
      {
         var _loc1_:Task = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         if(taskedArr != null)
         {
            for each(_loc1_ in taskedArr)
            {
               if((_loc1_.getId() == 210002 || isTsTask(_loc1_.getId())) && _loc1_.getGoodsId()[0].getValue() != -1)
               {
                  _loc2_ = [];
                  _loc3_ = [];
                  _loc4_ = [];
                  _loc2_ = goodsNum(_loc1_.getGoodsId(),Main.player1.getBag(),_loc1_.getId());
                  if(Main.P1P2)
                  {
                     _loc3_ = goodsNum(_loc1_.getGoodsId(),Main.player2.getBag(),_loc1_.getId());
                     _loc5_ = 0;
                     while(_loc5_ < _loc2_.length)
                     {
                        _loc4_.push(_loc2_[_loc5_] + _loc3_[_loc5_]);
                        _loc1_.setGoodsed(_loc4_);
                        _loc5_++;
                     }
                  }
                  else
                  {
                     _loc1_.setGoodsed(_loc2_);
                  }
               }
            }
         }
      }
      
      public static function goodsNum(param1:Array, param2:Bag, param3:Number) : Array
      {
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            if(param3 != 210002 && isTsTask(param3) == false)
            {
               _loc4_.push(param2.fallQusetBag(param1[_loc5_].getValue()));
            }
            else
            {
               _loc4_.push(param2.getOtherobjNum(param1[_loc5_].getValue()));
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getAddBag(param1:Number) : Boolean
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Task = isTaskById(param1);
         var _loc5_:Array = _loc4_.getGoodsId();
         var _loc6_:Array = _loc4_.getGoodsNum();
         var _loc7_:uint = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc2_[_loc7_] = -1;
            _loc3_[_loc7_] = -1;
            if(Main.player1.getBag().fallQusetBag(_loc5_[_loc7_].getValue()) >= _loc6_[_loc7_].getValue())
            {
               _loc2_[_loc7_] = 1;
            }
            if(Main.P1P2)
            {
               if(Main.player2.getBag().fallQusetBag(_loc5_[_loc7_].getValue()) >= _loc6_[_loc7_].getValue())
               {
                  _loc3_[_loc7_] = 1;
               }
            }
            _loc7_++;
         }
         if(!Main.P1P2)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if(_loc2_[_loc7_] == -1)
               {
                  return false;
               }
               _loc7_++;
            }
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if(_loc2_[_loc7_] == -1 || _loc3_[_loc7_] == -1)
               {
                  return false;
               }
               _loc7_++;
            }
         }
         return true;
      }
      
      public static function isTaskById(param1:Number) : Task
      {
         var _loc2_:Task = null;
         if(taskingArr == null)
         {
            return null;
         }
         for each(_loc2_ in taskingArr)
         {
            if(param1 == _loc2_.getId())
            {
               if(_loc2_.isMapStarOk())
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public static function clearGold(param1:Task) : void
      {
         if(param1.getFinishGold() != -1)
         {
            Main.player1.payGold(param1.getFinishGold());
            if(Main.P1P2)
            {
               Main.player2.payGold(param1.getFinishGold());
            }
         }
      }
      
      public static function clearGoods(param1:Task, param2:Number = 0) : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         if(param1.getGoodsId()[0].getValue() != -1)
         {
            _loc3_ = param1.getGoodsId();
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = Number(param1.getGoodsNum()[_loc4_].getValue());
               clearP1orP2(_loc3_[_loc4_].getValue(),param1.getId(),param2,_loc5_);
               _loc4_++;
            }
         }
      }
      
      public static function clearP1orP2(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
      {
         if(param2 != 210002 && isTsTask(param2) == false)
         {
            Main.player1.getBag().clearQuest(param1);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearQuest(param1);
            }
         }
         else if(param2 == 210002)
         {
            if(param3 == 0)
            {
               Main.player1.getBag().clearOther(param1);
               if(Main.P1P2)
               {
                  Main.player2.getBag().clearOther(param1);
               }
            }
         }
         else if(param3 == 0)
         {
            trace("扣除特殊___",param4);
            Main.player1.getBag().delOtherById(param1,param4);
            if(Main.P1P2)
            {
               Main.player2.getBag().delOtherById(param1,param4);
            }
         }
      }
      
      public static function getZxInOld() : Number
      {
         var _loc2_:Task = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in taskArr)
         {
            if(_loc2_.getSmallType() == 0 && _loc2_.getOldTime() > 0)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public static function isEnemyTaskOk() : void
      {
         var _loc1_:Task = null;
         if(taskingArr != null)
         {
            for each(_loc1_ in taskingArr)
            {
               if(_loc1_.getState() != 2 && _loc1_.getEnemyId()[0].getValue() != -1)
               {
                  _loc1_.isTaskOk();
               }
            }
         }
      }
      
      public static function setOk(param1:Number) : void
      {
         var _loc2_:Task = null;
         if(taskingArr != null)
         {
            for each(_loc2_ in taskingArr)
            {
               if(param1 == _loc2_.getId())
               {
                  _loc2_.setState(2);
               }
            }
         }
      }
   }
}

