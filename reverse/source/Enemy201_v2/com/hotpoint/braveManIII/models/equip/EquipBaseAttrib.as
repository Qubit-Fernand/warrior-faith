package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
   public class EquipBaseAttrib
   {
      
      private var _colorType:VT;
      
      private var _attribType:VT;
      
      private var _value:VT;
      
      public function EquipBaseAttrib()
      {
         super();
      }
      
      public static function creatEquipBaseAttrib(param1:Number, param2:Number, param3:Number) : EquipBaseAttrib
      {
         var _loc4_:EquipBaseAttrib = new EquipBaseAttrib();
         _loc4_._colorType = VT.createVT(param1);
         _loc4_._attribType = VT.createVT(param2);
         _loc4_._value = VT.createVT(param3);
         return _loc4_;
      }
      
      public function get colorType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._colorType;
      }
      
      public function set colorType(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._colorType = param1;
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
      
      public function getColorType() : Number
      {
         return this._colorType.getValue();
      }
      
      public function getAttribType() : Number
      {
         return this._attribType.getValue();
      }
      
      public function getValue() : Number
      {
         return this._value.getValue();
      }
      
      public function setValue(param1:Number) : void
      {
         this._value.setValue(param1);
      }
      
      public function getClone() : EquipBaseAttrib
      {
         return EquipBaseAttrib.creatEquipBaseAttrib(this._colorType.getValue(),this._attribType.getValue(),this._value.getValue());
      }
   }
}

