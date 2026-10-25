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
         var i:int = 0;
         super();
         btn.addEventListener(MouseEvent.CLICK,MouseIn2);
         for(i = 1; i < 10; i++)
         {
            if(Boolean(this["M" + i]) && Boolean(Main.guanKa[i]))
            {
               this["M" + i].gotoAndStop(2);
               this["M" + i].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
               this["M" + i].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               this["M" + i].addEventListener(MouseEvent.CLICK,GameGo);
            }
         }
      }
      
      public static function Close() : *
      {
         selMapX.x = 5000;
         selMapX.y = 5000;
         selMapX.visible = false;
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         selMapX = new SelMap();
         Main._stage.addChild(selMapX);
         selMapX.x = xx;
         selMapX.y = yy;
         selMapX.visible = true;
         Play_Interface.Close();
         Main.allClosePanel();
      }
      
      private function MouseIn(e:*) : *
      {
         e.currentTarget.gotoAndStop(3);
      }
      
      private function MouseOut(e:*) : *
      {
         e.currentTarget.gotoAndStop(2);
      }
      
      private function GameGo(e:MouseEvent) : *
      {
         var num:int = 0;
         num = int((e.currentTarget.name as String).substr(1,2));
         Main.gameNum = num;
         Main.gameNum2 = 1;
         Main._this.Loading();
         Load.loadName2 = "2";
         trace("选择关卡:" + Main.gameNum);
         WinShow.All_0();
         Close();
      }
      
      private function MouseIn2(e:*) : *
      {
         Main.gameNum = 0;
         Main.gameNum2 = 0;
         Main._this.Loading();
         Close();
      }
   }
}

