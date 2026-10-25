package com.hotpoint.braveManIII.models.basicBtn
{
   import com.hotpoint.braveManIII.events.*;
   import flash.events.*;
   
   public class SideChangeBtnOver extends BasicBtn
   {
      
      private var _isClick:Boolean = false;
      
      public function SideChangeBtnOver()
      {
         super();
      }
      
      override protected function mouseUp(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_UP)
         {
            this.gotoAndStop(3);
         }
      }
      
      override protected function mouseDown(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            this.gotoAndStop(3);
            this._isClick = true;
         }
      }
      
      override protected function rollOut(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OUT && this._isClick == false)
         {
            this.gotoAndStop(1);
         }
         else
         {
            this.gotoAndStop(3);
         }
         this.dispatchEvent(new BtnEvent(BtnEvent.DO_OUT,this.id));
      }
      
      override protected function clickFn(param1:MouseEvent) : void
      {
         this.dispatchEvent(new BtnEvent(BtnEvent.DO_CHANGE,this.id));
      }
      
      override protected function rollOver(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.gotoAndStop(2);
         }
         this.dispatchEvent(new BtnEvent(BtnEvent.DO_OVER,this.id));
      }
      
      public function set isClick(param1:Boolean) : void
      {
         _isClick = param1;
         if(!_isClick)
         {
            if(this.currentFrame != 4)
            {
               return this.gotoAndStop(1);
            }
            return this.gotoAndStop(4);
         }
         if(_isClick)
         {
            return this.gotoAndStop(3);
         }
      }
   }
}

