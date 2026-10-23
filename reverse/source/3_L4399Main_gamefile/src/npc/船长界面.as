package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8625")]
   public class 船长界面 extends MovieClip
   {
      
      private static var only:船长界面;
      
      public var close2:SimpleButton;
      
      public var _btn:SimpleButton;
      
      public function 船长界面()
      {
         super();
         close2.addEventListener(MouseEvent.CLICK,CloseXX);
         _btn.addEventListener(MouseEvent.CLICK,GoGo);
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!only)
         {
            only = new 船长界面();
         }
         Main._stage.addChild(only);
         only.x = param1;
         only.y = param2;
         only.visible = true;
         goldpanduan();
      }
      
      public static function Close() : *
      {
         if(!only)
         {
            only = new 船长界面();
         }
         only.x = 5000;
         only.y = 5000;
         only.visible = false;
      }
      
      private static function goldpanduan() : *
      {
         only._btn.visible = false;
         if(!Main.P1P2 && Main.player1.getGold() >= 10000 || Boolean(Main.P1P2) && Main.player1.getGold() >= 10000 && Main.player2.getGold() >= 10000)
         {
            only._btn.visible = true;
         }
      }
      
      private function CloseXX(param1:*) : *
      {
         Close();
      }
      
      private function GoGo(param1:*) : *
      {
         Main.player1.payGold(10000);
         if(Main.P1P2)
         {
            Main.player2.payGold(10000);
         }
         if(Main.Map0_YN == false)
         {
            Main.Map0_YN = true;
            Main.Save();
         }
         Main.water.setValue(1);
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Main._this.GameStart();
         Close();
      }
   }
}

