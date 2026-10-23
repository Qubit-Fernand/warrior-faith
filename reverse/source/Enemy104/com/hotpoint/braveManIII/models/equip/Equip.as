package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.utils.*;
   
   public class Equip
   {
      
      private var _baseAttrib:Array = [];
      
      private var _gemSlot:Gem;
      
      private var _base:VT;
      
      private var _skillAttrib:VT;
      
      private var _reinforceAttrib:EquipReinforce;
      
      private var _gemGrid:VT;
      
      public function Equip()
      {
         super();
      }
      
      public static function creatEquip(baseId:Number, baseAttrib:Array, skillAttrib:Number, grid:Number) : Equip
      {
         var equip:Equip = null;
         equip = new Equip();
         equip._base = VT.createVT(baseId);
         equip._baseAttrib = baseAttrib;
         equip._skillAttrib = VT.createVT(skillAttrib);
         equip._gemGrid = VT.createVT(grid);
         equip._reinforceAttrib = EquipReinforce.createEquipReinforce(0,0,0);
         return equip;
      }
      
      public function getDescript() : String
      {
         return EquipFactory.findDescript(_base.getValue());
      }
      
      public function getDressLevel() : Number
      {
         return EquipFactory.findDressLevel(_base.getValue());
      }
      
      public function getHPRengn() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.HPREGEN);
      }
      
      public function set skillAttrib(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillAttrib = value;
      }
      
      public function getName() : String
      {
         return EquipFactory.findName(_base.getValue());
      }
      
      public function getDefense() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function get reinforceAttrib() : EquipReinforce
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _reinforceAttrib;
      }
      
      public function getHardValue() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function changeReinforce(level:Number, attribType:uint, value:uint) : void
      {
         _reinforceAttrib.setLevel(level);
         _reinforceAttrib.setAttribType(attribType);
         _reinforceAttrib.setAttribValues(_reinforceAttrib.getAttribValues() + value);
      }
      
      public function getPrice() : Number
      {
         return EquipFactory.findPrice(_base.getValue());
      }
      
      public function getOutGem() : Gem
      {
         if(_gemGrid.getValue() == 0)
         {
            _gemGrid.setValue(1);
            return _gemSlot;
         }
         return null;
      }
      
      public function getWhiteAttack() : Number
      {
         var count:Number = NaN;
         var baseAttrib:EquipBaseAttrib = null;
         count = 0;
         for each(baseAttrib in _baseAttrib)
         {
            if(baseAttrib.getColorType() == 1 && baseAttrib.getAttribType() == EquipBaseAttribTypeConst.ATTACK)
            {
               count += baseAttrib.getValue();
            }
         }
         return count;
      }
      
      public function get skillAttrib() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _skillAttrib;
      }
      
      public function getPosition() : Number
      {
         return EquipFactory.findPosition(_base.getValue());
      }
      
      public function getEquipSkillAttrib() : String
      {
         return SkillFactory.getSkillById(getSkillAttrib()).getIntroduction();
      }
      
      public function set base(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _base = value;
      }
      
      private function countEquipAllAttrib(attribType:Number) : Number
      {
         var count:Number = NaN;
         var baseAttrib:EquipBaseAttrib = null;
         var attrib:Attribute = null;
         count = 0;
         for each(baseAttrib in _baseAttrib)
         {
            if(baseAttrib.getAttribType() == attribType)
            {
               count += baseAttrib.getValue();
            }
         }
         if(_reinforceAttrib.getLevel() > 0 && _reinforceAttrib.getAttribType() == attribType)
         {
            count += _reinforceAttrib.getAttribValues();
         }
         if(_gemGrid.getValue() == 0 && this._gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(attrib in _gemSlot.getGemAttrib())
            {
               if(attrib.getAttribType() == attribType)
               {
                  count += attrib.getValue();
               }
            }
         }
         return count;
      }
      
      public function getDropLevel() : Number
      {
         return EquipFactory.findDropLevel(_base.getValue());
      }
      
      public function getClone() : Equip
      {
         return Equip.creatEquip(this._base.getValue(),this._baseAttrib,this._skillAttrib.getValue(),this._gemGrid.getValue());
      }
      
      public function setInGem(gg:Gem) : Boolean
      {
         if(_gemGrid.getValue() == 1)
         {
            this._gemSlot = gg;
            _gemGrid.setValue(0);
            return true;
         }
         return false;
      }
      
      public function getColor() : Number
      {
         return EquipFactory.findColor(_base.getValue());
      }
      
      public function getDuck() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function get gemGrid() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemGrid;
      }
      
      public function getFrame() : Number
      {
         return EquipFactory.findFrame(_base.getValue());
      }
      
      public function getGrid() : Number
      {
         return _gemGrid.getValue();
      }
      
      public function getAttack() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getMoveSpeed() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getGemSlot() : Gem
      {
         return _gemSlot;
      }
      
      public function showReinforceAttrib() : String
      {
         return EquipBaseAttribTypeConst.getDescription(_reinforceAttrib.getAttribType(),_reinforceAttrib.getAttribValues());
      }
      
      public function getMPRengn() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.MPREGEN);
      }
      
      public function getGemAttrib() : Array
      {
         var arr:Array = null;
         var attrib:Attribute = null;
         arr = [];
         if(_gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(attrib in _gemSlot.getGemAttrib())
            {
               arr.push(EquipBaseAttribTypeConst.getDescription(attrib.getAttribType(),attrib.getValue()));
            }
         }
         return arr;
      }
      
      public function getSkillAttrib() : Number
      {
         return _skillAttrib.getValue();
      }
      
      public function getCrit() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function get base() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _base;
      }
      
      public function compareById(id:Number) : Boolean
      {
         if(this._base.getValue() == id)
         {
            return true;
         }
         return false;
      }
      
      public function showBaseAttrib() : Array
      {
         var allAttrib:Array = null;
         var baseAttrib:EquipBaseAttrib = null;
         allAttrib = [];
         for each(baseAttrib in _baseAttrib)
         {
            allAttrib.push([baseAttrib.getColorType(),EquipBaseAttribTypeConst.getDescription(baseAttrib.getAttribType(),baseAttrib.getValue())]);
         }
         return allAttrib;
      }
      
      public function set gemSlot(value:Gem) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemSlot = value;
      }
      
      public function getHP() : Number
      {
         var hp:Number = NaN;
         return Number(countEquipAllAttrib(EquipBaseAttribTypeConst.HP));
      }
      
      public function getReinforceLevel() : Number
      {
         return _reinforceAttrib.getLevel();
      }
      
      public function set gemGrid(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemGrid = value;
      }
      
      public function get gemSlot() : Gem
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemSlot;
      }
      
      public function getReincarnationLimit() : Number
      {
         return EquipFactory.findReincarnationLimit(_base.getValue());
      }
      
      public function getAttackIgnoreDefense() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
      
      public function getIsStrengthen() : Boolean
      {
         return EquipFactory.findIsStrengthen(_base.getValue());
      }
      
      public function getClassName() : String
      {
         return EquipFactory.findClassName(_base.getValue());
      }
      
      public function getMP() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function set reinforceAttrib(value:EquipReinforce) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _reinforceAttrib = value;
      }
      
      public function get baseAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _baseAttrib;
      }
      
      public function set baseAttrib(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _baseAttrib = value;
      }
      
      public function getSuitId() : Number
      {
         return EquipFactory.findSuitId(_base.getValue());
      }
   }
}

