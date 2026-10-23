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
         this._ignoreAlpha = true;
         this._transform = DisplayObject(target).transform;
         this.init(this._transform.colorTransform,end);
         return true;
      }
      
      public function init(start:ColorTransform, end:ColorTransform) : void
      {
         var p:String = null;
         this._ct = start;
         var i:* = int(_props.length);
         var cnt:* = int(_tweens.length);
         while(i--)
         {
            p = _props[i];
            if(this._ct[p] != end[p])
            {
               var _loc6_:Number;
               _tweens[_loc6_ = cnt++] = new PropTween(this._ct,p,this._ct[p],end[p] - this._ct[p],"tint",false);
            }
         }
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var ct:ColorTransform = null;
         updateTweens(n);
         if(this._transform)
         {
            if(this._ignoreAlpha)
            {
               ct = this._transform.colorTransform;
               this._ct.alphaMultiplier = ct.alphaMultiplier;
               this._ct.alphaOffset = ct.alphaOffset;
            }
            this._transform.colorTransform = this._ct;
         }
      }
   }
}

