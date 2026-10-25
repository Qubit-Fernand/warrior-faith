package src.epilogue.scene
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;

   /** Observable dock clues and three visual dials. Controller owns turns, locks and saves. */
   public class ChapterNavigation extends Sprite
   {
      private static const ANSWERS:Array = [3, 2, 1];
      private var floorY:Number;
      private var worldWidth:Number;
      private var turns:Array = [0, 0, 0];
      private var steps:int = 0;
      private var rescued:int = 0;
      private var calibrated:Boolean = false;
      private var disposed:Boolean = false;
      private var positions:Array = [520, 930, 1200];
      private var dials:Array = [];
      private var captions:Array = [];
      private var links:Sprite = new Sprite();
      private var ray:Sprite = new Sprite();

      public function ChapterNavigation(width:Number = 1600, floor:Number = 450)
      {
         worldWidth = isFinite(width) ? Math.max(320, width) : 1600;
         floorY = isFinite(floor) ? floor : 450;
         mouseEnabled = mouseChildren = false;
         name = "chapterNavigation";
         addChild(links);
         buildClues();
         for(var i:int = 0; i < 3; ++i)
         {
            var dial:Sprite = new Sprite(); dial.x = positions[i]; dial.y = floorY - 62;
            addChild(dial); dials.push(dial);
            var title:String = i == 0 ? "Ⅰ 回潮方向" : i == 1 ? "Ⅱ 运输船号" : "Ⅲ 神殿回光";
            text(title, positions[i], floorY - 137, 0xEED9A7, 14);
            var caption:TextField = text("", positions[i], floorY - 116, 0xD8D5BD, 12);
            captions.push(caption);
         }
         addChild(ray);
         redraw();
      }

      /** 0=up, 1=right, 2=down, 3=left. Dial 1 instead displays turn+1 sail stripes. */
      public static function correct(index:int, turn:int):Boolean
      {
         return index >= 0 && index < 3 && turn >= 0 && turn < 4 && turn == int(ANSWERS[index]);
      }

      /** Copies scalars and the three array entries; saved positions render immediately. */
      public function setProgress(state:Object):void
      {
         if(disposed) return;
         var source:Object = state == null ? {} : state;
         var input:Array = source.navigationTurns is Array ? source.navigationTurns as Array : [];
         turns = [];
         for(var i:int = 0; i < 3; ++i)
         {
            var value:int = i < input.length ? int(input[i]) : 0;
            turns.push(Math.max(0, Math.min(3, value)));
         }
         steps = Math.max(0, Math.min(3, int(source.navigationSteps)));
         rescued = Math.max(0, Math.min(2, int(source.rescuedGroups)));
         calibrated = Boolean(source.calibrationDone);
         redraw();
      }

      /** Only the next unlocked dial is actionable. The original compass confirms all three. */
      public function interactionPoints():Array
      {
         if(disposed || rescued < 2 || calibrated || steps >= 3) return [];
         var label:String = steps == 0 ? "转动回潮针 · 对照潮痕箭头" :
            steps == 1 ? "转动船号盘 · 对照接应船帆纹" : "转动回光镜 · 把光送往罗盘";
         return [{id:"nav" + steps, x:positions[steps], y:floorY, label:label, radius:70}];
      }

      public function dispose():void
      {
         if(disposed) return;
         disposed = true;
         while(numChildren > 0) removeChildAt(numChildren - 1);
         dials = []; captions = []; turns = [];
         links.graphics.clear(); ray.graphics.clear(); graphics.clear();
         if(parent) parent.removeChild(this);
      }

      private function buildClues():void
      {
         var g:Graphics = graphics;
         // Tide scratches and a physical arrow on a wooden pier post, visible before rescue.
         g.lineStyle(2, 0xAA9267); g.beginFill(0x514737);
         g.drawRect(421, floorY - 113, 24, 113); g.endFill();
         g.lineStyle(2, 0x92CBC5, .9);
         for(var i:int = 0; i < 4; ++i)
         {
            g.moveTo(421, floorY - 27 - i * 13); g.lineTo(445 - i * 2, floorY - 30 - i * 13);
         }
         g.lineStyle(3, 0xDFDEC1); g.moveTo(444, floorY - 94); g.lineTo(409, floorY - 94);
         g.lineTo(420, floorY - 103); g.moveTo(409, floorY - 94); g.lineTo(420, floorY - 85);
         text("潮痕向左", 420, floorY - 163, 0xD3E8D8, 12);
         // A raised signal sail above the boat remains visible even when this Sprite is in Back.
         // Painting marks directly onto the old sail would hide them behind Other-layer artwork.
         g.lineStyle(3, 0xB09A72); g.moveTo(164, floorY - 23); g.lineTo(164, floorY - 196);
         g.lineStyle(1, 0xE0D0AC); g.beginFill(0xD7C698, .95);
         g.moveTo(168, floorY - 188); g.lineTo(211, floorY - 146);
         g.lineTo(168, floorY - 146); g.lineTo(168, floorY - 188); g.endFill();
         g.lineStyle(3, 0x685742);
         for(i = 0; i < 3; ++i)
         {
            g.moveTo(172, floorY - 170 + i * 8); g.lineTo(184 + i * 6, floorY - 170 + i * 8);
         }
         text("接应船的帆纹", 178, floorY - 222, 0xE8DDBE, 12);
         // A persistent receiver outline and directional notch at the existing compass.
         g.lineStyle(2, 0xBBDFCE, .75); g.drawCircle(1380, floorY - 62, 40);
         g.moveTo(1339, floorY - 62); g.lineTo(1350, floorY - 70);
         g.moveTo(1339, floorY - 62); g.lineTo(1350, floorY - 54);
         text("把回光送入圆环", 1370, floorY - 144, 0xD5E6CF, 12);
      }

      private function redraw():void
      {
         var g:Graphics = links.graphics; g.clear();
         var lastX:Number = 435;
         for(var i:int = 0; i < 3; ++i)
         {
            var locked:Boolean = calibrated || i < steps;
            var node:Sprite = dials[i];
            var turn:int = int(turns[i]);
            drawDial(node.graphics, i, turn, locked);
            node.alpha = rescued < 2 ? .65 : 1;
            var label:String;
            if(locked) label = "✓ 已锁定";
            else if(rescued < 2) label = "先接回两组居民";
            else if(i > steps) label = "先锁定前一座航标";
            else label = i == 0 ? "E 旋转 · 看左侧潮痕" : i == 1 ? "E 旋转 · 看接应船帆纹" : "E 旋转 · 光应到达右侧圆环";
            TextField(captions[i]).text = label;
            TextField(captions[i]).textColor = locked ? 0xB4F3D3 : 0xD8D5BD;
            if(locked)
            {
               g.lineStyle(2, 0x9DE4CE, .65); g.moveTo(lastX, floorY - 8);
               g.lineTo(positions[i], floorY - 8); g.lineTo(positions[i], floorY - 30);
            }
            lastX = positions[i];
         }
         ray.graphics.clear();
         // The final receiver first sends a fine reference ray after the first two observations.
         if(steps >= 2 || calibrated)
         {
            g = ray.graphics;
            g.lineStyle(1, 0x91CDC3, .5);
            g.moveTo(1380, floorY - 62); g.lineTo(1200, floorY - 62);
            var angle:Number = (int(turns[2]) - 1) * Math.PI / 2;
            var length:Number = int(turns[2]) == 1 ? 180 : 72;
            var endX:Number = 1200 + Math.cos(angle) * length;
            var endY:Number = floorY - 62 + Math.sin(angle) * length;
            g.lineStyle(4, steps >= 3 || calibrated ? 0xD4FFE7 : 0xE0C998, .75);
            g.moveTo(1200, floorY - 62); g.lineTo(endX, endY);
            g.beginFill(0xFFF3C2, .85); g.drawCircle(endX, endY, 5); g.endFill();
            if(steps >= 3 || calibrated)
            {
               g.lineStyle(3, 0xC8FFE2, .85); g.drawCircle(1380, floorY - 62, 40);
            }
         }
      }

      private function drawDial(g:Graphics, index:int, turn:int, locked:Boolean):void
      {
         g.clear(); g.lineStyle(3, 0x9C8863); g.beginFill(0x2B4247, .9);
         g.drawRoundRect(-18, 26, 36, 36, 5, 5); g.endFill();
         g.lineStyle(3, locked ? 0xB3E8CD : 0xBEA678); g.beginFill(0x1C3037, .95);
         g.drawCircle(0, 0, 32); g.endFill();
         g.lineStyle(1, 0x8B9C8D); g.drawCircle(0, 0, 25);
         if(index == 1)
         {
            // Visible one/two/three/four stripe states map directly to the ship's sail marks.
            g.lineStyle(3, locked ? 0xCCFFE0 : 0xE4CCA1);
            for(var i:int = 0; i <= turn; ++i)
            {
               var lineY:Number = (i - turn / 2) * 8;
               g.moveTo(-14, lineY); g.lineTo(14, lineY);
            }
         }
         else
         {
            var angle:Number = (turn - 1) * Math.PI / 2;
            var dx:Number = Math.cos(angle); var dy:Number = Math.sin(angle);
            g.lineStyle(3, locked ? 0xC9FFE1 : 0xEBC891);
            g.moveTo(-dx * 15, -dy * 15); g.lineTo(dx * 23, dy * 23);
            g.lineTo(dx * 12 - dy * 7, dy * 12 + dx * 7);
            g.moveTo(dx * 23, dy * 23); g.lineTo(dx * 12 + dy * 7, dy * 12 - dx * 7);
            if(index == 2)
            {
               g.lineStyle(4, 0x8FB8D3); g.moveTo(-dy * 13, dx * 13); g.lineTo(dy * 13, -dx * 13);
            }
         }
         if(locked)
         {
            g.lineStyle(3, 0xD5FFE5); g.moveTo(22, -25); g.lineTo(27, -19); g.lineTo(37, -32);
         }
      }

      private function text(value:String, px:Number, py:Number, color:uint, size:int):TextField
      {
         var t:TextField = new TextField();
         t.defaultTextFormat = new TextFormat("_sans", size, color, true, null, null, null, null, "center");
         t.width = 230; t.height = 25; t.x = px - 115; t.y = py;
         t.text = value; t.selectable = false; t.mouseEnabled = false; addChild(t);
         return t;
      }
   }
}
