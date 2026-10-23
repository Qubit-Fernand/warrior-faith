package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.pet.Pet;
   
   public class PetSlot
   {
      
      private var _slot:Array = new Array();
      
      private var _slotLimit:VT = VT.createVT(3);
      
      public function PetSlot()
      {
         super();
      }
      
      public static function createPetSlot() : PetSlot
      {
         var ps:PetSlot = new PetSlot();
         for(var i:int = 0; i < 10; i++)
         {
            ps._slot[i] = null;
         }
         return ps;
      }
      
      public function get slotLimit() : VT
      {
         return this._slotLimit;
      }
      
      public function set slotLimit(value:VT) : void
      {
         this._slotLimit = value;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(value:Array) : void
      {
         this._slot = value;
      }
      
      public function getPetFromSlot(num:Number) : Pet
      {
         if(this._slot[num] != null)
         {
            return this._slot[num];
         }
         return null;
      }
      
      public function addPetSlot(value:Pet) : Boolean
      {
         for(var i:uint = 0; i < this._slotLimit.getValue(); i++)
         {
            if(this._slot[i] == null)
            {
               this._slot[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function delPetSlot(num:int) : Pet
      {
         var pet:Pet = null;
         if(this._slot[num] != null)
         {
            pet = this._slot[num];
            this._slot[num] = null;
         }
         return pet;
      }
      
      public function getPetSlotNum() : int
      {
         return this._slotLimit.getValue();
      }
      
      public function backPetSlotNum() : int
      {
         var num:int = 0;
         for(var i:uint = 0; i < this._slotLimit.getValue(); i++)
         {
            if(this._slot[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backPetNum() : int
      {
         var num:int = 0;
         for(var i:uint = 0; i < this._slotLimit.getValue(); i++)
         {
            if(this._slot[i] != null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function addPetSlotNum(num:int) : *
      {
         this._slotLimit.setValue(this._slotLimit.getValue() + num);
      }
   }
}

