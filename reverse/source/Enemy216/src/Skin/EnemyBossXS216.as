package src.Skin
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class EnemyBossXS216 extends EnemySkin
   {
      
      private var tempTimes:int;
      
      private var tempY:Number;
      
      private var tempFlag:Boolean = true;
      
      private var ss:String;
      
      public function EnemyBossXS216()
      {
         super();
      }
      
      public function zhaoHuan() : *
      {
         var _loc1_:Enemy = null;
         if(this.parent)
         {
            if(this.parent.关卡 == 216)
            {
               _loc1_ = new Enemy(219);
               Main.world.moveChild_Enemy.addChild(_loc1_);
               if(this.parent.RL == true)
               {
                  _loc1_.x = this.parent.x;
                  _loc1_.y = 520;
               }
               else
               {
                  _loc1_.x = this.parent.x;
                  _loc1_.y = 520;
               }
            }
            if(this.parent.关卡 == 217)
            {
               _loc1_ = new Enemy(220);
               Main.world.moveChild_Enemy.addChild(_loc1_);
               if(this.parent.RL == true)
               {
                  _loc1_.x = this.parent.x;
                  _loc1_.y = 520;
               }
               else
               {
                  _loc1_.x = this.parent.x;
                  _loc1_.y = 520;
               }
            }
            if(this.parent.关卡 == 218)
            {
               _loc1_ = new Enemy(221);
               Main.world.moveChild_Enemy.addChild(_loc1_);
               if(this.parent.RL == true)
               {
                  _loc1_.x = this.parent.x;
                  _loc1_.y = 520;
               }
               else
               {
                  _loc1_.x = this.parent.x;
                  _loc1_.y = 520;
               }
            }
         }
      }
      
      override public function otherGoTo(param1:String) : *
      {
         ss = param1;
         if(tempTimes == 1)
         {
            tempY = Math.random() * 100 + 50;
            tempTimes = 0;
         }
         if(param1 == "攻击4")
         {
            setTimeout(zhaoHuan,1900);
            setTimeout(zhaoHuan,2300);
            setTimeout(zhaoHuan,2700);
         }
         if(param1 == "移动")
         {
            if(this.parent.y < 300 + tempY && tempFlag == true)
            {
               this.parent.y += 5;
            }
            else
            {
               tempFlag = false;
               tempTimes = 1;
            }
            if(this.parent.y > 300 - tempY && tempFlag == false)
            {
               this.parent.y -= 5;
            }
            else
            {
               tempFlag = true;
               tempTimes = 1;
            }
         }
         if(param1 == "死亡")
         {
            Main.wts.wantedTaskComplete();
         }
      }
   }
}

