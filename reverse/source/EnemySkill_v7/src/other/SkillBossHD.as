package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class SkillBossHD extends FlyPerson
   {
      
      public function SkillBossHD()
      {
         super();
      }
      
      override public function setXY() : *
      {
         this.y += who.y;
         if(this.RL)
         {
            scaleX *= -1;
            this.x = who.x - this.x + 100;
         }
         else
         {
            scaleX *= 1;
            this.x = who.x + this.x - 100;
         }
      }
      
      override public function onENTER_FRAME(param1:*) : *
      {
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         if(over && this.currentLabel != "结束")
         {
            Dead();
            return;
         }
         if(!over && life == 0)
         {
            life = -1;
            gotoAndPlay("结束");
            continuous = false;
            over = true;
         }
         if(!over && time != -1)
         {
            --time;
            if(time == -1)
            {
               time = -1;
               gotoAndPlay("结束");
               continuous = false;
               over = true;
            }
         }
         if(continuous && this.currentLabel != "运行")
         {
            gotoAndPlay("运行");
         }
         else if(!continuous && this.currentLabel != "运行")
         {
            over = true;
         }
         if(!over)
         {
            _loc2_ = this.parent.localToGlobal(new Point(this.x,this.y));
            _loc3_ = 0;
            while(_loc3_ < Enemy.All.length)
            {
               _loc4_ = Enemy.All[_loc3_].parent.localToGlobal(new Point(Enemy.All[_loc3_].x,Enemy.All[_loc3_].y));
               if(_loc4_.x > _loc2_.x)
               {
                  (Enemy.All[_loc3_] as Enemy).runPower(18,0,1);
               }
               else
               {
                  (Enemy.All[_loc3_] as Enemy).runPower(-18,0,1);
               }
               if(_loc4_.y > _loc2_.y)
               {
                  (Enemy.All[_loc3_] as Enemy).runPower(0,10,1);
               }
               else
               {
                  (Enemy.All[_loc3_] as Enemy).runPower(0,-10,1);
               }
               _loc3_++;
            }
         }
      }
      
      override public function Dead() : *
      {
         EnergySlot.energyBool = true;
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         if(this.who is Player || this.who is Enemy)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

