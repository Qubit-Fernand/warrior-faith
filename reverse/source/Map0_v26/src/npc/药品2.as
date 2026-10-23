package src.npc
{
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 药品2 extends SimpleButton
   {
      
      public function 药品2()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(param1:*) : *
      {
         Main.allClosePanel();
         药水商人界面2.Open();
      }
   }
}

