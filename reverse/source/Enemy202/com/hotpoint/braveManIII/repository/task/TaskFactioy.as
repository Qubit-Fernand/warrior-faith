package com.hotpoint.braveManIII.repository.task
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.task.*;
   
   public class TaskFactioy
   {
      
      public static var ii:uint;
      
      public static var myXml:XML = new XML();
      
      public static var taskArr:Array = [];
      
      public function TaskFactioy()
      {
         super();
      }
      
      public static function creatTaskFactory() : TaskFactioy
      {
         var _loc1_:TaskFactioy = new TaskFactioy();
         _loc1_.creatLoard();
      }
      
      public static function getTaskBayId(param1:Number) : TaskBasicData
      {
         var _loc2_:TaskBasicData = null;
         var _loc3_:TaskBasicData = null;
         for each(_loc3_ in taskArr)
         {
            if(_loc3_.getTaskId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            throw new Error("找不到基础数据!id:" + param1);
         }
         return _loc2_;
      }
      
      public static function getUrl(param1:Number) : String
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getUrl();
      }
      
      public static function getMapId(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         if(_loc2_.getMapId() != -1)
         {
            return _loc2_.getMapId();
         }
         return -1;
      }
      
      public static function getEnemyId(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = _loc2_.getEnemyId();
         var _loc4_:Array = [];
         if(_loc3_.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_.push(_loc3_[_loc5_].getValue());
               _loc5_++;
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getEnemyName(param1:Number) : Array
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = _loc2_.getEnemyName();
         if(_loc3_.length > 0)
         {
            return _loc3_;
         }
         return null;
      }
      
      public static function getEnemyNum(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = _loc2_.getEnemyNum();
         var _loc4_:Array = [];
         if(_loc3_.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_.push(_loc3_[_loc5_].getValue());
               _loc5_++;
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getEenmyIdAndNan(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = getEnemyId(param1);
         var _loc3_:Array = getEnemyNum(param1);
         var _loc4_:Array = [];
         if(_loc2_.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc4_[_loc5_] = [_loc2_[_loc5_],_loc3_[_loc5_]];
               _loc5_++;
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getGoodsId(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = _loc2_.getGoodsId();
         var _loc4_:Array = [];
         if(_loc3_.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_.push(_loc3_[_loc5_].getValue());
               _loc5_++;
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getGoodsNum(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = _loc2_.getGoodsNum();
         var _loc4_:Array = [];
         if(_loc3_.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_.push(_loc3_[_loc5_].getValue());
               _loc5_++;
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getGoodsIdAndNan(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = getGoodsId(param1);
         var _loc3_:Array = getGoodsNum(param1);
         var _loc4_:Array = [];
         if(_loc2_.length > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc4_[_loc5_] = [_loc2_[_loc5_],_loc3_[_loc5_]];
               _loc5_++;
            }
            return _loc4_;
         }
         return null;
      }
      
      public static function getGoodsMaxNum(param1:Number, param2:Number) : Number
      {
         var _loc4_:uint = 0;
         var _loc3_:Array = getGoodsIdAndNan(param1);
         if(_loc3_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_][0] == param2)
               {
                  return _loc3_[_loc4_][1];
               }
               _loc4_++;
            }
         }
         return -1;
      }
      
      public static function getLianjiNum(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         if(_loc2_.getLianjiNum() != -1)
         {
            return _loc2_.getLianjiNum();
         }
         return -1;
      }
      
      public static function getFightNum(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         if(_loc2_.getFightNum() != -1)
         {
            return _loc2_.getFightNum();
         }
         return -1;
      }
      
      public static function getTimeNum(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         if(_loc2_.getTimeNum() != -1)
         {
            return _loc2_.getTimeNum();
         }
         return -1;
      }
      
      public static function getFinishGold(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         if(_loc2_.getFinishGold() != -1)
         {
            return _loc2_.getFinishGold();
         }
         return -1;
      }
      
      public static function getFinishiLevel(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         if(_loc2_.getFinishLevel() != -1)
         {
            return _loc2_.getFinishLevel();
         }
         return -1;
      }
      
      public static function getTg(param1:Number) : Boolean
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getTg();
      }
      
      public static function getTaskBranch(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getBranch();
      }
      
      public static function getTaskName(param1:Number) : String
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getTaskName();
      }
      
      public static function getTaskLevel(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getLevel();
      }
      
      public static function getDelet(param1:Number) : Boolean
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getDeletet();
      }
      
      public static function getTaskIntroduction(param1:Number) : String
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getTaskIntroduction();
      }
      
      public static function getTaskDemand(param1:Number) : String
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getDemand();
      }
      
      public static function getTaskDemandType(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getDemandType();
      }
      
      public static function getWho(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getWho();
      }
      
      public static function isAgin(param1:Number) : Boolean
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.isAgin();
      }
      
      public static function isRc(param1:Number) : Boolean
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.isRc();
      }
      
      public static function getAwardType(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = [];
         var _loc4_:Array = _loc2_.getAwardType();
         if(_loc4_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc3_.push(_loc4_[_loc5_].getValue());
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public static function getAwardId(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = [];
         var _loc4_:Array = _loc2_.getAwardId();
         if(_loc4_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc3_.push(_loc4_[_loc5_].getValue());
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public static function getAwardNum(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         var _loc3_:Array = [];
         var _loc4_:Array = _loc2_.getAwardNum();
         if(_loc4_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc3_.push(_loc4_[_loc5_].getValue());
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public static function getAwardTypeAndId(param1:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = getAwardType(param1);
         var _loc3_:Array = getAwardId(param1);
         var _loc4_:Array = [];
         if(_loc2_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc4_[_loc5_] = [_loc2_[_loc5_],_loc3_[_loc5_]];
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      public static function getGold(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getGold();
      }
      
      public static function getExp(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getExp();
      }
      
      public static function getPlayerDtate(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getPlayerStata();
      }
      
      public static function addBranchTask(param1:Number) : Array
      {
         var _loc3_:TaskBasicData = null;
         var _loc2_:Array = [];
         for each(_loc3_ in taskArr)
         {
            if(_loc3_.getBranch() == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length < 1)
         {
            trace("没有满足主干分支的任务");
         }
         return _loc2_;
      }
      
      public static function addTaskLevel(param1:Array, param2:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc7_:TaskBasicData = null;
         var _loc3_:Array = [];
         var _loc4_:uint = param2;
         if(param2 - 10 >= 1)
         {
            _loc5_ = param2 - 10;
         }
         else
         {
            _loc5_ = 1;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < param1.length)
         {
            _loc7_ = param1[_loc6_] as TaskBasicData;
            if(_loc7_.getLevel() <= _loc4_ && _loc7_.getLevel() >= _loc5_)
            {
               _loc3_.push(_loc7_);
            }
            _loc6_++;
         }
         if(_loc3_.length < 1)
         {
            trace("没有满足角色级别的任务");
         }
         return _loc3_;
      }
      
      public static function addTaskRebirth(param1:Array, param2:Boolean) : Array
      {
         var _loc5_:TaskBasicData = null;
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_] as TaskBasicData;
            if(!_loc5_.getRebirth())
            {
               _loc3_.push(_loc5_);
            }
            else if(param2)
            {
               _loc3_.push(_loc5_);
            }
            _loc4_++;
         }
         if(_loc3_.length < 1)
         {
            trace("没有满足重生的任务");
         }
         return _loc3_;
      }
      
      public static function addBeforeTask(param1:Array, param2:Array) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].getBeforeTaskId() != -1)
            {
               if(!NpcListData.isOldTaskOk(param1[_loc4_].getBeforeTaskId()))
               {
                  _loc3_.push(param1[_loc4_]);
               }
            }
            else if(param1[_loc4_].getBeforeTaskId() == -1)
            {
               _loc3_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         if(_loc3_.length < 1)
         {
            trace("没有前置的任务");
         }
         return _loc3_;
      }
      
      public static function addWhoTask(param1:Array, param2:Array) : Array
      {
         var _loc5_:TaskBasicData = null;
         var _loc6_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_] as TaskBasicData;
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               if(_loc5_.getWho() == 3)
               {
                  _loc3_.push(_loc5_);
                  break;
               }
               if(_loc5_.getWho() == param2[_loc6_])
               {
                  _loc3_.push(_loc5_);
                  break;
               }
               _loc6_++;
            }
            _loc4_++;
         }
         if(_loc3_ == null)
         {
            trace("没角色符合");
         }
         return _loc3_;
      }
      
      public static function addPickTask(param1:Array, param2:Array) : Array
      {
         var _loc5_:TaskBasicData = null;
         var _loc6_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_] as TaskBasicData;
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               if(_loc5_.getPickSkill() == param2[_loc6_])
               {
                  _loc3_.push(_loc5_);
               }
               _loc6_++;
            }
            _loc4_++;
         }
         if(_loc3_.length < 1)
         {
            trace("没有满足选择武器的任务");
         }
         return _loc3_;
      }
      
      public static function addZxTask(param1:Number, param2:Boolean, param3:Array) : Array
      {
         trace(param1 + "分支");
         var _loc4_:Array = addBranchTask(param1);
         var _loc5_:Array = addTaskRebirth(_loc4_,param2);
         return addBeforeTask(_loc5_,param3);
      }
      
      public static function addTansferTask(param1:Number, param2:Array, param3:Array) : Array
      {
         var _loc4_:Array = addBranchTask(param1);
         var _loc5_:Array = addWhoTask(_loc4_,param2);
         trace(_loc5_ + ":whoArrwhoArrwhoArrwhoArrwhoArr");
         var _loc6_:Array = addBeforeTask(_loc5_,param3);
         trace("可以接的特殊任务" + _loc6_);
         return _loc6_;
      }
      
      public static function addOther(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = addBranchTask(param1);
         return _loc3_;
      }
      
      public static function addXhTask(param1:Number, param2:Boolean, param3:Array) : Array
      {
         trace(param1 + "循环");
         var _loc4_:Array = addBranchTask(param1);
         var _loc5_:Array = addTaskRebirth(_loc4_,param2);
         return addBeforeTask(_loc5_,param3);
      }
      
      public static function creantTaskArr(param1:Array) : Array
      {
         var _loc3_:uint = 0;
         var _loc4_:TaskBasicData = null;
         var _loc2_:Array = [];
         if(param1 != "")
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_ = param1[_loc3_];
               _loc2_.push(_loc4_.creatTask());
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function creatLoard() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc13_:XMLList = null;
         var _loc14_:XMLList = null;
         var _loc15_:XMLList = null;
         var _loc16_:XMLList = null;
         var _loc17_:XMLList = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Boolean = false;
         var _loc24_:Number = NaN;
         var _loc25_:Boolean = false;
         var _loc26_:XMLList = null;
         var _loc27_:XMLList = null;
         var _loc28_:XMLList = null;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:String = null;
         var _loc33_:Array = null;
         var _loc34_:Array = null;
         var _loc35_:Array = null;
         var _loc36_:Array = null;
         var _loc37_:Array = null;
         var _loc38_:Array = null;
         var _loc39_:Array = null;
         var _loc40_:Array = null;
         var _loc41_:TaskBasicData = null;
         for each(_loc1_ in myXml.任务)
         {
            _loc2_ = Number(_loc1_.任务ID);
            _loc3_ = String(_loc1_.任务名称);
            _loc4_ = Number(_loc1_.任务级数);
            _loc5_ = (_loc1_.是否消失.toString() == "true") as Boolean;
            _loc6_ = Number(_loc1_.任务分支);
            _loc7_ = String(_loc1_.任务介绍);
            _loc8_ = String(_loc1_.任务需求);
            _loc9_ = Number(_loc1_.指定玩家);
            _loc10_ = (_loc1_.是否重生.toString() == "true") as Boolean;
            _loc11_ = (_loc1_.是否日常.toString() == "true") as Boolean;
            _loc12_ = Number(_loc1_.完成条件.地图ID);
            _loc13_ = _loc1_.完成条件.杀怪.怪物ID;
            _loc14_ = _loc1_.完成条件.杀怪.怪物名字;
            _loc15_ = _loc1_.完成条件.杀怪.怪物数量;
            _loc16_ = _loc1_.完成条件.搜集物品.物品ID;
            _loc17_ = _loc1_.完成条件.搜集物品.物品数量;
            _loc18_ = Number(_loc1_.完成条件.连击数);
            _loc19_ = Number(_loc1_.完成条件.被击打数);
            _loc20_ = Number(_loc1_.完成条件.时间);
            _loc21_ = Number(_loc1_.完成条件.完成金币);
            _loc22_ = Number(_loc1_.完成条件.完成等级);
            _loc23_ = (_loc1_.完成条件.通关.toString() == "true") as Boolean;
            _loc24_ = Number(_loc1_.出现任务条件.前置任务ID);
            _loc25_ = (_loc1_.出现任务条件.重生.toString() == "true") as Boolean;
            _loc26_ = _loc1_.奖励.奖励物品.奖励类型;
            _loc27_ = _loc1_.奖励.奖励物品.奖励id;
            _loc28_ = _loc1_.奖励.奖励物品.奖励数量;
            _loc29_ = Number(_loc1_.奖励.金币);
            _loc30_ = Number(_loc1_.奖励.经验);
            _loc31_ = Number(_loc1_.奖励.奖励状态);
            _loc32_ = String(_loc1_.论坛链接);
            _loc33_ = [];
            _loc34_ = [];
            _loc35_ = [];
            _loc36_ = [];
            _loc37_ = [];
            _loc38_ = [];
            _loc39_ = [];
            _loc40_ = [];
            for each(_loc1_ in _loc26_)
            {
               if(_loc1_ != -1)
               {
                  _loc38_.push(VT.createVT(_loc1_));
               }
            }
            for each(_loc1_ in _loc27_)
            {
               if(_loc1_ != -1)
               {
                  _loc39_.push(VT.createVT(_loc1_));
               }
            }
            for each(_loc1_ in _loc28_)
            {
               if(_loc1_ != -1)
               {
                  _loc40_.push(VT.createVT(_loc1_));
               }
            }
            for each(_loc1_ in _loc13_)
            {
               if(_loc1_ != -1)
               {
                  _loc33_.push(VT.createVT(_loc1_));
               }
            }
            for each(_loc1_ in _loc14_)
            {
               if(_loc1_ != -1)
               {
                  _loc35_.push(_loc1_);
               }
            }
            for each(_loc1_ in _loc15_)
            {
               if(_loc1_ != -1)
               {
                  _loc34_.push(VT.createVT(_loc1_));
               }
            }
            for each(_loc1_ in _loc16_)
            {
               if(_loc1_ != -1)
               {
                  _loc36_.push(VT.createVT(_loc1_));
               }
            }
            for each(_loc1_ in _loc17_)
            {
               if(_loc1_ != -1)
               {
                  _loc37_.push(VT.createVT(_loc1_));
               }
            }
            _loc41_ = TaskBasicData.creatTaskBasicData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc33_,_loc35_,_loc34_,_loc36_,_loc37_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_,_loc24_,_loc25_,_loc38_,_loc39_,_loc40_,_loc29_,_loc30_,_loc31_,_loc32_);
            taskArr.push(_loc41_);
         }
      }
      
      public function getBeforeTaskId(param1:Number) : Number
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getBeforeTaskId();
      }
      
      public function getTaskRebirth(param1:Number) : Boolean
      {
         var _loc2_:TaskBasicData = getTaskBayId(param1);
         return _loc2_.getRebirth();
      }
   }
}

