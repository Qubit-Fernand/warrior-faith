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
      
      public static function creatAttribute(attribType:Number, value:Number) : Attribute
      {
         var att:Attribute = null;
         att = new Attribute();
         att._attribType = VT.createVT(attribType);
         att._value = VT.createVT(value);
         return att;
      }
      
      public function set value(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = value;
      }
      
      public function set attribType(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _attribType = value;
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _attribType;
      }
      
      public function getClone() : Attribute
      {
         return Attribute.creatAttribute(_attribType.getValue(),_value.getValue());
      }
      
      public function get value() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function setValue(value:Number) : void
      {
         _value.setValue(value);
      }
      
      public function getAttribType() : Number
      {
         return _attribType.getValue();
      }
      
      public function getValue() : Number
      {
         return _value.getValue();
      }
   }
}

