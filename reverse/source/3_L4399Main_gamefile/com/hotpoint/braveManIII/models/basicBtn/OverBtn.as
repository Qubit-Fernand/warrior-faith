package com.hotpoint.braveManIII.models.basicBtn
{
   import com.hotpoint.braveManIII.events.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.TextField;
   
   public class OverBtn extends BasicBtn
   {
      
      public var cion_mast:MovieClip;
      
      public var diKuang:MovieClip;
      
      public var howNum:TextField;
      
      public function OverBtn()
      {
         super();
         this.buttonMode = false;
      }
      
      override protected function rollOver(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.dispatchEvent(new BtnEvent(BtnEvent.DO_OVER,this.id));
         }
      }
      
      override protected function rollOut(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OUT)
         {
            this.dispatchEvent(new BtnEvent(BtnEvent.DO_OUT,this.id));
         }
      }
      
      override protected function mouseDown(param1:MouseEvent) : void
      {
      }
      
      override protected function mouseUp(param1:MouseEvent) : void
      {
      }
   }
}

