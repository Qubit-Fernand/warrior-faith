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
      
      public function CengHao()
      {
         super();
         gotoAndStop(1);
      }
      
      public function Show(param1:int) : *
      {
         if(Main["player" + param1].getTitleSlot().getTitleView())
         {
            this.gotoAndStop(Main["player" + param1].getTitleSlot().getTitleView().getFrame());
         }
         else
         {
            gotoAndStop(1);
         }
      }
   }
}

