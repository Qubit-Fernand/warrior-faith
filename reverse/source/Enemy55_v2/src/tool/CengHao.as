package src.tool
{
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class CengHao extends MovieClip
   {
      
      public var who:Player;
      
      public var frame:uint = 1;
      
      public function CengHao()
      {
         super();
         gotoAndStop(1);
         frame = 1;
      }
      
      public function Show(param1:int) : *
      {
         if(Main["player" + param1].getTitleSlot().getTitleView())
         {
            frame = Main["player" + param1].getTitleSlot().getTitleView().getFrame();
            this.gotoAndStop(frame);
         }
         else
         {
            frame = 1;
            gotoAndStop(1);
         }
      }
   }
}

