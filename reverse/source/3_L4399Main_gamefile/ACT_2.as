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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8408")]
   public dynamic class ACT_2 extends ACT
   {
      
      public function ACT_2()
      {
         super();
         addFrameScript(8,frame9);
      }
      
      internal function frame9() : *
      {
         stop();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

