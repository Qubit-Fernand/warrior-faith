package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss8 extends EnemySkin
   {
      
      internal var timeOut:uint;
      
      public function EnemyBoss8()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击3")
         {
            timeOut = setTimeout(zhaoHuan,1800);
         }
      }
      
      public function clearTimeout() : void
      {
         if(timeOut > 0)
         {
            clearTimeout(timeOut);
         }
      }
      
      public function zhaoHuan() : *
      {
         var _loc1_:Enemy = new Enemy(27);
         Main.world.moveChild_Enemy.addChild(_loc1_);
         if(this.parent.RL == true)
         {
            _loc1_.x = this.parent.x;
            _loc1_.y = this.parent.y;
         }
         else
         {
            _loc1_.x = this.parent.x;
            _loc1_.y = this.parent.y;
         }
         this.parent.x = 50000;
         this.parent.y = 50000;
      }
   }
}

