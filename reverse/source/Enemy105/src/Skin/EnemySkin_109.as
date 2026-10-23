package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemySkin_109 extends EnemySkin
   {
      
      private var z1:Boss108_ZhaDan;
      
      private var z2:Boss108_ZhaDan;
      
      private var time:uint = 0;
      
      public function EnemySkin_109()
      {
         super();
      }
      
      override public function otherggg() : *
      {
         if(Boolean(Main.player_1) && Main.player_1.hp.getValue() > 0)
         {
            z1 = new Boss108_ZhaDan();
            Main.player_1.addChild(z1);
         }
         if(Boolean(Main.P1P2) && Boolean(Main.player_2) && Main.player_2.hp.getValue() > 0)
         {
            z2 = new Boss108_ZhaDan();
            Main.player_2.addChild(z1);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "死亡")
         {
            if(z1)
            {
               z1.JieChu();
               z1 = null;
            }
            if(z2)
            {
               z2.JieChu();
               z2 = null;
            }
         }
      }
   }
}

