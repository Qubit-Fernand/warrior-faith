package src.other
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.*;
   
   public class Boss108_FlyXX extends Fly
   {
      
      public var playerArr:Array = [0,false,false];
      
      public function Boss108_FlyXX()
      {
         super();
      }
      
      override public function otherXX() : *
      {
         if(this.who)
         {
            this.x = this.who.x;
         }
         if(Boolean(Main.gameNum != 0) && Boolean(this.parent) && this.parent != Main.world.moveChild_Back)
         {
            Main.world.moveChild_Back.addChild(this);
         }
      }
   }
}

