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
      
      public static function hitTestPoint(point:DisplayObject, shape:DisplayObject) : Boolean
      {
         var tempPoint:Point = JhitTestPoint.XXYY(point);
         return shape.hitTestPoint(tempPoint.x,tempPoint.y,true);
      }
      
      private static function XXYY(point:DisplayObject) : Point
      {
         var xx:int = point.x;
         var yy:int = point.y;
         var parentMC:DisplayObject = point;
         while(!(parentMC.parent is Stage))
         {
            parentMC = parentMC.parent;
            xx += parentMC.x;
            yy += parentMC.y;
         }
         return new Point(xx,yy);
      }
      
      public static function hitOrbit(point:DisplayObject, shape:DisplayObject, pointX:Point) : Point
      {
         var bool:Boolean = false;
         if(!point || !shape)
         {
            return new Point(0,0);
         }
         var tempX:Number = 0;
         var tempY:Number = 0;
         var num:int = Math.abs(pointX.x) > Math.abs(pointX.y) ? int(Math.abs(int(pointX.x))) : int(Math.abs(int(pointX.y)));
         var xx:Number = pointX.x / num;
         var yy:Number = pointX.y / num;
         var newPoint:Point = XXYY(point);
         for(var i:int = 0; i < num; i++)
         {
            bool = shape.hitTestPoint(newPoint.x,newPoint.y,true);
            if(bool)
            {
               break;
            }
            tempX += xx;
            tempY += yy;
            newPoint.x += xx;
            newPoint.y += yy;
         }
         return new Point(int(tempX),int(tempY));
      }
   }
}

