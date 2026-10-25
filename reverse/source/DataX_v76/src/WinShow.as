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
         if(Main.gameNum.getValue() > 16 && Main.gameNum.getValue() < 50 || Main.gameNum.getValue() > 80 && Main.gameNum.getValue() < 100)
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
      
      public static function LianJi(param1:int) : *
      {
         if(param1 > txt_2)
         {
            txt_2 = param1;
         }
      }
      
      private function TextShow() : *
      {
         if(Main.gameNum.getValue() == SixOne_Interface.guankaNum && SixOne_Interface.state.getValue() == 2)
         {
            SixOne_Interface.state.setValue(3);
            SixOne_Interface.okTimes.setValue(SixOne_Interface.okTimes.getValue() + 1);
         }
         time_txt.text = TimeNum(txt_1);
         lianji_txt.text = "" + txt_2;
         num_txt.text = "" + txt_3;
         num2_txt.text = "" + txt_4;
         p_txt.text = "" + txt_5;
         var _loc1_:String = " / 1P等级" + Main.player_1.data.getLevel();
         if(Main.P1P2)
         {
            _loc1_ += " / 2P等级" + Main.player_2.data.getLevel();
         }
         var _loc2_:String = " / 关卡:" + Main.gameNum.getValue();
         if(Main.gameNum.getValue() > 100 && Main.gameNum.getValue() < 200)
         {
            _loc2_ = " / 关卡:副本" + (Main.gameNum.getValue() - 100);
         }
         else if(Main.gameNum.getValue() == 17)
         {
            _loc2_ = "/ 挑关卡:" + (Main.gameNum.getValue() - 16);
         }
         else if(Main.gameNum.getValue() > 17 && Main.gameNum.getValue() < 50)
         {
            _loc2_ = "/ 星灵擂台:" + (Main.gameNum.getValue() - 17);
         }
         else if(Main.gameNum.getValue() > 50 && Main.gameNum.getValue() < 81)
         {
            _loc2_ = "/ 海底:" + (Main.gameNum.getValue() - 50);
         }
         else if(Main.gameNum.getValue() > 80 && Main.gameNum.getValue() < 100)
         {
            _loc2_ = "/ 海底副本:" + (Main.gameNum.getValue() - 80);
         }
         else
         {
            _loc2_ = "/ 关卡:" + Main.gameNum.getValue();
         }
         var _loc3_:String = " / 难度:★";
         if(GameData.gameLV == 2)
         {
            _loc3_ = " / 难度:★★";
         }
         else if(GameData.gameLV == 3)
         {
            _loc3_ = " / 难度:★★★";
         }
         else if(GameData.gameLV == 4)
         {
            _loc3_ = " / 难度:★★★★";
         }
         XX_txt.text = "版本" + Main.varX / 100 + _loc1_ + _loc2_ + _loc3_;
      }
      
      private function TimeNum(param1:int) : String
      {
         param1 /= 27;
         var _loc2_:int = param1 / 3600;
         var _loc3_:int = (param1 - _loc2_ * 3600) / 60;
         var _loc4_:int = param1 - _loc2_ * 3600 - _loc3_ * 60;
         return _loc2_ + ":" + _loc3_ + ":" + _loc4_;
      }
      
      private function 回村(param1:*) : *
      {
         Main._stage.frameRate = 27;
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Load.loadGameNum = 1;
         Load.loadGameNum2 = 1;
         Player.一起信春哥();
         removeEventListener(MouseEvent.CLICK,回村);
         removeEventListener(MouseEvent.CLICK,重开);
         Main._this.Loading();
         GameData.deadMcYN = false;
         GameData.deadTime = 5;
         Main.allClosePanel();
         this.parent.removeChild(this);
         WinShow.All_0();
         Main.Save();
      }
      
      private function 重开(param1:*) : *
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

