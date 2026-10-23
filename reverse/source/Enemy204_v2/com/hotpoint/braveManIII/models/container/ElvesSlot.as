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
         var es:ElvesSlot = new ElvesSlot();
         for(var i:int = 0; i < 5; i++)
         {
            es._slot[i] = null;
         }
         return es;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(value:Array) : void
      {
         _slot = value;
      }
      
      public function getElvesFromSlot(num:Number) : Elves
      {
         if(_slot[num] != null)
         {
            return _slot[num];
         }
         return null;
      }
      
      public function addElvesSlot(value:Elves) : Boolean
      {
         for(var i:uint = 0; i < 5; i++)
         {
            if(_slot[i] == null)
            {
               _slot[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function delElvesSlot(num:int) : Elves
      {
         var elves:Elves = null;
         if(_slot[num] != null)
         {
            elves = _slot[num];
            _slot[num] = null;
         }
         return elves;
      }
      
      public function backElvesSlotNum() : int
      {
         var num:int = 0;
         for(var i:uint = 0; i < 5; i++)
         {
            if(_slot[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backElvesNum() : int
      {
         var num:int = 0;
         for(var i:uint = 0; i < 5; i++)
         {
            if(_slot[i] != null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backElvesId() : int
      {
         for(var i:uint = 0; i < 5; i++)
         {
            if(_slot[i] != null)
            {
               return i;
            }
         }
         return -1;
      }
      
      public function backChoseElvesId(e:Elves) : int
      {
         for(var i:uint = 0; i < 5; i++)
         {
            if(_slot[i] == e)
            {
               return i;
            }
         }
         return -1;
      }
   }
}

