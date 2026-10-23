package src
{
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.tool.*;
   
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
         if(Main.gameNum.getValue() > 16 && Main.gameNum.getValue() < 50)
         {
            re_btn.visible = false;
         }
         else
         {
            re_btn.visible = true;
         }
         re_btn.addEventListener(MouseEvent.CLICK,重开);
         back_btn.addEventListener(MouseEvent.CLICK,回村);
         AchData.setTg();
         AchData.gkOk();
         TaskData.setTg();
         TaskData.isOk();
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
         time_txt.text = TimeNum(txt_1);
         lianji_txt.text = "" + txt_2;
         num_txt.text = "" + txt_3;
         num2_txt.text = "" + txt_4;
         p_txt.text = "" + txt_5;
         var lv:String = " / 1P等级" + Main.player_1.data.getLevel();
         if(Main.P1P2)
         {
            lv += " / 2P等级" + Main.player_2.data.getLevel();
         }
         var GameNumXX:String = " / 关卡:" + Main.gameNum.getValue();
         if(Main.gameNum.getValue() > 100 && Main.gameNum.getValue() < 200)
         {
            GameNumXX = " / 关卡:副本" + (Main.gameNum.getValue() - 100);
         }
         else if(Main.gameNum.getValue() == 17)
         {
            GameNumXX = "/ 挑关卡:" + (Main.gameNum.getValue() - 16);
         }
         else if(Main.gameNum.getValue() > 17 && Main.gameNum.getValue() < 50)
         {
            GameNumXX = "/ 星灵擂台:" + (Main.gameNum.getValue() - 17);
         }
         else if(Main.gameNum.getValue() > 50 && Main.gameNum.getValue() < 100)
         {
            GameNumXX = "/ 海底:" + (Main.gameNum.getValue() - 50);
         }
         else
         {
            GameNumXX = "/ 关卡:" + Main.gameNum.getValue();
         }
         var 难度:String = " / 难度:★";
         if(GameData.gameLV == 2)
         {
            难度 = " / 难度:★★";
         }
         else if(GameData.gameLV == 3)
         {
            难度 = " / 难度:★★★";
         }
         else if(GameData.gameLV == 4)
         {
            难度 = " / 难度:★★★★";
         }
         XX_txt.text = "版本" + Main.varX / 100 + lv + GameNumXX + 难度;
      }
      
      private function TimeNum(num:int) : String
      {
         num /= 27;
         var t1:int = num / 3600;
         var t2:int = (num - t1 * 3600) / 60;
         var t3:int = num - t1 * 3600 - t2 * 60;
         return t1 + ":" + t2 + ":" + t3;
      }
      
      private function 回村(e:*) : *
      {
         Main._stage.frameRate = 27;
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Player.一起信春哥();
         removeEventListener(MouseEvent.CLICK,回村);
         removeEventListener(MouseEvent.CLICK,重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 5;
         Main.allClosePanel();
         this.parent.removeChild(this);
         WinShow.All_0();
         Main.Save();
      }
      
      private function 重开(e:*) : *
      {
         Main._stage.frameRate = 27;
         Main.gameNum2.setValue(1);
         Player.一起信春哥();
         removeEventListener(MouseEvent.CLICK,回村);
         removeEventListener(MouseEvent.CLICK,重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 5;
         Main.allClosePanel();
         this.parent.removeChild(this);
         WinShow.All_0();
         Main.Save();
      }
   }
}

