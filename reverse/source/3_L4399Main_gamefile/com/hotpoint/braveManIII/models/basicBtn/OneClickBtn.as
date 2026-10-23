package com.hotpoint.braveManIII.models.basicBtn
{
   import com.hotpoint.braveManIII.events.*;
   import flash.events.MouseEvent;
   
   public class OneClickBtn extends BasicBtn
   {
      
      public var _isClick:Boolean = false;
      
      public function OneClickBtn()
      {
         super();
      }
      
      override protected function clickFn(param1:MouseEvent) : void
      {
         _isClick = !_isClick;
         if(_isClick)
         {
            this.gotoAndStop(3);
         }
         else
         {
            this.gotoAndStop(1);
         }
         this.dispatchEvent(new BtnEvent(BtnEvent.DO_ONECLICK,this.id));
      }
      
      override protected function rollOut(param1:MouseEvent) : void
      {
         if(_isClick)
         {
            this.gotoAndStop(3);
         }
         else
         {
            this.gotoAndStop(1);
         }
      }
      
      override protected function rollOver(param1:MouseEvent) : void
      {
         if(_isClick)
         {
            this.gotoAndStop(3);
         }
         else
         {
            this.gotoAndStop(2);
         }
      }
   }
}

