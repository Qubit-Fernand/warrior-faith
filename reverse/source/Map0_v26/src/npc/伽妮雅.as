package src.npc
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 伽妮雅 extends SimpleButton
   {
      
      public function 伽妮雅()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         伽妮雅界面.Open();
      }
   }
}

