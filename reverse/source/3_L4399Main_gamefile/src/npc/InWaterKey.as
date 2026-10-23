package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol8602")]
   public class InWaterKey extends MovieClip
   {
      
      private static var iwk:InWaterKey;
      
      public var txt_1:TextField;
      
      public var txt_2:TextField;
      
      public var txt_3:TextField;
      
      public var in_btn:SimpleButton;
      
      public var close_btn:SimpleButton;
      
      public function InWaterKey()
      {
         super();
         in_btn.addEventListener(MouseEvent.CLICK,nextWord);
         in_btn.visible = false;
         close_btn.addEventListener(MouseEvent.CLICK,closed);
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!iwk)
         {
            iwk = new InWaterKey();
         }
         Main._stage.addChild(iwk);
         iwk.x = param1;
         iwk.y = param2;
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
         var _loc1_:int = 0;
         if(Main.player1.getBag().getOtherobjNum(63223) > 0)
         {
            iwk.txt_1.text = "1/1";
            _loc1_++;
         }
         else
         {
            iwk.txt_1.text = "0/1";
         }
         if(Main.player1.getBag().getOtherobjNum(63224) > 0)
         {
            iwk.txt_2.text = "1/1";
            _loc1_++;
         }
         else
         {
            iwk.txt_2.text = "0/1";
         }
         if(Main.player1.getBag().getOtherobjNum(63225) > 0)
         {
            iwk.txt_3.text = "1/1";
            _loc1_++;
         }
         else
         {
            iwk.txt_3.text = "0/1";
         }
         if(_loc1_ >= 3)
         {
            iwk.in_btn.visible = true;
         }
      }
      
      private function closed(param1:*) : *
      {
         Close();
      }
      
      private function nextWord(param1:*) : *
      {
         InWaterDoor.Open();
         Close();
      }
   }
}

