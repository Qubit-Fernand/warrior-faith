package src.tool
{
   import flash.utils.*;
   import src.*;
   
   public class Obj_Compare
   {
      
      public function Obj_Compare()
      {
         super();
      }
      
      public static function getObj_ByteArray(param1:Object) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function CompareByteArray(param1:ByteArray, param2:ByteArray) : Boolean
      {
         var _loc5_:* = undefined;
         var _loc3_:uint = uint(getTimer());
         var _loc4_:int = int(param1.length);
         if(param1.length == param2.length)
         {
            param1.position = 0;
            param2.position = 0;
            while(_loc4_ - param1.position > 4)
            {
               if(param1.readUnsignedInt() != param2.readUnsignedInt())
               {
                  return false;
               }
            }
            while(param1.position < _loc4_)
            {
               if(param1.readByte() != param2.readByte())
               {
                  return false;
               }
            }
            _loc5_ = getTimer();
            return true;
         }
         return false;
      }
   }
}

