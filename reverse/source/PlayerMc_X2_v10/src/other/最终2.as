package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol75")]
   public class 最终2 extends MovieClip
   {
      
      private var time:int;
      
      public function 最终2()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function onENTER_FRAME(param1:*) : *
      {
         if(time > 0)
         {
            --time;
            if(time == 0)
            {
               Close();
            }
         }
         this.gotoAndStop((this.parent as MovieClip).currentFrame);
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         removeEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      public function Open() : *
      {
         time = 200;
         this.visible = true;
      }
      
      public function Close() : *
      {
         this.visible = false;
      }
   }
}

