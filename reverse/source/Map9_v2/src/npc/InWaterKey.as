package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class InWaterKey extends MovieClip
   {
      
      private static var iwk:InWaterKey;
      
      public function InWaterKey()
      {
         super();
         in_btn.addEventListener(MouseEvent.CLICK,nextWord);
         in_btn.visible = false;
         close_btn.addEventListener(MouseEvent.CLICK,closed);
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!iwk)
         {
            iwk = new InWaterKey();
         }
         Main._stage.addChild(iwk);
         iwk.x = xx;
         iwk.y = yy;
         iwk.visible = true;
         panduan();
      }
      
      public static function Close() : *
      {
         if(!iwk)
         {
            iwk = new InWaterKey();
         }
         iwk.x = 5000;
         iwk.y = 5000;
         iwk.visible = false;
      }
      
      private static function panduan() : *
      {
         var temp:int = 0;
         if(Main.player1.getBag().getOtherobjNum(63223) > 0)
         {
            iwk.txt_1.text = "1/1";
            temp++;
         }
         else
         {
            iwk.txt_1.text = "0/1";
         }
         if(Main.player1.getBag().getOtherobjNum(63224) > 0)
         {
            iwk.txt_2.text = "1/1";
            temp++;
         }
         else
         {
            iwk.txt_2.text = "0/1";
         }
         if(Main.player1.getBag().getOtherobjNum(63225) > 0)
         {
            iwk.txt_3.text = "1/1";
            temp++;
         }
         else
         {
            iwk.txt_3.text = "0/1";
         }
         if(temp >= 3)
         {
            iwk.in_btn.visible = true;
         }
      }
      
      private function closed(e:*) : *
      {
         Close();
      }
      
      private function nextWord(e:*) : *
      {
         InWaterDoor.Open();
         Close();
      }
   }
}

