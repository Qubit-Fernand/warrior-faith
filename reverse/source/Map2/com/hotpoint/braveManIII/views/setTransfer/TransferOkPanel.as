package com.hotpoint.braveManIII.views.setTransfer
{
   import com.hotpoint.braveManIII.events.*;
   import flash.display.MovieClip;
   import src.*;
   
   public class TransferOkPanel extends MovieClip
   {
      
      private static var _instance:TransferOkPanel;
      
      public function TransferOkPanel()
      {
         super();
      }
      
      public static function open() : void
      {
         if(TransferOkPanel._instance == null)
         {
            TransferOkPanel._instance = new TransferOkPanel();
         }
         Main._stage.addChild(TransferOkPanel._instance);
         TransferOkPanel._instance.addEvent();
         TransferOkPanel._instance.visible = true;
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

