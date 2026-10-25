package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import flash.display.*;
   import flash.events.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol28")]
   public class HitXX extends MovieClip
   {
      
      public static var AllHitXX:Array = [];
      
      private static var Temp:VT = VT.createVT(0.1);
      
      private static var Temp8:VT = VT.createVT(0.8);
      
      private static var Temp0:VT = VT.createVT(0);
      
      private static var Temp100:VT = VT.createVT(100);
      
      public var space:int;
      
      public var 硬直:int;
      
      public var totalTime:int;
      
      public var cross:Boolean;
      
      public var times:int;
      
      public var numValue:int;
      
      public var RL:Boolean;
      
      public var type:int = 0;
      
      public var who:Object;
      
      public var runArr:Array = [];
      
      public var gongJi_hp:Number;
      
      public var objArr:Array = [];
      
      public var _stage:MovieClip;
      
      public function HitXX()
      {
         super();
         _stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private static function SanBi(p:Player) : Boolean
      {
         var sbX:int = 0;
         var sb:Number = NaN;
         var i:int = 0;
         var xx:int = 0;
         sbX = int(p.sanbi.getValue() / 10);
         sb = Number(Temp0.getValue());
         for(i = 0; i < sbX; i++)
         {
            sb += Temp.getValue();
         }
         sb = Math.pow(sb,Temp8.getValue());
         xx = Math.random() * Temp100.getValue();
         if(sb > xx)
         {
            return true;
         }
         return false;
      }
      
      public static function HitEnemy() : *
      {
         var i:* = 0;
         var i4:* = 0;
         var hitXX:HitXX = null;
         var AA:Boolean = false;
         var j:uint = 0;
         var map:* = undefined;
         var i2:int = 0;
         var bool:Boolean = false;
         var i3:int = 0;
         var xx:int = 0;
         for(i = 0; i < HitXX.AllHitXX.length; i++)
         {
            hitXX = HitXX.AllHitXX[i] as HitXX;
            if(hitXX.parent is Fly)
            {
               if(!hitXX.cross && hitXX.parent.life != 0)
               {
                  AA = Boolean(JhitTestPoint.hitTestPoint(hitXX,Main.world.MapData));
                  if(!AA)
                  {
                     for(j = 0; j < Main.world.numChildren; j++)
                     {
                        map = Main.world.getChildAt(j);
                        if(map is Map && Boolean(JhitTestPoint.hitTestPoint(hitXX,map.MapData)))
                        {
                           AA = true;
                           break;
                        }
                     }
                  }
                  if(AA)
                  {
                     (hitXX.parent as Fly).life = 0;
                     continue;
                  }
               }
            }
            if(hitXX.who is Player)
            {
               trace("\n Enemy.All.length = " + Enemy.All.length);
               for(i2 = 0; i2 < Enemy.All.length; i2++)
               {
                  bool = false;
                  for(i3 = 0; i3 < hitXX.objArr.length; i3++)
                  {
                     if(Enemy.All[i2] == hitXX.objArr[i3])
                     {
                        bool = true;
                        break;
                     }
                  }
                  if(Boolean(Enemy.All[i2].hit && Enemy.All[i2].life.getValue() > 0) && Boolean(!bool) && hitXX.hitTestObject(Enemy.All[i2].hit))
                  {
                     if(BaoJi(hitXX.who))
                     {
                        hitXX.gongJi_hp *= 2;
                        (Enemy.All[i2] as Enemy).HpXX(hitXX,true);
                        hitXX.gongJi_hp /= 2;
                     }
                     else
                     {
                        (Enemy.All[i2] as Enemy).HpXX(hitXX);
                     }
                     if((hitXX.who as Player).skin.type >= 100)
                     {
                        new BuffEnemy(hitXX,Enemy.All[i2] as Enemy);
                     }
                     hitXX.who.连击计数();
                     hitXX.objArr[hitXX.objArr.length] = Enemy.All[i2];
                     MusicBox.ActMusicPlayX(hitXX.who.data.skinArr[hitXX.who.data.skinNum],hitXX.who.skin.runType);
                     ACT.Play(hitXX.who,Enemy.All[i2]);
                     if(hitXX.parent is Fly)
                     {
                        if((hitXX.parent as Fly).life != -1 && (hitXX.parent as Fly).life > 0)
                        {
                           --(hitXX.parent as Fly).life;
                        }
                     }
                  }
               }
            }
            else if(hitXX.who is Enemy)
            {
               for(i2 = 0; i2 < Player.All.length; i2++)
               {
                  bool = false;
                  for(i3 = 0; i3 < hitXX.objArr.length; i3++)
                  {
                     if(Player.All[i2] == hitXX.objArr[i3])
                     {
                        bool = true;
                        break;
                     }
                  }
                  if(Boolean(Player.All[i2].hit && (Player.All[i2] as Player).hp.getValue() > 0) && Boolean(!bool) && hitXX.hitTestObject(Player.All[i2].hit))
                  {
                     if(!SanBi(Player.All[i2]))
                     {
                        (Player.All[i2] as Player).HpXX(hitXX);
                     }
                     else
                     {
                        NewMC.Open("闪避",Player.All[i2] as Player,0,-(Player.All[i2] as Player).height);
                     }
                     if((hitXX.who as Enemy).skin.type != 0)
                     {
                        new BuffEffect(hitXX,Player.All[i2] as Player);
                     }
                     hitXX.objArr[hitXX.objArr.length] = Player.All[i2];
                     if(hitXX.parent is Fly)
                     {
                        if((hitXX.parent as Fly).life != -1 && (hitXX.parent as Fly).life > 0)
                        {
                           --(hitXX.parent as Fly).life;
                        }
                     }
                  }
               }
            }
            else
            {
               trace("~~~~~~~~~~~~~~ who are you ?? ??");
            }
         }
         for(i4 = int(Enemy.All.length - 1); i4 >= 0; i4--)
         {
            if(Enemy.All[i4] is Enemy && (Enemy.All[i4] as Enemy).life.getValue() <= 0)
            {
               Enemy.All.splice(i4,1);
            }
         }
         for(i = int(Player.All.length - 1); i >= 0; i--)
         {
            xx = int((Player.All[i] as Player).hp.getValue());
            if(Boolean(Player.All[i]) && xx <= 0)
            {
               Player.All.splice(i,1);
            }
         }
      }
      
      private static function BaoJi(p:Player) : Boolean
      {
         var bjX:int = 0;
         var bj:Number = NaN;
         var i:int = 0;
         var xx:int = 0;
         bjX = int(p.use_baoji.getValue() / 7);
         bj = Number(Temp0.getValue());
         for(i = 0; i < bjX; i++)
         {
            bj += Temp.getValue();
         }
         bj = Math.pow(bj,Temp8.getValue());
         xx = Math.random() * Temp100.getValue();
         if(bj > xx)
         {
            return true;
         }
         return false;
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         var parentMC:MovieClip = null;
         var i:int = 0;
         if(AllHitXX)
         {
            for(i = 0; i < AllHitXX.length; i++)
            {
               if(AllHitXX[i] == this)
               {
                  return;
               }
            }
         }
         parentMC = this.parent as MovieClip;
         while(parentMC != _stage)
         {
            if(parentMC is Fly)
            {
               parentMC.hit = this;
               硬直 = parentMC.硬直;
               times = parentMC.attTimes;
               who = parentMC.who;
               RL = parentMC.RL;
               cross = parentMC.cross;
               gongJi_hp = parentMC.gongJi_hp;
               runArr = [parentMC.runX,parentMC.runY,parentMC.runTime];
               AllHitXX[AllHitXX.length] = this;
               type = (parentMC as Fly).type;
               space = (parentMC as Fly).space;
               totalTime = (parentMC as Fly).totalTime;
               numValue = (parentMC as Fly).numValue;
               return;
            }
            if(parentMC is Skin_WuQi && parentMC.parent is Player)
            {
               who = parentMC.parent;
               RL = (who as Player).RL;
               gongJi_hp = who.skin.hpX;
               硬直 = who.skin.硬直;
               times = who.skin.attTimes;
               runArr = [who.skin.runX,who.skin.runY,who.skin.runTime];
               AllHitXX[AllHitXX.length] = this;
               return;
            }
            if(parentMC is EnemySkin && parentMC.parent is Enemy)
            {
               who = parentMC.parent;
               RL = (who as Enemy).RL;
               gongJi_hp = parentMC.hpX;
               硬直 = parentMC.硬直;
               runArr = [parentMC.runX,parentMC.runY,parentMC.runTime];
               AllHitXX[AllHitXX.length] = this;
               times = (parentMC as EnemySkin).attTimes;
               type = (parentMC as EnemySkin).type;
               space = (parentMC as EnemySkin).space;
               totalTime = (parentMC as EnemySkin).totalTime;
               numValue = (parentMC as EnemySkin).numValue;
               return;
            }
            parentMC = parentMC.parent as MovieClip;
         }
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         var i:int = 0;
         if(AllHitXX)
         {
            for(i = 0; i < AllHitXX.length; i++)
            {
               if(AllHitXX[i] == this)
               {
                  AllHitXX.splice(i,1);
               }
            }
         }
         this.objArr = new Array();
      }
   }
}

