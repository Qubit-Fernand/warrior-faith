package com.greensock.plugins
{
   import com.greensock.*;
   import flash.media.SoundTransform;
   
   public class VolumePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected var _target:Object;
      
      protected var _st:SoundTransform;
      
      public function VolumePlugin()
      {
         super();
         this.propName = "volume";
         this.overwriteProps = ["volume"];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(Boolean(isNaN(value)) || target.hasOwnProperty("volume") || !target.hasOwnProperty("soundTransform"))
         {
            return false;
         }
         this._target = target;
         this._st = this._target.soundTransform;
         addTween(this._st,"volume",this._st.volume,value,"volume");
         return true;
      }
      
      override public function set changeFactor(n:Number) : void
      {
         updateTweens(n);
         this._target.soundTransform = this._st;
      }
   }
}

