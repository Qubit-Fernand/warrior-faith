package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol330")]
   public class _黑洞 extends MovieClip
   {
      
      public function _黑洞()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onREMOVED_FROM_STAGE(param1:Event) : *
      {
         trace("onREMOVED_FROM_STAGE onREMOVED_FROM_STAGE $$$$$$$$$$$$$$$$");
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         _loc2_ = this.parent.localToGlobal(new Point(this.x,this.y));
         _loc3_ = 0;
         while(_loc3_ < Player.All.length)
         {
            _loc4_ = Player.All[_loc3_].parent.localToGlobal(new Point(Player.All[_loc3_].x,Player.All[_loc3_].y));
            if(_loc4_.x > _loc2_.x)
            {
               (Player.All[_loc3_] as Player).runPower(-8,0,1);
            }
            else
            {
               (Player.All[_loc3_] as Player).runPower(8,0,1);
            }
            _loc3_++;
         }
      }
   }
}

