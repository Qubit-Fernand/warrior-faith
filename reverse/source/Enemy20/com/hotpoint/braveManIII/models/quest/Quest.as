package com.hotpoint.braveManIII.models.quest
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   
   public class Quest
   {
      
      private var _fallId:VT;
      
      private var _times:VT = VT.createVT(1);
      
      public function Quest()
      {
         super();
      }
      
      public static function creatQuest(fallId:*, times:*) : Quest
      {
         var quest:Quest = new Quest();
         quest._times = VT.createVT(times);
         quest._fallId = VT.createVT(fallId);
         return quest;
      }
      
      public function get fallId() : VT
      {
         return this._fallId;
      }
      
      public function set fallId(value:VT) : void
      {
         this._fallId = value;
      }
      
      public function get times() : VT
      {
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         this._times = value;
      }
      
      public function getName() : String
      {
         return QuestFactory.getName(this._fallId.getValue());
      }
      
      public function getFrame() : Number
      {
         return QuestFactory.getFrame(this._fallId.getValue());
      }
      
      public function getFallLevel() : Number
      {
         return QuestFactory.getFallLevel(this._fallId.getValue());
      }
      
      public function getType() : Number
      {
         return QuestFactory.getType(this._fallId.getValue());
      }
      
      public function getIntroduction() : String
      {
         return QuestFactory.getIntroduction(this._fallId.getValue());
      }
      
      public function isMany() : Boolean
      {
         return QuestFactory.isMany(this._fallId.getValue());
      }
      
      public function getFallMax() : Number
      {
         return QuestFactory.getFallMax(this._fallId.getValue());
      }
      
      public function getGold() : Number
      {
         return QuestFactory.getGold(this._fallId.getValue());
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function getPileLimit() : Number
      {
         return QuestFactory.getPileLimit(this._fallId.getValue());
      }
      
      public function compareById(id:Number) : Boolean
      {
         if(this._fallId.getValue() == id)
         {
            return true;
         }
         return false;
      }
      
      public function compareQuest(qq:Quest) : Boolean
      {
         if(this._fallId.getValue() == qq._fallId.getValue())
         {
            return true;
         }
         return false;
      }
      
      public function useQuest(ts:Number) : Boolean
      {
         if(this._times.getValue() >= ts)
         {
            this._times.setValue(this._times.getValue() - ts);
            if(this._times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function addQuest(ts:Number) : Boolean
      {
         if(this._times.getValue() + ts <= this.getPileLimit())
         {
            this._times.setValue(this._times.getValue() + ts);
            return true;
         }
         return false;
      }
      
      public function cloneQuest(ts:Number) : Quest
      {
         return creatQuest(this._fallId.getValue(),ts);
      }
      
      public function getGoodMaxNum() : Number
      {
         return QuestFactory.getGoodMaxNum(this._fallId.getValue());
      }
   }
}

