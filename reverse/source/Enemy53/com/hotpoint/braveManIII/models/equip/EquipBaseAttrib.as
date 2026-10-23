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
         return this._colorType;
      }
      
      public function set colorType(value:VT) : void
      {
         this._colorType = value;
      }
      
      public function get attribType() : VT
      {
         return this._attribType;
      }
      
      public function set attribType(value:VT) : void
      {
         this._attribType = value;
      }
      
      public function get value() : VT
      {
         return this._value;
      }
      
      public function set value(value:VT) : void
      {
         this._value = value;
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
      
      public function setValue(value:Number) : void
      {
         this._value.setValue(value);
      }
      
      public function getClone() : EquipBaseAttrib
      {
         return EquipBaseAttrib.creatEquipBaseAttrib(this._colorType.getValue(),this._attribType.getValue(),this._value.getValue());
      }
   }
}

