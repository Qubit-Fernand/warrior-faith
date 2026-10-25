package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   
   public class StrengthenSynthesisSlot
   {
      
      private static var _slotNum:VT;
      
      private static var _slotArr:Array = [];
      
      public function StrengthenSynthesisSlot()
      {
         super();
      }
      
      public static function creatSynthesisSlot() : StrengthenSynthesisSlot
      {
         var streng:StrengthenSynthesisSlot = new StrengthenSynthesisSlot();
         _slotNum = VT.createVT(3);
         creatSlotArr();
         return streng;
      }
      
      private static function creatSlotArr() : void
      {
         var arrNum:Number = Number(_slotNum.getValue());
         for(var i:uint = 0; i < arrNum; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function get slotNum() : VT
      {
         return _slotNum;
      }
      
      public function slotArr() : Array
      {
         return _slotArr;
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
      
      public function getType(num:uint) : Number
      {
         if(_slotArr[num] != -1)
         {
            if(_slotArr[num] as Gem)
            {
               return _slotArr[num].getType();
            }
         }
         return -1;
      }
      
      public function clearSlot() : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            if(_slotArr[i] != -1)
            {
               _slotArr[i] = -1;
            }
         }
      }
   }
}

