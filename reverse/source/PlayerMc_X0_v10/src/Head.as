package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol67")]
   public class Head extends MovieClip
   {
      
      public var frame:int = 1;
      
      public function Head()
      {
         super();
         addFrameScript(0,frame1);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         if(this.parent.parent is Player || this.parent.parent is Player2)
         {
            this.frame = this.parent.parent.headFrame;
            gotoAndStop(frame);
         }
         if(this.parent is Dead && this.parent.visible)
         {
            gotoAndStop(frame);
         }
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         if(this.parent.parent is Player || this.parent.parent is Player2)
         {
            if(this.parent.parent.noHead)
            {
               this.visible = false;
               stop();
            }
            else
            {
               this.visible = true;
               this.frame = this.parent.parent.headFrame;
               gotoAndStop(frame);
            }
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

