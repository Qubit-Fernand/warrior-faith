package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyPig extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyPig()
      {
         super();
      }
      
      internal function backMove(e:Event) : *
      {
         if(rushNum < 100 && (this.parent as Enemy).skin.runType != "被打")
         {
            if(this.parent.RL == true)
            {
               this.parent.x -= 4;
            }
            else
            {
               this.parent.x += 4;
            }
            rushNum += 4;
         }
         else
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,backMove);
            this.addEventListener(Event.ENTER_FRAME,move);
         }
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击1")
         {
            this.addEventListener(Event.ENTER_FRAME,backMove);
         }
      }
      
      internal function move(e:Event) : *
      {
         if(rushNum < 240 && (this.parent as Enemy).skin.runType != "被打")
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 16;
            }
            else
            {
               this.parent.x -= 16;
            }
            rushNum += 16;
         }
         else
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move);
         }
      }
   }
}

