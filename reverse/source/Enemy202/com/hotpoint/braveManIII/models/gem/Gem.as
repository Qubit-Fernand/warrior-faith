package com.hotpoint.braveManIII.models.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class Gem
   {
      
      private var _id:VT;
      
      private var _gemAttribute:Array = [];
      
      private var _times:VT;
      
      public function Gem()
      {
         super();
      }
      
      public static function creatGem(param1:Number, param2:Number, param3:Array) : Gem
      {
         var _loc4_:Gem = new Gem();
         _loc4_._id = VT.createVT(param1);
         _loc4_._gemAttribute = param3;
         _loc4_._times = VT.createVT(param2);
         return _loc4_;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = param1;
      }
      
      public function get gemAttribute() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._gemAttribute;
      }
      
      public function set gemAttribute(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gemAttribute = param1;
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._times;
      }
      
      public function set times(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._times = param1;
      }
      
      public function getFrame() : Number
      {
         return GemFactory.findFrame(this._id.getValue());
      }
      
      public function getName() : String
      {
         return GemFactory.findName(this._id.getValue());
      }
      
      public function getDescript() : String
      {
         return GemFactory.findDescript(this._id.getValue());
      }
      
      public function getType() : int
      {
         return GemFactory.findType(this._id.getValue());
      }
      
      public function getIsPile() : Boolean
      {
         return GemFactory.findIsPile(this._id.getValue());
      }
      
      public function getIsStrengthen() : Boolean
      {
         return GemFactory.findIsStrengthen(this._id.getValue());
      }
      
      public function getIsCompound() : Boolean
      {
         return GemFactory.findIsCompound(this._id.getValue());
      }
      
      public function getDropLevel() : Number
      {
         return GemFactory.findDropLevel(this._id.getValue());
      }
      
      public function getUseLevel() : Number
      {
         return GemFactory.findUseLevel(this._id.getValue());
      }
      
      public function getPileLimit() : Number
      {
         return GemFactory.findPileLimit(this._id.getValue());
      }
      
      public function getPrice() : Number
      {
         return GemFactory.findPrice(this._id.getValue());
      }
      
      public function getColor() : Number
      {
         return GemFactory.findColor(this._id.getValue());
      }
      
      public function getProbability() : Number
      {
         return GemFactory.findProbability(this._id.getValue());
      }
      
      public function getStrengthenLevel() : Number
      {
         return GemFactory.findStrengthenLevel(this._id.getValue());
      }
      
      public function getGemSkill() : Number
      {
         return GemFactory.findSkill(this._id.getValue());
      }
      
      public function getGemAttrib() : Array
      {
         var _loc1_:Array = [];
         return this._gemAttribute.slice(0);
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function setUpGem() : Gem
      {
         return GemFactory.createGemByStrengthen(this.getName(),this.getStrengthenLevel());
      }
      
      public function compareById(param1:Number) : Boolean
      {
         if(this._id.getValue() == param1)
         {
            return true;
         }
         return false;
      }
      
      public function compareGem(param1:Gem) : Boolean
      {
         if(this._id.getValue() == param1._id.getValue())
         {
            return true;
         }
         return false;
      }
      
      public function showGemAttrib() : Array
      {
         var _loc2_:Attribute = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._gemAttribute)
         {
            _loc1_.push(EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue()));
         }
         return _loc1_;
      }
      
      public function useGem(param1:Number) : Boolean
      {
         CheckTest.Testing();
         if(this._times.getValue() >= param1)
         {
            this._times.setValue(this._times.getValue() - param1);
            CheckTest.setMD5();
            if(this._times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function addGem(param1:Number) : Boolean
      {
         CheckTest.Testing();
         if(this._times.getValue() + param1 <= this.getPileLimit())
         {
            this._times.setValue(this._times.getValue() + param1);
            CheckTest.setMD5();
            return true;
         }
         return false;
      }
      
      public function cloneGem(param1:Number) : Gem
      {
         return creatGem(this._id.getValue(),param1,this._gemAttribute);
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
   }
}

