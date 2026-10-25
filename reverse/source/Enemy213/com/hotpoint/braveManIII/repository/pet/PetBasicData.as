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
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         this._id = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get className() : String
      {
         return this._className;
      }
      
      public function set className(param1:String) : void
      {
         this._className = param1;
      }
      
      public function get type() : VT
      {
         return this._type;
      }
      
      public function set type(param1:VT) : void
      {
         this._type = param1;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(param1:VT) : void
      {
         this._frame = param1;
      }
      
      public function get introduction() : String
      {
         return this._introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         this._introduction = param1;
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
      
      public function get attup() : VT
      {
         return this._attup;
      }
      
      public function set attup(param1:VT) : void
      {
         this._attup = param1;
      }
      
      public function get defup() : VT
      {
         return this._defup;
      }
      
      public function set defup(param1:VT) : void
      {
         this._defup = param1;
      }
      
      public function get critup() : VT
      {
         return this._critup;
      }
      
      public function set critup(param1:VT) : void
      {
         this._critup = param1;
      }
      
      public function get lifeup() : VT
      {
         return this._lifeup;
      }
      
      public function set lifeup(param1:VT) : void
      {
         this._lifeup = param1;
      }
      
      public function get linkValue() : VT
      {
         return this._linkValue;
      }
      
      public function set linkValue(param1:VT) : void
      {
         this._linkValue = param1;
      }
      
      public function get evolution() : VT
      {
         return this._evolution;
      }
      
      public function set evolution(param1:VT) : void
      {
         this._evolution = param1;
      }
      
      public function get evolutionLV() : VT
      {
         return this._evolutionLV;
      }
      
      public function set evolutionLV(param1:VT) : void
      {
         this._evolutionLV = param1;
      }
      
      public function get wuxingLV() : VT
      {
         return this._wuxingLV;
      }
      
      public function set wuxingLV(param1:VT) : void
      {
         this._wuxingLV = param1;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getClassName() : String
      {
         return this._className;
      }
      
      public function getType() : Number
      {
         return this._type.getValue();
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getIntroduction() : String
      {
         return this._introduction;
      }
      
      public function getEvolution() : Number
      {
         return this._evolution.getValue();
      }
      
      public function getEvolutionLV() : Number
      {
         return this._evolutionLV.getValue();
      }
      
      public function getWuxingLV() : Number
      {
         return this._wuxingLV.getValue();
      }
      
      public function getAtt() : Number
      {
         return this._att.getValue();
      }
      
      public function getDef() : Number
      {
         return this._def.getValue();
      }
      
      public function getCrit() : Number
      {
         return this._crit.getValue();
      }
      
      public function getLife() : Number
      {
         return this._life.getValue();
      }
      
      public function getAttup() : Number
      {
         return this._attup.getValue();
      }
      
      public function getDefup() : Number
      {
         return this._defup.getValue();
      }
      
      public function getCritup() : Number
      {
         return this._critup.getValue();
      }
      
      public function getLifeup() : Number
      {
         return this._lifeup.getValue();
      }
      
      public function getLink() : Number
      {
         return this._linkValue.getValue();
      }
      
      public function creatPet() : Pet
      {
         return Pet.creatPet(this._id.getValue(),this._att.getValue(),this._def.getValue(),this._crit.getValue(),this._life.getValue());
      }
   }
}

