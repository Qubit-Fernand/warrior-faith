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
         var _loc_2:String = null;
         var _loc_3:String = null;
         var _loc_4:int = 0;
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         _loc_2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
         _loc_3 = new String("");
         _loc_4 = 0;
         while(_loc_4 < param1.length * 4)
         {
            _loc_5 = (param1[_loc_4 >> 2] >> 8 * (_loc_4 % 4) & 0xFF) << 16 | (param1[_loc_4 + 1 >> 2] >> 8 * ((_loc_4 + 1) % 4) & 0xFF) << 8 | param1[_loc_4 + 2 >> 2] >> 8 * ((_loc_4 + 2) % 4) & 0xFF;
            _loc_6 = 0;
            while(_loc_6 < 4)
            {
               if(_loc_4 * 8 + _loc_6 * 6 > param1.length * 32)
               {
                  _loc_3 += b64pad;
               }
               else
               {
                  _loc_3 += _loc_2.charAt(_loc_5 >> 6 * (3 - _loc_6) & 0x3F);
               }
               _loc_6++;
            }
            _loc_4 += 3;
         }
         return _loc_3;
      }
      
      private function md5_cmn(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
      {
         return safe_add(bit_rol(safe_add(safe_add(param2,param1),safe_add(param4,param6)),param5),param3);
      }
      
      private function binl2str(param1:Array) : String
      {
         var _loc_2:String = null;
         var _loc_3:int = 0;
         var _loc_4:int = 0;
         _loc_2 = new String("");
         _loc_3 = (1 << chrsz) - 1;
         _loc_4 = 0;
         while(_loc_4 < param1.length * 32)
         {
            _loc_2 += String.fromCharCode(param1[_loc_4 >> 5] >>> _loc_4 % 32 & _loc_3);
            _loc_4 += chrsz;
         }
         return _loc_2;
      }
      
      private function core_hmac_md5(param1:String, param2:String) : Array
      {
         var _loc_3:Array = null;
         var _loc_4:Array = null;
         var _loc_5:Array = null;
         var _loc_6:int = 0;
         var _loc_7:Array = null;
         _loc_3 = new Array(str2binl(param1));
         if(_loc_3.length > 16)
         {
            _loc_3 = core_md5(_loc_3,param1.length * chrsz);
         }
         _loc_4 = new Array(16);
         _loc_5 = new Array(16);
         _loc_6 = 0;
         while(_loc_6 < 16)
         {
            _loc_4[_loc_6] = _loc_3[_loc_6] ^ 0x36363636;
            _loc_5[_loc_6] = _loc_3[_loc_6] ^ 0x5C5C5C5C;
            _loc_6++;
         }
         _loc_7 = new Array(core_md5(_loc_4.concat(str2binl(param2)),512 + param2.length * chrsz));
         return core_md5(_loc_5.concat(_loc_7),512 + 128);
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
         var _loc_3:int = 0;
         var _loc_4:int = 0;
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         var _loc_7:int = 0;
         var _loc_8:int = 0;
         var _loc_9:int = 0;
         var _loc_10:int = 0;
         var _loc_11:int = 0;
         param1[param2 >> 5] |= 128 << param2 % 32;
         param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
         _loc_3 = 1732584193;
         _loc_4 = -271733879;
         _loc_5 = -1732584194;
         _loc_6 = 271733878;
         _loc_7 = 0;
         while(_loc_7 < param1.length)
         {
            _loc_8 = _loc_3;
            _loc_9 = _loc_4;
            _loc_10 = _loc_5;
            _loc_11 = _loc_6;
            _loc_3 = int(md5_ff(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 0],7,-680876936));
            _loc_6 = int(md5_ff(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 1],12,-389564586));
            _loc_5 = int(md5_ff(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 2],17,606105819));
            _loc_4 = int(md5_ff(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 3],22,-1044525330));
            _loc_3 = int(md5_ff(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 4],7,-176418897));
            _loc_6 = int(md5_ff(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 5],12,1200080426));
            _loc_5 = int(md5_ff(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 6],17,-1473231341));
            _loc_4 = int(md5_ff(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 7],22,-45705983));
            _loc_3 = int(md5_ff(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 8],7,1770035416));
            _loc_6 = int(md5_ff(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 9],12,-1958414417));
            _loc_5 = int(md5_ff(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 10],17,-42063));
            _loc_4 = int(md5_ff(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 11],22,-1990404162));
            _loc_3 = int(md5_ff(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 12],7,1804603682));
            _loc_6 = int(md5_ff(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 13],12,-40341101));
            _loc_5 = int(md5_ff(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 14],17,-1502002290));
            _loc_4 = int(md5_ff(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 15],22,1236535329));
            _loc_3 = int(md5_gg(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 1],5,-165796510));
            _loc_6 = int(md5_gg(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 6],9,-1069501632));
            _loc_5 = int(md5_gg(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 11],14,643717713));
            _loc_4 = int(md5_gg(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 0],20,-373897302));
            _loc_3 = int(md5_gg(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 5],5,-701558691));
            _loc_6 = int(md5_gg(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 10],9,38016083));
            _loc_5 = int(md5_gg(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 15],14,-660478335));
            _loc_4 = int(md5_gg(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 4],20,-405537848));
            _loc_3 = int(md5_gg(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 9],5,568446438));
            _loc_6 = int(md5_gg(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 14],9,-1019803690));
            _loc_5 = int(md5_gg(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 3],14,-187363961));
            _loc_4 = int(md5_gg(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 8],20,1163531501));
            _loc_3 = int(md5_gg(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 13],5,-1444681467));
            _loc_6 = int(md5_gg(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 2],9,-51403784));
            _loc_5 = int(md5_gg(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 7],14,1735328473));
            _loc_4 = int(md5_gg(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 12],20,-1926607734));
            _loc_3 = int(md5_hh(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 5],4,-378558));
            _loc_6 = int(md5_hh(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 8],11,-2022574463));
            _loc_5 = int(md5_hh(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 11],16,1839030562));
            _loc_4 = int(md5_hh(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 14],23,-35309556));
            _loc_3 = int(md5_hh(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 1],4,-1530992060));
            _loc_6 = int(md5_hh(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 4],11,1272893353));
            _loc_5 = int(md5_hh(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 7],16,-155497632));
            _loc_4 = int(md5_hh(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 10],23,-1094730640));
            _loc_3 = int(md5_hh(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 13],4,681279174));
            _loc_6 = int(md5_hh(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 0],11,-358537222));
            _loc_5 = int(md5_hh(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 3],16,-722521979));
            _loc_4 = int(md5_hh(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 6],23,76029189));
            _loc_3 = int(md5_hh(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 9],4,-640364487));
            _loc_6 = int(md5_hh(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 12],11,-421815835));
            _loc_5 = int(md5_hh(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 15],16,530742520));
            _loc_4 = int(md5_hh(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 2],23,-995338651));
            _loc_3 = int(md5_ii(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 0],6,-198630844));
            _loc_6 = int(md5_ii(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 7],10,1126891415));
            _loc_5 = int(md5_ii(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 14],15,-1416354905));
            _loc_4 = int(md5_ii(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 5],21,-57434055));
            _loc_3 = int(md5_ii(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 12],6,1700485571));
            _loc_6 = int(md5_ii(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 3],10,-1894986606));
            _loc_5 = int(md5_ii(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 10],15,-1051523));
            _loc_4 = int(md5_ii(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 1],21,-2054922799));
            _loc_3 = int(md5_ii(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 8],6,1873313359));
            _loc_6 = int(md5_ii(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 15],10,-30611744));
            _loc_5 = int(md5_ii(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 6],15,-1560198380));
            _loc_4 = int(md5_ii(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 13],21,1309151649));
            _loc_3 = int(md5_ii(_loc_3,_loc_4,_loc_5,_loc_6,param1[_loc_7 + 4],6,-145523070));
            _loc_6 = int(md5_ii(_loc_6,_loc_3,_loc_4,_loc_5,param1[_loc_7 + 11],10,-1120210379));
            _loc_5 = int(md5_ii(_loc_5,_loc_6,_loc_3,_loc_4,param1[_loc_7 + 2],15,718787259));
            _loc_4 = int(md5_ii(_loc_4,_loc_5,_loc_6,_loc_3,param1[_loc_7 + 9],21,-343485551));
            _loc_3 = int(safe_add(_loc_3,_loc_8));
            _loc_4 = int(safe_add(_loc_4,_loc_9));
            _loc_5 = int(safe_add(_loc_5,_loc_10));
            _loc_6 = int(safe_add(_loc_6,_loc_11));
            _loc_7 += 16;
         }
         return new Array(_loc_3,_loc_4,_loc_5,_loc_6);
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
         var _loc_2:Array = null;
         var _loc_3:int = 0;
         var _loc_4:int = 0;
         _loc_2 = new Array();
         _loc_3 = (1 << chrsz) - 1;
         _loc_4 = 0;
         while(_loc_4 < param1.length * chrsz)
         {
            _loc_2[_loc_4 >> 5] |= (param1.charCodeAt(_loc_4 / chrsz) & _loc_3) << _loc_4 % 32;
            _loc_4 += chrsz;
         }
         return _loc_2;
      }
      
      private function binl2hex(param1:Array) : String
      {
         var _loc_2:String = null;
         var _loc_3:String = null;
         var _loc_4:int = 0;
         _loc_2 = "0123456789abcdef";
         _loc_3 = new String("");
         _loc_4 = 0;
         while(_loc_4 < param1.length * 4)
         {
            _loc_3 += _loc_2.charAt(param1[_loc_4 >> 2] >> _loc_4 % 4 * 8 + 4 & 0x0F) + _loc_2.charAt(param1[_loc_4 >> 2] >> _loc_4 % 4 * 8 & 0x0F);
            _loc_4++;
         }
         return _loc_3;
      }
      
      private function safe_add(param1:Number, param2:Number) : Number
      {
         var _loc_3:int = 0;
         var _loc_4:int = 0;
         _loc_3 = (param1 & 0xFFFF) + (param2 & 0xFFFF);
         _loc_4 = (param1 >> 16) + (param2 >> 16) + (_loc_3 >> 16);
         return _loc_4 << 16 | _loc_3 & 0xFFFF;
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

