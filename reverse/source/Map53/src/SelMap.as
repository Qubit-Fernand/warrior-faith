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
         btn2.addEventListener(MouseEvent.CLICK,MouseIn3);
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
         if(Main.gameNum2.getValue() == 4)
         {
            selMapX.gotoAndStop(3);
         }
         else
         {
            selMapX.gotoAndStop(1);
         }
      }
      
      public static function Close() : *
      {
         if(!selMapX)
         {
            selMapX = new SelMap();
         }
         Main._stage.addChild(selMapX);
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
         gotoAndStop(2);
         MapYN();
      }
      
      private function Back_map(e:*) : *
      {
         gotoAndStop(1);
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
         else if(currentFrame == 2)
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
         for(var i:int = 1; i < 17; i++)
         {
            if(Boolean(this["M" + i]) && (Main.guanKa[i] != 0 || i == 1))
            {
               this["M" + i].gotoAndStop(2);
               this["M" + i].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
               this["M" + i].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               this["M" + i].addEventListener(MouseEvent.CLICK,sel_NanDu_Open);
            }
         }
         for(i = 51; i < 54; i++)
         {
            if(Boolean(this["M" + i]) && (Main.guanKa[i] != 0 || i == 51))
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
         if(this["M18"])
         {
            this["M18"].gotoAndStop(2);
            this["M18"].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
            this["M18"].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
            this["M18"].addEventListener(MouseEvent.CLICK,sel_GuanKaXX_Open);
         }
      }
      
      private function MouseIn2(e:*) : *
      {
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Main._this.GameStart();
         Close();
      }
      
      private function MouseIn3(e:*) : *
      {
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(4);
         Main._this.GameStart();
         Close();
      }
      
      private function sel_NanDu_Open(e:MouseEvent) : *
      {
         var num:int = int((e.currentTarget.name as String).substr(1,2));
         Main.gameNum.setValue(num);
         (Sel_nanDu_mc as Sel_NanDu).Open();
      }
      
      private function sel_GuanKaXX_Open(e:MouseEvent) : *
      {
         (Sel_nanDu_mc2 as Sel_NanDu2).Open();
      }
      
      private function GameGo(e:*) : *
      {
         var num:int = 0;
         if(Main.player1.getBag().getOtherobjNum(63155) > 0)
         {
            Main.player1.getBag().delOtherById(63155,1);
            num = int((e.currentTarget.name as String).substr(1,2));
            Main.gameNum.setValue(num);
            Main.gameNum2.setValue(1);
            GameData.gameLV = 4;
            Main._this.Loading();
            Close();
            Main.Save();
         }
         else if(Boolean(Main.P1P2) && Main.player2.getBag().getOtherobjNum(63155) > 0)
         {
            Main.player2.getBag().delOtherById(63155,1);
            num = int((e.currentTarget.name as String).substr(1,2));
            Main.gameNum.setValue(num);
            Main.gameNum2.setValue(1);
            GameData.gameLV = 4;
            Main._this.Loading();
            Close();
            Main.Save();
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

