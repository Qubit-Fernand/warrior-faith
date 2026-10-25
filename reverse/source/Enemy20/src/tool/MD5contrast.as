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
         var tmpStr:String = Base64.encodeByteArray(byte);
         trace("\n---tmpStr = " + tmpStr);
         return MD5.hash_X(tmpStr);
      }
   }
}

