package src.Skin
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   import src.other.*;
   
   public class Boss81hexin extends EnemySkin
   {
      
      internal var hitt:HitXX = null;
      
      public function Boss81hexin()
      {
         super();
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
         if(Enemy.All.length <= 1)
         {
            (this.parent as Enemy).life.setValue(0);
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

