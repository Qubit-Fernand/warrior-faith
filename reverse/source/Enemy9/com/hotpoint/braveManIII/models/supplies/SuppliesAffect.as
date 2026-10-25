package com.hotpoint.braveManIII.models.supplies
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
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
         var _loc3_:SuppliesAffect = null;
         _loc3_ = new SuppliesAffect();
         _loc3_._attribType = VT.createVT(param1);
         _loc3_._value = VT.createVT(param2);
         return _loc3_;
      }
      
      public function set value(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = param1;
      }
      
      public function set attribType(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _attribType = param1;
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _attribType;
      }
      
      public function get value() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
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

