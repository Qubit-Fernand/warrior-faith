package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class Enemy216 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function Enemy216()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击1")
         {
            this.addEventListener(Event.ENTER_FRAME,boom);
         }
      }
      
      internal function boom(param1:Event) : *
      {
         rushNum += 1;
         if(rushNum > 0 && rushNum < 36)
         {
            if(this.parent.x - Main.player_1.x < 0)
            {
               this.scaleX = -1;
               this.parent.x += 12;
            }
            else
            {
               this.scaleX = 1;
               this.parent.x -= 12;
            }
         }
         if(rushNum > 50 && runType == "攻击1")
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,boom);
            (this.parent as Enemy).Dead();
         }
      }
   }
}

