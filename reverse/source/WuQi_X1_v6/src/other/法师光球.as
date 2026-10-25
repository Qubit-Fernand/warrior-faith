package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol199")]
   public class 法师光球 extends Fly
   {
      
      public function 法师光球()
      {
         super();
      }
      
      override public function Dead() : *
      {
         var _loc1_:法师光球束缚 = null;
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         if(this.who is Player || this.who is Enemy || this.who is Player2)
         {
            _loc1_ = new 法师光球束缚();
            _loc1_.who = this.who;
            _loc1_.RL = this.RL;
            this.parent.addChild(_loc1_);
            _loc1_.x = this.x;
            _loc1_.y = this.y;
            this.parent.removeChild(this);
         }
      }
   }
}

