package src
{
   import com.hotpoint.braveManIII.models.player.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   
   public class Strat extends MovieClip
   {
      
      public static var stratX:Strat;
      
      public static var isGetData:Boolean = false;
      
      public static var SAVE_LIST:Array = ["空存档","空存档","空存档","空存档","空存档","空存档","空存档","空存档"];
      
      public static var 说明1:String = "123";
      
      public static var 说明2:String = "456";
      
      public static var 说明3:String = "789";
      
      private var 初始化等待:int = 1;
      
      public var 初始化mc:MovieClip;
      
      private var saveN:int = 1;
      
      private var 初始化YN:Boolean = false;
      
      public function Strat()
      {
         super();
         _btn2.p1_btn.addEventListener(MouseEvent.CLICK,NewGame1);
         _btn2.p2_btn.addEventListener(MouseEvent.CLICK,NewGame2);
         _btn2.back_btn.addEventListener(MouseEvent.CLICK,NewGameBtnClose);
         _btn.load_btn.addEventListener(MouseEvent.CLICK,loadXX);
         _btn.newGame_btn.addEventListener(MouseEvent.CLICK,NewGameBtnOpen);
         _btn.操作说明_btn.addEventListener(MouseEvent.CLICK,操作说明Open);
         _btn.游戏更新_btn.addEventListener(MouseEvent.CLICK,游戏更新Open);
         操作说明.back_btn.addEventListener(MouseEvent.CLICK,操作说明Open);
         游戏更新.back_btn.addEventListener(MouseEvent.CLICK,游戏更新Open);
         _btn.论坛_btn.addEventListener(MouseEvent.CLICK,论坛);
         save_mc.close_btn1.addEventListener(MouseEvent.CLICK,CloseLoad);
         save_mc.close_btn2.addEventListener(MouseEvent.CLICK,CloseLoad);
         操作说明.visible = _btn.visible = _btn2.visible = KC_mc.visible = save_mc.visible = false;
         游戏更新.visible = true;
         _btn.visible = true;
      }
      
      public static function VarXX() : *
      {
         if(stratX)
         {
            stratX.游戏更新._txt.text = "" + Main.varX / 100;
            stratX.游戏更新.说明1_txt.text = Strat.说明1;
            stratX.游戏更新.说明2_txt.text = Strat.说明2;
            stratX.游戏更新.说明3_txt.text = Strat.说明3;
         }
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!stratX)
         {
            stratX = new Strat();
         }
         Main._this.addChild(stratX);
         stratX.x = xx;
         stratX.y = yy;
         stratX.visible = true;
      }
      
      public static function startGame(e:* = null) : void
      {
         stratX.KC_mc.visible = false;
         Main._this.Loading();
         Strat.Close();
      }
      
      public static function Close() : *
      {
         if(!stratX)
         {
            stratX = new Strat();
         }
         Main._this.addChild(stratX);
         stratX._btn.visible = false;
         stratX.x = stratX.y = 5000;
         stratX.visible = false;
      }
      
      private function 覆盖确认面板() : *
      {
         save_mc["覆盖确认"].visible = true;
         save_mc["覆盖确认"].yes_btn.addEventListener(MouseEvent.CLICK,覆盖Yse);
         save_mc["覆盖确认"].no_btn.addEventListener(MouseEvent.CLICK,覆盖No);
      }
      
      private function 操作说明Open(e:* = null) : *
      {
         if(操作说明.visible)
         {
            操作说明.visible = false;
         }
         else
         {
            操作说明.visible = true;
         }
         游戏更新.visible = false;
      }
      
      public function NewSave() : *
      {
         var i:int = 0;
         save_mc.visible = true;
         save_mc.save_load_mc.gotoAndStop(1);
         save_mc["覆盖确认"].visible = false;
         for(i = 0; i < 8; i++)
         {
            save_mc["save" + i].removeEventListener(MouseEvent.CLICK,LoadNum);
            save_mc["save" + i].addEventListener(MouseEvent.CLICK,saveNum);
            save_mc["txt_" + i].text = "" + SAVE_LIST[i];
         }
         for(i = 0; i < 151; i++)
         {
            Main.guanKa[i] = false;
         }
         Main.guanKa[1] = true;
      }
      
      private function 游戏更新Open(e:* = null) : *
      {
         if(游戏更新.visible)
         {
            游戏更新.visible = false;
         }
         else
         {
            游戏更新.visible = true;
         }
         操作说明.visible = false;
      }
      
      private function 等待弹出(e:*) : *
      {
         if(Main.loadSaveOver)
         {
            if(初始化等待 == 1)
            {
               NewGameBtnOpen();
            }
            else if(初始化等待 == 2)
            {
               LoadSave();
            }
            初始化mc.parent.removeChild(初始化mc);
            removeEventListener(Event.ENTER_FRAME,等待弹出);
            removeEventListener(Event.ENTER_FRAME,onLog);
         }
      }
      
      private function 覆盖Yse(e:*) : *
      {
         Main.saveNum = saveN;
         KCplay();
      }
      
      private function loadXX(e:* = null) : *
      {
         _btn.visible = false;
         初始化等待 = 2;
         if(初始化())
         {
            LoadSave();
         }
      }
      
      private function 操作说明Close(e:* = null) : *
      {
         操作说明.visible = false;
      }
      
      private function 调用等待弹出() : *
      {
         addEventListener(Event.ENTER_FRAME,等待弹出);
      }
      
      private function 游戏更新Close(e:* = null) : *
      {
         游戏更新.visible = false;
      }
      
      private function 初始化() : Boolean
      {
         if(Boolean(初始化YN) && Boolean(Main.tempDataEnd))
         {
            removeEventListener(Event.ENTER_FRAME,onLog);
            return true;
         }
         初始化mc = new 游戏初始化();
         addChild(初始化mc);
         trace("初始化mc");
         addEventListener(Event.ENTER_FRAME,onLog);
         _btn2.visible = false;
         return false;
      }
      
      private function LoadNum(e:*) : *
      {
         saveN = (e.target.name as String).substr(4,1);
         if(SAVE_LIST[saveN] != "空存档")
         {
            save_mc.visible = false;
            Main.serviceHold.getData(false,saveN);
         }
      }
      
      private function NewGameBtnClose(e:* = null) : *
      {
         _btn.visible = true;
         _btn2.visible = false;
      }
      
      public function KCplay() : *
      {
         KC_mc.visible = true;
         KC_mc.gotoAndPlay(2);
         KC_mc.st_btn.addEventListener(MouseEvent.CLICK,SelZY);
      }
      
      public function LoadSave() : *
      {
         var i:int = 0;
         save_mc.visible = true;
         save_mc["覆盖确认"].visible = false;
         save_mc.save_load_mc.gotoAndStop(2);
         for(i = 0; i < 8; i++)
         {
            save_mc["save" + i].removeEventListener(MouseEvent.CLICK,saveNum);
            save_mc["save" + i].addEventListener(MouseEvent.CLICK,LoadNum);
            save_mc["txt_" + i].text = "" + SAVE_LIST[i];
         }
      }
      
      private function saveNum(e:*) : *
      {
         saveN = (e.target.name as String).substr(4,1);
         覆盖确认面板();
      }
      
      private function NewGameBtnOpen(e:* = null) : *
      {
         _btn.visible = false;
         初始化等待 = 1;
         if(初始化())
         {
            _btn.visible = false;
            _btn2.visible = true;
         }
      }
      
      private function CloseLoad(e:*) : *
      {
         save_mc.visible = false;
         _btn2.visible = false;
         _btn.visible = true;
      }
      
      private function NewGame2(e:* = null) : *
      {
         Main.saveNum = -1;
         Main.P1P2 = true;
         Main.gameNum = Main.gameNum2 = 0;
         NewSave();
      }
      
      private function 论坛(e:*) : *
      {
         var request:URLRequest = null;
         request = new URLRequest("http://my.4399.com/space-mtag-tagid-81127.html");
         navigateToURL(request,"_blank");
      }
      
      private function onLog(e:*) : *
      {
         Main._this.showLogUi();
         if(初始化mc.parent is DisplayObject)
         {
            初始化YN = true;
            trace("初始化mc 移除");
            调用等待弹出();
            removeEventListener(Event.ENTER_FRAME,onLog);
            Api_4399_All.Init(Main._stage);
         }
      }
      
      private function NewGame1(e:* = null) : *
      {
         Main.saveNum = -1;
         Main.P1P2 = false;
         Main.gameNum = Main.gameNum2 = 0;
         NewSave();
      }
      
      private function 覆盖No(e:*) : *
      {
         save_mc["覆盖确认"].visible = false;
      }
      
      private function SelZY(e:*) : *
      {
         var num:int = 0;
         Close();
         num = 1;
         if(Main.P1P2)
         {
            num = 3;
         }
         else
         {
            num = 1;
         }
         SetProfession.open1(num);
      }
   }
}

