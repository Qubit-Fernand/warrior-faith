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
      
      public static function creatEquipBaseAttrib(colorType:Number, attribType:Number, value:Number) : EquipBaseAttrib
      {
         var equipBaseAttrib:EquipBaseAttrib = new EquipBaseAttrib();
         equipBaseAttrib._colorType = VT.createVT(colorType);
         equipBaseAttrib._attribType = VT.createVT(attribType);
         equipBaseAttrib._value = VT.createVT(value);
         return equipBaseAttrib;
      }
      
      public function get colorType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _colorType;
      }
      
      public function set colorType(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _colorType = value;
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _attribType;
      }
      
      public function set attribType(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _attribType = value;
      }
      
      public function get value() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function set value(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = value;
      }
      
      public function getColorType() : Number
      {
         return _colorType.getValue();
      }
      
      public function getAttribType() : Number
      {
         return _attribType.getValue();
      }
      
      public function getValue() : Number
      {
         return _value.getValue();
      }
      
      public function setValue(value:Number) : void
      {
         _value.setValue(value);
      }
      
      public function getClone() : EquipBaseAttrib
      {
         return EquipBaseAttrib.creatEquipBaseAttrib(_colorType.getValue(),_attribType.getValue(),_value.getValue());
      }
   }
}

