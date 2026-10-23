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
   import src.NewMC;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8391")]
   public dynamic class 死亡倒计时2 extends NewMC
   {
      
      public function 死亡倒计时2()
      {
         super();
         addFrameScript(133,frame134);
      }
      
      internal function frame134() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

