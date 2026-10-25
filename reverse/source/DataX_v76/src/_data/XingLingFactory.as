package src._data
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.common.*;
   import src.*;
   import src.tool.*;
   
   public class XingLingFactory
   {
      
      public static var xingLingData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public static var AllData:Array = new Array();
      
      private static var selNumMax:uint = 6;
      
      private static var sel_LV_NumMax:uint = 5;
      
      private static var getTolal_Data_Arr:Array = new Array();
      
      private static var getTolal_Data_Arr2:Array = new Array();
      
      public static var dianLiangNum:uint = 0;
      
      public static var dianLiangNumX:Number = 0;
      
      public static var qiangHuaArr:Array = [90100,90080,90050,90030,90012,90010];
      
      public function XingLingFactory()
      {
         super();
      }
      
      public static function creatFactory() : *
      {
         myXml = XMLAsset.createXML(Data2.xingLing);
         InitDataX();
         Init_xingLingData();
      }
      
      public static function Init_xingLingData() : *
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(xingLingData.length < 1)
         {
            _loc1_ = 0;
            while(_loc1_ <= selNumMax)
            {
               xingLingData[_loc1_] = [VT.createVT()];
               _loc2_ = 1;
               while(_loc2_ <= sel_LV_NumMax)
               {
                  if(_loc2_ == 1)
                  {
                     (xingLingData[_loc1_] as Array).push(VT.createVT(1));
                  }
                  else
                  {
                     (xingLingData[_loc1_] as Array).push(VT.createVT());
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
         }
      }
      
      public static function Trace() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc1_:uint = 0;
         while(_loc1_ <= selNumMax)
         {
            _loc2_ = (xingLingData[_loc1_][0] as VT).getValue();
            _loc3_ = (xingLingData[_loc1_][1] as VT).getValue();
            _loc4_ = (xingLingData[_loc1_][2] as VT).getValue();
            _loc5_ = (xingLingData[_loc1_][3] as VT).getValue();
            _loc6_ = (xingLingData[_loc1_][4] as VT).getValue();
            _loc1_++;
         }
      }
      
      private static function InitDataX() : *
      {
         var _loc1_:XML = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         for each(_loc1_ in myXml.星灵数据)
         {
            _loc2_ = Number(_loc1_.星座ID);
            if(AllData[_loc2_] == null)
            {
               AllData[_loc2_] = new Array();
            }
            _loc3_ = Number(_loc1_.等级);
            _loc4_ = new Object();
            _loc4_.xh1_1 = VT.createVT(Number(_loc1_.消耗能源));
            _loc4_.xh1_2 = VT.createVT(Number(_loc1_.消耗击杀点));
            _loc4_.xh1_3 = VT.createVT(Number(_loc1_.消耗点券));
            _loc4_.xh1_4 = VT.createVT(Number(_loc1_.商城ID));
            _loc4_.xh2_1 = VT.createVT(Number(_loc1_.进阶能源));
            _loc4_.xh2_2 = VT.createVT(Number(_loc1_.进阶水晶));
            _loc4_.sx1 = VT.createVT(Number(_loc1_.生命));
            _loc4_.sx2 = VT.createVT(Number(_loc1_.魔法));
            _loc4_.sx3 = VT.createVT(Number(_loc1_.攻击));
            _loc4_.sx4 = VT.createVT(Number(_loc1_.防御));
            _loc4_.sx5 = VT.createVT(Number(_loc1_.暴击));
            _loc4_.sx6 = VT.createVT(Number(_loc1_.闪避));
            _loc4_.sx7 = VT.createVT(Number(_loc1_.破魔));
            _loc4_.sx8 = VT.createVT(Number(_loc1_.魔抗));
            _loc4_.sxA1 = VT.createVT(Number(_loc1_.sum生命));
            _loc4_.sxA2 = VT.createVT(Number(_loc1_.sum魔法));
            _loc4_.sxA3 = VT.createVT(Number(_loc1_.sum攻击));
            _loc4_.sxA4 = VT.createVT(Number(_loc1_.sum防御));
            _loc4_.sxA5 = VT.createVT(Number(_loc1_.sum暴击));
            _loc4_.sxA6 = VT.createVT(Number(_loc1_.sum闪避));
            _loc4_.sxA7 = VT.createVT(Number(_loc1_.sum破魔));
            _loc4_.sxA8 = VT.createVT(Number(_loc1_.sum魔抗));
            AllData[_loc2_][_loc3_] = _loc4_;
         }
      }
      
      public static function Get_LV_Data_Str(param1:uint = 1, param2:uint = 1) : Array
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:Array = null;
         var _loc3_:Array = new Array();
         var _loc4_:uint = 1;
         while(_loc4_ <= 10)
         {
            _loc5_ = 1;
            while(_loc5_ <= 8)
            {
               _loc6_ = param2 * 10 + _loc4_ - 10;
               if((AllData[param1][_loc6_]["sx" + _loc5_] as VT).getValue() != 0)
               {
                  _loc7_ = "";
                  if(_loc5_ == 1)
                  {
                     _loc7_ = "生命+";
                  }
                  else if(_loc5_ == 2)
                  {
                     _loc7_ = "魔法+";
                  }
                  else if(_loc5_ == 3)
                  {
                     _loc7_ = "攻击+";
                  }
                  else if(_loc5_ == 4)
                  {
                     _loc7_ = "防御+";
                  }
                  else if(_loc5_ == 5)
                  {
                     _loc7_ = "暴击+";
                  }
                  else if(_loc5_ == 6)
                  {
                     _loc7_ = "闪避+";
                  }
                  else if(_loc5_ == 7)
                  {
                     _loc7_ = "破魔+";
                  }
                  else if(_loc5_ == 8)
                  {
                     _loc7_ = "魔抗+";
                  }
                  _loc8_ = uint(xingLingData[param1][param2].getValue());
                  _loc9_ = [1,1,1.25,1.5,1.75,2,3];
                  _loc7_ += uint((AllData[param1][_loc6_]["sx" + _loc5_] as VT).getValue() * _loc9_[_loc8_]);
                  _loc3_[_loc4_] = _loc7_;
                  break;
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function Get_LV(param1:uint, param2:uint) : Array
      {
         var _loc3_:uint = uint((xingLingData[param1][param2] as VT).getValue());
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         if((xingLingData[param1][0] as VT).getValue() > param2 * 10)
         {
            _loc4_ = 10;
         }
         else
         {
            _loc4_ = (xingLingData[param1][0] as VT).getValue() - param2 * 10 + 10;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
         }
         return [_loc3_,_loc4_];
      }
      
      public static function Get_LV2(param1:uint) : uint
      {
         var _loc4_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 1;
         while(_loc3_ < xingLingData[param1].length)
         {
            _loc4_ = uint(xingLingData[param1][_loc3_].getValue());
            if(_loc4_ > 0)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function Get_LV_color(param1:uint) : Array
      {
         var _loc4_:uint = 0;
         var _loc2_:Array = new Array();
         var _loc3_:int = 1;
         while(_loc3_ < xingLingData[param1].length)
         {
            _loc4_ = uint(xingLingData[param1][_loc3_].getValue());
            _loc2_[_loc3_] = _loc4_ + 1;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function Get_one_color(param1:uint, param2:uint) : uint
      {
         return uint(xingLingData[param1][param2].getValue());
      }
      
      public static function GetLvNum(param1:uint) : uint
      {
         return (xingLingData[param1][0] as VT).getValue();
      }
      
      public static function Sel_XuQiu_up1(param1:uint) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:uint = GetLvNum(param1) + 1;
         _loc2_[0] = (AllData[param1][_loc3_].xh1_1 as VT).getValue();
         _loc2_[1] = (AllData[param1][_loc3_].xh1_2 as VT).getValue();
         _loc2_[2] = (AllData[param1][_loc3_].xh1_3 as VT).getValue();
         _loc2_[3] = (AllData[param1][_loc3_].xh1_4 as VT).getValue();
         return _loc2_;
      }
      
      public static function Sel_XuQiu_up2(param1:uint) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:uint = GetLvNum(param1);
         _loc2_[0] = (AllData[param1][_loc3_].xh2_1 as VT).getValue();
         _loc2_[1] = (AllData[param1][_loc3_].xh2_2 as VT).getValue();
         return _loc2_;
      }
      
      public static function GetTolal_Data() : *
      {
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc1_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc2_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc3_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc4_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc5_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc6_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc7_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc8_:uint = uint(InitData.BuyNum_0.getValue());
         var _loc9_:int = 1;
         while(_loc9_ < xingLingData.length)
         {
            _loc18_ = uint(xingLingData[_loc9_][0].getValue());
            if(_loc18_ > 0)
            {
               _loc1_ += (AllData[_loc9_][_loc18_].sxA1 as VT).getValue();
               _loc2_ += (AllData[_loc9_][_loc18_].sxA2 as VT).getValue();
               _loc3_ += (AllData[_loc9_][_loc18_].sxA3 as VT).getValue();
               _loc4_ += (AllData[_loc9_][_loc18_].sxA4 as VT).getValue();
               _loc5_ += (AllData[_loc9_][_loc18_].sxA5 as VT).getValue();
               _loc6_ += (AllData[_loc9_][_loc18_].sxA6 as VT).getValue();
               _loc7_ += (AllData[_loc9_][_loc18_].sxA7 as VT).getValue();
               _loc8_ += (AllData[_loc9_][_loc18_].sxA8 as VT).getValue();
               if(_loc18_ >= 10)
               {
                  _loc19_ = _loc18_ / 10;
                  _loc20_ = 1;
                  while(_loc20_ <= _loc19_)
                  {
                     _loc21_ = uint(xingLingData[_loc9_][_loc20_].getValue());
                     if(_loc20_ == 1)
                     {
                        _loc1_ += (AllData[_loc9_][10].sxA1 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc2_ += (AllData[_loc9_][10].sxA2 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc3_ += (AllData[_loc9_][10].sxA3 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc4_ += (AllData[_loc9_][10].sxA4 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc5_ += (AllData[_loc9_][10].sxA5 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc6_ += (AllData[_loc9_][10].sxA6 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc7_ += (AllData[_loc9_][10].sxA7 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc8_ += (AllData[_loc9_][10].sxA8 as VT).getValue() * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                     }
                     else
                     {
                        _loc1_ += ((AllData[_loc9_][_loc20_ * 10].sxA1 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA1 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc2_ += ((AllData[_loc9_][_loc20_ * 10].sxA2 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA2 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc3_ += ((AllData[_loc9_][_loc20_ * 10].sxA3 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA3 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc4_ += ((AllData[_loc9_][_loc20_ * 10].sxA4 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA4 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc5_ += ((AllData[_loc9_][_loc20_ * 10].sxA5 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA5 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc6_ += ((AllData[_loc9_][_loc20_ * 10].sxA6 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA6 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc7_ += ((AllData[_loc9_][_loc20_ * 10].sxA7 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA7 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                        _loc8_ += ((AllData[_loc9_][_loc20_ * 10].sxA8 as VT).getValue() - (AllData[_loc9_][_loc20_ * 10 - 10].sxA8 as VT).getValue()) * InitData.xingLingXiShu_Arr[_loc21_].getValue();
                     }
                     _loc20_++;
                  }
               }
            }
            _loc9_++;
         }
         var _loc10_:VT = VT.createVT(_loc1_);
         var _loc11_:VT = VT.createVT(_loc2_);
         var _loc12_:VT = VT.createVT(_loc3_);
         var _loc13_:VT = VT.createVT(_loc4_);
         var _loc14_:VT = VT.createVT(_loc5_);
         var _loc15_:VT = VT.createVT(_loc6_);
         var _loc16_:VT = VT.createVT(_loc7_);
         var _loc17_:VT = VT.createVT(_loc8_);
         getTolal_Data_Arr = [0,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_];
         GetTolal_NUM_UP();
      }
      
      public static function GetTolal_NUM_UP() : *
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc1_:uint = uint(InitData.Temp0.getValue());
         var _loc2_:int = 1;
         while(_loc2_ < xingLingData.length)
         {
            _loc5_ = 1;
            while(_loc5_ <= sel_LV_NumMax)
            {
               if(!xingLingData[_loc2_][_loc5_])
               {
                  xingLingData[_loc2_][_loc5_] = VT.createVT();
               }
               _loc6_ = uint(xingLingData[_loc2_][_loc5_].getValue());
               if(_loc6_ >= InitData.Temp5.getValue())
               {
                  _loc1_++;
               }
               _loc5_++;
            }
            _loc2_++;
         }
         dianLiangNum = _loc1_;
         var _loc3_:uint = 0;
         var _loc4_:uint = 1;
         while(_loc4_ <= 8)
         {
            getTolal_Data_Arr2[_loc4_] = VT.createVT();
            _loc4_++;
         }
         if(_loc1_ >= InitData.xL_Arr[0].getValue())
         {
            getTolal_Data_Arr2[2] = InitData.Temp3000;
         }
         if(_loc1_ >= InitData.xL_Arr[1].getValue())
         {
            getTolal_Data_Arr2[5] = InitData.Temp1000;
         }
         if(_loc1_ >= InitData.xL_Arr[2].getValue())
         {
            getTolal_Data_Arr2[1] = InitData.Temp8000;
         }
         if(_loc1_ >= InitData.xL_Arr[3].getValue())
         {
            getTolal_Data_Arr2[3] = InitData.Temp500;
         }
         if(_loc1_ >= InitData.xL_Arr[4].getValue())
         {
            getTolal_Data_Arr2[8] = InitData.Temp50;
         }
         if(_loc1_ >= InitData.xL_Arr[5].getValue())
         {
            getTolal_Data_Arr2[7] = InitData.Temp50;
         }
         if(_loc1_ >= InitData.xL_Arr[6].getValue())
         {
            getTolal_Data_Arr2[4] = InitData.Temp500;
         }
         if(_loc1_ >= InitData.xL_Arr[7].getValue())
         {
            getTolal_Data_Arr2[6] = InitData.Temp1000;
         }
         if(_loc1_ < InitData.xL_Arr[0].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[0].getValue();
         }
         else if(_loc1_ < InitData.xL_Arr[1].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[1].getValue();
         }
         else if(_loc1_ < InitData.xL_Arr[2].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[2].getValue();
         }
         else if(_loc1_ < InitData.xL_Arr[3].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[3].getValue();
         }
         else if(_loc1_ < InitData.xL_Arr[4].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[4].getValue();
         }
         else if(_loc1_ < InitData.xL_Arr[5].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[5].getValue();
         }
         else if(_loc1_ < InitData.xL_Arr[6].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[6].getValue();
         }
         else if(_loc1_ < InitData.xL_Arr[7].getValue())
         {
            dianLiangNumX = _loc1_ / InitData.xL_Arr[7].getValue();
         }
      }
      
      public static function GetTolal_DataStr() : Array
      {
         if(getTolal_Data_Arr.length <= 0)
         {
            GetTolal_Data();
         }
         var _loc1_:Array = [0,"生命+","魔法+","攻击+","防御+","暴击+","闪避+","破魔+","魔抗+"];
         var _loc2_:Array = new Array();
         var _loc3_:uint = 1;
         while(_loc3_ <= 8)
         {
            _loc2_[_loc3_] = _loc1_[_loc3_] + getTolal_Data_Arr[_loc3_].getValue();
            _loc2_[_loc3_ + 8] = "(+" + getTolal_Data_Arr2[_loc3_].getValue() + ")";
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function GetTolal_Data_VT() : Array
      {
         var _loc1_:Array = new Array();
         if(getTolal_Data_Arr.length <= 0)
         {
            GetTolal_Data();
         }
         var _loc2_:uint = 1;
         while(_loc2_ <= 8)
         {
            _loc1_[_loc2_] = VT.createVT(getTolal_Data_Arr[_loc2_].getValue() + getTolal_Data_Arr2[_loc2_].getValue());
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function UP(param1:uint, param2:uint) : uint
      {
         var _loc3_:Number = (xingLingData[param1][0] as VT).getValue() + 1;
         if(_loc3_ <= sel_LV_NumMax * 10)
         {
            (xingLingData[param1][0] as VT).setValue(_loc3_);
            GetTolal_Data();
            if(_loc3_ % 10 == 0)
            {
               return 10;
            }
            return _loc3_ % 10;
         }
         return 10;
      }
      
      public static function UP2(param1:uint, param2:uint) : *
      {
         if(param2 <= sel_LV_NumMax && (xingLingData[param1][param2 + 1] as VT).getValue() == 0)
         {
            (xingLingData[param1][param2 + 1] as VT).setValue(1);
            GetTolal_Data();
         }
      }
      
      public static function QiangHua(param1:uint, param2:uint) : Boolean
      {
         TiaoShi.txtShow("QiangHua() num = " + param1 + ", num2 = " + param2);
         var _loc3_:uint = Math.random() * 100 + 90000;
         if(xingLingData[param1][param2].getValue() == 1 && _loc3_ < qiangHuaArr[1])
         {
            xingLingData[param1][param2].setValue(2);
            GetTolal_Data();
            return true;
         }
         if(xingLingData[param1][param2].getValue() == 2 && _loc3_ < qiangHuaArr[2])
         {
            xingLingData[param1][param2].setValue(3);
            GetTolal_Data();
            return true;
         }
         if(xingLingData[param1][param2].getValue() == 3 && _loc3_ < qiangHuaArr[3])
         {
            xingLingData[param1][param2].setValue(4);
            GetTolal_Data();
            return true;
         }
         if(xingLingData[param1][param2].getValue() == 4 && _loc3_ < qiangHuaArr[4])
         {
            xingLingData[param1][param2].setValue(5);
            GetTolal_Data();
            return true;
         }
         if(xingLingData[param1][param2].getValue() == 5 && _loc3_ < qiangHuaArr[5])
         {
            xingLingData[param1][param2].setValue(6);
            GetTolal_Data();
            return true;
         }
         return false;
      }
   }
}

