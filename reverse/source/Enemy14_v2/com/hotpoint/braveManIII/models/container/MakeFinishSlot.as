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
            this._slotArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._slotArr;
      }
      
      public function addNeedSlot(num:Number, type:Object) : void
      {
         if(this._slotArr[num] == -1)
         {
            this._slotArr[num] = type;
         }
      }
      
      public function delMake(num:Number) : Object
      {
         var oj:Object = null;
         if(this._slotArr[num] != -1)
         {
            oj = this._slotArr[num];
            this._slotArr[num] = -1;
         }
         return oj;
      }
      
      public function addFinish(type:Object) : void
      {
         if(this._slotArr[5] == -1)
         {
            this._slotArr[5] = type;
         }
      }
      
      public function getMake(num:Number) : Object
      {
         if(this._slotArr[num] != -1)
         {
            return this._slotArr[num];
         }
         return null;
      }
      
      public function clearMake() : void
      {
         for(var i:uint = 0; i < 6; i++)
         {
            this._slotArr[i] = -1;
         }
      }
      
      public function setIntSlot(num:Number) : void
      {
         this._jh = num;
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

