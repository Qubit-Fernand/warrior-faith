package com
{
   import flash.utils.*;
   
   public class DeepCopyUtil
   {
      
      public function DeepCopyUtil()
      {
         super();
      }
      
      public static function clone(source:Object) : *
      {
         var array:ByteArray = new ByteArray();
         array.writeObject(source);
         array.position = 0;
         return array.readObject();
      }
   }
}

