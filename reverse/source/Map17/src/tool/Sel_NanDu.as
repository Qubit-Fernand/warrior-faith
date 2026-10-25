package src.tool
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class Sel_NanDu extends MovieClip
   {
      
      public static var GameNumX:Boolean = false;
      
      public function Sel_NanDu()
      {
         super();
         NanDu1_btn.addEventListener(MouseEvent.CLICK,NanDu1);
         NanDu2_btn.addEventListener(MouseEvent.CLICK,NanDu2);
         NanDu3_btn.addEventListener(MouseEvent.CLICK,NanDu3);
         Close_btn.addEventListener(MouseEvent.CLICK,Close);
      }
      
      public function Open() : *
      {
         NanDu1_mc.gotoAndStop("d" + Main.gameNum);
         NanDu2_mc.gotoAndStop("d" + Main.gameNum);
         NanDu3_mc.gotoAndStop("d" + Main.gameNum);
         this.x = this.y = 0;
         this.visible = true;
         NanDu2_btn.visible = NanDu3_btn.visible = false;
         TweenMax.to(NanDu2_mc,0,{"colorMatrixFilter":{"saturation":0}});
         TweenMax.to(NanDu3_mc,0,{"colorMatrixFilter":{"saturation":0}});
         if(Main.guanKa[Main.gameNum] > 1)
         {
            NanDu2_btn.visible = true;
            TweenMax.to(NanDu2_mc,0,{"colorMatrixFilter":{"saturation":1}});
         }
         if(Main.guanKa[Main.gameNum] > 2)
         {
            NanDu3_btn.visible = true;
            TweenMax.to(NanDu3_mc,0,{"colorMatrixFilter":{"saturation":1}});
         }
      }
      
      public function Close(e:* = null) : *
      {
         this.x = this.y = 5000;
         this.visible = false;
         if(GameNumX)
         {
            Main.gameNum = 0;
            Main.gameNum2 = 2;
         }
      }
      
      private function NanDu1(e:*) : *
      {
         GameData.gameLV = 1;
         GameGo();
      }
      
      private function NanDu2(e:*) : *
      {
         GameData.gameLV = 2;
         GameGo();
      }
      
      private function NanDu3(e:*) : *
      {
         GameData.gameLV = 3;
         GameGo();
      }
      
      private function GameGo() : *
      {
         GameNumX = false;
         Close();
         SelMap.Close();
         Main.gameNum2 = 1;
         Main._this.Loading();
      }
   }
}

