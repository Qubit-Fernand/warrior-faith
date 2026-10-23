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
         return this._lv.getValue();
      }
      
      public function setLv(level:Number) : *
      {
         this._lv.setValue(level);
         this.addSkill();
      }
      
      public function setFood(num:Number) : *
      {
         this._food.setValue(this._food.getValue() + num);
         if(this._food.getValue() < 0)
         {
            this._food.setValue(0);
         }
         if(this._food.getValue() > 100)
         {
            this._food.setValue(100);
         }
      }
      
      public function getLvLimit() : Number
      {
         return this._lvlimit.getValue();
      }
      
      public function getFood() : Number
      {
         return this._food.getValue();
      }
      
      public function getAtt() : Number
      {
         return this._att.getValue() + this.getAttup() * this.getLv();
      }
      
      public function getDef() : Number
      {
         return this._def.getValue() + this.getDefup() * this.getLv();
      }
      
      public function getCrit() : Number
      {
         return this._crit.getValue() + this.getCritup() * this.getLv();
      }
      
      public function getLife() : Number
      {
         return this._life.getValue() + this.getLifeup() * this.getLv();
      }
      
      public function getExp() : Number
      {
         return this._exp.getValue();
      }
      
      public function setExp(num:Number) : *
      {
         this._exp.setValue(num);
      }
      
      public function setWX() : *
      {
         if(this.getWXLV() > 0)
         {
            this._wuxing.setValue(Math.round(Math.random() * 3) + 1);
         }
         this.addSkill();
      }
      
      public function getWX() : Number
      {
         return this._wuxing.getValue();
      }
      
      public function addExp(num:Number) : *
      {
         this._exp.setValue(this._exp.getValue() + num);
         if(PetFactory.all_LVData_vt[this.getLv() - 1].getValue() < this._exp.getValue() && this.getLv() < this.getLvLimit())
         {
            this.setLv(this.getLv() + 1);
            this.setExp(0);
            return true;
         }
         return false;
      }
      
      public function addSkill() : *
      {
         if(this.getWX() == 4)
         {
            if(this.getLv() >= 5 && this._skill[0] == -1)
            {
               this._skill[0] = 0;
            }
            if(this.getLv() >= 10 && this._skill[1] == -1)
            {
               this._skill[1] = 0;
            }
            if(this.getLv() >= 15 && this._skill[2] == -1)
            {
               this._skill[2] = 0;
            }
            if(this.getLv() >= 20 && this._skill[3] == -1)
            {
               this._skill[3] = 0;
            }
         }
         if(this.getWX() == 3)
         {
            if(this.getLv() >= 5 && this._skill[0] == -1)
            {
               this._skill[0] = 0;
            }
            if(this.getLv() >= 10 && this._skill[1] == -1)
            {
               this._skill[1] = 0;
            }
            if(this.getLv() >= 15 && this._skill[2] == -1)
            {
               this._skill[2] = 0;
            }
         }
         if(this.getWX() == 2)
         {
            if(this.getLv() >= 5 && this._skill[0] == -1)
            {
               this._skill[0] = 0;
            }
            if(this.getLv() >= 10 && this._skill[1] == -1)
            {
               this._skill[1] = 0;
            }
         }
         if(this.getWX() == 1)
         {
            if(this.getLv() >= 5 && this._skill[0] == -1)
            {
               this._skill[0] = 0;
            }
         }
      }
      
      public function setSkill(num:Number) : *
      {
         this._skill[num] = SkillFactory.getSkillByPet(this._id.getValue());
      }
      
      public function getPetSkill() : Array
      {
         return this._skill;
      }
      
      public function getPetSkillType() : Array
      {
         var i:* = undefined;
         var _arr:Array = DeepCopyUtil.clone(this._skill);
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
         return SkillFactory.getSkillById(this._skill[num]);
      }
      
      public function getName() : String
      {
         return PetFactory.getName(this._id.getValue());
      }
      
      public function getFrame() : Number
      {
         return PetFactory.getFrame(this._id.getValue());
      }
      
      public function getType() : Number
      {
         return PetFactory.getType(this._id.getValue());
      }
      
      public function getClassName() : String
      {
         return PetFactory.getClassName(this._id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return PetFactory.getIntroduction(this._id.getValue());
      }
      
      public function getEvolution() : Number
      {
         return PetFactory.getEvolution(this._id.getValue());
      }
      
      public function getEvolutionLV() : Number
      {
         return PetFactory.getEvolutionLV(this._id.getValue());
      }
      
      public function getAttup() : Number
      {
         return PetFactory.getAttup(this._id.getValue());
      }
      
      public function getDefup() : Number
      {
         return PetFactory.getDefup(this._id.getValue());
      }
      
      public function getCritup() : Number
      {
         return PetFactory.getCritup(this._id.getValue());
      }
      
      public function getLifeup() : Number
      {
         return PetFactory.getLifeup(this._id.getValue());
      }
      
      public function getLink() : Number
      {
         return PetFactory.getLink(this._id.getValue());
      }
      
      public function getWXLV() : *
      {
         return PetFactory.getWuxingLV(this._id.getValue());
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get lv() : VT
      {
         return this._lv;
      }
      
      public function set lv(value:VT) : void
      {
         this._lv = value;
      }
      
      public function get lvlimit() : VT
      {
         return this._lvlimit;
      }
      
      public function set lvlimit(value:VT) : void
      {
         this._lvlimit = value;
      }
      
      public function get food() : VT
      {
         return this._food;
      }
      
      public function set food(value:VT) : void
      {
         this._food = value;
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
      
      public function get life() : VT
      {
         return this._life;
      }
      
      public function set life(value:VT) : void
      {
         this._life = value;
      }
      
      public function get exp() : VT
      {
         return this._exp;
      }
      
      public function set exp(value:VT) : void
      {
         this._exp = value;
      }
      
      public function get wuxing() : VT
      {
         return this._wuxing;
      }
      
      public function set wuxing(value:VT) : void
      {
         this._wuxing = value;
      }
      
      public function get skill() : Array
      {
         return this._skill;
      }
      
      public function set skill(value:Array) : void
      {
         this._skill = value;
      }
   }
}

