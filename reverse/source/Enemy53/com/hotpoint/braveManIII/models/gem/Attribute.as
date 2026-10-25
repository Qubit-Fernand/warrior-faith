package com.hotpoint.braveManIII.models.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   
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
         var att:Attribute = new Attribute();
         att._attribType = VT.createVT(attribType);
         att._value = VT.createVT(value);
         return att;
      }
      
      public function get attribType() : VT
      {
         return this._attribType;
      }
      
      public function set attribType(value:VT) : void
      {
         this._attribType = value;
      }
      
      public function get value() : VT
      {
         return this._value;
      }
      
      public function set value(value:VT) : void
      {
         this._value = value;
      }
      
      public function getAttribType() : Number
      {
         return this._attribType.getValue();
      }
      
      public function getValue() : Number
      {
         return this._value.getValue();
      }
      
      public function setValue(value:Number) : void
      {
         this._value.setValue(value);
      }
      
      public function getClone() : Attribute
      {
         return Attribute.creatAttribute(this._attribType.getValue(),this._value.getValue());
      }
   }
}

