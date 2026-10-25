package com.hotpoint.braveManIII.repository.quest
{
   import com.hotpoint.braveManIII.models.quest.Quest;
   import com.hotpoint.braveManIII.repository.task.*;
   
   public class QuestFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function QuestFactory()
      {
         super();
      }
      
      public static function creatQuestFactory() : *
      {
         var _loc1_:QuestFactory = new QuestFactory();
         _loc1_.creatQuestFactory();
      }
      
      public static function getQuestById(param1:Number) : QuestBasicData
      {
         var _loc2_:QuestBasicData = null;
         var _loc3_:QuestBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getFallLevel() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("找不到此任务物品掉落等级");
         }
         return _loc2_;
      }
      
      public static function getTaskId(param1:Number) : Number
      {
         return getQuestById(param1).getId();
      }
      
      public static function getName(param1:Number) : String
      {
         return getQuestById(param1).getName();
      }
      
      public static function getType(param1:Number) : Number
      {
         return getQuestById(param1).getType();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getQuestById(param1).getFrame();
      }
      
      public static function getFallLevel(param1:Number) : Number
      {
         return getQuestById(param1).getFallLevel();
      }
      
      public static function getIntroduction(param1:Number) : String
      {
         return getQuestById(param1).getIntroduction();
      }
      
      public static function isMany(param1:Number) : Boolean
      {
         return getQuestById(param1).isMany();
      }
      
      public static function getTimes(param1:Number) : Number
      {
         return getQuestById(param1).getTimes();
      }
      
      public static function getPileLimit(param1:Number) : Number
      {
         return getQuestById(param1).getPileLimit();
      }
      
      public static function getFallMax(param1:Number) : Number
      {
         return getQuestById(param1).getFallMax();
      }
      
      public static function getGold(param1:Number) : Number
      {
         return getQuestById(param1).getGold();
      }
      
      public static function creatQust(param1:Number) : Quest
      {
         return getQuestById(param1).creatQuest();
      }
      
      public static function getGoodMaxNum(param1:Number) : Number
      {
         var _loc2_:Number = getTaskId(param1);
         return Number(TaskFactioy.getGoodsMaxNum(_loc2_,param1));
      }
      
      private function creatQuestFactory() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:QuestBasicData = null;
         for each(_loc1_ in myXml.任务道具)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = String(_loc1_.名字);
            _loc4_ = Number(_loc1_.类型);
            _loc5_ = Number(_loc1_.帧数);
            _loc6_ = Number(_loc1_.掉落等级);
            _loc7_ = String(_loc1_.介绍);
            _loc8_ = (_loc1_.叠加.toString() == "true") as Boolean;
            _loc9_ = Number(_loc1_.堆叠次数);
            _loc10_ = Number(_loc1_.堆叠上限);
            _loc11_ = Number(_loc1_.最大掉落数);
            _loc12_ = Number(_loc1_.金币);
            _loc13_ = QuestBasicData.creatQuest(_loc2_,_loc6_,_loc4_,_loc3_,_loc5_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_);
            allData.push(_loc13_);
         }
      }
   }
}

