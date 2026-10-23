package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss2 extends EnemySkin
   {
      
      public function EnemyBoss2()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         var e:Enemy = null;
         if(str == "攻击3")
         {
            e = new Enemy(100);
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
      
      public function DefenseUP() : *
      {
         var i:* = undefined;
         for(i = 0; i < Enemy.All.length; i++)
         {
            Enemy.All[i].防御力.setValue(Enemy.All[i].防御力.getValue() + 20);
         }
      }
   }
}

