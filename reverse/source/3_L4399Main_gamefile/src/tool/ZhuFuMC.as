package src.tool
{
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7007")]
   public class ZhuFuMC extends MovieClip
   {
      
      public var go_mc:MovieClip;
      
      public var go_btn:SimpleButton;
      
      public function ZhuFuMC()
      {
         super();
         addFrameScript(29,frame30);
         go_btn.addEventListener(MouseEvent.CLICK,onCLICK);
         go_mc.close_btn.addEventListener(MouseEvent.CLICK,onClose);
      }
      
      private function onCLICK(param1:*) : *
      {
         go_mc.x = go_mc.y = 0;
      }
      
      private function onClose(param1:*) : *
      {
         go_mc.x = go_mc.y = 5000;
      }
      
      internal function frame30() : *
      {
         stop();
      }
   }
}

