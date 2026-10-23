package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossT2 extends EnemySkin
   {
      
      public function EnemyBossT2()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "死亡")
         {
            setTimeout(this.zhaohuan,2200);
         }
         if(str == "攻击2")
         {
            setTimeout(this.maotouying,100);
         }
      }
      
      public function maotouying() : *
      {
         if(this.parent)
         {
            this.addChild(new 猫头鹰());
         }
      }
      
      public function zhaohuan() : *
      {
         var e:Enemy = new Enemy(46);
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

