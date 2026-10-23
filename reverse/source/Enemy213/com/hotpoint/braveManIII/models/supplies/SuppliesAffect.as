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
         var _loc3_:SuppliesAffect = new SuppliesAffect();
         _loc3_._attribType = VT.createVT(param1);
         _loc3_._value = VT.createVT(param2);
         return _loc3_;
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._attribType;
      }
      
      public function set attribType(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._attribType = param1;
      }
      
      public function get value() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._value;
      }
      
      public function set value(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._value = param1;
      }
      
      public function getAttribType() : Number
      {
         return this._attribType.getValue();
      }
      
      public function getValue() : Number
      {
         return this._value.getValue();
      }
   }
}

