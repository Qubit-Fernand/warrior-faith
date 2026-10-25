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
      
      public static function creatElves(param1:Number, param2:Number, param3:Number, param4:Number) : Elves
      {
         var _loc5_:Elves = new Elves();
         _loc5_._id = VT.createVT(param1);
         _loc5_._level = VT.createVT(1);
         _loc5_._blueCD = VT.createVT(-1);
         _loc5_._pinkCD = VT.createVT(-1);
         _loc5_._goldCD = VT.createVT(-1);
         _loc5_._exp = VT.createVT(0);
         _loc5_._blueEquipNum = VT.createVT(param2);
         _loc5_._pinkEquipNum = VT.createVT(param3);
         _loc5_._goldEquipNum = VT.createVT(param4);
         _loc5_._allPoint = VT.createVT(0);
         _loc5_._hp = VT.createVT(0);
         _loc5_._mp = VT.createVT(0);
         _loc5_._att = VT.createVT(0);
         _loc5_._def = VT.createVT(0);
         _loc5_._crit = VT.createVT(0);
         return _loc5_;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         this._id = param1;
      }
      
      public function get level() : VT
      {
         return this._level;
      }
      
      public function set level(param1:VT) : void
      {
         this._level = param1;
      }
      
      public function get blueEquip() : Equip
      {
         return this._blueEquip;
      }
      
      public function set blueEquip(param1:Equip) : void
      {
         this._blueEquip = param1;
      }
      
      public function get pinkEquip() : Equip
      {
         return this._pinkEquip;
      }
      
      public function set pinkEquip(param1:Equip) : void
      {
         this._pinkEquip = param1;
      }
      
      public function get goldEquip() : Equip
      {
         return this._goldEquip;
      }
      
      public function set goldEquip(param1:Equip) : void
      {
         this._goldEquip = param1;
      }
      
      public function get blueCD() : VT
      {
         return this._blueCD;
      }
      
      public function set blueCD(param1:VT) : void
      {
         this._blueCD = param1;
      }
      
      public function get pinkCD() : VT
      {
         return this._pinkCD;
      }
      
      public function set pinkCD(param1:VT) : void
      {
         this._pinkCD = param1;
      }
      
      public function get goldCD() : VT
      {
         return this._goldCD;
      }
      
      public function set goldCD(param1:VT) : void
      {
         this._goldCD = param1;
      }
      
      public function get allPoint() : VT
      {
         return this._allPoint;
      }
      
      public function set allPoint(param1:VT) : void
      {
         this._allPoint = param1;
      }
      
      public function get hp() : VT
      {
         return this._hp;
      }
      
      public function set hp(param1:VT) : void
      {
         this._hp = param1;
      }
      
      public function get mp() : VT
      {
         return this._mp;
      }
      
      public function set mp(param1:VT) : void
      {
         this._mp = param1;
      }
      
      public function get att() : VT
      {
         return this._att;
      }
      
      public function set att(param1:VT) : void
      {
         this._att = param1;
      }
      
      public function get def() : VT
      {
         return this._def;
      }
      
      public function set def(param1:VT) : void
      {
         this._def = param1;
      }
      
      public function get crit() : VT
      {
         return this._crit;
      }
      
      public function set crit(param1:VT) : void
      {
         this._crit = param1;
      }
      
      public function get exp() : VT
      {
         return this._exp;
      }
      
      public function set exp(param1:VT) : void
      {
         this._exp = param1;
      }
      
      public function get blueEquipNum() : VT
      {
         return this._blueEquipNum;
      }
      
      public function set blueEquipNum(param1:VT) : void
      {
         this._blueEquipNum = param1;
      }
      
      public function get pinkEquipNum() : VT
      {
         return this._pinkEquipNum;
      }
      
      public function set pinkEquipNum(param1:VT) : void
      {
         this._pinkEquipNum = param1;
      }
      
      public function get goldEquipNum() : VT
      {
         return this._goldEquipNum;
      }
      
      public function set goldEquipNum(param1:VT) : void
      {
         this._goldEquipNum = param1;
      }
      
      public function get flagLV() : VT
      {
         return this._flagLV;
      }
      
      public function set flagLV(param1:VT) : void
      {
         this._flagLV = param1;
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
      
      public function setLevel(param1:Number) : *
      {
         this._level.setValue(param1);
      }
      
      public function getEXP() : Number
      {
         return this._exp.getValue();
      }
      
      public function setEXP(param1:Number) : *
      {
         this._exp.setValue(param1);
      }
      
      public function addExp(param1:Number) : *
      {
         this._exp.setValue(this._exp.getValue() + param1);
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
      
      public function setHP(param1:Number = 1) : *
      {
         this._hp.setValue(this._hp.getValue() + param1);
      }
      
      public function getMP() : Number
      {
         return this._mp.getValue();
      }
      
      public function setMP(param1:Number = 1) : *
      {
         this._mp.setValue(this._mp.getValue() + param1);
      }
      
      public function getATT() : Number
      {
         return this._att.getValue();
      }
      
      public function setATT(param1:Number = 1) : *
      {
         this._att.setValue(this._att.getValue() + param1);
      }
      
      public function getDEF() : Number
      {
         return this._def.getValue();
      }
      
      public function setDEF(param1:Number = 1) : *
      {
         this._def.setValue(this._def.getValue() + param1);
      }
      
      public function getCRIT() : Number
      {
         return this._crit.getValue();
      }
      
      public function setCRIT(param1:Number = 1) : *
      {
         this._crit.setValue(this._crit.getValue() + param1);
      }
      
      public function getAllPoint() : Number
      {
         return this._allPoint.getValue();
      }
      
      public function setAllPoint(param1:Number = -1) : *
      {
         this._allPoint.setValue(this._allPoint.getValue() + param1);
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
      
      public function setBlueEquip(param1:Equip) : *
      {
         this._blueEquip = param1;
         this._blueCD.setValue(1800 - this.getTimeBuff());
      }
      
      public function setPinkEquip(param1:Equip) : *
      {
         this._pinkEquip = param1;
         this._pinkCD.setValue(2400 - this.getTimeBuff());
      }
      
      public function setGoldEquip(param1:Equip) : *
      {
         this._goldEquip = param1;
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

