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
      
      public static function open(param1:Array, param2:Array, param3:Number = 100) : void
      {
         if(AwardPanel._instance == null)
         {
            AwardPanel._instance = new AwardPanel();
         }
         Main._stage.addChild(AwardPanel._instance);
         AwardPanel._instance.visible = true;
         AwardPanel._instance.alpha = 0;
         AwardPanel._instance.init(param1,param2);
         AwardPanel._instance.addEvent(param3);
      }
      
      private function addEvent(param1:Number) : void
      {
         bo = false;
         timerNum = param1;
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,onTimer);
         timer.start();
      }
      
      private function init(param1:Array, param2:Array) : void
      {
         trace(param1,"arr1_______________________");
         var _loc3_:uint = 0;
         while(_loc3_ < 5)
         {
            this["jl_" + _loc3_].visible = false;
            this["d_" + _loc3_].visible = false;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            this["jl_" + _loc3_].visible = true;
            this["d_" + _loc3_].visible = true;
            this["jl_" + _loc3_].gotoAndStop(param1[_loc3_].getFrame());
            this["jl_" + _loc3_].howNum.text = String(param2[_loc3_].getValue());
            _loc3_++;
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
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

