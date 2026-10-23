package com.greensock.plugins
{
   import com.greensock.*;
   
   public class AutoAlphaPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected var _ignoreVisible:Boolean;
      
      protected var _target:Object;
      
      public function AutoAlphaPlugin()
      {
         super();
         this.propName = "autoAlpha";
         this.overwriteProps = ["alpha","visible"];
      }
      
      override public function set changeFactor(n:Number) : void
      {
         updateTweens(n);
         if(!_ignoreVisible)
         {
            _target.visible = Boolean(_target.alpha != 0);
         }
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         _target = target;
         addTween(target,"alpha",target.alpha,value,"alpha");
         return true;
      }
      
      override public function killProps(lookup:Object) : void
      {
         super.killProps(lookup);
         _ignoreVisible = Boolean("visible" in lookup);
      }
   }
}

