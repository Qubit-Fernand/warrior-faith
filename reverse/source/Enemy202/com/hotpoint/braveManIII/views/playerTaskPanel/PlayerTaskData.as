package com.hotpoint.braveManIII.views.playerTaskPanel
{
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.task.*;
   import src.*;
   
   public class PlayerTaskData
   {
      
      private static var bo:Boolean;
      
      public static var taskArrZx:Array = [];
      
      public static var taskArrTs:Array = [];
      
      public static var zxTaskNum:Number = 5;
      
      public static var tsTaskNum:Number = 5;
      
      public function PlayerTaskData()
      {
         super();
      }
      
      public static function getTaskZx() : Array
      {
         taskArrZx = NpcListData.getZxjs();
         return taskArrZx;
      }
      
      public static function getTaskTs() : Array
      {
         taskArrTs = NpcListData.getTsjs();
         return taskArrTs;
      }
      
      public static function allTaskArr() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = getTaskZx();
         var _loc3_:Array = getTaskTs();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_.push(_loc2_[_loc4_]);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_.push(_loc3_[_loc4_]);
            _loc4_++;
         }
         return _loc1_;
      }
      
      public static function isTaskById(param1:Number) : Boolean
      {
         var _loc3_:Task = null;
         var _loc2_:Array = allTaskArr();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getId() == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function clearTask(param1:Number) : void
      {
         var _loc2_:Task = null;
         var _loc3_:uint = 0;
         while(_loc3_ < zxTaskNum)
         {
            _loc2_ = taskArrZx[_loc3_] as Task;
            if(_loc2_ != null)
            {
               if(_loc2_.getId() == param1)
               {
                  taskArrZx.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < tsTaskNum)
         {
            _loc2_ = taskArrTs[_loc3_] as Task;
            if(_loc2_ != null)
            {
               if(_loc2_.getId() == param1)
               {
                  taskArrTs.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
      }
      
      public static function noZxTask() : Boolean
      {
         if(taskArrZx.length < 1)
         {
            return false;
         }
         return true;
      }
      
      public static function noTsTask() : Boolean
      {
         if(taskArrTs.length < 1)
         {
            return false;
         }
         return true;
      }
      
      public static function addEnemyNum(param1:Number) : void
      {
         var _loc3_:Task = null;
         var _loc2_:Array = allTaskArr();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getEnemyId() != null)
            {
               if(_loc3_.isEnemyId(param1))
               {
                  if(_loc3_.getSkillEnemyNum(param1) < _loc3_.getEnemyMaxNum(param1))
                  {
                     _loc3_.addSkillEnemyNum(param1);
                  }
               }
            }
         }
      }
      
      public static function addGoodsNum() : void
      {
         var _loc2_:Task = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc1_:Array = allTaskArr();
         trace("检查收集");
         for each(_loc2_ in _loc1_)
         {
            trace(_loc2_.getGoodsId() + "是否有收集");
            if(_loc2_.getGoodsId() != null)
            {
               _loc3_ = [];
               _loc4_ = [];
               _loc5_ = [];
               if(_loc2_.getWho() == 1)
               {
                  _loc3_ = goodsNum(_loc2_.getGoodsId(),Main.player1.getBag(),_loc2_.getId());
                  _loc2_.setGoodsed(_loc3_);
               }
               else if(_loc2_.getWho() == 2)
               {
                  _loc4_ = goodsNum(_loc2_.getGoodsId(),Main.player2.getBag(),_loc2_.getId());
                  _loc2_.setGoodsed(_loc4_);
               }
               else if(_loc2_.getWho() == 3)
               {
                  _loc3_ = goodsNum(_loc2_.getGoodsId(),Main.player1.getBag(),_loc2_.getId());
                  if(Main.P1P2)
                  {
                     _loc4_ = goodsNum(_loc2_.getGoodsId(),Main.player2.getBag(),_loc2_.getId());
                     _loc6_ = 0;
                     while(_loc6_ < _loc3_.length)
                     {
                        _loc5_.push(_loc3_[_loc6_] + _loc4_[_loc6_]);
                        _loc2_.setGoodsed(_loc5_);
                        _loc6_++;
                     }
                  }
                  else
                  {
                     trace("写入收集:" + _loc3_);
                     _loc2_.setGoodsed(_loc3_);
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
            if(param3 != 210002)
            {
               _loc4_.push(param2.fallQusetBag(param1[_loc5_]));
            }
            else
            {
               _loc4_.push(param2.getOtherobjNum(param1[_loc5_]));
            }
            trace(param1[_loc5_] + ":收集的物品_________");
            _loc5_++;
         }
         trace(_loc4_ + "已经收集的数量");
         return _loc4_;
      }
      
      public static function getAddBag(param1:Number) : Boolean
      {
         var _loc2_:Array = [-1,-1,-1,-1];
         var _loc3_:Array = [-1,-1,-1,-1];
         var _loc4_:Array = TaskFactioy.getGoodsIdAndNan(param1);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(Main.player1.getBag().fallQusetBag(_loc4_[_loc5_][0]) >= _loc4_[_loc5_][1])
            {
               _loc2_[_loc5_] = 1;
            }
            if(Main.P1P2)
            {
               if(Main.player2.getBag().fallQusetBag(_loc4_[_loc5_][0]) >= _loc4_[_loc5_][1])
               {
                  _loc3_[_loc5_] = 1;
               }
            }
            _loc5_++;
         }
         if(Main.P1P2 == false)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(_loc2_[_loc5_] == -1)
               {
                  return false;
               }
               _loc5_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(_loc2_[_loc5_] == -1 || _loc3_[_loc5_] == -1)
               {
                  return false;
               }
               _loc5_++;
            }
         }
         return true;
      }
      
      public static function addMapId(param1:Number) : void
      {
         var _loc3_:Task = null;
         trace("存入的地图ID:" + param1);
         var _loc2_:Array = allTaskArr();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getMapId() != -1)
            {
               if(param1 != 0)
               {
                  _loc3_.setMaped(param1);
               }
            }
         }
      }
      
      public static function addTime(param1:Number) : void
      {
         var _loc3_:Task = null;
         var _loc2_:Array = allTaskArr();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getTimer() != -1)
            {
               if(_loc3_.ismapOk())
               {
                  if(_loc3_.isTgOk())
                  {
                     trace("地图条件满足才存入时间");
                     _loc3_.setTimer(param1);
                  }
                  else
                  {
                     _loc3_.setMaped(0);
                     _loc3_.setTimer(0);
                     trace("没通关,地图设置为不符合,时间为0");
                  }
               }
               else
               {
                  _loc3_.setTimer(0);
                  _loc3_.setTging(false);
               }
            }
         }
      }
      
      public static function addLj(param1:Number) : void
      {
         var _loc3_:Task = null;
         var _loc2_:Array = allTaskArr();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getLianji() != -1)
            {
               if(_loc3_.ismapOk())
               {
                  _loc3_.setLianjied(param1);
               }
               else
               {
                  _loc3_.setLianjied(0);
               }
            }
         }
      }
      
      public static function addBett(param1:Number) : void
      {
         var _loc3_:Task = null;
         var _loc2_:Array = allTaskArr();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.getBett() != -1)
            {
               if(_loc3_.ismapOk())
               {
                  _loc3_.setBetted(param1);
               }
               else
               {
                  _loc3_.setBetted(0);
               }
            }
         }
      }
      
      public static function addGold() : void
      {
         var _loc2_:Task = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         trace("对比金币");
         var _loc1_:Array = allTaskArr();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.getFinishGold() != -1)
            {
               if(_loc2_.getWho() == 1)
               {
                  _loc2_.setFinishGold(Main.player1.getGold());
               }
               else if(_loc2_.getWho() == 2)
               {
                  _loc2_.setFinishGold(Main.player2.getGold());
               }
               else if(_loc2_.getWho() == 3)
               {
                  _loc3_ = Number(Main.player1.getGold());
                  if(Main.P1P2)
                  {
                     _loc4_ = Number(Main.player2.getGold());
                     if(_loc3_ <= _loc4_)
                     {
                        _loc2_.setFinishGold(_loc3_);
                     }
                     else
                     {
                        _loc2_.setFinishGold(_loc4_);
                     }
                     trace("存入",_loc3_,_loc4_);
                  }
                  else
                  {
                     _loc2_.setFinishGold(_loc3_);
                  }
               }
            }
         }
      }
      
      public static function addLevel() : void
      {
         var _loc2_:Task = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:Array = allTaskArr();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.getLevel() != -1)
            {
               if(_loc2_.getWho() == 1)
               {
                  _loc2_.setLeveling(Main.player1.getLevel());
               }
               else if(_loc2_.getWho() == 2)
               {
                  _loc2_.setLeveling(Main.player2.getLevel());
               }
               else if(_loc2_.getWho() == 3)
               {
                  trace("等级需求_共同的任务");
                  _loc3_ = Number(Main.player1.getLevel());
                  if(Main.P1P2)
                  {
                     trace("2玩家");
                     _loc4_ = Number(Main.player2.getLevel());
                     if(_loc3_ <= _loc4_)
                     {
                        _loc2_.setLeveling(_loc3_);
                     }
                     else
                     {
                        _loc2_.setLeveling(_loc4_);
                     }
                  }
                  else
                  {
                     trace("1玩家L1" + _loc3_);
                     _loc2_.setLeveling(_loc3_);
                  }
               }
            }
         }
      }
      
      public static function addTg() : void
      {
         var _loc2_:Task = null;
         if(Main.gameNum.getValue() == 0)
         {
            return;
         }
         var _loc1_:Array = allTaskArr();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.getTg())
            {
               _loc2_.setTging(true);
            }
         }
      }
      
      public static function addTaskData() : void
      {
         addMapId(Main.gameNum.getValue());
         addLevel();
         addGold();
         addGoodsNum();
         addLj(WinShow.txt_2);
         addBett(WinShow.txt_3);
         addTime(WinShow.txt_1);
      }
   }
}

