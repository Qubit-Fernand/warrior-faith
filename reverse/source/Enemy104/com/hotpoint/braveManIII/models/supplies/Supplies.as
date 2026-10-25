package com.hotpoint.braveManIII.models.supplies
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import flash.utils.*;
   
   public class Supplies
   {
      
      private var _times:VT;
      
      private var _id:VT;
      
      public function Supplies()
      {
         super();
      }
      
      public static function creatSupplies(id:Number, times:Number) : Supplies
      {
         var supplies:Supplies = null;
         supplies = new Supplies();
         supplies._id = VT.createVT(id);
         supplies._times = VT.createVT(times);
         return supplies;
      }
      
      public function getDescript() : String
      {
         return SuppliesFactory.findDescript(_id.getValue());
      }
      
      public function setTimes(value:Number) : void
      {
         _times.setValue(value);
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _times;
      }
      
      public function getName() : String
      {
         return SuppliesFactory.findName(_id.getValue());
      }
      
      public function getDuration() : Number
      {
         return SuppliesFactory.findDuration(_id.getValue());
      }
      
      public function set times(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _times = value;
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getCoolDowns() : Number
      {
         return SuppliesFactory.findCoolDowns(_id.getValue());
      }
      
      public function getPrice() : Number
      {
         return SuppliesFactory.findPrice(_id.getValue());
      }
      
      public function getAffectMode() : Number
      {
         return SuppliesFactory.findAffectMode(_id.getValue());
      }
      
      public function compareById(id:Number) : Boolean
      {
         if(this._id.getValue() == id)
         {
            return true;
         }
         return false;
      }
      
      public function get id() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _id;
      }
      
      public function getDropLevel() : Number
      {
         return SuppliesFactory.findDropLevel(_id.getValue());
      }
      
      public function getClone() : Supplies
      {
         return Supplies.creatSupplies(_id.getValue(),_times.getValue());
      }
      
      public function getColor() : Number
      {
         return SuppliesFactory.findColor(_id.getValue());
      }
      
      public function getIsPile() : Boolean
      {
         return SuppliesFactory.findIsPile(_id.getValue());
      }
      
      public function getUseLevel() : Number
      {
         return SuppliesFactory.findUseLevel(_id.getValue());
      }
      
      public function getAffectAttrib() : Array
      {
         return SuppliesFactory.findAffect(_id.getValue());
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = value;
      }
      
      public function getFrame() : Number
      {
         return SuppliesFactory.findFrame(_id.getValue());
      }
      
      public function useSupplies(ts:Number) : Boolean
      {
         if(_times.getValue() >= ts)
         {
            _times.setValue(_times.getValue() - ts);
            return true;
         }
         return false;
      }
   }
}

