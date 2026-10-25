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
      
      public static function contrast(param1:String, param2:String, param3:uint = 9) : Boolean
      {
         if(uint(param2.substr(5,1)) != param3)
         {
            errorID = 1;
            return false;
         }
         if(param2.substr(6,8) != MD5.hash_X(param1).substr(0,8))
         {
            contrastID = "大写错误";
            if(param2.substr(6,8) != MD5.hash_X(param1.toLocaleLowerCase()).substr(0,8))
            {
               contrastID = "小写错误";
               if(param2.substr(6,8) != MD5.hash_X(param1.toLocaleUpperCase()).substr(0,8))
               {
                  errorID = 2;
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function SaveStr(param1:String, param2:uint, param3:int = 1) : String
      {
         var _loc4_:String = null;
         if(param3 == 1)
         {
            _loc4_ = String(Math.random() * 654321 + 54321).substr(0,5);
            _loc4_ = _loc4_ + String(param2);
            return _loc4_ + MD5.hash_X(param1).substr(0,8);
         }
         return "";
      }
      
      public static function getObj_MD5String(param1:Object) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         var _loc3_:String = Base64.encodeByteArray(_loc2_);
         return MD5.hash_X(_loc3_);
      }
   }
}

