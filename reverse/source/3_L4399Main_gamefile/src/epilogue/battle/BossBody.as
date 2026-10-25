package src.epilogue.battle
{
   import flash.display.Sprite;
   import flash.display.Graphics;
   import flash.text.TextField;
   import flash.text.TextFormat;

   /** Original composite vector art. No EnemySkin, exported boss sprite or timeline. */
   public class BossBody extends Sprite
   {
      public var core:Sprite = new Sprite();
      public var leftNode:Sprite = new Sprite();
      public var rightNode:Sprite = new Sprite();
      private var kind:String;
      private var frame:Sprite = new Sprite();
      private var crown:Sprite = new Sprite();
      private var lenses:Array = [];
      private var legs:Array = [];
      private var flash:Number = 0;
      private var shattered:Boolean = false;
      // Decorative siblings/children of frame never participate in core/node hit bounds.
      private var detail:Sprite = new Sprite();
      private var fractures:Sprite = new Sprite();
      private var channel:Sprite = new Sprite();
      private var channelLabel:TextField = new TextField();
      private var connections:Sprite = new Sprite();
      private var nodeMeters:Sprite = new Sprite();
      private var nodeLabels:Array = [];
      private var nodeRatios:Array = [1, 1];
      private var nodeFlashes:Array = [0, 0];
      private var debris:Sprite = new Sprite();
      private var pieces:Array = [];
      private var breakEffectsDone:Array = [false, false];
      private var retirementAge:Number = 0;
      private var retirementAlpha:Number = 1;
      private var retirementCoreAlpha:Number = 1;
      private var retirementCrownAlpha:Number = 1;

      public function BossBody(type:String)
      {
         kind = type;
         mouseEnabled = mouseChildren = false;
         addChild(frame);
         addChild(connections);
         addChild(crown);
         addChild(leftNode); addChild(rightNode); addChild(core);
         leftNode.x = -132; rightNode.x = 132;
         leftNode.y = rightNode.y = -56;
         core.y = type == "warden" ? -92 : -103;
         build();
         frame.addChild(detail); frame.addChild(fractures);
         drawDetails();
         channelLabel.defaultTextFormat = new TextFormat("_sans", 13, 0xFFF0DE, true);
         channelLabel.width = 220; channelLabel.height = 24;
         channelLabel.x = -80; channelLabel.y = -266;
         channelLabel.selectable = false; channelLabel.mouseEnabled = false;
         channel.addChild(channelLabel); addChild(channel);
         channel.visible = false;
         // Sibling overlays never enlarge leftNode/rightNode's hitTestObject bounds.
         addChild(nodeMeters); addChild(debris);
         for(var index:int = 0; index < 2; ++index)
         {
            var label:TextField = new TextField();
            label.defaultTextFormat = new TextFormat("_sans", 12, 0xE2FFE7, true);
            label.width = 100; label.height = 20;
            label.selectable = false; label.mouseEnabled = false;
            nodeMeters.addChild(label); nodeLabels.push(label);
         }
         drawNodeMeters();
      }

      public function setNodeHealth(values:Array, maximum:Number):void
      {
         nodeRatios[0] = Math.max(0, Math.min(1, Number(values[0]) / Math.max(1, maximum)));
         nodeRatios[1] = Math.max(0, Math.min(1, Number(values[1]) / Math.max(1, maximum)));
         drawNodeMeters();
      }

      public function pulseNode(index:int):void
      {
         if(index >= 0 && index < 2) nodeFlashes[index] = .16;
      }

      public function breakNode(index:int):void
      {
         if(index < 0 || index > 1 || breakEffectsDone[index]) return;
         breakEffectsDone[index] = true;
         var node:Sprite = index == 0 ? leftNode : rightNode;
         for(var i:int = 0; i < 5; ++i)
         {
            var shard:Sprite = new Sprite();
            shard.graphics.beginFill(i % 2 == 0 ? 0xD1C38A : 0x9FE9CE);
            shard.graphics.moveTo(-4, -3); shard.graphics.lineTo(5, -2);
            shard.graphics.lineTo(1, 6); shard.graphics.lineTo(-4, -3); shard.graphics.endFill();
            shard.x = node.x; shard.y = node.y - 9;
            debris.addChild(shard);
            pieces.push({sprite:shard, vx:(i - 2) * 35, vy:-105 - i % 3 * 25, age:0});
         }
      }

      private function drawNodeMeters():void
      {
         var g:Graphics = nodeMeters.graphics;
         var wire:Graphics = connections.graphics;
         g.clear(); wire.clear();
         for(var i:int = 0; i < 2; ++i)
         {
            var node:Sprite = i == 0 ? leftNode : rightNode;
            var ratio:Number = Number(nodeRatios[i]);
            var alive:Boolean = ratio > 0;
            var label:TextField = nodeLabels[i] as TextField;
            label.x = node.x - 37; label.y = -135;
            label.text = alive ? "供能 " + Math.ceil(ratio * 100) + "%" : "已切断";
            if(alive)
            {
               g.lineStyle(1, 0xDCEEC5, .9); g.beginFill(0x132329, .96);
               g.drawRect(node.x - 33, -114, 66, 8); g.endFill();
               g.lineStyle(0, 0, 0); g.beginFill(ratio < .3 ? 0xF3B276 : 0xA6F2C9);
               g.drawRect(node.x - 32, -113, 64 * ratio, 6); g.endFill();
            }
            var side:Number = i == 0 ? -1 : 1;
            wire.lineStyle(alive ? 3 : 2, alive ? 0xA9F2CD : 0x4A525B, alive ? .95 : .5);
            if(kind == "warden")
            {
               wire.moveTo(side * 48, -54);
               wire.lineTo(side * (alive ? 111 : 80), alive ? -69 : -48);
               if(alive) wire.lineTo(side * 132, -56);
            }
            else
            {
               wire.moveTo(side * 58, -140);
               wire.lineTo(side * (alive ? 118 : 87), alive ? -117 : -111);
               if(alive) wire.lineTo(side * 132, -56);
            }
         }
      }

      private function updateDebris(dt:Number):void
      {
         for(var i:int = pieces.length - 1; i >= 0; --i)
         {
            var p:Object = pieces[i];
            p.age += dt; p.vy += dt * 250;
            p.sprite.x += p.vx * dt; p.sprite.y += p.vy * dt;
            p.sprite.rotation += dt * 160;
            p.sprite.alpha = Math.max(0, 1 - Number(p.age) / .9);
            if(p.age >= .9)
            {
               if(p.sprite.parent) p.sprite.parent.removeChild(p.sprite);
               pieces.splice(i, 1);
            }
         }
      }

      public function setChanneling(progress:Number, interruption:Number):void
      {
         channel.visible = kind == "regent" && progress >= 0;
         if(!channel.visible) return;
         progress = Math.max(0, Math.min(1, progress));
         interruption = Math.max(0, Math.min(1, interruption));
         var g:Graphics = channel.graphics;
         g.clear();
         g.lineStyle(2 + progress * 3, 0xE6A7E0, .45 + progress * .4);
         if(nodeRatios[0] > 0) { g.moveTo(-132, -56); g.lineTo(-48, -117); }
         else g.moveTo(-68, -169);
         g.lineTo(0, -103);
         if(nodeRatios[1] > 0) { g.moveTo(132, -56); g.lineTo(48, -117); }
         else g.moveTo(68, -169);
         g.lineTo(0, -103);
         g.drawCircle(0, -103, 45 + progress * 18);
         g.lineStyle(0, 0, 0); g.beginFill(0x101E2B, .95);
         g.drawRect(-80, -243, 160, 17); g.endFill();
         g.beginFill(0xDFA0DF, .95); g.drawRect(-78, -241, 156 * progress, 5); g.endFill();
         g.beginFill(0xA3F7D4, 1); g.drawRect(-78, -233, 156 * interruption, 5); g.endFill();
         channelLabel.text = "聚光 " + Math.round(progress * 100) + "% · 打断 " + Math.round(interruption * 100) + "%";
      }

      /** Hide transient battle UI immediately so victory dialogue has no stale overlay. */
      public function beginRetirement():void
      {
         retirementAge = 0;
         retirementAlpha = alpha;
         retirementCoreAlpha = core.alpha;
         retirementCrownAlpha = crown.alpha;
         channel.visible = false;
         channel.graphics.clear();
         nodeMeters.visible = false;
         connections.visible = false;
         while(debris.numChildren > 0) debris.removeChildAt(0);
         pieces = [];
         flash = 0; nodeFlashes = [0, 0];
         leftNode.alpha = rightNode.alpha = 1;
      }

      /** Returns true after one visual second. Never mutates node/core geometry or game state. */
      public function retireVisual(dt:Number):Boolean
      {
         retirementAge = Math.min(1, retirementAge + Math.max(0, dt));
         // Smoothly extinguish the powered parts; retain the identifiable ruined machine.
         var p:Number = retirementAge * retirementAge * (3 - 2 * retirementAge);
         alpha = retirementAlpha + (.42 - retirementAlpha) * p;
         core.alpha = retirementCoreAlpha + (.12 - retirementCoreAlpha) * p;
         crown.alpha = retirementCrownAlpha + (.3 - retirementCrownAlpha) * p;
         return retirementAge >= 1;
      }

      public function pulse():void { flash = .15; }

      private function build():void
      {
         var g:Graphics = frame.graphics;
         var s:Sprite;
         var i:int;
         if(kind == "warden")
         {
            g.lineStyle(5, 0xC9A864); g.beginFill(0x203D44);
            g.drawEllipse(-84, -66, 168, 57); g.endFill();
            g.lineStyle(2, 0x6C8F8C);
            g.drawEllipse(-69, -59, 138, 34);
            for(i = -1; i <= 1; ++i)
            {
               s = new Sprite();
               s.x = i * 52; s.y = -35;
               s.graphics.lineStyle(11, 0x18282F);
               s.graphics.moveTo(0, 0); s.graphics.lineTo(i * 23, 18);
               s.graphics.lineTo(i * 35 + (i == 0 ? 12 : 0), 34);
               s.graphics.lineStyle(4, 0xB49A61);
               s.graphics.moveTo(0, 0); s.graphics.lineTo(i * 23, 18);
               s.graphics.lineTo(i * 35 + (i == 0 ? 12 : 0), 34);
               s.graphics.beginFill(0xD8BF7C); s.graphics.drawCircle(0, 0, 6); s.graphics.endFill();
               frame.addChild(s); legs.push(s);
            }
            crown.graphics.lineStyle(3, 0xD5C48C);
            crown.graphics.drawEllipse(-52, -136, 104, 30);
            crown.graphics.moveTo(-38, -120); crown.graphics.lineTo(-25, -62);
            crown.graphics.moveTo(38, -120); crown.graphics.lineTo(25, -62);
            for(i = -1; i <= 1; i += 2)
            {
               s = new Sprite(); s.x = i * 43; s.y = -90;
               s.graphics.lineStyle(3, 0xC8B47D);
               s.graphics.beginFill(0x4D9899, .7);
               s.graphics.moveTo(0, -36); s.graphics.lineTo(i * 22, -17);
               s.graphics.lineTo(i * 22, 24); s.graphics.lineTo(0, 38);
               s.graphics.lineTo(0, -36); s.graphics.endFill();
               addChild(s); lenses.push(s);
            }
         }
         else
         {
            // Separate buttresses and seat leave the captive readable in the opening.
            g.lineStyle(3, 0x82748D); g.beginFill(0x211E30);
            g.moveTo(-82, -24); g.lineTo(-96, -170); g.lineTo(-61, -208);
            g.lineTo(-43, -166); g.lineTo(-49, -65); g.lineTo(-30, -24);
            g.lineTo(-82, -24); g.endFill();
            g.moveTo(82, -24); g.lineTo(96, -170); g.lineTo(61, -208);
            g.lineTo(43, -166); g.lineTo(49, -65); g.lineTo(30, -24);
            g.lineTo(82, -24); g.endFill();
            g.lineStyle(2, 0x87734F); g.beginFill(0x171E29);
            g.moveTo(-87, -31); g.lineTo(87, -31); g.lineTo(100, -10);
            g.lineTo(-100, -10); g.lineTo(-87, -31); g.endFill();
            g.lineStyle(2, 0x6C668F);
            for(i = -1; i <= 1; i += 2)
            {
               g.moveTo(i * 80, -150); g.lineTo(i * 52, -120); g.lineTo(i * 75, -83);
               g.moveTo(i * 72, -26); g.lineTo(i * 118, -12); g.lineTo(i * 141, -4);
            }
            g.lineStyle(9, 0x635A81);
            g.moveTo(-58, -140); g.lineTo(-118, -117); g.lineTo(-132, -56);
            g.moveTo(58, -140); g.lineTo(118, -117); g.lineTo(132, -56);
            crown.y = -169;
            crown.graphics.lineStyle(7, 0xD3B76E);
            crown.graphics.drawCircle(0, 0, 68);
            crown.graphics.lineStyle(1, 0xFFF0B2);
            crown.graphics.drawCircle(0, 0, 78);
            for(i = 0; i < 8; ++i)
            {
               var a:Number = i * Math.PI / 4;
               crown.graphics.moveTo(Math.cos(a) * 82, Math.sin(a) * 82);
               crown.graphics.lineTo(Math.cos(a) * 95, Math.sin(a) * 95);
            }
            // Captive human silhouette inside a unique throne, not an old boss skin.
            g.lineStyle(0, 0, 0); g.beginFill(0x101526);
            g.drawCircle(0, -146, 12); g.drawEllipse(-17, -133, 34, 72);
            g.endFill();
         }
         drawCore(false);
         drawNode(leftNode, false); drawNode(rightNode, false);
      }

      private function rivet(g:Graphics, x:Number, y:Number, bright:Boolean = false):void
      {
         g.lineStyle(1, 0x1A2229, .9); g.beginFill(bright ? 0xD3BC83 : 0x827359);
         g.drawCircle(x, y, 2.5); g.endFill();
         g.lineStyle(1, 0xF1DFC0, .65); g.moveTo(x - 1, y - 1); g.lineTo(x + 1, y - 1);
      }

      private function drawDetails():void
      {
         var g:Graphics = detail.graphics;
         var c:Graphics = crown.graphics;
         var side:int;
         var i:int;
         var angle:Number;
         g.clear();
         if(kind == "warden")
         {
            // Recessed brass drum: narrow bands and vents break the flat teal hull.
            g.lineStyle(2, 0xD4B475, .8);
            g.moveTo(-71, -48); g.curveTo(0, -17, 71, -48);
            g.lineStyle(1, 0x0D242A, .9);
            g.moveTo(-64, -40); g.curveTo(0, -11, 64, -40);
            for(i = -3; i <= 3; ++i)
            {
               g.lineStyle(3, 0x0E262B); g.moveTo(i * 16, -40); g.lineTo(i * 14, -26);
               rivet(g, i * 20, -49 + Math.abs(i) * 2, i % 2 == 0);
            }
            for(side = -1; side <= 1; side += 2)
            {
               g.lineStyle(2, 0x655B43); g.beginFill(0x112B33, .9);
               g.moveTo(side * 39, -67); g.lineTo(side * 55, -82);
               g.lineTo(side * 75, -62); g.lineTo(side * 59, -44);
               g.lineTo(side * 39, -67); g.endFill();
               g.lineStyle(1, 0xC2A56C, .9);
               g.moveTo(side * 49, -67); g.lineTo(side * 57, -74); g.lineTo(side * 66, -61);
               rivet(g, side * 61, -51, true);
               // Lens ribs and glints share each decorative lens's existing rotation.
               var lens:Sprite = lenses[side < 0 ? 0 : 1] as Sprite;
               var l:Graphics = lens.graphics;
               l.lineStyle(1, 0x1B4B55, .8);
               l.moveTo(side * 7, -27); l.lineTo(side * 7, 29);
               l.moveTo(side * 15, -22); l.lineTo(side * 15, 26);
               l.lineStyle(2, 0xD1F8E8, .75);
               l.moveTo(side * 5, -22); l.lineTo(side * 17, -12);
               l.lineStyle(1, 0xD1F8E8, .45);
               l.moveTo(side * 5, 3); l.lineTo(side * 16, 13);
            }
            c.lineStyle(1, 0xEEE0AB, .65); c.drawEllipse(-46, -133, 92, 21);
            c.lineStyle(2, 0x6A765F); c.moveTo(0, -139); c.lineTo(0, -151);
            c.beginFill(0xDDCC91); c.drawCircle(0, -151, 3); c.endFill();
         }
         else
         {
            for(side = -1; side <= 1; side += 2)
            {
               // Faceted stone-metal ribs around an open central silhouette.
               g.lineStyle(1, 0xAA9475, .75); g.beginFill(0x3A3144, .85);
               g.moveTo(side * 61, -198); g.lineTo(side * 86, -166);
               g.lineTo(side * 74, -65); g.lineTo(side * 55, -42);
               g.lineTo(side * 60, -158); g.lineTo(side * 61, -198); g.endFill();
               g.lineStyle(1, 0xD1BA8B, .55);
               g.moveTo(side * 65, -185); g.lineTo(side * 77, -163); g.lineTo(side * 66, -84);
               for(i = 0; i < 4; ++i) rivet(g, side * (77 - i * 3), -151 + i * 27, i == 0);
               g.lineStyle(2, 0xB08D60, .8);
               g.moveTo(side * 56, -141); g.lineTo(side * 112, -117);
               g.lineStyle(1, 0xE1CEA0, .6);
               g.moveTo(side * 67, -139); g.lineTo(side * 108, -121);
               rivet(g, side * 111, -116, true);
               // Linked cuff, chain, and fingers belong to the throne, not a reused boss.
               g.lineStyle(2, 0x706C7E, .9);
               g.moveTo(side * 13, -130); g.lineTo(side * 32, -105); g.lineTo(side * 43, -72);
               for(i = 0; i < 4; ++i) g.drawEllipse(side * (38 + i * 7) - 3, -89 - i * 5, 6, 9);
               g.lineStyle(1, 0xB2A49A, .7);
               g.moveTo(side * 42, -75); g.lineTo(side * 47, -66);
               g.moveTo(side * 39, -73); g.lineTo(side * 42, -64);
            }
            // A hood, shoulder planes, and a narrow face replace the featureless dot.
            g.lineStyle(1, 0x716B81); g.beginFill(0x101520);
            g.moveTo(0, -165); g.lineTo(15, -149); g.lineTo(12, -130);
            g.lineTo(23, -113); g.lineTo(-23, -113); g.lineTo(-12, -130);
            g.lineTo(-15, -149); g.lineTo(0, -165); g.endFill();
            g.lineStyle(1, 0xB5A899, .8); g.moveTo(-5, -149); g.lineTo(0, -138); g.lineTo(5, -149);
            g.lineStyle(1, 0xDED6BD, .85); g.moveTo(-7, -148); g.lineTo(-3, -147);
            g.moveTo(3, -147); g.lineTo(7, -148);
            g.lineStyle(1, 0xB69865, .7);
            g.moveTo(-74, -24); g.lineTo(74, -24);
            for(i = -3; i <= 3; ++i) rivet(g, i * 22, -17, i == 0);
            c.lineStyle(1, 0x8C784E, .9); c.drawCircle(0, 0, 60);
            c.lineStyle(1, 0xF3DCA3, .65); c.drawCircle(0, 0, 72);
            for(i = 0; i < 24; ++i)
            {
               angle = i * Math.PI / 12;
               c.lineStyle(i % 3 == 0 ? 2 : 1, 0xC8B178, i % 3 == 0 ? .9 : .5);
               c.moveTo(Math.cos(angle) * 61, Math.sin(angle) * 61);
               c.lineTo(Math.cos(angle) * (i % 3 == 0 ? 74 : 66), Math.sin(angle) * (i % 3 == 0 ? 74 : 66));
            }
         }
      }

      private function drawFractures():void
      {
         var g:Graphics = fractures.graphics;
         for(var side:int = -1; side <= 1; side += 2)
         {
            g.lineStyle(4, 0x0B1421, .95);
            g.moveTo(side * 67, -192); g.lineTo(side * 57, -161);
            g.lineTo(side * 73, -137); g.lineTo(side * 58, -101); g.lineTo(side * 70, -55);
            g.lineStyle(1, 0xD2B5D9, .8);
            g.moveTo(side * 66, -191); g.lineTo(side * 56, -161);
            g.lineTo(side * 72, -137); g.lineTo(side * 57, -101);
            g.moveTo(side * 72, -137); g.lineTo(side * 85, -128);
         }
      }

      private function drawCore(open:Boolean):void
      {
         var g:Graphics = core.graphics;
         g.clear();
         g.lineStyle(2, 0xD4C791);
         g.beginFill(kind == "warden" ? 0x77D5C3 : 0xD6ADFF, .18);
         g.drawEllipse(-39, -45, 78, 90); g.endFill();
         g.lineStyle(3, open ? 0xFFF2B6 : 0xB3A177);
         g.beginFill(kind == "warden" ? 0xBBF8DC : 0xEAD5FF, .85);
         g.moveTo(0, -38); g.lineTo(24, -5); g.lineTo(0, 33);
         g.lineTo(-24, -5); g.lineTo(0, -38); g.endFill();
         g.beginFill(0xFFFFFF, .9); g.drawEllipse(-6, -20, 12, 31); g.endFill();
      }

      private function drawNode(node:Sprite, broken:Boolean):void
      {
         var g:Graphics = node.graphics;
         g.clear();
         g.lineStyle(3, broken ? 0x57566B : 0xC6B079);
         g.beginFill(broken ? 0x292C39 : 0x223D46);
         g.moveTo(-22, 19); g.lineTo(-18, -22); g.lineTo(0, -35);
         g.lineTo(18, -22); g.lineTo(22, 19); g.lineTo(-22, 19); g.endFill();
         if(!broken)
         {
            g.lineStyle(2, 0xD9FFD9); g.beginFill(0x8EE6C9, .8);
            g.drawEllipse(-11, -21, 22, 32); g.endFill();
         }
         else
         {
            g.lineStyle(2, 0xA08483);
            g.moveTo(-12, -15); g.lineTo(5, -4); g.lineTo(-3, 14);
         }
      }

      public function animate(time:Number, dt:Number, phase:int, state:String, nodes:Array):void
      {
         flash = Math.max(0, flash - dt);
         nodeFlashes[0] = Math.max(0, Number(nodeFlashes[0]) - dt);
         nodeFlashes[1] = Math.max(0, Number(nodeFlashes[1]) - dt);
         leftNode.alpha = Number(nodeFlashes[0]) > 0 ? .3 : 1;
         rightNode.alpha = Number(nodeFlashes[1]) > 0 ? .3 : 1;
         updateDebris(dt);
         drawNodeMeters();
         alpha = state == "defeated" ? Math.max(.25, alpha - dt * .5) : 1;
         core.alpha = flash > 0 ? .25 : .8 + Math.sin(time * 3) * .2;
         var open:Boolean = !nodes[0] && !nodes[1];
         drawCore(open);
         drawNode(leftNode, !nodes[0]); drawNode(rightNode, !nodes[1]);
         leftNode.y = nodes[0] ? -56 : -18;
         rightNode.y = nodes[1] ? -56 : -18;
         leftNode.rotation = nodes[0] ? Math.sin(time * 2) * 5 : -35;
         rightNode.rotation = nodes[1] ? -Math.sin(time * 2) * 5 : 35;
         var i:int;
         if(kind == "warden")
         {
            for(i = 0; i < lenses.length; ++i)
               Sprite(lenses[i]).rotation = (i == 0 ? -1 : 1) * (open ? 35 : 5 + Math.sin(time * 2) * 4);
            for(i = 0; i < legs.length; ++i)
               Sprite(legs[i]).rotation = Math.sin(time * 2.7 + i * 2) * (state == "telegraph" ? 8 : 3);
            crown.y = Math.sin(time * 2) * 3;
         }
         else
         {
            if(phase == 2 && !shattered)
            {
               shattered = true;
               drawFractures();
               detail.alpha = .8;
               crown.graphics.clear();
               for(i = 0; i < 8; ++i)
               {
                  var a:Number = i * Math.PI / 4;
                  crown.graphics.lineStyle(5, 0xD3B76E, .9);
                  crown.graphics.moveTo(Math.cos(a - .21) * 71, Math.sin(a - .21) * 71);
                  crown.graphics.lineTo(Math.cos(a) * 84, Math.sin(a) * 84);
                  crown.graphics.lineTo(Math.cos(a + .21) * 71, Math.sin(a + .21) * 71);
                  crown.graphics.lineStyle(2, 0xEFE0FA, .7);
                  crown.graphics.moveTo(Math.cos(a) * 91, Math.sin(a) * 91);
                  crown.graphics.lineTo(Math.cos(a) * 107, Math.sin(a) * 107);
                  crown.graphics.lineStyle(1, 0x64516E, .9);
                  crown.graphics.moveTo(Math.cos(a - .13) * 75, Math.sin(a - .13) * 75);
                  crown.graphics.lineTo(Math.cos(a) * 81, Math.sin(a) * 81);
               }
            }
            crown.rotation += dt * (phase == 2 ? 25 : 6);
            crown.scaleX = crown.scaleY = phase == 2 ? 1.3 : 1;
            crown.alpha = phase == 2 ? .55 + Math.sin(time * 5) * .2 : .9;
            frame.rotation = phase == 2 ? Math.sin(time * 1.2) * 4 : 0;
            core.y = -103 + Math.sin(time * 2.5) * (phase == 2 ? 11 : 4);
         }
      }
   }
}
