package com.hotpoint.braveManIII.views.setProfession
{
   import com.hotpoint.braveManIII.models.player.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class SetProfession extends MovieClip
   {
      
      public static var spp:SetProfession;
      
      public static var wqPanel:MovieClip = new WQ_Interface();
      
      public static var skinArr1:Array = [0,1];
      
      public static var skinArr2:Array = [0,1];
      
      public static var p1_num:int = 0;
      
      public static var p2_num:int = 0;
      
      public static var p_now:int = 1;
      
      private static var temp:int = 0;
      
      public function SetProfession()
      {
         super();
         this.addChild(wqPanel);
      }
      
      public static function open() : void
      {
         if(spp == null)
         {
            spp = new SetProfession();
         }
         spp.x = 0;
         spp.y = 0;
         addListenerP1();
         Main._stage.addChild(spp);
         spp.visible = true;
      }
      
      public static function close() : void
      {
         if(spp == null)
         {
            spp = new QiangHuaPanel();
         }
         removeListenerP1();
         spp.visible = false;
      }
      
      public static function addListenerP1() : *
      {
         wqPanel["jian"].gotoAndStop(1);
         wqPanel["zhang"].gotoAndStop(1);
         wqPanel["quan"].gotoAndStop(1);
         wqPanel["jian"].addEventListener(MouseEvent.CLICK,jianClick);
         wqPanel["jian"].addEventListener(MouseEvent.MOUSE_OVER,doOver);
         wqPanel["jian"].addEventListener(MouseEvent.MOUSE_OUT,doOut);
         wqPanel["zhang"].addEventListener(MouseEvent.CLICK,zhangClick);
         wqPanel["zhang"].addEventListener(MouseEvent.MOUSE_OVER,doOver);
         wqPanel["zhang"].addEventListener(MouseEvent.MOUSE_OUT,doOut);
         wqPanel["quan"].addEventListener(MouseEvent.CLICK,quanClick);
         wqPanel["quan"].addEventListener(MouseEvent.MOUSE_OVER,doOver);
         wqPanel["quan"].addEventListener(MouseEvent.MOUSE_OUT,doOut);
         wqPanel["re_btn"].addEventListener(MouseEvent.CLICK,reChose);
         wqPanel["ok_btn"].addEventListener(MouseEvent.CLICK,okChose);
         wqPanel["jian"].mouseChildren = false;
         wqPanel["zhang"].mouseChildren = false;
         wqPanel["quan"].mouseChildren = false;
         wqPanel["txt_2"].visible = false;
      }
      
      public static function removeListenerP1() : *
      {
         wqPanel["jian"].removeEventListener(MouseEvent.CLICK,jianClick);
         wqPanel["jian"].removeEventListener(MouseEvent.MOUSE_OVER,doOver);
         wqPanel["jian"].removeEventListener(MouseEvent.MOUSE_OUT,doOut);
         wqPanel["zhang"].removeEventListener(MouseEvent.CLICK,zhangClick);
         wqPanel["zhang"].removeEventListener(MouseEvent.MOUSE_OVER,doOver);
         wqPanel["zhang"].removeEventListener(MouseEvent.MOUSE_OUT,doOut);
         wqPanel["quan"].removeEventListener(MouseEvent.CLICK,quanClick);
         wqPanel["quan"].removeEventListener(MouseEvent.MOUSE_OVER,doOver);
         wqPanel["quan"].removeEventListener(MouseEvent.MOUSE_OUT,doOut);
         wqPanel["re_btn"].removeEventListener(MouseEvent.CLICK,reChose);
         wqPanel["ok_btn"].removeEventListener(MouseEvent.CLICK,okChose);
      }
      
      private static function doOver(param1:*) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame <= 2)
         {
            _loc2_.gotoAndStop(2);
         }
      }
      
      private static function doOut(param1:*) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame <= 2)
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      private static function jianClick(param1:*) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(p_now == 1)
         {
            if(p1_num < 2 && _loc2_.currentFrame <= 2)
            {
               _loc2_.gotoAndStop(3);
               skinArr1[p1_num] = 0;
               ++p1_num;
               wqPanel["txt_1"].text += "剑";
            }
         }
         else if(p_now == 2)
         {
            if(p2_num < 2 && _loc2_.currentFrame <= 2)
            {
               _loc2_.gotoAndStop(3);
               skinArr2[p2_num] = 0;
               ++p2_num;
               wqPanel["txt_2"].text += "剑";
            }
         }
         if(p1_num == 1 || p2_num == 1)
         {
            NewMC.Open("文字提示",Main._stage,480,400,70,0,true,2,"请继续选择右手武器");
         }
         if(Main.P1P2)
         {
            if(p1_num == 2 && p_now == 1)
            {
               p_now = 2;
               wqPanel.addEventListener(Event.ENTER_FRAME,ChoseP2);
            }
         }
      }
      
      private static function zhangClick(param1:*) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(p_now == 1)
         {
            if(p1_num < 2 && _loc2_.currentFrame <= 2)
            {
               _loc2_.gotoAndStop(3);
               skinArr1[p1_num] = 1;
               ++p1_num;
               wqPanel["txt_1"].text += "杖";
            }
         }
         else if(p_now == 2)
         {
            if(p2_num < 2 && _loc2_.currentFrame <= 2)
            {
               _loc2_.gotoAndStop(3);
               skinArr2[p2_num] = 1;
               ++p2_num;
               wqPanel["txt_2"].text += "杖";
            }
         }
         if(p1_num == 1 || p2_num == 1)
         {
            NewMC.Open("文字提示",Main._stage,480,400,70,0,true,2,"请继续选择右手武器");
         }
         if(Main.P1P2)
         {
            if(p1_num == 2 && p_now == 1)
            {
               p_now = 2;
               wqPanel.addEventListener(Event.ENTER_FRAME,ChoseP2);
            }
         }
      }
      
      private static function quanClick(param1:*) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(p_now == 1)
         {
            if(p1_num < 2 && _loc2_.currentFrame <= 2)
            {
               _loc2_.gotoAndStop(3);
               skinArr1[p1_num] = 2;
               ++p1_num;
               wqPanel["txt_1"].text += "拳";
            }
         }
         else if(p_now == 2)
         {
            if(p2_num < 2 && _loc2_.currentFrame <= 2)
            {
               _loc2_.gotoAndStop(3);
               skinArr2[p2_num] = 2;
               ++p2_num;
               wqPanel["txt_2"].text += "拳";
            }
         }
         if(p1_num == 1 || p2_num == 1)
         {
            NewMC.Open("文字提示",Main._stage,480,400,70,0,true,2,"请继续选择右手武器");
         }
         if(Main.P1P2)
         {
            if(p1_num == 2 && p_now == 1)
            {
               p_now = 2;
               wqPanel.addEventListener(Event.ENTER_FRAME,ChoseP2);
            }
         }
      }
      
      private static function ChoseP2(param1:*) : void
      {
         ++temp;
         if(temp > 100)
         {
            if(wqPanel["jian"].currentFrame > 2)
            {
               wqPanel["jian"].gotoAndStop(1);
            }
            if(wqPanel["zhang"].currentFrame > 2)
            {
               wqPanel["zhang"].gotoAndStop(1);
            }
            if(wqPanel["quan"].currentFrame > 2)
            {
               wqPanel["quan"].gotoAndStop(1);
            }
            wqPanel["txt_2"].visible = true;
            NewMC.Open("文字提示",Main._stage,480,400,70,0,true,2,"请2P玩家选择左右手武器");
            temp = 0;
            wqPanel.removeEventListener(Event.ENTER_FRAME,ChoseP2);
         }
      }
      
      private static function reChose(param1:*) : void
      {
         temp = 0;
         wqPanel.removeEventListener(Event.ENTER_FRAME,ChoseP2);
         if(wqPanel["jian"].currentFrame > 2)
         {
            wqPanel["jian"].gotoAndPlay(79);
         }
         if(wqPanel["zhang"].currentFrame > 2)
         {
            wqPanel["zhang"].gotoAndPlay(78);
         }
         if(wqPanel["quan"].currentFrame > 2)
         {
            wqPanel["quan"].gotoAndPlay(78);
         }
         NewMC.Open("文字提示",Main._stage,480,400,70,0,true,2,"请1P玩家选择左右手武器");
         wqPanel["txt_2"].visible = false;
         wqPanel["txt_1"].text = "玩家1正在选择武器…";
         wqPanel["txt_2"].text = "玩家2正在选择武器…";
         p1_num = 0;
         p2_num = 0;
         p_now = 1;
      }
      
      private static function okChose(param1:*) : void
      {
         if(Main.P1P2)
         {
            if(p1_num >= 2 && p2_num >= 2)
            {
               close();
               Strat.startGame();
            }
            else
            {
               NewMC.Open("文字提示",Main._stage,480,400,70,0,true,2,"请继续选择武器");
            }
         }
         else if(p1_num >= 2)
         {
            close();
            Strat.startGame();
         }
         else
         {
            NewMC.Open("文字提示",Main._stage,480,400,70,0,true,2,"请继续选择武器");
         }
      }
   }
}

