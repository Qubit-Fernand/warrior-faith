package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8614")]
   public class InWaterDoor extends MovieClip
   {
      
      private static var iwd:InWaterDoor;
      
      public var go_btn:SimpleButton;
      
      public var close_btn:SimpleButton;
      
      public function InWaterDoor()
      {
         super();
         go_btn.addEventListener(MouseEvent.CLICK,gotoWaterWorld);
         go_btn.visible = false;
         close_btn.addEventListener(MouseEvent.CLICK,closed);
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!iwd)
         {
            iwd = new InWaterDoor();
         }
         Main._stage.addChild(iwd);
         iwd.x = param1;
         iwd.y = param2;
         iwd.visible = true;
         goldpanduan();
      }
      
      public static function Close() : *
      {
         if(!iwd)
         {
            iwd = new InWaterDoor();
         }
         iwd.x = 5000;
         iwd.y = 5000;
         iwd.visible = false;
      }
      
      private static function goldpanduan() : *
      {
         if(!Main.P1P2 && Main.player1.getGold() >= 50000 || Boolean(Main.P1P2) && Main.player1.getGold() >= 50000 && Main.player2.getGold() >= 50000)
         {
            iwd.go_btn.visible = true;
         }
      }
      
      private function closed(param1:*) : *
      {
         Close();
      }
      
      private function gotoWaterWorld(param1:*) : *
      {
         Main.player1.getBag().delOtherById(63223);
         Main.player1.getBag().delOtherById(63224);
         Main.player1.getBag().delOtherById(63225);
         Main.player1.payGold(50000);
         if(Main.P1P2)
         {
            Main.player2.getBag().delOtherById(63223);
            Main.player2.getBag().delOtherById(63224);
            Main.player2.getBag().delOtherById(63225);
            Main.player2.payGold(50000);
         }
         Main.Map0_YN2 = true;
         Main.water.setValue(Math.random() * 999 + 1);
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Main._this.Loading();
         Close();
      }
   }
}

