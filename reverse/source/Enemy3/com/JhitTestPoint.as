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
      
      private static function XXYY(point:DisplayObject) : Point
      {
         var xx:int = 0;
         var yy:int = 0;
         var parentMC:DisplayObject = null;
         xx = point.x;
         yy = point.y;
         parentMC = point;
         while(!(parentMC.parent is Stage))
         {
            parentMC = parentMC.parent;
            xx += parentMC.x;
            yy += parentMC.y;
         }
         return new Point(xx,yy);
      }
      
      public static function hitTestPoint(point:DisplayObject, shape:DisplayObject) : Boolean
      {
         var tempPoint:Point = null;
         var bool:Boolean = false;
         tempPoint = JhitTestPoint.XXYY(point);
         return shape.hitTestPoint(tempPoint.x,tempPoint.y,true);
      }
      
      public static function hitOrbit(point:DisplayObject, shape:DisplayObject, pointX:Point) : Point
      {
         var tempX:Number = NaN;
         var tempY:Number = NaN;
         var num:int = 0;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var newPoint:Point = null;
         var i:int = 0;
         var p:Point = null;
         var bool:Boolean = false;
         if(!point || !shape)
         {
            return new Point(0,0);
         }
         tempX = 0;
         tempY = 0;
         num = Math.abs(pointX.x) > Math.abs(pointX.y) ? int(Math.abs(int(pointX.x))) : int(Math.abs(int(pointX.y)));
         xx = pointX.x / num;
         yy = pointX.y / num;
         newPoint = XXYY(point);
         for(i = 0; i < num; i++)
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

