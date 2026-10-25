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
      
      public static function creatOtherBasicData(param1:Number, param2:Number, param3:Number, param4:String, param5:Number, param6:Number, param7:String, param8:Boolean, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number) : OtherBasicData
      {
         var _loc16_:OtherBasicData = new OtherBasicData();
         _loc16_._id = VT.createVT(param1);
         _loc16_._fallLevel = VT.createVT(param2);
         _loc16_._type = VT.createVT(param3);
         _loc16_._name = param4;
         _loc16_._frame = VT.createVT(param5);
         _loc16_._color = VT.createVT(param6);
         _loc16_._introduction = param7;
         _loc16_._many = param8;
         _loc16_._pileLimit = VT.createVT(param9);
         _loc16_._times = VT.createVT(param10);
         _loc16_._gold = VT.createVT(param11);
         _loc16_._remaining = VT.createVT(param12);
         _loc16_._multiple = VT.createVT(param13);
         _loc16_._value_1 = VT.createVT(param14);
         _loc16_._value_2 = VT.createVT(param15);
         return _loc16_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(param1:VT) : void
      {
         _frame = param1;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         _introduction = param1;
      }
      
      public function get many() : Boolean
      {
         return _many;
      }
      
      public function set many(param1:Boolean) : void
      {
         _many = param1;
      }
      
      public function get FallLevel() : VT
      {
         return _fallLevel;
      }
      
      public function set FallLevel(param1:VT) : void
      {
         _fallLevel = param1;
      }
      
      public function get gold() : VT
      {
         return _gold;
      }
      
      public function set gold(param1:VT) : void
      {
         _gold = param1;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(param1:VT) : void
      {
         _type = param1;
      }
      
      public function get pileLimit() : VT
      {
         return _pileLimit;
      }
      
      public function set pileLimit(param1:VT) : void
      {
         _pileLimit = param1;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(param1:VT) : void
      {
         _times = param1;
      }
      
      public function get remaining() : VT
      {
         return _remaining;
      }
      
      public function set remaining(param1:VT) : void
      {
         _remaining = param1;
      }
      
      public function get multiple() : VT
      {
         return _multiple;
      }
      
      public function set multiple(param1:VT) : void
      {
         _multiple = param1;
      }
      
      public function get value_1() : VT
      {
         return _value_1;
      }
      
      public function set value_1(param1:VT) : void
      {
         _value_1 = param1;
      }
      
      public function get value_2() : VT
      {
         return _value_2;
      }
      
      public function set value_2(param1:VT) : void
      {
         _value_2 = param1;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function set color(param1:VT) : void
      {
         _color = param1;
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

