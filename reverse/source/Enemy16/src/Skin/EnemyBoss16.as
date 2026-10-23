package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss16 extends EnemySkin
   {
      
      public function EnemyBoss16()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击5")
         {
            if(BuffEffect.AllBuffArr.length > 0)
            {
               lexAdd = 5;
            }
         }
         else
         {
            lexAdd = 1;
         }
      }
   }
}

