package src.Skin
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class Boss81zuo extends EnemySkin
   {
      
      public static var zuobian:Boolean = true;
      
      private var suolian:MovieClip = new 锁链();
      
      internal var temp:int = 0;
      
      internal var hitt:HitXX = null;
      
      public function Boss81zuo()
      {
         super();
      }
      
      internal function kunzhu(e:*) : *
      {
         ++temp;
         if(temp == 27)
         {
            Boss81.red = 0;
            this.parent.addChild(suolian);
            suolian.x = -350;
            this.GoTo("被打",405);
         }
         if(temp > 425)
         {
            this.parent.removeChild(suolian);
            temp = 0;
            removeEventListener(Event.ENTER_FRAME,kunzhu);
         }
      }
      
      override public function GoTo(str:String, timeX:int = 0) : *
      {
         if((str == "攻击1" || str == "攻击2") && (!Boss81.benti || !Boss81you.youbian || !Boss81zuo.zuobian))
         {
            return;
         }
         if(str == "攻击1" && Boss81.red >= 3)
         {
            addEventListener(Event.ENTER_FRAME,kunzhu);
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
      
      override public function onENTER_FRAME(e:*) : *
      {
         var i:int = 0;
         for(i in HitXX.AllHitXX)
         {
            if((this.parent as Enemy).hitXX == HitXX.AllHitXX[i] && hitt != (this.parent as Enemy).hitXX)
            {
               hitt = (this.parent as Enemy).hitXX;
               for(i = 0; i < Enemy.All.length; i++)
               {
                  if(Enemy.All[i].id == 5003)
                  {
                     (Enemy.All[i] as Enemy).HpXX((this.parent as Enemy).hitXX);
                     break;
                  }
               }
               break;
            }
         }
         if(this.currentFrame == this.totalFrames)
         {
            stop();
            (this.parent as Enemy).Dead();
            return;
         }
         if(runType == "攻击1" || runType == "攻击2")
         {
            zuobian = false;
         }
         else
         {
            zuobian = true;
         }
         if(continuousTime > 0)
         {
            --continuousTime;
         }
         else if(runType == "被打")
         {
            GoTo("站立");
         }
         GoToPlay();
      }
   }
}

