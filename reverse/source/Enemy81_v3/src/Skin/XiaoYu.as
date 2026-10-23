package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.tool.*;
   
   public class XiaoYu extends EnemySkin
   {
      
      private var tempbool:int = 0;
      
      private var tempTimes:int;
      
      private var tempTimesX:int;
      
      private var tempXX:Number = 0;
      
      private var tempX:Number = 0;
      
      private var temp:int = 0;
      
      private var tempFlagX:Boolean = true;
      
      public function XiaoYu()
      {
         super();
      }
      
      internal function dodead(e:*) : *
      {
         var i:int = 0;
         ++temp;
         if(temp >= 37)
         {
            for(i = 0; i < Enemy.All.length; i++)
            {
               if(Enemy.All[i].id == 5003)
               {
                  (Enemy.All[i] as Enemy).life.setValue((Enemy.All[i] as Enemy).life.getValue() + 100000);
               }
            }
            (this.parent as Enemy).life.setValue(0);
            if(this.parent.id = 5005)
            {
               --Boss81.red;
            }
            if(this.parent.id = 5006)
            {
               --Boss81.blue;
            }
            temp = 0;
            removeEventListener(Event.ENTER_FRAME,dodead);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(Boolean(tempbool == 0) && Boolean(this.parent) && this.parent.x < 550)
         {
            tempbool = 1;
            tempFlagX = false;
         }
         else if(Boolean(tempbool == 0) && Boolean(this.parent) && this.parent.x >= 550)
         {
            tempbool = 1;
            tempFlagX = true;
         }
         if(tempTimesX == 1)
         {
            tempX = Math.random() * 550;
            tempXX = Math.random() * 20 + 5;
            tempTimesX = 0;
         }
         if(str == "死亡")
         {
            if(this.parent)
            {
               if(this.parent.id = 5005)
               {
                  ++Boss81.red;
               }
               if(this.parent.id = 5006)
               {
                  ++Boss81.blue;
               }
            }
         }
         if(str == "攻击1")
         {
            addEventListener(Event.ENTER_FRAME,dodead);
         }
         if(str == "移动")
         {
            if(this.parent)
            {
               this.parent.y = 525;
               if(this.parent.x < 550 + tempX && tempFlagX == true)
               {
                  this.parent.x += tempXX;
               }
               else if(tempFlagX == true)
               {
                  this.parent.getRL(false);
                  tempFlagX = false;
                  tempTimesX = 1;
               }
               if(this.parent.x > 550 - tempX && tempFlagX == false)
               {
                  this.parent.x -= tempXX;
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
}

