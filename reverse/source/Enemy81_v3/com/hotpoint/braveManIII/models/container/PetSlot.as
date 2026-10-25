package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.pet.Pet;
   
   public class PetSlot
   {
      
      private var _slot:Array = new Array();
      
      private var _slotLimit:VT = VT.createVT(5);
      
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
         return _slotLimit;
      }
      
      public function set slotLimit(value:VT) : void
      {
         _slotLimit = value;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(value:Array) : void
      {
         _slot = value;
      }
      
      public function getPetFromSlot(num:Number) : Pet
      {
         if(_slot[num] != null)
         {
            return _slot[num];
         }
         return null;
      }
      
      public function addPetSlot(value:Pet) : Boolean
      {
         for(var i:uint = 0; i < _slotLimit.getValue(); i++)
         {
            if(_slot[i] == null)
            {
               _slot[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function delPetSlot(num:int) : Pet
      {
         var pet:Pet = null;
         if(_slot[num] != null)
         {
            pet = _slot[num];
            _slot[num] = null;
         }
         return pet;
      }
      
      public function getPetSlotNum() : int
      {
         return _slotLimit.getValue();
      }
      
      public function backPetSlotNum() : int
      {
         if(_slotLimit.getValue() == 3)
         {
            _slotLimit.setValue(5);
         }
         var num:int = 0;
         for(var i:uint = 0; i < _slotLimit.getValue(); i++)
         {
            if(_slot[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backPetNum() : int
      {
         var num:int = 0;
         for(var i:uint = 0; i < _slotLimit.getValue(); i++)
         {
            if(_slot[i] != null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function addPetSlotNum(num:int) : *
      {
         _slotLimit.setValue(_slotLimit.getValue() + num);
      }
   }
}

