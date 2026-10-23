package src
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class SelMap extends MovieClip
   {
      
      public static var selMapX:SelMap;
      
      public function SelMap()
      {
         var _loc1_:int = 0;
         super();
         btn.addEventListener(MouseEvent.CLICK,MouseIn2);
         _loc1_ = 1;
         while(_loc1_ < 10)
         {
            if(Boolean(this["M" + _loc1_]) && Boolean(Main.guanKa[_loc1_]))
            {
               this["M" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
               this["M" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               this["M" + _loc1_].addEventListener(MouseEvent.CLICK,GameGo);
            }
            _loc1_++;
         }
      }
      
      public static function Close() : *
      {
         selMapX.x = 5000;
         selMapX.y = 5000;
         selMapX.visible = false;
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         selMapX = new SelMap();
         Main._stage.addChild(selMapX);
         selMapX.x = param1;
         selMapX.y = param2;
         selMapX.visible = true;
         Play_Interface.Close();
         Main.allClosePanel();
      }
      
      private function MouseIn(param1:*) : *
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      private function MouseOut(param1:*) : *
      {
         param1.currentTarget.gotoAndStop(1);
      }
      
      private function GameGo(param1:MouseEvent) : *
      {
         var _loc2_:int = 0;
         _loc2_ = int((param1.currentTarget.name as String).substr(1,2));
         Main.gameNum = _loc2_;
         Main.gameNum2 = 1;
         Main._this.Loading();
         Load.loadName2 = "2";
         trace("选择关卡:" + Main.gameNum);
         Close();
      }
      
      private function MouseIn2(param1:*) : *
      {
         Main.gameNum = 0;
         Main.gameNum2 = 0;
         Main._this.Loading();
         Close();
      }
   }
}

