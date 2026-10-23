package src
{
   import com.hotpoint.braveManIII.models.player.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.views.makePanel.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import src._data.*;
   import src.tool.*;
   
   public class Strat extends MovieClip
   {
      
      public static var stratX:Strat;
      
      public static var isGetData:Boolean = false;
      
      public static var SAVE_LIST:Array = ["空存档","空存档","空存档","空存档","空存档","空存档","空存档","空存档"];
      
      public static var 说明1:String = "123";
      
      public static var 说明2:String = "456";
      
      public static var 说明3:String = "789";
      
      public var 初始化mc:MovieClip;
      
      private var 初始化YN:Boolean = false;
      
      private var 初始化等待:int = 1;
      
      private var kqTime:int = 0;
      
      private var saveN:int = 1;
      
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
         _btn.论坛_btn.addEventListener(MouseEvent.CLICK,论坛);
         操作说明.back_btn.addEventListener(MouseEvent.CLICK,操作说明Open);
         游戏更新.back_btn.addEventListener(MouseEvent.CLICK,游戏更新Open);
         save_mc.close_btn1.addEventListener(MouseEvent.CLICK,CloseLoad);
         save_mc.close_btn2.addEventListener(MouseEvent.CLICK,CloseLoad);
         游戏更新.http_btn.addEventListener(MouseEvent.CLICK,http_Fun);
         操作说明.visible = _btn.visible = _btn2.visible = KC_mc.visible = save_mc.visible = false;
         游戏更新.visible = true;
         _btn.visible = true;
         btn_mc.gotoAndStop("弹出stop");
         addEventListener(Event.ENTER_FRAME,on_MC_ENTER_FRAME);
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!stratX)
         {
            stratX = new Strat();
         }
         Main._this.addChild(stratX);
         stratX.x = param1;
         stratX.y = param2;
         stratX.visible = true;
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
      
      public static function startGame(param1:* = null) : void
      {
         Api_4399_All.Money_sel();
         stratX.KC_mc.visible = false;
         Main._this.Loading();
         Strat.Close();
      }
      
      public static function VarXX() : *
      {
         if(stratX)
         {
            stratX.游戏更新._txt.text = "正式版v" + int(Main.varX / 100) + "." + int(Main.varX % 100);
            stratX.游戏更新.说明1_txt.text = Strat.说明1;
            stratX.游戏更新.说明2_txt.text = Strat.说明2;
            stratX.游戏更新.说明3_txt.text = Strat.说明3;
         }
      }
      
      private function on_MC_ENTER_FRAME(param1:*) : *
      {
         if(btn_mc.currentLabel == "收进stop")
         {
            _btn.visible = false;
            _btn2.visible = true;
         }
         else if(btn_mc.currentLabel == "弹出stop")
         {
            _btn.visible = true;
            _btn2.visible = false;
         }
         else
         {
            _btn.visible = _btn2.visible = false;
         }
      }
      
      private function http_Fun(param1:*) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://my.4399.com/forums-thread-id-33880763-tagid-81127.html");
         navigateToURL(_loc2_,"_blank");
      }
      
      private function 论坛(param1:*) : *
      {
         var _loc2_:URLRequest = new URLRequest("http://my.4399.com/space-mtag-tagid-81127.html");
         navigateToURL(_loc2_,"_blank");
      }
      
      private function 初始化() : Boolean
      {
         if(Boolean(初始化YN) && Boolean(Main.tempDataEnd))
         {
            return true;
         }
         初始化mc = new 游戏初始化();
         addChild(初始化mc);
         trace("初始化mc");
         onLog();
         _btn2.visible = false;
         return false;
      }
      
      private function onLog(param1:* = null) : *
      {
         Main._this.showLogUi();
         初始化YN = true;
         Api_4399_All.Init(Main._stage);
         调用等待弹出();
      }
      
      private function loadXX(param1:* = null) : *
      {
         _btn.visible = false;
         初始化等待 = 2;
         if(初始化())
         {
            LoadSave();
         }
      }
      
      private function NewGameBtnOpen(param1:* = null) : *
      {
         btn_mc.gotoAndPlay("收进");
         _btn.visible = false;
         初始化等待 = 1;
         if(初始化())
         {
            _btn.visible = false;
            _btn2.visible = true;
         }
      }
      
      public function NewGame1(param1:* = null) : *
      {
         Main.saveNum = -1;
         Main.P1P2 = false;
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         NewSave();
      }
      
      public function NewGame2(param1:* = null) : *
      {
         Main.saveNum = -1;
         Main.P1P2 = true;
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         NewSave();
      }
      
      public function NewSave() : *
      {
         var _loc1_:int = 0;
         save_mc.visible = true;
         save_mc.save_load_mc.gotoAndStop(1);
         save_mc["Load_Info_mc"].visible = false;
         StoragePanel.storage = null;
         Main.player1 = null;
         Main.player2 = null;
         Main.questArr = [[false,84110],[false,84111],[false,84112],[false,84113],[false,84114]];
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            save_mc["save" + _loc1_].removeEventListener(MouseEvent.CLICK,LoadNum);
            save_mc["save" + _loc1_].addEventListener(MouseEvent.CLICK,saveNum);
            save_mc["txt_" + _loc1_].text = "" + SAVE_LIST[_loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 151)
         {
            Main.guanKa[_loc1_] = 0;
            _loc1_++;
         }
         Main.guanKa[1] = 1;
         Main.GetServerTime();
         MakeData.clearXXX();
         Main.NoLog = 0;
         TeShuHuoDong.Init();
      }
      
      public function LoadSave() : *
      {
         save_mc.visible = true;
         save_mc["Load_Info_mc"].visible = false;
         save_mc.save_load_mc.gotoAndStop(2);
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            save_mc["save" + _loc1_].removeEventListener(MouseEvent.CLICK,saveNum);
            save_mc["save" + _loc1_].addEventListener(MouseEvent.CLICK,LoadNum);
            save_mc["txt_" + _loc1_].text = "" + SAVE_LIST[_loc1_];
            _loc1_++;
         }
         Main.GetServerTime();
         TeShuHuoDong.Init();
      }
      
      public function KCplay() : *
      {
         KC_mc.visible = true;
         KC_mc.st_btn.addEventListener(MouseEvent.CLICK,SelZY);
         addEventListener(Event.ENTER_FRAME,ZhiMuGunDong);
      }
      
      private function ZhiMuGunDong(param1:*) : *
      {
         ++kqTime;
         if(kqTime < 550)
         {
            KC_mc.zhiMu_mc.y -= 2;
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,ZhiMuGunDong);
         }
      }
      
      private function SelZY(param1:*) : *
      {
         Close();
         SetProfession.open();
      }
      
      private function saveNum(param1:*) : *
      {
         saveN = (param1.target.name as String).substr(4,1);
         覆盖确认面板();
      }
      
      private function LoadNum(param1:*) : *
      {
         saveN = (param1.target.name as String).substr(4,1);
         if(SAVE_LIST[saveN] != "空存档")
         {
            save_mc.visible = false;
            Main.serviceHold.getData(false,saveN);
         }
      }
      
      private function 覆盖确认面板() : *
      {
         save_mc["Load_Info_mc"].Info_mc.gotoAndStop(1);
         save_mc["Load_Info_mc"].visible = true;
         save_mc["Load_Info_mc"].yes_btn.removeEventListener(MouseEvent.CLICK,信息关闭);
         save_mc["Load_Info_mc"].no_btn.removeEventListener(MouseEvent.CLICK,信息关闭);
         save_mc["Load_Info_mc"].yes_btn.addEventListener(MouseEvent.CLICK,覆盖Yse);
         save_mc["Load_Info_mc"].no_btn.addEventListener(MouseEvent.CLICK,覆盖No);
      }
      
      private function 覆盖Yse(param1:*) : *
      {
         Main.saveNum = saveN;
         KCplay();
      }
      
      private function 覆盖No(param1:*) : *
      {
         save_mc["Load_Info_mc"].visible = false;
      }
      
      private function CloseLoad(param1:*) : *
      {
         save_mc.visible = false;
         _btn2.visible = false;
         _btn.visible = true;
      }
      
      public function 游戏盒信息() : *
      {
         save_mc.visible = true;
         save_mc["Load_Info_mc"].visible = true;
         save_mc["Load_Info_mc"].Info_mc.gotoAndStop(2);
         save_mc["Load_Info_mc"].yes_btn.removeEventListener(MouseEvent.CLICK,覆盖Yse);
         save_mc["Load_Info_mc"].no_btn.removeEventListener(MouseEvent.CLICK,覆盖No);
         save_mc["Load_Info_mc"].yes_btn.addEventListener(MouseEvent.CLICK,信息关闭);
         save_mc["Load_Info_mc"].no_btn.addEventListener(MouseEvent.CLICK,信息关闭);
      }
      
      public function 复制存档信息() : *
      {
         save_mc.visible = true;
         save_mc["Load_Info_mc"].visible = true;
         save_mc["Load_Info_mc"].Info_mc.gotoAndStop(3);
         save_mc["Load_Info_mc"].yes_btn.removeEventListener(MouseEvent.CLICK,覆盖Yse);
         save_mc["Load_Info_mc"].no_btn.removeEventListener(MouseEvent.CLICK,覆盖No);
         save_mc["Load_Info_mc"].yes_btn.addEventListener(MouseEvent.CLICK,信息关闭2);
         save_mc["Load_Info_mc"].no_btn.addEventListener(MouseEvent.CLICK,信息关闭2);
      }
      
      private function 信息关闭(param1:*) : *
      {
         save_mc["Load_Info_mc"].visible = false;
      }
      
      private function 信息关闭2(param1:*) : *
      {
         navigateToURL(new URLRequest("javascript:location.reload(); "),"_self");
      }
      
      private function NewGameBtnClose(param1:* = null) : *
      {
         btn_mc.gotoAndPlay("弹出");
         _btn.visible = true;
         _btn2.visible = false;
      }
      
      private function 游戏更新Open(param1:* = null) : *
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
      
      private function 操作说明Open(param1:* = null) : *
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
      
      private function 游戏更新Close(param1:* = null) : *
      {
         游戏更新.visible = false;
      }
      
      private function 操作说明Close(param1:* = null) : *
      {
         操作说明.visible = false;
      }
      
      private function 调用等待弹出() : *
      {
         addEventListener(Event.ENTER_FRAME,等待弹出);
      }
      
      private function 等待弹出(param1:*) : *
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
   }
}

