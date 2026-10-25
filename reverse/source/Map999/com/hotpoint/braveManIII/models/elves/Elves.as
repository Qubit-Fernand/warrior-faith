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
      
      public function Elves()
      {
         super();
         a = setInterval(timeStart,1000);
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
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get level() : VT
      {
         return _level;
      }
      
      public function set level(value:VT) : void
      {
         _level = value;
      }
      
      public function get blueEquip() : Equip
      {
         return _blueEquip;
      }
      
      public function set blueEquip(value:Equip) : void
      {
         _blueEquip = value;
      }
      
      public function get pinkEquip() : Equip
      {
         return _pinkEquip;
      }
      
      public function set pinkEquip(value:Equip) : void
      {
         _pinkEquip = value;
      }
      
      public function get goldEquip() : Equip
      {
         return _goldEquip;
      }
      
      public function set goldEquip(value:Equip) : void
      {
         _goldEquip = value;
      }
      
      public function get blueCD() : VT
      {
         return _blueCD;
      }
      
      public function set blueCD(value:VT) : void
      {
         _blueCD = value;
      }
      
      public function get pinkCD() : VT
      {
         return _pinkCD;
      }
      
      public function set pinkCD(value:VT) : void
      {
         _pinkCD = value;
      }
      
      public function get goldCD() : VT
      {
         return _goldCD;
      }
      
      public function set goldCD(value:VT) : void
      {
         _goldCD = value;
      }
      
      public function get allPoint() : VT
      {
         return _allPoint;
      }
      
      public function set allPoint(value:VT) : void
      {
         _allPoint = value;
      }
      
      public function get hp() : VT
      {
         return _hp;
      }
      
      public function set hp(value:VT) : void
      {
         _hp = value;
      }
      
      public function get mp() : VT
      {
         return _mp;
      }
      
      public function set mp(value:VT) : void
      {
         _mp = value;
      }
      
      public function get att() : VT
      {
         return _att;
      }
      
      public function set att(value:VT) : void
      {
         _att = value;
      }
      
      public function get def() : VT
      {
         return _def;
      }
      
      public function set def(value:VT) : void
      {
         _def = value;
      }
      
      public function get crit() : VT
      {
         return _crit;
      }
      
      public function set crit(value:VT) : void
      {
         _crit = value;
      }
      
      public function get exp() : VT
      {
         return _exp;
      }
      
      public function set exp(value:VT) : void
      {
         _exp = value;
      }
      
      public function get blueEquipNum() : VT
      {
         return _blueEquipNum;
      }
      
      public function set blueEquipNum(value:VT) : void
      {
         _blueEquipNum = value;
      }
      
      public function get pinkEquipNum() : VT
      {
         return _pinkEquipNum;
      }
      
      public function set pinkEquipNum(value:VT) : void
      {
         _pinkEquipNum = value;
      }
      
      public function get goldEquipNum() : VT
      {
         return _goldEquipNum;
      }
      
      public function set goldEquipNum(value:VT) : void
      {
         _goldEquipNum = value;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return ElvesFactory.getName(_id.getValue());
      }
      
      public function getClassName() : String
      {
         return ElvesFactory.getClassName(_id.getValue());
      }
      
      public function getFrame() : Number
      {
         return ElvesFactory.getFrame(_id.getValue());
      }
      
      public function getColor() : Number
      {
         return ElvesFactory.getColor(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return ElvesFactory.getIntroduction(_id.getValue());
      }
      
      public function getBlueLV() : Number
      {
         return ElvesFactory.getBlueLV(_id.getValue());
      }
      
      public function getPinkLV() : Number
      {
         return ElvesFactory.getPinkLV(_id.getValue());
      }
      
      public function getGoldLV() : Number
      {
         return ElvesFactory.getGoldLV(_id.getValue());
      }
      
      public function getBlueNum() : Number
      {
         return ElvesFactory.getBlueNum(_id.getValue());
      }
      
      public function getPinkNum() : Number
      {
         return ElvesFactory.getPinkNum(_id.getValue());
      }
      
      public function getGoldNum() : Number
      {
         return ElvesFactory.getGoldNum(_id.getValue());
      }
      
      public function getTimeX() : Number
      {
         return ElvesFactory.getTimeX(_id.getValue());
      }
      
      public function getTimeBuff() : Number
      {
         return getTimeX() * _level.getValue();
      }
      
      public function getLevel() : Number
      {
         return _level.getValue();
      }
      
      public function setLevel(num:Number) : *
      {
         _level.setValue(num);
      }
      
      public function getEXP() : Number
      {
         return _exp.getValue();
      }
      
      public function setEXP(num:Number) : *
      {
         _exp.setValue(num);
      }
      
      public function addExp(num:Number) : *
      {
         _exp.setValue(_exp.getValue() + num);
         if(getLevel() * 15 < _exp.getValue() && getLevel() < 10)
         {
            this.setLevel(getLevel() + 1);
            this.setEXP(0);
            return true;
         }
         return false;
      }
      
      public function getHP() : Number
      {
         return _hp.getValue();
      }
      
      public function setHP(num:Number = 1) : *
      {
         _hp.setValue(_hp.getValue() + num);
      }
      
      public function getMP() : Number
      {
         return _mp.getValue();
      }
      
      public function setMP(num:Number = 1) : *
      {
         _mp.setValue(_mp.getValue() + num);
      }
      
      public function getATT() : Number
      {
         return _att.getValue();
      }
      
      public function setATT(num:Number = 1) : *
      {
         _att.setValue(_att.getValue() + num);
      }
      
      public function getDEF() : Number
      {
         return _def.getValue();
      }
      
      public function setDEF(num:Number = 1) : *
      {
         _def.setValue(_def.getValue() + num);
      }
      
      public function getCRIT() : Number
      {
         return _crit.getValue();
      }
      
      public function setCRIT(num:Number = 1) : *
      {
         _crit.setValue(_crit.getValue() + num);
      }
      
      public function getAllPoint() : Number
      {
         return _allPoint.getValue();
      }
      
      public function setAllPoint(num:Number = -1) : *
      {
         _allPoint.setValue(_allPoint.getValue() + num);
      }
      
      public function resetAllPoint() : *
      {
         _allPoint.setValue(_allPoint.getValue() + _hp.getValue() + _mp.getValue() + _att.getValue() + _def.getValue() + _crit.getValue());
         _hp.setValue(0);
         _mp.setValue(0);
         _att.setValue(0);
         _def.setValue(0);
         _crit.setValue(0);
      }
      
      public function setBlueEquip(e:Equip) : *
      {
         _blueEquip = e;
         _blueCD.setValue(1800 - getTimeBuff());
      }
      
      public function setPinkEquip(e:Equip) : *
      {
         _pinkEquip = e;
         _pinkCD.setValue(2400 - getTimeBuff());
      }
      
      public function setGoldEquip(e:Equip) : *
      {
         _goldEquip = e;
         _goldCD.setValue(2700 - getTimeBuff());
      }
      
      public function getBlueEquip() : Equip
      {
         return _blueEquip;
      }
      
      public function getPinkEquip() : Equip
      {
         return _pinkEquip;
      }
      
      public function getGoldEquip() : Equip
      {
         return _goldEquip;
      }
      
      public function delBlueEquip() : *
      {
         _blueEquip = null;
         _blueCD.setValue(-1);
      }
      
      public function delPinkEquip() : *
      {
         _pinkEquip = null;
         _pinkCD.setValue(-1);
      }
      
      public function delGoldEquip() : *
      {
         _goldEquip = null;
         _goldCD.setValue(-1);
      }
      
      public function overBlueEquip() : *
      {
         if(_blueEquipNum.getValue() > 0)
         {
            _blueCD.setValue(-1);
            _allPoint.setValue(_allPoint.getValue() + 1);
            _blueEquipNum.setValue(_blueEquipNum.getValue() - 1);
            _blueEquip = null;
         }
      }
      
      public function overPinkEquip() : *
      {
         if(_pinkEquipNum.getValue() > 0)
         {
            _pinkCD.setValue(-1);
            _allPoint.setValue(_allPoint.getValue() + 2);
            _pinkEquipNum.setValue(_pinkEquipNum.getValue() - 1);
            _pinkEquip = null;
         }
      }
      
      public function overGoldEquip() : *
      {
         if(_goldEquipNum.getValue() > 0)
         {
            _goldCD.setValue(-1);
            _allPoint.setValue(_allPoint.getValue() + 3);
            _goldEquipNum.setValue(_goldEquipNum.getValue() - 1);
            _goldEquip = null;
         }
      }
      
      public function getBlueCD() : Number
      {
         return _blueCD.getValue();
      }
      
      public function getPinkCD() : Number
      {
         return _pinkCD.getValue();
      }
      
      public function getGoldCD() : Number
      {
         return _goldCD.getValue();
      }
      
      public function getBlueEquipNum() : Number
      {
         return _blueEquipNum.getValue();
      }
      
      public function getPinkEquipNum() : Number
      {
         return _pinkEquipNum.getValue();
      }
      
      public function getGoldEquipNum() : Number
      {
         return _goldEquipNum.getValue();
      }
      
      private function timeStart() : *
      {
         if(_blueCD.getValue() >= 0)
         {
            if(_blueCD.getValue() == 0)
            {
               overBlueEquip();
            }
            _blueCD.setValue(_blueCD.getValue() - 1);
         }
         if(_pinkCD.getValue() >= 0)
         {
            if(_pinkCD.getValue() == 0)
            {
               overPinkEquip();
            }
            _pinkCD.setValue(_pinkCD.getValue() - 1);
         }
         if(_goldCD.getValue() >= 0)
         {
            if(_goldCD.getValue() == 0)
            {
               overGoldEquip();
            }
            _goldCD.setValue(_goldCD.getValue() - 1);
         }
      }
   }
}

