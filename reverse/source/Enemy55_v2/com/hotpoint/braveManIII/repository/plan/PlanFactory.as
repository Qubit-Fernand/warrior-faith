package com.hotpoint.braveManIII.repository.plan
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.plan.Plan;
   import src.*;
   
   public class PlanFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public static var JiHuaData:Array = [];
      
      public function PlanFactory()
      {
         super();
      }
      
      public static function Init_JiHuaData() : *
      {
         var _loc1_:int = 0;
         if(JiHuaData.length <= 0)
         {
            _loc1_ = 0;
            while(_loc1_ < allData.length)
            {
               JiHuaData[_loc1_] = (allData[_loc1_] as PlanBasicData).creatPlan();
               _loc1_++;
            }
         }
      }
      
      public static function creatPlanFactory() : *
      {
         var _loc1_:PlanFactory = new PlanFactory();
         myXml = XMLAsset.createXML(Data2.jihua);
         _loc1_.creatPlanFactory();
         Init_JiHuaData();
      }
      
      public static function getPlanById(param1:Number) : PlanBasicData
      {
         var _loc2_:PlanBasicData = null;
         var _loc3_:PlanBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("找不到");
         }
         return _loc2_;
      }
      
      public static function getPlanByGroup(param1:Number, param2:Number) : PlanBasicData
      {
         var _loc3_:PlanBasicData = null;
         var _loc4_:PlanBasicData = null;
         for each(_loc4_ in allData)
         {
            if(_loc4_.getGroupId() == param1 && _loc4_.getGroup() == param2)
            {
               _loc3_ = _loc4_;
            }
         }
         if(_loc3_ == null)
         {
            trace("找不到");
         }
         return _loc3_;
      }
      
      public static function findGroupId(param1:Number) : Number
      {
         return getPlanById(param1).getGroupId();
      }
      
      public static function findXiaoZu(param1:Number) : Number
      {
         return getPlanById(param1).getGroup();
      }
      
      public static function findIntroduction(param1:Number) : String
      {
         return getPlanById(param1).getIntroduction();
      }
      
      public static function findRewardType_1(param1:Number) : Number
      {
         return getPlanById(param1).getRewardType_1();
      }
      
      public static function findRewardType_2(param1:Number) : Number
      {
         return getPlanById(param1).getRewardType_2();
      }
      
      public static function findReward_1(param1:Number) : Number
      {
         return getPlanById(param1).getReward_1();
      }
      
      public static function findReward_2(param1:Number) : Number
      {
         return getPlanById(param1).getReward_2();
      }
      
      public static function findFrame_1(param1:Number) : Number
      {
         return getPlanById(param1).getFrame_1();
      }
      
      public static function findFrame_2(param1:Number) : Number
      {
         return getPlanById(param1).getFrame_2();
      }
      
      public static function findCount_1(param1:Number) : Number
      {
         return getPlanById(param1).getCount_1();
      }
      
      public static function findCount_2(param1:Number) : Number
      {
         return getPlanById(param1).getCount_2();
      }
      
      public static function creatPlan(param1:Number) : Plan
      {
         return getPlanById(param1).creatPlan();
      }
      
      private function creatPlanFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:PlanBasicData = null;
         for each(_loc1_ in myXml.计划)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = Number(_loc1_.小组编号);
            _loc4_ = String(_loc1_.小组);
            _loc5_ = String(_loc1_.描述);
            _loc6_ = Number(_loc1_.奖励类型1);
            _loc7_ = Number(_loc1_.奖励类型2);
            _loc8_ = Number(_loc1_.奖励1);
            _loc9_ = Number(_loc1_.奖励2);
            _loc10_ = Number(_loc1_.帧数1);
            _loc11_ = Number(_loc1_.帧数2);
            _loc12_ = Number(_loc1_.数量1);
            _loc13_ = Number(_loc1_.数量2);
            _loc14_ = PlanBasicData.creatPlanBasicData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_);
            allData.push(_loc14_);
         }
      }
   }
}

