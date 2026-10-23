package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol6709")]
   public class XX_MC extends MovieClip
   {
      
      public var close_btn:SimpleButton;
      
      public function XX_MC()
      {
         super();
         close_btn.addEventListener(MouseEvent.CLICK,Close);
      }
      
      private function Close(param1:*) : *
      {
         this.parent.removeChild(this);
         close_btn.removeEventListener(MouseEvent.CLICK,Close);
         Main.Map0_YN = true;
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Main._this.GameStart();
         Main.Save();
      }
   }
}

