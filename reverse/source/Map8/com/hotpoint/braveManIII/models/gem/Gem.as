package com.hotpoint.braveManIII.models.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import flash.utils.*;
   
   public class Gem
   {
      
      private var _id:VT;
      
      private var _times:VT;
      
      private var _gemAttribute:Array = [];
      
      public function Gem()
      {
         super();
      }
      
      public static function creatGem(param1:Number, param2:Number, param3:Array) : Gem
      {
         var _loc4_:Gem = null;
         _loc4_ = new Gem();
         _loc4_._id = VT.createVT(param1);
         _loc4_._gemAttribute = param3;
         _loc4_._times = VT.createVT(param2);
         return _loc4_;
      }
      
      public function getDescript() : String
      {
         return GemFactory.findDescript(_id.getValue());
      }
      
      public function getGemAttrib() : Array
      {
         var _loc1_:Array = null;
         _loc1_ = [];
         return _gemAttribute.slice(0);
      }
      
      public function getStrengthenLevel() : Number
      {
         return GemFactory.findStrengthenLevel(_id.getValue());
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _times;
      }
      
      public function getName() : String
      {
         return GemFactory.findName(_id.getValue());
      }
      
      public function cloneGem(param1:Number) : Gem
      {
         return creatGem(_id.getValue(),param1,_gemAttribute);
      }
      
      public function set times(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _times = param1;
      }
      
      public function get gemAttribute() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemAttribute;
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getPrice() : Number
      {
         return GemFactory.findPrice(_id.getValue());
      }
      
      public function useGem(param1:Number) : Boolean
      {
         if(_times.getValue() >= param1)
         {
            _times.setValue(_times.getValue() - param1);
            if(_times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function set gemAttribute(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemAttribute = param1;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _id;
      }
      
      public function getDropLevel() : Number
      {
         return GemFactory.findDropLevel(_id.getValue());
      }
      
      public function getIsStrengthen() : Boolean
      {
         return GemFactory.findIsStrengthen(_id.getValue());
      }
      
      public function getIsCompound() : Boolean
      {
         return GemFactory.findIsCompound(_id.getValue());
      }
      
      public function getColor() : Number
      {
         return GemFactory.findColor(_id.getValue());
      }
      
      public function addGem(param1:Number) : Boolean
      {
         if(_times.getValue() + param1 <= this.getPileLimit())
         {
            _times.setValue(_times.getValue() + param1);
            return true;
         }
         return false;
      }
      
      public function getType() : int
      {
         return GemFactory.findType(_id.getValue());
      }
      
      public function compareGem(param1:Gem) : Boolean
      {
         if(this._id.getValue() == param1._id.getValue())
         {
            return true;
         }
         return false;
      }
      
      public function getIsPile() : Boolean
      {
         return GemFactory.findIsPile(_id.getValue());
      }
      
      public function getPileLimit() : Number
      {
         return GemFactory.findPileLimit(_id.getValue());
      }
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = param1;
      }
      
      public function getFrame() : Number
      {
         return GemFactory.findFrame(_id.getValue());
      }
      
      public function getGemSkill() : Number
      {
         return GemFactory.findSkill(_id.getValue());
      }
      
      public function setUpGem() : Gem
      {
         return GemFactory.createGemByStrengthen(getName(),getStrengthenLevel());
      }
      
      public function getUseLevel() : Number
      {
         return GemFactory.findUseLevel(_id.getValue());
      }
      
      public function showGemAttrib() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Attribute = null;
         _loc1_ = [];
         for each(_loc2_ in _gemAttribute)
         {
            _loc1_.push(EquipBaseAttribTypeConst.getDescription(_loc2_.getAttribType(),_loc2_.getValue()));
         }
         return _loc1_;
      }
      
      public function getProbability() : Number
      {
         return GemFactory.findProbability(_id.getValue());
      }
   }
}

