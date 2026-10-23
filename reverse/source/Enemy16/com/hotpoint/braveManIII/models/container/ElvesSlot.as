package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.elves.Elves;
   
   public class ElvesSlot
   {
      
      private var _slot:Array = new Array();
      
      public function ElvesSlot()
      {
         super();
      }
      
      public static function createElvesSlot() : ElvesSlot
      {
         var _loc1_:ElvesSlot = new ElvesSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(param1:Array) : void
      {
         _slot = param1;
      }
      
      public function getElvesFromSlot(param1:Number) : Elves
      {
         if(_slot[param1] != null)
         {
            return _slot[param1];
         }
         return null;
      }
      
      public function addElvesSlot(param1:Elves) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
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
      
      public function delElvesSlot(param1:int) : Elves
      {
         var _loc2_:Elves = null;
         if(_slot[param1] != null)
         {
            _loc2_ = _slot[param1];
            _slot[param1] = null;
         }
         return _loc2_;
      }
      
      public function backElvesSlotNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            if(_slot[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backElvesNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            if(_slot[_loc2_] != null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backElvesId() : int
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 5)
         {
            if(_slot[_loc1_] != null)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function backChoseElvesId(param1:Elves) : int
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            if(_slot[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
   }
}

