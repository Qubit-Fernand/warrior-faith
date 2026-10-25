package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class InitData
   {
      
      public static var DOWNxTime:VT;
      
      public static var EXPxTime:VT;
      
      public static var EXPxN:VT;
      
      public static var DOWNxN:VT;
      
      private static var timeInterval:VT = VT.createVT(1000);
      
      private static var timeNum:VT = VT.createVT();
      
      public static var XX1:VT = VT.createVT(1);
      
      public function InitData()
      {
         super();
      }
      
      public static function LoadInitData(arr:Array) : Array
      {
         DOWNxTime.setValue(arr[0]);
         EXPxTime.setValue(arr[1]);
      }
      
      public static function EXPxTimeUp(num:uint) : *
      {
         EXPxTime.setValue(EXPxTime.getValue() + num);
      }
      
      public static function GetDOWNxN() : VT
      {
         if(DOWNxTime.getValue() > 0)
         {
            return DOWNxN;
         }
         return XX1;
      }
      
      public static function SaveInitData() : Array
      {
         var arr:Array = null;
         return [DOWNxTime.getValue(),EXPxTime.getValue()];
      }
      
      private static function TimeGo() : *
      {
         if(DOWNxTime.getValue() > 0)
         {
            DOWNxTime.setValue(DOWNxTime.getValue() - 1);
         }
         if(EXPxTime.getValue() > 0)
         {
            EXPxTime.setValue(EXPxTime.getValue() - 1);
         }
         trace("\n---> DOWNxTime = " + DOWNxTime.getValue() + ", EXPxTime = " + EXPxTime.getValue());
      }
      
      public static function GetEXPxN() : VT
      {
         if(EXPxTime.getValue() > 0)
         {
            return EXPxN;
         }
         return XX1;
      }
      
      public static function DOWNxTimeUp(num:uint) : *
      {
         DOWNxTime.setValue(DOWNxTime.getValue() + num);
      }
      
      public static function Init() : *
      {
         DOWNxN = VT.createVT(50);
         DOWNxTime = VT.createVT(6666660);
         EXPxN = VT.createVT(15);
         EXPxTime = VT.createVT(5555550);
         intervalId = setInterval(TimeGo,timeInterval.getValue());
      }
   }
}

