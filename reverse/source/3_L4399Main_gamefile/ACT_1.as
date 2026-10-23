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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8461")]
   public dynamic class ACT_1 extends ACT
   {
      
      public function ACT_1()
      {
         super();
         addFrameScript(12,frame13);
      }
      
      internal function frame13() : *
      {
         stop();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

