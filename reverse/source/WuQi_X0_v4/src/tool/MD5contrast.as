package src.tool
{
   import com.ByteArrayXX.*;
   import flash.utils.*;
   import src.*;
   
   public class MD5contrast
   {
      
      public static var contrastID:String = "验证通过!!";
      
      public static var errorID:int = 0;
      
      public function MD5contrast()
      {
         super();
      }
      
      public static function contrast(id_Str:String, Md5:String, save_num:uint = 9) : Boolean
      {
         if(uint(Md5.substr(5,1)) != save_num)
         {
            errorID = 1;
            return false;
         }
         if(Md5.substr(6,8) != MD5.hash_X(id_Str).substr(0,8))
         {
            contrastID = "大写错误";
            if(Md5.substr(6,8) != MD5.hash_X(id_Str.toLocaleLowerCase()).substr(0,8))
            {
               contrastID = "小写错误";
               if(Md5.substr(6,8) != MD5.hash_X(id_Str.toLocaleUpperCase()).substr(0,8))
               {
                  errorID = 2;
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function GetScoreMD5(tempStr:String) : String
      {
         return MD5.hash_X(tempStr);
      }
      
      public static function SaveStr(str:String, num:uint, type:int = 1) : String
      {
         var strRandom:String = null;
         if(type == 1)
         {
            strRandom = String(Math.random() * 654321 + 54321).substr(0,5);
            strRandom += String(num);
            return strRandom + MD5.hash_X(str).substr(0,8);
         }
         return "";
      }
      
      public static function getObj_MD5String(objX:Object) : String
      {
         var byte:ByteArray = new ByteArray();
         byte.writeObject(objX);
         byte.position = 0;
         compareObject(objX,byte);
         var tmpStr:String = Base64.encodeByteArray(byte);
         return MD5.hash_X(tmpStr);
      }
      
      public static function compareObject(obj1:Object, buffer2:ByteArray) : Boolean
      {
         var beginTime:uint = 0;
         var v2:int = 0;
         var buffer1:ByteArray = new ByteArray();
         buffer1.writeObject(obj1);
         var size:uint = buffer1.length;
         TiaoShi.txtShow("ByteArray长度" + size);
         if(buffer1.length == buffer2.length)
         {
            beginTime = uint(getTimer());
            buffer1.position = 0;
            buffer2.position = 0;
            while(size - buffer1.position > 4)
            {
               if(buffer1.readInt() != buffer2.readInt())
               {
                  TiaoShi.txtShow("不相等1");
                  return false;
               }
            }
            while(buffer1.position < size)
            {
               v2 = buffer1.readByte();
               if(v2 != buffer2.readByte())
               {
                  TiaoShi.txtShow("不相等2");
                  return false;
               }
            }
            endTime = getTimer();
            TiaoShi.txtShow("耗时:" + uint(endTime - beginTime) + "毫秒");
            return true;
         }
         TiaoShi.txtShow("length不相等");
         return false;
      }
   }
}

