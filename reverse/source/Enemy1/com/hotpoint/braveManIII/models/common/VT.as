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
      
      public static function createVT(value:Number = 0) : VT
      {
         var temp:VT = null;
         temp = new VT();
         temp.setValue(value);
         return temp;
      }
      
      public function setValue(value:Number) : void
      {
         var temp:Object = null;
         temp = new Object();
         temp.random = Math.round(Math.random() * 733 + 5) * (Math.round(Math.random()) * 2 - 1);
         temp.num = value + temp.random;
         this._value = temp;
      }
      
      public function get value() : Object
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function set value(value:Object) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = value;
      }
      
      public function getValue() : Number
      {
         var result:Number = NaN;
         return _value.num - _value.random;
      }
   }
}

