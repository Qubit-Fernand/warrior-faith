package src.tool
{
   import flash.text.*;
   
   public class TextTool
   {
      
      public function TextTool()
      {
         super();
      }
      
      public static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
   }
}

