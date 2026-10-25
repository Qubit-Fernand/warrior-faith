package com
{
   import flash.utils.*;
   
   public class DeepCopyUtil
   {
      
      public function DeepCopyUtil()
      {
         super();
      }
      
      public static function clone(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
   }
}

