package com
{
   public class TimeBox
   {
      
      public function TimeBox()
      {
         super();
      }
      
      public static function TimeXX(runFun:Function) : String
      {
         var beginTime:Number = new Date().getTime();
         runFun();
         var endTime:Number = new Date().getTime();
         return "耗时:" + (endTime - beginTime) + "毫秒";
      }
   }
}

