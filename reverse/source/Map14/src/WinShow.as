package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class WinShow extends MovieClip
   {
      
      public static var txt_1:int = 0;
      
      public static var txt_2:int = 0;
      
      public static var txt_3:int = 0;
      
      public static var txt_4:int = 0;
      
      public static var txt_5:int = 0;
      
      public function WinShow()
      {
         super();
         GameData.GuanKaXX();
         TextShow();
         Main._stage.addChild(this);
         Main._stage.frameRate = 0;
         re_btn.addEventListener(MouseEvent.CLICK,重开);
         back_btn.addEventListener(MouseEvent.CLICK,回村);
      }
      
      public static function All_0() : *
      {
         txt_1 = txt_2 = txt_3 = txt_4 = txt_5 = 0;
      }
      
      public static function LianJi(num:int) : *
      {
         if(num > txt_2)
         {
            txt_2 = num;
         }
      }
      
      private function TextShow() : *
      {
         trace("txt_1 = " + txt_1 + " txt_2 = " + txt_2 + " txt_3 = " + txt_3 + " txt_4 = " + txt_4 + " txt_5 = " + txt_5);
         time_txt.text = TimeNum(txt_1);
         lianji_txt.text = "" + txt_2;
         num_txt.text = "" + txt_3;
         num2_txt.text = "" + txt_4;
         p_txt.text = "" + txt_5;
         var lv:String = "1P等级" + Main.player_1.data.getLevel();
         if(Main.P1P2)
         {
            lv += " / 2P等级" + Main.player_2.data.getLevel();
         }
         var GameNumXX:String = "" + Main.gameNum;
         if(Main.gameNum > 100)
         {
            GameNumXX = "副本" + (Main.gameNum - 100);
         }
         var 难度:String = "★";
         if(GameData.gameLV == 2)
         {
            难度 = "★★";
         }
         else if(GameData.gameLV == 3)
         {
            难度 = "★★★";
         }
         XX_txt.text = "版本" + Main.varX / 100 + " / " + lv + " / 关卡:" + GameNumXX + " / 难度:" + 难度;
      }
      
      private function TimeNum(num:int) : String
      {
         num /= 27;
         var t1:int = num / 3600;
         var t2:int = (num - t1 * 3600) / 60;
         var t3:int = num - t1 * 3600 - t2 * 60;
         trace("t1 = " + t1 + "t2 = " + t2 + "t3 = " + t3);
         return t1 + ":" + t2 + ":" + t3;
      }
      
      private function 回村(e:*) : *
      {
         Main._stage.frameRate = 27;
         Main.gameNum = 0;
         Main.gameNum2 = 0;
         Player.一起信春哥();
         removeEventListener(MouseEvent.CLICK,回村);
         removeEventListener(MouseEvent.CLICK,重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 135;
         Main.allClosePanel();
         this.parent.removeChild(this);
         WinShow.All_0();
      }
      
      private function 重开(e:*) : *
      {
         Main._stage.frameRate = 27;
         Main.gameNum2 = 1;
         Player.一起信春哥();
         removeEventListener(MouseEvent.CLICK,回村);
         removeEventListener(MouseEvent.CLICK,重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 135;
         Main.allClosePanel();
         this.parent.removeChild(this);
         WinShow.All_0();
      }
   }
}

