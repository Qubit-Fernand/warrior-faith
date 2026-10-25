package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss13 extends EnemySkin
   {
      
      internal var rushNum:int = 0;
      
      public function EnemyBoss13()
      {
         super();
      }
      
      override public function otherGoTo(param1:String) : *
      {
         var _loc2_:int = 0;
         if(param1 == "攻击5")
         {
            this.addChild(new 瞬移术());
            if(Player.All.length > 0)
            {
               _loc2_ = Math.random() * Player.All.length;
               if((Player.All[_loc2_] as Player).RL)
               {
                  this.parent.x = (Player.All[_loc2_] as Player).x - 100;
                  this.addChild(new 瞬移术());
               }
               else
               {
                  this.parent.x = (Player.All[_loc2_] as Player).x + 100;
                  this.addChild(new 瞬移术());
               }
            }
         }
         if(param1 == "攻击4")
         {
            this.addEventListener(Event.ENTER_FRAME,move);
         }
      }
      
      internal function move(param1:Event) : *
      {
         rushNum += 1;
         if(rushNum > 11 && rushNum < 21)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 18;
            }
            else
            {
               this.parent.x -= 18;
            }
         }
         if(rushNum > 22 && rushNum < 42)
         {
            if(this.parent.RL == true)
            {
               this.parent.x += 12;
            }
            else
            {
               this.parent.x -= 12;
            }
         }
         if(rushNum > 42)
         {
            rushNum = 0;
            this.removeEventListener(Event.ENTER_FRAME,move);
         }
      }
   }
}

