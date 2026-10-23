package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss1202 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyBoss1202()
      {
         super();
      }
      
      override public function GoTo(str:String, timeX:int = 0) : *
      {
         var e:Enemy = null;
         if(str == "攻击2")
         {
            for(i in Enemy.All)
            {
               if((Enemy.All[i] as Enemy).id == 2002)
               {
                  str = "攻击1";
               }
            }
            if(str == "攻击2")
            {
               e = new Enemy(2002);
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
            }
         }
         if(str == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,move);
         }
         if(str == "死亡" && runType != str)
         {
            runType = "死亡";
            gotoAndPlay(runType);
            return;
         }
         if(str == "被打")
         {
            runType = str;
            runOver = false;
            stopRun = false;
            gotoAndPlay(runType);
         }
         if((runOver || stopRun) && runType != str)
         {
            runType = str;
            runOver = false;
            gotoAndPlay(runType);
            frame = 0;
         }
         continuousTime = timeX;
      }
      
      internal function move(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 20 && rushNum < 67)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 15;
            }
            else
            {
               this.parent.x -= 15;
            }
         }
         if(rushNum > 67)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move);
         }
      }
   }
}

