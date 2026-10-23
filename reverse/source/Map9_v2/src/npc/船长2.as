package src.npc
{
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 船长2 extends SimpleButton
   {
      
      public function 船长2()
      {
         super();
         addEventListener(MouseEvent.CLICK,Open);
      }
      
      public function Open(e:*) : *
      {
         Main.allClosePanel();
         if(Main.Map0_YN2)
         {
            InWaterDoor.Open();
         }
         else
         {
            InWaterKey.Open();
         }
      }
   }
}

