package com.hotpoint.braveManIII.models.common
{
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
         var tempNum:Number = NaN;
         var tempStrX:String = null;
         var xx1:int = 0;
         var tempStrArr:Array = new Array();
         var X_Arr:Array = new Array();
         var tempStr:String = "";
         for(var i:int = 0; i < str.length; i++)
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
         for(var j:int = 0; j < X_Arr.length; j++)
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
         return tempNum;
      }
      
      private static function GetTempXX(x:int) : Number
      {
         if(x < 0 || x > 10)
         {
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
         var temp:VT = new VT();
         temp.setValue(value);
         return temp;
      }
      
      public function get value() : Object
      {
         return this._value;
      }
      
      public function set value(value:Object) : void
      {
         this._value = value;
      }
      
      public function getValue() : Number
      {
         return this._value.num - this._value.random;
      }
      
      public function setValue(value:Number) : void
      {
         var temp:Object = new Object();
         temp.random = Math.round(Math.random() * 733 + 5) * (Math.round(Math.random()) * 2 - 1);
         temp.num = value + temp.random;
         this._value = temp;
      }
   }
}

