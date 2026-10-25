package src.Skin
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import src.*;
   
   public class EnemyBoss15 extends EnemySkin
   {
      
      public var wudi:MovieClip;
      
      public function EnemyBoss15()
      {
         super();
         var e:Enemy = new Enemy(49);
         e.x = 800;
         Main.world.moveChild_Enemy.addChild(e);
      }
      
      override public function otherGoTo(str:String) : *
      {
      }
   }
}

