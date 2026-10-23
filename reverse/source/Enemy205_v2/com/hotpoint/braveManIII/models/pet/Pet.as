package com.hotpoint.braveManIII.models.pet
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   
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
      
      private var _wuxing:VT = VT.createVT(0);
      
      private var _skill:Array = [-1,-1,-1,-1];
      
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
         if(pet.getWXLV() > 0)
         {
            pet._wuxing = VT.createVT(Math.round(Math.random() * 3) + 1);
         }
         else
         {
            pet._wuxing = VT.createVT(0);
         }
         return pet;
      }
      
      public function getLv() : Number
      {
         return _lv.getValue();
      }
      
      public function setLv(level:Number) : *
      {
         _lv.setValue(level);
         addSkill();
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
      
      public function setWX() : *
      {
         if(getWXLV() > 0)
         {
            _wuxing.setValue(Math.round(Math.random() * 3) + 1);
         }
         addSkill();
      }
      
      public function getWX() : Number
      {
         return _wuxing.getValue();
      }
      
      public function addExp(num:Number) : *
      {
         _exp.setValue(_exp.getValue() + num);
         if(PetFactory.all_LVData_vt[this.getLv() - 1].getValue() < _exp.getValue() && this.getLv() < this.getLvLimit())
         {
            this.setLv(this.getLv() + 1);
            this.setExp(0);
            return true;
         }
         return false;
      }
      
      public function addSkill() : *
      {
         if(getWX() == 4)
         {
            if(getLv() >= 5 && _skill[0] == -1)
            {
               _skill[0] = 0;
            }
            if(getLv() >= 10 && _skill[1] == -1)
            {
               _skill[1] = 0;
            }
            if(getLv() >= 15 && _skill[2] == -1)
            {
               _skill[2] = 0;
            }
            if(getLv() >= 20 && _skill[3] == -1)
            {
               _skill[3] = 0;
            }
         }
         if(getWX() == 3)
         {
            if(getLv() >= 5 && _skill[0] == -1)
            {
               _skill[0] = 0;
            }
            if(getLv() >= 10 && _skill[1] == -1)
            {
               _skill[1] = 0;
            }
            if(getLv() >= 15 && _skill[2] == -1)
            {
               _skill[2] = 0;
            }
         }
         if(getWX() == 2)
         {
            if(getLv() >= 5 && _skill[0] == -1)
            {
               _skill[0] = 0;
            }
            if(getLv() >= 10 && _skill[1] == -1)
            {
               _skill[1] = 0;
            }
         }
         if(getWX() == 1)
         {
            if(getLv() >= 5 && _skill[0] == -1)
            {
               _skill[0] = 0;
            }
         }
      }
      
      public function setSkill(num:Number) : *
      {
         _skill[num] = SkillFactory.getSkillByPet(_id.getValue());
      }
      
      public function getPetSkill() : Array
      {
         return _skill;
      }
      
      public function getPetSkillType() : Array
      {
         var i:* = undefined;
         var _arr:Array = DeepCopyUtil.clone(_skill);
         for(i in _arr)
         {
            if(_arr[i] > 0)
            {
               _arr[i] = SkillFactory.getSkillById(_arr[i]).getTypeId();
            }
         }
         return _arr;
      }
      
      public function getPetSkillNum(num:Number) : Skill
      {
         return SkillFactory.getSkillById(_skill[num]);
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
      
      public function getEvolution() : Number
      {
         return PetFactory.getEvolution(_id.getValue());
      }
      
      public function getEvolutionLV() : Number
      {
         return PetFactory.getEvolutionLV(_id.getValue());
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
      
      public function getWXLV() : *
      {
         return PetFactory.getWuxingLV(_id.getValue());
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
      
      public function get wuxing() : VT
      {
         return _wuxing;
      }
      
      public function set wuxing(value:VT) : void
      {
         _wuxing = value;
      }
      
      public function get skill() : Array
      {
         return _skill;
      }
      
      public function set skill(value:Array) : void
      {
         _skill = value;
      }
   }
}

