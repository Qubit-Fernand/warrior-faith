package src.npc
{
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 探险家 extends SimpleButton
   {
      
      public function 探险家()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         探险家界面.Open();
      }
   }
}

