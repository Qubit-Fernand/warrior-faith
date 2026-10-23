package com.hotpoint.braveManIII.models.container
{
   public class MakeFinishSlot
   {
      
      private var _slotArr:Array = [];
      
      private var _jh:Number;
      
      public function MakeFinishSlot()
      {
         super();
      }
      
      public static function creatSlot() : MakeFinishSlot
      {
         var finishSlot:MakeFinishSlot = new MakeFinishSlot();
         finishSlot.initSlotArr();
         finishSlot.intIntSlot();
         return finishSlot;
      }
      
      private function initSlotArr() : void
      {
         for(var i:uint = 0; i < 6; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _slotArr;
      }
      
      public function addNeedSlot(num:Number, type:Object) : void
      {
         if(_slotArr[num] == -1)
         {
            _slotArr[num] = type;
         }
      }
      
      public function delMake(num:Number) : Object
      {
         var oj:Object = null;
         if(_slotArr[num] != -1)
         {
            oj = _slotArr[num];
            _slotArr[num] = -1;
         }
         return oj;
      }
      
      public function addFinish(type:Object) : void
      {
         if(_slotArr[5] == -1)
         {
            _slotArr[5] = type;
         }
      }
      
      public function getMake(num:Number) : Object
      {
         if(_slotArr[num] != -1)
         {
            return _slotArr[num];
         }
         return null;
      }
      
      public function clearMake() : void
      {
         for(var i:uint = 0; i < 6; i++)
         {
            _slotArr[i] = -1;
         }
      }
      
      public function setIntSlot(num:Number) : void
      {
         _jh = num;
      }
      
      public function getIntSlot() : Number
      {
         return _jh;
      }
      
      public function intIntSlot() : void
      {
         _jh = -1;
      }
   }
}

