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
      
      public static function creatSuitEquipAttrib(suitId:Number, skillAttrib:Array, baseAttrib:Array) : SuitEquipAttrib
      {
         var suitEquipAttrib:SuitEquipAttrib = null;
         suitEquipAttrib = new SuitEquipAttrib();
         suitEquipAttrib._suitId = VT.createVT(suitId);
         suitEquipAttrib._skillAttrib = skillAttrib;
         suitEquipAttrib._baseAttrib = baseAttrib;
         return suitEquipAttrib;
      }
      
      public function get baseAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _baseAttrib;
      }
      
      public function getSuitBaseAttrib() : Array
      {
         var suitAttrib:Array = null;
         var baseAttrib:EquipBaseAttrib = null;
         suitAttrib = [];
         for each(baseAttrib in _baseAttrib)
         {
            suitAttrib.push(EquipBaseAttribTypeConst.getDescription(baseAttrib.getAttribType(),baseAttrib.getValue()));
         }
         return suitAttrib;
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
      
      public function set suitId(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suitId = value;
      }
      
      public function set skillAttrib(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillAttrib = value;
      }
      
      public function get skillAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _skillAttrib;
      }
      
      public function set baseAttrib(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _baseAttrib = value;
      }
      
      public function getSuitId() : Number
      {
         return _suitId.getValue();
      }
      
      public function getSuitSkillAttrib() : Array
      {
         var suitSkill:Array = null;
         var sk:Number = NaN;
         suitSkill = [];
         for each(sk in _skillAttrib)
         {
            suitSkill.push(SkillFactory.getSkillById(sk).getIntroduction());
         }
         return suitSkill;
      }
   }
}

