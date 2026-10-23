package com.hotpoint.braveManIII.models.common
{
   import flash.utils.*;
   
   public class VT
   {
      
      private var _value:Object = new Object();
      
      public function VT()
      {
         super();
      }
      
      public static function createVT(param1:Number = 0) : VT
      {
         var _loc2_:VT = null;
         _loc2_ = new VT();
         _loc2_.setValue(param1);
         return _loc2_;
      }
      
      public function setValue(param1:Number) : void
      {
         var _loc2_:Object = null;
         _loc2_ = new Object();
         _loc2_.random = Math.round(Math.random() * 733 + 5) * (Math.round(Math.random()) * 2 - 1);
         _loc2_.num = param1 + _loc2_.random;
         this._value = _loc2_;
      }
      
      public function get value() : Object
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function set value(param1:Object) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = param1;
      }
      
      public function getValue() : Number
      {
         var _loc1_:Number = NaN;
         return _value.num - _value.random;
      }
   }
}

