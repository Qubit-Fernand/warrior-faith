package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1747")]
   public class GameStop extends MovieClip
   {
      
      public function GameStop()
      {
         super();
         Main._stage.addChild(this);
         Main._stage.frameRate = 0;
         addEventListener(MouseEvent.CLICK,Close);
      }
      
      private function Close(param1:*) : *
      {
         removeEventListener(MouseEvent.CLICK,Close);
         Main._stage.frameRate = 27;
         this.parent.removeChild(this);
      }
   }
}

