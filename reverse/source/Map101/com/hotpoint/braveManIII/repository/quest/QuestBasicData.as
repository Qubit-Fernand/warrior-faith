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
      
      public static function creatQuest(param1:Number, param2:Number, param3:Number, param4:String, param5:Number, param6:String, param7:Boolean, param8:Number, param9:Number) : QuestBasicData
      {
         var _loc10_:QuestBasicData = null;
         _loc10_ = new QuestBasicData();
         _loc10_._id = VT.createVT(param1);
         _loc10_._fallLevel = VT.createVT(param2);
         _loc10_._type = VT.createVT(param3);
         _loc10_._name = param4;
         _loc10_._frame = VT.createVT(param5);
         _loc10_._introduction = param6;
         _loc10_._many = param7;
         _loc10_._fallMax = VT.createVT(param8);
         _loc10_._gold = VT.createVT(param9);
         return _loc10_;
      }
      
      public function set gold(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gold = param1;
      }
      
      public function getFallMax() : Number
      {
         return _fallMax.getValue();
      }
      
      public function set type(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _type = param1;
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
      
      public function set many(param1:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _many = param1;
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function set FallLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _fallLevel = param1;
      }
      
      public function getFallLevel() : Number
      {
         return _fallLevel.getValue();
      }
      
      public function set name(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _name = param1;
      }
      
      public function set fallMax(param1:Number) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _fallMax = param1;
      }
      
      public function set frame(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _frame = param1;
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
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = param1;
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function isMany() : Boolean
      {
         return _many;
      }
      
      public function set introduction(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _introduction = param1;
      }
   }
}

