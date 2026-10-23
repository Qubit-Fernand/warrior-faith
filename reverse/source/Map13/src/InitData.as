package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class InitData
   {
      
      public static var qinMiDu_Arr:Array;
      
      public static var XX1:VT;
      
      public static var qinMiDu_Time:Array;
      
      public static var qinMiDu_Max_Arr:Array;
      
      public static var qinMiDu_num:Array;
      
      private static var timeInterval:VT = VT.createVT(1000);
      
      private static var timeNum:VT = VT.createVT();
      
      public static var DOWNxN:VT = VT.createVT();
      
      public static var DOWNxTime:VT = VT.createVT();
      
      public static var EXPxN:VT = VT.createVT();
      
      public static var EXPxTime:VT = VT.createVT();
      
      public static var BuyNum_300:VT = VT.createVT();
      
      public static var BuyNum_80000:VT = VT.createVT();
      
      public static var BuyNum_3:VT = VT.createVT();
      
      public static var BuyNum_0:VT = VT.createVT();
      
      public static var BuyNum_1:VT = VT.createVT();
      
      public static var BuyNum_Money:VT = VT.createVT();
      
      public static var BuyS_Money:VT = VT.createVT();
      
      public function InitData()
      {
         super();
      }
      
      public static function LoadInitData(arr:Array) : Array
      {
         DOWNxTime.setValue(arr[0]);
         EXPxTime.setValue(arr[1]);
         if(arr[2])
         {
            qinMiDu_Arr = arr[2];
            qinMiDu_num = arr[4];
            qinMiDu_Time = arr[5];
         }
      }
      
      public static function SaveInitData() : Array
      {
         var arr:Array = null;
         return [DOWNxTime.getValue(),EXPxTime.getValue(),qinMiDu_Arr,qinMiDu_Max_Arr,qinMiDu_num,qinMiDu_Time];
      }
      
      public static function GetEXPxN() : VT
      {
         if(EXPxTime.getValue() > 0)
         {
            return EXPxN;
         }
         return XX1;
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
      }
      
      public static function Init() : *
      {
         var i:int = 0;
         var tempVt:VT = null;
         var tempVt2:VT = null;
         var tempVt3:VT = null;
         var tempVt4:VT = null;
         BuyNum_0.setValue(0);
         BuyNum_1.setValue(1);
         BuyNum_300.setValue(300);
         BuyNum_80000.setValue(80000);
         for(i = 0; i < 11; i++)
         {
            VT.TempVtArr[i] = VT.createVT(i);
         }
         XX1 = VT.createVT(1);
         DOWNxN = VT.createVT(2);
         DOWNxTime = VT.createVT(0);
         EXPxN = VT.createVT(1.5);
         EXPxTime = VT.createVT(0);
         intervalId = setInterval(TimeGo,timeInterval.getValue());
         qinMiDu_Arr = new Array();
         qinMiDu_Max_Arr = new Array();
         qinMiDu_num = new Array();
         qinMiDu_Time = new Array();
         for(i = 0; i <= 5; i++)
         {
            tempVt = VT.createVT();
            qinMiDu_Arr[i] = tempVt;
            tempVt2 = VT.createVT(100);
            qinMiDu_Max_Arr[i] = tempVt2;
            tempVt3 = VT.createVT(1);
            qinMiDu_num[i] = tempVt3;
            tempVt4 = VT.createVT();
            qinMiDu_Time[i] = tempVt4;
         }
         BuyNum_Money.setValue(30);
         BuyS_Money.setValue(129);
         BuyNum_3.setValue(3);
         Player.Init();
      }
      
      public static function DOWNxTimeUp(num:uint) : *
      {
         DOWNxTime.setValue(DOWNxTime.getValue() + num);
      }
   }
}

