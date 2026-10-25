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
         var _loc1_:MakeFinishSlot = new MakeFinishSlot();
         _loc1_.initSlotArr();
         _loc1_.intIntSlot();
         return _loc1_;
      }
      
      private function initSlotArr() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            _slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _slotArr;
      }
      
      public function addNeedSlot(param1:Number, param2:Object) : void
      {
         if(_slotArr[param1] == -1)
         {
            _slotArr[param1] = param2;
         }
      }
      
      public function delMake(param1:Number) : Object
      {
         var _loc2_:Object = null;
         if(_slotArr[param1] != -1)
         {
            _loc2_ = _slotArr[param1];
            _slotArr[param1] = -1;
         }
         return _loc2_;
      }
      
      public function addFinish(param1:Object) : void
      {
         if(_slotArr[5] == -1)
         {
            _slotArr[5] = param1;
         }
      }
      
      public function getMake(param1:Number) : Object
      {
         if(_slotArr[param1] != -1)
         {
            return _slotArr[param1];
         }
         return null;
      }
      
      public function clearMake() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            _slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function setIntSlot(param1:Number) : void
      {
         _jh = param1;
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

