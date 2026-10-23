package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyFB101 extends EnemySkin
   {
      
      public function EnemyFB101()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         var e:Enemy = null;
         if(str == "攻击1")
         {
            if(this.parent.x > 50 && this.parent.x < 1550)
            {
               e = new Enemy(103);
               Main.world.moveChild_Enemy.addChild(e);
               if(this.parent.RL == true)
               {
                  e.x = this.parent.x + 60;
                  e.y = this.parent.y;
               }
               else
               {
                  e.x = this.parent.x - 60;
                  e.y = this.parent.y;
               }
               DefenseUP();
            }
         }
      }
      
      public function DefenseUP() : *
      {
         for(var i:* = 0; i < Enemy.All.length; i++)
         {
            Enemy.All[i].防御力.setValue(Enemy.All[i].防御力.getValue() + 20);
         }
      }
   }
}

