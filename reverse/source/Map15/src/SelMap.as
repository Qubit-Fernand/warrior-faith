package src
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   public class SelMap extends MovieClip
   {
      
      public static var selMapX:SelMap;
      
      public var pageNum:int = 1;
      
      public function SelMap()
      {
         super();
         btn.addEventListener(MouseEvent.CLICK,MouseIn2);
         this["next_btn"].addEventListener(MouseEvent.CLICK,Next_map);
         this["back_btn"].addEventListener(MouseEvent.CLICK,Back_map);
         MapYN();
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!selMapX)
         {
            selMapX = new SelMap();
         }
         Main._stage.addChild(selMapX);
         selMapX.x = xx;
         selMapX.y = yy;
         selMapX.visible = true;
         Play_Interface.Close();
         Main.allClosePanel();
         selMapX.MapYN();
      }
      
      public static function Close() : *
      {
         if(!selMapX)
         {
            selMapX = new SelMap();
         }
         selMapX.x = 5000;
         selMapX.y = 5000;
         selMapX.visible = false;
      }
      
      private function MapYN() : *
      {
         setTimeout(OpenMapNum,100);
      }
      
      private function Next_map(e:*) : *
      {
         ++pageNum;
         gotoAndStop(pageNum);
         MapYN();
      }
      
      private function Back_map(e:*) : *
      {
         --pageNum;
         gotoAndStop(pageNum);
         MapYN();
      }
      
      private function OpenMapNum() : *
      {
         this["next_btn"].visible = true;
         this["back_btn"].visible = true;
         if(currentFrame == 1)
         {
            this["back_btn"].visible = false;
         }
         else if(currentFrame == totalFrames)
         {
            this["next_btn"].visible = false;
            this["next_提示_mc"].visible = false;
         }
         if(!Main.guanKa[9])
         {
            this["next_btn"].visible = false;
            this["next_提示_mc"].visible = false;
         }
         if(Main.guanKa[1] == null || Main.guanKa[1] == false || Main.guanKa[1] == 0)
         {
            Main.guanKa[1] = 2;
         }
         for(var i:int = 1; i < 16; i++)
         {
            if(Boolean(this["M" + i]) && (Main.guanKa[i] != 0 || i == 1))
            {
               this["M" + i].gotoAndStop(2);
               this["M" + i].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
               this["M" + i].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               this["M" + i].addEventListener(MouseEvent.CLICK,sel_NanDu_Open);
            }
         }
         if(this["M17"])
         {
            this["M17"].gotoAndStop(2);
            this["M17"].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
            this["M17"].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
            this["M17"].addEventListener(MouseEvent.CLICK,GameGo);
         }
      }
      
      private function MouseIn2(e:*) : *
      {
         Main.gameNum = 0;
         Main.gameNum2 = 0;
         Main._this.Loading();
         Close();
      }
      
      private function sel_NanDu_Open(e:MouseEvent) : *
      {
         var num:int = int((e.currentTarget.name as String).substr(1,2));
         Main.gameNum = num;
         (Sel_nanDu_mc as Sel_NanDu).Open();
      }
      
      private function GameGo(e:*) : *
      {
         var num:int = 0;
         if(Main.player1.getBag().getOtherobjNum(63155) > 0)
         {
            Main.player1.getBag().delOtherById(63155,1);
            num = int((e.currentTarget.name as String).substr(1,2));
            Main.gameNum = num;
            Main.gameNum2 = 1;
            GameData.gameLV = 4;
            Main._this.Loading();
            Close();
            Main.Save();
         }
         else if(Boolean(Main.P1P2) && Main.player2.getBag().getOtherobjNum(63155) > 0)
         {
            Main.player2.getBag().delOtherById(63155,1);
            num = int((e.currentTarget.name as String).substr(1,2));
            Main.gameNum = num;
            Main.gameNum2 = 1;
            GameData.gameLV = 4;
            Main._this.Loading();
            Close();
         }
         else
         {
            NewMC.Open("无入场券",this,470,290,30,0,true,2);
         }
      }
      
      private function MouseIn(e:*) : *
      {
         e.currentTarget.gotoAndStop(3);
      }
      
      private function MouseOut(e:*) : *
      {
         e.currentTarget.gotoAndStop(2);
      }
   }
}

