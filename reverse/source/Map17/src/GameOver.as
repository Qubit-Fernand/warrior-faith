package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class GameOver extends MovieClip
   {
      
      public function GameOver()
      {
         super();
         back_btn.addEventListener(MouseEvent.CLICK,回村);
         if(Main.gameNum == 17)
         {
            re_btn.visible = false;
         }
         else
         {
            re_btn.visible = true;
         }
         re_btn.addEventListener(MouseEvent.CLICK,重开);
      }
      
      private function 回村(e:*) : *
      {
         Main.gameNum = 0;
         Main.gameNum2 = 0;
         Player.一起信春哥();
         this.visible = false;
         this.parent.removeChild(this);
         removeEventListener(MouseEvent.CLICK,回村);
         removeEventListener(MouseEvent.CLICK,重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 135;
         Main.allClosePanel();
         WinShow.All_0();
         Main.Save();
      }
      
      private function 重开(e:*) : *
      {
         Main.gameNum2 = 1;
         Player.一起信春哥();
         this.visible = false;
         this.parent.removeChild(this);
         removeEventListener(MouseEvent.CLICK,回村);
         removeEventListener(MouseEvent.CLICK,重开);
         Main._this.GameStart();
         GameData.deadMcYN = false;
         GameData.deadTime = 135;
         Main.allClosePanel();
         WinShow.All_0();
         Main.Save();
      }
   }
}

