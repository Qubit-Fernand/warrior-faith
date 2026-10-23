package com.hotpoint.braveManIII.repository.skillCondition
{
   public class SkillConditionFactory
   {
      
      public static var isCondDataOk:Boolean;
      
      public static var SkillCondDataArr:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function SkillConditionFactory()
      {
         super();
      }
      
      public static function getTransfer(param1:String, param2:Number = 1) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         _loc3_ = [];
         _loc4_ = param2 - 1;
         _loc3_ = getSkillDataByTypeId(param1).slice(0);
         return _loc3_[_loc4_].getTransfer();
      }
      
      public static function getPlayerDataLevel(param1:String, param2:Number = 1) : Number
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         _loc3_ = [];
         _loc4_ = param2 - 1;
         _loc3_ = getSkillDataByTypeId(param1).slice(0);
         return _loc3_[_loc4_].getPlayerDataLevel();
      }
      
      public static function getGold(param1:String, param2:Number = 1) : Number
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         _loc3_ = [];
         _loc4_ = param2 - 1;
         _loc3_ = getSkillDataByTypeId(param1).slice(0);
         return _loc3_[_loc4_].getGold();
      }
      
      public static function creatKillCond() : *
      {
         var _loc1_:SkillConditionFactory = null;
         _loc1_ = new SkillConditionFactory();
         _loc1_.creatLoard();
      }
      
      public static function getBeforeLevelId(param1:String, param2:Number = 1) : String
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         _loc3_ = [];
         _loc4_ = param2 - 1;
         _loc3_ = getSkillDataByTypeId(param1).slice(0);
         return _loc3_[_loc4_].getBeforeLevelId();
      }
      
      public static function getCondition(param1:String, param2:*) : Array
      {
         var _loc3_:Array = null;
         _loc3_ = [];
         _loc3_.push(getPlayerDataLevel(param1,param2));
         _loc3_.push(getPoints(param1,param2));
         _loc3_.push(getGold(param1,param2));
         _loc3_.push(getRebirth(param1,param2));
         _loc3_.push(getTransfer(param1,param2));
         _loc3_.push(getBeforeLevelId(param1,param2));
         _loc3_.push(getBeforeLevel(param1,param2));
         return _loc3_;
      }
      
      public static function getBeforeLevel(param1:String, param2:Number = 1) : Number
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         _loc3_ = [];
         _loc4_ = param2 - 1;
         _loc3_ = getSkillDataByTypeId(param1).slice(0);
         return _loc3_[_loc4_].getBeforeLevel();
      }
      
      private static function getSkillDataByTypeId(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:SkillConditionBaseData = null;
         var _loc4_:SkillConditionBaseData = null;
         _loc2_ = [];
         for each(_loc4_ in SkillCondDataArr)
         {
            if(_loc4_.getTypeId() == param1)
            {
               _loc3_ = _loc4_;
               _loc2_.push(_loc3_);
            }
         }
         if(_loc2_.length < 1)
         {
            throw new Error("找不到基础数据!typeId:" + param1);
         }
         return _loc2_;
      }
      
      public static function getPoints(param1:String, param2:Number = 1) : Number
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         _loc3_ = [];
         _loc4_ = param2 - 1;
         _loc3_ = getSkillDataByTypeId(param1).slice(0);
         return _loc3_[_loc4_].getPoints();
      }
      
      public static function getRebirth(param1:String, param2:Number = 1) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         _loc3_ = [];
         _loc4_ = param2 - 1;
         _loc3_ = getSkillDataByTypeId(param1).slice(0);
         return _loc3_[_loc4_].getRebirth();
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var _loc1_:XML = null;
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:SkillConditionBaseData = null;
         for each(_loc1_ in myXml.技能)
         {
            _loc2_ = String(_loc1_.技能类型);
            _loc3_ = Number(_loc1_.技能等级);
            _loc4_ = Number(_loc1_.学习条件.角色等级);
            _loc5_ = (_loc1_.学习条件.重生.toString() == "true") as Boolean;
            _loc6_ = (_loc1_.学习条件.转职.toString() == "true") as Boolean;
            _loc7_ = String(_loc1_.学习条件.特定技能条件.特定技能类型);
            _loc8_ = Number(_loc1_.学习条件.特定技能条件.特定技能等级);
            _loc9_ = Number(_loc1_.学习条件.点数);
            _loc10_ = Number(_loc1_.学习条件.金币);
            _loc11_ = SkillConditionBaseData.creatConditionBaseData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
            SkillCondDataArr.push(_loc11_);
            isCondDataOk = true;
         }
      }
   }
}

