package src.tool
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class Sel_NanDu extends MovieClip
   {
      
      public function Sel_NanDu()
      {
         super();
         NanDu1_btn.addEventListener(MouseEvent.CLICK,this.NanDu1);
         NanDu2_btn.addEventListener(MouseEvent.CLICK,this.NanDu2);
         NanDu3_btn.addEventListener(MouseEvent.CLICK,this.NanDu3);
         Close_btn.addEventListener(MouseEvent.CLICK,this.Close);
      }
      
      public function Open() : *
      {
         NanDu1_mc.gotoAndStop("d" + Main.gameNum.getValue());
         NanDu2_mc.gotoAndStop("d" + Main.gameNum.getValue());
         NanDu3_mc.gotoAndStop("d" + Main.gameNum.getValue());
         this.x = this.y = 0;
         this.visible = true;
         NanDu2_btn.visible = NanDu3_btn.visible = false;
         TweenMax.to(NanDu2_mc,0,{"colorMatrixFilter":{"saturation":0}});
         TweenMax.to(NanDu3_mc,0,{"colorMatrixFilter":{"saturation":0}});
         if(Main.guanKa[Main.gameNum.getValue()] > 1)
         {
            NanDu2_btn.visible = true;
            TweenMax.to(NanDu2_mc,0,{"colorMatrixFilter":{"saturation":1}});
         }
         if(Main.guanKa[Main.gameNum.getValue()] > 2)
         {
            NanDu3_btn.visible = true;
            TweenMax.to(NanDu3_mc,0,{"colorMatrixFilter":{"saturation":1}});
         }
      }
      
      public function Close(param1:* = null) : *
      {
         this.x = this.y = 5000;
         this.visible = false;
      }
      
      private function NanDu1(param1:*) : *
      {
         GameData.gameLV = 1;
         this.GameGo();
      }
      
      private function NanDu2(param1:*) : *
      {
         GameData.gameLV = 2;
         this.GameGo();
      }
      
      private function NanDu3(param1:*) : *
      {
         GameData.gameLV = 3;
         this.GameGo();
      }
      
      private function GameGo() : *
      {
         this.Close();
         SelMap.Close();
         Main.gameNum2.setValue(1);
         Main._this.Loading();
      }
   }
}

