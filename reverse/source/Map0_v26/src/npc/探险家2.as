package src.npc
{
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 探险家2 extends SimpleButton
   {
      
      public function 探险家2()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         探险家界面2.Open();
      }
   }
}

