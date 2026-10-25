package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.gem.Gem;
   
   public class EquipSkillSlot
   {
      
      private var _skillSlot:Array = new Array();
      
      public function EquipSkillSlot()
      {
         super();
      }
      
      public static function createEquipSkillSlot() : EquipSkillSlot
      {
         var ess:EquipSkillSlot = new EquipSkillSlot();
         for(var i:int = 0; i < 3; i++)
         {
            ess._skillSlot[i] = null;
         }
         return ess;
      }
      
      public function get skillSlot() : Array
      {
         return _skillSlot;
      }
      
      public function set skillSlot(value:Array) : void
      {
         _skillSlot = value;
      }
      
      public function getGemFromSkillSlot(num:Number) : Gem
      {
         if(_skillSlot[num] != null)
         {
            return _skillSlot[num];
         }
         return null;
      }
      
      public function addToSkillSlot(value:Gem, num:Number) : Boolean
      {
         if(_skillSlot[num] == null)
         {
            _skillSlot[num] = value;
            return true;
         }
         return false;
      }
      
      public function delSkillSlot(num:Number) : Gem
      {
         var gem:Gem = null;
         if(_skillSlot[num] != null)
         {
            gem = _skillSlot[num];
            _skillSlot[num] = null;
         }
         return gem;
      }
   }
}

