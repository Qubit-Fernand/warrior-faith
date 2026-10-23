package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyGhost extends EnemySkin
   {
      
      private var tempY:Number;
      
      private var timeOut2:uint;
      
      private var timeOut:uint;
      
      private var tempFlag:Boolean = true;
      
      private var ss:String;
      
      private var tempTimes:int;
      
      public function EnemyGhost()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         ss = str;
         if(tempTimes == 1)
         {
            tempY = Math.random() * 100 + 20;
            tempTimes = 0;
         }
         if(str == "站立")
         {
            if(this.parent)
            {
               if(this.parent.y < 300 + tempY && tempFlag == true)
               {
                  this.parent.y += 3;
               }
               else
               {
                  tempFlag = false;
                  tempTimes = 1;
               }
               if(this.parent.y > 300 - tempY && tempFlag == false)
               {
                  this.parent.y -= 3;
               }
               else
               {
                  tempFlag = true;
                  tempTimes = 1;
               }
            }
         }
         if(str == "移动")
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
      }
   }
}

