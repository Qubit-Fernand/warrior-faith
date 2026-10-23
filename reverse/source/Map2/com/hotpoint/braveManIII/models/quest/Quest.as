package com.hotpoint.braveManIII.models.quest
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   
   public class Quest
   {
      
      private var _fallId:VT;
      
      public function Quest()
      {
         super();
      }
      
      public static function creatQuest(param1:*) : Quest
      {
         var _loc2_:Quest = null;
         _loc2_ = new Quest();
         _loc2_._fallId = VT.createVT(param1);
         return _loc2_;
      }
      
      public function getFallMax() : Number
      {
         return QuestFactory.getFallMax(_fallId.getValue());
      }
      
      public function getName() : String
      {
         return QuestFactory.getName(_fallId.getValue());
      }
      
      public function isMany() : Boolean
      {
         return QuestFactory.isMany(_fallId.getValue());
      }
      
      public function set fallId(param1:VT) : void
      {
         _fallId = param1;
      }
      
      public function getType() : Number
      {
         return QuestFactory.getType(_fallId.getValue());
      }
      
      public function getFallLevel() : Number
      {
         return QuestFactory.getFallLevel(_fallId.getValue());
      }
      
      public function get fallId() : VT
      {
         return _fallId;
      }
      
      public function getFrame() : Number
      {
         return QuestFactory.getFrame(_fallId.getValue());
      }
      
      public function getGold() : Number
      {
         return QuestFactory.getGold(_fallId.getValue());
      }
      
      public function getIntroduction() : String
      {
         return QuestFactory.getIntroduction(_fallId.getValue());
      }
   }
}

