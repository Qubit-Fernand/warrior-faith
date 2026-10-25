package src.tool
{
   import com.greensock.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class Sel_NanDu2 extends MovieClip
   {
      
      public static var _this:Sel_NanDu2;
      
      private static var gameNumX:int = 0;
      
      private var chenJiuArr:Array = [0,35,35,35,35,35,35];
      
      private var chenJiuXXXArr:Array = [0,19,49,59,79,89,99];
      
      public function Sel_NanDu2()
      {
         super();
         NanDu1_btn.addEventListener(MouseEvent.CLICK,NanDu1);
         NanDu2_btn.addEventListener(MouseEvent.CLICK,NanDu2);
         NanDu3_btn.addEventListener(MouseEvent.CLICK,NanDu3);
         NanDu4_btn.addEventListener(MouseEvent.CLICK,NanDu4);
         NanDu5_btn.addEventListener(MouseEvent.CLICK,NanDu5);
         NanDu6_btn.addEventListener(MouseEvent.CLICK,NanDu6);
         Close_btn.addEventListener(MouseEvent.CLICK,Close);
         dianQuan_mc.addEventListener(Event.ADDED_TO_STAGE,DianQuanShow);
         _this = this;
      }
      
      public static function DianQuanGoGame() : *
      {
         if(gameNumX == 0)
         {
            return;
         }
         Main.gameNum.setValue(gameNumX);
         GameData.gameLV = 4;
         _this.GameGo();
         gameNumX = 0;
      }
      
      private function DianQuanShow(param1:*) : *
      {
         if(dianQuan_mc)
         {
            dianQuan_mc.dianQuan_Yes.addEventListener(MouseEvent.CLICK,DianQuan);
            dianQuan_mc.dianQuan_No.addEventListener(MouseEvent.CLICK,DianQuanClose);
         }
      }
      
      public function Open() : *
      {
         this.x = this.y = 0;
         this.visible = true;
         dianQuan_mc.visible = false;
         Show();
      }
      
      public function Close(param1:* = null) : *
      {
         this.x = this.y = 5000;
         this.visible = false;
         dianQuan_mc.visible = false;
      }
      
      public function DianQuan(param1:* = null) : *
      {
         if(Shop4399.moneyAll.getValue() < InitData.xingLing.getValue())
         {
            (NoMoney_mc as NoMoneyInfo).Open(InitData.xingLing.getValue());
            return;
         }
         Api_4399_All.BuyObj(InitData.xingLing.getValue());
         dianQuan_mc.visible = false;
      }
      
      public function DianQuanClose(param1:* = null) : *
      {
         dianQuan_mc.visible = false;
      }
      
      private function NanDu1(param1:*) : *
      {
         if(Boolean(Main.isVip()) && AchData.cjPoint_1.getValue() >= 18)
         {
            Main.gameNum.setValue(18);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - 18);
         }
         else if(AchData.cjPoint_1.getValue() >= chenJiuArr[1])
         {
            Main.gameNum.setValue(18);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[1]);
         }
         else
         {
            dianQuan_mc.visible = true;
            gameNumX = 18;
         }
      }
      
      private function NanDu2(param1:*) : *
      {
         if(Boolean(Main.isVip()) && AchData.cjPoint_1.getValue() >= 18)
         {
            Main.gameNum.setValue(19);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - 18);
         }
         else if(AchData.cjPoint_1.getValue() >= chenJiuArr[2])
         {
            Main.gameNum.setValue(19);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[2]);
         }
         else
         {
            dianQuan_mc.visible = true;
            gameNumX = 19;
         }
      }
      
      private function NanDu3(param1:*) : *
      {
         if(Boolean(Main.isVip()) && AchData.cjPoint_1.getValue() >= 18)
         {
            Main.gameNum.setValue(20);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - 18);
         }
         else if(AchData.cjPoint_1.getValue() >= chenJiuArr[3])
         {
            Main.gameNum.setValue(20);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[3]);
         }
         else
         {
            dianQuan_mc.visible = true;
            gameNumX = 20;
         }
      }
      
      private function NanDu4(param1:*) : *
      {
         if(Boolean(Main.isVip()) && AchData.cjPoint_1.getValue() >= 18)
         {
            Main.gameNum.setValue(21);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - 18);
         }
         else if(AchData.cjPoint_1.getValue() >= chenJiuArr[4])
         {
            Main.gameNum.setValue(21);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[4]);
         }
         else
         {
            dianQuan_mc.visible = true;
            gameNumX = 21;
         }
      }
      
      private function NanDu5(param1:*) : *
      {
         if(Boolean(Main.isVip()) && AchData.cjPoint_1.getValue() >= 18)
         {
            Main.gameNum.setValue(22);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - 18);
         }
         else if(AchData.cjPoint_1.getValue() >= chenJiuArr[5])
         {
            Main.gameNum.setValue(22);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[5]);
         }
         else
         {
            dianQuan_mc.visible = true;
            gameNumX = 22;
         }
      }
      
      private function NanDu6(param1:*) : *
      {
         if(Boolean(Main.isVip()) && AchData.cjPoint_1.getValue() >= 18)
         {
            Main.gameNum.setValue(23);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - 18);
         }
         else if(AchData.cjPoint_1.getValue() >= chenJiuArr[6])
         {
            Main.gameNum.setValue(23);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[6]);
         }
         else
         {
            dianQuan_mc.visible = true;
            gameNumX = 23;
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
         var _loc1_:int = 1;
         while(_loc1_ < 7)
         {
            if(this["XXX_" + _loc1_])
            {
               if(AchData.cjPoint_2.getValue() > chenJiuXXXArr[_loc1_])
               {
                  this["XXX_" + _loc1_].visible = false;
               }
            }
            _loc1_++;
         }
         x1_txt.text = AchData.cjPoint_1.getValue();
         x2_txt.text = AchData.cjPoint_2.getValue();
         x4_txt.text = Shop4399.moneyAll.getValue();
      }
   }
}

