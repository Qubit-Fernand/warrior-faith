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
   import src.ACT;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8352")]
   public dynamic class ACT_0 extends ACT
   {
      
      public function ACT_0()
      {
         super();
         addFrameScript(6,frame7);
      }
      
      internal function frame7() : *
      {
         stop();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

