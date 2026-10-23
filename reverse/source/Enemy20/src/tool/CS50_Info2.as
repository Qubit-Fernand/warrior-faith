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
      
      public static function Add(xx:int = 165, yy:int = 130) : *
      {
         var cs:CS50_Info2 = null;
         if(Main.gameNum == 0 && (Main.player1.getLevel() >= 50 || Boolean(Main.P1P2) && Main.player2.getLevel() >= 50))
         {
            if(!Main.player1.isRebirth() || Boolean(Main.P1P2) && !Main.player2.isRebirth())
            {
               cs = new CS50_Info2();
               Main.world.addChild(cs);
               cs.x = xx;
               cs.y = yy;
            }
         }
      }
      
      private function onCLICK(e:*) : *
      {
         NpcTaskPanel.open(2);
         ++infoYN;
      }
   }
}

