package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   
   public class promptSlot
   {
      
      private static var _slotArr:Array = [];
      
      private static var arrNum:* = 2;
      
      public function promptSlot()
      {
         super();
      }
      
      public static function creatDeleteSlot() : promptSlot
      {
         var streng:promptSlot = new promptSlot();
         creatSlotArr();
         return streng;
      }
      
      private static function creatSlotArr() : void
      {
         for(var i:uint = 0; i < arrNum; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function addToSlot(obj:*, num:*) : void
      {
         _slotArr[num] = obj;
      }
      
      public function delSlot(num:Number) : void
      {
         if(_slotArr[num] != 1)
         {
            _slotArr[num] = -1;
         }
      }
      
      public function getProp(num:uint) : *
      {
         return _slotArr[num];
      }
      
      public function getPropGem(num:uint) : Boolean
      {
         if(_slotArr[num] is Gem)
         {
            return true;
         }
         return false;
      }
      
      public function getPropEquip(num:uint) : Boolean
      {
         if(_slotArr[num] is Equip)
         {
            return true;
         }
         return false;
      }
   }
}

