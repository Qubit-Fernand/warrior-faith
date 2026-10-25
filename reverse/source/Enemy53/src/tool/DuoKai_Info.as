package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   import src.*;
   
   public class DuoKai_Info extends MovieClip
   {
      
      private static var _this:DuoKai_Info;
      
      public static var _noSave:Boolean = false;
      
      public function DuoKai_Info()
      {
         super();
      }
      
      public static function Open(num:int = 1) : *
      {
         var _this:* = new DuoKai_Info();
         Main._stage.addChild(_this);
         _this.gotoAndStop(num);
         _noSave = true;
         var intervalId:uint = uint(setTimeout(TimeFun,1000));
      }
      
      public static function TimeFun() : void
      {
         Main._stage.frameRate = 0;
      }
   }
}

