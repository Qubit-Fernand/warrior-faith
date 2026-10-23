package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.EnemySkin;
   
   public class EnemyDun2 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyDun2()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击2")
         {
            this.addEventListener(Event.ENTER_FRAME,move2);
         }
      }
      
      internal function move2(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 13 && rushNum < 52)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 16;
            }
            else
            {
               this.parent.x -= 16;
            }
         }
         if(rushNum >= 52)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move2);
         }
      }
   }
}

