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
         return _fallId;
      }
      
      public function set fallId(value:VT) : void
      {
         _fallId = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
      }
      
      public function getId() : Number
      {
         return _fallId.getValue();
      }
      
      public function getName() : String
      {
         return QuestFactory.getName(_fallId.getValue());
      }
      
      public function getFrame() : Number
      {
         return QuestFactory.getFrame(_fallId.getValue());
      }
      
      public function getFallLevel() : Number
      {
         return QuestFactory.getFallLevel(_fallId.getValue());
      }
      
      public function getType() : Number
      {
         return QuestFactory.getType(_fallId.getValue());
      }
      
      public function getIntroduction() : String
      {
         return QuestFactory.getIntroduction(_fallId.getValue());
      }
      
      public function isMany() : Boolean
      {
         return QuestFactory.isMany(_fallId.getValue());
      }
      
      public function getFallMax() : Number
      {
         return QuestFactory.getFallMax(_fallId.getValue());
      }
      
      public function getGold() : Number
      {
         return QuestFactory.getGold(_fallId.getValue());
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getPileLimit() : Number
      {
         return QuestFactory.getPileLimit(_fallId.getValue());
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
         if(_times.getValue() >= ts)
         {
            _times.setValue(_times.getValue() - ts);
            if(_times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function addQuest(ts:Number) : Boolean
      {
         if(_times.getValue() + ts <= this.getPileLimit())
         {
            _times.setValue(_times.getValue() + ts);
            return true;
         }
         return false;
      }
      
      public function cloneQuest(ts:Number) : Quest
      {
         return creatQuest(_fallId.getValue(),ts);
      }
      
      public function getGoodMaxNum() : Number
      {
         return QuestFactory.getGoodMaxNum(_fallId.getValue());
      }
   }
}

