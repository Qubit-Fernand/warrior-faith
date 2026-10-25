package com.efnx.fps
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class fpsBox extends TextField
   {
      
      protected var format:TextFormat = new TextFormat();
      
      protected var averageArray:Array = new Array();
      
      protected var targetFPS:int = 0;
      
      protected var frames:uint = 0;
      
      public function fpsBox(... rest)
      {
         var _loc2_:Timer = null;
         super();
         _loc2_ = new Timer(1000);
         format.font = "Verdana";
         format.color = 16777215;
         format.size = 10;
         this.autoSize = TextFieldAutoSize.LEFT;
         this.defaultTextFormat = format;
         this.text = "-- FPS ---- AV";
         _loc2_.addEventListener(TimerEvent.TIMER,tick);
         if(rest[0] is Stage)
         {
            rest[0].addEventListener(Event.ENTER_FRAME,everyFrame,false,0,true);
            targetFPS = rest[0].frameRate;
         }
         else
         {
            this.addEventListener(Event.ENTER_FRAME,everyFrame,false,0,true);
         }
         _loc2_.start();
      }
      
      public function everyFrame(param1:Event) : void
      {
         ++frames;
      }
      
      protected function tick(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         averageArray.push(frames);
         if(averageArray.length == 4)
         {
            _loc2_ = 1;
            while(_loc2_ < averageArray.length)
            {
               averageArray[0] += averageArray[_loc2_];
               _loc2_++;
            }
            averageArray.splice(1,averageArray.length - 1);
            averageArray[0] /= 4;
         }
         this.text = frames + " FPS " + Math.round(averageArray[0]) + " AV";
         if(targetFPS != 0)
         {
            this.appendText(" /" + targetFPS);
         }
         frames = 0;
      }
   }
}

