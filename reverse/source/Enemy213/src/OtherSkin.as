package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class OtherSkin extends MovieClip
   {
      
      public static var All:Array = [];
      
      public var id:int;
      
      public var hit:MovieClip = null;
      
      public var skin:MovieClip;
      
      public function OtherSkin(param1:int)
      {
         super();
         this.id = param1;
         this.addskin();
         All[All.length] = this;
      }
      
      public function addskin() : *
      {
         var _loc1_:Class = Enemy.EnemyArr[81].getClass("水晶灯机关") as Class;
         this.skin = new _loc1_();
         this.addChild(this.skin);
      }
   }
}

