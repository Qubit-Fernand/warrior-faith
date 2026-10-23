package com.hotpoint.braveManIII.views.taskPanel
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.utils.*;
   import src.*;
   
   public class AwardPanel extends MovieClip
   {
      
      private static var _instance:AwardPanel;
      
      private var timer:Timer;
      
      private var timerNum:Number;
      
      private var bo:Boolean;
      
      public function AwardPanel()
      {
         super();
      }
      
      public static function open(arr1:Array, arr2:Array, time:Number = 100) : void
      {
         if(AwardPanel._instance == null)
         {
            AwardPanel._instance = new AwardPanel();
         }
         Main._stage.addChild(AwardPanel._instance);
         AwardPanel._instance.visible = true;
         AwardPanel._instance.alpha = 0;
         AwardPanel._instance.init(arr1,arr2);
         AwardPanel._instance.addEvent(time);
      }
      
      private function addEvent(time:Number) : void
      {
         bo = false;
         timerNum = time;
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,onTimer);
         timer.start();
      }
      
      private function init(arr1:Array, arr2:Array) : void
      {
         trace(arr1,"arr1_______________________");
         for(var i:uint = 0; i < 5; i++)
         {
            this["jl_" + i].visible = false;
            this["d_" + i].visible = false;
         }
         for(i = 0; i < arr1.length; i++)
         {
            this["jl_" + i].visible = true;
            this["d_" + i].visible = true;
            this["jl_" + i].gotoAndStop(arr1[i].getFrame());
            this["jl_" + i].howNum.text = String(arr2[i].getValue());
         }
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         if(!bo)
         {
            if(this.alpha < 1)
            {
               this.alpha += 0.1;
            }
            else
            {
               bo = true;
            }
         }
         else if(timerNum > 0)
         {
            --timerNum;
         }
         else if(this.alpha > 0)
         {
            this.alpha -= 0.1;
         }
         else
         {
            bo = false;
            this.visible = false;
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER,onTimer);
         }
      }
   }
}

