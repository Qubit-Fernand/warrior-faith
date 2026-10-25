package com
{
   public class TimeBox
   {
      
      public function TimeBox()
      {
         super();
      }
      
      public static function TimeXX(param1:Function) : String
      {
         var _loc2_:Number = new Date().getTime();
         param1();
         var _loc3_:Number = new Date().getTime();
         return "耗时:" + (_loc3_ - _loc2_) + "毫秒";
      }
   }
}

