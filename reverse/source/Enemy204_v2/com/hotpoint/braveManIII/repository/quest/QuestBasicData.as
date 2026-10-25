package com.hotpoint.braveManIII.repository.quest
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.quest.*;
   
   public class QuestBasicData
   {
      
      private var _id:VT;
      
      private var _fallLevel:VT;
      
      private var _type:VT;
      
      private var _name:String;
      
      private var _frame:VT;
      
      private var _introduction:String;
      
      private var _many:Boolean;
      
      private var _times:VT;
      
      private var _pileLimit:VT;
      
      private var _fallMax:VT;
      
      private var _gold:VT;
      
      public function QuestBasicData()
      {
         super();
      }
      
      public static function creatQuest(id:Number, fallLevel:Number, type:Number, name:String, frame:Number, introduction:String, many:Boolean, times:Number, pileLimit:Number, fallMax:Number, gold:Number) : QuestBasicData
      {
         var quest:QuestBasicData = new QuestBasicData();
         quest._id = VT.createVT(id);
         quest._fallLevel = VT.createVT(fallLevel);
         quest._type = VT.createVT(type);
         quest._name = name;
         quest._frame = VT.createVT(frame);
         quest._introduction = introduction;
         quest._many = many;
         quest._times = VT.createVT(times);
         quest._pileLimit = VT.createVT(pileLimit);
         quest._fallMax = VT.createVT(fallMax);
         quest._gold = VT.createVT(gold);
         return quest;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(value:String) : void
      {
         _introduction = value;
      }
      
      public function get many() : Boolean
      {
         return _many;
      }
      
      public function set many(value:Boolean) : void
      {
         _many = value;
      }
      
      public function get FallLevel() : VT
      {
         return _fallLevel;
      }
      
      public function set FallLevel(value:VT) : void
      {
         _fallLevel = value;
      }
      
      public function get gold() : VT
      {
         return _gold;
      }
      
      public function set gold(value:VT) : void
      {
         _gold = value;
      }
      
      public function get fallMax() : Number
      {
         return _fallMax;
      }
      
      public function set fallMax(value:Number) : void
      {
         _fallMax = value;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(value:VT) : void
      {
         _type = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
      }
      
      public function get pileLimit() : VT
      {
         return _pileLimit;
      }
      
      public function set pileLimit(value:VT) : void
      {
         _pileLimit = value;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function getFallLevel() : Number
      {
         return _fallLevel.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function isMany() : Boolean
      {
         return _many;
      }
      
      public function getFallMax() : Number
      {
         return _fallMax.getValue();
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getPileLimit() : Number
      {
         return _pileLimit.getValue();
      }
      
      public function creatQuest() : Quest
      {
         return Quest.creatQuest(_fallLevel.getValue(),_times.getValue());
      }
   }
}

