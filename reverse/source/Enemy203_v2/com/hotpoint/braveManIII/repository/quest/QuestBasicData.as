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
      
      public static function creatQuest(param1:Number, param2:Number, param3:Number, param4:String, param5:Number, param6:String, param7:Boolean, param8:Number, param9:Number, param10:Number, param11:Number) : QuestBasicData
      {
         var _loc12_:QuestBasicData = new QuestBasicData();
         _loc12_._id = VT.createVT(param1);
         _loc12_._fallLevel = VT.createVT(param2);
         _loc12_._type = VT.createVT(param3);
         _loc12_._name = param4;
         _loc12_._frame = VT.createVT(param5);
         _loc12_._introduction = param6;
         _loc12_._many = param7;
         _loc12_._times = VT.createVT(param8);
         _loc12_._pileLimit = VT.createVT(param9);
         _loc12_._fallMax = VT.createVT(param10);
         _loc12_._gold = VT.createVT(param11);
         return _loc12_;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = param1;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._name = param1;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._frame;
      }
      
      public function set frame(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._frame = param1;
      }
      
      public function get introduction() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._introduction = param1;
      }
      
      public function get many() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._many;
      }
      
      public function set many(param1:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._many = param1;
      }
      
      public function get FallLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._fallLevel;
      }
      
      public function set FallLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._fallLevel = param1;
      }
      
      public function get gold() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._gold;
      }
      
      public function set gold(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gold = param1;
      }
      
      public function get fallMax() : Number
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._fallMax;
      }
      
      public function set fallMax(param1:Number) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._fallMax = param1;
      }
      
      public function get type() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._type;
      }
      
      public function set type(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._type = param1;
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._times;
      }
      
      public function set times(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._times = param1;
      }
      
      public function get pileLimit() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._pileLimit;
      }
      
      public function set pileLimit(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._pileLimit = param1;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getType() : Number
      {
         return this._type.getValue();
      }
      
      public function getFallLevel() : Number
      {
         return this._fallLevel.getValue();
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getIntroduction() : String
      {
         return this._introduction;
      }
      
      public function isMany() : Boolean
      {
         return this._many;
      }
      
      public function getFallMax() : Number
      {
         return this._fallMax.getValue();
      }
      
      public function getGold() : Number
      {
         return this._gold.getValue();
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function getPileLimit() : Number
      {
         return this._pileLimit.getValue();
      }
      
      public function creatQuest() : Quest
      {
         return Quest.creatQuest(this._fallLevel.getValue(),this._times.getValue());
      }
   }
}

