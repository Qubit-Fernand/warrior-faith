package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 装备 extends SimpleButton
   {
      
      public function 装备()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         装备商人界面.Open();
      }
   }
}

