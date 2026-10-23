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
      
      public static function creatQuest(param1:*, param2:*) : Quest
      {
         var _loc3_:Quest = new Quest();
         _loc3_._times = VT.createVT(param2);
         _loc3_._fallId = VT.createVT(param1);
         return _loc3_;
      }
      
      public function get fallId() : VT
      {
         return this._fallId;
      }
      
      public function set fallId(param1:VT) : void
      {
         this._fallId = param1;
      }
      
      public function get times() : VT
      {
         return this._times;
      }
      
      public function set times(param1:VT) : void
      {
         this._times = param1;
      }
      
      public function getId() : Number
      {
         return this._fallId.getValue();
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
      
      public function compareById(param1:Number) : Boolean
      {
         if(this._fallId.getValue() == param1)
         {
            return true;
         }
         return false;
      }
      
      public function compareQuest(param1:Quest) : Boolean
      {
         if(this._fallId.getValue() == param1._fallId.getValue())
         {
            return true;
         }
         return false;
      }
      
      public function useQuest(param1:Number) : Boolean
      {
         if(this._times.getValue() >= param1)
         {
            this._times.setValue(this._times.getValue() - param1);
            if(this._times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function addQuest(param1:Number) : Boolean
      {
         if(this._times.getValue() + param1 <= this.getPileLimit())
         {
            this._times.setValue(this._times.getValue() + param1);
            return true;
         }
         return false;
      }
      
      public function cloneQuest(param1:Number) : Quest
      {
         return creatQuest(this._fallId.getValue(),param1);
      }
      
      public function getGoodMaxNum() : Number
      {
         return QuestFactory.getGoodMaxNum(this._fallId.getValue());
      }
   }
}

