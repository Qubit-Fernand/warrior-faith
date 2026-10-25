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
         if(this._slot[param1] != null)
         {
            return this._slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:Otherobj, param2:Number) : Boolean
      {
         if(this._slot[param2] == null)
         {
            this._slot[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function getMP() : Number
      {
         if(this._slot[0])
         {
            return (this._slot[0] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getHP() : Number
      {
         if(this._slot[1])
         {
            return (this._slot[1] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getATT() : Number
      {
         if(this._slot[2])
         {
            return (this._slot[2] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getDEF() : Number
      {
         if(this._slot[3])
         {
            return (this._slot[3] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getCRIT() : Number
      {
         if(this._slot[4])
         {
            return (this._slot[4] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function getSPEED() : Number
      {
         if(this._slot[5])
         {
            return (this._slot[5] as Otherobj).getValue_1();
         }
         return 0;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(param1:Array) : void
      {
         this._slot = param1;
      }
   }
}

