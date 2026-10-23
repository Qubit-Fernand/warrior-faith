package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol7983")]
   public class HPdown extends MovieClip
   {
      
      public var _txt:TextField;
      
      internal var time:int = 20;
      
      public function HPdown()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public static function Open(param1:Number, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false) : *
      {
         var _loc6_:HPdown = new HPdown();
         if(param1 <= 0)
         {
            _loc6_._txt.text = "Miss";
         }
         else
         {
            _loc6_._txt.text = "" + param1;
         }
         if(param4)
         {
            ColorX(_loc6_._txt,"0xF028C9");
         }
         if(param5)
         {
            _loc6_.scaleX = _loc6_.scaleY = 1.5;
         }
         Main.world.moveChild_Other.addChild(_loc6_);
         _loc6_.x = param2 + Math.random() * 100 - 50;
         _loc6_.y = param3 + Math.random() * 50;
      }
      
      private static function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         if(time > 0)
         {
            --time;
            this.y -= 2;
         }
         else
         {
            this.parent.removeChild(this);
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         }
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
      }
   }
}

