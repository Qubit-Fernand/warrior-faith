package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.gem.Gem;
   import flash.utils.*;
   
   public class EquipSkillSlot
   {
      
      private var _skillSlot:Array = new Array();
      
      public function EquipSkillSlot()
      {
         super();
      }
      
      public static function createEquipSkillSlot() : EquipSkillSlot
      {
         var _loc1_:EquipSkillSlot = null;
         var _loc2_:int = 0;
         _loc1_ = new EquipSkillSlot();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_._skillSlot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addToSkillSlot(param1:Gem, param2:Number) : Boolean
      {
         if(_skillSlot[param2] == null)
         {
            _skillSlot[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function delSkillSlot(param1:Number) : Gem
      {
         var _loc2_:Gem = null;
         if(_skillSlot[param1] != null)
         {
            _loc2_ = _skillSlot[param1];
            _skillSlot[param1] = null;
         }
         return _loc2_;
      }
      
      public function set skillSlot(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillSlot = param1;
      }
      
      public function getGemFromSkillSlot(param1:Number) : Gem
      {
         if(_skillSlot[param1] != null)
         {
            return _skillSlot[param1];
         }
         return null;
      }
      
      public function get skillSlot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _skillSlot;
      }
   }
}

