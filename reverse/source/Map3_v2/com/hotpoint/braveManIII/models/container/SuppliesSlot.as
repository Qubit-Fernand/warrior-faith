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
         var ss:SuppliesSlot = new SuppliesSlot();
         for(var i:int = 0; i < 3; i++)
         {
            ss._suppliesSlot[i] = null;
         }
         return ss;
      }
      
      public function get suppliesSlot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesSlot;
      }
      
      public function set suppliesSlot(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesSlot = value;
      }
      
      public function getFromSuppliesSlot(num:Number) : Supplies
      {
         if(_suppliesSlot[num] != null)
         {
            return _suppliesSlot[num];
         }
         return null;
      }
      
      public function getNumFromSuppliesSlot(bag:Bag, num:Number) : Number
      {
         var i:int = 0;
         var n:int = 0;
         if(_suppliesSlot[num] != null)
         {
            for(i = 0; i < 24; i++)
            {
               if(bag.getSuppliesFromBag(i) != null)
               {
                  if(bag.getSuppliesFromBag(i).getName() == getFromSuppliesSlot(num).getName())
                  {
                     if(bag.getSuppliesFromBag(i).getIsPile() == true)
                     {
                        n += bag.getSuppliesFromBag(i).getTimes();
                     }
                     else
                     {
                        n++;
                     }
                  }
               }
            }
         }
         return n;
      }
      
      public function useSupplies(bag:Bag, num:Number) : void
      {
         var i:int = 0;
         var n:int = 0;
         if(_suppliesSlot[num] != null)
         {
            for(i = 0; i < 24; i++)
            {
               if(bag.getSuppliesFromBag(i) != null)
               {
                  if(bag.getSuppliesFromBag(i).getName() == getFromSuppliesSlot(num).getName())
                  {
                     if(bag.getSuppliesFromBag(i).getIsPile() == true)
                     {
                        if(bag.getSuppliesFromBag(i).getTimes() == 1)
                        {
                           bag.delSupplies(i);
                           break;
                        }
                        bag.getSuppliesFromBag(i).useSupplies(1);
                        break;
                     }
                     bag.delSupplies(i);
                     break;
                  }
               }
            }
         }
      }
      
      public function setToSuppliesSlot(value:Supplies, num:Number) : Boolean
      {
         _suppliesSlot[num] = value;
         return true;
      }
   }
}

