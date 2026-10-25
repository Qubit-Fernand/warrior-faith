package com.hotpoint.braveManIII.repository.other
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.other.*;
   
   public class OtherBasicData
   {
      
      private var _id:VT;
      
      private var _fallLevel:VT;
      
      private var _type:VT;
      
      private var _name:String;
      
      private var _frame:VT;
      
      private var _color:VT;
      
      private var _introduction:String;
      
      private var _many:Boolean;
      
      private var _pileLimit:VT;
      
      private var _times:VT;
      
      private var _gold:VT;
      
      private var _remaining:VT;
      
      private var _multiple:VT;
      
      private var _value_1:VT;
      
      private var _value_2:VT;
      
      public function OtherBasicData()
      {
         super();
      }
      
      public static function creatOtherBasicData(id:Number, fallLevel:Number, type:Number, name:String, frame:Number, color:Number, introduction:String, many:Boolean, pileLimit:Number, times:Number, gold:Number, remaining:Number, multiple:Number, value_1:Number, value_2:Number) : OtherBasicData
      {
         var other:OtherBasicData = new OtherBasicData();
         other._id = VT.createVT(id);
         other._fallLevel = VT.createVT(fallLevel);
         other._type = VT.createVT(type);
         other._name = name;
         other._frame = VT.createVT(frame);
         other._color = VT.createVT(color);
         other._introduction = introduction;
         other._many = many;
         other._pileLimit = VT.createVT(pileLimit);
         other._times = VT.createVT(times);
         other._gold = VT.createVT(gold);
         other._remaining = VT.createVT(remaining);
         other._multiple = VT.createVT(multiple);
         other._value_1 = VT.createVT(value_1);
         other._value_2 = VT.createVT(value_2);
         return other;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = value;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._name = value;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._frame;
      }
      
      public function set frame(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._frame = value;
      }
      
      public function get introduction() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._introduction;
      }
      
      public function set introduction(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._introduction = value;
      }
      
      public function get many() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._many;
      }
      
      public function set many(value:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._many = value;
      }
      
      public function get FallLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._fallLevel;
      }
      
      public function set FallLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._fallLevel = value;
      }
      
      public function get gold() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._gold;
      }
      
      public function set gold(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gold = value;
      }
      
      public function get type() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._type;
      }
      
      public function set type(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._type = value;
      }
      
      public function get pileLimit() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._pileLimit;
      }
      
      public function set pileLimit(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._pileLimit = value;
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._times = value;
      }
      
      public function get remaining() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._remaining;
      }
      
      public function set remaining(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._remaining = value;
      }
      
      public function get multiple() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._multiple;
      }
      
      public function set multiple(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._multiple = value;
      }
      
      public function get value_1() : VT
      {
         return this._value_1;
      }
      
      public function set value_1(value:VT) : void
      {
         this._value_1 = value;
      }
      
      public function get value_2() : VT
      {
         return this._value_2;
      }
      
      public function set value_2(value:VT) : void
      {
         this._value_2 = value;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function set color(value:VT) : void
      {
         this._color = value;
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
      
      public function getColor() : Number
      {
         return this._color.getValue();
      }
      
      public function getIntroduction() : String
      {
         return this._introduction;
      }
      
      public function isMany() : Boolean
      {
         return this._many;
      }
      
      public function getPileLimit() : Number
      {
         return this._pileLimit.getValue();
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function getGold() : Number
      {
         return this._gold.getValue();
      }
      
      public function getRemaining() : Number
      {
         return this._remaining.getValue();
      }
      
      public function getMultiple() : Number
      {
         return this._multiple.getValue();
      }
      
      public function getValue_1() : Number
      {
         return this._value_1.getValue();
      }
      
      public function getValue_2() : Number
      {
         return this._value_2.getValue();
      }
      
      public function creatOther() : Otherobj
      {
         return Otherobj.creatOther(this._id.getValue(),this._times.getValue());
      }
   }
}

