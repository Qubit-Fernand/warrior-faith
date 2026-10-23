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
         return _fallId;
      }
      
      public function set fallId(param1:VT) : void
      {
         _fallId = param1;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(param1:VT) : void
      {
         _times = param1;
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
         if(_times.getValue() >= param1)
         {
            _times.setValue(_times.getValue() - param1);
            if(_times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function addQuest(param1:Number) : Boolean
      {
         if(_times.getValue() + param1 <= this.getPileLimit())
         {
            _times.setValue(_times.getValue() + param1);
            return true;
         }
         return false;
      }
      
      public function cloneQuest(param1:Number) : Quest
      {
         return creatQuest(_fallId.getValue(),param1);
      }
      
      public function getGoodMaxNum() : Number
      {
         return QuestFactory.getGoodMaxNum(_fallId.getValue());
      }
   }
}

