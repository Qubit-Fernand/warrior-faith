package src.tool
{
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   import src._data.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol6706")]
   public class CeShi extends MovieClip
   {
      
      public static var _this:CeShi;
      
      public var p2_btn:SimpleButton;
      
      public var _txt:TextField;
      
      public var _btn:SimpleButton;
      
      public var p1_btn:SimpleButton;
      
      public function CeShi()
      {
         super();
         _this = this;
         _txt.text = "开启调试";
         Main.tianShiYN = true;
         _btn.addEventListener(MouseEvent.CLICK,onCLICK);
         p1_btn.addEventListener(MouseEvent.CLICK,P1Go);
         p2_btn.addEventListener(MouseEvent.CLICK,P2Go);
      }
      
      private function onCLICK(param1:*) : *
      {
         if(Main.tianShiYN)
         {
            _txt.text = "关闭调试";
            Main.tianShiYN = false;
         }
         else
         {
            _txt.text = "开启调试";
            Main.tianShiYN = true;
         }
      }
      
      private function P1Go(param1:*) : *
      {
         Strat.stratX.NewGame1();
         Main.noSave = 43994396;
      }
      
      private function P2Go(param1:*) : *
      {
         Strat.stratX.NewGame2();
         Main.noSave = 43994377;
      }
   }
}

