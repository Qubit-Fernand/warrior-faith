package src
{
   import com.*;
   import flash.display.*;
   import flash.events.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol50")]
   public class HitXX extends MovieClip
   {
      
      public static var AllHitXX:Array = [];
      
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
      
      public static function HitEnemy() : *
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:HitXX = null;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc1_ = 0;
         for(; _loc1_ < HitXX.AllHitXX.length; _loc1_++)
         {
            _loc3_ = HitXX.AllHitXX[_loc1_] as HitXX;
            if(_loc3_.parent is Fly)
            {
               if(!_loc3_.cross && _loc3_.parent.life != 0)
               {
                  _loc4_ = Boolean(JhitTestPoint.hitTestPoint(_loc3_,Main.world.MapData));
                  if(!_loc4_)
                  {
                     _loc5_ = 0;
                     while(_loc5_ < Main.world.numChildren)
                     {
                        _loc6_ = Main.world.getChildAt(_loc5_);
                        if(_loc6_ is Map && Boolean(JhitTestPoint.hitTestPoint(_loc3_,_loc6_.MapData)))
                        {
                           _loc4_ = true;
                           break;
                        }
                        _loc5_++;
                     }
                  }
                  if(_loc4_)
                  {
                     (_loc3_.parent as Fly).life = 0;
                     continue;
                  }
               }
            }
            if(_loc3_.who is Player)
            {
               _loc7_ = 0;
               while(_loc7_ < Enemy.All.length)
               {
                  _loc8_ = false;
                  _loc9_ = 0;
                  while(_loc9_ < _loc3_.objArr.length)
                  {
                     if(Enemy.All[_loc7_] == _loc3_.objArr[_loc9_])
                     {
                        _loc8_ = true;
                        break;
                     }
                     _loc9_++;
                  }
                  if(Boolean(Enemy.All[_loc7_].hit && Enemy.All[_loc7_].life > 0) && Boolean(!_loc8_) && _loc3_.hitTestObject(Enemy.All[_loc7_].hit))
                  {
                     if(BaoJi(_loc3_.who))
                     {
                        _loc3_.gongJi_hp *= 2;
                        (Enemy.All[_loc7_] as Enemy).HpXX(_loc3_,true);
                     }
                     else
                     {
                        (Enemy.All[_loc7_] as Enemy).HpXX(_loc3_);
                     }
                     _loc3_.who.连击计数();
                     _loc3_.objArr[_loc3_.objArr.length] = Enemy.All[_loc7_];
                     MusicBox.ActMusicPlayX(_loc3_.who.data.skinArr[_loc3_.who.data.skinNum],_loc3_.who.skin.runType);
                     ACT.Play(_loc3_.who,Enemy.All[_loc7_]);
                     if(_loc3_.parent is Fly)
                     {
                        if((_loc3_.parent as Fly).life != -1 && (_loc3_.parent as Fly).life > 0)
                        {
                           --(_loc3_.parent as Fly).life;
                        }
                     }
                  }
                  _loc7_++;
               }
            }
            else if(_loc3_.who is Enemy)
            {
               _loc7_ = 0;
               while(_loc7_ < Player.All.length)
               {
                  _loc8_ = false;
                  _loc9_ = 0;
                  while(_loc9_ < _loc3_.objArr.length)
                  {
                     if(Player.All[_loc7_] == _loc3_.objArr[_loc9_])
                     {
                        _loc8_ = true;
                        break;
                     }
                     _loc9_++;
                  }
                  if(Boolean(Player.All[_loc7_].hit && (Player.All[_loc7_] as Player).hp.getValue() > 0) && Boolean(!_loc8_) && _loc3_.hitTestObject(Player.All[_loc7_].hit))
                  {
                     if(!SanBi(Player.All[_loc7_]))
                     {
                        (Player.All[_loc7_] as Player).HpXX(_loc3_);
                     }
                     else
                     {
                        NewMC.Open("闪避",Player.All[_loc7_] as Player,0,-(Player.All[_loc7_] as Player).height);
                     }
                     if((_loc3_.who as Enemy).skin.type != 0)
                     {
                        new BuffEffect(_loc3_,Player.All[_loc7_] as Player);
                     }
                     _loc3_.objArr[_loc3_.objArr.length] = Player.All[_loc7_];
                     if(_loc3_.parent is Fly)
                     {
                        if((_loc3_.parent as Fly).life != -1 && (_loc3_.parent as Fly).life > 0)
                        {
                           --(_loc3_.parent as Fly).life;
                        }
                     }
                  }
                  _loc7_++;
               }
            }
            else
            {
               trace("~~~~~~~~~~~~~~ who are you ?? ??");
            }
         }
         _loc2_ = int(Enemy.All.length - 1);
         while(_loc2_ >= 0)
         {
            if(Enemy.All[_loc2_] is Enemy && (Enemy.All[_loc2_] as Enemy).life <= 0)
            {
               Enemy.All.splice(_loc2_,1);
            }
            _loc2_--;
         }
         _loc1_ = int(Player.All.length - 1);
         while(_loc1_ >= 0)
         {
            _loc10_ = int((Player.All[_loc1_] as Player).hp.getValue());
            if(Boolean(Player.All[_loc1_]) && _loc10_ <= 0)
            {
               Player.All.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      private static function BaoJi(param1:Player) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = int(param1.use_baoji.getValue() / 38);
         _loc3_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ += 0.6;
            _loc4_++;
         }
         _loc5_ = Math.random() * 100;
         if(_loc3_ > _loc5_)
         {
            return true;
         }
         return false;
      }
      
      private static function SanBi(param1:Player) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc2_ = int(param1.sanbi.getValue() / 31);
         _loc3_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ += 0.5;
            _loc4_++;
         }
         _loc5_ = Math.random() * 100;
         if(_loc3_ > _loc5_)
         {
            return true;
         }
         return false;
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         if(AllHitXX)
         {
            _loc3_ = 0;
            while(_loc3_ < AllHitXX.length)
            {
               if(AllHitXX[_loc3_] == this)
               {
                  return;
               }
               _loc3_++;
            }
         }
         _loc2_ = this.parent as MovieClip;
         while(_loc2_ != _stage)
         {
            if(_loc2_ is Fly)
            {
               _loc2_.hit = this;
               硬直 = _loc2_.硬直;
               times = _loc2_.attTimes;
               who = _loc2_.who;
               RL = _loc2_.RL;
               cross = _loc2_.cross;
               gongJi_hp = _loc2_.gongJi_hp;
               runArr = [_loc2_.runX,_loc2_.runY,_loc2_.runTime];
               AllHitXX[AllHitXX.length] = this;
               type = (_loc2_ as Fly).type;
               space = (_loc2_ as Fly).space;
               totalTime = (_loc2_ as Fly).totalTime;
               numValue = (_loc2_ as Fly).numValue;
               return;
            }
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               RL = (who as Player).RL;
               gongJi_hp = who.skin.hpX;
               硬直 = who.skin.硬直;
               times = who.skin.attTimes;
               runArr = [who.skin.runX,who.skin.runY,who.skin.runTime];
               AllHitXX[AllHitXX.length] = this;
               return;
            }
            if(_loc2_ is EnemySkin && _loc2_.parent is Enemy)
            {
               who = _loc2_.parent;
               RL = (who as Enemy).RL;
               gongJi_hp = _loc2_.hpX;
               硬直 = _loc2_.硬直;
               runArr = [_loc2_.runX,_loc2_.runY,_loc2_.runTime];
               AllHitXX[AllHitXX.length] = this;
               times = (_loc2_ as EnemySkin).attTimes;
               type = (_loc2_ as EnemySkin).type;
               space = (_loc2_ as EnemySkin).space;
               totalTime = (_loc2_ as EnemySkin).totalTime;
               numValue = (_loc2_ as EnemySkin).numValue;
               return;
            }
            _loc2_ = _loc2_.parent as MovieClip;
         }
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         var _loc2_:int = 0;
         if(AllHitXX)
         {
            _loc2_ = 0;
            while(_loc2_ < AllHitXX.length)
            {
               if(AllHitXX[_loc2_] == this)
               {
                  AllHitXX.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
         this.objArr = new Array();
      }
   }
}

