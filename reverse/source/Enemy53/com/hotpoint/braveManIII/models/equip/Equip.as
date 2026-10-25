package com.hotpoint.braveManIII.models.equip
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.skill.*;
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
         return this._gemGrid;
      }
      
      public function set gemGrid(value:VT) : void
      {
         this._gemGrid = value;
      }
      
      public function get base() : VT
      {
         return this._base;
      }
      
      public function set base(value:VT) : void
      {
         this._base = value;
      }
      
      public function get baseAttrib() : Array
      {
         return this._baseAttrib;
      }
      
      public function set baseAttrib(value:Array) : void
      {
         this._baseAttrib = value;
      }
      
      public function get skillAttrib() : VT
      {
         return this._skillAttrib;
      }
      
      public function set skillAttrib(value:VT) : void
      {
         this._skillAttrib = value;
      }
      
      public function get reinforceAttrib() : EquipReinforce
      {
         return this._reinforceAttrib;
      }
      
      public function set reinforceAttrib(value:EquipReinforce) : void
      {
         this._reinforceAttrib = value;
      }
      
      public function get gemSlot() : Gem
      {
         return this._gemSlot;
      }
      
      public function set gemSlot(value:Gem) : void
      {
         this._gemSlot = value;
      }
      
      public function get newSkill() : VT
      {
         return this._newSkill;
      }
      
      public function set newSkill(value:VT) : void
      {
         this._newSkill = value;
      }
      
      public function get createTime() : Date
      {
         return this._createTime;
      }
      
      public function set createTime(value:Date) : void
      {
         this._createTime = value;
      }
      
      public function get remainingTime() : VT
      {
         return this._remainingTime;
      }
      
      public function set remainingTime(value:VT) : void
      {
         this._remainingTime = value;
      }
      
      public function get blessAttrib() : EquipBaseAttrib
      {
         return this._blessAttrib;
      }
      
      public function set blessAttrib(value:EquipBaseAttrib) : void
      {
         this._blessAttrib = value;
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
      
      public function getJinHua() : Number
      {
         return EquipFactory.findJinHua(this._base.getValue());
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
         var baseAttrib:EquipBaseAttrib = null;
         var count:Number = 0;
         for each(baseAttrib in this._baseAttrib)
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
      
      public function getMOKANG() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.MOKANG);
      }
      
      public function getPOMO() : Number
      {
         return this.countEquipAllAttrib(EquipBaseAttribTypeConst.POMO);
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
         return EquipFactory.findDefaultTime(this._base.getValue());
      }
      
      public function getRemainingTime() : Number
      {
         if(this.getPosition() < 8 && this._remainingTime.getValue() <= 0)
         {
            this._remainingTime.setValue(1);
         }
         return this._remainingTime.getValue();
      }
      
      public function setRemainingTimeNow() : *
      {
         this._remainingTime.setValue(this.getDefaultTime());
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
         var dd:Date = this.getSysTime();
         var nd:Date = new Date(yeanum,munnum - 1,daynum);
         if(nd.getTime() >= dd.getTime())
         {
            tt = Math.floor((nd.getTime() - dd.getTime()) / (1000 * 24 * 60 * 60));
            tt = this.getDefaultTime() - tt;
            if(tt < 0)
            {
               tt = 0;
            }
            this._remainingTime.setValue(tt);
         }
      }
      
      public function setSysTime(time:VT) : *
      {
         var mytime:int = time.getValue();
         if(mytime <= 18991231)
         {
            this._createTime = new Date();
            return;
         }
         var str:String = String(mytime);
         var yea:String = str.substr(0,4);
         var mun:String = str.substr(4,2);
         var day:String = str.substr(6,2);
         var yeanum:int = new int(yea);
         var munnum:int = new int(mun);
         var daynum:int = new int(day);
         this._createTime = new Date(yeanum,munnum - 1,daynum);
      }
      
      public function getSysTime() : Date
      {
         if(this._createTime == null)
         {
            this.setSysTime(Main.serverTime);
         }
         return this._createTime;
      }
      
      public function changeReinforce(level:Number, attribType:uint, value:uint) : void
      {
         this._reinforceAttrib.setLevel(level);
         this._reinforceAttrib.setAttribType(attribType);
         this._reinforceAttrib.setAttribValues(this._reinforceAttrib.getAttribValues() + value);
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
         var arr:Array = EquipFactory.findBlessAttrib(this._base.getValue());
         var rdm:int = int(this.getRandomType());
         this._blessAttrib = arr[rdm];
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
         for each(baseAttrib in this._baseAttrib)
         {
            allAttrib.push([baseAttrib.getColorType(),EquipBaseAttribTypeConst.getDescription(baseAttrib.getAttribType(),baseAttrib.getValue())]);
         }
         return allAttrib;
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
      
      public function setInGem(gg:Gem) : Boolean
      {
         if(this._gemGrid.getValue() == 1 || this.gemGrid.getValue() == 0)
         {
            this._gemSlot = gg;
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
         var attrib:Attribute = null;
         var arr:Array = [];
         if(this._gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(attrib in this._gemSlot.getGemAttrib())
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
         for each(baseAttrib in this._baseAttrib)
         {
            if(baseAttrib.getAttribType() == attribType)
            {
               count += baseAttrib.getValue();
            }
         }
         if(this._reinforceAttrib.getLevel() > 0 && this._reinforceAttrib.getAttribType() == attribType)
         {
            count += this._reinforceAttrib.getAttribValues();
         }
         if(this._gemGrid.getValue() == 0 && this._gemSlot.getType() == GemTypeConst.ATTRIBSTONE)
         {
            for each(attrib in this._gemSlot.getGemAttrib())
            {
               if(attrib.getAttribType() == attribType)
               {
                  count += attrib.getValue();
               }
            }
         }
         if(this._blessAttrib)
         {
            if(this._blessAttrib.getAttribType() == attribType)
            {
               count += this._blessAttrib.getValue();
            }
         }
         return count;
      }
      
      public function getSkillAttrib() : Number
      {
         return this._skillAttrib.getValue();
      }
      
      public function getNewSkill() : Number
      {
         return this._newSkill.getValue();
      }
      
      public function setNewSkill(fmId:Number) : *
      {
         this._newSkill.setValue(fmId);
      }
      
      public function getGemSlot() : Gem
      {
         return this._gemSlot;
      }
      
      public function jinhuaEquip() : Equip
      {
         var e:Equip = null;
         e = EquipFactory.createEquipByID(this.getJinHua());
         e._reinforceAttrib = this._reinforceAttrib;
         e._gemGrid = this._gemGrid;
         e._gemSlot = this._gemSlot;
         e._blessAttrib = this._blessAttrib;
         e._newSkill = this._newSkill;
         return e;
      }
      
      public function reCreatEquip() : Equip
      {
         var e:Equip = null;
         e = EquipFactory.createEquipByID(this._base.getValue());
         e._gemGrid = this._gemGrid;
         e._gemSlot = this._gemSlot;
         e._newSkill = this._newSkill;
         e._reinforceAttrib = this._reinforceAttrib;
         e._skillAttrib = this._skillAttrib;
         e._blessAttrib = this._blessAttrib;
         return e;
      }
      
      public function upStarEquip() : Equip
      {
         var e:Equip = null;
         var i:* = 0;
         e = EquipFactory.createEquipByID(this.getReincarnationLimit());
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
            for(i = 0; i < this._baseAttrib.length; i++)
            {
               if((this._baseAttrib[i] as EquipBaseAttrib).getColorType() == 3)
               {
                  e._baseAttrib.push(this._baseAttrib[i]);
               }
            }
         }
         e._gemGrid = this._gemGrid;
         e._gemSlot = this._gemSlot;
         e._newSkill = this._newSkill;
         e._reinforceAttrib = this._reinforceAttrib;
         e._blessAttrib = this._blessAttrib;
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
      
      public function testEquip(ee:Equip) : Boolean
      {
         if(this == ee)
         {
            return true;
         }
         return false;
      }
   }
}

