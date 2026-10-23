package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyBoss1202SY extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyBoss1202SY()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,move);
         }
      }
      
      internal function move(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 10 && rushNum < 53)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 10;
            }
            else
            {
               this.parent.x -= 10;
            }
         }
         if(rushNum > 53)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move);
         }
      }
   }
}

