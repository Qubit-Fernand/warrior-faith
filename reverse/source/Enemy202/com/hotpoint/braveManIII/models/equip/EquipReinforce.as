package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
   public class EquipReinforce
   {
      
      private var _level:VT;
      
      private var _attribType:VT;
      
      private var _attribValues:VT;
      
      public function EquipReinforce()
      {
         super();
      }
      
      public static function createEquipReinforce(param1:Number, param2:Number, param3:Number) : EquipReinforce
      {
         var _loc4_:EquipReinforce = new EquipReinforce();
         _loc4_._level = VT.createVT(param1);
         _loc4_._attribType = VT.createVT(param2);
         _loc4_._attribValues = VT.createVT(param3);
         return _loc4_;
      }
      
      public function get level() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._level;
      }
      
      public function set level(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._level = param1;
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
      
      public function get attribValues() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._attribValues;
      }
      
      public function set attribValues(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._attribValues = param1;
      }
      
      public function getLevel() : int
      {
         return this._level.getValue();
      }
      
      public function setLevel(param1:Number) : void
      {
         this._level.setValue(param1);
      }
      
      public function getAttribType() : int
      {
         return this._attribType.getValue();
      }
      
      public function setAttribType(param1:Number) : *
      {
         this._attribType.setValue(param1);
      }
      
      public function getAttribValues() : int
      {
         return this._attribValues.getValue();
      }
      
      public function setAttribValues(param1:Number) : *
      {
         this._attribValues.setValue(param1);
      }
   }
}

