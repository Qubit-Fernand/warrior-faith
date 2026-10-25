package com.hotpoint.braveManIII.models.supplies
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   
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
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(param1:VT) : void
      {
         _times = param1;
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function setTimes(param1:Number) : void
      {
         _times.setValue(param1);
      }
      
      public function getFrame() : Number
      {
         return SuppliesFactory.findFrame(_id.getValue());
      }
      
      public function getName() : String
      {
         return SuppliesFactory.findName(_id.getValue());
      }
      
      public function getUseLevel() : Number
      {
         return SuppliesFactory.findUseLevel(_id.getValue());
      }
      
      public function getPrice() : Number
      {
         return SuppliesFactory.findPrice(_id.getValue());
      }
      
      public function getIsPile() : Boolean
      {
         return SuppliesFactory.findIsPile(_id.getValue());
      }
      
      public function getDropLevel() : Number
      {
         return SuppliesFactory.findDropLevel(_id.getValue());
      }
      
      public function getDescript() : String
      {
         return SuppliesFactory.findDescript(_id.getValue());
      }
      
      public function getCoolDowns() : Number
      {
         return SuppliesFactory.findCoolDowns(_id.getValue());
      }
      
      public function getColor() : Number
      {
         return SuppliesFactory.findColor(_id.getValue());
      }
      
      public function getAffectMode() : Number
      {
         return SuppliesFactory.findAffectMode(_id.getValue());
      }
      
      public function getDuration() : Number
      {
         return SuppliesFactory.findDuration(_id.getValue());
      }
      
      public function getAffectAttrib() : Array
      {
         return SuppliesFactory.findAffect(_id.getValue());
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
         if(_times.getValue() >= param1)
         {
            _times.setValue(_times.getValue() - param1);
            return true;
         }
         return false;
      }
      
      public function getClone() : Supplies
      {
         return Supplies.creatSupplies(_id.getValue(),_times.getValue());
      }
   }
}

