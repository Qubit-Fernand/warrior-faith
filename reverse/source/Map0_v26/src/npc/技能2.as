package src.npc
{
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 技能2 extends SimpleButton
   {
      
      public function 技能2()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         技能导师界面2.Open();
      }
   }
}

