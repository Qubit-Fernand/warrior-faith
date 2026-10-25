package com.hotpoint.braveManIII.views.strengthenPanel
{
   import com.hotpoint.braveManIII.events.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.text.*;
   
   public class DaoJu extends MovieClip
   {
      
      public var ob_mast:MovieClip;
      
      public var diKuang:MovieClip;
      
      public var howNum:TextField;
      
      public function DaoJu()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         this.mouseChildren = false;
         this.howNum.text = "";
         this.addEventListener(MouseEvent.MOUSE_OVER,overHandle);
         this.addEventListener(MouseEvent.MOUSE_OUT,outHandle);
         this.addEventListener(MouseEvent.MOUSE_DOWN,downHandle);
         this.addEventListener(MouseEvent.MOUSE_UP,upHandle);
         this.addEventListener(MouseEvent.CLICK,clickHandle);
      }
      
      private function overHandle(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DaoJuEvent(DaoJuEvent.DAOJU_OVER_MESSAGE,true));
      }
      
      private function outHandle(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DaoJuEvent(DaoJuEvent.DAOJU_OUT_MESSAGE,true));
      }
      
      private function downHandle(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DaoJuEvent(DaoJuEvent.DAOJU_DOWN_MESSAGE,true));
      }
      
      private function upHandle(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DaoJuEvent(DaoJuEvent.DAOJU_UP_MESSAGE,true));
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         this.dispatchEvent(new DaoJuEvent(DaoJuEvent.DAOJU_CLICK_MESSAGE,true));
      }
   }
}

