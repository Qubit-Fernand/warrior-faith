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
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(value:VT) : void
      {
         _type = value;
      }
      
      public function get pileLimit() : VT
      {
         return _pileLimit;
      }
      
      public function set pileLimit(value:VT) : void
      {
         _pileLimit = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
      }
      
      public function get remaining() : VT
      {
         return _remaining;
      }
      
      public function set remaining(value:VT) : void
      {
         _remaining = value;
      }
      
      public function get multiple() : VT
      {
         return _multiple;
      }
      
      public function set multiple(value:VT) : void
      {
         _multiple = value;
      }
      
      public function get value_1() : VT
      {
         return _value_1;
      }
      
      public function set value_1(value:VT) : void
      {
         _value_1 = value;
      }
      
      public function get value_2() : VT
      {
         return _value_2;
      }
      
      public function set value_2(value:VT) : void
      {
         _value_2 = value;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function set color(value:VT) : void
      {
         _color = value;
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
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function isMany() : Boolean
      {
         return _many;
      }
      
      public function getPileLimit() : Number
      {
         return _pileLimit.getValue();
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function getRemaining() : Number
      {
         return _remaining.getValue();
      }
      
      public function getMultiple() : Number
      {
         return _multiple.getValue();
      }
      
      public function getValue_1() : Number
      {
         return _value_1.getValue();
      }
      
      public function getValue_2() : Number
      {
         return _value_2.getValue();
      }
      
      public function creatOther() : Otherobj
      {
         return Otherobj.creatOther(_id.getValue(),_times.getValue());
      }
   }
}

