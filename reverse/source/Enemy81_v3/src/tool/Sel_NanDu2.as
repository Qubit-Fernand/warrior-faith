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
      }
      
      public function Open() : *
      {
         this.x = this.y = 0;
         this.visible = true;
         Show();
      }
      
      public function Close(e:* = null) : *
      {
         this.x = this.y = 5000;
         this.visible = false;
      }
      
      private function NanDu1(e:*) : *
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
      
      private function NanDu2(e:*) : *
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
      
      private function NanDu3(e:*) : *
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
      
      private function NanDu4(e:*) : *
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
      
      private function NanDu5(e:*) : *
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
      
      private function NanDu6(e:*) : *
      {
         if(AchData.cjPoint_1.getValue() >= chenJiuArr[6])
         {
            Main.gameNum.setValue(23);
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[6]);
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
         for(var i:int = 1; i < 7; i++)
         {
            if(this["XXX_" + i])
            {
               if(AchData.cjPoint_2.getValue() > chenJiuXXXArr[i])
               {
                  this["XXX_" + i].visible = false;
               }
            }
         }
         x1_txt.text = AchData.cjPoint_1.getValue();
         x2_txt.text = AchData.cjPoint_2.getValue();
         x4_txt.text = Shop4399.moneyAll.getValue();
      }
   }
}

