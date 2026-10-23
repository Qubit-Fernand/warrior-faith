package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import flash.utils.*;
   
   public class SuppliesSlot
   {
      
      private var _suppliesSlot:Array = new Array();
      
      public function SuppliesSlot()
      {
         super();
      }
      
      public static function createSuppliesSlot() : SuppliesSlot
      {
         var _loc1_:SuppliesSlot = null;
         var _loc2_:int = 0;
         _loc1_ = new SuppliesSlot();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_._suppliesSlot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getNumFromSuppliesSlot(param1:Bag, param2:Number) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         if(_suppliesSlot[param2] != null)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(param1.getSuppliesFromBag(_loc4_) != null)
               {
                  if(param1.getSuppliesFromBag(_loc4_).getName() == getFromSuppliesSlot(param2).getName())
                  {
                     _loc3_++;
                  }
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      public function setToSuppliesSlot(param1:Supplies, param2:Number) : Boolean
      {
         _suppliesSlot[param2] = param1;
         return true;
      }
      
      public function getFromSuppliesSlot(param1:Number) : Supplies
      {
         if(_suppliesSlot[param1] != null)
         {
            return _suppliesSlot[param1];
         }
         return null;
      }
      
      public function get suppliesSlot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesSlot;
      }
      
      public function useSupplies(param1:Bag, param2:Number) : Supplies
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         if(_suppliesSlot[param2] != null)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(param1.getSuppliesFromBag(_loc4_) != null)
               {
                  if(param1.getSuppliesFromBag(_loc4_).getName() == getFromSuppliesSlot(param2).getName())
                  {
                     return param1.delSupplies(_loc4_);
                  }
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      public function set suppliesSlot(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesSlot = param1;
      }
   }
}

