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
      
      public static var pageNum:int = 1;
      
      public function SelMap()
      {
         super();
         btn.addEventListener(MouseEvent.CLICK,this.MouseIn2);
         btn2.addEventListener(MouseEvent.CLICK,this.MouseIn3);
         this["next_btn"].addEventListener(MouseEvent.CLICK,this.Next_map);
         this["back_btn"].addEventListener(MouseEvent.CLICK,this.Back_map);
         this.MapYN();
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!selMapX)
         {
            selMapX = new SelMap();
         }
         Main._this.addChild(selMapX);
         selMapX.x = param1;
         selMapX.y = param2;
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
            selMapX.gotoAndStop(pageNum);
         }
      }
      
      public static function Close() : *
      {
         if(!selMapX)
         {
            selMapX = new SelMap();
         }
         Main._this.addChild(selMapX);
         selMapX.x = 5000;
         selMapX.y = 5000;
         selMapX.visible = false;
      }
      
      private function MapYN() : *
      {
         setTimeout(this.OpenMapNum,100);
      }
      
      private function Next_map(param1:*) : *
      {
         if(pageNum < 2)
         {
            ++pageNum;
            gotoAndStop(pageNum);
            this.MapYN();
         }
      }
      
      private function Back_map(param1:*) : *
      {
         if(pageNum > 1)
         {
            --pageNum;
            gotoAndStop(pageNum);
            this.MapYN();
         }
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
         var _loc1_:int = 1;
         while(_loc1_ < 17)
         {
            if(Boolean(this["M" + _loc1_]) && (Main.guanKa[_loc1_] != 0 || _loc1_ == 1))
            {
               this["M" + _loc1_].gotoAndStop(2);
               this["M" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.MouseIn);
               this["M" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.MouseOut);
               this["M" + _loc1_].addEventListener(MouseEvent.CLICK,this.sel_NanDu_Open);
            }
            _loc1_++;
         }
         _loc1_ = 51;
         while(_loc1_ < 54)
         {
            if(Boolean(this["M" + _loc1_]) && (Main.guanKa[_loc1_] != 0 || _loc1_ == 51))
            {
               this["M" + _loc1_].gotoAndStop(2);
               this["M" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.MouseIn);
               this["M" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,this.MouseOut);
               this["M" + _loc1_].addEventListener(MouseEvent.CLICK,this.sel_NanDu_Open);
            }
            _loc1_++;
         }
         if(this["M17"])
         {
            this["M17"].gotoAndStop(2);
            this["M17"].addEventListener(MouseEvent.MOUSE_OVER,this.MouseIn);
            this["M17"].addEventListener(MouseEvent.ROLL_OUT,this.MouseOut);
            this["M17"].addEventListener(MouseEvent.CLICK,this.GameGo);
         }
         if(this["M18"])
         {
            this["M18"].gotoAndStop(2);
            this["M18"].addEventListener(MouseEvent.MOUSE_OVER,this.MouseIn);
            this["M18"].addEventListener(MouseEvent.ROLL_OUT,this.MouseOut);
            this["M18"].addEventListener(MouseEvent.CLICK,this.sel_GuanKaXX_Open);
         }
         if(this["M81"])
         {
            this["M81"].gotoAndStop(2);
            this["M81"].addEventListener(MouseEvent.MOUSE_OVER,this.MouseIn);
            this["M81"].addEventListener(MouseEvent.ROLL_OUT,this.MouseOut);
            this["M81"].addEventListener(MouseEvent.CLICK,this.sel_GuanKaXX_Open2);
         }
      }
      
      private function MouseIn2(param1:*) : *
      {
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Main._this.GameStart();
         Close();
      }
      
      private function MouseIn3(param1:*) : *
      {
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(4);
         Main._this.Loading();
         Close();
      }
      
      private function sel_NanDu_Open(param1:MouseEvent) : *
      {
         var _loc2_:int = int((param1.currentTarget.name as String).substr(1,2));
         Main.gameNum.setValue(_loc2_);
         (Sel_nanDu_mc as Sel_NanDu).Open();
      }
      
      private function sel_GuanKaXX_Open(param1:MouseEvent) : *
      {
         (Sel_nanDu_mc2 as Sel_NanDu2).Open();
      }
      
      private function sel_GuanKaXX_Open2(param1:MouseEvent) : *
      {
         (Sel_nanDu_mc3 as Sel_NanDu3).Open();
      }
      
      private function GameGo(param1:*) : *
      {
         var _loc2_:int = 0;
         if(Main.player1.getBag().getOtherobjNum(63155) > 0)
         {
            Main.player1.getBag().delOtherById(63155,1);
            _loc2_ = int((param1.currentTarget.name as String).substr(1,2));
            Main.gameNum.setValue(_loc2_);
            Main.gameNum2.setValue(1);
            GameData.gameLV = 4;
            Main._this.Loading();
            Close();
            Main.Save();
         }
         else if(Boolean(Main.P1P2) && Main.player2.getBag().getOtherobjNum(63155) > 0)
         {
            Main.player2.getBag().delOtherById(63155,1);
            _loc2_ = int((param1.currentTarget.name as String).substr(1,2));
            Main.gameNum.setValue(_loc2_);
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
      
      private function MouseIn(param1:*) : *
      {
         param1.currentTarget.gotoAndStop(3);
      }
      
      private function MouseOut(param1:*) : *
      {
         param1.currentTarget.gotoAndStop(2);
      }
   }
}

