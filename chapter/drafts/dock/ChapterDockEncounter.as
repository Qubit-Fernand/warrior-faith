package src.epilogue.battle
{
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import src.Fly;
    import src.HitXX;
    import src.Main;
    import src.Player;

    /** Draft: original dock mechanisms; controller owns saving, rescue and travel. */
    public class ChapterDockEncounter extends Sprite
    {
        public static const CHANGED:String = "chapterDockChanged";
        private var settings:Object;
        private var arenaWidth:Number;
        private var floorY:Number;
        private var player:Player;
        private var machines:Array = [];
        private var hitAreas:Array = [];
        private var labels:Array = [];
        private var hp:Array = [];
        private var maxHp:Array = [];
        private var sparks:Array = [0, 0, 0];
        private var hazards:Array = [];
        private var cooldowns:Array = [1.2, 1.4];
        private var _bridgeBroken:Boolean;
        private var _relays:int;
        private var _paused:Boolean = false;
        private var _disposed:Boolean = false;
        private var elapsed:Number = 0;
        private var attackPower:Number;
        private var playerHits:int = 0;
        private var attacksLanded:int = 0;
        private var lastDamage:Number = 0;
        private var lastHitBounds:Object = null;
        private var hint:String = "攻击铜色桥锁，放下渡桥";

        public function ChapterDockEncounter(width:Number, groundY:Number, options:Object = null)
        {
            settings = options == null ? {} : options;
            arenaWidth = Math.max(1200, width);
            floorY = groundY;
            player = settings.player is Player ? settings.player as Player : Main.player_1;
            _bridgeBroken = Boolean(settings.bridgeOpen);
            _relays = settings.hasOwnProperty("dockRelays") ? int(settings.dockRelays) & 3 : 0;
            // Lock health once at entry. Approximately 12 basic hits below the cap;
            // the cap keeps high-power graduation equipment visibly stronger.
            var baseline:Number = player ? Math.max(1, player.use_gongji.getValue() * professionScale()) : 7500;
            var nodeHealth:Number = numeric("nodeHealth", Math.min(120000, baseline * 12));
            nodeHealth = Math.max(1, nodeHealth);
            maxHp = [Math.max(1, nodeHealth * .8), nodeHealth, nodeHealth];
            hp = [_bridgeBroken ? 0 : maxHp[0], (_relays & 1) != 0 ? 0 : maxHp[1], (_relays & 2) != 0 ? 0 : maxHp[2]];
            attackPower = Math.max(1, numeric("attack", 1200));
            mouseEnabled = mouseChildren = false;
            name = "chapterDockEncounter";
            for(var i:int = 0; i < 3; ++i) createMachine(i);
            updateHint();
        }

        private function numeric(key:String, fallback:Number):Number
        {
            return settings.hasOwnProperty(key) && isFinite(Number(settings[key])) ? Number(settings[key]) : fallback;
        }

        public function get bridgeBroken():Boolean { return _bridgeBroken; }
        /** bit 1 = wave relay at x620, bit 2 = anchor relay at x1080. */
        public function get relays():int { return _relays; }
        public function setPaused(value:Boolean):void { _paused = value; }

        public function get snapshot():Object
        {
            var active:Array = [];
            for each(var entry:Object in hazards) active.push({relay:entry.relay, hazard:BattleHazard(entry.hazard).state});
            var regions:Array = [];
            for each(var area:Sprite in hitAreas) regions.push(boundsObject(area.getBounds(this)));
            return {bridgeBroken:_bridgeBroken, bridgeOpen:_bridgeBroken, relays:_relays, dockRelays:_relays,
                nodeHp:hp.concat(), nodeMax:maxHp.concat(), hint:hint, paused:_paused, disposed:_disposed,
                elapsed:elapsed, playerHits:playerHits, attacksLanded:attacksLanded, lastDamage:lastDamage,
                lastHitBounds:lastHitBounds == null ? null : {x:lastHitBounds.x,y:lastHitBounds.y,width:lastHitBounds.width,height:lastHitBounds.height},
                nodeBounds:regions, hazards:active};
        }

        public function update(dt:Number):void
        {
            if(_paused || _disposed || !stage || !isFinite(dt) || dt <= 0) return;
            if(!player || !player.stage) player = settings.player is Player ? settings.player as Player : Main.player_1;
            if(!player || !player.stage || player.hp.getValue() <= 0) return;
            dt = Math.min(.05, dt);
            elapsed += dt;
            acceptAttacks();
            if(_disposed || _paused) return;
            for(var i:int = 0; i < machines.length; ++i)
            {
                sparks[i] = Math.max(0, Number(sparks[i]) - dt);
                Sprite(machines[i]).alpha = Number(sparks[i]) > 0 ? .45 : 1;
            }
            var feet:Point = globalToLocal(player.localToGlobal(new Point(0, 0)));
            var bounds:Rectangle = playerBounds(feet);
            for(i = hazards.length - 1; i >= 0; --i)
            {
                var item:Object = hazards[i];
                var h:BattleHazard = item.hazard as BattleHazard;
                h.update(dt);
                if(h.touches(bounds, feet)) damagePlayer(feet.x > (item.relay == 1 ? 620 : 1080));
                if(h.finished)
                {
                    if(h.parent) h.parent.removeChild(h);
                    hazards.splice(i, 1);
                }
            }
            // Each lesson is local to its rescue zone. No overlapping off-screen ambushes.
            if(_bridgeBroken && (_relays & 1) == 0 && feet.x >= 430 && feet.x <= 875)
            {
                cooldowns[0] = Number(cooldowns[0]) - dt;
                if(cooldowns[0] <= 0 && !hasHazard(1))
                {
                    spawnHazard(1, feet.x);
                    cooldowns[0] = 5.1;
                }
            }
            if(_bridgeBroken && (_relays & 2) == 0 && feet.x >= 900 && feet.x <= 1480)
            {
                cooldowns[1] = Number(cooldowns[1]) - dt;
                if(cooldowns[1] <= 0 && !hasHazard(2))
                {
                    spawnHazard(2, feet.x);
                    cooldowns[1] = 4.6;
                }
            }
            updateHint();
        }

        public function dispose():void
        {
            if(_disposed) return;
            _disposed = true;
            clearHazards(0);
            while(numChildren > 0) removeChildAt(0);
            machines = []; hitAreas = []; labels = []; player = null;
            if(parent) parent.removeChild(this);
        }

        private function createMachine(index:int):void
        {
            var s:Sprite = new Sprite();
            s.x = index == 0 ? 300 : index == 1 ? 620 : 1080;
            s.y = floorY;
            s.name = "dockMechanism" + index;
            addChild(s); machines.push(s);
            var area:Sprite = new Sprite();
            area.graphics.beginFill(0xFFFFFF, .001);
            area.graphics.drawRect(-30, -92, 60, 86);
            area.graphics.endFill();
            s.addChild(area); hitAreas.push(area);
            var label:TextField = new TextField();
            label.defaultTextFormat = new TextFormat("_sans", 13, 0xFFF1C9, true);
            label.x = -95; label.y = -132; label.width = 190; label.height = 26;
            label.selectable = false; label.mouseEnabled = false;
            s.addChild(label); labels.push(label);
            redraw(index);
        }

        private function redraw(index:int):void
        {
            var g:Graphics = Sprite(machines[index]).graphics;
            var broken:Boolean = Number(hp[index]) <= 0;
            var metal:uint = broken ? 0x5D5A55 : 0xC5A66D;
            var light:uint = index == 2 ? 0xD3B2FF : 0xFFE1A1;
            g.clear();
            g.lineStyle(3, metal); g.beginFill(0x253841);
            g.drawRoundRect(-37, -21, 74, 20, 6, 6); g.endFill();
            if(index == 0)
            {
                // A segmented winch chain and padlock, not a humanoid or enemy skin.
                g.lineStyle(7, metal);
                g.moveTo(-62, broken ? -12 : -59); g.lineTo(-31, broken ? -27 : -62);
                g.moveTo(62, broken ? -10 : -59); g.lineTo(31, broken ? -26 : -62);
                g.lineStyle(4, metal); g.drawEllipse(-19, broken ? -55 : -90, 38, 42);
                g.beginFill(broken ? 0x514A40 : 0x93754B);
                g.drawRoundRect(-28, broken ? -39 : -65, 56, 45, 8, 8); g.endFill();
                g.lineStyle(3, broken ? 0xAF7768 : 0xFFE2A0);
                g.moveTo(-5, broken ? -33 : -54); g.lineTo(6, broken ? -25 : -45);
                g.lineTo(-3, broken ? -17 : -32);
                if(!broken)
                {
                    g.beginFill(0x18262B); g.drawCircle(0, -48, 5);
                    g.drawRect(-3, -46, 6, 14); g.endFill();
                }
            }
            else if(index == 1)
            {
                // Horizontal induction wheel: the emitted hazard is a low ground wave.
                g.lineStyle(5, metal); g.moveTo(-23, -18); g.lineTo(-20, -65);
                g.moveTo(23, -18); g.lineTo(20, -65);
                g.lineStyle(4, metal); g.beginFill(0x1B2C31);
                g.drawCircle(0, broken ? -37 : -65, 27); g.endFill();
                g.lineStyle(3, broken ? 0x5B5B55 : light);
                for(var j:int = -1; j <= 1; ++j)
                {
                    g.moveTo(-17, (broken ? -37 : -65) + j * 10);
                    g.lineTo(17, (broken ? -37 : -65) + j * 10);
                }
                if(broken)
                {
                    g.lineStyle(4, 0x263841); g.moveTo(-4, -63); g.lineTo(5, -34); g.lineTo(-6, -12);
                }
            }
            else
            {
                // Tall split prongs and a suspended anchor crystal identify the move lesson.
                g.lineStyle(5, metal);
                g.moveTo(-22, -18); g.lineTo(-22, broken ? -46 : -99);
                g.moveTo(22, -18); g.lineTo(22, broken ? -41 : -99);
                g.lineStyle(2, broken ? 0x736C83 : light);
                g.beginFill(broken ? 0x544A62 : 0x8C70B6, .8);
                g.moveTo(0, broken ? -43 : -94); g.lineTo(15, broken ? -29 : -65);
                g.lineTo(0, broken ? -10 : -39); g.lineTo(-15, broken ? -29 : -65);
                g.lineTo(0, broken ? -43 : -94); g.endFill();
                if(!broken)
                {
                    g.lineStyle(2, light); g.moveTo(-33, -63); g.lineTo(-44, -63);
                    g.moveTo(33, -63); g.lineTo(44, -63);
                }
            }
            // Per-device life bar provides feedback without pretending these are Boss enemies.
            if(!broken)
            {
                g.lineStyle(0, 0, 0); g.beginFill(0x111D26, .95);
                g.drawRect(-34, -108, 68, 6); g.endFill();
                g.beginFill(light); g.drawRect(-34, -108, 68 * Number(hp[index]) / Number(maxHp[index]), 6); g.endFill();
            }
            TextField(labels[index]).text = broken ? (index == 0 ? "桥锁已断" : "继电器已关闭") :
                (index == 0 ? "桥锁 · 攻击解开" : index == 1 ? "扫波继电器 · 跳跃" : "光锚继电器 · 横移");
        }

        private function professionScale():Number
        {
            if(!player || !player.data) return 1;
            var skinId:int = int(player.data.skinArr[player.data.skinNum]);
            var scale:Number = skinId >= 0 && skinId < player.职业附加.length ? Number(player.职业附加[skinId]) : 1;
            return isFinite(scale) && scale > 0 ? scale : 1;
        }

        private function acceptAttacks():void
        {
            var all:Array = HitXX.AllHitXX.concat();
            for each(var hit:HitXX in all)
            {
                if(!hit || hit.who != player || !hit.stage) continue;
                var projectile:Fly = hit.parent as Fly;
                if(projectile && (projectile.life == 0 || projectile.over)) continue;
                lastHitBounds = boundsObject(hit.getBounds(this));
                var damage:Number = player.use_gongji.getValue() * hit.gongJi_hp * professionScale();
                if(!isFinite(damage) || damage <= 0) continue;
                for(var i:int = 0; i < hitAreas.length; ++i)
                {
                    // Bridge must physically open before remote attacks can disable later devices.
                    if(i > 0 && !_bridgeBroken) continue;
                    if(Number(hp[i]) <= 0) continue;
                    var target:Sprite = hitAreas[i] as Sprite;
                    if(hit.objArr.indexOf(target) >= 0 || !hit.hitTestObject(target)) continue;
                    hit.objArr.push(target);
                    if(projectile && projectile.life > 0) --projectile.life;
                    hp[i] = Math.max(0, Number(hp[i]) - damage);
                    lastDamage = damage; ++playerHits; sparks[i] = .12;
                    player.连击计数();
                    if(player.energySlot) player.energySlot.addEnergy(player, damage);
                    redraw(i);
                    if(Number(hp[i]) <= 0)
                    {
                        if(i == 0) _bridgeBroken = true;
                        else
                        {
                            _relays |= i == 1 ? 1 : 2;
                            clearHazards(i);
                        }
                        updateHint();
                        dispatchEvent(new Event(CHANGED));
                        if(_disposed || _paused) return;
                    }
                    if(projectile && projectile.life == 0) break;
                }
            }
        }

        private function spawnHazard(relay:int, aimX:Number):void
        {
            var h:BattleHazard;
            if(relay == 1)
                h = new BattleHazard("wave", 430, 875, floorY, [], 1.65, 1.65, -1);
            else
                h = new BattleHazard("columns", 900, Math.min(arenaWidth - 40, 1480), floorY,
                    [Math.max(945, Math.min(arenaWidth - 95, aimX))], 1.65, .55);
            addChildAt(h, 0);
            hazards.push({relay:relay, hazard:h});
        }

        private function hasHazard(relay:int):Boolean
        {
            for each(var item:Object in hazards) if(int(item.relay) == relay) return true;
            return false;
        }

        /** relay=0 removes all, otherwise only the permanently disabled device's hazard. */
        private function clearHazards(relay:int):void
        {
            for(var i:int = hazards.length - 1; i >= 0; --i)
            {
                if(relay != 0 && int(hazards[i].relay) != relay) continue;
                var h:BattleHazard = hazards[i].hazard as BattleHazard;
                if(h.parent) h.parent.removeChild(h);
                hazards.splice(i, 1);
            }
        }

        private function playerBounds(feet:Point):Rectangle
        {
            if(player.hit && player.hit.width > 0 && player.hit.height > 0)
            {
                var r:Rectangle = player.hit.getBounds(this);
                if(r.width < 180 && r.height < 220) return r;
            }
            return new Rectangle(feet.x - 15, feet.y - 72, 30, 72);
        }

        private function damagePlayer(toRight:Boolean):void
        {
            var hit:HitXX = new HitXX();
            hit.who = this; hit.getWho = this; hit.gongJi_hp = attackPower;
            hit.times = 1; hit.硬直 = 8; hit.RL = toRight; hit.runArr = [3, -1, 4];
            var before:Number = player.hp.getValue();
            player.HpXX(hit, false);
            if(player.hp.getValue() < before) ++attacksLanded;
        }

        private function updateHint():void
        {
            if(!_bridgeBroken) hint = "攻击铜色桥锁，放下渡桥";
            else if((_relays & 1) == 0) hint = "金色地波要跳；击破扫波继电器，第一组居民才能通行";
            else if((_relays & 2) == 0) hint = "紫色光锚要横移；击破光锚继电器，第二组居民才能通行";
            else hint = "两处危险已经关闭。靠近居民，带他们离开码头";
        }

        private function boundsObject(r:Rectangle):Object
        {
            return {x:r.x, y:r.y, width:r.width, height:r.height};
        }
    }
}
