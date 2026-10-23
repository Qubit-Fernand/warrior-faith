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
         var _loc1_:AcTiaoSlot = new AcTiaoSlot();
         _loc1_.initSlotArr();
         return _loc1_;
      }
      
      private function initSlotArr() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 15)
         {
            _nameArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function getSlotArr() : Array
      {
         return _nameArr;
      }
      
      public function addName(param1:String) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 15)
         {
            if(_nameArr[_loc2_] == -1)
            {
               _nameArr[_loc2_] = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public function getName(param1:Number) : String
      {
         if(_nameArr[param1] != -1)
         {
            return _nameArr[param1];
         }
         return null;
      }
      
      public function clearAc() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 15)
         {
            _nameArr[_loc1_] = -1;
            _loc1_++;
         }
      }
   }
}

