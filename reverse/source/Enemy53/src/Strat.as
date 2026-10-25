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
         _btn2.p1_btn.addEventListener(MouseEvent.CLICK,this.NewGame1);
         _btn2.p2_btn.addEventListener(MouseEvent.CLICK,this.NewGame2);
         _btn2.back_btn.addEventListener(MouseEvent.CLICK,this.NewGameBtnClose);
         _btn.load_btn.addEventListener(MouseEvent.CLICK,this.loadXX);
         _btn.newGame_btn.addEventListener(MouseEvent.CLICK,this.NewGameBtnOpen);
         _btn.操作说明_btn.addEventListener(MouseEvent.CLICK,this.操作说明Open);
         _btn.游戏更新_btn.addEventListener(MouseEvent.CLICK,this.游戏更新Open);
         _btn.论坛_btn.addEventListener(MouseEvent.CLICK,this.论坛);
         操作说明.back_btn.addEventListener(MouseEvent.CLICK,this.操作说明Open);
         游戏更新.back_btn.addEventListener(MouseEvent.CLICK,this.游戏更新Open);
         save_mc.close_btn1.addEventListener(MouseEvent.CLICK,this.CloseLoad);
         save_mc.close_btn2.addEventListener(MouseEvent.CLICK,this.CloseLoad);
         操作说明.visible = _btn.visible = _btn2.visible = KC_mc.visible = save_mc.visible = false;
         游戏更新.visible = true;
         _btn.visible = true;
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
      
      public static function startGame(e:* = null) : void
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
      
      private function 论坛(e:*) : *
      {
         var request:URLRequest = new URLRequest("http://my.4399.com/space-mtag-tagid-81127.html");
         navigateToURL(request,"_blank");
      }
      
      private function 初始化() : Boolean
      {
         if(Boolean(this.初始化YN) && Boolean(Main.tempDataEnd))
         {
            return true;
         }
         this.初始化mc = new 游戏初始化();
         addChild(this.初始化mc);
         this.onLog();
         _btn2.visible = false;
         return false;
      }
      
      private function onLog(e:* = null) : *
      {
         Main._this.showLogUi();
         this.初始化YN = true;
         Api_4399_All.Init(Main._stage);
         this.调用等待弹出();
      }
      
      private function loadXX(e:* = null) : *
      {
         _btn.visible = false;
         this.初始化等待 = 2;
         if(this.初始化())
         {
            this.LoadSave();
         }
      }
      
      private function NewGameBtnOpen(e:* = null) : *
      {
         _btn.visible = false;
         this.初始化等待 = 1;
         if(this.初始化())
         {
            _btn.visible = false;
            _btn2.visible = true;
         }
      }
      
      public function NewGame1(e:* = null) : *
      {
         Main.saveNum = -1;
         Main.P1P2 = false;
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         this.NewSave();
      }
      
      public function NewGame2(e:* = null) : *
      {
         Main.saveNum = -1;
         Main.P1P2 = true;
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         this.NewSave();
      }
      
      public function NewSave() : *
      {
         var i:int = 0;
         save_mc.visible = true;
         save_mc.save_load_mc.gotoAndStop(1);
         save_mc["Load_Info_mc"].visible = false;
         StoragePanel.storage = null;
         Main.player1 = null;
         Main.player2 = null;
         Main.questArr = [[false,84110],[false,84111],[false,84112],[false,84113],[false,84114]];
         for(i = 0; i < 8; i++)
         {
            save_mc["save" + i].removeEventListener(MouseEvent.CLICK,this.LoadNum);
            save_mc["save" + i].addEventListener(MouseEvent.CLICK,this.saveNum);
            save_mc["txt_" + i].text = "" + SAVE_LIST[i];
         }
         for(i = 0; i < 151; i++)
         {
            Main.guanKa[i] = 0;
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
         for(var i:int = 0; i < 8; i++)
         {
            save_mc["save" + i].removeEventListener(MouseEvent.CLICK,this.saveNum);
            save_mc["save" + i].addEventListener(MouseEvent.CLICK,this.LoadNum);
            save_mc["txt_" + i].text = "" + SAVE_LIST[i];
         }
         Main.GetServerTime();
         TeShuHuoDong.Init();
      }
      
      public function KCplay() : *
      {
         KC_mc.visible = true;
         KC_mc.st_btn.addEventListener(MouseEvent.CLICK,this.SelZY);
         addEventListener(Event.ENTER_FRAME,this.ZhiMuGunDong);
      }
      
      private function ZhiMuGunDong(e:*) : *
      {
         ++this.kqTime;
         if(this.kqTime < 550)
         {
            KC_mc.zhiMu_mc.y -= 2;
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.ZhiMuGunDong);
         }
      }
      
      private function SelZY(e:*) : *
      {
         Close();
         var num:int = 1;
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
      
      private function saveNum(e:*) : *
      {
         this.saveN = (e.target.name as String).substr(4,1);
         this.覆盖确认面板();
      }
      
      private function LoadNum(e:*) : *
      {
         this.saveN = (e.target.name as String).substr(4,1);
         if(SAVE_LIST[this.saveN] != "空存档")
         {
            save_mc.visible = false;
            Main.serviceHold.getData(false,this.saveN);
         }
      }
      
      private function 覆盖确认面板() : *
      {
         save_mc["Load_Info_mc"].Info_mc.gotoAndStop(1);
         save_mc["Load_Info_mc"].visible = true;
         save_mc["Load_Info_mc"].yes_btn.removeEventListener(MouseEvent.CLICK,this.信息关闭);
         save_mc["Load_Info_mc"].no_btn.removeEventListener(MouseEvent.CLICK,this.信息关闭);
         save_mc["Load_Info_mc"].yes_btn.addEventListener(MouseEvent.CLICK,this.覆盖Yse);
         save_mc["Load_Info_mc"].no_btn.addEventListener(MouseEvent.CLICK,this.覆盖No);
      }
      
      private function 覆盖Yse(e:*) : *
      {
         Main.saveNum = this.saveN;
         this.KCplay();
      }
      
      private function 覆盖No(e:*) : *
      {
         save_mc["Load_Info_mc"].visible = false;
      }
      
      private function CloseLoad(e:*) : *
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
         save_mc["Load_Info_mc"].yes_btn.removeEventListener(MouseEvent.CLICK,this.覆盖Yse);
         save_mc["Load_Info_mc"].no_btn.removeEventListener(MouseEvent.CLICK,this.覆盖No);
         save_mc["Load_Info_mc"].yes_btn.addEventListener(MouseEvent.CLICK,this.信息关闭);
         save_mc["Load_Info_mc"].no_btn.addEventListener(MouseEvent.CLICK,this.信息关闭);
      }
      
      public function 复制存档信息() : *
      {
         save_mc.visible = true;
         save_mc["Load_Info_mc"].visible = true;
         save_mc["Load_Info_mc"].Info_mc.gotoAndStop(3);
         save_mc["Load_Info_mc"].yes_btn.removeEventListener(MouseEvent.CLICK,this.覆盖Yse);
         save_mc["Load_Info_mc"].no_btn.removeEventListener(MouseEvent.CLICK,this.覆盖No);
         save_mc["Load_Info_mc"].yes_btn.addEventListener(MouseEvent.CLICK,this.信息关闭2);
         save_mc["Load_Info_mc"].no_btn.addEventListener(MouseEvent.CLICK,this.信息关闭2);
      }
      
      private function 信息关闭(e:*) : *
      {
         save_mc["Load_Info_mc"].visible = false;
      }
      
      private function 信息关闭2(e:*) : *
      {
         navigateToURL(new URLRequest("javascript:location.reload(); "),"_self");
      }
      
      private function NewGameBtnClose(e:* = null) : *
      {
         _btn.visible = true;
         _btn2.visible = false;
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
      
      private function 游戏更新Close(e:* = null) : *
      {
         游戏更新.visible = false;
      }
      
      private function 操作说明Close(e:* = null) : *
      {
         操作说明.visible = false;
      }
      
      private function 调用等待弹出() : *
      {
         addEventListener(Event.ENTER_FRAME,this.等待弹出);
      }
      
      private function 等待弹出(e:*) : *
      {
         if(Main.loadSaveOver)
         {
            if(this.初始化等待 == 1)
            {
               this.NewGameBtnOpen();
            }
            else if(this.初始化等待 == 2)
            {
               this.LoadSave();
            }
            this.初始化mc.parent.removeChild(this.初始化mc);
            removeEventListener(Event.ENTER_FRAME,this.等待弹出);
            removeEventListener(Event.ENTER_FRAME,this.onLog);
         }
      }
   }
}

