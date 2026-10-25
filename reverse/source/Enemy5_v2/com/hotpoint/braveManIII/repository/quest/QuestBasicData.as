package com.hotpoint.braveManIII.repository.quest
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.quest.*;
   
   public class QuestBasicData
   {
      
      private var _many:Boolean;
      
      private var _fallLevel:VT;
      
      private var _type:VT;
      
      private var _fallMax:VT;
      
      private var _frame:VT;
      
      private var _name:String;
      
      private var _introduction:String;
      
      private var _id:VT;
      
      private var _gold:VT;
      
      public function QuestBasicData()
      {
         super();
      }
      
      public static function creatQuest(id:Number, fallLevel:Number, type:Number, name:String, frame:Number, introduction:String, many:Boolean, fallMax:Number, gold:Number) : QuestBasicData
      {
         var quest:QuestBasicData = null;
         quest = new QuestBasicData();
         quest._id = VT.createVT(id);
         quest._fallLevel = VT.createVT(fallLevel);
         quest._type = VT.createVT(type);
         quest._name = name;
         quest._frame = VT.createVT(frame);
         quest._introduction = introduction;
         quest._many = many;
         quest._fallMax = VT.createVT(fallMax);
         quest._gold = VT.createVT(gold);
         return quest;
      }
      
      public function set gold(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gold = value;
      }
      
      public function getFallMax() : Number
      {
         return _fallMax.getValue();
      }
      
      public function set type(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _type = value;
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function get type() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _type;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _name;
      }
      
      public function set many(value:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _many = value;
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function set FallLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _fallLevel = value;
      }
      
      public function getFallLevel() : Number
      {
         return _fallLevel.getValue();
      }
      
      public function set name(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _name = value;
      }
      
      public function set fallMax(value:Number) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _fallMax = value;
      }
      
      public function set frame(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _frame = value;
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function get gold() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gold;
      }
      
      public function get introduction() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _introduction;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _id;
      }
      
      public function get many() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _many;
      }
      
      public function creatQuest() : Quest
      {
         return Quest.creatQuest(_fallLevel.getValue());
      }
      
      public function get FallLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _fallLevel;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _frame;
      }
      
      public function get fallMax() : Number
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _fallMax;
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = value;
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function isMany() : Boolean
      {
         return _many;
      }
      
      public function set introduction(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _introduction = value;
      }
   }
}

