package com.hotpoint.braveManIII.views.setTransfer
{
   import com.hotpoint.braveManIII.events.*;
   import flash.display.MovieClip;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1017")]
   public class TransferOkPanel extends MovieClip
   {
      
      private static var _instance:TransferOkPanel;
      
      public var zorc:MovieClip;
      
      public var sys_three:转成确定;
      
      public function TransferOkPanel()
      {
         super();
      }
      
      public static function open(param1:Number = 1) : void
      {
         if(TransferOkPanel._instance == null)
         {
            TransferOkPanel._instance = new TransferOkPanel();
         }
         Main._stage.addChild(TransferOkPanel._instance);
         TransferOkPanel._instance.addEvent();
         TransferOkPanel._instance.visible = true;
         TransferOkPanel._instance.init(param1);
      }
      
      private function init(param1:Number = 1) : void
      {
         this.zorc.gotoAndStop(param1);
      }
      
      private function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
      }
      
      private function clickHandle(param1:BtnEvent) : void
      {
         this.visible = false;
      }
   }
}

