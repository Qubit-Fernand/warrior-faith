package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class HuoDong_btn extends SimpleButton
   {
      
      public function HuoDong_btn()
      {
         super();
         addEventListener(MouseEvent.CLICK,onCLICK);
      }
      
      private function onCLICK(param1:*) : *
      {
         Shop_LiBao.Open();
         Shop_LiBao.SelliBao();
      }
   }
}

