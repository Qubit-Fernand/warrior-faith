package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.media.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class ACT extends MovieClip
   {
      
      public function ACT()
      {
         super();
      }
      
      public static function Play(p:Player, e:Enemy) : *
      {
         var i:int = 0;
         var st:String = null;
         var classRef:Class = null;
         var act:ACT = null;
         i = int(p.data.skinArr[p.data.skinNum]);
         st = "ACT_" + i;
         classRef = getDefinitionByName(st) as Class;
         act = new classRef();
         act.x = e.x;
         act.y = e.y - 50;
         Main.world.moveChild_Other.addChild(act);
      }
   }
}

