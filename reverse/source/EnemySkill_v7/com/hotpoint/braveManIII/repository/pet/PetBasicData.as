package com.hotpoint.braveManIII.repository.pet
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.pet.*;
   
   public class PetBasicData
   {
      
      private var _id:VT;
      
      private var _name:String;
      
      private var _className:String;
      
      private var _type:VT;
      
      private var _frame:VT;
      
      private var _introduction:String;
      
      private var _evolution:VT;
      
      private var _evolutionLV:VT;
      
      private var _wuxingLV:VT;
      
      private var _att:VT;
      
      private var _def:VT;
      
      private var _crit:VT;
      
      private var _life:VT;
      
      private var _attup:VT;
      
      private var _defup:VT;
      
      private var _critup:VT;
      
      private var _lifeup:VT;
      
      private var _linkValue:VT;
      
      public function PetBasicData()
      {
         super();
      }
      
      public static function creatPetBasicData(param1:Number, param2:String, param3:String, param4:Number, param5:Number, param6:String, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number, param16:Number, param17:Number, param18:Number) : PetBasicData
      {
         var _loc19_:PetBasicData = new PetBasicData();
         _loc19_._id = VT.createVT(param1);
         _loc19_._name = param2;
         _loc19_._className = param3;
         _loc19_._type = VT.createVT(param4);
         _loc19_._frame = VT.createVT(param5);
         _loc19_._introduction = param6;
         _loc19_._evolution = VT.createVT(param7);
         _loc19_._evolutionLV = VT.createVT(param8);
         _loc19_._wuxingLV = VT.createVT(param9);
         _loc19_._att = VT.createVT(param10);
         _loc19_._def = VT.createVT(param11);
         _loc19_._crit = VT.createVT(param12);
         _loc19_._life = VT.createVT(param13);
         _loc19_._attup = VT.createVT(param14);
         _loc19_._defup = VT.createVT(param15);
         _loc19_._critup = VT.createVT(param16);
         _loc19_._lifeup = VT.createVT(param17);
         _loc19_._linkValue = VT.createVT(param18);
         return _loc19_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function set className(param1:String) : void
      {
         _className = param1;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(param1:VT) : void
      {
         _type = param1;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(param1:VT) : void
      {
         _frame = param1;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         _introduction = param1;
      }
      
      public function get att() : VT
      {
         return _att;
      }
      
      public function set att(param1:VT) : void
      {
         _att = param1;
      }
      
      public function get def() : VT
      {
         return _def;
      }
      
      public function set def(param1:VT) : void
      {
         _def = param1;
      }
      
      public function get crit() : VT
      {
         return _crit;
      }
      
      public function set crit(param1:VT) : void
      {
         _crit = param1;
      }
      
      public function get life() : VT
      {
         return _life;
      }
      
      public function set life(param1:VT) : void
      {
         _life = param1;
      }
      
      public function get attup() : VT
      {
         return _attup;
      }
      
      public function set attup(param1:VT) : void
      {
         _attup = param1;
      }
      
      public function get defup() : VT
      {
         return _defup;
      }
      
      public function set defup(param1:VT) : void
      {
         _defup = param1;
      }
      
      public function get critup() : VT
      {
         return _critup;
      }
      
      public function set critup(param1:VT) : void
      {
         _critup = param1;
      }
      
      public function get lifeup() : VT
      {
         return _lifeup;
      }
      
      public function set lifeup(param1:VT) : void
      {
         _lifeup = param1;
      }
      
      public function get linkValue() : VT
      {
         return _linkValue;
      }
      
      public function set linkValue(param1:VT) : void
      {
         _linkValue = param1;
      }
      
      public function get evolution() : VT
      {
         return _evolution;
      }
      
      public function set evolution(param1:VT) : void
      {
         _evolution = param1;
      }
      
      public function get evolutionLV() : VT
      {
         return _evolutionLV;
      }
      
      public function set evolutionLV(param1:VT) : void
      {
         _evolutionLV = param1;
      }
      
      public function get wuxingLV() : VT
      {
         return _wuxingLV;
      }
      
      public function set wuxingLV(param1:VT) : void
      {
         _wuxingLV = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getClassName() : String
      {
         return _className;
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getEvolution() : Number
      {
         return _evolution.getValue();
      }
      
      public function getEvolutionLV() : Number
      {
         return _evolutionLV.getValue();
      }
      
      public function getWuxingLV() : Number
      {
         return _wuxingLV.getValue();
      }
      
      public function getAtt() : Number
      {
         return _att.getValue();
      }
      
      public function getDef() : Number
      {
         return _def.getValue();
      }
      
      public function getCrit() : Number
      {
         return _crit.getValue();
      }
      
      public function getLife() : Number
      {
         return _life.getValue();
      }
      
      public function getAttup() : Number
      {
         return _attup.getValue();
      }
      
      public function getDefup() : Number
      {
         return _defup.getValue();
      }
      
      public function getCritup() : Number
      {
         return _critup.getValue();
      }
      
      public function getLifeup() : Number
      {
         return _lifeup.getValue();
      }
      
      public function getLink() : Number
      {
         return _linkValue.getValue();
      }
      
      public function creatPet() : Pet
      {
         return Pet.creatPet(_id.getValue(),_att.getValue(),_def.getValue(),_crit.getValue(),_life.getValue());
      }
   }
}

