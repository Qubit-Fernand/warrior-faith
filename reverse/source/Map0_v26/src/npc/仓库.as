package src.npc
{
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 仓库 extends SimpleButton
   {
      
      public function 仓库()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         StoragePanel.open();
      }
   }
}

