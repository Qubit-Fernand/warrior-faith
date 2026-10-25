package com.greensock.plugins
{
   import com.greensock.*;
   import flash.display.*;
   
   public class FrameLabelPlugin extends FramePlugin
   {
      
      public static const API:Number = 1;
      
      public function FrameLabelPlugin()
      {
         super();
         this.propName = "frameLabel";
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         var labels:Array = null;
         var label:String = null;
         var endFrame:int = 0;
         var i:* = 0;
         if(!tween.target is MovieClip)
         {
            return false;
         }
         _target = target as MovieClip;
         this.frame = _target.currentFrame;
         labels = _target.currentLabels;
         label = value;
         endFrame = _target.currentFrame;
         i = int(labels.length);
         while(i--)
         {
            if(labels[i].name == label)
            {
               endFrame = int(labels[i].frame);
               break;
            }
         }
         if(this.frame != endFrame)
         {
            addTween(this,"frame",this.frame,endFrame,"frame");
         }
         return true;
      }
   }
}

