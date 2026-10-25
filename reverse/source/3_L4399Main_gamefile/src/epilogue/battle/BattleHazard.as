package src.epilogue.battle
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;

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
      private var caption:TextField = new TextField();

      public function BattleHazard(type:String, x1:Number, x2:Number, ground:Number,
                                   aim:Array, warn:Number, active:Number, dir:int = 1, power:Number = 1)
      {
         kind = type;
         left = x1; right = x2; floorY = ground;
         targets = aim.concat(); warning = warn; duration = active;
         direction = dir; strength = power;
         mouseEnabled = mouseChildren = false;
         name = "chapterHazard_" + type;
         caption.defaultTextFormat = new TextFormat("_sans", 16, 0xFFFFFF, true);
         caption.width = 260; caption.height = 26;
         caption.selectable = false; caption.mouseEnabled = false;
         addChild(caption);
         render();
      }

      public function update(dt:Number):void
      {
         elapsed += dt;
         fired = elapsed >= warning;
         finished = elapsed >= warning + duration;
         render();
      }

      /** Tracking closes at least 1.1 seconds before firing. Thereafter aim is immutable. */
      public function trackPlayer(px:Number):void
      {
         if(kind == "tracking" && tracking)
            targets[0] = Math.max(left + 55, Math.min(right - 55, px));
      }

      public function get tracking():Boolean
      {
         return kind == "tracking" && elapsed < Math.max(0, warning - 1.1);
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
         else if(kind == "sanctuary")
         {
            var safeLeft:Number = Number(targets[0]) - Number(targets[1]);
            var safeRight:Number = Number(targets[0]) + Number(targets[1]);
            var sheltered:Boolean = bounds.left >= safeLeft && bounds.right <= safeRight;
            hit = !sheltered && bounds.intersects(new Rectangle(left, floorY - 360, right - left, 372));
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
                 finished:finished, hit:hitOnce, targets:targets.concat(), direction:direction,
                 tracking:tracking, lockRemaining:kind == "tracking" ? Math.max(0, warning - elapsed) : 0,
                 safeCenter:kind == "sanctuary" ? Number(targets[0]) : null,
                 safeHalfWidth:kind == "sanctuary" ? Number(targets[1]) : null};
      }

      private function render():void
      {
         graphics.clear();
         caption.visible = false;
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
         else if(kind == "sanctuary")
         {
            var center:Number = Number(targets[0]);
            var radius:Number = Number(targets[1]);
            var dangerAlpha:Number = fired ? .68 : .08 + .1 * progress;
            graphics.lineStyle(0, 0, 0);
            graphics.beginFill(fired ? 0xB94A90 : 0x714E8E, dangerAlpha);
            graphics.drawRect(left, floorY - 360, Math.max(0, center - radius - left), 372);
            graphics.drawRect(center + radius, floorY - 360, Math.max(0, right - center - radius), 372);
            graphics.endFill();
            // The bright green region and collision exemption are exactly the same width.
            graphics.lineStyle(3, 0xB4FFE5, 1);
            graphics.beginFill(0x47B89D, fired ? .35 : .2);
            graphics.drawRect(center - radius, floorY - 180, radius * 2, 190);
            graphics.endFill();
            graphics.drawEllipse(center - radius, floorY - 14, radius * 2, 28);
            graphics.lineStyle(2, 0xCBFFE9, .8);
            graphics.moveTo(center - 16, floorY - 60); graphics.lineTo(center, floorY - 82);
            graphics.lineTo(center + 16, floorY - 60);
            caption.visible = true; caption.x = center - radius; caption.y = floorY - 208;
            caption.text = fired ? "解缚光环 · 留在其中" : "安全区 · 可躲开夺光爆发";
            if(!fired)
            {
               graphics.lineStyle(4, 0xF3BCE2, 1);
               graphics.moveTo(left, floorY - 6);
               graphics.lineTo(left + (right - left) * progress, floorY - 6);
            }
            else
            {
               graphics.lineStyle(2, 0xFFD5F1, .7);
               for(c = left + 16; c < right; c += 48)
               {
                  if(c > center - radius && c < center + radius) continue;
                  graphics.moveTo(c, floorY - 360); graphics.lineTo(c + 18, floorY);
               }
            }
         }
         else
         {
            if(kind == "tracking")
            {
               caption.visible = true;
               caption.x = Number(targets[0]) - 70; caption.y = floorY - 310;
               caption.text = fired ? "追光释放" : tracking ? "追踪中…" : "已锁定！横移！";
               graphics.lineStyle(tracking ? 2 : 4, tracking ? 0xC9A5FF : 0xFFF0C6, 1);
               graphics.drawCircle(Number(targets[0]), floorY - 110, tracking ? 25 : 34);
               graphics.moveTo(Number(targets[0]) - 42, floorY - 110);
               graphics.lineTo(Number(targets[0]) + 42, floorY - 110);
            }
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
