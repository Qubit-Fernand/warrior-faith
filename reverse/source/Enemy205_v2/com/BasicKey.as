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
      
      public static function Start(_stageX:*, _clickYsNum:uint = 0, _jgNum:uint = 100, _targetKeyYsNum:uint = 5, _sjYsNum:uint = 200) : *
      {
         _stage = _stageX;
         clickYsNum = _clickYsNum;
         jgNum = _jgNum;
         targetKeyYsNum = _targetKeyYsNum;
         sjYsNum = _sjYsNum;
         init();
      }
      
      private static function init() : void
      {
         for(var i:uint = 0; i < allKeyNum; i++)
         {
            clickArr[i] = false;
            downArr[i] = false;
            clickTimerArr[i] = 0;
            clickBo[i] = false;
            clickKgBo[i] = false;
            downKgBo[i] = false;
            towClickArr[i] = false;
            targetArr[i] = false;
            targetKgBoArr[i] = false;
            clickOkArr[i] = false;
         }
         timer = new Timer(0);
         timer.addEventListener(TimerEvent.TIMER,onTimer);
         timer.start();
         _stage.addEventListener(KeyboardEvent.KEY_DOWN,downHandle);
         _stage.addEventListener(KeyboardEvent.KEY_UP,upHandle);
      }
      
      private static function onTimer(e:TimerEvent) : void
      {
         for(var i:uint = 0; i < allKeyNum; i++)
         {
            if(downKgBo[i])
            {
               downArr[i] = true;
            }
            else
            {
               downArr[i] = false;
            }
            if(!targetKgBoArr[i])
            {
               targetArr[i] = false;
            }
            if(clickTimerArr[i] != 0)
            {
               if(getTimer() - clickTimerArr[i] > jgNum)
               {
                  targetKgBoArr[i] = false;
                  targetArr[i] = false;
               }
               if(getTimer() - clickTimerArr[i] > clickYsNum && getTimer() - clickTimerArr[i] <= jgNum)
               {
                  if(!clickOkArr[i])
                  {
                     clickArr[i] = true;
                  }
               }
               if(getTimer() - clickTimerArr[i] > jgNum)
               {
                  clickArr[i] = false;
               }
            }
         }
      }
      
      private static function downHandle(e:KeyboardEvent) : void
      {
         nowKey = e.keyCode;
         clickFunction();
         sjFunction();
         targetFunction();
      }
      
      private static function targetFunction() : void
      {
         for(var i:uint = 0; i < towKeyArr.length; i++)
         {
            if(i > 1)
            {
               if(towKeyArr[i] != towKeyArr[i - 1])
               {
                  if(towKeyTimer[i] - towKeyTimer[i - 1] < targetKeyYsNum)
                  {
                     if(targetKgBoArr[towKeyArr[i]])
                     {
                        clickOkArr[towKeyArr[i]] = true;
                        clickOkArr[towKeyArr[i - 1]] = true;
                        targetArr[towKeyArr[i]] = true;
                        targetArr[towKeyArr[i - 1]] = true;
                        keyTimer = 0;
                        towKeyTimer = [];
                     }
                  }
               }
            }
         }
      }
      
      private static function sjFunction() : void
      {
         for(var i:uint = 0; i < towKeyArr.length; i++)
         {
            if(i > 1)
            {
               if(towKeyArr[i] == towKeyArr[i - 1])
               {
                  if(towKeyTimer[i] - towKeyTimer[i - 1] < 300)
                  {
                     towClickArr[nowKey] = true;
                     keyTimer = 0;
                     towKeyArr = [];
                     towKeyTimer = [];
                  }
               }
            }
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
      
      private static function upHandle(e:KeyboardEvent) : void
      {
         var upKey:uint = e.keyCode;
         clickBo[upKey] = false;
         downKgBo[upKey] = false;
         towClickArr[upKey] = false;
         clickOkArr[upKey] = false;
         targetKgBoArr[upKey] = false;
      }
      
      public static function getKeyState(keyNum:uint, ctype:uint) : Boolean
      {
         switch(ctype)
         {
            case 1:
               if(clickArr[keyNum])
               {
                  return true;
               }
               break;
            case 2:
               if(downArr[keyNum])
               {
                  return true;
               }
               break;
            case 3:
               if(towClickArr[keyNum])
               {
                  return true;
               }
         }
         return false;
      }
      
      public static function getTargetState(keyNum:Array) : Boolean
      {
         for(var i:int = 0; i < keyNum.length; i++)
         {
            if(!targetArr[keyNum[i]])
            {
               return false;
            }
         }
         return true;
      }
   }
}

