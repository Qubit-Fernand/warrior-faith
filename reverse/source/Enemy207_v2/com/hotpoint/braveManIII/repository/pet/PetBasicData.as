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
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function set className(value:String) : void
      {
         _className = value;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(value:VT) : void
      {
         _type = value;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(value:String) : void
      {
         _introduction = value;
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
      
      public function get attup() : VT
      {
         return _attup;
      }
      
      public function set attup(value:VT) : void
      {
         _attup = value;
      }
      
      public function get defup() : VT
      {
         return _defup;
      }
      
      public function set defup(value:VT) : void
      {
         _defup = value;
      }
      
      public function get critup() : VT
      {
         return _critup;
      }
      
      public function set critup(value:VT) : void
      {
         _critup = value;
      }
      
      public function get lifeup() : VT
      {
         return _lifeup;
      }
      
      public function set lifeup(value:VT) : void
      {
         _lifeup = value;
      }
      
      public function get linkValue() : VT
      {
         return _linkValue;
      }
      
      public function set linkValue(value:VT) : void
      {
         _linkValue = value;
      }
      
      public function get evolution() : VT
      {
         return _evolution;
      }
      
      public function set evolution(value:VT) : void
      {
         _evolution = value;
      }
      
      public function get evolutionLV() : VT
      {
         return _evolutionLV;
      }
      
      public function set evolutionLV(value:VT) : void
      {
         _evolutionLV = value;
      }
      
      public function get wuxingLV() : VT
      {
         return _wuxingLV;
      }
      
      public function set wuxingLV(value:VT) : void
      {
         _wuxingLV = value;
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

