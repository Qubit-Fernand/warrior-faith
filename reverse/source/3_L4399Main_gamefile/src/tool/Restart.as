package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1754")]
   public class Restart extends MovieClip
   {
      
      public var _close_btn:透明按钮;
      
      public function Restart()
      {
         super();
         _close_btn.addEventListener(MouseEvent.CLICK,onClose);
      }
      
      private function onClose(param1:*) : *
      {
         navigateToURL(new URLRequest("javascript:location.reload(); "),"_self");
      }
   }
}

