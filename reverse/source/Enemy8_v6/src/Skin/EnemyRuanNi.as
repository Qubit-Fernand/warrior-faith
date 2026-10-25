package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyRuanNi extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyRuanNi()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         if(param1 == "攻击1")
         {
            this.addEventListener(Event.ENTER_FRAME,move);
         }
      }
      
      internal function move(param1:Event) : *
      {
         if(rushNum < 200 && (this.parent as Enemy).skin.runType != "被打")
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 8;
            }
            else
            {
               this.parent.x -= 8;
            }
            rushNum += 8;
         }
         else
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move);
         }
      }
   }
}

