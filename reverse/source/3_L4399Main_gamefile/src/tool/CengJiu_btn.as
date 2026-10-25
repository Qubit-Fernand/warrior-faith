package src.tool
{
   import com.hotpoint.braveManIII.views.achPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class CengJiu_btn extends SimpleButton
   {
      
      public function CengJiu_btn()
      {
         super();
         addEventListener(MouseEvent.CLICK,onCLICK);
      }
      
      private function onCLICK(param1:*) : *
      {
         AchPanel.open();
      }
   }
}

