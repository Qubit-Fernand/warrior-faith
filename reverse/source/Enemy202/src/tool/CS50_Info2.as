package src.tool
{
   import com.hotpoint.braveManIII.views.npcTaskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class CS50_Info2 extends SimpleButton
   {
      
      public static var infoYN:int = 0;
      
      public function CS50_Info2()
      {
         super();
         addEventListener(MouseEvent.CLICK,this.onCLICK);
      }
      
      public static function Add(param1:int = 165, param2:int = 130) : *
      {
         var _loc3_:CS50_Info2 = null;
         if(Main.gameNum.getValue() == 0 && (Main.player1.getLevel() >= 50 || Boolean(Main.P1P2) && Main.player2.getLevel() >= 50))
         {
            if(!Main.player1.isRebirth() || Boolean(Main.P1P2) && !Main.player2.isRebirth())
            {
               _loc3_ = new CS50_Info2();
               Main.world.addChild(_loc3_);
               _loc3_.x = param1;
               _loc3_.y = param2;
            }
         }
      }
      
      private function onCLICK(param1:*) : *
      {
         NpcTaskPanel.open(2);
         ++infoYN;
      }
   }
}

