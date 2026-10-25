package com
{
   import flash.events.*;
   import flash.utils.*;
   
   public class BasicKey
   {
      
      private static var _stage:*;
      
      private static var nowKey:uint;
      
      private static var timer:Timer;
      
      private static var ii:uint;
      
      private static var allKeyNum:uint = 300;
      
      private static var clickYsNum:uint = 20;
      
      private static var jgNum:uint = 70;
      
      private static var targetKeyYsNum:uint = 15;
      
      private static var sjYsNum:uint = 300;
      
      private static var keyTimer:uint = 0;
      
      private static var clickArr:Array = [];
      
      private static var clickTimerArr:Array = [];
      
      private static var clickBo:Array = [];
      
      private static var clickKgBo:Array = [];
      
      private static var downKgBo:Array = [];
      
      private static var downArr:Array = [];
      
      private static var towKeyArr:Array = [];
      
      private static var towKeyTimer:Array = [];
      
      private static var towClickArr:Array = [];
      
      private static var targetArr:Array = [];
      
      private static var targetKgBoArr:Array = [];
      
      private static var clickOkArr:Array = [];
      
      public function BasicKey()
      {
         super();
      }
      
      public static function Start(param1:*, param2:uint = 0, param3:uint = 100, param4:uint = 5, param5:uint = 200) : *
      {
         _stage = param1;
         clickYsNum = param2;
         jgNum = param3;
         targetKeyYsNum = param4;
         sjYsNum = param5;
         init();
      }
      
      public static function clearPressed() : void
      {
         for(var n:uint=0;n<allKeyNum;n++)
         {
            clickArr[n]=downArr[n]=clickBo[n]=clickKgBo[n]=downKgBo[n]=false;
            towClickArr[n]=targetArr[n]=targetKgBoArr[n]=clickOkArr[n]=false;
            clickTimerArr[n]=0;
         }
         towKeyArr=[];towKeyTimer=[];keyTimer=0;
      }

      private static function init() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < allKeyNum)
         {
            clickArr[_loc1_] = false;
            downArr[_loc1_] = false;
            clickTimerArr[_loc1_] = 0;
            clickBo[_loc1_] = false;
            clickKgBo[_loc1_] = false;
            downKgBo[_loc1_] = false;
            towClickArr[_loc1_] = false;
            targetArr[_loc1_] = false;
            targetKgBoArr[_loc1_] = false;
            clickOkArr[_loc1_] = false;
            _loc1_++;
         }
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,onTimer);
         timer.start();
         _stage.addEventListener(KeyboardEvent.KEY_DOWN,downHandle);
         _stage.addEventListener(KeyboardEvent.KEY_UP,upHandle);
      }
      
      private static function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < allKeyNum)
         {
            if(downKgBo[_loc2_])
            {
               downArr[_loc2_] = true;
            }
            else
            {
               downArr[_loc2_] = false;
            }
            if(!targetKgBoArr[_loc2_])
            {
               targetArr[_loc2_] = false;
            }
            if(clickTimerArr[_loc2_] != 0)
            {
               if(getTimer() - clickTimerArr[_loc2_] > jgNum)
               {
                  targetKgBoArr[_loc2_] = false;
                  targetArr[_loc2_] = false;
               }
               if(getTimer() - clickTimerArr[_loc2_] > clickYsNum && getTimer() - clickTimerArr[_loc2_] <= jgNum)
               {
                  if(!clickOkArr[_loc2_])
                  {
                     clickArr[_loc2_] = true;
                  }
               }
               if(getTimer() - clickTimerArr[_loc2_] > jgNum)
               {
                  clickArr[_loc2_] = false;
               }
            }
            _loc2_++;
         }
      }
      
      private static function downHandle(param1:KeyboardEvent) : void
      {
         nowKey = param1.keyCode;
         clickFunction();
         sjFunction();
         targetFunction();
      }
      
      private static function targetFunction() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < towKeyArr.length)
         {
            if(_loc1_ > 1)
            {
               if(towKeyArr[_loc1_] != towKeyArr[_loc1_ - 1])
               {
                  if(towKeyTimer[_loc1_] - towKeyTimer[_loc1_ - 1] < targetKeyYsNum)
                  {
                     if(targetKgBoArr[towKeyArr[_loc1_]])
                     {
                        clickOkArr[towKeyArr[_loc1_]] = true;
                        clickOkArr[towKeyArr[_loc1_ - 1]] = true;
                        targetArr[towKeyArr[_loc1_]] = true;
                        targetArr[towKeyArr[_loc1_ - 1]] = true;
                        keyTimer = 0;
                        towKeyTimer = [];
                     }
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private static function sjFunction() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < towKeyArr.length)
         {
            if(_loc1_ > 1)
            {
               if(towKeyArr[_loc1_] == towKeyArr[_loc1_ - 1])
               {
                  if(towKeyTimer[_loc1_] - towKeyTimer[_loc1_ - 1] < 300)
                  {
                     towClickArr[nowKey] = true;
                     keyTimer = 0;
                     towKeyArr = [];
                     towKeyTimer = [];
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private static function clickFunction() : void
      {
         if(!clickBo[nowKey])
         {
            clickBo[nowKey] = true;
            ++keyTimer;
            towKeyArr[keyTimer] = nowKey;
            towKeyTimer[keyTimer] = getTimer();
            clickTimerArr[nowKey] = getTimer();
            clickKgBo[nowKey] = true;
            downKgBo[nowKey] = true;
            targetKgBoArr[nowKey] = true;
         }
      }
      
      private static function upHandle(param1:KeyboardEvent) : void
      {
         var _loc2_:uint = param1.keyCode;
         clickBo[_loc2_] = false;
         downKgBo[_loc2_] = false;
         towClickArr[_loc2_] = false;
         clickOkArr[_loc2_] = false;
         targetKgBoArr[_loc2_] = false;
      }
      
      public static function getKeyState(param1:uint, param2:uint) : Boolean
      {
         switch(param2)
         {
            case 1:
               if(clickArr[param1])
               {
                  return true;
               }
               break;
            case 2:
               if(downArr[param1])
               {
                  return true;
               }
               break;
            case 3:
               if(towClickArr[param1])
               {
                  return true;
               }
         }
         return false;
      }
      
      public static function getTargetState(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(!targetArr[param1[_loc2_]])
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
   }
}

