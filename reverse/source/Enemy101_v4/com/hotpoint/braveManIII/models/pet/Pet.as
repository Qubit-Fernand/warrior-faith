package com.hotpoint.braveManIII.models.pet
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   
   public class Pet
   {
      
      public var _id:VT;
      
      private var _lv:VT;
      
      private var _lvlimit:VT;
      
      private var _food:VT;
      
      private var _att:VT;
      
      private var _def:VT;
      
      private var _crit:VT;
      
      private var _life:VT;
      
      private var _exp:VT;
      
      public function Pet()
      {
         super();
      }
      
      public static function creatPet(id:*, att:*, def:*, crit:*, life:*) : Pet
      {
         var pet:Pet = new Pet();
         pet._id = VT.createVT(id);
         pet._lvlimit = VT.createVT(20);
         pet._lv = VT.createVT(1);
         pet._food = VT.createVT(50);
         pet._exp = VT.createVT(0);
         pet._att = VT.createVT(att);
         pet._def = VT.createVT(def);
         pet._crit = VT.createVT(crit);
         pet._life = VT.createVT(life);
         return pet;
      }
      
      public function getLv() : Number
      {
         return _lv.getValue();
      }
      
      public function setLv(level:Number) : *
      {
         _lv.setValue(level);
      }
      
      public function setFood(num:Number) : *
      {
         _food.setValue(_food.getValue() + num);
         if(_food.getValue() < 0)
         {
            _food.setValue(0);
         }
         if(_food.getValue() > 100)
         {
            _food.setValue(100);
         }
      }
      
      public function getLvLimit() : Number
      {
         return _lvlimit.getValue();
      }
      
      public function getFood() : Number
      {
         return _food.getValue();
      }
      
      public function getAtt() : Number
      {
         return _att.getValue() + getAttup() * getLv();
      }
      
      public function getDef() : Number
      {
         return _def.getValue() + getDefup() * getLv();
      }
      
      public function getCrit() : Number
      {
         return _crit.getValue() + getCritup() * getLv();
      }
      
      public function getLife() : Number
      {
         return _life.getValue() + getLifeup() * getLv();
      }
      
      public function getExp() : Number
      {
         return _exp.getValue();
      }
      
      public function setExp(num:Number) : *
      {
         _exp.setValue(num);
      }
      
      public function addExp(num:Number) : *
      {
         _exp.setValue(_exp.getValue() + num);
         if(PetFactory.all_LVData_vt[this.getLv() - 1].getValue() < _exp.getValue() && this.getLv() < this.getLvLimit())
         {
            this.setLv(this.getLv() + 1);
            this.setExp(0);
         }
      }
      
      public function getName() : String
      {
         return PetFactory.getName(_id.getValue());
      }
      
      public function getFrame() : Number
      {
         return PetFactory.getFrame(_id.getValue());
      }
      
      public function getType() : Number
      {
         return PetFactory.getType(_id.getValue());
      }
      
      public function getClassName() : String
      {
         return PetFactory.getClassName(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return PetFactory.getIntroduction(_id.getValue());
      }
      
      public function getAttup() : Number
      {
         return PetFactory.getAttup(_id.getValue());
      }
      
      public function getDefup() : Number
      {
         return PetFactory.getDefup(_id.getValue());
      }
      
      public function getCritup() : Number
      {
         return PetFactory.getCritup(_id.getValue());
      }
      
      public function getLifeup() : Number
      {
         return PetFactory.getLifeup(_id.getValue());
      }
      
      public function getLink() : Number
      {
         return PetFactory.getLink(_id.getValue());
      }
      
      public function cloneOtherobj(ts:Number) : Pet
      {
         return creatOther(_id.getValue(),ts);
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get lv() : VT
      {
         return _lv;
      }
      
      public function set lv(value:VT) : void
      {
         _lv = value;
      }
      
      public function get lvlimit() : VT
      {
         return _lvlimit;
      }
      
      public function set lvlimit(value:VT) : void
      {
         _lvlimit = value;
      }
      
      public function get food() : VT
      {
         return _food;
      }
      
      public function set food(value:VT) : void
      {
         _food = value;
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
      
      public function get life() : VT
      {
         return _life;
      }
      
      public function set life(value:VT) : void
      {
         _life = value;
      }
      
      public function get exp() : VT
      {
         return _exp;
      }
      
      public function set exp(value:VT) : void
      {
         _exp = value;
      }
   }
}

