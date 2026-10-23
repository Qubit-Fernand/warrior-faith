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
      
      public static function creatSuppliesAffect(attribType:Number, value:Number) : SuppliesAffect
      {
         var sa:SuppliesAffect = new SuppliesAffect();
         sa._attribType = VT.createVT(attribType);
         sa._value = VT.createVT(value);
         return sa;
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._attribType;
      }
      
      public function set attribType(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._attribType = value;
      }
      
      public function get value() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._value;
      }
      
      public function set value(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
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
   }
}

