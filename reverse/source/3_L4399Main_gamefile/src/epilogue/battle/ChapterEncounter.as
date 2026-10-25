package src.epilogue.battle
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import src.Enemy;
   import src.Fly;
   import src.HitXX;
   import src.InitData;
   import src.Main;
   import src.Player;

   /** Single-player encounter. Parent owns player/world lifecycle and persistence. */
   public class ChapterEncounter extends Sprite
   {
      public static const DEFEATED:String = "chapterBossDefeated";
      public static const PHASE_CHANGED:String = "chapterBossPhase";
      public static const ATTACK_STARTED:String = "chapterBossAttack";
      private var kind:String;
      private var settings:Object;
      private var arenaWidth:Number;
      private var floorY:Number;
      private var arenaLeft:Number;
      private var arenaRight:Number;
      private var body:BossBody;
      private var effects:Sprite = new Sprite();
      private var hazards:Array = [];
      private var numbers:Array = [];
      private var nodes:Array = [0, 0];
      private var nodeMax:Number;
      private var phaseOneMax:Number;
      private var phaseTwoMax:Number;
      private var currentHp:Number;
      private var armor:Number;
      private var attackPower:Number;
      private var currentPhase:int = 1;
      private var stateName:String = "intro";
      private var stateTime:Number = 0;
      private var elapsed:Number = 0;
      private var attackIndex:int = 0;
      private var _paused:Boolean = false;
      private var _disposed:Boolean = false;
      private var _finished:Boolean = false;
      private var player:Player;
      private var attacksLanded:int = 0;
      private var playerHits:int = 0;
      private var lastDamage:Number = 0;
      private var transitionCount:int = 0;
      private var currentHint:String = "";
      private var lastHitBounds:Object = null;
      private var lastHitAt:Number = -1;
      private var lastHitResult:String = "none";
      private var lastHitSource:String = "";
      private var chargeHazard:BattleHazard = null;
      private var chargeReleased:Boolean = false;
      private var chargeDamage:Number = 0;
      private var chargeRequired:Number = 0;
      private var interruptions:int = 0;
      private var chargeFailures:int = 0;
      private var sanctuaryEscapes:int = 0;
      private var trackingDodges:int = 0;
      private var exposedUntil:Number = 0;
      private var lastMechanicResult:String = "none";
      private var lastDt:Number = 0;
      private var damageContacts:int = 0;
      private var lastReceivedDamage:Number = 0;
      private var lastIncomingPower:Number = 0;
      private var shieldReleased:Boolean = false;

      public function ChapterEncounter(type:String, width:Number, groundY:Number, options:Object = null)
      {
         kind = type == "regent" ? "regent" : "warden";
         settings = options == null ? {} : options;
         arenaWidth = Math.max(400, width);
         floorY = groundY;
         arenaLeft = numeric("left", 20);
         arenaRight = numeric("right", arenaWidth - 20);
         if(arenaRight < arenaLeft + 320) arenaRight = arenaLeft + 320;
         phaseOneMax = Math.max(1, numeric("maxHealth", kind == "warden" ? 420000 : 280000));
         phaseTwoMax = kind == "regent" ? Math.max(1, numeric("phaseTwoHealth", 360000)) : 0;
         armor = Math.max(0, numeric("defense", 250));
         attackPower = Math.max(1, numeric("attack", 1800));
         nodeMax = Math.max(1, numeric("nodeHealth", 24000));
         mouseEnabled = mouseChildren = false;
         name = "chapterEncounter_" + kind;
         reset();
      }

      private function numeric(key:String, fallback:Number):Number
      {
         return settings.hasOwnProperty(key) && isFinite(Number(settings[key])) ? Number(settings[key]) : fallback;
      }

      /** dt is seconds; controller must NOT call while gameplay is paused. */
      public function update(dt:Number):void
      {
         if(_disposed || _paused || _finished || !stage) return;
         if(!isFinite(dt) || dt <= 0) return;
         // A restored background window never skips a telegraph in a single frame.
         dt = Math.min(dt, .05);
         lastDt = dt;
         if(!player || !player.stage) player = settings.player is Player ? settings.player as Player : Main.player_1;
         if(!player || !player.stage || player.hp.getValue() <= 0) return;
         elapsed += dt;
         stateTime += dt;
         body.animate(elapsed, dt, currentPhase, stateName, [nodes[0] > 0, nodes[1] > 0]);
         body.setChanneling(chargeHazard && !chargeHazard.fired ? chargeHazard.progress : -1,
                            chargeRequired > 0 ? chargeDamage / chargeRequired : 0);
         updateNumbers(dt);
         if(stateName == "intro")
         {
            if(stateTime >= 1.25) enterState("recover", kind == "warden" ? "击破两侧供能灯座，展开灯核" : "击断输光臂；追光锁定后横移，夺光蓄能时攻击核心");
            return;
         }
         if(stateName == "transform")
         {
            if(stateTime >= 1.8)
            {
               enterState("recover", "冠轮已裂：打断夺光，或进入绿色光环躲避爆发");
            }
            return;
         }
         receivePlayerAttacks();
         if(_disposed || _finished || stateName == "transform") return;
         updateHazards(dt);
         if(_disposed || _finished) return;
         if(stateName == "exposed" && elapsed >= exposedUntil)
            enterState("recover", "王座重新聚光。准备横移躲避追光锁定");
         if(stateName == "recover" && stateTime >= (settings.releasePrepared ? 1.9 : 1.35))
            beginAttack();
         else if(stateName == "telegraph" && hazards.length > 0 && BattleHazard(hazards[0]).fired)
            enterState("active", currentHint);
         else if((stateName == "active" || stateName == "telegraph") && hazards.length == 0)
            enterState("recover", nodes[0] > 0 || nodes[1] > 0 ? "侧面灯座仍在供能：攻击灯座削弱护盾" : "核心展开：靠近并攻击");
      }

      public function setPaused(value:Boolean):void { _paused = value; }
      public function get paused():Boolean { return _paused; }
      public function get dead():Boolean { return _finished; }
      public function get finished():Boolean { return _finished; }
      public function get phase():int { return currentPhase; }
      public function get hpRatio():Number { return Number(snapshot.hp) / Number(snapshot.maxHp); }
      public function get hint():String { return currentHint; }
      public function get bossName():String { return kind == "warden" ? "缄潮司灯·诺弥" : "窃光王座·霍根"; }

      public function get snapshot():Object
      {
         var remaining:Number = currentHp + (kind == "regent" && currentPhase == 1 ? phaseTwoMax : 0);
         var hazardStates:Array = [];
         for each(var h:BattleHazard in hazards) hazardStates.push(h.state);
         return {name:bossName, kind:kind, hp:_finished ? 0 : remaining,
                 maxHp:phaseOneMax + phaseTwoMax, phase:currentPhase,
                 phaseHp:currentHp, phaseMaxHp:kind == "warden" || currentPhase == 1 ? phaseOneMax : phaseTwoMax,
                 hint:currentHint, state:stateName, paused:_paused, dead:_finished,
                 finished:_finished, disposed:_disposed, elapsed:elapsed,
                 nodes:[Number(nodes[0]), Number(nodes[1])], nodeMax:nodeMax, shieldReleased:shieldReleased,
                 attackIndex:attackIndex, playerHits:playerHits, attacksLanded:attacksLanded,
                 lastDamage:lastDamage, phaseTransitions:transitionCount, hazards:hazardStates,
                 lastHitBounds:lastHitBounds == null ? null : {x:lastHitBounds.x,y:lastHitBounds.y,width:lastHitBounds.width,height:lastHitBounds.height},
                 coreBounds:body ? numericBounds(body.core.getBounds(this)) : null,
                 lastHitAt:lastHitAt, lastHitResult:lastHitResult, lastHitSource:lastHitSource,
                 beaconPrepared:Boolean(settings.beaconPrepared), releasePrepared:Boolean(settings.releasePrepared),
                 playerHp:player ? player.hp.getValue() : -1, playerStats:diagnosticPlayer(),
                 frameDelta:lastDt, damageContacts:damageContacts,
                 lastReceivedDamage:lastReceivedDamage, lastIncomingPower:lastIncomingPower,
                 configuredAttack:attackPower, configuredDefense:armor,
                 chargeDamage:chargeDamage, chargeRequired:chargeRequired,
                 charging:chargeHazard != null && !chargeHazard.fired,
                 chargeProgress:chargeHazard ? chargeHazard.progress : 0,
                 interruptions:interruptions, chargeFailures:chargeFailures,
                 sanctuaryEscapes:sanctuaryEscapes, trackingDodges:trackingDodges,
                 exposedRemaining:Math.max(0, exposedUntil - elapsed), lastMechanicResult:lastMechanicResult};
      }

      /** Reconstructs encounter-only state. Does not heal, teleport or save the player. */
      public function reset():void
      {
         if(_disposed) return;
         while(numChildren > 0) removeChildAt(0);
         hazards = []; numbers = [];
         effects = new Sprite(); effects.mouseEnabled = effects.mouseChildren = false;
         body = new BossBody(kind);
         body.x = arenaLeft + (arenaRight - arenaLeft) * .64;
         body.y = floorY;
         addChild(body); addChild(effects);
         currentHp = phaseOneMax;
         nodes = [nodeMax, nodeMax];
         shieldReleased = false; body.setNodeHealth(nodes, nodeMax);
         currentPhase = 1; elapsed = 0; stateTime = 0; attackIndex = 0;
         attacksLanded = playerHits = transitionCount = 0; lastDamage = 0;
         lastHitBounds = null; lastHitAt = -1; lastHitResult = "none"; lastHitSource = "";
         chargeHazard = null; chargeReleased = false; chargeDamage = chargeRequired = 0;
         interruptions = chargeFailures = sanctuaryEscapes = trackingDodges = 0;
         exposedUntil = 0; lastMechanicResult = "none";
         lastDt = lastReceivedDamage = lastIncomingPower = 0; damageContacts = 0;
         _finished = false; _paused = false;
         player = settings.player is Player ? settings.player as Player : Main.player_1;
         enterState("intro", kind == "warden" ? "司灯机关苏醒：金色地波要跳，紫色锚印要躲" : "击断输光臂，让王座失去供能");
      }

      public function dispose():void
      {
         if(_disposed) return;
         _disposed = true;
         clearHazards();
         while(numChildren > 0) removeChildAt(0);
         numbers = []; player = null; body = null;
         if(parent) parent.removeChild(this);
      }

      private function enterState(value:String, message:String):void
      {
         stateName = value; stateTime = 0; currentHint = message;
      }

      private function playerFeet():Point
      {
         return globalToLocal(player.localToGlobal(new Point(0, 0)));
      }

      private function playerBounds():Rectangle
      {
         var p:Point = playerFeet();
         if(player.hit && player.hit.width > 0 && player.hit.height > 0)
         {
            var r:Rectangle = player.hit.getBounds(this);
            if(r.width < 180 && r.height < 220) return r;
         }
         return new Rectangle(p.x - 15, p.y - 72, 30, 72);
      }

      private function beginAttack():void
      {
         if(kind == "regent")
         {
            beginRegentAttack();
            return;
         }
         var feet:Point = playerFeet();
         var aim:Number = Math.max(arenaLeft + 55, Math.min(arenaRight - 55, feet.x));
         var pattern:String = attackIndex % 2 == 0 ? "wave" : "columns";
         var targets:Array = [aim];
         var warn:Number = currentPhase == 2 ? 1.0 : 1.35;
         var duration:Number = pattern == "wave" ? 1.5 : .55;
         var h:BattleHazard = new BattleHazard(pattern, arenaLeft, arenaRight, floorY,
            targets, warn, duration, attackIndex % 4 == 0 ? -1 : 1, currentPhase == 2 ? 1.25 : 1);
         hazards.push(h);
         addChildAt(h, 0);
         ++attackIndex;
         enterState("telegraph", pattern == "wave" ? "金色扫海波 → 跳起越过低位光浪" : "紫色光锚 → 横移离开标记，跳跃不能躲开");
         dispatchEvent(new Event(ATTACK_STARTED));
      }

      private function beginRegentAttack():void
      {
         var feet:Point = playerFeet();
         var h:BattleHazard;
         var message:String;
         if(attackIndex % 2 == 0)
         {
            // Follow, then visibly lock. A late horizontal dodge is different from
            // Warden's fixed ground-wave jump and from attacking to interrupt below.
            h = new BattleHazard("tracking", arenaLeft, arenaRight, floorY, [feet.x],
                currentPhase == 2 ? 2.2 : 2.8, .6, 1, currentPhase == 2 ? 1.3 : 1.1);
            message = "追光正在跟随 → 等“已锁定”出现后横移";
         }
         else
         {
            var radius:Number = (currentPhase == 2 ? 72 : 100) + (settings.beaconPrepared ? 28 : 0);
            // Keep shelter close enough to reach without depending on a specific movement build.
            var center:Number = feet.x + (feet.x < body.x ? 140 : -140);
            center = Math.max(arenaLeft + radius + 12, Math.min(arenaRight - radius - 12, center));
            h = new BattleHazard("sanctuary", arenaLeft, arenaRight, floorY, [center, radius],
                currentPhase == 2 ? 3.2 : 3.8, .65, 1, 1.8);
            var skinId:int = int(player.data.skinArr[player.data.skinNum]);
            var profession:Number = skinId >= 0 && skinId < player.职业附加.length ? Number(player.职业附加[skinId]) : 1;
            if(!isFinite(profession) || profession <= 0) profession = 1;
            chargeRequired = Math.max(1, numeric("interruptDamage",
                Math.min(90000, Math.max(1000, player.use_gongji.getValue() * profession * 3))));
            if(settings.releasePrepared) chargeRequired *= .7;
            chargeDamage = 0; chargeReleased = false; chargeHazard = h;
            message = "夺光蓄能 → 攻击核心打断，或进入绿色光环";
            lastMechanicResult = "charging";
         }
         hazards.push(h); addChildAt(h, 0); ++attackIndex;
         enterState("telegraph", message);
         dispatchEvent(new Event(ATTACK_STARTED));
      }

      private function interruptCharge():void
      {
         ++interruptions;
         lastMechanicResult = "interrupted";
         clearHazards();
         exposedUntil = elapsed + 2.8;
         enterState("exposed", "夺光已打断！核心失衡，2.8秒内伤害提高50%");
         body.setChanneling(-1, 0);
         floating("夺光打断 · 核心失衡", body.x, floorY - 235, 0xB8FFE1);
      }

      private function updateHazards(dt:Number):void
      {
         var bounds:Rectangle = playerBounds();
         var feet:Point = playerFeet();
         for(var i:int = hazards.length - 1; i >= 0; --i)
         {
            var h:BattleHazard = hazards[i] as BattleHazard;
            h.trackPlayer(feet.x);
            h.update(dt);
            if(h.kind == "tracking" && !h.fired)
               currentHint = h.tracking ? "追光正在跟随 → 等“已锁定”出现后横移" : "追光已锁定！立即横移出紫色光束";
            if(h == chargeHazard && h.fired && !chargeReleased)
            {
               chargeReleased = true; ++chargeFailures;
               lastMechanicResult = "charge-released";
               currentHint = "未能打断！夺光爆发：留在绿色光环内";
               floating("夺光爆发", body.x, floorY - 235, 0xFFD1E9);
            }
            if(h.touches(bounds, feet)) damagePlayer(h.damageScale, feet.x > body.x);
            if(h.finished)
            {
               if(h.kind == "sanctuary" && !Boolean(h.state.hit))
               {
                  ++sanctuaryEscapes; lastMechanicResult = "sheltered";
                  floating("解缚光环保护了你", feet.x, feet.y - 110, 0xB8FFE1);
               }
               if(h.kind == "tracking" && !Boolean(h.state.hit)) ++trackingDodges;
               if(h == chargeHazard) chargeHazard = null;
               if(h.parent) h.parent.removeChild(h);
               hazards.splice(i, 1);
            }
         }
      }

      private function damagePlayer(multiplier:Number, toRight:Boolean):void
      {
         // Never add this HitXX to stage: its ADDED_TO_STAGE handler expects native skin ancestry.
         var hit:HitXX = new HitXX();
         hit.who = this; hit.getWho = this;
         hit.gongJi_hp = attackPower * multiplier * (settings.beaconPrepared ? .72 : 1);
         hit.times = 1; hit.硬直 = 12; hit.RL = toRight;
         hit.runArr = [5, -1, 5];
         var before:Number = player.hp.getValue();
         ++damageContacts; lastIncomingPower = hit.gongJi_hp;
         player.HpXX(hit, false);
         lastReceivedDamage = Math.max(0, before - player.hp.getValue());
         if(lastReceivedDamage > 0) ++attacksLanded;
      }

      private function receivePlayerAttacks():void
      {
         // A snapshot protects against original frame scripts removing hits during callbacks.
         var attacks:Array = HitXX.AllHitXX.concat();
         for each(var hit:HitXX in attacks)
         {
            if(!hit || !(hit.who is Player) || hit.who != player || !hit.stage) continue;
            var projectile:Fly = hit.parent as Fly;
            // Native HitXX.HitEnemy handles !cross terrain collision. It can leave
            // life=0 hits on stage until Fly's next frame; these must not hit again.
            // Fly.over identifies its ending animation, which is not a live attack.
            if(projectile && (projectile.life == 0 || projectile.over)) continue;
            lastHitBounds = numericBounds(hit.getBounds(this));
            lastHitAt = elapsed;
            lastHitSource = projectile ? "projectile" : "melee";
            lastHitResult = "no-new-target";
            var target:Sprite = null;
            var node:int = -1;
            if(nodes[0] > 0 && hit.objArr.indexOf(body.leftNode) < 0 && hit.hitTestObject(body.leftNode))
            { target = body.leftNode; node = 0; }
            else if(nodes[1] > 0 && hit.objArr.indexOf(body.rightNode) < 0 && hit.hitTestObject(body.rightNode))
            { target = body.rightNode; node = 1; }
            else if(hit.objArr.indexOf(body.core) < 0 && hit.hitTestObject(body.core)) target = body.core;
            if(!target) continue;
            // Match native once-per-HitXX-per-target semantics. Multi-hit skills create fresh hits.
            hit.objArr.push(target);
            lastHitResult = node >= 0 ? "node-" + node : "core";
            // Match HitXX.as:139-144: consume one finite penetration only for
            // a newly accepted custom target, never for a previously hit part.
            // The native loop does not know these sprites, so it cannot also
            // charge this same target. -1 remains unlimited penetration.
            if(projectile && projectile.life > 0) --projectile.life;
            var damage:Number = playerDamage(hit);
            var rawDamage:Number = damage;
            if(damage <= 0) continue;
            if(node >= 0)
            {
               nodes[node] = Math.max(0, Number(nodes[node]) - damage);
               body.setNodeHealth(nodes, nodeMax);
               if(nodes[node] == 0)
               {
                  body.breakNode(node);
                  floating("供能切断", target.x + body.x, floorY - 110, 0xBBF8DC);
                  announceShieldReleased();
               }
            }
            else
            {
               if(nodes[0] > 0 || nodes[1] > 0) damage *= .3;
               if(elapsed < exposedUntil) damage *= 1.5;
               currentHp = Math.max(0, currentHp - damage);
            }
            lastDamage = damage; ++playerHits;
            player.连击计数();
            if(player.energySlot) player.energySlot.addEnergy(player, damage);
            if(node >= 0) body.pulseNode(node);
            else body.pulse();
            floating(formatDamage(damage), target.x + body.x, target.y + body.y - 45, 0xFFF1B2);
            if(currentHp <= 0)
            {
               if(kind == "regent" && currentPhase == 1) beginTransformation();
               else finish();
               return;
            }
            if(node < 0 && chargeHazard && !chargeHazard.fired)
            {
               // Shield mitigation does not make the interruption test impossible.
               // Only real core hits count; the timer never removes charge by itself.
               chargeDamage += rawDamage;
               if(chargeDamage >= chargeRequired) interruptCharge();
               else currentHint = "攻击核心打断夺光：" + Math.min(100, Math.round(chargeDamage / chargeRequired * 100)) + "%";
            }
            // Warden changes cadence and opens its lens while retaining one continuous health pool.
            if(kind == "warden" && currentPhase == 1 && currentHp <= phaseOneMax * .5)
            {
               currentPhase = 2; ++transitionCount;
               currentHint = "司灯加速：锚印锁定后立刻移动";
               dispatchEvent(new Event(PHASE_CHANGED));
               if(_disposed || _finished) return;
            }
         }
      }

      private function diagnosticPlayer():Object
      {
         if(!player) return null;
         return {hp:player.hp.getValue(), maxHp:player.use_hp_Max.getValue(),
                 attack:player.use_gongji.getValue(), defense:player.use_fangyu.getValue(),
                 temporaryDefense:player.fangYuPOWER.getValue(), x:player.x, y:player.y};
      }

      private function numericBounds(rect:Rectangle):Object
      {
         return {x:rect.x, y:rect.y, width:rect.width, height:rect.height};
      }

      private function playerDamage(hit:HitXX):Number
      {
         var skinId:int = int(player.data.skinArr[player.data.skinNum]);
         var profession:Number = skinId >= 0 && skinId < player.职业附加.length ? Number(player.职业附加[skinId]) : 1;
         var raw:Number = player.use_gongji.getValue() * hit.gongJi_hp * profession;
         raw += raw * Math.random() * InitData.X002.getValue() + Enemy.gongJiPOWER.getValue();
         var result:Number = Math.max(0, raw - armor / Math.max(1, hit.times));
         var base:Number = player.use_baoji.getValue() / Math.max(.001, InitData.Temp7.getValue()) * InitData.Temp01.getValue();
         var crit:Number = Math.pow(Math.max(0, int(base) + HitXX.baoJiUP.getValue()), InitData.Temp8.getValue());
         if(Math.random() * Math.max(1, InitData.Temp100.getValue()) < crit) result *= 2;
         return isFinite(result) ? Math.max(0, result) : 0;
      }

      private function announceShieldReleased():void
      {
         if(shieldReleased || nodes[0] > 0 || nodes[1] > 0) return;
         shieldReleased = true;
         floating("护盾解除 · 核心完全暴露", body.x, floorY - 185, 0xBCFFE0);
         currentHint = "护盾解除！两侧供能已切断，攻击中央核心";
      }

      private function beginTransformation():void
      {
         clearHazards();
         currentPhase = 2; ++transitionCount;
         currentHp = phaseTwoMax;
         body.breakNode(0); body.breakNode(1);
         nodes = [0, 0]; body.setNodeHealth(nodes, nodeMax);
         announceShieldReleased();
         enterState("transform", "冠轮崩裂 · 无冠之王：输光臂已断，核心完全暴露");
         floating("冠轮崩裂", body.x, floorY - 240, 0xE7D6FF);
         // Separate health pools make threshold transitions atomic even with graduation damage.
         dispatchEvent(new Event(PHASE_CHANGED));
      }

      private function finish():void
      {
         _finished = true; currentHp = 0;
         clearHazards();
         nodes = [0, 0]; body.setNodeHealth(nodes, nodeMax);
         enterState("defeated", kind == "warden" ? "司灯熄灭，归航记录已经显现" : "王座崩解。女神之灵终于可以回答");
         body.animate(elapsed, .05, currentPhase, stateName, [false, false]);
         dispatchEvent(new Event(DEFEATED));
      }

      private function clearHazards():void
      {
         for each(var h:BattleHazard in hazards) if(h.parent) h.parent.removeChild(h);
         hazards = [];
         chargeHazard = null;
      }

      private function floating(text:String, px:Number, py:Number, color:uint):void
      {
         var label:TextField = new TextField();
         label.defaultTextFormat = new TextFormat("_sans", 18, color, true, null, null, null, null, "center");
         label.text = text; label.width = text.length > 10 ? 320 : 180; label.height = 30;
         label.x = px - label.width / 2; label.y = py;
         label.mouseEnabled = false; label.selectable = false;
         effects.addChild(label);
         numbers.push({label:label, life:0});
         // Limit even skills which generate a large number of independent hitboxes.
         if(numbers.length > 20)
         {
            var old:Object = numbers.shift();
            if(old.label.parent) old.label.parent.removeChild(old.label);
         }
      }

      private function updateNumbers(dt:Number):void
      {
         for(var i:int = numbers.length - 1; i >= 0; --i)
         {
            var n:Object = numbers[i];
            n.life += dt; n.label.y -= dt * 38;
            n.label.alpha = Math.max(0, 1 - Number(n.life) / .9);
            if(n.life >= .9)
            {
               if(n.label.parent) n.label.parent.removeChild(n.label);
               numbers.splice(i, 1);
            }
         }
      }

      private function formatDamage(value:Number):String
      {
         return value >= 10000 ? (value / 10000).toFixed(1) + "万" : String(Math.round(value));
      }
   }
}
