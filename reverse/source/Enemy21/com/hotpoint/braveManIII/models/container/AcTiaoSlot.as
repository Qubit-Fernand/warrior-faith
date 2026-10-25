package com.hotpoint.braveManIII.models.container
{
   public class AcTiaoSlot
   {
      
      private var _nameArr:Array = [];
      
      public function AcTiaoSlot()
      {
         super();
      }
      
      public static function creatSlot() : AcTiaoSlot
      {
         var acSlot:AcTiaoSlot = new AcTiaoSlot();
         acSlot.initSlotArr();
         return acSlot;
      }
      
      private function initSlotArr() : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            this._nameArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._nameArr;
      }
      
      public function addName(name:String) : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            if(this._nameArr[i] == -1)
            {
               this._nameArr[i] = name;
               break;
            }
         }
      }
      
      public function getName(num:Number) : String
      {
         if(this._nameArr[num] != -1)
         {
            return this._nameArr[num];
         }
         return null;
      }
      
      public function clearAc() : void
      {
         for(var i:uint = 0; i < 15; i++)
         {
            this._nameArr[i] = -1;
         }
      }
   }
}

