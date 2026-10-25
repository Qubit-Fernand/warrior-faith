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
         var qe:QuestFactory = new QuestFactory();
         qe.creatQuestFactory();
      }
      
      public static function getQuestById(fallId:Number) : QuestBasicData
      {
         var questData:QuestBasicData = null;
         var data:QuestBasicData = null;
         for each(data in allData)
         {
            if(data.getFallLevel() == fallId)
            {
               questData = data;
            }
         }
         if(questData == null)
         {
            trace("找不到此任务物品掉落等级");
         }
         return questData;
      }
      
      public static function getTaskId(fallId:Number) : Number
      {
         return getQuestById(fallId).getId();
      }
      
      public static function getName(fallId:Number) : String
      {
         return getQuestById(fallId).getName();
      }
      
      public static function getType(fallId:Number) : Number
      {
         return getQuestById(fallId).getType();
      }
      
      public static function getFrame(fallId:Number) : Number
      {
         return getQuestById(fallId).getFrame();
      }
      
      public static function getFallLevel(fallId:Number) : Number
      {
         return getQuestById(fallId).getFallLevel();
      }
      
      public static function getIntroduction(fallId:Number) : String
      {
         return getQuestById(fallId).getIntroduction();
      }
      
      public static function isMany(fallId:Number) : Boolean
      {
         return getQuestById(fallId).isMany();
      }
      
      public static function getTimes(fallId:Number) : Number
      {
         return getQuestById(fallId).getTimes();
      }
      
      public static function getPileLimit(fallId:Number) : Number
      {
         return getQuestById(fallId).getPileLimit();
      }
      
      public static function getFallMax(fallId:Number) : Number
      {
         return getQuestById(fallId).getFallMax();
      }
      
      public static function getGold(fallId:Number) : Number
      {
         return getQuestById(fallId).getGold();
      }
      
      public static function creatQust(fallId:Number) : Quest
      {
         return getQuestById(fallId).creatQuest();
      }
      
      public static function getGoodMaxNum(fallId:Number) : Number
      {
         var taskId:Number = getTaskId(fallId);
         return Number(TaskFactioy.getGoodsMaxNum(taskId,fallId));
      }
      
      private function creatQuestFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var name:String = null;
         var type:Number = NaN;
         var frame:Number = NaN;
         var fallLevel:Number = NaN;
         var introduction:String = null;
         var many:Boolean = false;
         var times:Number = NaN;
         var pileLimit:Number = NaN;
         var fallMax:Number = NaN;
         var gold:Number = NaN;
         var data:QuestBasicData = null;
         for each(property in myXml.任务道具)
         {
            id = Number(property.编号);
            name = String(property.名字);
            type = Number(property.类型);
            frame = Number(property.帧数);
            fallLevel = Number(property.掉落等级);
            introduction = String(property.介绍);
            many = (property.叠加.toString() == "true") as Boolean;
            times = Number(property.堆叠次数);
            pileLimit = Number(property.堆叠上限);
            fallMax = Number(property.最大掉落数);
            gold = Number(property.金币);
            data = QuestBasicData.creatQuest(id,fallLevel,type,name,frame,introduction,many,times,pileLimit,fallMax,gold);
            allData.push(data);
         }
      }
   }
}

