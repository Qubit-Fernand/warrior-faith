package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyBossEY extends EnemySkin
   {
      
      internal var timeOut:uint;
      
      internal var rushNum:int = 0;
      
      public function EnemyBossEY()
      {
         super();
      }
      
      internal function rush(e:Event) : *
      {
         if(rushNum < 180)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 20;
            }
            else
            {
               this.parent.x -= 20;
            }
            rushNum += 20;
         }
         else
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,rush);
         }
      }
      
      internal function move(e:Event) : *
      {
         if(rushNum < 200)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 4;
            }
            else
            {
               this.parent.x -= 4;
            }
            rushNum += 4;
         }
         else
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move);
         }
      }
      
      internal function yiDong() : *
      {
         this.addEventListener(Event.ENTER_FRAME,move);
      }
      
      public function clearTimeout() : void
      {
         if(timeOut > 0)
         {
            clearTimeout(timeOut);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击2")
         {
            this.addEventListener(Event.ENTER_FRAME,rush);
         }
         if(str == "攻击4")
         {
            timeOut = setTimeout(yiDong,500);
         }
      }
   }
}

