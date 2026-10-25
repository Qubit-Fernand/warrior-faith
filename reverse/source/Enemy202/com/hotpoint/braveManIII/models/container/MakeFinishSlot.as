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
            this._slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._slotArr;
      }
      
      public function addNeedSlot(param1:Number, param2:Object) : void
      {
         if(this._slotArr[param1] == -1)
         {
            this._slotArr[param1] = param2;
         }
      }
      
      public function delMake(param1:Number) : Object
      {
         var _loc2_:Object = null;
         if(this._slotArr[param1] != -1)
         {
            _loc2_ = this._slotArr[param1];
            this._slotArr[param1] = -1;
         }
         return _loc2_;
      }
      
      public function addFinish(param1:Object) : void
      {
         if(this._slotArr[5] == -1)
         {
            this._slotArr[5] = param1;
         }
      }
      
      public function getMake(param1:Number) : Object
      {
         if(this._slotArr[param1] != -1)
         {
            return this._slotArr[param1];
         }
         return null;
      }
      
      public function clearMake() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 6)
         {
            this._slotArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function setIntSlot(param1:Number) : void
      {
         this._jh = param1;
      }
      
      public function getIntSlot() : Number
      {
         return this._jh;
      }
      
      public function intIntSlot() : void
      {
         this._jh = -1;
      }
   }
}

