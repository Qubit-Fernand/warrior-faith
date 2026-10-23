package src.tool
{
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class ZhuFuMC extends MovieClip
   {
      
      public function ZhuFuMC()
      {
         super();
         go_btn.addEventListener(MouseEvent.CLICK,this.onCLICK);
         go_mc.close_btn.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function onCLICK(param1:*) : *
      {
         go_mc.x = go_mc.y = 0;
      }
      
      private function onClose(param1:*) : *
      {
         go_mc.x = go_mc.y = 5000;
      }
   }
}

