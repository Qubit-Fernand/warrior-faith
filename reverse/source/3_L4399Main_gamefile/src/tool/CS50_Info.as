package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1027")]
   public class CS50_Info extends MovieClip
   {
      
      public var sys_three:转成确定;
      
      public function CS50_Info()
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

