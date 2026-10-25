package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol608")]
   public class Boss108_ZhaDan extends MovieClip
   {
      
      public function Boss108_ZhaDan()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         if(Main.gameNum.getValue() == 0)
         {
            JieChu();
            return;
         }
         if(this.currentFrame > 418)
         {
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            if(Boolean(this.parent) && Boolean(this.parent is Player) && this.parent.hp.getValue() > 0)
            {
               this.parent.hp.setValue(0);
            }
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            JieChu();
         }
         else if(Boolean(this.parent) && this.parent is Player)
         {
            if(this.parent.hp.getValue() <= 0 || Main.world == null)
            {
               JieChu();
            }
         }
      }
      
      public function JieChu() : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

