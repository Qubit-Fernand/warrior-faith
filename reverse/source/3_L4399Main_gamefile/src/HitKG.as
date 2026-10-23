package src
{
   import flash.display.*;
   import flash.events.*;
   import src.Skin.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3009")]
   public class HitKG extends MovieClip
   {
      
      public static var AllHitKG:Array = [];
      
      public static var guangsu:GuangSu = new GuangSu();
      
      public static var flag:int = 0;
      
      public static var timeTemp:int = 0;
      
      public static var time:int = 0;
      
      public var objArr:Array = [];
      
      public function HitKG()
      {
         super();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      public static function HitFly() : *
      {
         var _loc2_:HitKG = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:HitXX = null;
         var _loc1_:int = 0;
         while(_loc1_ < HitKG.AllHitKG.length)
         {
            _loc2_ = HitKG.AllHitKG[_loc1_] as HitKG;
            _loc3_ = 0;
            while(_loc3_ < Player.All.length)
            {
               _loc4_ = false;
               _loc5_ = 0;
               while(_loc5_ < _loc2_.objArr.length)
               {
                  if(Player.All[_loc3_] == _loc2_.objArr[_loc5_])
                  {
                     _loc4_ = true;
                     break;
                  }
                  _loc5_++;
               }
               if(Boolean(Player.All[_loc3_].hit) && Boolean(!_loc4_) && _loc2_.hitTestObject(Player.All[_loc3_].hit))
               {
                  ++time;
                  if(time > 27)
                  {
                     EnemyBoss52.kaiguan.gotoAndStop(3);
                     Main.world.moveChild_Other.addChild(guangsu);
                     guangsu.x = 5400;
                     guangsu.y = 500;
                     timeTemp = 50;
                     flag = 1;
                     time = 0;
                     _loc6_ = new HitXX();
                     _loc6_.gongJi_hp = 10000;
                     (Player.All[_loc3_] as Player).HpXX(_loc6_);
                  }
               }
               else
               {
                  time = 0;
               }
               if(timeTemp > 0)
               {
                  --timeTemp;
                  if(timeTemp <= 0)
                  {
                     flag = 0;
                     EnemyBoss52.kaiguan.gotoAndStop(1);
                     Main.world.moveChild_Other.removeChild(guangsu);
                  }
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < Enemy.All.length)
            {
               _loc4_ = false;
               _loc5_ = 0;
               while(_loc5_ < _loc2_.objArr.length)
               {
                  if(Enemy.All[_loc3_] == _loc2_.objArr[_loc5_])
                  {
                     _loc4_ = true;
                     break;
                  }
                  _loc5_++;
               }
               if(Boolean(flag == 1 && Enemy.All[_loc3_].id == "62" && Enemy.All[_loc3_].skin.alpha != 1 && Enemy.All[_loc3_].hit) && Boolean(!_loc4_) && _loc2_.hitTestObject(Enemy.All[_loc3_].hit))
               {
                  (Enemy.All[_loc3_] as Enemy).skin.alpha = 1;
                  (Enemy.All[_loc3_] as Enemy).skin.hit.y = (Enemy.All[_loc3_] as Enemy).skin.y;
               }
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         AllHitKG[AllHitKG.length] = this;
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         var _loc2_:int = 0;
         if(AllHitKG)
         {
            _loc2_ = 0;
            while(_loc2_ < AllHitKG.length)
            {
               if(AllHitKG[_loc2_] == this)
               {
                  AllHitKG.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
         this.objArr = new Array();
      }
   }
}

