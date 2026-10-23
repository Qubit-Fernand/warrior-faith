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
      
      public static function creatEquip(param1:Number, param2:Array, param3:Number, param4:Number) : Equip
      {
         var _loc5_:Equip = null;
         _loc5_ = new Equip();
         _loc5_._base = VT.createVT(param1);
         _loc5_._baseAttrib = param2;
         _loc5_._skillAttrib = VT.createVT(param3);
         _loc5_._gemGrid = VT.createVT(param4);
         _loc5_._reinforceAttrib = EquipReinforce.createEquipReinforce(0,0,0);
         return _loc5_;
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
      
      public function set skillAttrib(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillAttrib = param1;
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
      
      public function changeReinforce(param1:Number, param2:uint, param3:uint) : void
      {
         _reinforceAttrib.setLevel(param1);
         _reinforceAttrib.setAttribType(param2);
         _reinforceAttrib.setAttribValues(_reinforceAttrib.getAttribValues() + param3);
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
         var _loc1_:Number = NaN;
         var _loc2_:EquipBaseAttrib = null;
         _loc1_ = 0;
         for each(_loc2_ in _baseAttrib)
         {
            if(_loc2_.getColorType() == 1 && _loc2_.getAttribType() == EquipBaseAttribTypeConst.ATTACK)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
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
      
      public function set base(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _base = param1;
      }
      
      private function countEquipAllAttrib(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:EquipBaseAttrib = null;
         var _loc4_:Attribute = null;
         _loc2_ = 0;
         for each(_loc3_ in _baseAttrib)
         {
            if(_loc3_.getAttribType() == param1)
            {
               _loc2_ += _loc3_.getValue();
            }
         }
         if(_reinforceAttrib.getLevel() > 0 && _reinforceAttrib.getAttribType() == param1)
         {
            _loc2_ += _reinforceAttrib.getAttribValues();
         }
         if(_gemGrid.getValue() == 0 && this._gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(_loc4_ in _gemSlot.getGemAttrib())
            {
               if(_loc4_.getAttribType() == param1)
               {
                  _loc2_ += _loc4_.getValue();
               }
            }
         }
         return _loc2_;
      }
      
      public function getDropLevel() : Number
      {
         return EquipFactory.findDropLevel(_base.getValue());
      }
      
      public function getClone() : Equip
      {
         return Equip.creatEquip(this._base.getValue(),this._baseAttrib,this._skillAttrib.getValue(),this._gemGrid.getValue());
      }
      
      public function setInGem(param1:Gem) : Boolean
      {
         if(_gemGrid.getValue() == 1)
         {
            this._gemSlot = param1;
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
         var _loc1_:Array = null;
         var _loc2_:Attribute = null;
         _loc1_ = [];
         if(_gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(_loc2_ in _gemSlot.getGemAttrib())
            {
               _loc1_.push(EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue()));
            }
         }
         return _loc1_;
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
      
      public function showBaseAttrib() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:EquipBaseAttrib = null;
         _loc1_ = [];
         for each(_loc2_ in _baseAttrib)
         {
            _loc1_.push([_loc2_.getColorType(),EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue())]);
         }
         return _loc1_;
      }
      
      public function set gemSlot(param1:Gem) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemSlot = param1;
      }
      
      public function getHP() : Number
      {
         var _loc1_:Number = NaN;
         return Number(countEquipAllAttrib(EquipBaseAttribTypeConst.HP));
      }
      
      public function getReinforceLevel() : Number
      {
         return _reinforceAttrib.getLevel();
      }
      
      public function set gemGrid(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemGrid = param1;
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
      
      public function set reinforceAttrib(param1:EquipReinforce) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _reinforceAttrib = param1;
      }
      
      public function get baseAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _baseAttrib;
      }
      
      public function set baseAttrib(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _baseAttrib = param1;
      }
      
      public function getSuitId() : Number
      {
         return EquipFactory.findSuitId(_base.getValue());
      }
   }
}

