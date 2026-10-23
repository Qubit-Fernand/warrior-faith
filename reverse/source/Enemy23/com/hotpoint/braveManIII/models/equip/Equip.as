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
      
      public static function creatEquip(baseId:Number, baseAttrib:Array, skillAttrib:Number, grid:Number) : Equip
      {
         var equip:Equip = new Equip();
         equip._base = VT.createVT(baseId);
         equip._baseAttrib = baseAttrib;
         equip._skillAttrib = VT.createVT(skillAttrib);
         equip._gemGrid = VT.createVT(grid);
         equip._reinforceAttrib = EquipReinforce.createEquipReinforce(0,0,0);
         equip.setSysTime(Main.serverTime);
         equip.setRemainingTimeNow();
         return equip;
      }
      
      public function get gemGrid() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemGrid;
      }
      
      public function set gemGrid(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemGrid = value;
      }
      
      public function get base() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _base;
      }
      
      public function set base(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _base = value;
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
      
      public function get skillAttrib() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _skillAttrib;
      }
      
      public function set skillAttrib(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _skillAttrib = value;
      }
      
      public function get reinforceAttrib() : EquipReinforce
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _reinforceAttrib;
      }
      
      public function set reinforceAttrib(value:EquipReinforce) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _reinforceAttrib = value;
      }
      
      public function get gemSlot() : Gem
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemSlot;
      }
      
      public function set gemSlot(value:Gem) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemSlot = value;
      }
      
      public function get newSkill() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _newSkill;
      }
      
      public function set newSkill(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _newSkill = value;
      }
      
      public function get createTime() : Date
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _createTime;
      }
      
      public function set createTime(value:Date) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _createTime = value;
      }
      
      public function get remainingTime() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _remainingTime;
      }
      
      public function set remainingTime(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _remainingTime = value;
      }
      
      public function get blessAttrib() : EquipBaseAttrib
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _blessAttrib;
      }
      
      public function set blessAttrib(value:EquipBaseAttrib) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _blessAttrib = value;
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
         var baseAttrib:EquipBaseAttrib = null;
         var count:Number = 0;
         for each(baseAttrib in _baseAttrib)
         {
            if(baseAttrib.getColorType() == 1 && baseAttrib.getAttribType() == EquipBaseAttribTypeConst.ATTACK)
            {
               count += baseAttrib.getValue();
            }
         }
         return count;
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
         return _remainingTime.getValue();
      }
      
      public function setRemainingTimeNow() : *
      {
         _remainingTime.setValue(getDefaultTime());
      }
      
      public function setRemainingTime(time:VT) : *
      {
         var tt:int = 0;
         var mytime:int = time.getValue();
         var str:String = String(mytime);
         var yea:String = str.substr(0,4);
         var mun:String = str.substr(4,2);
         var day:String = str.substr(6,2);
         var yeanum:int = new int(yea);
         var munnum:int = new int(mun);
         var daynum:int = new int(day);
         var dd:Date = getSysTime();
         var nd:Date = new Date(yeanum,munnum - 1,daynum);
         if(nd.getTime() >= dd.getTime())
         {
            tt = Math.floor((nd.getTime() - dd.getTime()) / (1000 * 24 * 60 * 60));
            tt = getDefaultTime() - tt;
            if(tt < 0)
            {
               tt = 0;
            }
            _remainingTime.setValue(tt);
         }
      }
      
      public function setSysTime(time:VT) : *
      {
         var mytime:int = time.getValue();
         if(mytime <= 18991231)
         {
            _createTime = new Date();
            return;
         }
         var str:String = String(mytime);
         var yea:String = str.substr(0,4);
         var mun:String = str.substr(4,2);
         var day:String = str.substr(6,2);
         var yeanum:int = new int(yea);
         var munnum:int = new int(mun);
         var daynum:int = new int(day);
         _createTime = new Date(yeanum,munnum - 1,daynum);
      }
      
      public function getSysTime() : Date
      {
         return _createTime;
      }
      
      public function changeReinforce(level:Number, attribType:uint, value:uint) : void
      {
         _reinforceAttrib.setLevel(level);
         _reinforceAttrib.setAttribType(attribType);
         _reinforceAttrib.setAttribValues(_reinforceAttrib.getAttribValues() + value);
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
         var arr:Array = EquipFactory.findBlessAttrib(_base.getValue());
         var rdm:int = int(getRandomType());
         _blessAttrib = arr[rdm];
      }
      
      private function getRandomType() : uint
      {
         var rdm:* = Math.random() * 100;
         if(rdm >= 0 && rdm < 22)
         {
            return 0;
         }
         if(rdm >= 22 && rdm < 44)
         {
            return 1;
         }
         if(rdm >= 44 && rdm < 66)
         {
            return 2;
         }
         if(rdm >= 66 && rdm < 83)
         {
            return 3;
         }
         return 4;
      }
      
      public function showBaseAttrib() : Array
      {
         var baseAttrib:EquipBaseAttrib = null;
         var allAttrib:Array = [];
         for each(baseAttrib in _baseAttrib)
         {
            allAttrib.push([baseAttrib.getColorType(),EquipBaseAttribTypeConst.getDescription(baseAttrib.getAttribType(),baseAttrib.getValue())]);
         }
         return allAttrib;
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
      
      public function setInGem(gg:Gem) : Boolean
      {
         if(_gemGrid.getValue() == 1 || gemGrid.getValue() == 0)
         {
            this._gemSlot = gg;
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
         var attrib:Attribute = null;
         var arr:Array = [];
         if(_gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(attrib in _gemSlot.getGemAttrib())
            {
               arr.push(EquipBaseAttribTypeConst.getDescription(attrib.getAttribType(),attrib.getValue()));
            }
         }
         return arr;
      }
      
      private function countEquipAllAttrib(attribType:Number) : Number
      {
         var baseAttrib:EquipBaseAttrib = null;
         var attrib:Attribute = null;
         var count:Number = 0;
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
         if(_blessAttrib)
         {
            if(_blessAttrib.getAttribType() == attribType)
            {
               count += _blessAttrib.getValue();
            }
         }
         return count;
      }
      
      public function getSkillAttrib() : Number
      {
         return _skillAttrib.getValue();
      }
      
      public function getNewSkill() : Number
      {
         return _newSkill.getValue();
      }
      
      public function setNewSkill(fmId:Number) : *
      {
         _newSkill.setValue(fmId);
      }
      
      public function getGemSlot() : Gem
      {
         return _gemSlot;
      }
      
      public function jinhuaEquip() : Equip
      {
         var e:Equip = null;
         e = EquipFactory.createEquipByID(getJinHua());
         e._reinforceAttrib = _reinforceAttrib;
         e._gemGrid = _gemGrid;
         e._gemSlot = _gemSlot;
         e._blessAttrib = _blessAttrib;
         e._newSkill = _newSkill;
         return e;
      }
      
      public function reCreatEquip() : Equip
      {
         var e:Equip = null;
         e = EquipFactory.createEquipByID(_base.getValue());
         e._gemGrid = _gemGrid;
         e._gemSlot = _gemSlot;
         e._newSkill = _newSkill;
         e._reinforceAttrib = _reinforceAttrib;
         e._skillAttrib = _skillAttrib;
         e._blessAttrib = _blessAttrib;
         return e;
      }
      
      public function upStarEquip() : Equip
      {
         var e:Equip = null;
         var i:* = 0;
         e = EquipFactory.createEquipByID(getReincarnationLimit());
         if(e._baseAttrib)
         {
            for(i = 0; i < e._baseAttrib.length; i++)
            {
               if((e._baseAttrib[i] as EquipBaseAttrib).getColorType() == 3)
               {
                  e._baseAttrib.splice(i,1);
                  i--;
               }
            }
            for(i = 0; i < _baseAttrib.length; i++)
            {
               if((_baseAttrib[i] as EquipBaseAttrib).getColorType() == 3)
               {
                  e._baseAttrib.push(_baseAttrib[i]);
               }
            }
         }
         e._gemGrid = _gemGrid;
         e._gemSlot = _gemSlot;
         e._newSkill = _newSkill;
         e._reinforceAttrib = _reinforceAttrib;
         e._blessAttrib = _blessAttrib;
         return e;
      }
      
      public function getClone() : Equip
      {
         return Equip.creatEquip(this._base.getValue(),this._baseAttrib,this._skillAttrib.getValue(),this._gemGrid.getValue());
      }
      
      public function compareById(id:Number) : Boolean
      {
         if(this._base.getValue() == id)
         {
            return true;
         }
         return false;
      }
   }
}

