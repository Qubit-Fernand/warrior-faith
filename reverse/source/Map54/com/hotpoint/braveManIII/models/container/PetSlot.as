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
         var _loc1_:PetSlot = new PetSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get slotLimit() : VT
      {
         return _slotLimit;
      }
      
      public function set slotLimit(param1:VT) : void
      {
         _slotLimit = param1;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(param1:Array) : void
      {
         _slot = param1;
      }
      
      public function getPetFromSlot(param1:Number) : Pet
      {
         if(_slot[param1] != null)
         {
            return _slot[param1];
         }
         return null;
      }
      
      public function addPetSlot(param1:Pet) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < _slotLimit.getValue())
         {
            if(_slot[_loc2_] == null)
            {
               _slot[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function delPetSlot(param1:int) : Pet
      {
         var _loc2_:Pet = null;
         if(_slot[param1] != null)
         {
            _loc2_ = _slot[param1];
            _slot[param1] = null;
         }
         return _loc2_;
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
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < _slotLimit.getValue())
         {
            if(_slot[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backPetNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < _slotLimit.getValue())
         {
            if(_slot[_loc2_] != null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addPetSlotNum(param1:int) : *
      {
         _slotLimit.setValue(_slotLimit.getValue() + param1);
      }
   }
}

