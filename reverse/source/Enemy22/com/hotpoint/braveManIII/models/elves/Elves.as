package com.hotpoint.braveManIII.models.elves
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.repository.elves.*;
   import flash.utils.*;
   
   public class Elves
   {
      
      internal var a:uint;
      
      private var _id:VT;
      
      private var _level:VT;
      
      private var _exp:VT;
      
      private var _blueEquip:Equip = null;
      
      private var _pinkEquip:Equip = null;
      
      private var _goldEquip:Equip = null;
      
      private var _blueEquipNum:VT;
      
      private var _pinkEquipNum:VT;
      
      private var _goldEquipNum:VT;
      
      private var _blueCD:VT;
      
      private var _pinkCD:VT;
      
      private var _goldCD:VT;
      
      private var _allPoint:VT;
      
      private var _hp:VT;
      
      private var _mp:VT;
      
      private var _att:VT;
      
      private var _def:VT;
      
      private var _crit:VT;
      
      private var _flagLV:VT = VT.createVT(0);
      
      public function Elves()
      {
         super();
         this.a = setInterval(this.timeStart,1000);
      }
      
      public static function creatElves(id:Number, blueEquipNum:Number, pinkEquipNum:Number, goldEquipNum:Number) : Elves
      {
         var elves:Elves = new Elves();
         elves._id = VT.createVT(id);
         elves._level = VT.createVT(1);
         elves._blueCD = VT.createVT(-1);
         elves._pinkCD = VT.createVT(-1);
         elves._goldCD = VT.createVT(-1);
         elves._exp = VT.createVT(0);
         elves._blueEquipNum = VT.createVT(blueEquipNum);
         elves._pinkEquipNum = VT.createVT(pinkEquipNum);
         elves._goldEquipNum = VT.createVT(goldEquipNum);
         elves._allPoint = VT.createVT(0);
         elves._hp = VT.createVT(0);
         elves._mp = VT.createVT(0);
         elves._att = VT.createVT(0);
         elves._def = VT.createVT(0);
         elves._crit = VT.createVT(0);
         return elves;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get level() : VT
      {
         return this._level;
      }
      
      public function set level(value:VT) : void
      {
         this._level = value;
      }
      
      public function get blueEquip() : Equip
      {
         return this._blueEquip;
      }
      
      public function set blueEquip(value:Equip) : void
      {
         this._blueEquip = value;
      }
      
      public function get pinkEquip() : Equip
      {
         return this._pinkEquip;
      }
      
      public function set pinkEquip(value:Equip) : void
      {
         this._pinkEquip = value;
      }
      
      public function get goldEquip() : Equip
      {
         return this._goldEquip;
      }
      
      public function set goldEquip(value:Equip) : void
      {
         this._goldEquip = value;
      }
      
      public function get blueCD() : VT
      {
         return this._blueCD;
      }
      
      public function set blueCD(value:VT) : void
      {
         this._blueCD = value;
      }
      
      public function get pinkCD() : VT
      {
         return this._pinkCD;
      }
      
      public function set pinkCD(value:VT) : void
      {
         this._pinkCD = value;
      }
      
      public function get goldCD() : VT
      {
         return this._goldCD;
      }
      
      public function set goldCD(value:VT) : void
      {
         this._goldCD = value;
      }
      
      public function get allPoint() : VT
      {
         return this._allPoint;
      }
      
      public function set allPoint(value:VT) : void
      {
         this._allPoint = value;
      }
      
      public function get hp() : VT
      {
         return this._hp;
      }
      
      public function set hp(value:VT) : void
      {
         this._hp = value;
      }
      
      public function get mp() : VT
      {
         return this._mp;
      }
      
      public function set mp(value:VT) : void
      {
         this._mp = value;
      }
      
      public function get att() : VT
      {
         return this._att;
      }
      
      public function set att(value:VT) : void
      {
         this._att = value;
      }
      
      public function get def() : VT
      {
         return this._def;
      }
      
      public function set def(value:VT) : void
      {
         this._def = value;
      }
      
      public function get crit() : VT
      {
         return this._crit;
      }
      
      public function set crit(value:VT) : void
      {
         this._crit = value;
      }
      
      public function get exp() : VT
      {
         return this._exp;
      }
      
      public function set exp(value:VT) : void
      {
         this._exp = value;
      }
      
      public function get blueEquipNum() : VT
      {
         return this._blueEquipNum;
      }
      
      public function set blueEquipNum(value:VT) : void
      {
         this._blueEquipNum = value;
      }
      
      public function get pinkEquipNum() : VT
      {
         return this._pinkEquipNum;
      }
      
      public function set pinkEquipNum(value:VT) : void
      {
         this._pinkEquipNum = value;
      }
      
      public function get goldEquipNum() : VT
      {
         return this._goldEquipNum;
      }
      
      public function set goldEquipNum(value:VT) : void
      {
         this._goldEquipNum = value;
      }
      
      public function get flagLV() : VT
      {
         return this._flagLV;
      }
      
      public function set flagLV(value:VT) : void
      {
         this._flagLV = value;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return ElvesFactory.getName(this._id.getValue());
      }
      
      public function getClassName() : String
      {
         return ElvesFactory.getClassName(this._id.getValue());
      }
      
      public function getFrame() : Number
      {
         return ElvesFactory.getFrame(this._id.getValue());
      }
      
      public function getColor() : Number
      {
         return ElvesFactory.getColor(this._id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return ElvesFactory.getIntroduction(this._id.getValue());
      }
      
      public function getBlueLV() : Number
      {
         return ElvesFactory.getBlueLV(this._id.getValue());
      }
      
      public function getPinkLV() : Number
      {
         return ElvesFactory.getPinkLV(this._id.getValue());
      }
      
      public function getGoldLV() : Number
      {
         return ElvesFactory.getGoldLV(this._id.getValue());
      }
      
      public function getBlueNum() : Number
      {
         return ElvesFactory.getBlueNum(this._id.getValue());
      }
      
      public function getPinkNum() : Number
      {
         return ElvesFactory.getPinkNum(this._id.getValue());
      }
      
      public function getGoldNum() : Number
      {
         return ElvesFactory.getGoldNum(this._id.getValue());
      }
      
      public function getTimeX() : Number
      {
         return ElvesFactory.getTimeX(this._id.getValue());
      }
      
      public function getTimeBuff() : Number
      {
         return this.getTimeX() * this._level.getValue();
      }
      
      public function getLevel() : Number
      {
         return this._level.getValue();
      }
      
      public function setLevel(num:Number) : *
      {
         this._level.setValue(num);
      }
      
      public function getEXP() : Number
      {
         return this._exp.getValue();
      }
      
      public function setEXP(num:Number) : *
      {
         this._exp.setValue(num);
      }
      
      public function addExp(num:Number) : *
      {
         this._exp.setValue(this._exp.getValue() + num);
         while(this._flagLV.getValue() < this._level.getValue())
         {
            if(this.getColor() == 2)
            {
               this.setAllPoint(2);
            }
            else if(this.getColor() == 3)
            {
               this.setAllPoint(3);
            }
            else if(this.getColor() == 4)
            {
               this.setAllPoint(5);
            }
            this._flagLV.setValue(this._flagLV.getValue() + 1);
         }
         if(this.getLevel() * 15 < this._exp.getValue() && this.getLevel() < 10)
         {
            this.setLevel(this.getLevel() + 1);
            this.setEXP(0);
            return true;
         }
         return false;
      }
      
      public function getHP() : Number
      {
         return this._hp.getValue();
      }
      
      public function setHP(num:Number = 1) : *
      {
         this._hp.setValue(this._hp.getValue() + num);
      }
      
      public function getMP() : Number
      {
         return this._mp.getValue();
      }
      
      public function setMP(num:Number = 1) : *
      {
         this._mp.setValue(this._mp.getValue() + num);
      }
      
      public function getATT() : Number
      {
         return this._att.getValue();
      }
      
      public function setATT(num:Number = 1) : *
      {
         this._att.setValue(this._att.getValue() + num);
      }
      
      public function getDEF() : Number
      {
         return this._def.getValue();
      }
      
      public function setDEF(num:Number = 1) : *
      {
         this._def.setValue(this._def.getValue() + num);
      }
      
      public function getCRIT() : Number
      {
         return this._crit.getValue();
      }
      
      public function setCRIT(num:Number = 1) : *
      {
         this._crit.setValue(this._crit.getValue() + num);
      }
      
      public function getAllPoint() : Number
      {
         return this._allPoint.getValue();
      }
      
      public function setAllPoint(num:Number = -1) : *
      {
         this._allPoint.setValue(this._allPoint.getValue() + num);
      }
      
      public function resetAllPoint() : *
      {
         this._allPoint.setValue(this._allPoint.getValue() + this._hp.getValue() + this._mp.getValue() + this._att.getValue() + this._def.getValue() + this._crit.getValue());
         this._hp.setValue(0);
         this._mp.setValue(0);
         this._att.setValue(0);
         this._def.setValue(0);
         this._crit.setValue(0);
      }
      
      public function setBlueEquip(e:Equip) : *
      {
         this._blueEquip = e;
         this._blueCD.setValue(1800 - this.getTimeBuff());
      }
      
      public function setPinkEquip(e:Equip) : *
      {
         this._pinkEquip = e;
         this._pinkCD.setValue(2400 - this.getTimeBuff());
      }
      
      public function setGoldEquip(e:Equip) : *
      {
         this._goldEquip = e;
         this._goldCD.setValue(2700 - this.getTimeBuff());
      }
      
      public function getBlueEquip() : Equip
      {
         return this._blueEquip;
      }
      
      public function getPinkEquip() : Equip
      {
         return this._pinkEquip;
      }
      
      public function getGoldEquip() : Equip
      {
         return this._goldEquip;
      }
      
      public function delBlueEquip() : *
      {
         this._blueEquip = null;
         this._blueCD.setValue(-1);
      }
      
      public function delPinkEquip() : *
      {
         this._pinkEquip = null;
         this._pinkCD.setValue(-1);
      }
      
      public function delGoldEquip() : *
      {
         this._goldEquip = null;
         this._goldCD.setValue(-1);
      }
      
      public function overBlueEquip() : *
      {
         if(this._blueEquipNum.getValue() > 0)
         {
            this._blueCD.setValue(-1);
            this._allPoint.setValue(this._allPoint.getValue() + 1);
            this._blueEquipNum.setValue(this._blueEquipNum.getValue() - 1);
            this._blueEquip = null;
         }
      }
      
      public function overPinkEquip() : *
      {
         if(this._pinkEquipNum.getValue() > 0)
         {
            this._pinkCD.setValue(-1);
            this._allPoint.setValue(this._allPoint.getValue() + 2);
            this._pinkEquipNum.setValue(this._pinkEquipNum.getValue() - 1);
            this._pinkEquip = null;
         }
      }
      
      public function overGoldEquip() : *
      {
         if(this._goldEquipNum.getValue() > 0)
         {
            this._goldCD.setValue(-1);
            this._allPoint.setValue(this._allPoint.getValue() + 3);
            this._goldEquipNum.setValue(this._goldEquipNum.getValue() - 1);
            this._goldEquip = null;
         }
      }
      
      public function getBlueCD() : Number
      {
         return this._blueCD.getValue();
      }
      
      public function getPinkCD() : Number
      {
         return this._pinkCD.getValue();
      }
      
      public function getGoldCD() : Number
      {
         return this._goldCD.getValue();
      }
      
      public function getBlueEquipNum() : Number
      {
         return this._blueEquipNum.getValue();
      }
      
      public function getPinkEquipNum() : Number
      {
         return this._pinkEquipNum.getValue();
      }
      
      public function getGoldEquipNum() : Number
      {
         return this._goldEquipNum.getValue();
      }
      
      private function timeStart() : *
      {
         if(this._blueCD.getValue() >= 0)
         {
            if(this._blueCD.getValue() == 0)
            {
               this.overBlueEquip();
            }
            this._blueCD.setValue(this._blueCD.getValue() - 1);
         }
         if(this._pinkCD.getValue() >= 0)
         {
            if(this._pinkCD.getValue() == 0)
            {
               this.overPinkEquip();
            }
            this._pinkCD.setValue(this._pinkCD.getValue() - 1);
         }
         if(this._goldCD.getValue() >= 0)
         {
            if(this._goldCD.getValue() == 0)
            {
               this.overGoldEquip();
            }
            this._goldCD.setValue(this._goldCD.getValue() - 1);
         }
      }
   }
}

