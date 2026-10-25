package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 装备商人界面 extends MovieClip
   {
      
      private static var only:装备商人界面;
      
      public function 装备商人界面()
      {
         super();
         buy_btn.addEventListener(MouseEvent.CLICK,BUY);
         close1.addEventListener(MouseEvent.CLICK,CloseXX);
         close2.addEventListener(MouseEvent.CLICK,CloseXX);
         Q_p1.addEventListener(MouseEvent.CLICK,P1QQ);
         if(!Main.P1P2)
         {
            Q_p2.visible = false;
         }
         else
         {
            Q_p2.addEventListener(MouseEvent.CLICK,P2QQ);
         }
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!only)
         {
            only = new 装备商人界面();
         }
         Main._stage.addChild(only);
         only.x = xx;
         only.y = yy;
         only.visible = true;
      }
      
      public static function Close() : *
      {
         if(!only)
         {
            only = new 装备商人界面();
         }
         only.x = 5000;
         only.y = 5000;
         only.visible = false;
      }
      
      private function CloseXX(e:*) : *
      {
         Close();
      }
      
      private function BUY(e:*) : *
      {
         EquipShopPanel.open();
         装备商人界面.Close();
      }
      
      private function P2QQ(e:*) : *
      {
         StrengthenPanel.open(2);
         装备商人界面.Close();
      }
      
      private function P1QQ(e:*) : *
      {
         StrengthenPanel.open(1);
         装备商人界面.Close();
      }
   }
}

