package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.other.*;
   
   public class BadgeSlot
   {
      
      private var _slot:Array = new Array();
      
      public function BadgeSlot()
      {
         super();
      }
      
      public static function createBadgeSlot() : BadgeSlot
      {
         var _loc1_:BadgeSlot = new BadgeSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getBadgeFromSlot(param1:Number) : Otherobj
      {
         if(_slot[param1] != null)
         {
            return _slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:Otherobj, param2:Number) : Boolean
      {
         if(_slot[param2] == null)
         {
            _slot[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function getMP() : Number
      {
         if(_slot[0])
         {
            return (_slot[0] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getHP() : Number
      {
         if(_slot[1])
         {
            return (_slot[1] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getATT() : Number
      {
         if(_slot[2])
         {
            return (_slot[2] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getDEF() : Number
      {
         if(_slot[3])
         {
            return (_slot[3] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getCRIT() : Number
      {
         if(_slot[4])
         {
            return (_slot[4] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getSPEED() : Number
      {
         if(_slot[5])
         {
            return (_slot[5] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function plan6_14() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            if(_slot[_loc1_])
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(param1:Array) : void
      {
         _slot = param1;
      }
   }
}

