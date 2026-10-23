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
      
      public static function Play(param1:Player, param2:Enemy) : *
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Class = null;
         var _loc6_:ACT = null;
         _loc3_ = int(param1.data.skinArr[param1.data.skinNum]);
         _loc4_ = "ACT_" + _loc3_;
         _loc5_ = getDefinitionByName(_loc4_) as Class;
         _loc6_ = new _loc5_();
         _loc6_.x = param2.x;
         _loc6_.y = param2.y - 50;
         Main.world.moveChild_Other.addChild(_loc6_);
      }
   }
}

