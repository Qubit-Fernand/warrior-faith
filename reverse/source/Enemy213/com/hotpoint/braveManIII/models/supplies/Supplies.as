package com.hotpoint.braveManIII.models.supplies
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import flash.utils.*;
   
   public class Supplies
   {
      
      private var _id:VT;
      
      private var _times:VT;
      
      public function Supplies()
      {
         super();
      }
      
      public static function creatSupplies(param1:Number, param2:Number) : Supplies
      {
         var _loc3_:Supplies = new Supplies();
         _loc3_._id = VT.createVT(param1);
         _loc3_._times = VT.createVT(param2);
         return _loc3_;
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
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function setTimes(param1:Number) : void
      {
         this._times.setValue(param1);
      }
      
      public function getFrame() : Number
      {
         return SuppliesFactory.findFrame(this._id.getValue());
      }
      
      public function getName() : String
      {
         return SuppliesFactory.findName(this._id.getValue());
      }
      
      public function getUseLevel() : Number
      {
         return SuppliesFactory.findUseLevel(this._id.getValue());
      }
      
      public function getPrice() : Number
      {
         return SuppliesFactory.findPrice(this._id.getValue());
      }
      
      public function getIsPile() : Boolean
      {
         return SuppliesFactory.findIsPile(this._id.getValue());
      }
      
      public function getDropLevel() : Number
      {
         return SuppliesFactory.findDropLevel(this._id.getValue());
      }
      
      public function getDescript() : String
      {
         return SuppliesFactory.findDescript(this._id.getValue());
      }
      
      public function getCoolDowns() : Number
      {
         return SuppliesFactory.findCoolDowns(this._id.getValue());
      }
      
      public function getColor() : Number
      {
         return SuppliesFactory.findColor(this._id.getValue());
      }
      
      public function getAffectMode() : Number
      {
         return SuppliesFactory.findAffectMode(this._id.getValue());
      }
      
      public function getDuration() : Number
      {
         return SuppliesFactory.findDuration(this._id.getValue());
      }
      
      public function getAffectAttrib() : Array
      {
         return SuppliesFactory.findAffect(this._id.getValue());
      }
      
      public function compareById(param1:Number) : Boolean
      {
         if(this._id.getValue() == param1)
         {
            return true;
         }
         return false;
      }
      
      public function useSupplies(param1:Number) : Boolean
      {
         if(this._times.getValue() >= param1)
         {
            this._times.setValue(this._times.getValue() - param1);
            return true;
         }
         return false;
      }
      
      public function getClone() : Supplies
      {
         return Supplies.creatSupplies(this._id.getValue(),this._times.getValue());
      }
   }
}

