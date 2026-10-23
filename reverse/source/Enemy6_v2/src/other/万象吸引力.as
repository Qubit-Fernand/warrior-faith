package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class 万象吸引力 extends MovieClip
   {
      
      public function 万象吸引力()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onREMOVED_FROM_STAGE(e:Event) : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         var xPoint:Point = null;
         var i:int = 0;
         var pPoint:Point = null;
         xPoint = this.parent.localToGlobal(new Point(this.x,this.y));
         for(i = 0; i < Player.All.length; i++)
         {
            pPoint = Player.All[i].parent.localToGlobal(new Point(Player.All[i].x,Player.All[i].y));
            if(pPoint.x - xPoint.x < 300 && pPoint.x - xPoint.x > 0)
            {
               (Player.All[i] as Player).runPower(-18,0,1);
            }
            else if(pPoint.x - xPoint.x > -300 && pPoint.x - xPoint.x < 0)
            {
               (Player.All[i] as Player).runPower(18,0,1);
            }
         }
      }
   }
}

