package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol59")]
   public class Boss108_BaoZha extends MovieClip
   {
      
      public var hitXX:MovieClip;
      
      public function Boss108_BaoZha()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         var this_x:uint = 0;
         if(Main.gameNum.getValue() == 0)
         {
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            return;
         }
         if(this.currentFrame > 39)
         {
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else if(this.currentFrame > 28)
         {
            if(Boolean(Main.player_1 && Main.player_1.hp.getValue() > 0 && !Main.player_1.noHit) && Boolean(Main.player_1.hit) && this.hitXX.hitTestObject(Main.player_1.hit))
            {
               Main.player_1.hp.setValue(0);
            }
            if(Boolean(Main.P1P2 && Main.player_2 && Main.player_2.hp.getValue() > 0 && !Main.player_2.noHit) && Boolean(Main.player_2.hit) && this.hitXX.hitTestObject(Main.player_2.hit))
            {
               Main.player_2.hp.setValue(0);
            }
         }
         else
         {
            this_x = this.x + this.parent.parent.parent.x;
            if(Boolean(Main.player_1) && Main.player_1.hp.getValue() > 0)
            {
               if(Main.player_1.x > this_x + 50)
               {
                  Main.player_1.x -= 50;
               }
               else if(Main.player_1.x < this_x - 50)
               {
                  Main.player_1.x += 50;
               }
            }
            if(Boolean(Main.P1P2) && Boolean(Main.player_2) && Main.player_2.hp.getValue() > 0)
            {
               if(Main.player_2.x > this_x + 50)
               {
                  Main.player_2.x -= 50;
               }
               else if(Main.player_2.x < this_x - 50)
               {
                  Main.player_2.x += 50;
               }
            }
         }
      }
   }
}

