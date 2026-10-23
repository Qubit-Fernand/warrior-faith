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
      
      public static function GetTempVT(param1:String) : Number
      {
         var _loc4_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         var _loc5_:String = "";
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc8_ = param1.substr(_loc6_,1);
            if(_loc8_ != "+" && _loc8_ != "-" && _loc8_ != "*" && _loc8_ != "/" && _loc8_ != "%")
            {
               _loc5_ += _loc8_;
               if(_loc6_ == param1.length - 1)
               {
                  _loc2_[_loc2_.length] = _loc5_;
                  break;
               }
            }
            else
            {
               _loc3_[_loc3_.length] = _loc8_;
               _loc2_[_loc2_.length] = _loc5_;
               _loc5_ = "";
            }
            _loc6_++;
         }
         _loc4_ = Number(GetTempXX(int(_loc2_[0])));
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc9_ = int(_loc2_[_loc7_ + 1]);
            if(_loc3_[_loc7_] == "+")
            {
               _loc4_ += GetTempXX(_loc9_);
            }
            else if(_loc3_[_loc7_] == "-")
            {
               _loc4_ -= GetTempXX(_loc9_);
            }
            else if(_loc3_[_loc7_] == "*")
            {
               _loc4_ *= GetTempXX(_loc9_);
            }
            else if(_loc3_[_loc7_] == "/")
            {
               _loc4_ /= GetTempXX(_loc9_);
            }
            else if(_loc3_[_loc7_] == "%")
            {
               _loc4_ %= GetTempXX(_loc9_);
            }
            _loc7_++;
         }
         return _loc4_;
      }
      
      private static function GetTempXX(param1:int) : Number
      {
         if(param1 < 0 || param1 > 10)
         {
            trace("GetTempXX 参数错误!!!!!!!!!!");
            return null;
         }
         if(TempVtArr[param1])
         {
            return TempVtArr[param1].getValue();
         }
         return null;
      }
      
      public static function createVT(param1:Number = 0) : VT
      {
         var _loc2_:VT = new VT();
         _loc2_.setValue(param1);
         return _loc2_;
      }
      
      public function get value() : Object
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _value;
      }
      
      public function set value(param1:Object) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _value = param1;
      }
      
      public function getValue() : Number
      {
         return _value.num - _value.random;
      }
      
      public function setValue(param1:Number) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.random = Math.round(Math.random() * 733 + 5) * (Math.round(Math.random()) * 2 - 1);
         _loc2_.num = param1 + _loc2_.random;
         this._value = _loc2_;
      }
   }
}

