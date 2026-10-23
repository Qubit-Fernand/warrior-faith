package com.hotpoint.braveManIII.models.common
{
   import flash.utils.*;
   
   public class VT
   {
      
      public static var TempVtArr:Array = new Array();
      
      private var _value:Object = new Object();
      
      public function VT()
      {
         super();
      }
      
      public static function GetTempVT(str:String) : Number
      {
         var tempStrArr:Array = null;
         var X_Arr:Array = null;
         var tempNum:Number = NaN;
         var tempStr:String = null;
         var i:int = 0;
         var j:int = 0;
         var tempStrX:String = null;
         var xx1:int = 0;
         tempStrArr = new Array();
         X_Arr = new Array();
         tempStr = "";
         for(i = 0; i < str.length; i++)
         {
            tempStrX = str.substr(i,1);
            if(tempStrX != "+" && tempStrX != "-" && tempStrX != "*" && tempStrX != "/" && tempStrX != "%")
            {
               tempStr += tempStrX;
               if(i == str.length - 1)
               {
                  tempStrArr[tempStrArr.length] = tempStr;
                  break;
               }
            }
            else
            {
               X_Arr[X_Arr.length] = tempStrX;
               tempStrArr[tempStrArr.length] = tempStr;
               tempStr = "";
            }
         }
         tempNum = Number(GetTempXX(int(tempStrArr[0])));
         for(j = 0; j < X_Arr.length; j++)
         {
            xx1 = int(tempStrArr[j + 1]);
            if(X_Arr[j] == "+")
            {
               tempNum += GetTempXX(xx1);
            }
            else if(X_Arr[j] == "-")
            {
               tempNum -= GetTempXX(xx1);
            }
            else if(X_Arr[j] == "*")
            {
               tempNum *= GetTempXX(xx1);
            }
            else if(X_Arr[j] == "/")
            {
               tempNum /= GetTempXX(xx1);
            }
            else if(X_Arr[j] == "%")
            {
               tempNum %= GetTempXX(xx1);
            }
         }
         trace("tempNum ========================================> " + tempNum);
         return tempNum;
      }
      
      private static function GetTempXX(x:int) : Number
      {
         trace("x!!!!!!!!!!" + x);
         if(x < 0 || x > 10)
         {
            trace("GetTempXX 参数错误!!!!!!!!!!");
            return null;
         }
         if(TempVtArr[x])
         {
            return TempVtArr[x].getValue();
         }
         return null;
      }
      
      public static function createVT(value:Number = 0) : VT
      {
         var temp:VT = null;
         temp = new VT();
         temp.setValue(value);
         return temp;
      }
      
      public function setValue(value:Number) : void
      {
         var temp:Object = null;
         temp = new Object();
         temp.random = Math.round(Math.random() * 733 + 5) * (Math.round(Math.random()) * 2 - 1);
         temp.num = value + temp.random;
         this._value = temp;
      }
      
      public function get value() : Object
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function set value(value:Object) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = value;
      }
      
      public function getValue() : Number
      {
         var result:Number = NaN;
         return _value.num - _value.random;
      }
   }
}

