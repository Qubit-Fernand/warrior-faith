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

      public function ChapterEncounter(type:String, width:Number, groundY:Number, options:Object = null)
      {
         kind = type == "regent" ? "regent" : "warden";
         settings = options == null ? {} : options;
         arenaWidth = Math.max(400, width);
         floorY = groundY;
         arenaLeft = numeric("left", 20);
         arenaRight = numeric("right", arenaWidth - 20);
         if(arenaRight < arenaLeft + 320) arenaRight = arenaLeft + 320;
         phaseOneMax = Math.max(1, numeric("maxHealth", kind == "warden" ? 1800000 : 1800000));
         phaseTwoMax = kind == "regent" ? Math.max(1, numeric("phaseTwoHealth", 2400000)) : 0;
         armor = Math.max(0, numeric("defense", 250));
         attackPower = Math.max(1, numeric("attack", 1800));
         nodeMax = Math.max(1, numeric("nodeHealth", phaseOneMax * .07));
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
         if(!player || !player.stage) player = settings.player is Player ? settings.player as Player : Main.player_1;
         if(!player || !player.stage || player.hp.getValue() <= 0) return;
         elapsed += dt;
         stateTime += dt;
         body.animate(elapsed, dt, currentPhase, stateName, [nodes[0] > 0, nodes[1] > 0]);
         updateNumbers(dt);
         if(stateName == "intro")
         {
            if(stateTime >= 1.25) enterState("recover", "击破两侧供能灯座，展开灯核");
            return;
         }
         if(stateName == "transform")
         {
            if(stateTime >= 1.8)
            {
               enterState("recover", "冠轮已裂。避开紫色光柱，跳过金色地波");
            }
            return;
         }
         receivePlayerAttacks();
         if(_disposed || _finished || stateName == "transform") return;
         updateHazards(dt);
         if(_disposed || _finished) return;
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
                 nodes:[Number(nodes[0]), Number(nodes[1])], nodeMax:nodeMax,
                 attackIndex:attackIndex, playerHits:playerHits, attacksLanded:attacksLanded,
                 lastDamage:lastDamage, phaseTransitions:transitionCount, hazards:hazardStates,
                 lastHitBounds:lastHitBounds == null ? null : {x:lastHitBounds.x,y:lastHitBounds.y,width:lastHitBounds.width,height:lastHitBounds.height},
                 coreBounds:body ? numericBounds(body.core.getBounds(this)) : null,
                 lastHitAt:lastHitAt, lastHitResult:lastHitResult, lastHitSource:lastHitSource,
                 beaconPrepared:Boolean(settings.beaconPrepared), releasePrepared:Boolean(settings.releasePrepared),
                 playerHp:player ? player.hp.getValue() : -1};
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
         currentPhase = 1; elapsed = 0; stateTime = 0; attackIndex = 0;
         attacksLanded = playerHits = transitionCount = 0; lastDamage = 0;
         lastHitBounds = null; lastHitAt = -1; lastHitResult = "none"; lastHitSource = "";
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
         var feet:Point = playerFeet();
         var aim:Number = Math.max(arenaLeft + 55, Math.min(arenaRight - 55, feet.x));
         var pattern:String = attackIndex % 2 == 0 ? "wave" : "columns";
         var targets:Array = [aim];
         var warn:Number = currentPhase == 2 ? 1.0 : 1.35;
         var duration:Number = pattern == "wave" ? 1.5 : .55;
         if(kind == "regent" && currentPhase == 2)
         {
            duration = pattern == "wave" ? 1.15 : .7;
            if(pattern == "columns")
            {
               var second:Number = aim < (arenaLeft + arenaRight) / 2 ? aim + 170 : aim - 170;
               if(second > arenaLeft + 50 && second < arenaRight - 50) targets.push(second);
            }
         }
         var h:BattleHazard = new BattleHazard(pattern, arenaLeft, arenaRight, floorY,
            targets, warn, duration, attackIndex % 4 == 0 ? -1 : 1, currentPhase == 2 ? 1.25 : 1);
         hazards.push(h);
         addChildAt(h, 0);
         ++attackIndex;
         enterState("telegraph", pattern == "wave" ? "金色扫海波 → 跳起越过低位光浪" : "紫色光锚 → 横移离开标记，跳跃不能躲开");
         dispatchEvent(new Event(ATTACK_STARTED));
      }

      private function updateHazards(dt:Number):void
      {
         var bounds:Rectangle = playerBounds();
         var feet:Point = playerFeet();
         for(var i:int = hazards.length - 1; i >= 0; --i)
         {
            var h:BattleHazard = hazards[i] as BattleHazard;
            h.update(dt);
            if(h.touches(bounds, feet)) damagePlayer(h.damageScale, feet.x > body.x);
            if(h.finished)
            {
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
         player.HpXX(hit, false);
         if(player.hp.getValue() < before) ++attacksLanded;
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
            if(damage <= 0) continue;
            if(node >= 0)
            {
               nodes[node] = Math.max(0, Number(nodes[node]) - damage);
               if(nodes[node] == 0) floating("供能切断", target.x + body.x, floorY - 110, 0xBBF8DC);
            }
            else
            {
               if(nodes[0] > 0 || nodes[1] > 0) damage *= .3;
               currentHp = Math.max(0, currentHp - damage);
            }
            lastDamage = damage; ++playerHits;
            player.连击计数();
            if(player.energySlot) player.energySlot.addEnergy(player, damage);
            body.pulse();
            floating(formatDamage(damage), target.x + body.x, target.y + body.y - 45, 0xFFF1B2);
            if(currentHp <= 0)
            {
               if(kind == "regent" && currentPhase == 1) beginTransformation();
               else finish();
               return;
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

      private function beginTransformation():void
      {
         clearHazards();
         currentPhase = 2; ++transitionCount;
         currentHp = phaseTwoMax;
         nodes = [0, 0];
         enterState("transform", "冠轮崩裂 · 无冠之王：输光臂已断，核心完全暴露");
         floating("冠轮崩裂", body.x, floorY - 240, 0xE7D6FF);
         // Separate health pools make threshold transitions atomic even with graduation damage.
         dispatchEvent(new Event(PHASE_CHANGED));
      }

      private function finish():void
      {
         _finished = true; currentHp = 0;
         clearHazards();
         enterState("defeated", kind == "warden" ? "司灯熄灭，归航记录已经显现" : "王座崩解。女神之灵终于可以回答");
         body.animate(elapsed, .05, currentPhase, stateName, [false, false]);
         dispatchEvent(new Event(DEFEATED));
      }

      private function clearHazards():void
      {
         for each(var h:BattleHazard in hazards) if(h.parent) h.parent.removeChild(h);
         hazards = [];
      }

      private function floating(text:String, px:Number, py:Number, color:uint):void
      {
         var label:TextField = new TextField();
         label.defaultTextFormat = new TextFormat("_sans", 18, color, true);
         label.text = text; label.width = 180; label.height = 30;
         label.x = px - 70; label.y = py;
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
