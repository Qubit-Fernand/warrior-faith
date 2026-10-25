package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class InitData
   {
      
      public static var qinMiDu_Arr:Array;
      
      public static var qinMiDu_Max_Arr:Array;
      
      public static var qinMiDu_num:Array;
      
      public static var qinMiDu_Time:Array;
      
      public static var XX1:VT;
      
      public static var shengdanArr:Array = [];
      
      public static var cjPoint:VT = VT.createVT(1);
      
      public static var timeNum:VT = VT.createVT();
      
      private static var timeInterval:VT = VT.createVT(1000);
      
      public static var DOWNxN:VT = VT.createVT();
      
      public static var DOWNxTime:VT = VT.createVT();
      
      public static var EXPxN:VT = VT.createVT();
      
      public static var EXPxTime:VT = VT.createVT();
      
      public static var BuyNum_Money:VT = VT.createVT();
      
      public static var BuyS_Money:VT = VT.createVT();
      
      public static var XiLian_Money:VT = VT.createVT();
      
      public static var EXP_num:VT = VT.createVT();
      
      public static var EXP_big_num:VT = VT.createVT();
      
      public static var no_jiaoYan:VT = VT.createVT();
      
      public static var jiaoYan_num:VT = VT.createVT();
      
      public static var fuHua:VT = VT.createVT();
      
      public static var wuXingJiNeng:VT = VT.createVT();
      
      public static var chongzhirenwu:VT = VT.createVT();
      
      public static var tongyongjiesuo:VT = VT.createVT();
      
      public static var blue:VT = VT.createVT();
      
      public static var pink:VT = VT.createVT();
      
      public static var gold:VT = VT.createVT();
      
      public static var Money_init:VT = VT.createVT();
      
      public static var Money_max:VT = VT.createVT();
      
      public static var noTestVar:VT = VT.createVT();
      
      public static var pkHpMaxNum_Player:VT = VT.createVT();
      
      public static var pkHpMaxNum_Player2:VT = VT.createVT();
      
      public static var X002:VT = VT.createVT();
      
      public static var BuyNum_0:VT = VT.createVT();
      
      public static var BuyNum_1:VT = VT.createVT();
      
      public static var BuyNum_3:VT = VT.createVT();
      
      public static var BuyNum_50:VT = VT.createVT();
      
      public static var BuyNum_80:VT = VT.createVT();
      
      public static var BuyNum_300:VT = VT.createVT();
      
      public static var BuyNum_80000:VT = VT.createVT();
      
      public static var BuyNum_18000:VT = VT.createVT();
      
      public static var Temp0:VT = VT.createVT();
      
      public static var Temp01:VT = VT.createVT();
      
      public static var Temp7:VT = VT.createVT();
      
      public static var Temp8:VT = VT.createVT();
      
      public static var Temp100:VT = VT.createVT();
      
      public function InitData()
      {
         super();
      }
      
      public static function Init() : *
      {
         var i:int = 0;
         var intervalId:int = 0;
         var tempVt:VT = null;
         var tempVt2:VT = null;
         var tempVt3:VT = null;
         var tempVt4:VT = null;
         Temp0.setValue(0);
         Temp01.setValue(0.1);
         Temp7.setValue(7);
         Temp8.setValue(0.8);
         Temp100.setValue(100);
         X002.setValue(0.02);
         fuHua.setValue(15);
         no_jiaoYan.setValue(1000);
         jiaoYan_num.setValue(60);
         BuyNum_0.setValue(0);
         BuyNum_1.setValue(1);
         BuyNum_50.setValue(50);
         BuyNum_80.setValue(80);
         BuyNum_300.setValue(300);
         BuyNum_80000.setValue(80000);
         BuyNum_18000.setValue(18000);
         wuXingJiNeng.setValue(20);
         chongzhirenwu.setValue(25);
         tongyongjiesuo.setValue(120);
         blue.setValue(18);
         pink.setValue(36);
         gold.setValue(80);
         for(i = 0; i < 11; i++)
         {
            VT.TempVtArr[i] = VT.createVT(i);
         }
         XX1 = VT.createVT(1);
         DOWNxN = VT.createVT(2);
         DOWNxTime = VT.createVT(0);
         EXPxN = VT.createVT(1.5);
         EXPxTime = VT.createVT(0);
         intervalId = int(setInterval(TimeGo,timeInterval.getValue()));
         qinMiDu_Arr = new Array();
         qinMiDu_Max_Arr = new Array();
         qinMiDu_num = new Array();
         qinMiDu_Time = new Array();
         for(i = 0; i <= 5; i++)
         {
            tempVt = VT.createVT();
            qinMiDu_Arr[i] = tempVt;
            tempVt2 = VT.createVT(50);
            qinMiDu_Max_Arr[i] = tempVt2;
            tempVt3 = VT.createVT(1);
            qinMiDu_num[i] = tempVt3;
            tempVt4 = VT.createVT();
            qinMiDu_Time[i] = tempVt4;
         }
         BuyNum_Money.setValue(30);
         BuyS_Money.setValue(129);
         XiLian_Money.setValue(3);
         EXP_num.setValue(50000);
         EXP_big_num.setValue(500000);
         BuyNum_3.setValue(3);
         Money_init.setValue(4399);
         Money_max.setValue(500000000);
         noTestVar.setValue(1000);
         pkHpMaxNum_Player.setValue(20);
         pkHpMaxNum_Player2.setValue(20);
         shengdanArr = [[3,10],[6,11],[9,12],[13,13],[16,14],[19,15],[23,16],[28,17],[32,19],[35,20],[41,22],[46,23],[50,25]];
         Player.Init();
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
         timeNum.setValue(timeNum.getValue() + 1);
      }
      
      public static function DOWNxTimeUp(num:uint) : *
      {
         DOWNxTime.setValue(DOWNxTime.getValue() + num);
      }
      
      public static function EXPxTimeUp(num:uint) : *
      {
         EXPxTime.setValue(EXPxTime.getValue() + num);
      }
      
      public static function SaveInitData() : Array
      {
         return [DOWNxTime.getValue(),EXPxTime.getValue(),qinMiDu_Arr,qinMiDu_Max_Arr,qinMiDu_num,qinMiDu_Time];
      }
      
      public static function LoadInitData(arr:Array) : *
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
      
      public static function GetDOWNxN() : VT
      {
         if(DOWNxTime.getValue() > 0)
         {
            return DOWNxN;
         }
         return XX1;
      }
      
      public static function GetEXPxN() : VT
      {
         if(EXPxTime.getValue() > 0)
         {
            return EXPxN;
         }
         return XX1;
      }
   }
}

