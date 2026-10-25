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
         return _level;
      }
      
      public function set level(param1:VT) : void
      {
         _level = param1;
      }
      
      public function get attribType() : VT
      {
         return _attribType;
      }
      
      public function set attribType(param1:VT) : void
      {
         _attribType = param1;
      }
      
      public function get attribValues() : VT
      {
         return _attribValues;
      }
      
      public function set attribValues(param1:VT) : void
      {
         _attribValues = param1;
      }
      
      public function getLevel() : int
      {
         return _level.getValue();
      }
      
      public function setLevel(param1:Number) : void
      {
         _level.setValue(param1);
      }
      
      public function getAttribType() : int
      {
         return _attribType.getValue();
      }
      
      public function setAttribType(param1:Number) : *
      {
         _attribType.setValue(param1);
      }
      
      public function getAttribValues() : int
      {
         return _attribValues.getValue();
      }
      
      public function setAttribValues(param1:Number) : *
      {
         _attribValues.setValue(param1);
      }
   }
}

