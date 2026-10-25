package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   
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
         return _colorType;
      }
      
      public function set colorType(value:VT) : void
      {
         _colorType = value;
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

