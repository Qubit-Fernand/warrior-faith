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
      
      private static function XXYY(param1:DisplayObject) : Point
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         _loc2_ = param1.x;
         _loc3_ = param1.y;
         _loc4_ = param1;
         while(!(_loc4_.parent is Stage))
         {
            _loc4_ = _loc4_.parent;
            _loc2_ += _loc4_.x;
            _loc3_ += _loc4_.y;
         }
         return new Point(_loc2_,_loc3_);
      }
      
      public static function hitTestPoint(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         var _loc3_:Point = null;
         var _loc4_:Boolean = false;
         _loc3_ = JhitTestPoint.XXYY(param1);
         return param2.hitTestPoint(_loc3_.x,_loc3_.y,true);
      }
      
      public static function hitOrbit(param1:DisplayObject, param2:DisplayObject, param3:Point) : Point
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Point = null;
         var _loc10_:int = 0;
         var _loc11_:Point = null;
         var _loc12_:Boolean = false;
         if(!param1 || !param2)
         {
            return new Point(0,0);
         }
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = Math.abs(param3.x) > Math.abs(param3.y) ? int(Math.abs(int(param3.x))) : int(Math.abs(int(param3.y)));
         _loc7_ = param3.x / _loc6_;
         _loc8_ = param3.y / _loc6_;
         _loc9_ = XXYY(param1);
         _loc10_ = 0;
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

