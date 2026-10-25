package com.hotpoint.braveManIII.models.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
   public class Attribute
   {
      
      private var _attribType:VT;
      
      private var _value:VT;
      
      public function Attribute()
      {
         super();
      }
      
      public static function creatAttribute(param1:Number, param2:Number) : Attribute
      {
         var _loc3_:Attribute = new Attribute();
         _loc3_._attribType = VT.createVT(param1);
         _loc3_._value = VT.createVT(param2);
         return _loc3_;
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _attribType;
      }
      
      public function set attribType(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _attribType = param1;
      }
      
      public function get value() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function set value(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = param1;
      }
      
      public function getAttribType() : Number
      {
         return _attribType.getValue();
      }
      
      public function getValue() : Number
      {
         return _value.getValue();
      }
      
      public function setValue(param1:Number) : void
      {
         _value.setValue(param1);
      }
      
      public function getClone() : Attribute
      {
         return Attribute.creatAttribute(_attribType.getValue(),_value.getValue());
      }
   }
}

