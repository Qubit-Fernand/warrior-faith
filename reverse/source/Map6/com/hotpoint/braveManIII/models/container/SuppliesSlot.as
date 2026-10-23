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
         var ss:SuppliesSlot = null;
         var i:int = 0;
         ss = new SuppliesSlot();
         for(i = 0; i < 3; i++)
         {
            ss._suppliesSlot[i] = null;
         }
         return ss;
      }
      
      public function getNumFromSuppliesSlot(bag:Bag, num:Number) : Number
      {
         var n:int = 0;
         var i:int = 0;
         n = 0;
         if(_suppliesSlot[num] != null)
         {
            for(i = 0; i < 24; i++)
            {
               if(bag.getSuppliesFromBag(i) != null)
               {
                  if(bag.getSuppliesFromBag(i).getName() == getFromSuppliesSlot(num).getName())
                  {
                     n++;
                  }
               }
            }
         }
         return n;
      }
      
      public function setToSuppliesSlot(value:Supplies, num:Number) : Boolean
      {
         _suppliesSlot[num] = value;
         return true;
      }
      
      public function getFromSuppliesSlot(num:Number) : Supplies
      {
         if(_suppliesSlot[num] != null)
         {
            return _suppliesSlot[num];
         }
         return null;
      }
      
      public function get suppliesSlot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesSlot;
      }
      
      public function useSupplies(bag:Bag, num:Number) : Supplies
      {
         var n:int = 0;
         var i:int = 0;
         n = 0;
         if(_suppliesSlot[num] != null)
         {
            for(i = 0; i < 24; i++)
            {
               if(bag.getSuppliesFromBag(i) != null)
               {
                  if(bag.getSuppliesFromBag(i).getName() == getFromSuppliesSlot(num).getName())
                  {
                     return bag.delSupplies(i);
                  }
               }
            }
         }
         return null;
      }
      
      public function set suppliesSlot(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesSlot = value;
      }
   }
}

