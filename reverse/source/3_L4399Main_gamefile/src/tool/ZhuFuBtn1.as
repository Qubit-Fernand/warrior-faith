package src.tool
{
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class ZhuFuBtn1 extends SimpleButton
   {
      
      public function ZhuFuBtn1()
      {
         super();
         addEventListener(MouseEvent.CLICK,onCLICK);
      }
      
      private function onCLICK(param1:*) : *
      {
         var _loc2_:int = 0;
         if(Main.gameNum.getValue() == 18)
         {
            _loc2_ = 4;
         }
         else if(Main.gameNum.getValue() == 19)
         {
            _loc2_ = 3;
         }
         else if(Main.gameNum.getValue() == 20)
         {
            _loc2_ = 1;
         }
         else if(Main.gameNum.getValue() == 21)
         {
            _loc2_ = 2;
         }
         else if(Main.gameNum.getValue() == 22)
         {
            _loc2_ = 5;
         }
         else if(Main.gameNum.getValue() == 23)
         {
            _loc2_ = 8;
         }
         JinHuaPanel.open(true,Main.gameNum.getValue() - 17,_loc2_);
      }
   }
}

