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
      
      public static function creatKillCond() : *
      {
         var skillCond:SkillConditionFactory = new SkillConditionFactory();
         skillCond.creatLoard();
      }
      
      private static function getSkillDataByTypeId(typeId:String) : Array
      {
         var skData:SkillConditionBaseData = null;
         var data:SkillConditionBaseData = null;
         var skArr:Array = [];
         for each(data in SkillCondDataArr)
         {
            if(data.getTypeId() == typeId)
            {
               skData = data;
               skArr.push(skData);
            }
         }
         if(skArr.length < 1)
         {
            throw new Error("找不到基础数据!typeId:" + typeId);
         }
         return skArr;
      }
      
      public static function getPlayerDataLevel(typeId:String, level:Number = 1) : Number
      {
         var myArr:Array = [];
         var skLevel:Number = level - 1;
         myArr = getSkillDataByTypeId(typeId).slice(0);
         return myArr[skLevel].getPlayerDataLevel();
      }
      
      public static function getRebirth(typeId:String, level:Number = 1) : Boolean
      {
         var myArr:Array = [];
         var skLevel:Number = level - 1;
         myArr = getSkillDataByTypeId(typeId).slice(0);
         return myArr[skLevel].getRebirth();
      }
      
      public static function getTransfer(typeId:String, level:Number = 1) : Boolean
      {
         var myArr:Array = [];
         var skLevel:Number = level - 1;
         myArr = getSkillDataByTypeId(typeId).slice(0);
         return myArr[skLevel].getTransfer();
      }
      
      public static function getBeforeLevel(typeId:String, level:Number = 1) : Number
      {
         var myArr:Array = [];
         var skLevel:Number = level - 1;
         myArr = getSkillDataByTypeId(typeId).slice(0);
         return myArr[skLevel].getBeforeLevel();
      }
      
      public static function getBeforeLevelId(typeId:String, level:Number = 1) : String
      {
         var myArr:Array = [];
         var skLevel:Number = level - 1;
         myArr = getSkillDataByTypeId(typeId).slice(0);
         return myArr[skLevel].getBeforeLevelId();
      }
      
      public static function getPoints(typeId:String, level:Number = 1) : Number
      {
         var myArr:Array = [];
         var skLevel:Number = level - 1;
         myArr = getSkillDataByTypeId(typeId).slice(0);
         return myArr[skLevel].getPoints();
      }
      
      public static function getGold(typeId:String, level:Number = 1) : Number
      {
         var myArr:Array = [];
         var skLevel:Number = level - 1;
         myArr = getSkillDataByTypeId(typeId).slice(0);
         return myArr[skLevel].getGold();
      }
      
      public static function getCondition(typeId:String, skilllevel:*) : Array
      {
         var conditionArr:Array = [];
         conditionArr.push(getPlayerDataLevel(typeId,skilllevel));
         conditionArr.push(getPoints(typeId,skilllevel));
         conditionArr.push(getGold(typeId,skilllevel));
         conditionArr.push(getRebirth(typeId,skilllevel));
         conditionArr.push(getTransfer(typeId,skilllevel));
         conditionArr.push(getBeforeLevelId(typeId,skilllevel));
         conditionArr.push(getBeforeLevel(typeId,skilllevel));
         return conditionArr;
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var property:XML = null;
         var typeId:String = null;
         var skillLevel:Number = NaN;
         var playerLevel:Number = NaN;
         var rebirth:Boolean = false;
         var transfer:Boolean = false;
         var beforeLevelId:String = null;
         var beforeLevel:Number = NaN;
         var points:Number = NaN;
         var gold:Number = NaN;
         var condtionData:SkillConditionBaseData = null;
         for each(property in myXml.技能)
         {
            typeId = String(property.技能类型);
            skillLevel = Number(property.技能等级);
            playerLevel = Number(property.学习条件.角色等级);
            rebirth = (property.学习条件.重生.toString() == "true") as Boolean;
            transfer = (property.学习条件.转职.toString() == "true") as Boolean;
            beforeLevelId = String(property.学习条件.特定技能条件.特定技能类型);
            beforeLevel = Number(property.学习条件.特定技能条件.特定技能等级);
            points = Number(property.学习条件.点数);
            gold = Number(property.学习条件.金币);
            condtionData = SkillConditionBaseData.creatConditionBaseData(typeId,skillLevel,playerLevel,rebirth,transfer,beforeLevelId,beforeLevel,points,gold);
            SkillCondDataArr.push(condtionData);
            isCondDataOk = true;
         }
      }
   }
}

