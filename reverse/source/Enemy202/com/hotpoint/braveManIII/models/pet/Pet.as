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
      
      public static function creatPet(param1:*, param2:*, param3:*, param4:*, param5:*) : Pet
      {
         var _loc6_:Pet = new Pet();
         _loc6_._id = VT.createVT(param1);
         _loc6_._lvlimit = VT.createVT(20);
         _loc6_._lv = VT.createVT(1);
         _loc6_._food = VT.createVT(50);
         _loc6_._exp = VT.createVT(0);
         _loc6_._att = VT.createVT(param2);
         _loc6_._def = VT.createVT(param3);
         _loc6_._crit = VT.createVT(param4);
         _loc6_._life = VT.createVT(param5);
         if(_loc6_.getWXLV() > 0)
         {
            _loc6_._wuxing = VT.createVT(Math.round(Math.random() * 3) + 1);
         }
         else
         {
            _loc6_._wuxing = VT.createVT(0);
         }
         return _loc6_;
      }
      
      public function getLv() : Number
      {
         return this._lv.getValue();
      }
      
      public function setLv(param1:Number) : *
      {
         this._lv.setValue(param1);
         this.addSkill();
      }
      
      public function setFood(param1:Number) : *
      {
         this._food.setValue(this._food.getValue() + param1);
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
      
      public function setExp(param1:Number) : *
      {
         this._exp.setValue(param1);
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
      
      public function addExp(param1:Number) : *
      {
         this._exp.setValue(this._exp.getValue() + param1);
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
      
      public function setSkill(param1:Number) : *
      {
         this._skill[param1] = SkillFactory.getSkillByPet(this._id.getValue());
      }
      
      public function getPetSkill() : Array
      {
         return this._skill;
      }
      
      public function getPetSkillType() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = DeepCopyUtil.clone(this._skill);
         for(_loc2_ in _loc1_)
         {
            if(_loc1_[_loc2_] > 0)
            {
               _loc1_[_loc2_] = SkillFactory.getSkillById(_loc1_[_loc2_]).getTypeId();
            }
         }
         return _loc1_;
      }
      
      public function getPetSkillNum(param1:Number) : Skill
      {
         return SkillFactory.getSkillById(this._skill[param1]);
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
      
      public function set id(param1:VT) : void
      {
         this._id = param1;
      }
      
      public function get lv() : VT
      {
         return this._lv;
      }
      
      public function set lv(param1:VT) : void
      {
         this._lv = param1;
      }
      
      public function get lvlimit() : VT
      {
         return this._lvlimit;
      }
      
      public function set lvlimit(param1:VT) : void
      {
         this._lvlimit = param1;
      }
      
      public function get food() : VT
      {
         return this._food;
      }
      
      public function set food(param1:VT) : void
      {
         this._food = param1;
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
      
      public function get life() : VT
      {
         return this._life;
      }
      
      public function set life(param1:VT) : void
      {
         this._life = param1;
      }
      
      public function get exp() : VT
      {
         return this._exp;
      }
      
      public function set exp(param1:VT) : void
      {
         this._exp = param1;
      }
      
      public function get wuxing() : VT
      {
         return this._wuxing;
      }
      
      public function set wuxing(param1:VT) : void
      {
         this._wuxing = param1;
      }
      
      public function get skill() : Array
      {
         return this._skill;
      }
      
      public function set skill(param1:Array) : void
      {
         this._skill = param1;
      }
   }
}

