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
         var _loc1_:SuppliesSlot = new SuppliesSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc1_._suppliesSlot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get suppliesSlot() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._suppliesSlot;
      }
      
      public function set suppliesSlot(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._suppliesSlot = param1;
      }
      
      public function getFromSuppliesSlot(param1:Number) : Supplies
      {
         if(this._suppliesSlot[param1] != null)
         {
            return this._suppliesSlot[param1];
         }
         return null;
      }
      
      public function getNumFromSuppliesSlot(param1:Bag, param2:Number) : Number
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(this._suppliesSlot[param2] != null)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(param1.getSuppliesFromBag(_loc4_) != null)
               {
                  if(param1.getSuppliesFromBag(_loc4_).getName() == this.getFromSuppliesSlot(param2).getName())
                  {
                     if(param1.getSuppliesFromBag(_loc4_).getIsPile() == true)
                     {
                        _loc3_ += param1.getSuppliesFromBag(_loc4_).getTimes();
                     }
                     else
                     {
                        _loc3_++;
                     }
                  }
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      public function useSupplies(param1:Bag, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(this._suppliesSlot[param2] != null)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(param1.getSuppliesFromBag(_loc4_) != null)
               {
                  if(param1.getSuppliesFromBag(_loc4_).getName() == this.getFromSuppliesSlot(param2).getName())
                  {
                     if(param1.getSuppliesFromBag(_loc4_).getIsPile() == true)
                     {
                        if(param1.getSuppliesFromBag(_loc4_).getTimes() == 1)
                        {
                           param1.delSupplies(_loc4_);
                           break;
                        }
                        param1.getSuppliesFromBag(_loc4_).useSupplies(1);
                        break;
                     }
                     param1.delSupplies(_loc4_);
                     break;
                  }
               }
               _loc4_++;
            }
         }
      }
      
      public function setToSuppliesSlot(param1:Supplies, param2:Number) : Boolean
      {
         this._suppliesSlot[param2] = param1;
         return true;
      }
   }
}

