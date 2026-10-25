package src.tool
{
   import com.greensock.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class Sel_NanDu3 extends MovieClip
   {
      
      public function Sel_NanDu3()
      {
         super();
         NanDu1_btn.addEventListener(MouseEvent.CLICK,NanDu1);
         Close_btn.addEventListener(MouseEvent.CLICK,Close);
         killPoint_btn.addEventListener(MouseEvent.CLICK,BuyKill);
      }
      
      public function Open() : *
      {
         this.x = this.y = 0;
         this.visible = true;
         Show();
      }
      
      public function Close(param1:* = null) : *
      {
         this.x = this.y = 5000;
         this.visible = false;
      }
      
      private function NanDu1(param1:*) : *
      {
         if(Main.guanKa[53] <= 0)
         {
            return;
         }
         if(Main.P1P2 == false && Main.player1.killPoint.getValue() >= InitData.BuyNum_20.getValue())
         {
            Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() - InitData.BuyNum_20.getValue());
            Main.gameNum.setValue(81);
            Main.gameNum2.setValue(1);
            GameData.gameLV = 4;
            GameGo();
         }
         else if(Main.P1P2 == true && Main.player1.killPoint.getValue() >= InitData.BuyNum_20.getValue() && Main.player2.killPoint.getValue() >= InitData.BuyNum_20.getValue())
         {
            Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() - InitData.BuyNum_20.getValue());
            Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() - InitData.BuyNum_20.getValue());
            Main.gameNum.setValue(81);
            Main.gameNum2.setValue(1);
            GameData.gameLV = 4;
            GameGo();
         }
         else
         {
            NewMC.Open("文字提示",Main._this,480,290,30,0,true,2,"击杀点不足");
         }
      }
      
      private function GameGo() : *
      {
         SelMap.Close();
         Main.gameNum2.setValue(1);
         Main._this.Loading();
         Close();
      }
      
      private function Show() : *
      {
         var _loc2_:uint = 0;
         var _loc1_:int = 1;
         while(_loc1_ < 2)
         {
            if(this["XXX_" + _loc1_])
            {
               _loc2_ = 50 + _loc1_ * 3;
               if(Main.guanKa[_loc2_] > 0)
               {
                  this["XXX_" + _loc1_].visible = false;
               }
               else
               {
                  this["XXX_" + _loc1_].visible = true;
               }
            }
            _loc1_++;
         }
         killPoint_1.text = Main.player1.killPoint.getValue();
         if(Main.P1P2)
         {
            killPoint_2.text = Main.player2.killPoint.getValue();
         }
      }
      
      private function BuyKill(param1:*) : *
      {
         Shop4399.Open(3);
      }
   }
}

