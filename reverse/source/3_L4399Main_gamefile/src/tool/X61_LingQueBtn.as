package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class X61_LingQueBtn extends SimpleButton
   {
      
      public function X61_LingQueBtn()
      {
         super();
         Show();
      }
      
      private function Show() : *
      {
         addEventListener(MouseEvent.CLICK,onCLICK);
      }
      
      private function onCLICK(param1:*) : *
      {
         var _loc2_:JiFenLingQue = new JiFenLingQue();
         Main._stage.addChild(_loc2_);
      }
   }
}

