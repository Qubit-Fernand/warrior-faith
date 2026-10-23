package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss12 extends EnemySkin
   {
      
      private var tempX:Number = 0;
      
      private var tempY:Number = 0;
      
      private var timeOut2:uint;
      
      private var tempFlagX:Boolean = true;
      
      private var timeOut:uint;
      
      private var tempFlag:Boolean = true;
      
      private var ss:String;
      
      private var tempTimesX:int;
      
      private var tempTimes:int;
      
      public function EnemyBoss12()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         var i:int = 0;
         var e:Enemy = null;
         ss = str;
         if(tempTimes == 1)
         {
            tempY = Math.random() * 150 + 50;
            tempTimes = 0;
         }
         if(tempTimesX == 1)
         {
            tempX = Math.random() * 700;
            tempTimesX = 0;
         }
         if(str == "攻击1")
         {
            (this.parent as Enemy).life.setValue((this.parent as Enemy).life.getValue() + 10000);
         }
         if(str == "攻击2")
         {
            for(i = 0; i < 4; i++)
            {
               e = new Enemy(37);
               Main.world.moveChild_Enemy.addChild(e);
               e.x = this.parent.x + (Math.random() * 500 - 250);
               e.y = this.parent.y + (Math.random() * 500 - 250);
               if(e.x > 1600 || e.x < 0)
               {
                  e.x = 800;
               }
               if(e.y > 520 || e.y < 0)
               {
                  e.y = 250;
               }
            }
         }
         if(str == "移动")
         {
            if(this.parent.y < 0)
            {
               this.parent.y = 0;
            }
            if(this.parent.y > 520)
            {
               this.parent.y = 520;
            }
            if(this.parent.x < 0)
            {
               this.parent.x = 0;
            }
            if(this.parent.x > 1600)
            {
               this.parent.x = 1600;
            }
            if(this.parent.y < 300 + tempY && tempFlag == true)
            {
               this.parent.y += 5;
            }
            else if(tempFlag == true)
            {
               tempFlag = false;
               tempTimes = 1;
            }
            if(this.parent.y > 300 - tempY && tempFlag == false)
            {
               this.parent.y -= 5;
            }
            else if(tempFlag == false)
            {
               tempFlag = true;
               tempTimes = 1;
            }
            if(this.parent.x < 800 + tempX && tempFlagX == true)
            {
               this.parent.x += 6;
            }
            else if(tempFlagX == true)
            {
               this.parent.getRL(false);
               tempFlagX = false;
               tempTimesX = 1;
            }
            if(this.parent.x > 800 - tempX && tempFlagX == false)
            {
               this.parent.x -= 6;
            }
            else if(tempFlagX == false)
            {
               this.parent.getRL(true);
               tempFlagX = true;
               tempTimesX = 1;
            }
         }
      }
   }
}

