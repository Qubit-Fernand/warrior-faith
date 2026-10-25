package com.ByteArrayXX
{
   import flash.utils.*;
   
   public class Base64
   {
      
      private static const base64chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
      
      public function Base64()
      {
         super();
      }
      
      public static function encode(param1:String) : String
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(!param1 || param1 == "")
         {
            return "";
         }
         _loc3_ = param1.length;
         _loc4_ = "";
         while(_loc2_ < _loc3_)
         {
            _loc5_ = param1.charCodeAt(_loc2_++);
            _loc6_ = param1.charCodeAt(_loc2_++);
            _loc7_ = param1.charCodeAt(_loc2_++);
            _loc8_ = _loc5_ >> 2;
            _loc9_ = (_loc5_ & 3) << 4 | _loc6_ >> 4;
            _loc10_ = (_loc6_ & 0x0F) << 2 | _loc7_ >> 6;
            _loc11_ = _loc7_ & 0x3F;
            if(isNaN(_loc6_))
            {
               _loc10_ = _loc11_ = 64;
            }
            else if(isNaN(_loc7_))
            {
               _loc11_ = 64;
            }
            _loc4_ += base64chars.charAt(_loc8_) + base64chars.charAt(_loc9_);
            _loc4_ = _loc4_ + (base64chars.charAt(_loc10_) + base64chars.charAt(_loc11_));
         }
         return _loc4_;
      }
      
      public static function decodeToByteArray(param1:String) : ByteArray
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc2_ = new ByteArray();
         _loc3_ = new Array(4);
         _loc4_ = new Array(3);
         _loc5_ = uint(param1.length);
         while(_loc6_ < _loc5_)
         {
            _loc7_ = 0;
            while(_loc7_ < 4 && _loc6_ + _loc7_ < _loc5_)
            {
               _loc3_[_loc7_] = base64chars.indexOf(param1.charAt(_loc6_ + _loc7_));
               _loc7_++;
            }
            _loc4_[0] = (_loc3_[0] << 2) + ((_loc3_[1] & 0x30) >> 4);
            _loc4_[1] = ((_loc3_[1] & 0x0F) << 4) + ((_loc3_[2] & 0x3C) >> 2);
            _loc4_[2] = ((_loc3_[2] & 3) << 6) + _loc3_[3];
            _loc8_ = 0;
            while(_loc8_ < 3)
            {
               if(_loc3_[_loc8_ + 1] == 64)
               {
                  break;
               }
               _loc2_.writeByte(_loc4_[_loc8_]);
               _loc8_++;
            }
            _loc6_ += 4;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function encodeByteArray(param1:ByteArray) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         if(!param1)
         {
            return "";
         }
         _loc4_ = param1.position;
         _loc5_ = "";
         _loc7_ = new Array(4);
         param1.position = 0;
         while(param1.bytesAvailable > 0)
         {
            _loc6_ = new Array();
            _loc2_ = 0;
            while(_loc2_ < 3 && param1.bytesAvailable > 0)
            {
               _loc6_[_loc2_] = param1.readUnsignedByte();
               _loc2_++;
            }
            _loc7_[0] = (_loc6_[0] & 0xFC) >> 2;
            _loc7_[1] = (_loc6_[0] & 3) << 4 | _loc6_[1] >> 4;
            _loc7_[2] = (_loc6_[1] & 0x0F) << 2 | _loc6_[2] >> 6;
            _loc7_[3] = _loc6_[2] & 0x3F;
            _loc3_ = int(_loc6_.length);
            _loc2_ = _loc3_;
            while(_loc2_ < 3)
            {
               _loc7_[_loc2_ + 1] = 64;
               _loc2_++;
            }
            _loc3_ = int(_loc7_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc5_ += base64chars.charAt(_loc7_[_loc2_]);
               _loc2_++;
            }
         }
         param1.position = _loc4_;
         return _loc5_;
      }
      
      public static function decode(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         if(!param1 || param1 == "")
         {
            return "";
         }
         _loc10_ = param1.length;
         _loc11_ = "";
         while(_loc9_ < _loc10_)
         {
            _loc5_ = int(base64chars.indexOf(param1.charAt(_loc9_++)));
            _loc6_ = int(base64chars.indexOf(param1.charAt(_loc9_++)));
            _loc7_ = int(base64chars.indexOf(param1.charAt(_loc9_++)));
            _loc8_ = int(base64chars.indexOf(param1.charAt(_loc9_++)));
            _loc2_ = _loc5_ << 2 | _loc6_ >> 4;
            _loc3_ = (_loc6_ & 0x0F) << 4 | _loc7_ >> 2;
            _loc4_ = (_loc7_ & 3) << 6 | _loc8_;
            _loc11_ += String.fromCharCode(_loc2_);
            if(_loc7_ != 64)
            {
               _loc11_ += String.fromCharCode(_loc3_);
            }
            if(_loc8_ != 64)
            {
               _loc11_ += String.fromCharCode(_loc4_);
            }
         }
         return _loc11_;
      }
   }
}

