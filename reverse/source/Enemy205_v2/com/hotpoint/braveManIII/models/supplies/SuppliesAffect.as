package com.hotpoint.braveManIII.models.supplies
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class SuppliesAffect
   {
      
      private var _attribType:VT;
      
      private var _value:VT;
      
      public function SuppliesAffect()
      {
         super();
      }
      
      public static function creatSuppliesAffect(attribType:Number, value:Number) : SuppliesAffect
      {
         var sa:SuppliesAffect = new SuppliesAffect();
         sa._attribType = VT.createVT(attribType);
         sa._value = VT.createVT(value);
         return sa;
      }
      
      public function get attribType() : VT
      {
         return _attribType;
      }
      
      public function set attribType(value:VT) : void
      {
         _attribType = value;
      }
      
      public function get value() : VT
      {
         return _value;
      }
      
      public function set value(value:VT) : void
      {
         _value = value;
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

