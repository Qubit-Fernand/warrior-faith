package src.npc
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 塔丽莎 extends SimpleButton
   {
      
      public function 塔丽莎()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         塔丽莎界面.Open();
      }
   }
}

