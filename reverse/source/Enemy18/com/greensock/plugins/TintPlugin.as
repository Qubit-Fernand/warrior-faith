package com.greensock.plugins
{
   import com.greensock.*;
   import com.greensock.core.*;
   import flash.display.*;
   import flash.geom.*;
   
   public class TintPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
      
      protected var _transform:Transform;
      
      protected var _ct:ColorTransform;
      
      protected var _ignoreAlpha:Boolean;
      
      public function TintPlugin()
      {
         super();
         this.propName = "tint";
         this.overwriteProps = ["tint"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(!(target is DisplayObject))
         {
            return false;
         }
         var end:ColorTransform = new ColorTransform();
         if(value != null && tween.vars.removeTint != true)
         {
            end.color = uint(value);
         }
         _ignoreAlpha = true;
         _transform = DisplayObject(target).transform;
         init(_transform.colorTransform,end);
         return true;
      }
      
      public function init(start:ColorTransform, end:ColorTransform) : void
      {
         var p:String = null;
         _ct = start;
         var i:* = int(_props.length);
         var cnt:* = int(_tweens.length);
         while(i--)
         {
            p = _props[i];
            if(_ct[p] != end[p])
            {
               var _loc6_:Number;
               _tweens[_loc6_ = cnt++] = new PropTween(_ct,p,_ct[p],end[p] - _ct[p],"tint",false);
            }
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var ct:ColorTransform = null;
         updateTweens(n);
         if(_transform)
         {
            if(_ignoreAlpha)
            {
               ct = _transform.colorTransform;
               _ct.alphaMultiplier = ct.alphaMultiplier;
               _ct.alphaOffset = ct.alphaOffset;
            }
            _transform.colorTransform = _ct;
         }
      }
   }
}

