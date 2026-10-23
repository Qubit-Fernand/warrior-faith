package src
{
   import flash.display.*;
   import flash.events.*;
   import src.Skin.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol575")]
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
         var hitKG:HitKG = null;
         var i2:int = 0;
         var bool:Boolean = false;
         var i3:int = 0;
         var hit:HitXX = null;
         for(var i:int = 0; i < HitKG.AllHitKG.length; i++)
         {
            hitKG = HitKG.AllHitKG[i] as HitKG;
            for(i2 = 0; i2 < Player.All.length; i2++)
            {
               bool = false;
               for(i3 = 0; i3 < hitKG.objArr.length; i3++)
               {
                  if(Player.All[i2] == hitKG.objArr[i3])
                  {
                     bool = true;
                     break;
                  }
               }
               if(Boolean(Player.All[i2].hit) && Boolean(!bool) && hitKG.hitTestObject(Player.All[i2].hit))
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
                     hit = new HitXX();
                     hit.gongJi_hp = 10000;
                     (Player.All[i2] as Player).HpXX(hit);
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
            }
            for(i2 = 0; i2 < Enemy.All.length; i2++)
            {
               bool = false;
               for(i3 = 0; i3 < hitKG.objArr.length; i3++)
               {
                  if(Enemy.All[i2] == hitKG.objArr[i3])
                  {
                     bool = true;
                     break;
                  }
               }
               if(Boolean(flag == 1 && Enemy.All[i2].id == "62" && Enemy.All[i2].skin.alpha != 1 && Enemy.All[i2].hit) && Boolean(!bool) && hitKG.hitTestObject(Enemy.All[i2].hit))
               {
                  (Enemy.All[i2] as Enemy).skin.alpha = 1;
                  (Enemy.All[i2] as Enemy).skin.hit.y = (Enemy.All[i2] as Enemy).skin.y;
               }
            }
         }
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         AllHitKG[AllHitKG.length] = this;
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         var i:int = 0;
         if(AllHitKG)
         {
            for(i = 0; i < AllHitKG.length; i++)
            {
               if(AllHitKG[i] == this)
               {
                  AllHitKG.splice(i,1);
               }
            }
         }
         this.objArr = new Array();
      }
   }
}

