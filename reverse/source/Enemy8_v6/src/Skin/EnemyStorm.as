package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyStorm extends EnemySkin
   {
      
      public function EnemyStorm()
      {
         super();
         this.hpX = 298;
         this.runX = 12;
         this.runY = 35;
         this.硬直 = 110;
      }
      
      override public function otherGoTo(param1:String) : *
      {
         var _loc2_:int = 0;
         if(param1 == "死亡")
         {
            _loc2_ = 0;
            while(_loc2_ < Enemy.All.length)
            {
               if((Enemy.All[_loc2_] as Enemy).className == "黑暗王小弟")
               {
                  (Enemy.All[_loc2_] as Enemy).x = this.parent.x;
                  (Enemy.All[_loc2_] as Enemy).y = this.parent.y;
               }
               _loc2_++;
            }
         }
      }
   }
}

