package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyBossXS210 extends EnemySkin
   {
      
      public function EnemyBossXS210()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "死亡")
         {
            Main.wts.wantedTaskComplete();
         }
      }
   }
}

