package
{
   import com.hotpoint.braveManIII.models.basicBtn.CloseBtn;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1102")]
   public dynamic class 制作关闭按钮 extends com.hotpoint.braveManIII.models.basicBtn.CloseBtn
   {
      
      public function 制作关闭按钮()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

