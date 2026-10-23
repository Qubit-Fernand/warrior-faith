package com.hotpoint.braveManIII.models.basicBtn
{
   import com.hotpoint.braveManIII.events.*;
   import flash.events.MouseEvent;
   
   public class BasicClickBtn extends BasicBtn
   {
      
      public function BasicClickBtn()
      {
         super();
      }
      
      override protected function clickFn(param1:MouseEvent) : void
      {
         this.dispatchEvent(new BtnEvent(BtnEvent.DO_CLICK,this.id));
      }
   }
}

