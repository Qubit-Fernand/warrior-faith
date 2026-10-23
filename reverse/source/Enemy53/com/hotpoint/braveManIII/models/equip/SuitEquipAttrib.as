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
      
      public static function creatSuitEquipAttrib(suitId:Number, skillAttrib:Array, baseAttrib:Array) : SuitEquipAttrib
      {
         var suitEquipAttrib:SuitEquipAttrib = new SuitEquipAttrib();
         suitEquipAttrib._suitId = VT.createVT(suitId);
         suitEquipAttrib._skillAttrib = skillAttrib;
         suitEquipAttrib._baseAttrib = baseAttrib;
         return suitEquipAttrib;
      }
      
      public function get suitId() : VT
      {
         return this._suitId;
      }
      
      public function set suitId(value:VT) : void
      {
         this._suitId = value;
      }
      
      public function get skillAttrib() : Array
      {
         return this._skillAttrib;
      }
      
      public function set skillAttrib(value:Array) : void
      {
         this._skillAttrib = value;
      }
      
      public function get baseAttrib() : Array
      {
         return this._baseAttrib;
      }
      
      public function set baseAttrib(value:Array) : void
      {
         this._baseAttrib = value;
      }
      
      public function getSuitId() : Number
      {
         return this._suitId.getValue();
      }
      
      public function getSuitSkillAttrib() : Array
      {
         var sk:Number = NaN;
         var suitSkill:Array = [];
         for each(sk in this._skillAttrib)
         {
            suitSkill.push(SkillFactory.getSkillById(sk).getIntroduction());
         }
         return suitSkill;
      }
      
      public function getSuitBaseAttrib() : Array
      {
         var baseAttrib:EquipBaseAttrib = null;
         var suitAttrib:Array = [];
         for each(baseAttrib in this._baseAttrib)
         {
            suitAttrib.push(EquipBaseAttribTypeConst.getDescription(baseAttrib.getAttribType(),baseAttrib.getValue()));
         }
         return suitAttrib;
      }
      
      public function getSuitAttrib() : Array
      {
         return this._baseAttrib.slice();
      }
      
      public function getSuitSkill() : Array
      {
         return this._skillAttrib.slice();
      }
   }
}

