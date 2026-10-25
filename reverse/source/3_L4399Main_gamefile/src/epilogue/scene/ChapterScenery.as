package src.epilogue.scene
{
   import flash.display.Graphics;
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
      private var ritualLinks:Sprite;
      private var ritualNodes:Array = [];
      private var prisoners:Array = [];
      private var gates:Array = [];
      private var glows:Array = [];
      private var labels:Array = [];
      private var villageWindows:Array = [];
      private var villagePeople:Array = [];

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
         if(bridge) bridge.rotation = progress.bridgeOpen ? 0 : -72;
         if(needle) needle.rotation = progress.calibrationDone ? 35 : -35;
         for each(var resident:Object in prisoners)
         {
            resident.node.x = resident.targetX;
            resident.node.y = resident.targetY;
            resident.node.rotation = 0;
            resident.node.scaleX = resident.baseScale;
         }
      }

      /** Seconds, driven by Controller. Call only while world animation is allowed. */
      public function update(dt:Number):void
      {
         if(disposed || !isFinite(dt) || dt <= 0) return;
         dt = Math.min(dt, .1);
         elapsed += dt;
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
         }
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
            point("bridge", progress.bridgeOpen ? "渡桥已放下" : "断开锁链", 300),
            point("group1", progress.rescuedGroups >= 1 ? "居民已经获救" : "救出第一组居民", 620),
            point("group2", progress.rescuedGroups >= 2 ? "居民已经获救" : "救出第二组居民", 1080),
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
         bridge = chain = compass = needle = boat = beacon = release = wreck = routeMarker = ritualLinks = null;
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
         chain = new Sprite(); chain.x = 300; chain.y = floorY - 100; addChild(chain);
         drawChain(chain.graphics, false);
         sign("渡桥锁链", 300, floorY - 126);
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
         var post:Sprite = new Sprite(); post.x = px; post.y = floorY; addChild(post);
         var g:Graphics = post.graphics;
         g.lineStyle(8, 0x544B40); g.moveTo(-65, 0); g.lineTo(-65, -90); g.lineTo(65, -90); g.lineTo(65, 0);
         g.lineStyle(2, 0xAE956A); g.moveTo(-65, -84); g.lineTo(65, -84);
         for(var i:int = 0; i < 3; ++i)
         {
            var p:Sprite = person(index == 0 ? 0x87B4A8 : 0xBC9183, i == 1);
            p.x = px + (i - 1) * 25; p.y = floorY; addChild(p);
            prisoners.push({node:p, group:index, homeX:p.x, targetX:p.x, targetY:floorY, baseScale:p.scaleX, phase:i * 2 + index});
         }
         var gate:Sprite = new Sprite(); gate.x = px; gate.y = floorY; addChild(gate);
         g = gate.graphics; g.lineStyle(3, 0x778087);
         for(i = -2; i <= 2; ++i) { g.moveTo(i * 22, 0); g.lineTo(i * 22, -82); }
         g.moveTo(-60, -58); g.lineTo(60, -58); g.moveTo(-60, -17); g.lineTo(60, -17);
         gates.push(gate);
         sign(index == 0 ? "第一处关押点" : "第二处关押点", px, floorY - 118);
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
            var g:Graphics = statue.graphics; g.lineStyle(2, 0x96989C); g.beginFill(0x555C65);
            g.drawRect(-38, -10, 76, 10); g.drawCircle(0, -90, 14);
            g.moveTo(-14, -74); g.lineTo(-29, -13); g.lineTo(29, -13); g.lineTo(14, -74); g.endFill();
            sign("不再束缚光的神像", 450, floorY - 130);
         }
         for(var i:int = 0; i < 3; ++i)
         {
            var px:Number = 850 + i * 220;
            var house:Sprite = new Sprite(); house.x = px; house.y = floorY; addChild(house);
            var hg:Graphics = house.graphics; hg.lineStyle(2, 0x756A58); hg.beginFill(0x453E37, .75);
            hg.drawRect(-48, -96, 96, 96); hg.endFill(); hg.beginFill(0x655144, .85);
            hg.moveTo(-61, -93); hg.lineTo(0, -132); hg.lineTo(61, -93); hg.lineTo(-61, -93); hg.endFill();
            hg.lineStyle(3, 0xA08760); hg.drawRect(-27, -77, 54, 38);
            var window:Sprite = new Sprite(); window.x = px; window.y = floorY - 58; addChild(window);
            window.graphics.beginFill(isBeacon ? 0xCCAC68 : 0xFFE0A0, .8);
            window.graphics.drawRect(-22, -14, 44, 28); window.graphics.endFill();
            window.graphics.lineStyle(3, 0x5B4B3B); window.graphics.moveTo(0, -14); window.graphics.lineTo(0, 14);
            villageWindows.push(window);
         }
         for(i = 0; i < 4; ++i)
         {
            var p:Sprite = person(i % 2 == 0 ? 0x7DA99A : 0xB39984, i == 3);
            p.x = isBeacon ? 620 + i * 42 : 670 + i * 155; p.y = floorY; addChild(p); villagePeople.push(p);
            if(!isBeacon) addGlow(p, 12, -39, 0xFFE2A0, 10, true);
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
         ritualLinks.visible = show; ritualLinks.graphics.clear();
         if(show)
         {
            ritualLinks.graphics.lineStyle(2, choice == "beacon" ? 0x90DDCF : 0xC5A3DB, .45);
            ritualLinks.graphics.moveTo(350, floorY - 7); ritualLinks.graphics.lineTo(1100, floorY - 7);
         }
         for(var i:int = 0; i < ritualNodes.length; ++i)
         {
            var node:Sprite = ritualNodes[i]; node.visible = show;
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
         if(release) drawReleaseFrame(release, progress.ending == "release");
         drawRitual();
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

      private function person(coat:uint, small:Boolean = false):Sprite
      {
         var s:Sprite = new Sprite(); var g:Graphics = s.graphics;
         g.lineStyle(5, 0x273139); g.moveTo(-6, -16); g.lineTo(-8, 0); g.moveTo(6, -16); g.lineTo(8, 0);
         g.lineStyle(1, 0x28343C); g.beginFill(coat); g.drawRoundRect(-13, -43, 26, 29, 6, 6); g.endFill();
         g.lineStyle(4, coat); g.moveTo(-11, -37); g.lineTo(-17, -19); g.moveTo(11, -37); g.lineTo(17, -20);
         g.lineStyle(1, 0x4D3931); g.beginFill(0xD1AA87); g.drawCircle(0, -52, 10); g.endFill();
         g.beginFill(0x4A3C37); g.drawEllipse(-10, -62, 20, 8); g.endFill();
         if(small) s.scaleX = s.scaleY = .77;
         return s;
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
