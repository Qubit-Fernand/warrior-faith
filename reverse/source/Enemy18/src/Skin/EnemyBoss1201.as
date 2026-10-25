package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss1201 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      internal var tempNum:int = 0;
      
      public function EnemyBoss1201()
      {
         super();
      }
      
      override public function otherGoTo(str:String) : *
      {
         if(str == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,changeX);
         }
         if(str == "攻击6")
         {
            this.addEventListener(Event.ENTER_FRAME,move);
         }
      }
      
      internal function changeX(e:Event) : *
      {
         var xx:int = 0;
         ++tempNum;
         if(tempNum > 25)
         {
            if(Player.All.length > 0)
            {
               xx = Math.random() * Player.All.length;
               this.parent.x = (Player.All[xx] as Player).x;
            }
            tempNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,changeX);
         }
      }
      
      internal function move(e:Event) : *
      {
         rushNum += 1;
         if(rushNum > 16 && rushNum < 110)
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
         if(rushNum > 110)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move);
         }
      }
   }
}

