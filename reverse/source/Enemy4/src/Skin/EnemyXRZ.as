package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyXRZ extends EnemySkin
   {
      
      internal var timeOut:uint;
      
      public function EnemyXRZ()
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
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击2")
         {
            timeOut = setTimeout(zhaoHuan,1300);
         }
      }
      
      public function zhaoHuan() : *
      {
         var _loc1_:Enemy = null;
         _loc1_ = new Enemy(10);
         Main.world.moveChild_Enemy.addChild(_loc1_);
         if(this.parent.RL == true)
         {
            _loc1_.x = this.parent.x + 60;
            _loc1_.y = this.parent.y;
         }
         else
         {
            _loc1_.x = this.parent.x - 60;
            _loc1_.y = this.parent.y;
         }
      }
   }
}

