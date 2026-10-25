package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
   public class EquipReinforce
   {
      
      private var _attribType:VT;
      
      private var _level:VT;
      
      private var _attribValues:VT;
      
      public function EquipReinforce()
      {
         super();
      }
      
      public static function createEquipReinforce(param1:Number, param2:Number, param3:Number) : EquipReinforce
      {
         var _loc4_:EquipReinforce = null;
         _loc4_ = new EquipReinforce();
         _loc4_._level = VT.createVT(param1);
         _loc4_._attribType = VT.createVT(param2);
         _loc4_._attribValues = VT.createVT(param3);
         return _loc4_;
      }
      
      public function setLevel(param1:Number) : void
      {
         _level.setValue(param1);
      }
      
      public function get level() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _level;
      }
      
      public function set level(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _level = param1;
      }
      
      public function getAttribValues() : int
      {
         return _attribValues.getValue();
      }
      
      public function get attribValues() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _attribValues;
      }
      
      public function setAttribType(param1:Number) : *
      {
         _attribType.setValue(param1);
      }
      
      public function getLevel() : int
      {
         return _level.getValue();
      }
      
      public function get attribType() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _attribType;
      }
      
      public function setAttribValues(param1:Number) : *
      {
         _attribValues.setValue(param1);
      }
      
      public function set attribType(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _attribType = param1;
      }
      
      public function set attribValues(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _attribValues = param1;
      }
      
      public function getAttribType() : int
      {
         return _attribType.getValue();
      }
   }
}

