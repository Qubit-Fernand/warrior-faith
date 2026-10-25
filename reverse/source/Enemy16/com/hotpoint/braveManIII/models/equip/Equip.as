package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.utils.*;
   import src.*;
   
   public class Equip
   {
      
      private var _base:VT;
      
      private var _baseAttrib:Array = [];
      
      private var _blessAttrib:EquipBaseAttrib = null;
      
      private var _skillAttrib:VT;
      
      private var _newSkill:VT = VT.createVT(0);
      
      private var _reinforceAttrib:EquipReinforce;
      
      private var _gemSlot:Gem;
      
      private var _gemGrid:VT;
      
      private var _createTime:Date = null;
      
      private var _remainingTime:VT = VT.createVT(1);
      
      public function Equip()
      {
         super();
      }
      
      public static function creatEquip(param1:Number, param2:Array, param3:Number, param4:Number) : Equip
      {
         var _loc5_:Equip = new Equip();
         _loc5_._base = VT.createVT(param1);
         _loc5_._baseAttrib = param2;
         _loc5_._skillAttrib = VT.createVT(param3);
         _loc5_._gemGrid = VT.createVT(param4);
         _loc5_._reinforceAttrib = EquipReinforce.createEquipReinforce(0,0,0);
         _loc5_.setSysTime(Main.serverTime);
         _loc5_.setRemainingTimeNow();
         return _loc5_;
      }
      
      public function get gemGrid() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemGrid;
      }
      
      public function set gemGrid(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemGrid = param1;
      }
      
      public function get base() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _base;
      }
      
      public function set base(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _base = param1;
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
      
      public function get skillAttrib() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _skillAttrib;
      }
      
      public function set skillAttrib(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillAttrib = param1;
      }
      
      public function get reinforceAttrib() : EquipReinforce
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _reinforceAttrib;
      }
      
      public function set reinforceAttrib(param1:EquipReinforce) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _reinforceAttrib = param1;
      }
      
      public function get gemSlot() : Gem
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemSlot;
      }
      
      public function set gemSlot(param1:Gem) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemSlot = param1;
      }
      
      public function get newSkill() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _newSkill;
      }
      
      public function set newSkill(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _newSkill = param1;
      }
      
      public function get createTime() : Date
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _createTime;
      }
      
      public function set createTime(param1:Date) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _createTime = param1;
      }
      
      public function get remainingTime() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _remainingTime;
      }
      
      public function set remainingTime(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _remainingTime = param1;
      }
      
      public function get blessAttrib() : EquipBaseAttrib
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _blessAttrib;
      }
      
      public function set blessAttrib(param1:EquipBaseAttrib) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _blessAttrib = param1;
      }
      
      public function getId() : Number
      {
         return _base.getValue();
      }
      
      public function getPosition() : Number
      {
         return EquipFactory.findPosition(_base.getValue());
      }
      
      public function getFrame() : Number
      {
         return EquipFactory.findFrame(_base.getValue());
      }
      
      public function getDropLevel() : Number
      {
         return EquipFactory.findDropLevel(_base.getValue());
      }
      
      public function getDressLevel() : Number
      {
         return EquipFactory.findDressLevel(_base.getValue());
      }
      
      public function getName() : String
      {
         return EquipFactory.findName(_base.getValue());
      }
      
      public function getClassName() : String
      {
         return EquipFactory.findClassName(_base.getValue());
      }
      
      public function getClassName2() : String
      {
         return EquipFactory.findClassName2(_base.getValue());
      }
      
      public function getDescript() : String
      {
         return EquipFactory.findDescript(_base.getValue());
      }
      
      public function getPrice() : Number
      {
         return EquipFactory.findPrice(_base.getValue());
      }
      
      public function getReincarnationLimit() : Number
      {
         return EquipFactory.findReincarnationLimit(_base.getValue());
      }
      
      public function getColor() : Number
      {
         return EquipFactory.findColor(_base.getValue());
      }
      
      public function getIsStrengthen() : Boolean
      {
         return EquipFactory.findIsStrengthen(_base.getValue());
      }
      
      public function getGrid() : Number
      {
         return _gemGrid.getValue();
      }
      
      public function getSuitId() : Number
      {
         return EquipFactory.findSuitId(_base.getValue());
      }
      
      public function getStar() : Number
      {
         return EquipFactory.findStar(_base.getValue());
      }
      
      public function getJinHua() : Number
      {
         return EquipFactory.findJinHua(_base.getValue());
      }
      
      public function getHP() : Number
      {
         return Number(countEquipAllAttrib(EquipBaseAttribTypeConst.HP));
      }
      
      public function getMP() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAttack() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getWhiteAttack() : Number
      {
         var _loc2_:EquipBaseAttrib = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in _baseAttrib)
         {
            if(_loc2_.getColorType() == 1 && _loc2_.getAttribType() == EquipBaseAttribTypeConst.ATTACK)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
      
      public function getAttackIgnoreDefense() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
      
      public function getDefense() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getMoveSpeed() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getCrit() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getDuck() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function getHPRengn() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.HPREGEN);
      }
      
      public function getMPRengn() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.MPREGEN);
      }
      
      public function getHardValue() : Number
      {
         return countEquipAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getReinforceLevel() : Number
      {
         return _reinforceAttrib.getLevel();
      }
      
      public function reinforceClear() : *
      {
         _reinforceAttrib.setAttribType(0);
         _reinforceAttrib.setAttribValues(0);
         _reinforceAttrib.setLevel(0);
      }
      
      public function getDefaultTime() : Number
      {
         trace(EquipFactory.findDefaultTime(_base.getValue()));
         return EquipFactory.findDefaultTime(_base.getValue());
      }
      
      public function getRemainingTime() : Number
      {
         if(getPosition() < 8 && _remainingTime.getValue() <= 0)
         {
            _remainingTime.setValue(1);
         }
         return _remainingTime.getValue();
      }
      
      public function setRemainingTimeNow() : *
      {
         _remainingTime.setValue(getDefaultTime());
      }
      
      public function setRemainingTime(param1:VT) : *
      {
         var _loc12_:int = 0;
         var _loc2_:int = param1.getValue();
         var _loc3_:String = String(_loc2_);
         var _loc4_:String = _loc3_.substr(0,4);
         var _loc5_:String = _loc3_.substr(4,2);
         var _loc6_:String = _loc3_.substr(6,2);
         var _loc7_:int = new int(_loc4_);
         var _loc8_:int = new int(_loc5_);
         var _loc9_:int = new int(_loc6_);
         var _loc10_:Date = getSysTime();
         var _loc11_:Date = new Date(_loc7_,_loc8_ - 1,_loc9_);
         if(_loc11_.getTime() >= _loc10_.getTime())
         {
            _loc12_ = Math.floor((_loc11_.getTime() - _loc10_.getTime()) / (1000 * 24 * 60 * 60));
            _loc12_ = getDefaultTime() - _loc12_;
            if(_loc12_ < 0)
            {
               _loc12_ = 0;
            }
            _remainingTime.setValue(_loc12_);
         }
      }
      
      public function setSysTime(param1:VT) : *
      {
         var _loc2_:int = param1.getValue();
         if(_loc2_ <= 18991231)
         {
            _createTime = new Date();
            return;
         }
         var _loc3_:String = String(_loc2_);
         var _loc4_:String = _loc3_.substr(0,4);
         var _loc5_:String = _loc3_.substr(4,2);
         var _loc6_:String = _loc3_.substr(6,2);
         var _loc7_:int = new int(_loc4_);
         var _loc8_:int = new int(_loc5_);
         var _loc9_:int = new int(_loc6_);
         _createTime = new Date(_loc7_,_loc8_ - 1,_loc9_);
      }
      
      public function getSysTime() : Date
      {
         if(_createTime == null)
         {
            setSysTime(Main.serverTime);
         }
         return _createTime;
      }
      
      public function changeReinforce(param1:Number, param2:uint, param3:uint) : void
      {
         _reinforceAttrib.setLevel(param1);
         _reinforceAttrib.setAttribType(param2);
         _reinforceAttrib.setAttribValues(_reinforceAttrib.getAttribValues() + param3);
      }
      
      public function showBlessAttrib() : String
      {
         return EquipBaseAttribTypeConst.getDescription(_blessAttrib.getAttribType(),_blessAttrib.getValue());
      }
      
      public function getBlessAttrib() : Boolean
      {
         if(_blessAttrib)
         {
            return true;
         }
         return false;
      }
      
      public function setBlessAttrib() : *
      {
         var _loc1_:Array = EquipFactory.findBlessAttrib(_base.getValue());
         var _loc2_:int = int(getRandomType());
         _blessAttrib = _loc1_[_loc2_];
      }
      
      private function getRandomType() : uint
      {
         var _loc1_:* = Math.random() * 100;
         if(_loc1_ >= 0 && _loc1_ < 22)
         {
            return 0;
         }
         if(_loc1_ >= 22 && _loc1_ < 44)
         {
            return 1;
         }
         if(_loc1_ >= 44 && _loc1_ < 66)
         {
            return 2;
         }
         if(_loc1_ >= 66 && _loc1_ < 83)
         {
            return 3;
         }
         return 4;
      }
      
      public function showBaseAttrib() : Array
      {
         var _loc2_:EquipBaseAttrib = null;
         var _loc1_:Array = [];
         for each(_loc2_ in _baseAttrib)
         {
            _loc1_.push([_loc2_.getColorType(),EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue())]);
         }
         return _loc1_;
      }
      
      public function showReinforceAttrib() : String
      {
         return EquipBaseAttribTypeConst.getDescription(_reinforceAttrib.getAttribType(),_reinforceAttrib.getAttribValues());
      }
      
      public function getEquipSkillAttrib() : String
      {
         return SkillFactory.getSkillById(getSkillAttrib()).getIntroduction();
      }
      
      public function getEquipNewSkill() : String
      {
         return SkillFactory.getSkillById(getNewSkill()).getIntroduction();
      }
      
      public function setInGem(param1:Gem) : Boolean
      {
         if(_gemGrid.getValue() == 1 || gemGrid.getValue() == 0)
         {
            this._gemSlot = param1;
            _gemGrid.setValue(0);
            return true;
         }
         return false;
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
      
      public function getGemAttrib() : Array
      {
         var _loc2_:Attribute = null;
         var _loc1_:Array = [];
         if(_gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(_loc2_ in _gemSlot.getGemAttrib())
            {
               _loc1_.push(EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue()));
            }
         }
         return _loc1_;
      }
      
      private function countEquipAllAttrib(param1:Number) : Number
      {
         var _loc3_:EquipBaseAttrib = null;
         var _loc4_:Attribute = null;
         var _loc2_:Number = 0;
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
         if(_blessAttrib)
         {
            if(_blessAttrib.getAttribType() == param1)
            {
               _loc2_ += _blessAttrib.getValue();
            }
         }
         return _loc2_;
      }
      
      public function getSkillAttrib() : Number
      {
         return _skillAttrib.getValue();
      }
      
      public function getNewSkill() : Number
      {
         return _newSkill.getValue();
      }
      
      public function setNewSkill(param1:Number) : *
      {
         _newSkill.setValue(param1);
      }
      
      public function getGemSlot() : Gem
      {
         return _gemSlot;
      }
      
      public function jinhuaEquip() : Equip
      {
         var _loc1_:Equip = null;
         _loc1_ = EquipFactory.createEquipByID(getJinHua());
         _loc1_._reinforceAttrib = _reinforceAttrib;
         _loc1_._gemGrid = _gemGrid;
         _loc1_._gemSlot = _gemSlot;
         _loc1_._blessAttrib = _blessAttrib;
         _loc1_._newSkill = _newSkill;
         return _loc1_;
      }
      
      public function reCreatEquip() : Equip
      {
         var _loc1_:Equip = null;
         _loc1_ = EquipFactory.createEquipByID(_base.getValue());
         _loc1_._gemGrid = _gemGrid;
         _loc1_._gemSlot = _gemSlot;
         _loc1_._newSkill = _newSkill;
         _loc1_._reinforceAttrib = _reinforceAttrib;
         _loc1_._skillAttrib = _skillAttrib;
         _loc1_._blessAttrib = _blessAttrib;
         return _loc1_;
      }
      
      public function upStarEquip() : Equip
      {
         var _loc1_:Equip = null;
         var _loc2_:* = 0;
         _loc1_ = EquipFactory.createEquipByID(getReincarnationLimit());
         if(_loc1_._baseAttrib)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_._baseAttrib.length)
            {
               if((_loc1_._baseAttrib[_loc2_] as EquipBaseAttrib).getColorType() == 3)
               {
                  _loc1_._baseAttrib.splice(_loc2_,1);
                  _loc2_--;
               }
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _baseAttrib.length)
            {
               if((_baseAttrib[_loc2_] as EquipBaseAttrib).getColorType() == 3)
               {
                  _loc1_._baseAttrib.push(_baseAttrib[_loc2_]);
               }
               _loc2_++;
            }
         }
         _loc1_._gemGrid = _gemGrid;
         _loc1_._gemSlot = _gemSlot;
         _loc1_._newSkill = _newSkill;
         _loc1_._reinforceAttrib = _reinforceAttrib;
         _loc1_._blessAttrib = _blessAttrib;
         return _loc1_;
      }
      
      public function getClone() : Equip
      {
         return Equip.creatEquip(this._base.getValue(),this._baseAttrib,this._skillAttrib.getValue(),this._gemGrid.getValue());
      }
      
      public function compareById(param1:Number) : Boolean
      {
         if(this._base.getValue() == param1)
         {
            return true;
         }
         return false;
      }
      
      public function testEquip(param1:Equip) : Boolean
      {
         if(this == param1)
         {
            return true;
         }
         return false;
      }
   }
}

