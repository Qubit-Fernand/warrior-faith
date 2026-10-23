package src.tool
{
   public class MD5
   {
      
      private static var mdXX:MD5 = new MD5();
      
      private var chrsz:int = 8;
      
      private var b64pad:String = "";
      
      public function MD5(param1:String = null, param2:int = 0)
      {
         super();
         b64pad = "";
         chrsz = 8;
         if(param1 != null)
         {
            this.b64pad = param1.toLocaleLowerCase();
         }
         if(param2 != 0 && param2 == 8 || param2 == 16)
         {
            this.chrsz = param2;
         }
      }
      
      public static function hash_X(param1:String) : String
      {
         return mdXX.hash(param1);
      }
      
      private function hash(param1:String) : String
      {
         return hex_md5(param1);
      }
      
      private function binl2b64(param1:Array) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
         _loc3_ = new String("");
         _loc4_ = 0;
         while(_loc4_ < param1.length * 4)
         {
            _loc5_ = (param1[_loc4_ >> 2] >> 8 * (_loc4_ % 4) & 0xFF) << 16 | (param1[_loc4_ + 1 >> 2] >> 8 * ((_loc4_ + 1) % 4) & 0xFF) << 8 | param1[_loc4_ + 2 >> 2] >> 8 * ((_loc4_ + 2) % 4) & 0xFF;
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               if(_loc4_ * 8 + _loc6_ * 6 > param1.length * 32)
               {
                  _loc3_ += b64pad;
               }
               else
               {
                  _loc3_ += _loc2_.charAt(_loc5_ >> 6 * (3 - _loc6_) & 0x3F);
               }
               _loc6_++;
            }
            _loc4_ += 3;
         }
         return _loc3_;
      }
      
      private function md5_cmn(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
      {
         return safe_add(bit_rol(safe_add(safe_add(param2,param1),safe_add(param4,param6)),param5),param3);
      }
      
      private function binl2str(param1:Array) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = new String("");
         _loc3_ = (1 << chrsz) - 1;
         _loc4_ = 0;
         while(_loc4_ < param1.length * 32)
         {
            _loc2_ += String.fromCharCode(param1[_loc4_ >> 5] >>> _loc4_ % 32 & _loc3_);
            _loc4_ += chrsz;
         }
         return _loc2_;
      }
      
      private function core_hmac_md5(param1:String, param2:String) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         _loc3_ = new Array(str2binl(param1));
         if(_loc3_.length > 16)
         {
            _loc3_ = core_md5(_loc3_,param1.length * chrsz);
         }
         _loc4_ = new Array(16);
         _loc5_ = new Array(16);
         _loc6_ = 0;
         while(_loc6_ < 16)
         {
            _loc4_[_loc6_] = _loc3_[_loc6_] ^ 0x36363636;
            _loc5_[_loc6_] = _loc3_[_loc6_] ^ 0x5C5C5C5C;
            _loc6_++;
         }
         _loc7_ = new Array(core_md5(_loc4_.concat(str2binl(param2)),512 + param2.length * chrsz));
         return core_md5(_loc5_.concat(_loc7_),512 + 128);
      }
      
      private function md5_gg(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return md5_cmn(param2 & param4 | param3 & ~param4,param1,param2,param5,param6,param7);
      }
      
      private function hex_hmac_md5(param1:String, param2:String) : String
      {
         return binl2hex(core_hmac_md5(param1,param2));
      }
      
      private function md5_ii(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return md5_cmn(param3 ^ (param2 | ~param4),param1,param2,param5,param6,param7);
      }
      
      private function hex_md5(param1:String) : String
      {
         return binl2hex(core_md5(str2binl(param1),param1.length * chrsz));
      }
      
      private function bit_rol(param1:int, param2:int) : int
      {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      private function core_md5(param1:Array, param2:int) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         param1[param2 >> 5] |= 128 << param2 % 32;
         param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
         _loc3_ = 1732584193;
         _loc4_ = -271733879;
         _loc5_ = -1732584194;
         _loc6_ = 271733878;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc8_ = _loc3_;
            _loc9_ = _loc4_;
            _loc10_ = _loc5_;
            _loc11_ = _loc6_;
            _loc3_ = int(md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],7,-680876936));
            _loc6_ = int(md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 1],12,-389564586));
            _loc5_ = int(md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],17,606105819));
            _loc4_ = int(md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 3],22,-1044525330));
            _loc3_ = int(md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],7,-176418897));
            _loc6_ = int(md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 5],12,1200080426));
            _loc5_ = int(md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],17,-1473231341));
            _loc4_ = int(md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 7],22,-45705983));
            _loc3_ = int(md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],7,1770035416));
            _loc6_ = int(md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 9],12,-1958414417));
            _loc5_ = int(md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],17,-42063));
            _loc4_ = int(md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 11],22,-1990404162));
            _loc3_ = int(md5_ff(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],7,1804603682));
            _loc6_ = int(md5_ff(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 13],12,-40341101));
            _loc5_ = int(md5_ff(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],17,-1502002290));
            _loc4_ = int(md5_ff(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 15],22,1236535329));
            _loc3_ = int(md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],5,-165796510));
            _loc6_ = int(md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 6],9,-1069501632));
            _loc5_ = int(md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],14,643717713));
            _loc4_ = int(md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 0],20,-373897302));
            _loc3_ = int(md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],5,-701558691));
            _loc6_ = int(md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 10],9,38016083));
            _loc5_ = int(md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],14,-660478335));
            _loc4_ = int(md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 4],20,-405537848));
            _loc3_ = int(md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],5,568446438));
            _loc6_ = int(md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 14],9,-1019803690));
            _loc5_ = int(md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],14,-187363961));
            _loc4_ = int(md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 8],20,1163531501));
            _loc3_ = int(md5_gg(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],5,-1444681467));
            _loc6_ = int(md5_gg(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 2],9,-51403784));
            _loc5_ = int(md5_gg(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],14,1735328473));
            _loc4_ = int(md5_gg(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 12],20,-1926607734));
            _loc3_ = int(md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],4,-378558));
            _loc6_ = int(md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 8],11,-2022574463));
            _loc5_ = int(md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],16,1839030562));
            _loc4_ = int(md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 14],23,-35309556));
            _loc3_ = int(md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],4,-1530992060));
            _loc6_ = int(md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 4],11,1272893353));
            _loc5_ = int(md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],16,-155497632));
            _loc4_ = int(md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 10],23,-1094730640));
            _loc3_ = int(md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],4,681279174));
            _loc6_ = int(md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 0],11,-358537222));
            _loc5_ = int(md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],16,-722521979));
            _loc4_ = int(md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 6],23,76029189));
            _loc3_ = int(md5_hh(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],4,-640364487));
            _loc6_ = int(md5_hh(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 12],11,-421815835));
            _loc5_ = int(md5_hh(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],16,530742520));
            _loc4_ = int(md5_hh(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 2],23,-995338651));
            _loc3_ = int(md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],6,-198630844));
            _loc6_ = int(md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 7],10,1126891415));
            _loc5_ = int(md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],15,-1416354905));
            _loc4_ = int(md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 5],21,-57434055));
            _loc3_ = int(md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],6,1700485571));
            _loc6_ = int(md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 3],10,-1894986606));
            _loc5_ = int(md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],15,-1051523));
            _loc4_ = int(md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 1],21,-2054922799));
            _loc3_ = int(md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],6,1873313359));
            _loc6_ = int(md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 15],10,-30611744));
            _loc5_ = int(md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],15,-1560198380));
            _loc4_ = int(md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 13],21,1309151649));
            _loc3_ = int(md5_ii(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],6,-145523070));
            _loc6_ = int(md5_ii(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 11],10,-1120210379));
            _loc5_ = int(md5_ii(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],15,718787259));
            _loc4_ = int(md5_ii(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 9],21,-343485551));
            _loc3_ = int(safe_add(_loc3_,_loc8_));
            _loc4_ = int(safe_add(_loc4_,_loc9_));
            _loc5_ = int(safe_add(_loc5_,_loc10_));
            _loc6_ = int(safe_add(_loc6_,_loc11_));
            _loc7_ += 16;
         }
         return new Array(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      private function b64_md5(param1:String) : String
      {
         return binl2b64(core_md5(str2binl(param1),param1.length * chrsz));
      }
      
      private function md5_hh(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return md5_cmn(param2 ^ param3 ^ param4,param1,param2,param5,param6,param7);
      }
      
      private function b64_hmac_md5(param1:String, param2:String) : String
      {
         return binl2b64(core_hmac_md5(param1,param2));
      }
      
      private function str2binl(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = new Array();
         _loc3_ = (1 << chrsz) - 1;
         _loc4_ = 0;
         while(_loc4_ < param1.length * chrsz)
         {
            _loc2_[_loc4_ >> 5] |= (param1.charCodeAt(_loc4_ / chrsz) & _loc3_) << _loc4_ % 32;
            _loc4_ += chrsz;
         }
         return _loc2_;
      }
      
      private function binl2hex(param1:Array) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _loc2_ = "0123456789abcdef";
         _loc3_ = new String("");
         _loc4_ = 0;
         while(_loc4_ < param1.length * 4)
         {
            _loc3_ += _loc2_.charAt(param1[_loc4_ >> 2] >> _loc4_ % 4 * 8 + 4 & 0x0F) + _loc2_.charAt(param1[_loc4_ >> 2] >> _loc4_ % 4 * 8 & 0x0F);
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function safe_add(param1:Number, param2:Number) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = (param1 & 0xFFFF) + (param2 & 0xFFFF);
         _loc4_ = (param1 >> 16) + (param2 >> 16) + (_loc3_ >> 16);
         return _loc4_ << 16 | _loc3_ & 0xFFFF;
      }
      
      private function str_md5(param1:String) : String
      {
         return binl2str(core_md5(str2binl(param1),param1.length * chrsz));
      }
      
      private function str_hmac_md5(param1:String, param2:String) : String
      {
         return binl2str(core_hmac_md5(param1,param2));
      }
      
      private function md5_ff(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return md5_cmn(param2 & param3 | ~param2 & param4,param1,param2,param5,param6,param7);
      }
   }
}

