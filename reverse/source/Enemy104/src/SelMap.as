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
      
      public var pageNum:int = 1;
      
      public function SelMap()
      {
         super();
         btn.addEventListener(MouseEvent.CLICK,MouseIn2);
         this["next_btn"].addEventListener(MouseEvent.CLICK,Next_map);
         this["back_btn"].addEventListener(MouseEvent.CLICK,Back_map);
         MapYN();
      }
      
      public static function Close() : *
      {
         if(!selMapX)
         {
            selMapX = new SelMap();
         }
         selMapX.x = 5000;
         selMapX.y = 5000;
         selMapX.visible = false;
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!selMapX)
         {
            selMapX = new SelMap();
         }
         Main._stage.addChild(selMapX);
         selMapX.x = xx;
         selMapX.y = yy;
         selMapX.visible = true;
         Play_Interface.Close();
         Main.allClosePanel();
         selMapX.MapYN();
      }
      
      private function Back_map(e:*) : *
      {
         --pageNum;
         gotoAndStop(pageNum);
         MapYN();
      }
      
      private function Next_map(e:*) : *
      {
         ++pageNum;
         gotoAndStop(pageNum);
         MapYN();
      }
      
      private function MapYN() : *
      {
         setTimeout(OpenMapNum,100);
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
         Close();
      }
      
      private function OpenMapNum() : *
      {
         var i:int = 0;
         this["next_btn"].visible = true;
         this["back_btn"].visible = true;
         if(currentFrame == 1)
         {
            this["back_btn"].visible = false;
         }
         else if(currentFrame == totalFrames)
         {
            this["next_btn"].visible = false;
            this["next_提示_mc"].visible = false;
         }
         if(!Main.guanKa[9])
         {
            this["next_btn"].visible = false;
            this["next_提示_mc"].visible = false;
         }
         for(i = 1; i < 13; i++)
         {
            if(Boolean(this["M" + i]) && (Boolean(Main.guanKa[i]) || Boolean(i == 1)))
            {
               trace("M = " + i);
               this["M" + i].gotoAndStop(2);
               this["M" + i].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
               this["M" + i].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               this["M" + i].addEventListener(MouseEvent.CLICK,GameGo);
            }
         }
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

