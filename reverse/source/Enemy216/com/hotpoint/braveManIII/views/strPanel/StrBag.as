package com.hotpoint.braveManIII.views.strPanel
{
   public class StrBag
   {
      
      private var _bagArr:Array = [];
      
      private var _pointArr:Array = [];
      
      public function StrBag()
      {
         super();
      }
      
      public static function creatBag() : StrBag
      {
         var _loc1_:StrBag = new StrBag();
         _loc1_.initBag();
         return _loc1_;
      }
      
      private function initBag() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            _bagArr[_loc1_] = -1;
            _pointArr[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function addBag(param1:Object, param2:Number = -1) : void
      {
         var _loc3_:uint = 0;
         while(_loc3_ < 24)
         {
            if(_bagArr[_loc3_] == -1)
            {
               _bagArr[_loc3_] = param1;
               _pointArr[_loc3_] = param2;
               break;
            }
            _loc3_++;
         }
      }
      
      public function getObj(param1:Number) : Array
      {
         var _loc2_:Array = [];
         if(_bagArr[param1] != -1)
         {
            _loc2_ = [_bagArr[param1],_pointArr[param1]];
         }
         if(_loc2_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function clearBag() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            _bagArr[_loc1_] = -1;
            _pointArr[_loc1_] = -1;
            _loc1_++;
         }
      }
   }
}

