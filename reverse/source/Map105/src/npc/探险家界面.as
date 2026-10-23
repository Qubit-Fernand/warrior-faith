package src.npc
{
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import src.*;
   
   public class 探险家界面 extends MovieClip
   {
      
      private static var only:探险家界面;
      
      public function 探险家界面()
      {
         super();
         close1.addEventListener(MouseEvent.CLICK,CloseXX);
         close2.addEventListener(MouseEvent.CLICK,CloseXX);
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!only)
         {
            only = new 探险家界面();
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
            only = new 探险家界面();
         }
         only.x = 5000;
         only.y = 5000;
         only.visible = false;
      }
      
      private function CloseXX(e:*) : *
      {
         Close();
      }
   }
}

