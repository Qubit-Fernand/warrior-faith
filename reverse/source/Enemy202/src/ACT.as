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
         var _loc3_:int = int(param1.data.skinArr[param1.data.skinNum]);
         var _loc4_:String = "ACT_" + _loc3_;
         var _loc5_:Class = getDefinitionByName(_loc4_) as Class;
         var _loc6_:ACT = new _loc5_();
         _loc6_.x = param2.x;
         if(param2.id == 31)
         {
            _loc6_.y = 160;
         }
         else
         {
            _loc6_.y = param2.y - 50;
         }
         Main.world.moveChild_Other.addChild(_loc6_);
      }
      
      public static function Play2(param1:int, param2:Enemy) : *
      {
         var _loc3_:String = "ACT_" + param1;
         var _loc4_:Class = getDefinitionByName(_loc3_) as Class;
         var _loc5_:ACT = new _loc4_();
         _loc5_.x = param2.x;
         if(param2.id == 31)
         {
            _loc5_.y = 160;
         }
         else
         {
            _loc5_.y = param2.y - 50;
         }
         Main.world.moveChild_Other.addChild(_loc5_);
      }
   }
}

