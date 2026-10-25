package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class HPdown extends MovieClip
   {
      
      internal var time:int = 20;
      
      public function HPdown()
      {
         super();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public static function Open(num:Number, xx:int, yy:int, color:Boolean = false, Baoji:Boolean = false) : *
      {
         var HP:HPdown = null;
         HP = new HPdown();
         if(num <= 0)
         {
            HP._txt.text = "Miss";
         }
         else
         {
            HP._txt.text = "" + num;
         }
         if(color)
         {
            ColorX(HP._txt,"0xF028C9");
         }
         if(Baoji)
         {
            HP.scaleX = HP.scaleY = 1.5;
         }
         Main.world.moveChild_Other.addChild(HP);
         HP.x = xx + Math.random() * 100 - 50;
         HP.y = yy + Math.random() * 50;
      }
      
      private static function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = undefined;
         myTextFormat = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
      }
      
      private function onENTER_FRAME(e:*) : *
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
   }
}

