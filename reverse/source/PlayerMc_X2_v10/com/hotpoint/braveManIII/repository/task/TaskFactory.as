package com.hotpoint.braveManIII.repository.task
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class TaskFactory
   {
      
      public static var allData:Array = [];
      
      public static var allTask:Array = [];
      
      public function TaskFactory()
      {
         super();
      }
      
      public static function creatTaskFactory() : *
      {
         var _loc1_:TaskFactory = new TaskFactory();
         myXml = XMLAsset.createXML(Data2.taskData);
         _loc1_.creatTaskXml();
      }
      
      private static function getDataById(param1:Number) : TaskBasicData
      {
         var _loc2_:TaskBasicData = null;
         for each(_loc2_ in allData)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_;
            }
         }
         trace("没有此ID的任务数据");
         return null;
      }
      
      public static function getName(param1:Number) : String
      {
         return getDataById(param1).getName();
      }
      
      public static function getLevel(param1:Number) : Number
      {
         return getDataById(param1).getLevel();
      }
      
      public static function getTaskIntroduction(param1:Number) : String
      {
         return getDataById(param1).getTaskIntroduction();
      }
      
      public static function getDemand(param1:Number) : String
      {
         return getDataById(param1).getDemand();
      }
      
      public static function getBigType(param1:Number) : Number
      {
         return getDataById(param1).getBigType();
      }
      
      public static function getSmallType(param1:Number) : Number
      {
         return getDataById(param1).getSmallType();
      }
      
      public static function getWtr(param1:Number) : String
      {
         return getDataById(param1).getWtr();
      }
      
      public static function getBeforeTaskId(param1:Number) : Number
      {
         return getDataById(param1).getBeforeTaskId();
      }
      
      public static function getRebirth(param1:Number) : Boolean
      {
         return getDataById(param1).getRebirth();
      }
      
      public static function getMapId(param1:Number) : Number
      {
         return getDataById(param1).getMapId();
      }
      
      public static function getMapStar(param1:Number) : Number
      {
         return getDataById(param1).getMapStar();
      }
      
      public static function getEnemyId(param1:Number) : Array
      {
         return getDataById(param1).getEnemyId();
      }
      
      public static function getEnemyName(param1:Number) : Array
      {
         return getDataById(param1).getEnemyName();
      }
      
      public static function getEnemyNum(param1:Number) : Array
      {
         return getDataById(param1).getEnemyNum();
      }
      
      public static function getGoodsId(param1:Number) : Array
      {
         return getDataById(param1).getGoodsId();
      }
      
      public static function getGoodsNum(param1:Number) : Array
      {
         return getDataById(param1).getGoodsNum();
      }
      
      public static function getLianjiNum(param1:Number) : Number
      {
         return getDataById(param1).getLianjiNum();
      }
      
      public static function getFightNum(param1:Number) : Number
      {
         return getDataById(param1).getFightNum();
      }
      
      public static function getTime(param1:Number) : Number
      {
         return getDataById(param1).getTimeNum();
      }
      
      public static function getFinishGold(param1:Number) : Number
      {
         return getDataById(param1).getFinishGold();
      }
      
      public static function getFinishLevel(param1:Number) : Number
      {
         return getDataById(param1).getFinishLevel();
      }
      
      public static function getTg(param1:Number) : Boolean
      {
         return getDataById(param1).getTg();
      }
      
      public static function getNpc(param1:Number) : Number
      {
         return getDataById(param1).getNpc();
      }
      
      public static function getYhd(param1:Number) : Number
      {
         return getDataById(param1).getYhd();
      }
      
      public static function getPhb(param1:Number) : Number
      {
         return getDataById(param1).getPhb();
      }
      
      public static function getAwardId(param1:Number) : Array
      {
         return getDataById(param1).getAwardId();
      }
      
      public static function getAwardType(param1:Number) : Array
      {
         return getDataById(param1).getAwardType();
      }
      
      public static function getAwardNum(param1:Number) : Array
      {
         return getDataById(param1).getAwardNum();
      }
      
      public static function getAwardGold(param1:Number) : Number
      {
         return getDataById(param1).getGold();
      }
      
      public static function getAwardExp(param1:Number) : Number
      {
         return getDataById(param1).getExp();
      }
      
      public static function getAwardPs(param1:Number) : Number
      {
         return getDataById(param1).getPlayerStata();
      }
      
      public static function getAwardGl(param1:Number) : Array
      {
         return getDataById(param1).getGl();
      }
      
      public static function getGoodsMaxNum(param1:Number, param2:Number) : Number
      {
         var _loc5_:uint = 0;
         var _loc3_:Array = getGoodsId(param1);
         var _loc4_:Array = getGoodsNum(param1);
         if(_loc3_[0].getValue() != -1)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               if(_loc3_[_loc5_].getValue() == param2)
               {
                  return _loc4_[_loc5_].getValue();
               }
               _loc5_++;
            }
         }
         return -1;
      }
      
      private function creatTaskXml() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Boolean = false;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Boolean = false;
         var _loc28_:String = null;
         var _loc29_:String = null;
         var _loc30_:String = null;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:String = null;
         var _loc35_:TaskBasicData = null;
         for each(_loc1_ in myXml.任务)
         {
            _loc2_ = Number(_loc1_.ID);
            _loc3_ = String(_loc1_.名称);
            _loc4_ = Number(_loc1_.级数);
            _loc5_ = String(_loc1_.介绍);
            _loc6_ = String(_loc1_.需求);
            _loc7_ = Number(_loc1_.大类型);
            _loc8_ = Number(_loc1_.小类型);
            _loc9_ = String(_loc1_.委托人);
            _loc10_ = Number(_loc1_.完成条件.地图ID);
            _loc11_ = Number(_loc1_.完成条件.地图星级);
            _loc12_ = String(_loc1_.完成条件.怪物ID);
            _loc13_ = String(_loc1_.完成条件.怪物名字);
            _loc14_ = String(_loc1_.完成条件.怪物数量);
            _loc15_ = String(_loc1_.完成条件.物品ID);
            _loc16_ = String(_loc1_.完成条件.物品数量);
            _loc17_ = Number(_loc1_.完成条件.连击数);
            _loc18_ = Number(_loc1_.完成条件.被击打数);
            _loc19_ = Number(_loc1_.完成条件.时间);
            _loc20_ = Number(_loc1_.完成条件.完成金币);
            _loc21_ = Number(_loc1_.完成条件.完成等级);
            _loc22_ = (_loc1_.完成条件.通关.toString() == "true") as Boolean;
            _loc23_ = Number(_loc1_.完成条件.npc);
            _loc24_ = Number(_loc1_.完成条件.友好度);
            _loc25_ = Number(_loc1_.完成条件.排行榜);
            _loc26_ = Number(_loc1_.出现任务条件.前置任务ID);
            _loc27_ = (_loc1_.出现任务条件.重生.toString() == "true") as Boolean;
            _loc28_ = String(_loc1_.奖励.奖励类型);
            _loc29_ = String(_loc1_.奖励.奖励id);
            _loc30_ = String(_loc1_.奖励.奖励数量);
            _loc31_ = Number(_loc1_.奖励.金币);
            _loc32_ = Number(_loc1_.奖励.经验);
            _loc33_ = Number(_loc1_.奖励.奖励状态);
            _loc34_ = String(_loc1_.奖励.奖励概率);
            _loc35_ = TaskBasicData.creatTaskBasicData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc26_,_loc27_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_,_loc24_,_loc25_,_loc28_,_loc29_,_loc30_,_loc31_,_loc32_,_loc33_,_loc34_);
            allData.push(_loc35_);
            allTask.push(_loc35_.creatTask());
         }
      }
   }
}

