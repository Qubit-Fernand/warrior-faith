package src.npc
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   import src.tool.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol165")]
   public class LuoPan extends MovieClip
   {
      
      public var mc2:MovieClip;
      
      public var MC:MovieClip;
      
      public var MC2:MovieClip;
      
      public function LuoPan()
      {
         super();
         MC = this["MC"] as MovieClip;
         MC2 = this["mc2"] as MovieClip;
         MC2.visible = false;
         addEventListener(MouseEvent.MOUSE_OUT,onMOUSE_OUT);
         addEventListener(MouseEvent.MOUSE_OVER,onMOUSE_OVER);
         addEventListener(MouseEvent.CLICK,GoGoGo);
         Show();
      }
      
      private function Show() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < Main.LuoPanArr.length)
         {
            if(Main.LuoPanArr[_loc2_] == 1)
            {
               MC["lp" + _loc2_].gotoAndPlay(15);
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ == 4)
         {
            MC2.visible = false;
            removeEventListener(MouseEvent.MOUSE_OUT,onMOUSE_OUT);
            removeEventListener(MouseEvent.MOUSE_OVER,onMOUSE_OVER);
         }
      }
      
      private function onMOUSE_OUT(param1:*) : *
      {
         MC2.visible = false;
      }
      
      private function onMOUSE_OVER(param1:*) : *
      {
         MC2.visible = true;
      }
      
      private function GoGoGo(param1:*) : *
      {
         var _loc2_:uint = 0;
         while(_loc2_ < Main.LuoPanArr.length)
         {
            SelLuoPan(_loc2_);
            _loc2_++;
         }
      }
      
      private function SelLuoPan(param1:uint) : *
      {
         var _loc2_:uint = 84117 + param1;
         if(Main.player1.getBag().isHavesQuest(_loc2_) > 0)
         {
            TiaoShi.txtShow("罗盘碎片" + _loc2_);
            Main.player1.getBag().clearQuest(_loc2_);
            if(Main.LuoPanArr[param1] != 1)
            {
               Main.LuoPanArr[param1] = 1;
               MC["lp" + param1].gotoAndPlay(2);
            }
         }
         if(Boolean(Main.P1P2) && Main.player2.getBag().isHavesQuest(_loc2_) > 0)
         {
            TiaoShi.txtShow("罗盘碎片" + _loc2_);
            Main.player2.getBag().clearQuest(_loc2_);
            if(Main.LuoPanArr[param1] != 1)
            {
               Main.LuoPanArr[param1] = 1;
               MC["lp" + param1].gotoAndPlay(2);
            }
         }
      }
   }
}

