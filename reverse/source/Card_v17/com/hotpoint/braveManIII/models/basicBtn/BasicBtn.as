package com.hotpoint.braveManIII.models.basicBtn
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   
   public class BasicBtn extends MovieClip
   {
      
      private var _id:Number;
      
      private var _set:Boolean;
      
      public function BasicBtn()
      {
         super();
         this.stop();
         this.focusRect = false;
         this.buttonMode = true;
         this.mouseChildren = false;
         this.addEventListener(Event.ADDED_TO_STAGE,init,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,destroy,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,rollOut);
         this.addEventListener(MouseEvent.ROLL_OVER,rollOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
         this.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
         this.addEventListener(MouseEvent.CLICK,clickFn);
      }
      
      public function get id() : Number
      {
         return _id;
      }
      
      public function set id(param1:Number) : void
      {
         if(_set)
         {
            return;
         }
         _id = param1;
         _set = true;
      }
      
      private function init(param1:Event) : void
      {
         var _loc2_:String = getQualifiedClassName(this);
         var _loc3_:Number = Number(parseInt(_loc2_.substring(_loc2_.lastIndexOf("_") + 1,_loc2_.length)));
         if(isNaN(_loc3_))
         {
            return;
         }
         this.id = _loc3_;
      }
      
      private function destroy(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,init,false);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,destroy,false);
         this.removeEventListener(MouseEvent.ROLL_OUT,rollOut);
         this.removeEventListener(MouseEvent.ROLL_OVER,rollOver);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
         this.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
         this.removeEventListener(MouseEvent.CLICK,clickFn);
      }
      
      protected function rollOut(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OUT)
         {
            this.gotoAndStop(1);
         }
      }
      
      protected function rollOver(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.gotoAndStop(2);
         }
      }
      
      protected function mouseDown(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            this.gotoAndStop(3);
         }
      }
      
      protected function mouseUp(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_UP)
         {
            this.gotoAndStop(2);
         }
      }
      
      protected function clickFn(param1:MouseEvent) : void
      {
      }
   }
}

