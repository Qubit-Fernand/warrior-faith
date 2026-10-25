package src
{
   import com.hotpoint.braveManIII.views.achPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class GameOver extends MovieClip
   {
      
      public function GameOver()
      {
         super();
         back_btn.addEventListener(MouseEvent.CLICK,this.回村);
         if(Main.gameNum.getValue() > 16 && Main.gameNum.getValue() < 100)
         {
            re_btn.visible = false;
         }
         else
         {
            re_btn.visible = true;
         }
         re_btn.addEventListener(MouseEvent.CLICK,this.重开);
         AchData.gkOk();
      }
      
      private function 回村(param1:*) : *
      {
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Player.一起信春哥();
         this.visible = false;
         this.parent.removeChild(this);
         removeEventListener(MouseEvent.CLICK,this.回村);
         removeEventListener(MouseEvent.CLICK,this.重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 5;
         Main.allClosePanel();
         WinShow.All_0();
         Main.Save();
      }
      
      private function 重开(param1:*) : *
      {
         Main.gameNum2.setValue(1);
         Player.一起信春哥();
         this.visible = false;
         this.parent.removeChild(this);
         removeEventListener(MouseEvent.CLICK,this.回村);
         removeEventListener(MouseEvent.CLICK,this.重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 5;
         Main.allClosePanel();
         WinShow.All_0();
         Main.Save();
      }
   }
}

