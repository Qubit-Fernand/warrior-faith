package src.epilogue.scene
{
   import flash.display.Graphics;
   import flash.display.GradientType;
   import flash.geom.Matrix;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;

   /** Decorative world-space scenery. No collision, input, player or persistence writes. */
   public class ChapterScenery extends Sprite
   {
      private var sceneName:String;
      private var worldWidth:Number;
      private var floorY:Number;
      private var progress:Object = {};
      private var initialized:Boolean = false;
      private var disposed:Boolean = false;
      private var elapsed:Number = 0;
      private var bridge:Sprite;
      private var chain:Sprite;
      private var compass:Sprite;
      private var needle:Sprite;
      private var boat:Sprite;
      private var beacon:Sprite;
      private var release:Sprite;
      private var wreck:Sprite;
      private var routeMarker:Sprite;
      private var dockRoute:Sprite;
      private var ritualLinks:Sprite;
      private var ritualNodes:Array = [];
      private var prisoners:Array = [];
      private var gates:Array = [];
      private var glows:Array = [];
      private var labels:Array = [];
      private var villageWindows:Array = [];
      private var villagePeople:Array = [];
      private var endingSequence:String = "";
      private var endingSequencePlayed:String = "";
      private var endingSequenceTime:Number = 0;
      private var endingSequenceLayer:Sprite;
      private static const ENDING_SEQUENCE_DURATION:Number = 2.3;

      public function ChapterScenery(scene:String, width:Number = 1600, groundY:Number = 450)
      {
         sceneName = scene;
         worldWidth = isFinite(width) ? Math.max(320, width) : 1600;
         floorY = isFinite(groundY) ? groundY : 450;
         name = "chapterScenery_" + sceneName;
         mouseEnabled = mouseChildren = false;
         build();
         refreshVisuals();
      }

      /** Copies the supported fields. First load snaps to saved positions, later changes animate. */
      public function setProgress(state:Object):void
      {
         if(disposed) return;
         var source:Object = state == null ? {} : state;
         var count:Number = Number(source.rescuedGroups);
         progress = {
            bridgeOpen:Boolean(source.bridgeOpen),
            dockRelays:int(source.dockRelays) & 3,
            rescuedGroups:isFinite(count) ? Math.max(0, Math.min(2, int(count))) : 0,
            calibrationDone:Boolean(source.calibrationDone),
            beaconPrepared:Boolean(source.beaconPrepared),
            releasePrepared:Boolean(source.releasePrepared),
            boss1Defeated:Boolean(source.boss1Defeated),
            boss2Defeated:Boolean(source.boss2Defeated),
            ending:source.ending == null ? "" : String(source.ending),
            endingChoice:source.endingChoice == null ? "" : String(source.endingChoice),
            endingNodes:Math.max(0, Math.min(3, int(source.endingNodes)))
         };
         refreshVisuals();
         if(!initialized)
         {
            settle();
            initialized = true;
         }
      }

      /** Action completion excludes decorative flames, boat bobbing and an uncalibrated needle. */
      public function get animating():Boolean
      {
         if(disposed) return false;
         if(endingSequence != "") return true;
         if(bridge && Math.abs(bridge.rotation - (progress.bridgeOpen ? 0 : -72)) > .8) return true;
         if(needle && progress.calibrationDone && Math.abs(needle.rotation - 35) > .8) return true;
         for each(var resident:Object in prisoners)
            if(Math.abs(resident.node.x - resident.targetX) > .8 || Math.abs(resident.node.y - resident.targetY) > .8) return true;
         return false;
      }

      /** Skip animation or restore a checkpoint into the identical action endpoint. */
      public function settle():void
      {
         if(disposed) return;
         finishEndingSequence();
         if(bridge) bridge.rotation = progress.bridgeOpen ? 0 : -72;
         if(needle) needle.rotation = progress.calibrationDone ? 35 : -35;
         for each(var resident:Object in prisoners)
         {
            resident.node.x = resident.targetX;
            resident.node.y = resident.targetY;
            resident.node.rotation = 0;
            resident.node.scaleX = resident.baseScale;
            animatePerson(resident.node as Sprite, false, 0);
         }
      }

      /** Seconds, driven by Controller. Call only while world animation is allowed. */
      public function update(dt:Number):void
      {
         if(disposed || !isFinite(dt) || dt <= 0) return;
         dt = Math.min(dt, .1);
         elapsed += dt;
         if(endingSequence != "")
         {
            endingSequenceTime += dt;
            if(endingSequenceTime >= ENDING_SEQUENCE_DURATION)finishEndingSequence();
            else drawEndingSequence();
         }
         var ease:Number = Math.min(1, dt * 3.8);
         if(bridge) bridge.rotation += ((progress.bridgeOpen ? 0 : -72) - bridge.rotation) * ease;
         if(needle)
         {
            var target:Number = progress.calibrationDone ? 35 : -35 + Math.sin(elapsed * 1.1) * 14;
            needle.rotation += (target - needle.rotation) * ease;
         }
         if(boat) boat.y = floorY + 7 + Math.sin(elapsed * 1.6) * 2;
         for each(var person:Object in prisoners)
         {
            var node:Sprite = person.node as Sprite;
            var delta:Number = person.targetX - node.x;
            var step:Number = Math.min(Math.abs(delta), 105 * dt);
            node.x += delta < 0 ? -step : step;
            var moving:Boolean = Math.abs(delta) > 1;
            node.y += (person.targetY - node.y) * ease;
            node.rotation = moving ? Math.sin(elapsed * 11 + person.phase) * 3 : 0;
            // Feet remain at the same ground line; rescued residents visibly walk to the boat.
            node.scaleX = (moving && delta < 0 ? -1 : 1) * person.baseScale;
            animatePerson(node, moving, elapsed * (moving ? 8 : 1.8) + person.phase);
         }
         for(var residentIndex:int = 0; residentIndex < villagePeople.length; ++residentIndex)
            animatePerson(villagePeople[residentIndex] as Sprite, false, elapsed * 1.8 + residentIndex * 1.7);
         for each(var glow:Object in glows)
         {
            glow.node.alpha = glow.active ? .65 + Math.sin(elapsed * 2 + glow.phase) * .16 : .08;
            glow.node.scaleX = glow.node.scaleY = glow.active ? 1 + Math.sin(elapsed * 1.5 + glow.phase) * .04 : 1;
         }
         for(var i:int = 0; i < villageWindows.length; ++i)
         {
            // Window flames are independent, so the release village reads as many human lights.
            Sprite(villageWindows[i]).alpha = .75 + Math.sin(elapsed * 2.3 + i * 1.9) * .12;
         }
      }

      /** Fresh objects in world coordinates; all interaction/input belongs to Controller. */
      public function interactionPoints():Array
      {
         if(disposed) return [];
         if(sceneName == "dock") return [
            point("bridge", progress.bridgeOpen ? "渡桥已放下" : "攻击铜色桥锁", 300),
            point("group1", progress.rescuedGroups >= 1 ? "居民已经获救" : (int(progress.dockRelays) & 1) != 0 ? "通路安全 · 解救居民" : "先攻击扫波继电器", 620),
            point("group2", progress.rescuedGroups >= 2 ? "居民已经获救" : (int(progress.dockRelays) & 2) != 0 ? "通路安全 · 解救居民" : "先攻击光锚继电器", 1080),
            point("compass", progress.calibrationDone ? "航路已经校准" : "校准罗盘", 1380),
            point("exit", "沿航路前进", 1510)
         ];
         if(sceneName == "warden" && progress.boss1Defeated) return [
            point("beacon", progress.beaconPrepared ? "归航灯塔已准备" : "检查归航灯塔", 250),
            point("release", progress.releasePrepared ? "解缚环已准备" : "检查解缚环", 1150),
            point("exit", "前往王座", 1450)
         ];
         if(sceneName == "regent" && progress.boss2Defeated)
         {
            var points:Array = [point("beacon", "长明之约 · 共同守灯", 350),
               point("release", "万家之火 · 解除束缚", 1100),
               point("return_warden", "返回司灯遗址", 1400)];
            if((progress.endingChoice == "beacon" || progress.endingChoice == "release") && progress.ending == "")
            {
               var xs:Array = [520, 800, 1050];
               for(var i:int = 0; i < 3; ++i)
               {
                  var action:String = progress.endingChoice == "beacon" ? "点亮守望节点" : "解除束缚节点";
                  points.push(point("ritual" + (i + 1), int(progress.endingNodes) > i ? "节点已完成" : action + " " + (i + 1), xs[i]));
               }
            }
            return points;
         }
         if(sceneName == "village_beacon") return [point("post", "与守灯的人交谈", 700)];
         if(sceneName == "village_release") return [point("post", "与归来的居民交谈", 700)];
         return [];
      }

      public function dispose():void
      {
         if(disposed) return;
         disposed = true;
         while(numChildren > 0) removeChildAt(numChildren - 1);
         prisoners = []; gates = []; glows = []; labels = [];
         villageWindows = []; villagePeople = []; ritualNodes = [];
         endingSequence="";endingSequencePlayed="";endingSequenceLayer=null;
         bridge = chain = compass = needle = boat = beacon = release = wreck = routeMarker = ritualLinks = dockRoute = null;
         graphics.clear();
         if(parent) parent.removeChild(this);
      }

      private function point(id:String, label:String, px:Number):Object
      {
         return {id:id, label:label, x:px, y:floorY, radius:90};
      }

      private function build():void
      {
         if(sceneName == "dock") buildDock();
         else if(sceneName == "warden" || sceneName == "regent") buildSanctum();
         else if(sceneName == "village_beacon" || sceneName == "village_release") buildVillage();
      }

      private function buildDock():void
      {
         var g:Graphics = graphics;
         // Only a narrow pier strip: the native map and sky remain visible.
         g.lineStyle(2, 0x705340); g.beginFill(0x372F2B, .8);
         g.drawRect(30, floorY, worldWidth - 60, 12); g.endFill();
         for(var x0:Number = 35; x0 < worldWidth - 25; x0 += 65)
         {
            g.lineStyle(1, 0xA08762, .65); g.moveTo(x0, floorY + 1); g.lineTo(x0, floorY + 10);
            if(int(x0) % 2 == 1)
            {
               g.lineStyle(8, 0x4F3D32); g.moveTo(x0, floorY + 8); g.lineTo(x0, floorY + 42);
            }
         }
         dockRoute = new Sprite(); addChild(dockRoute);
         boat = new Sprite(); boat.x = 100; boat.y = floorY + 7; addChild(boat);
         drawBoat(boat.graphics);
         bridge = new Sprite(); bridge.x = 210; bridge.y = floorY - 3; addChild(bridge);
         g = bridge.graphics; g.lineStyle(3, 0xB59868); g.beginFill(0x5B4632);
         g.drawRect(0, -7, 180, 10); g.endFill();
         for(var i:int = 0; i < 12; ++i)
         {
            g.moveTo(i * 15, -7); g.lineTo(i * 15, 3);
         }
         bridge.rotation = -72;
         // The hittable padlock at x300 belongs to ChapterDockEncounter. This is its bridge chain.
         chain = new Sprite(); chain.x = 225; chain.y = floorY - 100; addChild(chain);
         drawChain(chain.graphics, false);
         buildPrison(620, 0); buildPrison(1080, 1);
         compass = new Sprite(); compass.x = 1380; compass.y = floorY - 60; addChild(compass);
         g = compass.graphics; g.lineStyle(4, 0xA88E55); g.beginFill(0x202F36);
         g.drawCircle(0, 0, 33); g.endFill(); g.lineStyle(1, 0xD3BB77); g.drawCircle(0, 0, 26);
         for(i = 0; i < 8; ++i)
         {
            var a:Number = i * Math.PI / 4;
            g.moveTo(Math.cos(a) * 21, Math.sin(a) * 21); g.lineTo(Math.cos(a) * 29, Math.sin(a) * 29);
         }
         g.lineStyle(5, 0x786B53); g.moveTo(0, 34); g.lineTo(0, 60);
         needle = new Sprite(); compass.addChild(needle);
         g = needle.graphics; g.lineStyle(1, 0xE9D79A); g.beginFill(0x79DBCE);
         g.moveTo(0, -23); g.lineTo(7, 11); g.lineTo(0, 6); g.lineTo(-7, 11); g.lineTo(0, -23); g.endFill();
         sign("旧罗盘 · 航标台", 1380, floorY - 112);
         direction(1510, "航路");
      }

      private function buildPrison(px:Number, index:int):void
      {
         // Keep residents beside the relay silhouette, not hidden under its attackable core.
         px += 85;
         var post:Sprite = new Sprite(); post.x = px; post.y = floorY; addChild(post);
         var g:Graphics = post.graphics;
         g.lineStyle(8, 0x544B40); g.moveTo(-65, 0); g.lineTo(-65, -90); g.lineTo(65, -90); g.lineTo(65, 0);
         g.lineStyle(2, 0xAE956A); g.moveTo(-65, -84); g.lineTo(65, -84);
         for(var i:int = 0; i < 3; ++i)
         {
            var p:Sprite = person(index == 0 ? 0x87B4A8 : 0xBC9183, i == 1, i + index);
            p.x = px + (i - 1) * 25; p.y = floorY; addChild(p);
            prisoners.push({node:p, group:index, homeX:p.x, targetX:p.x, targetY:floorY, baseScale:p.scaleX, phase:i * 2 + index});
         }
         var gate:Sprite = new Sprite(); gate.x = px; gate.y = floorY; addChild(gate);
         g = gate.graphics; g.lineStyle(3, 0x778087);
         for(i = -2; i <= 2; ++i) { g.moveTo(i * 22, 0); g.lineTo(i * 22, -82); }
         g.moveTo(-60, -58); g.lineTo(60, -58); g.moveTo(-60, -17); g.lineTo(60, -17);
         gates.push(gate);
         sign(index == 0 ? "第一处关押点" : "第二处关押点", px, floorY - 159, "dockGroup" + (index + 1));
      }

      private function buildSanctum():void
      {
         var after:Boolean = sceneName == "regent";
         beacon = makeBeacon(after ? 350 : 250); release = makeRelease(after ? 1100 : 1150);
         wreck = new Sprite(); wreck.x = worldWidth * .52; wreck.y = floorY; addChild(wreck);
         var g:Graphics = wreck.graphics;
         g.lineStyle(4, after ? 0x8E83A5 : 0x819491);
         g.beginFill(after ? 0x3D354D : 0x34484C, .85);
         g.moveTo(-100, 0); g.lineTo(-77, -37); g.lineTo(-39, -13); g.lineTo(-12, -48);
         g.lineTo(38, -12); g.lineTo(81, -28); g.lineTo(110, 0); g.lineTo(-100, 0); g.endFill();
         g.lineStyle(5, 0xB69F68); g.moveTo(-130, -4); g.lineTo(-156, -28); g.lineTo(-192, -15);
         g.moveTo(120, -4); g.lineTo(152, -32); g.lineTo(184, -8);
         g.lineStyle(3, 0xC6B47A); g.drawEllipse(-54, -28, 95, 24);
         g.lineStyle(3, 0x27343C); g.moveTo(-18, -28); g.lineTo(3, -16); g.lineTo(-8, -6);
         routeMarker = direction(after ? 1400 : 1450, after ? "返回司灯" : "王座", "route");
         if(after)
         {
            ritualLinks = new Sprite(); addChild(ritualLinks);
            var xs:Array = [520, 800, 1050];
            for(var i:int = 0; i < 3; ++i)
            {
               var node:Sprite = new Sprite(); node.x = xs[i]; node.y = floorY; addChild(node);
               ritualNodes.push(node);
            }
         }
      }

      private function buildVillage():void
      {
         var isBeacon:Boolean = sceneName == "village_beacon";
         if(isBeacon) beacon = makeBeacon(450);
         else
         {
            // A quiet, unlit memorial, accompanied by many warm human-scale lights.
            var statue:Sprite = new Sprite(); statue.x = 450; statue.y = floorY; addChild(statue);
            var g:Graphics = statue.graphics;
            g.beginFill(0x16222A,.25);g.drawEllipse(-43,-6,86,13);g.endFill();
            g.lineStyle(1.5,0x353B48);stoneFill(g,0xAAAEB5,0x555E6C,-36,-17,72,17);
            g.drawRoundRect(-36,-17,72,15,4,4);g.endFill();
            g.lineStyle(1,0x4A515D);stoneFill(g,0xB1B3BC,0x68727E,-26,-105,52,92);
            g.moveTo(-14,-79);g.curveTo(-20,-68,-18,-55);g.lineTo(-27,-18);
            g.curveTo(0,-10,27,-18);g.lineTo(18,-55);g.curveTo(21,-69,13,-80);
            g.curveTo(19,-103,0,-108);g.curveTo(-18,-104,-14,-79);g.endFill();
            g.beginFill(0x747F8D);g.moveTo(-11,-88);g.curveTo(0,-99,11,-88);
            g.curveTo(10,-75,0,-72);g.curveTo(-10,-76,-11,-88);g.endFill();
            g.lineStyle(1,0xCFD0D3,.7);g.moveTo(-11,-72);g.curveTo(-17,-50,-23,-22);
            g.moveTo(10,-72);g.curveTo(16,-47,23,-22);g.moveTo(-5,-56);g.lineTo(-10,-23);
            g.moveTo(4,-56);g.lineTo(10,-23);g.moveTo(-11,-90);g.curveTo(0,-100,12,-90);
            g.lineStyle(3,0x8C95A0);g.moveTo(-15,-68);g.curveTo(-17,-54,-4,-51);
            g.moveTo(15,-68);g.curveTo(17,-54,4,-51);
            g.lineStyle(1,0x4F5967);g.moveTo(-5,-84);g.lineTo(-2,-84);g.moveTo(2,-84);g.lineTo(5,-84);
            g.moveTo(-2,-78);g.lineTo(2,-78);g.moveTo(9,-38);g.lineTo(5,-31);g.lineTo(8,-26);g.lineStyle();
            sign("不再束缚光的神像", 450, floorY - 130);
         }
         for(var i:int = 0; i < 3; ++i)
         {
            // Low roadside lamp niches respect the native village skyline and quest board.
            var px:Number = 900 + i * 200;
            var house:Sprite = new Sprite(); house.x = px; house.y = floorY; addChild(house);
            var hg:Graphics = house.graphics;hg.beginFill(0x152331,.22);hg.drawEllipse(-26,-4,52,9);hg.endFill();
            hg.lineStyle(1,0x3A4654);stoneFill(hg,0x81909C,0x424C5B,-23,-17,46,17);
            hg.drawRoundRect(-23,-17,46,15,4,4);hg.endFill();
            hg.lineStyle(2,0xB89A60);hg.beginFill(0x303F49);hg.drawRoundRect(-12,-46,24,29,5,5);hg.endFill();
            hg.moveTo(-15,-46);hg.lineTo(0,-52);hg.lineTo(15,-46);
            var window:Sprite = new Sprite(); window.x = px; window.y = floorY - 32; addChild(window);
            var wg:Graphics=window.graphics;wg.beginFill(isBeacon ? 0xD8EED2 : 0xFFE0A0,.9);
            wg.drawRoundRect(-8,-10,16,20,3,3);wg.endFill();
            wg.lineStyle(1,0x8E7951);wg.moveTo(0,-10);wg.lineTo(0,10);
            wg.beginFill(0xFFF9D1);wg.drawEllipse(-2,-5,4,9);wg.endFill();wg.lineStyle();
            villageWindows.push(window);
         }
         for(i = 0; i < 4; ++i)
         {
            var p:Sprite = person(i % 2 == 0 ? 0x7DA99A : 0xB39984, i == 3, i, !isBeacon);
            p.x = isBeacon ? 620 + i * 42 : 670 + i * 155; p.y = floorY; addChild(p); villagePeople.push(p);

         }
         sign(isBeacon ? "长明之约 · 今日守灯人" : "万家之火 · 回家的路", 700, floorY - 112);
      }

      private function makeBeacon(px:Number):Sprite
      {
         var s:Sprite = new Sprite(); s.x = px; s.y = floorY; addChild(s);
         var g:Graphics = s.graphics; g.lineStyle(2, 0xC2A46B); g.beginFill(0x3A5557, .9);
         g.moveTo(-31, 0); g.lineTo(-21, -124); g.lineTo(21, -124); g.lineTo(31, 0); g.lineTo(-31, 0); g.endFill();
         g.lineStyle(2, 0x799495);
         for(var i:int = 0; i < 5; ++i) { g.moveTo(-24, -i * 22); g.lineTo(24, -i * 22); }
         g.lineStyle(3, 0xD0B678); g.beginFill(0x213A41); g.drawRect(-28, -158, 56, 35); g.endFill();
         g.beginFill(0xB79D65); g.moveTo(-36, -158); g.lineTo(0, -178); g.lineTo(36, -158); g.lineTo(-36, -158); g.endFill();
         g.lineStyle(3, 0xD0B678); g.moveTo(-25, -123); g.lineTo(25, -123); g.moveTo(0, -157); g.lineTo(0, -123);
         addGlow(s, 0, -140, 0xAEFFF0, 34, false);
         sign("归航灯塔", px, floorY - 207, "beacon");
         return s;
      }

      private function makeRelease(px:Number):Sprite
      {
         var s:Sprite = new Sprite(); s.x = px; s.y = floorY; addChild(s);
         drawReleaseFrame(s, false);
         addGlow(s, 0, -69, 0xE9CFFF, 42, false);
         sign("解缚环", px, floorY - 150, "release");
         return s;
      }

      private function drawReleaseFrame(s:Sprite, broken:Boolean):void
      {
         var g:Graphics = s.graphics; g.clear();
         g.lineStyle(3, 0xA092B6); g.beginFill(0x393443);
         g.drawRect(-54, -13, 108, 13); g.endFill();
         if(broken)
         {
            // The former closed circle becomes separated fragments lying around the plinth.
            g.lineStyle(8, 0x9683AE);
            g.moveTo(-66, -15); g.lineTo(-48, -26); g.lineTo(-31, -20);
            g.moveTo(-20, -7); g.lineTo(-3, -21); g.lineTo(17, -12);
            g.moveTo(36, -22); g.lineTo(53, -13); g.lineTo(69, -23);
            g.lineStyle(2, 0xE7D7AA); g.moveTo(-52, -28); g.lineTo(-49, -21);
            g.moveTo(17, -17); g.lineTo(21, -9);
            return;
         }
         g.lineStyle(9, 0x776B8A); g.drawCircle(0, -69, 47);
         g.lineStyle(2, 0xD5B982); g.drawCircle(0, -69, 52);
         for(var i:int = 0; i < 6; ++i)
         {
            var a:Number = i * Math.PI / 3;
            var x0:Number = Math.cos(a) * 47; var y0:Number = -69 + Math.sin(a) * 47;
            g.lineStyle(4, 0xD7C18A); g.moveTo(x0 - 6, y0 - 6); g.lineTo(x0 + 6, y0 + 6);
         }
      }

      private function drawRitual():void
      {
         if(!ritualLinks) return;
         var choice:String = progress.ending != "" ? String(progress.ending) : String(progress.endingChoice);
         var show:Boolean = Boolean(progress.boss2Defeated) && (choice == "beacon" || choice == "release");
         var complete:int = progress.ending != "" ? 3 : int(progress.endingNodes);
         if(endingSequence != "")complete=Math.max(0,Math.min(3,int((endingSequenceTime+.02)/.65)));
         ritualLinks.visible = show; ritualLinks.graphics.clear();
         if(show)
         {
            ritualLinks.graphics.lineStyle(2, choice == "beacon" ? 0x90DDCF : 0xC5A3DB, .45);
            ritualLinks.graphics.moveTo(350, floorY - 7); ritualLinks.graphics.lineTo(1100, floorY - 7);
         }
         for(var i:int = 0; i < ritualNodes.length; ++i)
         {
            var node:Sprite = ritualNodes[i]; node.visible = show;
            // The active release ring is drawn as independently separating arcs below.
            var releaseAge:Number=(endingSequenceTime-i*.65)/.65;
            if(endingSequence=="release" && releaseAge>0 && releaseAge<1)node.visible=false;
            var g:Graphics = node.graphics; g.clear();
            if(!show) continue;
            var done:Boolean = i < complete;
            g.lineStyle(2, 0xAD9775); g.beginFill(0x3E454A); g.drawEllipse(-30, -10, 60, 15); g.endFill();
            if(choice == "beacon")
            {
               g.lineStyle(3, 0x9C865C); g.moveTo(0, -7); g.lineTo(0, -59);
               g.beginFill(0x2E5151); g.drawRoundRect(-17, -77, 34, 26, 5, 5); g.endFill();
               g.lineStyle(1, done ? 0xD7FFEA : 0x726953);
               g.beginFill(done ? 0xB6FFE1 : 0x514E44, done ? .9 : .7);
               g.drawEllipse(-9, -72, 18, 17); g.endFill();
               if(done)
               {
                  g.lineStyle(0, 0, 0); g.beginFill(0xB5FFE7, .12); g.drawCircle(0, -64, 34); g.endFill();
                  g.lineStyle(1, 0xD9FFE7, .7); g.moveTo(-24, -84); g.lineTo(-30, -93);
                  g.moveTo(24, -84); g.lineTo(30, -93);
               }
            }
            else
            {
               g.lineStyle(5, done ? 0xA498B2 : 0xC8AADF);
               if(done)
               {
                  g.moveTo(-30, -14); g.lineTo(-20, -31); g.lineTo(-9, -21);
                  g.moveTo(8, -15); g.lineTo(22, -27); g.lineTo(32, -13);
               }
               else
               {
                  g.drawCircle(0, -43, 23); g.lineStyle(3, 0xDBC58B);
                  g.moveTo(-22, -57); g.lineTo(22, -30); g.moveTo(-22, -30); g.lineTo(22, -57);
               }
            }
         }
      }

      private function refreshVisuals():void
      {
         var i:int;
         if(chain) drawChain(chain.graphics, Boolean(progress.bridgeOpen));
         drawDockRoute();
         for(i = 0; i < gates.length; ++i) Sprite(gates[i]).visible = int(progress.rescuedGroups) <= i;
         for(i = 0; i < prisoners.length; ++i)
         {
            var p:Object = prisoners[i]; var rescued:Boolean = int(progress.rescuedGroups) > p.group;
            p.targetX = rescued ? 55 + i * 17 : p.homeX;
            p.targetY = rescued ? floorY - 22 : floorY;
         }
         var available:Boolean = sceneName == "warden" ? Boolean(progress.boss1Defeated) : Boolean(progress.boss2Defeated);
         if(sceneName == "warden" || sceneName == "regent")
         {
            if(beacon) beacon.visible = available;
            if(release) release.visible = available;
            if(wreck) wreck.visible = available;
            if(routeMarker) routeMarker.visible = available;
            for each(var entry:Object in labels) if(entry.role != "") entry.node.visible = available;
         }
         for each(var light:Object in glows)
         {
            if(light.owner == beacon) light.active = sceneName == "village_beacon" || (progress.ending == "" && Boolean(progress.beaconPrepared)) || progress.ending == "beacon";
            else if(light.owner == release) light.active = progress.ending == "" && Boolean(progress.releasePrepared);
         }
         if(release) drawReleaseFrame(release, progress.ending == "release" && endingSequence != "release");
         drawRitual();
         if(endingSequence != "")drawEndingSequence();
      }

      /** Explicit live ending cue; loading saved state never calls this method. */
      public function beginEndingSequence(ending:String):void
      {
         if(disposed || sceneName!="regent" || (ending!="beacon" && ending!="release"))return;
         if(endingSequence!="" || endingSequencePlayed!="" || progress.ending!==ending)return;
         endingSequence=ending;endingSequencePlayed=ending;endingSequenceTime=0;
         endingSequenceLayer=new Sprite();endingSequenceLayer.mouseEnabled=false;
         endingSequenceLayer.mouseChildren=false;addChild(endingSequenceLayer);
         refreshVisuals();
      }

      private function finishEndingSequence():void
      {
         if(endingSequence=="")return;
         endingSequence="";endingSequenceTime=ENDING_SEQUENCE_DURATION;
         if(endingSequenceLayer){endingSequenceLayer.graphics.clear();endingSequenceLayer.visible=false;}
         refreshVisuals();
      }

      private function drawEndingSequence():void
      {
         if(!endingSequenceLayer || endingSequence=="")return;
         drawRitual();
         var g:Graphics=endingSequenceLayer.graphics;g.clear();
         var xs:Array=[520,800,1050];
         var beaconEnding:Boolean=endingSequence=="beacon";
         var tint:uint=beaconEnding?0xBBFFE9:0xFFE3A2;
         for(var i:int=0;i<3;++i)
         {
            var age:Number=(endingSequenceTime-i*.65)/.65;
            var p:Number=Math.max(0,Math.min(1,age));
            if(age<0)continue;
            if(!beaconEnding && age<1)
               drawSeparatingRing(g,Number(xs[i]),floorY-43,23,p,1-p*.45);
            // A sparse moving trail, rather than a filled beam over the actor.
            if(age<=1.35)
            {
               var targetX:Number=beaconEnding?350:1320+i*48;
               var targetY:Number=beaconEnding?floorY-140:floorY-42-i*8;
               var startY:Number=beaconEnding?floorY-64:floorY-43;
               for(var j:int=0;j<9;++j)
               {
                  var u:Number=Math.max(0,Math.min(1,p-j*.045));
                  var px:Number=Number(xs[i])+(targetX-Number(xs[i]))*u;
                  var py:Number=startY+(targetY-startY)*u-Math.sin(u*Math.PI)*(beaconEnding?44:34);
                  var opacity:Number=(1-j/10)*.75*Math.max(0,1-Math.max(0,age-1)*3);
                  g.lineStyle();g.beginFill(tint,opacity*.13);g.drawCircle(px,py,j==0?12:5);g.endFill();
                  g.beginFill(tint,opacity);g.drawCircle(px,py,j==0?3.5:1.6);g.endFill();
               }
            }
            if(age>=1)
            {
               var fade:Number=Math.max(0,1-(age-1)*.7);
               g.lineStyle(1,tint,fade*.45);
               g.drawCircle(beaconEnding?350:1320+i*48,beaconEnding?floorY-140:floorY-42-i*8,8+Math.min(1,age-1)*15);
               g.lineStyle();
            }
         }
         if(!beaconEnding && release)
         {
            // Final larger seal follows the third node; no state is written by this visual.
            var ringProgress:Number=Math.max(0,Math.min(1,(endingSequenceTime-1.3)/.85));
            var rg:Graphics=release.graphics;rg.clear();rg.lineStyle(3,0xA092B6);rg.beginFill(0x393443);
            rg.drawRect(-54,-13,108,13);rg.endFill();
            drawSeparatingRing(rg,0,-69,47,ringProgress,1-ringProgress*.95);
         }
      }

      private function drawSeparatingRing(g:Graphics,cx:Number,cy:Number,radius:Number,p:Number,opacity:Number):void
      {
         for(var segment:int=0;segment<3;++segment)
         {
            var center:Number=segment*Math.PI*2/3-Math.PI/2;
            var dx:Number=Math.cos(center)*p*18;
            var dy:Number=Math.sin(center)*p*9+p*p*22;
            g.lineStyle(radius>30?7:4,0xBCA4CE,opacity);
            for(var step:int=0;step<=8;++step)
            {
               var a:Number=center-.94+step*.235;
               var x0:Number=cx+Math.cos(a)*radius+dx;
               var y0:Number=cy+Math.sin(a)*radius+dy;
               if(step==0)g.moveTo(x0,y0);else g.lineTo(x0,y0);
            }
            g.lineStyle(1,0xFFF0C8,opacity*.8);
            g.moveTo(cx+Math.cos(center-.94)*radius+dx-2,cy+Math.sin(center-.94)*radius+dy-3);
            g.lineTo(cx+Math.cos(center-.94)*radius+dx+2,cy+Math.sin(center-.94)*radius+dy+3);
         }
         g.lineStyle();
      }

      private function drawDockRoute():void
      {
         if(!dockRoute) return;
         var g:Graphics = dockRoute.graphics; g.clear();
         var sections:Array = [{left:210, right:405, safe:Boolean(progress.bridgeOpen), color:0xA38462},
            {left:435, right:865, safe:Boolean(progress.bridgeOpen) && (int(progress.dockRelays) & 1) != 0, color:0xE7B965},
            {left:905, right:1325, safe:Boolean(progress.bridgeOpen) && int(progress.dockRelays) == 3, color:0xBA94DA}];
         for each(var section:Object in sections)
         {
            var color:uint = section.safe ? 0xA1E3BF : uint(section.color);
            g.lineStyle(3, color, section.safe ? .85 : .45);
            for(var px:Number = section.left; px < section.right - 12; px += 34)
            {
               g.moveTo(px, floorY - 3); g.lineTo(px + 18, floorY - 3);
               if(section.safe)
               {
                  // Left-pointing arrows make the cleared route to the rescue boat explicit.
                  g.moveTo(px + 5, floorY - 8); g.lineTo(px, floorY - 3); g.lineTo(px + 5, floorY + 2);
               }
            }
         }
         for each(var entry:Object in labels)
         {
            if(entry.role != "dockGroup1" && entry.role != "dockGroup2") continue;
            var index:int = entry.role == "dockGroup1" ? 0 : 1;
            var rescued:Boolean = int(progress.rescuedGroups) > index;
            var disabled:Boolean = (int(progress.dockRelays) & (1 << index)) != 0;
            TextField(entry.node).text = rescued ? "已撤离 · 船上接应" : disabled ? "供能已断 · 可以开门" : "居民关押点 · 先断供能";
            TextField(entry.node).textColor = disabled || rescued ? 0xB9EBD0 : 0xEEE3BF;
         }
      }

      private function drawChain(g:Graphics, broken:Boolean):void
      {
         g.clear(); g.lineStyle(2, 0xB6B8B7);
         for(var i:int = 0; i < 7; ++i)
         {
            if(broken && i > 2 && i < 5) continue;
            g.drawEllipse(-5 + (broken && i > 4 ? 14 : 0), i * 10, 10, 15);
         }
         if(!broken)
         {
            g.beginFill(0xD7B46C); g.drawRoundRect(-9, 26, 18, 21, 3, 3); g.endFill();
            g.lineStyle(2, 0x5B4D37); g.moveTo(0, 33); g.lineTo(0, 41);
         }
      }

      private function drawBoat(g:Graphics):void
      {
         g.lineStyle(3, 0xAE8751); g.beginFill(0x5A3F2B);
         g.moveTo(-85, -23); g.lineTo(-63, 10); g.lineTo(60, 10); g.lineTo(88, -23); g.lineTo(-85, -23); g.endFill();
         g.lineStyle(1, 0xBE9B68); g.moveTo(-70, -10); g.lineTo(73, -10);
         g.lineStyle(4, 0xAA9973); g.moveTo(5, -22); g.lineTo(5, -110);
         g.lineStyle(1, 0xE1D3B0); g.beginFill(0xC9B992, .85);
         g.moveTo(9, -104); g.lineTo(63, -42); g.lineTo(9, -42); g.lineTo(9, -104); g.endFill();
      }

      private function stoneFill(g:Graphics, top:uint, bottom:uint, x:Number, y:Number, w:Number, h:Number):void
      {
         var matrix:Matrix=new Matrix();matrix.createGradientBox(w,h,Math.PI/2,x,y);
         g.beginGradientFill(GradientType.LINEAR,[top,bottom],[1,1],[0,255],matrix);
      }

      private function person(coat:uint, small:Boolean = false, variant:int = 0, lantern:Boolean = false):Sprite
      {
         var s:Sprite = new Sprite(); var g:Graphics = s.graphics;
         variant=variant%3;
         g.beginFill(0x152630,.23);g.drawEllipse(-17,-4,34,8);g.endFill();
         // Feet have independent pivots, while the outer node retains its saved ground anchor.
         for(var i:int=0;i<2;++i)
         {
            var foot:Sprite=new Sprite();foot.name=i==0?"footLeft":"footRight";
            foot.x=i==0?-6:6;foot.y=-17;s.addChild(foot);g=foot.graphics;
            g.lineStyle(1,0x29343C);g.beginFill(0x46515B);g.drawRoundRect(-4,0,8,13,3,3);g.endFill();
            g.beginFill(0x533F35);g.drawRoundRect(-5,11,12,6,3,3);g.endFill();
            g.lineStyle(1,0xAD9170,.7);g.moveTo(-3,12);g.lineTo(4,12);g.lineStyle();
         }
         var body:Sprite=new Sprite();body.name="figure";s.addChild(body);g=body.graphics;
         g.lineStyle(1,0x344047);stoneFill(g,coat,0x3E565B,-13,-46,26,31);
         g.moveTo(-8,-46);g.curveTo(-16,-43,-15,-34);g.lineTo(-12,-17);
         g.curveTo(0,-13,12,-17);g.lineTo(15,-34);g.curveTo(16,-43,8,-46);
         g.lineTo(-8,-46);g.endFill();
         // Curved sleeves and cuffs; a held lamp belongs to the right arm rather than floating.
         g.lineStyle(6,coat);g.moveTo(-11,-40);g.curveTo(-16,-32,-16,-24);
         g.lineStyle(4,0xE5BD98);g.moveTo(-16,-24);g.lineTo(-15,-21);g.lineStyle();
         g.beginFill(0xE7C29D);g.drawRoundRect(-4,-49,8,9,3,3);g.endFill();
         if(variant==1)
         {
            g.beginFill(0xDDD1AE);g.moveTo(-7,-41);g.lineTo(7,-41);g.lineTo(10,-19);g.lineTo(-10,-19);g.lineTo(-7,-41);g.endFill();
            g.lineStyle(1,0xA28B68);g.moveTo(-7,-30);g.lineTo(7,-30);g.lineTo(6,-23);g.lineTo(-6,-23);g.lineStyle();
         }
         else
         {
            g.beginFill(variant==0?0xC7B491:0x647B92);g.moveTo(-8,-44);g.lineTo(0,-36);g.lineTo(8,-44);
            g.lineTo(5,-37);g.lineTo(0,-32);g.lineTo(-5,-37);g.endFill();
            g.lineStyle(1,0xD2BE99,.8);g.moveTo(0,-32);g.lineTo(0,-18);g.lineStyle();
            g.beginFill(0xD9B670);g.drawCircle(3,-29,1);g.drawCircle(3,-24,1);g.endFill();
         }
         // A rounded cheek/jaw silhouette, hair locks and readable eyes replace the circle icon.
         g.lineStyle(.8,0x705449);stoneFill(g,0xFFE1B8,0xC48E70,-13,-72,26,28);
         g.moveTo(-11,-65);g.curveTo(-12,-74,0,-74);g.curveTo(12,-74,13,-63);
         g.lineTo(12,-54);g.curveTo(10,-47,0,-45);g.curveTo(-11,-47,-12,-55);
         g.lineTo(-11,-65);g.endFill();g.lineStyle();
         var hair:uint=variant==0?0x4B3934:variant==1?0x655145:0xB39B7A;
         g.beginFill(hair);g.moveTo(-14,-59);g.curveTo(-17,-74,-3,-77);g.curveTo(12,-80,15,-64);
         g.lineTo(12,-56);g.lineTo(9,-66);g.lineTo(4,-63);g.lineTo(-1,-68);
         g.lineTo(-6,-62);g.lineTo(-9,-66);g.lineTo(-11,-55);g.lineTo(-14,-59);g.endFill();
         g.lineStyle(1,0xD7B793,.5);g.moveTo(-10,-70);g.curveTo(-3,-76,7,-72);g.lineStyle();
         if(variant==1)
         {
            g.beginFill(0xB5ADA0);g.moveTo(-14,-69);g.curveTo(-4,-81,9,-75);g.lineTo(15,-65);
            g.curveTo(0,-73,-14,-64);g.lineTo(-14,-69);g.endFill();
            g.beginFill(0xDED4BC);g.drawEllipse(9,-68,7,5);g.endFill();
         }
         for(i=0;i<2;++i)
         {
            var ex:Number=i==0?-8:3;
            g.lineStyle(.7,0x463B39);g.beginFill(0xFFF2DB);g.drawEllipse(ex,-60,6,7);g.endFill();g.lineStyle();
            g.beginFill(0x395D5C);g.drawEllipse(ex+2,-59,3,5);g.endFill();
            g.beginFill(0xFFFFFF);g.drawCircle(ex+2.7,-58.3,.8);g.endFill();
         }
         g.lineStyle(.8,0x9D6F5C);g.moveTo(-2,-50);g.curveTo(1,-48,4,-51);g.lineStyle();
         var arm:Sprite=new Sprite();arm.name="lampArm";arm.x=11;arm.y=-39;s.addChild(arm);g=arm.graphics;
         g.lineStyle(6,coat);g.moveTo(0,0);g.curveTo(6,7,5,13);
         g.lineStyle(4,0xE5BD98);g.moveTo(5,13);g.lineTo(8,15);g.lineStyle();
         if(lantern)
         {
            g.lineStyle(1.5,0xC3A064);g.drawEllipse(5,13,8,8);
            g.beginFill(0x394A50);g.drawRoundRect(3,20,14,17,3,3);g.endFill();
            g.beginFill(0xFFE5A2);g.drawRoundRect(6,23,8,11,2,2);g.endFill();
            g.lineStyle(1,0x9F814F);g.moveTo(10,22);g.lineTo(10,35);g.lineStyle();
            addGlow(arm,10,28,0xFFE2A0,12,true);
         }
         if(small) s.scaleX = s.scaleY = .77;
         return s;
      }

      private function animatePerson(node:Sprite, moving:Boolean, phase:Number):void
      {
         if(!node)return;
         var figure:Sprite=node.getChildByName("figure") as Sprite;
         var left:Sprite=node.getChildByName("footLeft") as Sprite;
         var right:Sprite=node.getChildByName("footRight") as Sprite;
         var arm:Sprite=node.getChildByName("lampArm") as Sprite;
         if(figure)figure.y=moving?-Math.abs(Math.sin(phase))*.9:Math.sin(phase)*.35;
         if(left)left.rotation=moving?Math.sin(phase)*12:0;
         if(right)right.rotation=moving?-Math.sin(phase)*12:0;
         if(arm)arm.rotation=Math.sin(phase)*(moving?5:1.4);
      }

      private function addGlow(owner:Sprite, px:Number, py:Number, color:uint, radius:Number, active:Boolean):void
      {
         var s:Sprite = new Sprite(); s.x = px; s.y = py; owner.addChild(s);
         var g:Graphics = s.graphics;
         g.beginFill(color, .08); g.drawCircle(0, 0, radius); g.endFill();
         g.beginFill(color, .2); g.drawCircle(0, 0, radius * .62); g.endFill();
         g.beginFill(color, .8); g.drawEllipse(-radius * .13, -radius * .31, radius * .26, radius * .62); g.endFill();
         glows.push({owner:owner, node:s, active:active, phase:glows.length * 1.7});
      }

      private function sign(text:String, px:Number, py:Number, role:String = ""):void
      {
         var t:TextField = new TextField(); t.defaultTextFormat = new TextFormat("_sans", 13, 0xEEE3BF, true, null, null, null, null, "center");
         t.text = text; t.width = 210; t.height = 25; t.x = px - 105; t.y = py;
         t.selectable = false; t.mouseEnabled = false; addChild(t); labels.push({node:t, role:role});
      }

      private function direction(px:Number, label:String, role:String = ""):Sprite
      {
         var marker:Sprite = new Sprite(); addChild(marker);
         var g:Graphics = marker.graphics; g.lineStyle(4, 0xB3A374); g.moveTo(px, floorY); g.lineTo(px, floorY - 65);
         g.lineStyle(2, 0xCDBD84); g.beginFill(0x43585B);
         g.moveTo(px - 29, floorY - 70); g.lineTo(px + 24, floorY - 70); g.lineTo(px + 39, floorY - 56);
         g.lineTo(px + 24, floorY - 42); g.lineTo(px - 29, floorY - 42); g.lineTo(px - 29, floorY - 70); g.endFill();
         sign(label, px, floorY - 65, role);
         return marker;
      }
   }
}
