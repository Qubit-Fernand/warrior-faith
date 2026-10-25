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
      
      public function OtherSkin(i:int)
      {
         super();
         this.id = i;
         addskin();
         All[All.length] = this;
      }
      
      public function addskin() : *
      {
         var classRef:Class = Enemy.EnemyArr[81].getClass("水晶灯机关") as Class;
         skin = new classRef();
         this.addChild(skin);
      }
   }
}

