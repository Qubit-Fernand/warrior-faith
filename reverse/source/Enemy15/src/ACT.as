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
         var i:int = int(p.data.skinArr[p.data.skinNum]);
         var st:String = "ACT_" + i;
         var classRef:Class = getDefinitionByName(st) as Class;
         var act:ACT = new classRef();
         act.x = e.x;
         if(e.id == 31)
         {
            act.y = 160;
         }
         else
         {
            act.y = e.y - 50;
         }
         Main.world.moveChild_Other.addChild(act);
      }
      
      public static function Play2(xx:int, e:Enemy) : *
      {
         var st:String = "ACT_" + xx;
         var classRef:Class = getDefinitionByName(st) as Class;
         var act:ACT = new classRef();
         act.x = e.x;
         if(e.id == 31)
         {
            act.y = 160;
         }
         else
         {
            act.y = e.y - 50;
         }
         Main.world.moveChild_Other.addChild(act);
      }
   }
}

