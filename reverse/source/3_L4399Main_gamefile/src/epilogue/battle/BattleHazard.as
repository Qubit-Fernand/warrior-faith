package src.epilogue.battle
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;

   /** Telegraph and collision share the same arena-local geometry. No stage timers. */
   public class BattleHazard extends Sprite
   {
      public var kind:String;
      public var elapsed:Number = 0;
      public var warning:Number;
      public var duration:Number;
      public var finished:Boolean = false;
      public var fired:Boolean = false;
      private var left:Number;
      private var right:Number;
      private var floorY:Number;
      private var targets:Array;
      private var direction:int;
      private var hitOnce:Boolean = false;
      private var strength:Number;

      public function BattleHazard(type:String, x1:Number, x2:Number, ground:Number,
                                   aim:Array, warn:Number, active:Number, dir:int = 1, power:Number = 1)
      {
         kind = type;
         left = x1; right = x2; floorY = ground;
         targets = aim.concat(); warning = warn; duration = active;
         direction = dir; strength = power;
         mouseEnabled = mouseChildren = false;
         name = "chapterHazard_" + type;
         render();
      }

      public function update(dt:Number):void
      {
         elapsed += dt;
         fired = elapsed >= warning;
         finished = elapsed >= warning + duration;
         render();
      }

      /** One damage application per hazard; jump clears the 34px ground wave. */
      public function touches(bounds:Rectangle, feet:Point):Boolean
      {
         if(!fired || finished || hitOnce) return false;
         var hit:Boolean = false;
         var a:Number;
         var c:Number;
         if(kind == "wave")
         {
            a = Math.min(1, (elapsed - warning) / duration);
            c = direction > 0 ? left + (right - left) * a : right - (right - left) * a;
            hit = feet.y > floorY - 36 && bounds.intersects(new Rectangle(c - 38, floorY - 34, 76, 42));
         }
         else
         {
            for each(c in targets)
            {
               if(bounds.intersects(new Rectangle(c - 43, floorY - 360, 86, 372)))
               {
                  hit = true;
                  break;
               }
            }
         }
         if(hit) hitOnce = true;
         return hit;
      }

      public function get damageScale():Number { return strength; }
      public function get progress():Number { return Math.min(1, elapsed / warning); }
      public function get state():Object
      {
         return {kind:kind, elapsed:elapsed, warning:warning, active:fired,
                 finished:finished, hit:hitOnce, targets:targets.concat(), direction:direction};
      }

      private function render():void
      {
         graphics.clear();
         if(finished) return;
         var c:Number;
         var i:int;
         var a:Number;
         if(kind == "wave")
         {
            if(!fired)
            {
               graphics.beginFill(0xF6B64F, .12 + .08 * Math.sin(elapsed * 16));
               graphics.drawRect(left, floorY - 34, right - left, 34);
               graphics.endFill();
               graphics.lineStyle(2, 0xFFD58A, .85);
               graphics.moveTo(left, floorY - 34); graphics.lineTo(right, floorY - 34);
               for(c = left + 45; c < right; c += 90)
               {
                  graphics.moveTo(c - 9, floorY - 49); graphics.lineTo(c, floorY - 62);
                  graphics.lineTo(c + 9, floorY - 49);
               }
               graphics.lineStyle(4, 0xFFCF75, 1);
               graphics.moveTo(left, floorY - 3);
               graphics.lineTo(left + (right - left) * progress, floorY - 3);
            }
            else
            {
               a = Math.min(1, (elapsed - warning) / duration);
               c = direction > 0 ? left + (right - left) * a : right - (right - left) * a;
               graphics.lineStyle(0, 0, 0);
               graphics.beginFill(0xFFB64B, .24);
               graphics.drawEllipse(c - 60, floorY - 38, 120, 48); graphics.endFill();
               graphics.beginFill(0xFFE9A4, .9);
               graphics.drawRect(c - 28, floorY - 32, 56, 36); graphics.endFill();
               graphics.lineStyle(3, 0xFFF9DC, 1);
               graphics.moveTo(c, floorY); graphics.lineTo(c, floorY - 38);
            }
         }
         else
         {
            for each(c in targets)
            {
               if(!fired)
               {
                  graphics.lineStyle(1, 0xD5B5FF, .85);
                  graphics.beginFill(0x875CDA, .13 + .07 * Math.sin(elapsed * 14));
                  graphics.drawRect(c - 43, floorY - 360, 86, 372); graphics.endFill();
                  graphics.lineStyle(3, 0xE1C9FF, 1);
                  graphics.drawEllipse(c - 43, floorY - 10, 86, 20);
                  graphics.moveTo(c - 33, floorY - 370);
                  graphics.lineTo(c - 33 + 66 * progress, floorY - 370);
                  // Outward arrows communicate sideways movement, not jumping.
                  for(i = -1; i <= 1; i += 2)
                  {
                     graphics.moveTo(c + i * 50, floorY - 65);
                     graphics.lineTo(c + i * 65, floorY - 65);
                     graphics.lineTo(c + i * 58, floorY - 72);
                     graphics.moveTo(c + i * 65, floorY - 65);
                     graphics.lineTo(c + i * 58, floorY - 58);
                  }
               }
               else
               {
                  graphics.lineStyle(0, 0, 0);
                  graphics.beginFill(0xA876F1, .3);
                  graphics.drawRect(c - 43, floorY - 360, 86, 372); graphics.endFill();
                  graphics.beginFill(0xEEDCFF, .85);
                  graphics.drawRect(c - 18, floorY - 360, 36, 372); graphics.endFill();
                  graphics.beginFill(0xFFFFFF, .9);
                  graphics.drawRect(c - 4, floorY - 360, 8, 372); graphics.endFill();
               }
            }
         }
      }
   }
}
