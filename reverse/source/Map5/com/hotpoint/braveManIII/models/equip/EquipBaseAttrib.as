package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
   public class EquipBaseAttrib
   {
      
      private var _attribType:VT;
      
      private var _value:VT;
      
      private var _colorType:VT;
      
      public function EquipBaseAttrib()
      {
         super();
      }
      
      public static function creatEquipBaseAttrib(param1:Number, param2:Number, param3:Number) : EquipBaseAttrib
      {
         var _loc4_:EquipBaseAttrib = null;
         _loc4_ = new EquipBaseAttrib();
         _loc4_._colorType = VT.createVT(param1);
         _loc4_._attribType = VT.createVT(param2);
         _loc4_._value = VT.createVT(param3);
         return _loc4_;
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
      
      public function getAttribType() : Number
      {
         return _attribType.getValue();
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _attribType;
      }
      
      public function getColorType() : Number
      {
         return _colorType.getValue();
      }
      
      public function get value() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function setValue(param1:Number) : void
      {
         _value.setValue(param1);
      }
      
      public function set colorType(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _colorType = param1;
      }
      
      public function getValue() : Number
      {
         return _value.getValue();
      }
      
      public function get colorType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _colorType;
      }
      
      public function getClone() : EquipBaseAttrib
      {
         return EquipBaseAttrib.creatEquipBaseAttrib(_colorType.getValue(),_attribType.getValue(),_value.getValue());
      }
   }
}

