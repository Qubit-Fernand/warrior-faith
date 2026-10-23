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
      
      public static function GetScoreMD5(param1:String) : String
      {
         return MD5.hash_X(param1);
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
         compareObject(param1,_loc2_);
         var _loc3_:String = Base64.encodeByteArray(_loc2_);
         return MD5.hash_X(_loc3_);
      }
      
      public static function compareObject(param1:Object, param2:ByteArray) : Boolean
      {
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeObject(param1);
         var _loc4_:uint = _loc3_.length;
         TiaoShi.txtShow("ByteArray长度" + _loc4_);
         if(_loc3_.length == param2.length)
         {
            _loc5_ = uint(getTimer());
            _loc3_.position = 0;
            param2.position = 0;
            while(_loc4_ - _loc3_.position > 4)
            {
               if(_loc3_.readInt() != param2.readInt())
               {
                  TiaoShi.txtShow("不相等1");
                  return false;
               }
            }
            while(_loc3_.position < _loc4_)
            {
               _loc6_ = _loc3_.readByte();
               if(_loc6_ != param2.readByte())
               {
                  TiaoShi.txtShow("不相等2");
                  return false;
               }
            }
            endTime = getTimer();
            TiaoShi.txtShow("耗时:" + uint(endTime - _loc5_) + "毫秒");
            return true;
         }
         TiaoShi.txtShow("length不相等");
         return false;
      }
   }
}

