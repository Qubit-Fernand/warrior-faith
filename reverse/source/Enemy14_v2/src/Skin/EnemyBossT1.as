package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossT1 extends EnemySkin
   {
      
      public function EnemyBossT1()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "死亡")
         {
            setTimeout(this.zhaohuan,2000);
         }
      }
      
      public function zhaohuan() : *
      {
         var e:Enemy = new Enemy(45);
         Main.world.moveChild_Enemy.addChild(e);
         Play_Interface.WhoIsBoss(e);
         if(this.parent.RL == true)
         {
            e.x = this.parent.x - 60;
            e.y = this.parent.y;
         }
         else
         {
            e.x = this.parent.x + 60;
            e.y = this.parent.y;
         }
      }
   }
}

