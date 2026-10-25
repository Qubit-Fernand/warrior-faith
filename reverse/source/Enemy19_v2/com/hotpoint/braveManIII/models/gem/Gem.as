package com.hotpoint.braveManIII.models.gem
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   
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
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get gemAttribute() : Array
      {
         return _gemAttribute;
      }
      
      public function set gemAttribute(value:Array) : void
      {
         _gemAttribute = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
      }
      
      public function getFrame() : Number
      {
         return GemFactory.findFrame(_id.getValue());
      }
      
      public function getName() : String
      {
         return GemFactory.findName(_id.getValue());
      }
      
      public function getDescript() : String
      {
         return GemFactory.findDescript(_id.getValue());
      }
      
      public function getType() : int
      {
         return GemFactory.findType(_id.getValue());
      }
      
      public function getIsPile() : Boolean
      {
         return GemFactory.findIsPile(_id.getValue());
      }
      
      public function getIsStrengthen() : Boolean
      {
         return GemFactory.findIsStrengthen(_id.getValue());
      }
      
      public function getIsCompound() : Boolean
      {
         return GemFactory.findIsCompound(_id.getValue());
      }
      
      public function getDropLevel() : Number
      {
         return GemFactory.findDropLevel(_id.getValue());
      }
      
      public function getUseLevel() : Number
      {
         return GemFactory.findUseLevel(_id.getValue());
      }
      
      public function getPileLimit() : Number
      {
         return GemFactory.findPileLimit(_id.getValue());
      }
      
      public function getPrice() : Number
      {
         return GemFactory.findPrice(_id.getValue());
      }
      
      public function getColor() : Number
      {
         return GemFactory.findColor(_id.getValue());
      }
      
      public function getProbability() : Number
      {
         return GemFactory.findProbability(_id.getValue());
      }
      
      public function getStrengthenLevel() : Number
      {
         return GemFactory.findStrengthenLevel(_id.getValue());
      }
      
      public function getGemSkill() : Number
      {
         return GemFactory.findSkill(_id.getValue());
      }
      
      public function getGemAttrib() : Array
      {
         var returnAttrib:Array = [];
         return _gemAttribute.slice(0);
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function setUpGem() : Gem
      {
         return GemFactory.createGemByStrengthen(getName(),getStrengthenLevel());
      }
      
      public function compareById(id:Number) : Boolean
      {
         if(this._id.getValue() == id)
         {
            return true;
         }
         return false;
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
         for each(attrib in _gemAttribute)
         {
            arr.push(EquipBaseAttribTypeConst.getDescription(attrib.getAttribType(),attrib.getValue()));
         }
         return arr;
      }
      
      public function useGem(ts:Number) : Boolean
      {
         if(_times.getValue() >= ts)
         {
            _times.setValue(_times.getValue() - ts);
            if(_times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function addGem(ts:Number) : Boolean
      {
         if(_times.getValue() + ts <= this.getPileLimit())
         {
            _times.setValue(_times.getValue() + ts);
            return true;
         }
         return false;
      }
      
      public function cloneGem(ts:Number) : Gem
      {
         return creatGem(_id.getValue(),ts,_gemAttribute);
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
   }
}

