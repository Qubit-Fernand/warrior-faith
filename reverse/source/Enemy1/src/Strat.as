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
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!stratX)
         {
            stratX = new Strat();
         }
         Main._stage.addChild(stratX);
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
      
      private static function loadXX(e:* = null) : *
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
         var i:int = 0;
         save_mc["覆盖确认"].visible = false;
         save_mc.visible = true;
         for(i = 0; i < 8; i++)
         {
            save_mc["save" + i].addEventListener(MouseEvent.CLICK,saveNum);
            save_mc["txt_" + i].text = "" + SAVE_LIST[i];
         }
         for(i = 0; i < 151; i++)
         {
            Main.guanKa[i] = false;
         }
         Main.guanKa[1] = true;
      }
      
      private function 覆盖Yse(e:*) : *
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
      
      private function saveNum(e:*) : *
      {
         saveN = (e.target.name as String).substr(4,1);
         覆盖确认面板();
      }
      
      private function CloseLoad(e:*) : *
      {
         save_mc.visible = false;
      }
      
      private function NewGame2(e:* = null) : *
      {
         isGetData = false;
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
      
      private function NewGame1(e:* = null) : *
      {
         isGetData = false;
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

