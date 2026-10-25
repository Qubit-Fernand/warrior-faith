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
      
      public static function getObj_ByteArray(objX:Object) : ByteArray
      {
         var byte:ByteArray = new ByteArray();
         byte.writeObject(objX);
         byte.position = 0;
         return byte;
      }
      
      public static function CompareByteArray(byt1:ByteArray, byt2:ByteArray) : Boolean
      {
         var endTime:* = undefined;
         var beginTime:uint = uint(getTimer());
         var size:int = int(byt1.length);
         if(byt1.length == byt2.length)
         {
            byt1.position = 0;
            byt2.position = 0;
            while(size - byt1.position > 4)
            {
               if(byt1.readUnsignedInt() != byt2.readUnsignedInt())
               {
                  return false;
               }
            }
            while(byt1.position < size)
            {
               if(byt1.readByte() != byt2.readByte())
               {
                  return false;
               }
            }
            endTime = getTimer();
            TiaoShi.txtShow("耗时:" + uint(endTime - beginTime) + "毫秒");
            return true;
         }
         return false;
      }
   }
}

