package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyHuoNiao extends EnemySkin
   {
      
      private var tempY:Number;
      
      private var timeOut2:uint;
      
      private var timeOut:uint;
      
      private var tempFlag:Boolean = true;
      
      private var ss:String;
      
      private var tempTimes:int;
      
      public function EnemyHuoNiao()
      {
         super();
      }
      
      internal function siwang() : *
      {
         (this.parent as Enemy).life.setValue(0);
         this.parent.Dead();
      }
      
      public function clearTimeout() : void
      {
         if(timeOut > 0)
         {
            trace(111);
            clearTimeout(timeOut);
         }
         if(timeOut2 > 0)
         {
            clearTimeout(timeOut2);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         ss = str;
         if(tempTimes == 1)
         {
            tempY = Math.random() * 100 + 50;
            tempTimes = 0;
         }
         if(str == "移动")
         {
            if(this.parent.y < 200 + tempY && tempFlag == true)
            {
               this.parent.y += 5;
            }
            else if(tempFlag == true)
            {
               tempFlag = false;
               tempTimes = 1;
            }
            if(this.parent.y > 200 - tempY && tempFlag == false)
            {
               this.parent.y -= 5;
            }
            else if(tempFlag == false)
            {
               tempFlag = true;
               tempTimes = 1;
            }
         }
         if(str == "攻击1")
         {
            timeOut = setTimeout(xiaoShi,460);
            timeOut2 = setTimeout(siwang,1400);
         }
      }
      
      internal function xiaoShi() : *
      {
         if(ss == "被打")
         {
            this.parent.visible = true;
         }
         else
         {
            this.parent.visible = false;
         }
      }
   }
}

