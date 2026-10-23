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
         addEventListener(MouseEvent.CLICK,onCLICK);
      }
      
      public static function Add(xx:int = 15, yy:int = 138) : *
      {
         var X61:X61_LingQueBtn = new X61_LingQueBtn();
         Main.world.addChild(X61);
         X61.x = xx;
         X61.y = yy;
      }
      
      private function onCLICK(e:*) : *
      {
         var X61:X61_LingQue = new X61_LingQue();
         Main._this.addChild(X61);
      }
   }
}

