package src
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import src.tool.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2964")]
   public class SelMap extends MovieClip
   {
      
      public static var selMapX:SelMap;
      
      public static var pageNum:int = 1;
      
      public var M81:MovieClip;
      
      public var M19:MovieClip;
      
      public var Sel_nanDu_mc:Sel_NanDu;
      
      public var M51:MovieClip;
      
      public var M52:MovieClip;
      
      public var M53:MovieClip;
      
      public var next_提示_mc:MovieClip;
      
      public var M0:SimpleButton;
      
      public var M54:MovieClip;
      
      public var M10:MovieClip;
      
      public var M1:MovieClip;
      
      public var M55:MovieClip;
      
      public var M11:MovieClip;
      
      public var btn2:SimpleButton;
      
      public var M2:MovieClip;
      
      public var M12:MovieClip;
      
      public var Sel_nanDu_mc3:Sel_NanDu3;
      
      public var M3:MovieClip;
      
      public var M13:MovieClip;
      
      public var Sel_nanDu_mc2:Sel_NanDu2;
      
      public var btn:SimpleButton;
      
      public var M4:MovieClip;
      
      public var M14:MovieClip;
      
      public var M5:MovieClip;
      
      public var M15:MovieClip;
      
      public var M6:MovieClip;
      
      public var M16:MovieClip;
      
      public var back_btn:SimpleButton;
      
      public var M7:MovieClip;
      
      public var M17:MovieClip;
      
      public var M8:MovieClip;
      
      public var M18:MovieClip;
      
      public var next_btn:SimpleButton;
      
      public var M9:MovieClip;
      
      public function SelMap()
      {
         super();
         addFrameScript(0,frame1);
         M0.addEventListener(MouseEvent.CLICK,MouseIn2);
         btn.addEventListener(MouseEvent.CLICK,MouseIn2);
         btn2.addEventListener(MouseEvent.CLICK,MouseIn3);
         this["next_btn"].addEventListener(MouseEvent.CLICK,Next_map);
         this["back_btn"].addEventListener(MouseEvent.CLICK,Back_map);
         MapYN();
      }
      
      public static function Open(param1:int = 0, param2:int = 0, param3:uint = 1) : *
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
         if(param3 == 2)
         {
            selMapX.x = selMapX.y = -2000;
            (selMapX["Sel_nanDu_mc"] as Sel_NanDu).Open(2000,2000,2);
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
         setTimeout(OpenMapNum,100);
      }
      
      private function Next_map(param1:*) : *
      {
         if(pageNum < 2)
         {
            ++pageNum;
            gotoAndStop(pageNum);
            MapYN();
         }
      }
      
      private function Back_map(param1:*) : *
      {
         if(pageNum > 1)
         {
            --pageNum;
            gotoAndStop(pageNum);
            MapYN();
         }
      }
      
      private function OpenMapNum() : *
      {
         this["next_btn"].visible = true;
         this["back_btn"].visible = true;
         if(currentFrame == 1)
         {
            this["back_btn"].visible = false;
            if(!Main.guanKa[9] || Main.guanKa[9] == 0)
            {
               this["next_btn"].visible = false;
            }
         }
         else if(currentFrame == 2)
         {
            this["next_btn"].visible = false;
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
               this["M" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
               this["M" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               this["M" + _loc1_].addEventListener(MouseEvent.CLICK,sel_NanDu_Open);
            }
            _loc1_++;
         }
         _loc1_ = 51;
         while(_loc1_ < 56)
         {
            if(Boolean(this["M" + _loc1_]) && (Main.guanKa[_loc1_] != 0 || _loc1_ == 51))
            {
               this["M" + _loc1_].gotoAndStop(2);
               this["M" + _loc1_].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
               this["M" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
               this["M" + _loc1_].addEventListener(MouseEvent.CLICK,sel_NanDu_Open);
            }
            _loc1_++;
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
         if(this["M81"])
         {
            this["M81"].gotoAndStop(2);
            this["M81"].addEventListener(MouseEvent.MOUSE_OVER,MouseIn);
            this["M81"].addEventListener(MouseEvent.ROLL_OUT,MouseOut);
            this["M81"].addEventListener(MouseEvent.CLICK,sel_GuanKaXX_Open2);
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
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

