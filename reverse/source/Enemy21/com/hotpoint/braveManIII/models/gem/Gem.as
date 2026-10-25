package com.hotpoint.braveManIII.models.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import flash.utils.*;
   import src.*;
   
   public class Gem
   {
      
      private var _id:VT;
      
      private var _gemAttribute:Array = [];
      
      private var _times:VT;
      
      public function Gem()
      {
         super();
      }
      
      public static function creatGem(id:Number, times:Number, att:Array) : Gem
      {
         var gem:Gem = new Gem();
         gem._id = VT.createVT(id);
         gem._gemAttribute = att;
         gem._times = VT.createVT(times);
         return gem;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = value;
      }
      
      public function get gemAttribute() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._gemAttribute;
      }
      
      public function set gemAttribute(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gemAttribute = value;
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._times = value;
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
         var returnAttrib:Array = [];
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
      
      public function compareById(id:Number) : Boolean
      {
         if(this._id.getValue() == id)
         {
            return true;
         }
         return false;
      }
      
      public function testGem(gg:Gem) : *
      {
         if(this == gg)
         {
            SaveXX.Save(7,123);
         }
      }
      
      public function compareGem(gg:Gem) : Boolean
      {
         if(this._id.getValue() == gg._id.getValue())
         {
            return true;
         }
         return false;
      }
      
      public function showGemAttrib() : Array
      {
         var attrib:Attribute = null;
         var arr:Array = [];
         for each(attrib in this._gemAttribute)
         {
            arr.push(EquipBaseAttribTypeConst.getDescription(attrib.getAttribType(),attrib.getValue()));
         }
         return arr;
      }
      
      public function useGem(ts:Number) : Boolean
      {
         if(this._times.getValue() >= ts)
         {
            this._times.setValue(this._times.getValue() - ts);
            if(this._times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function addGem(ts:Number) : Boolean
      {
         if(this._times.getValue() + ts <= this.getPileLimit())
         {
            this._times.setValue(this._times.getValue() + ts);
            return true;
         }
         return false;
      }
      
      public function cloneGem(ts:Number) : Gem
      {
         return creatGem(this._id.getValue(),ts,this._gemAttribute);
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
   }
}

