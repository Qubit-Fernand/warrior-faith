package com
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class JhitTestPoint
   {
      
      public function JhitTestPoint()
      {
         super();
      }
      
      public static function hitTestPoint(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         var _loc3_:Point = JhitTestPoint.XXYY(param1);
         return param2.hitTestPoint(_loc3_.x,_loc3_.y,true);
      }
      
      private static function XXYY(param1:DisplayObject) : Point
      {
         var _loc2_:int = param1.x;
         var _loc3_:int = param1.y;
         var _loc4_:DisplayObject = param1;
         while(!(_loc4_.parent is Stage))
         {
            _loc4_ = _loc4_.parent;
            _loc2_ += _loc4_.x;
            _loc3_ += _loc4_.y;
         }
         return new Point(_loc2_,_loc3_);
      }
      
      public static function hitOrbit(param1:DisplayObject, param2:DisplayObject, param3:Point) : Point
      {
         var _loc12_:Boolean = false;
         if(!param1 || !param2)
         {
            return new Point(0,0);
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:int = Math.abs(param3.x) > Math.abs(param3.y) ? int(Math.abs(int(param3.x))) : int(Math.abs(int(param3.y)));
         var _loc7_:Number = param3.x / _loc6_;
         var _loc8_:Number = param3.y / _loc6_;
         var _loc9_:Point = XXYY(param1);
         var _loc10_:int = 0;
         while(_loc10_ < _loc6_)
         {
            _loc12_ = param2.hitTestPoint(_loc9_.x,_loc9_.y,true);
            if(_loc12_)
            {
               break;
            }
            _loc4_ += _loc7_;
            _loc5_ += _loc8_;
            _loc9_.x += _loc7_;
            _loc9_.y += _loc8_;
            _loc10_++;
         }
         return new Point(int(_loc4_),int(_loc5_));
      }
   }
}

