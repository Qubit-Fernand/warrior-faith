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
         TextShow();
         Main._stage.addChild(this);
         Main._stage.frameRate = 0;
         re_btn.addEventListener(MouseEvent.CLICK,重开);
         back_btn.addEventListener(MouseEvent.CLICK,回村);
      }
      
      public static function LianJi(param1:int) : *
      {
         if(param1 > txt_2)
         {
            txt_2 = param1;
         }
      }
      
      public static function All_0() : *
      {
         txt_1 = txt_2 = txt_3 = txt_4 = txt_5 = 0;
      }
      
      private function TimeNum(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         param1 /= 27;
         _loc2_ = param1 / 3600;
         _loc3_ = (param1 - _loc2_ * 3600) / 60;
         _loc4_ = param1 - _loc2_ * 3600 - _loc3_ * 60;
         trace("t1 = " + _loc2_ + "t2 = " + _loc3_ + "t3 = " + _loc4_);
         return _loc2_ + ":" + _loc3_ + ":" + _loc4_;
      }
      
      private function 回村(param1:*) : *
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
      }
      
      private function 重开(param1:*) : *
      {
         WinShow.All_0();
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
      }
      
      private function TextShow() : *
      {
         trace("txt_1 = " + txt_1 + " txt_2 = " + txt_2 + " txt_3 = " + txt_3 + " txt_4 = " + txt_4 + " txt_5 = " + txt_5);
         time_txt.text = TimeNum(txt_1);
         lianji_txt.text = "" + txt_2;
         num_txt.text = "" + txt_3;
         num2_txt.text = "" + txt_4;
         p_txt.text = "" + txt_5;
      }
   }
}

