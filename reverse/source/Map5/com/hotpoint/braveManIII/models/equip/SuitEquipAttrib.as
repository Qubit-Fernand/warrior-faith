package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.utils.*;
   
   public class SuitEquipAttrib
   {
      
      private var _suitId:VT;
      
      private var _baseAttrib:Array = [];
      
      private var _skillAttrib:Array = [];
      
      public function SuitEquipAttrib()
      {
         super();
      }
      
      public static function creatSuitEquipAttrib(param1:Number, param2:Array, param3:Array) : SuitEquipAttrib
      {
         var _loc4_:SuitEquipAttrib = null;
         _loc4_ = new SuitEquipAttrib();
         _loc4_._suitId = VT.createVT(param1);
         _loc4_._skillAttrib = param2;
         _loc4_._baseAttrib = param3;
         return _loc4_;
      }
      
      public function get baseAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _baseAttrib;
      }
      
      public function getSuitBaseAttrib() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:EquipBaseAttrib = null;
         _loc1_ = [];
         for each(_loc2_ in _baseAttrib)
         {
            _loc1_.push(EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue()));
         }
         return _loc1_;
      }
      
      public function getSuitSkill() : Array
      {
         return _skillAttrib.slice();
      }
      
      public function get suitId() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suitId;
      }
      
      public function getSuitAttrib() : Array
      {
         return _baseAttrib.slice();
      }
      
      public function set suitId(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suitId = param1;
      }
      
      public function set skillAttrib(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillAttrib = param1;
      }
      
      public function get skillAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _skillAttrib;
      }
      
      public function set baseAttrib(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _baseAttrib = param1;
      }
      
      public function getSuitId() : Number
      {
         return _suitId.getValue();
      }
      
      public function getSuitSkillAttrib() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Number = NaN;
         _loc1_ = [];
         for each(_loc2_ in _skillAttrib)
         {
            _loc1_.push(SkillFactory.getSkillById(_loc2_).getIntroduction());
         }
         return _loc1_;
      }
   }
}

