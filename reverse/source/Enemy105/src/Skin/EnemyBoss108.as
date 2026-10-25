package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss108 extends EnemySkin
   {
      
      public function EnemyBoss108()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,ACT4);
         }
         if(str == "攻击5")
         {
            this.addEventListener(Event.ENTER_FRAME,ACT5);
         }
         if(str == "死亡")
         {
            removeEventListener(Event.ENTER_FRAME,ACT4);
            removeEventListener(Event.ENTER_FRAME,ACT5);
         }
      }
      
      private function ACT4(e:*) : *
      {
         var enemy:Enemy = null;
         var xx:int = 0;
         if(this.currentFrame >= 180)
         {
            enemy = new Enemy(109);
            Main.world.moveChild_Enemy.addChild(enemy);
            xx = Math.random() * 1400 + 100;
            enemy.x = xx;
            enemy.y = 380;
            removeEventListener(Event.ENTER_FRAME,ACT4);
         }
      }
      
      private function ACT5(e:*) : *
      {
      }
   }
}

