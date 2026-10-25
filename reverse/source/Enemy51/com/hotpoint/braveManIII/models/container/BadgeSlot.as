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
         var bs:BadgeSlot = new BadgeSlot();
         for(var i:int = 0; i < 6; i++)
         {
            bs._slot[i] = null;
         }
         return bs;
      }
      
      public function getBadgeFromSlot(num:Number) : Otherobj
      {
         if(_slot[num] != null)
         {
            return _slot[num];
         }
         return null;
      }
      
      public function addToSlot(value:Otherobj, num:Number) : Boolean
      {
         if(_slot[num] == null)
         {
            _slot[num] = value;
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
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(value:Array) : void
      {
         _slot = value;
      }
   }
}

