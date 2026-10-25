package src.tool
{
   import com.greensock.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class Sel_NanDu2 extends MovieClip
   {
      
      private var chenJiuArr:Array = [0,35,35,35,35,35,99999999];
      
      private var chenJiuXXXArr:Array = [0,19,49,59,79,89,99999999];
      
      public function Sel_NanDu2()
      {
         super();
         NanDu1_btn.addEventListener(MouseEvent.CLICK,NanDu1);
         NanDu2_btn.addEventListener(MouseEvent.CLICK,NanDu2);
         NanDu3_btn.addEventListener(MouseEvent.CLICK,NanDu3);
         NanDu4_btn.addEventListener(MouseEvent.CLICK,NanDu4);
         NanDu5_btn.addEventListener(MouseEvent.CLICK,NanDu5);
         Close_btn.addEventListener(MouseEvent.CLICK,Close);
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
         if(AchData.cjPoint_1.getValue() >= chenJiuArr[1])
         {
            Main.gameNum.setValue(18);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[1]);
         }
         else
         {
            ShortTip.open(42);
         }
      }
      
      private function NanDu2(param1:*) : *
      {
         if(AchData.cjPoint_1.getValue() >= chenJiuArr[2])
         {
            Main.gameNum.setValue(19);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[2]);
         }
         else
         {
            ShortTip.open(42);
         }
      }
      
      private function NanDu3(param1:*) : *
      {
         if(AchData.cjPoint_1.getValue() >= chenJiuArr[3])
         {
            Main.gameNum.setValue(20);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[3]);
         }
         else
         {
            ShortTip.open(42);
         }
      }
      
      private function NanDu4(param1:*) : *
      {
         if(AchData.cjPoint_1.getValue() >= chenJiuArr[4])
         {
            Main.gameNum.setValue(21);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[4]);
         }
         else
         {
            ShortTip.open(42);
         }
      }
      
      private function NanDu5(param1:*) : *
      {
         if(AchData.cjPoint_1.getValue() >= chenJiuArr[5])
         {
            Main.gameNum.setValue(22);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[5]);
         }
         else
         {
            ShortTip.open(42);
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

