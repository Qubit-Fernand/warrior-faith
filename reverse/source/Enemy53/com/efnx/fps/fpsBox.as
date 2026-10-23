package com.efnx.fps
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class fpsBox extends TextField
   {
      
      protected var frames:uint = 0;
      
      protected var format:TextFormat = new TextFormat();
      
      protected var averageArray:Array = new Array();
      
      protected var targetFPS:int = 0;
      
      public function fpsBox(... rest)
      {
         super();
         var timer:Timer = new Timer(1000);
         this.format.font = "Verdana";
         this.format.color = 16777215;
         this.format.size = 10;
         this.autoSize = TextFieldAutoSize.LEFT;
         this.defaultTextFormat = this.format;
         this.text = "-- FPS ---- AV";
         timer.addEventListener(TimerEvent.TIMER,this.tick);
         if(rest[0] is Stage)
         {
            rest[0].addEventListener(Event.ENTER_FRAME,this.everyFrame,false,0,true);
            this.targetFPS = rest[0].frameRate;
         }
         else
         {
            this.addEventListener(Event.ENTER_FRAME,this.everyFrame,false,0,true);
         }
         timer.start();
      }
      
      public function everyFrame(event:Event) : void
      {
         ++this.frames;
      }
      
      protected function tick(event:TimerEvent) : void
      {
         var i:int = 0;
         this.averageArray.push(this.frames);
         if(this.averageArray.length == 4)
         {
            for(i = 1; i < this.averageArray.length; i++)
            {
               this.averageArray[0] += this.averageArray[i];
            }
            this.averageArray.splice(1,this.averageArray.length - 1);
            this.averageArray[0] /= 4;
         }
         this.text = this.frames + " FPS " + Math.round(this.averageArray[0]) + " AV";
         if(this.targetFPS != 0)
         {
            this.appendText(" /" + this.targetFPS);
         }
         this.frames = 0;
      }
   }
}

