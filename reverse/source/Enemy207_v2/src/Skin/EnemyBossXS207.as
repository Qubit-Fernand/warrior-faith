package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossXS207 extends EnemySkin
   {
      
      public function EnemyBossXS207()
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

