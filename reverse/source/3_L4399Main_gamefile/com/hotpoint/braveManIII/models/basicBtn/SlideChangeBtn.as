package com.hotpoint.braveManIII.models.basicBtn
{
   import com.hotpoint.braveManIII.events.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.TextField;
   
   public class SlideChangeBtn extends BasicBtn
   {
      
      public var type:MovieClip;
      
      public var sbtn:MovieClip;
      
      public var ox:TextField;
      
      public var n_text:TextField;
      
      public var name_text:TextField;
      
      public var tx:TextField;
      
      public var num_text:TextField;
      
      private var _isClick:Boolean = false;
      
      public function SlideChangeBtn()
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
         this._isClick = true;
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

