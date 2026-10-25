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
      
      public static var cwJiNeng:VT = VT.createVT();
      
      public static var cwWuXing:VT = VT.createVT();
      
      public static var cwShengJi:VT = VT.createVT();
      
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
      
      public static var BuyNum_20:VT = VT.createVT();
      
      public static var BuyNum_50:VT = VT.createVT();
      
      public static var BuyNum_80:VT = VT.createVT();
      
      public static var BuyNum_300:VT = VT.createVT();
      
      public static var BuyNum_2000:VT = VT.createVT();
      
      public static var BuyNum_80000:VT = VT.createVT();
      
      public static var BuyNum_18000:VT = VT.createVT();
      
      public static var Temp0:VT = VT.createVT();
      
      public static var Temp01:VT = VT.createVT();
      
      public static var Temp5:VT = VT.createVT();
      
      public static var Temp7:VT = VT.createVT();
      
      public static var Temp8:VT = VT.createVT();
      
      public static var Temp50:VT = VT.createVT();
      
      public static var Temp100:VT = VT.createVT();
      
      public static var Temp500:VT = VT.createVT();
      
      public static var Temp1000:VT = VT.createVT();
      
      public static var Temp3000:VT = VT.createVT();
      
      public static var Temp8000:VT = VT.createVT();
      
      public static var xingLing:VT = VT.createVT();
      
      public static var xingLing_num9:VT = VT.createVT();
      
      public static var xingLing_ID55:VT = VT.createVT();
      
      public static var vip2990:VT = VT.createVT();
      
      public static var vipID:VT = VT.createVT();
      
      public static var vip10:VT = VT.createVT();
      
      public static var PaiNumMax:VT = VT.createVT();
      
      public static var xingLingXiShu_Arr:Array = new Array();
      
      public static var xL_Arr:Array = new Array();
      
      public static var ShopId_Arr:Array = new Array();
      
      public function InitData()
      {
         super();
      }
      
      public static function Init() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:VT = null;
         var _loc4_:VT = null;
         var _loc5_:VT = null;
         var _loc6_:VT = null;
         PaiNumMax.setValue(3999999);
         vip10.setValue(56);
         vip2990.setValue(2990);
         vipID.setValue(104);
         xingLingXiShu_Arr = [VT.createVT(0),VT.createVT(0),VT.createVT(0.25),VT.createVT(0.5),VT.createVT(0.75),VT.createVT(1),VT.createVT(2)];
         xL_Arr = [VT.createVT(5),VT.createVT(10),VT.createVT(15),VT.createVT(20),VT.createVT(25),VT.createVT(30),VT.createVT(40),VT.createVT(50)];
         xingLing.setValue(62);
         xingLing_num9.setValue(9);
         xingLing_ID55.setValue(55);
         Temp0.setValue(0);
         Temp01.setValue(0.1);
         Temp5.setValue(5);
         Temp7.setValue(7);
         Temp8.setValue(0.8);
         Temp50.setValue(50);
         Temp100.setValue(100);
         Temp500.setValue(500);
         Temp1000.setValue(1000);
         Temp3000.setValue(3000);
         Temp8000.setValue(8000);
         X002.setValue(0.02);
         fuHua.setValue(60);
         no_jiaoYan.setValue(1000);
         jiaoYan_num.setValue(60);
         BuyNum_0.setValue(0);
         BuyNum_1.setValue(1);
         BuyNum_20.setValue(20);
         BuyNum_50.setValue(66);
         BuyNum_80.setValue(80);
         BuyNum_300.setValue(300);
         BuyNum_2000.setValue(2000);
         BuyNum_80000.setValue(80000);
         BuyNum_18000.setValue(18000);
         cwJiNeng.setValue(57);
         cwShengJi.setValue(59);
         cwWuXing.setValue(58);
         chongzhirenwu.setValue(44);
         tongyongjiesuo.setValue(67);
         blue.setValue(63);
         pink.setValue(64);
         gold.setValue(65);
         _loc1_ = 0;
         while(_loc1_ < 11)
         {
            VT.TempVtArr[_loc1_] = VT.createVT(_loc1_);
            _loc1_++;
         }
         XX1 = VT.createVT(1);
         DOWNxN = VT.createVT(2);
         DOWNxTime = VT.createVT(0);
         EXPxN = VT.createVT(1.5);
         EXPxTime = VT.createVT(0);
         _loc2_ = int(setInterval(TimeGo,timeInterval.getValue()));
         qinMiDu_Arr = new Array();
         qinMiDu_Max_Arr = new Array();
         qinMiDu_num = new Array();
         qinMiDu_Time = new Array();
         _loc1_ = 0;
         while(_loc1_ <= 5)
         {
            _loc3_ = VT.createVT();
            qinMiDu_Arr[_loc1_] = _loc3_;
            _loc4_ = VT.createVT(50);
            qinMiDu_Max_Arr[_loc1_] = _loc4_;
            _loc5_ = VT.createVT(1);
            qinMiDu_num[_loc1_] = _loc5_;
            _loc6_ = VT.createVT();
            qinMiDu_Time[_loc1_] = _loc6_;
            _loc1_++;
         }
         BuyNum_Money.setValue(61);
         BuyS_Money.setValue(103);
         XiLian_Money.setValue(43);
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
      
      public static function DOWNxTimeUp(param1:uint) : *
      {
         DOWNxTime.setValue(DOWNxTime.getValue() + param1);
      }
      
      public static function EXPxTimeUp(param1:uint) : *
      {
         EXPxTime.setValue(EXPxTime.getValue() + param1);
      }
      
      public static function SaveInitData() : Array
      {
         return [DOWNxTime.getValue(),EXPxTime.getValue(),qinMiDu_Arr,qinMiDu_Max_Arr,qinMiDu_num,qinMiDu_Time];
      }
      
      public static function LoadInitData(param1:Array) : *
      {
         DOWNxTime.setValue(param1[0]);
         EXPxTime.setValue(param1[1]);
         if(param1[2])
         {
            qinMiDu_Arr = param1[2];
            qinMiDu_num = param1[4];
            qinMiDu_Time = param1[5];
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

