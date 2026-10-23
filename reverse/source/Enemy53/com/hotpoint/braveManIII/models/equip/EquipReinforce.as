package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class EquipReinforce
   {
      
      private var _level:VT;
      
      private var _attribType:VT;
      
      private var _attribValues:VT;
      
      public function EquipReinforce()
      {
         super();
      }
      
      public static function createEquipReinforce(level:Number, attribType:Number, attribValues:Number) : EquipReinforce
      {
         var equipReinforce:EquipReinforce = new EquipReinforce();
         equipReinforce._level = VT.createVT(level);
         equipReinforce._attribType = VT.createVT(attribType);
         equipReinforce._attribValues = VT.createVT(attribValues);
         return equipReinforce;
      }
      
      public function get level() : VT
      {
         return this._level;
      }
      
      public function set level(value:VT) : void
      {
         this._level = value;
      }
      
      public function get attribType() : VT
      {
         return this._attribType;
      }
      
      public function set attribType(value:VT) : void
      {
         this._attribType = value;
      }
      
      public function get attribValues() : VT
      {
         return this._attribValues;
      }
      
      public function set attribValues(value:VT) : void
      {
         this._attribValues = value;
      }
      
      public function getLevel() : int
      {
         return this._level.getValue();
      }
      
      public function setLevel(level:Number) : void
      {
         this._level.setValue(level);
      }
      
      public function getAttribType() : int
      {
         return this._attribType.getValue();
      }
      
      public function setAttribType(type:Number) : *
      {
         this._attribType.setValue(type);
      }
      
      public function getAttribValues() : int
      {
         return this._attribValues.getValue();
      }
      
      public function setAttribValues(val:Number) : *
      {
         this._attribValues.setValue(val);
      }
   }
}

