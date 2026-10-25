package src.epilogue.battle
{
   import flash.display.Sprite;
   import flash.display.Graphics;

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

      public function BossBody(type:String)
      {
         kind = type;
         mouseEnabled = mouseChildren = false;
         addChild(frame);
         addChild(crown);
         addChild(leftNode); addChild(rightNode); addChild(core);
         leftNode.x = -132; rightNode.x = 132;
         leftNode.y = rightNode.y = -56;
         core.y = type == "warden" ? -92 : -103;
         build();
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
            g.lineStyle(6, 0xA79564);
            g.moveTo(-48, -54); g.lineTo(-111, -69); g.lineTo(-132, -56);
            g.moveTo(48, -54); g.lineTo(111, -69); g.lineTo(132, -56);
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
            g.lineStyle(4, 0xA7A0CB); g.beginFill(0x24223C);
            g.moveTo(-82, -24); g.lineTo(-96, -170); g.lineTo(-61, -208);
            g.lineTo(-39, -164); g.lineTo(39, -164); g.lineTo(61, -208);
            g.lineTo(96, -170); g.lineTo(82, -24); g.lineTo(-82, -24); g.endFill();
            g.lineStyle(2, 0x6C668F);
            for(i = -1; i <= 1; i += 2)
            {
               g.moveTo(i * 80, -150); g.lineTo(i * 52, -120); g.lineTo(i * 75, -83);
               g.moveTo(i * 72, -26); g.lineTo(i * 118, -12); g.lineTo(i * 141, -4);
            }
            g.lineStyle(9, 0x635A81);
            g.moveTo(-58, -140); g.lineTo(-118, -117); g.lineTo(-132, -56);
            g.moveTo(58, -140); g.lineTo(118, -117); g.lineTo(132, -56);
            g.lineStyle(3, 0xE1BE7A);
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
