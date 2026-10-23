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
      
      public static function Open(param1:int = 1) : *
      {
         var _loc2_:* = new DuoKai_Info();
         Main._stage.addChild(_loc2_);
         _loc2_.gotoAndStop(param1);
         _noSave = true;
         var _loc3_:uint = uint(setTimeout(TimeFun,1000));
      }
      
      public static function TimeFun() : void
      {
         Main._stage.frameRate = 0;
      }
   }
}

