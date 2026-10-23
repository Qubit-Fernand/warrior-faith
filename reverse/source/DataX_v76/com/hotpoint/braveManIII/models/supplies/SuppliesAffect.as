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
      
      public static function creatSuppliesAffect(param1:Number, param2:Number) : SuppliesAffect
      {
         var _loc3_:SuppliesAffect = new SuppliesAffect();
         _loc3_._attribType = VT.createVT(param1);
         _loc3_._value = VT.createVT(param2);
         return _loc3_;
      }
      
      public function get attribType() : VT
      {
         return _attribType;
      }
      
      public function set attribType(param1:VT) : void
      {
         _attribType = param1;
      }
      
      public function get value() : VT
      {
         return _value;
      }
      
      public function set value(param1:VT) : void
      {
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
   }
}

