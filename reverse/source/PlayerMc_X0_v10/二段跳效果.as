package
{
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol245")]
   public dynamic class 二段跳效果 extends MovieClip
   {
      
      public function 二段跳效果()
      {
         super();
         addFrameScript(5,frame6);
      }
      
      internal function frame6() : *
      {
         stop();
         this.parent.removeChild(this);
      }
   }
}

