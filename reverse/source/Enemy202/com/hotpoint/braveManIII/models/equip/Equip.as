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
      
      private var _createTime:Date;
      
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
         return this._gemGrid;
      }
      
      public function set gemGrid(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gemGrid = param1;
      }
      
      public function get base() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._base;
      }
      
      public function set base(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._base = param1;
      }
      
      public function get baseAttrib() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._baseAttrib;
      }
      
      public function set baseAttrib(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._baseAttrib = param1;
      }
      
      public function get skillAttrib() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._skillAttrib;
      }
      
      public function set skillAttrib(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._skillAttrib = param1;
      }
      
      public function get reinforceAttrib() : EquipReinforce
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._reinforceAttrib;
      }
      
      public function set reinforceAttrib(param1:EquipReinforce) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._reinforceAttrib = param1;
      }
      
      public function get gemSlot() : Gem
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._gemSlot;
      }
      
      public function set gemSlot(param1:Gem) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gemSlot = param1;
      }
      
      public function get newSkill() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._newSkill;
      }
      
      public function set newSkill(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._newSkill = param1;
      }
      
      public function get createTime() : Date
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._createTime;
      }
      
      public function set createTime(param1:Date) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._createTime = param1;
      }
      
      public function get remainingTime() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._remainingTime;
      }
      
      public function set remainingTime(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._remainingTime = param1;
      }
      
      public function get blessAttrib() : EquipBaseAttrib
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._blessAttrib;
      }
      
      public function set blessAttrib(param1:EquipBaseAttrib) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._blessAttrib = param1;
      }
      
      public function getId() : Number
      {
         return this._base.getValue();
      }
      
      public function getPosition() : Number
      {
         return EquipFactory.findPosition(this._base.getValue());
      }
      
      public function getFrame() : Number
      {
         return EquipFactory.findFrame(this._base.getValue());
      }
      
      public function getDropLevel() : Number
      {
         return EquipFactory.findDropLevel(this._base.getValue());
      }
      
      public function getDressLevel() : Number
      {
         return EquipFactory.findDressLevel(this._base.getValue());
      }
      
      public function getName() : String
      {
         return EquipFactory.findName(this._base.getValue());
      }
      
      public function getClassName() : String
      {
         return EquipFactory.findClassName(this._base.getValue());
      }
      
      public function getClassName2() : String
      {
         return EquipFactory.findClassName2(this._base.getValue());
      }
      
      public function getDescript() : String
      {
         return EquipFactory.findDescript(this._base.getValue());
      }
      
      public function getPrice() : Number
      {
         return EquipFactory.findPrice(this._base.getValue());
      }
      
      public function getReincarnationLimit() : Number
      {
         return EquipFactory.findReincarnationLimit(this._base.getValue());
      }
      
      public function getColor() : Number
      {
         return EquipFactory.findColor(this._base.getValue());
      }
      
      public function getIsStrengthen() : Boolean
      {
         return EquipFactory.findIsStrengthen(this._base.getValue());
      }
      
      public function getGrid() : Number
      {
         return this._gemGrid.getValue();
      }
      
      public function getSuitId() : Number
      {
         return EquipFactory.findSuitId(this._base.getValue());
      }
      
      public function getStar() : Number
      {
         return EquipFactory.findStar(this._base.getValue());
      }
      
      public function getHP() : Number
      {
         return Number(this.countEquipAllAttrib(EquipBaseAttribTypeConst.HP));
      }
      
      public function getMP() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.MP);
      }
      
      public function getAttack() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.ATTACK);
      }
      
      public function getWhiteAttack() : Number
      {
         var _loc2_:EquipBaseAttrib = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in this._baseAttrib)
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
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE);
      }
      
      public function getDefense() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.DEFENSE);
      }
      
      public function getMoveSpeed() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.MOVESPEED);
      }
      
      public function getCrit() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.CRIT);
      }
      
      public function getDuck() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.DUCK);
      }
      
      public function getHPRengn() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.HPREGEN);
      }
      
      public function getMPRengn() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.MPREGEN);
      }
      
      public function getHardValue() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.HARDVALUE);
      }
      
      public function getReinforceLevel() : Number
      {
         return this._reinforceAttrib.getLevel();
      }
      
      public function reinforceClear() : *
      {
         this._reinforceAttrib.setAttribType(0);
         this._reinforceAttrib.setAttribValues(0);
         this._reinforceAttrib.setLevel(0);
      }
      
      public function getDefaultTime() : Number
      {
         trace(EquipFactory.findDefaultTime(this._base.getValue()));
         return EquipFactory.findDefaultTime(this._base.getValue());
      }
      
      public function getRemainingTime() : Number
      {
         return this._remainingTime.getValue();
      }
      
      public function setRemainingTimeNow() : *
      {
         this._remainingTime.setValue(this.getDefaultTime());
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
         var _loc10_:Date = this.getSysTime();
         var _loc11_:Date = new Date(_loc7_,_loc8_ - 1,_loc9_);
         if(_loc11_.getTime() >= _loc10_.getTime())
         {
            _loc12_ = Math.floor((_loc11_.getTime() - _loc10_.getTime()) / (1000 * 24 * 60 * 60));
            _loc12_ = this.getDefaultTime() - _loc12_;
            if(_loc12_ < 0)
            {
               _loc12_ = 0;
            }
            this._remainingTime.setValue(_loc12_);
         }
      }
      
      public function setSysTime(param1:VT) : *
      {
         var _loc2_:int = param1.getValue();
         if(_loc2_ <= 18991231)
         {
            this._createTime = new Date();
            return;
         }
         var _loc3_:String = String(_loc2_);
         var _loc4_:String = _loc3_.substr(0,4);
         var _loc5_:String = _loc3_.substr(4,2);
         var _loc6_:String = _loc3_.substr(6,2);
         var _loc7_:int = new int(_loc4_);
         var _loc8_:int = new int(_loc5_);
         var _loc9_:int = new int(_loc6_);
         this._createTime = new Date(_loc7_,_loc8_ - 1,_loc9_);
      }
      
      public function getSysTime() : Date
      {
         return this._createTime;
      }
      
      public function changeReinforce(param1:Number, param2:uint, param3:uint) : void
      {
         this._reinforceAttrib.setLevel(param1);
         this._reinforceAttrib.setAttribType(param2);
         this._reinforceAttrib.setAttribValues(this._reinforceAttrib.getAttribValues() + param3);
      }
      
      public function showBlessAttrib() : String
      {
         return EquipBaseAttribTypeConst.getDescription(this._blessAttrib.getAttribType(),this._blessAttrib.getValue());
      }
      
      public function getBlessAttrib() : Boolean
      {
         if(this._blessAttrib)
         {
            return true;
         }
         return false;
      }
      
      public function setBlessAttrib() : *
      {
         var _loc1_:Array = EquipFactory.findBlessAttrib(this._base.getValue());
         var _loc2_:int = int(this.getRandomType());
         this._blessAttrib = _loc1_[_loc2_];
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
         for each(_loc2_ in this._baseAttrib)
         {
            _loc1_.push([_loc2_.getColorType(),EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue())]);
         }
         return _loc1_;
      }
      
      public function showReinforceAttrib() : String
      {
         return EquipBaseAttribTypeConst.getDescription(this._reinforceAttrib.getAttribType(),this._reinforceAttrib.getAttribValues());
      }
      
      public function getEquipSkillAttrib() : String
      {
         return SkillFactory.getSkillById(this.getSkillAttrib()).getIntroduction();
      }
      
      public function getEquipNewSkill() : String
      {
         return SkillFactory.getSkillById(this.getNewSkill()).getIntroduction();
      }
      
      public function setInGem(param1:Gem) : Boolean
      {
         if(this._gemGrid.getValue() == 1 || this.gemGrid.getValue() == 0)
         {
            this._gemSlot = param1;
            this._gemGrid.setValue(0);
            return true;
         }
         return false;
      }
      
      public function getOutGem() : Gem
      {
         if(this._gemGrid.getValue() == 0)
         {
            this._gemGrid.setValue(1);
            return this._gemSlot;
         }
         return null;
      }
      
      public function getGemAttrib() : Array
      {
         var _loc2_:Attribute = null;
         var _loc1_:Array = [];
         if(this._gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(_loc2_ in this._gemSlot.getGemAttrib())
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
         for each(_loc3_ in this._baseAttrib)
         {
            if(_loc3_.getAttribType() == param1)
            {
               _loc2_ += _loc3_.getValue();
            }
         }
         if(this._reinforceAttrib.getLevel() > 0 && this._reinforceAttrib.getAttribType() == param1)
         {
            _loc2_ += this._reinforceAttrib.getAttribValues();
         }
         if(this._gemGrid.getValue() == 0 && this._gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(_loc4_ in this._gemSlot.getGemAttrib())
            {
               if(_loc4_.getAttribType() == param1)
               {
                  _loc2_ += _loc4_.getValue();
               }
            }
         }
         if(this._blessAttrib)
         {
            if(this._blessAttrib.getAttribType() == param1)
            {
               _loc2_ += this._blessAttrib.getValue();
            }
         }
         return _loc2_;
      }
      
      public function getSkillAttrib() : Number
      {
         return this._skillAttrib.getValue();
      }
      
      public function getNewSkill() : Number
      {
         return this._newSkill.getValue();
      }
      
      public function setNewSkill(param1:Number) : *
      {
         this._newSkill.setValue(param1);
      }
      
      public function getGemSlot() : Gem
      {
         return this._gemSlot;
      }
      
      public function reCreatEquip() : Equip
      {
         var _loc1_:Equip = null;
         _loc1_ = EquipFactory.createEquipByID(this._base.getValue());
         _loc1_._gemGrid = this._gemGrid;
         _loc1_._gemSlot = this._gemSlot;
         _loc1_._newSkill = this._newSkill;
         _loc1_._reinforceAttrib = this._reinforceAttrib;
         _loc1_._skillAttrib = this._skillAttrib;
         _loc1_._blessAttrib = this._blessAttrib;
         return _loc1_;
      }
      
      public function upStarEquip() : Equip
      {
         var _loc1_:Equip = null;
         var _loc2_:* = 0;
         _loc1_ = EquipFactory.createEquipByID(this.getReincarnationLimit());
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
            while(_loc2_ < this._baseAttrib.length)
            {
               if((this._baseAttrib[_loc2_] as EquipBaseAttrib).getColorType() == 3)
               {
                  _loc1_._baseAttrib.push(this._baseAttrib[_loc2_]);
               }
               _loc2_++;
            }
         }
         _loc1_._gemGrid = this._gemGrid;
         _loc1_._gemSlot = this._gemSlot;
         _loc1_._newSkill = this._newSkill;
         _loc1_._reinforceAttrib = this._reinforceAttrib;
         _loc1_._blessAttrib = this._blessAttrib;
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
   }
}

