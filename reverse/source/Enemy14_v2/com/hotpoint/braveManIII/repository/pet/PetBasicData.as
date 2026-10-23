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
      
      public static function creatPetBasicData(id:Number, name:String, className:String, type:Number, frame:Number, introduction:String, evolution:Number, evolutionLV:Number, wuxingLV:Number, att:Number, def:Number, crit:Number, life:Number, attup:Number, defup:Number, critup:Number, lifeup:Number, linkValue:Number) : PetBasicData
      {
         var pet:PetBasicData = new PetBasicData();
         pet._id = VT.createVT(id);
         pet._name = name;
         pet._className = className;
         pet._type = VT.createVT(type);
         pet._frame = VT.createVT(frame);
         pet._introduction = introduction;
         pet._evolution = VT.createVT(evolution);
         pet._evolutionLV = VT.createVT(evolutionLV);
         pet._wuxingLV = VT.createVT(wuxingLV);
         pet._att = VT.createVT(att);
         pet._def = VT.createVT(def);
         pet._crit = VT.createVT(crit);
         pet._life = VT.createVT(life);
         pet._attup = VT.createVT(attup);
         pet._defup = VT.createVT(defup);
         pet._critup = VT.createVT(critup);
         pet._lifeup = VT.createVT(lifeup);
         pet._linkValue = VT.createVT(linkValue);
         return pet;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get className() : String
      {
         return this._className;
      }
      
      public function set className(value:String) : void
      {
         this._className = value;
      }
      
      public function get type() : VT
      {
         return this._type;
      }
      
      public function set type(value:VT) : void
      {
         this._type = value;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(value:VT) : void
      {
         this._frame = value;
      }
      
      public function get introduction() : String
      {
         return this._introduction;
      }
      
      public function set introduction(value:String) : void
      {
         this._introduction = value;
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
      
      public function get attup() : VT
      {
         return this._attup;
      }
      
      public function set attup(value:VT) : void
      {
         this._attup = value;
      }
      
      public function get defup() : VT
      {
         return this._defup;
      }
      
      public function set defup(value:VT) : void
      {
         this._defup = value;
      }
      
      public function get critup() : VT
      {
         return this._critup;
      }
      
      public function set critup(value:VT) : void
      {
         this._critup = value;
      }
      
      public function get lifeup() : VT
      {
         return this._lifeup;
      }
      
      public function set lifeup(value:VT) : void
      {
         this._lifeup = value;
      }
      
      public function get linkValue() : VT
      {
         return this._linkValue;
      }
      
      public function set linkValue(value:VT) : void
      {
         this._linkValue = value;
      }
      
      public function get evolution() : VT
      {
         return this._evolution;
      }
      
      public function set evolution(value:VT) : void
      {
         this._evolution = value;
      }
      
      public function get evolutionLV() : VT
      {
         return this._evolutionLV;
      }
      
      public function set evolutionLV(value:VT) : void
      {
         this._evolutionLV = value;
      }
      
      public function get wuxingLV() : VT
      {
         return this._wuxingLV;
      }
      
      public function set wuxingLV(value:VT) : void
      {
         this._wuxingLV = value;
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

