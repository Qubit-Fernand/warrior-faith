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
      
      public function Show(num:int) : *
      {
         if(Main["player" + num].getTitleSlot().getTitleView())
         {
            this.gotoAndStop(Main["player" + num].getTitleSlot().getTitleView().getFrame());
         }
         else
         {
            gotoAndStop(1);
         }
      }
   }
}

