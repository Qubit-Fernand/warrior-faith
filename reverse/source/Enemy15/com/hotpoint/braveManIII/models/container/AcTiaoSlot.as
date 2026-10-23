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
         for(var i:uint = 0; i < 6; i++)
         {
            _nameArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _nameArr;
      }
      
      public function addName(name:String) : void
      {
         for(var i:uint = 0; i < 6; i++)
         {
            if(_nameArr[i] == -1)
            {
               _nameArr[i] = name;
               break;
            }
         }
      }
      
      public function getName(num:Number) : String
      {
         if(_nameArr[num] != -1)
         {
            return _nameArr[num];
         }
         return null;
      }
      
      public function clearAc() : void
      {
         for(var i:uint = 0; i < 6; i++)
         {
            _nameArr[i] = -1;
         }
      }
   }
}

