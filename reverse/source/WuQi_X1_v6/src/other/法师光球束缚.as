package src.other
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1050")]
   public class 法师光球束缚 extends MovieClip
   {
      
      public var hit:MovieClip;
      
      public var RL:Boolean;
      
      public var who:Object;
      
      public var time:int = 200;
      
      public function 法师光球束缚()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         var _loc2_:int = 0;
         if(this.who is Enemy)
         {
         }
         --time;
         if(time > 0)
         {
            if(this.who is Player)
            {
               _loc2_ = 0;
               while(_loc2_ < Enemy.All.length)
               {
                  if(Enemy.All[_loc2_].hit)
                  {
                     if(this.hit.hitTestObject(Enemy.All[_loc2_].hit))
                     {
                        Enemy.All[_loc2_].noMove = true;
                     }
                     else
                     {
                        Enemy.All[_loc2_].noMove = false;
                     }
                  }
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < Player2.All.length)
               {
                  if(Player2.All[_loc2_].hit)
                  {
                     if(this.hit.hitTestObject(Player2.All[_loc2_].hit))
                     {
                        Player2.All[_loc2_].noMove = true;
                     }
                     else
                     {
                        Player2.All[_loc2_].noMove = false;
                     }
                  }
                  _loc2_++;
               }
            }
            else if(this.who is Player2)
            {
               _loc2_ = 0;
               while(_loc2_ < Player.All.length)
               {
                  if(Player.All[_loc2_].hit)
                  {
                     if(this.hit.hitTestObject(Player.All[_loc2_].hit))
                     {
                        Player.All[_loc2_].noMove = true;
                     }
                     else
                     {
                        Player.All[_loc2_].noMove = false;
                     }
                  }
                  _loc2_++;
               }
            }
         }
         else
         {
            if(this.who is Player)
            {
               _loc2_ = 0;
               while(_loc2_ < Enemy.All.length)
               {
                  Enemy.All[_loc2_].noMove = false;
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < Player2.All.length)
               {
                  Player2.All[_loc2_].noMove = false;
                  _loc2_++;
               }
            }
            else if(this.who is Player2)
            {
               _loc2_ = 0;
               while(_loc2_ < Player.All.length)
               {
                  Player.All[_loc2_].noMove = false;
                  _loc2_++;
               }
            }
            this.parent.removeChild(this);
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         }
      }
      
      private function onREMOVED_FROM_STAGE(param1:Event) : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
   }
}

