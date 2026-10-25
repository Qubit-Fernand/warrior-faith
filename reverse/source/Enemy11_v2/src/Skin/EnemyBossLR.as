package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBossLR extends EnemySkin
   {
      
      internal var timeOut:uint;
      
      public function EnemyBossLR()
      {
         super();
      }
      
      public function clearTimeout() : void
      {
         if(timeOut > 0)
         {
            clearTimeout(timeOut);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            timeOut = setTimeout(zhaoHuan,1300);
         }
      }
      
      public function zhaoHuan() : *
      {
         var e:Enemy = null;
         if(!this.parent)
         {
            return;
         }
         e = new Enemy(36);
         Main.world.moveChild_Enemy.addChild(e);
         if(this.parent.RL == true)
         {
            e.x = this.parent.x + 200;
            e.y = this.parent.y;
         }
         else
         {
            e.x = this.parent.x - 200;
            e.y = this.parent.y;
         }
      }
   }
}

