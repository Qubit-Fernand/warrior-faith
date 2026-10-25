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
      
      public static var SAVE_LIST:Array = [-1,-1,-1,-1,-1,-1,-1,-1];
      
      public var 初始化mc:MovieClip;
      
      private var saveN:int = 1;
      
      internal var time:int = 0;
      
      public function Strat()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onLog);
         _btn.p1_btn.addEventListener(MouseEvent.CLICK,NewGame1);
         _btn.p2_btn.addEventListener(MouseEvent.CLICK,NewGame2);
         _btn.load_btn.addEventListener(MouseEvent.CLICK,loadXX);
         _btn.论坛_btn.addEventListener(MouseEvent.CLICK,论坛);
         save_mc.close_btn1.addEventListener(MouseEvent.CLICK,CloseLoad);
         save_mc.close_btn2.addEventListener(MouseEvent.CLICK,CloseLoad);
         _btn.visible = KC_mc.visible = save_mc.visible = false;
         _btn.visible = true;
         初始化mc = new 游戏初始化();
         addChild(初始化mc);
         trace("初始化mc");
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!stratX)
         {
            stratX = new Strat();
         }
         Main._stage.addChild(stratX);
         stratX.x = param1;
         stratX.y = param2;
         stratX.visible = true;
      }
      
      public static function startGame(param1:* = null) : void
      {
         stratX.KC_mc.visible = false;
         Main._this.Loading();
         Strat.Close();
      }
      
      private static function loadXX(param1:* = null) : *
      {
         isGetData = true;
         Main.serviceHold.getData();
      }
      
      public static function Close() : *
      {
         if(!stratX)
         {
            stratX = new Strat();
         }
         Main._stage.addChild(stratX);
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
      
      public function NewSave() : *
      {
         var _loc1_:int = 0;
         save_mc["覆盖确认"].visible = false;
         save_mc.visible = true;
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            save_mc["save" + _loc1_].addEventListener(MouseEvent.CLICK,saveNum);
            save_mc["txt_" + _loc1_].text = "" + SAVE_LIST[_loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 151)
         {
            Main.guanKa[_loc1_] = false;
            _loc1_++;
         }
         Main.guanKa[1] = true;
      }
      
      private function 覆盖Yse(param1:*) : *
      {
         Main.saveNum = saveN;
         KCplay();
      }
      
      public function KCplay() : *
      {
         KC_mc.visible = true;
         KC_mc.gotoAndPlay(2);
         KC_mc.st_btn.addEventListener(MouseEvent.CLICK,SelZY);
      }
      
      private function saveNum(param1:*) : *
      {
         saveN = (param1.target.name as String).substr(4,1);
         覆盖确认面板();
      }
      
      private function CloseLoad(param1:*) : *
      {
         save_mc.visible = false;
      }
      
      private function NewGame2(param1:* = null) : *
      {
         isGetData = false;
         Main.saveNum = -1;
         Main.P1P2 = true;
         Main.gameNum = Main.gameNum2 = 0;
         NewSave();
      }
      
      private function 论坛(param1:*) : *
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://my.4399.com/space-mtag-tagid-81127.html");
         navigateToURL(_loc2_,"_blank");
      }
      
      private function onLog(param1:*) : *
      {
         ++time;
         if(time < 200)
         {
            if(Boolean(Main.serviceHold) && Boolean(Main.serviceHold.isLog))
            {
               Main._this.Info_txt.text += "\n 登录加载";
               _btn.visible = true;
               removeEventListener(Event.ENTER_FRAME,onLog);
            }
         }
         else
         {
            Main._this.showLogUi();
            if(初始化mc.parent is DisplayObject)
            {
               初始化mc.parent.removeChild(初始化mc);
               trace("初始化mc 移除");
            }
            time = -500;
         }
      }
      
      private function NewGame1(param1:* = null) : *
      {
         isGetData = false;
         Main.saveNum = -1;
         Main.P1P2 = false;
         Main.gameNum = Main.gameNum2 = 0;
         NewSave();
      }
      
      private function 覆盖No(param1:*) : *
      {
         save_mc["覆盖确认"].visible = false;
      }
      
      private function SelZY(param1:*) : *
      {
         var _loc2_:int = 0;
         Close();
         _loc2_ = 1;
         if(Main.P1P2)
         {
            _loc2_ = 3;
         }
         else
         {
            _loc2_ = 1;
         }
         SetProfession.open1(_loc2_);
      }
   }
}

