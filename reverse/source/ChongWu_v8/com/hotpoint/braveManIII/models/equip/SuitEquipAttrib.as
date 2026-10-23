package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   
   public class SuitEquipAttrib
   {
      
      private var _suitId:VT;
      
      private var _skillAttrib:Array = [];
      
      private var _baseAttrib:Array = [];
      
      public function SuitEquipAttrib()
      {
         super();
      }
      
      public static function creatSuitEquipAttrib(param1:Number, param2:Array, param3:Array) : SuitEquipAttrib
      {
         var _loc4_:SuitEquipAttrib = new SuitEquipAttrib();
         _loc4_._suitId = VT.createVT(param1);
         _loc4_._skillAttrib = param2;
         _loc4_._baseAttrib = param3;
         return _loc4_;
      }
      
      public function get suitId() : VT
      {
         return _suitId;
      }
      
      public function set suitId(param1:VT) : void
      {
         _suitId = param1;
      }
      
      public function get skillAttrib() : Array
      {
         return _skillAttrib;
      }
      
      public function set skillAttrib(param1:Array) : void
      {
         _skillAttrib = param1;
      }
      
      public function get baseAttrib() : Array
      {
         return _baseAttrib;
      }
      
      public function set baseAttrib(param1:Array) : void
      {
         _baseAttrib = param1;
      }
      
      public function getSuitId() : Number
      {
         return _suitId.getValue();
      }
      
      public function getSuitSkillAttrib() : Array
      {
         var _loc2_:Number = NaN;
         var _loc1_:Array = [];
         for each(_loc2_ in _skillAttrib)
         {
            _loc1_.push(SkillFactory.getSkillById(_loc2_).getIntroduction());
         }
         return _loc1_;
      }
      
      public function getSuitBaseAttrib() : Array
      {
         var _loc2_:EquipBaseAttrib = null;
         var _loc1_:Array = [];
         for each(_loc2_ in _baseAttrib)
         {
            _loc1_.push(EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue()));
         }
         return _loc1_;
      }
      
      public function getSuitAttrib() : Array
      {
         return _baseAttrib.slice();
      }
      
      public function getSuitSkill() : Array
      {
         return _skillAttrib.slice();
      }
   }
}

