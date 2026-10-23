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
      
      private var chenJiuArr:Array = [0,80,120,240];
      
      public function Sel_NanDu2()
      {
         super();
         NanDu1_btn.addEventListener(MouseEvent.CLICK,NanDu1);
         Close_btn.addEventListener(MouseEvent.CLICK,Close);
         ShowTxt();
      }
      
      public function Open() : *
      {
         this.x = this.y = 0;
         this.visible = true;
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
            Main.gameNum = 18;
            GameData.gameLV = 4;
            GameGo();
            AchData.cjPoint_1.setValue(AchData.cjPoint_1.getValue() - chenJiuArr[1]);
         }
      }
      
      private function GameGo() : *
      {
         SelMap.Close();
         Main.gameNum2 = 1;
         Main._this.Loading();
         Close();
      }
      
      private function ShowTxt() : *
      {
         x1_txt.text = AchData.cjPoint_1.getValue();
         x2_txt.text = AchData.cjPoint_2.getValue();
         x4_txt.text = Shop4399.moneyAll.getValue();
      }
   }
}

