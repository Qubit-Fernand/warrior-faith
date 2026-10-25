package src.tool
{
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class TeShuHuoDong
   {
      
      public static var TeShuHuoDongArr:Array = [];
      
      public function TeShuHuoDong()
      {
         super();
      }
      
      public static function Init() : *
      {
         if(!TeShuHuoDongArr[0])
         {
            TeShuHuoDongArr[0] = 0;
         }
         if(!TeShuHuoDongArr[1])
         {
            TeShuHuoDongArr[1] = 0;
         }
         if(!TeShuHuoDongArr[2])
         {
            TeShuHuoDongArr[2] = 0;
         }
         if(!TeShuHuoDongArr[3])
         {
            TeShuHuoDongArr[3] = 0;
         }
      }
   }
}

