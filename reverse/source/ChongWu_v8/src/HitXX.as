package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import flash.display.*;
   import flash.events.*;
   import src.other.*;
   import src.tool.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol299")]
   public class HitXX extends MovieClip
   {
      
      public static var AllHitXX:Array = [];
      
      public static var baoJiUP:VT = VT.createVT();
      
      public var objArr:Array = [];
      
      public var gongJi_hp:Number;
      
      public var runArr:Array = [];
      
      public var cross:Boolean;
      
      public var 硬直:int;
      
      public var who:Object;
      
      public var getWho:Object;
      
      public var _stage:MovieClip;
      
      public var RL:Boolean;
      
      public var times:int;
      
      public var type:int = 0;
      
      public var space:int;
      
      public var totalTime:int;
      
      public var numValue:int;
      
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
         var _loc3_:HitXX = null;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:Player = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
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
                  if(Boolean(Enemy.All[_loc7_].hit && Enemy.All[_loc7_].life.getValue() > 0) && Boolean(!_loc8_) && _loc3_.hitTestObject(Enemy.All[_loc7_].hit))
                  {
                     if(BaoJi(_loc3_.who))
                     {
                        (Enemy.All[_loc7_] as Enemy).HpXX(_loc3_,true);
                     }
                     else
                     {
                        (Enemy.All[_loc7_] as Enemy).HpXX(_loc3_);
                     }
                     if((_loc3_.who as Player).skin.type >= 100)
                     {
                        new BuffEnemy(_loc3_,Enemy.All[_loc7_] as Enemy);
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
               _loc7_ = 0;
               while(_loc7_ < Player2.All.length)
               {
                  _loc8_ = false;
                  _loc9_ = 0;
                  while(_loc9_ < _loc3_.objArr.length)
                  {
                     if(Player2.All[_loc7_] == _loc3_.objArr[_loc9_])
                     {
                        _loc8_ = true;
                        break;
                     }
                     _loc9_++;
                  }
                  if(Boolean(!_loc8_ && Player2.All[_loc7_].hit) && Boolean(Player2.All[_loc7_].hp.getValue() > 0) && _loc3_.hitTestObject(Player2.All[_loc7_].hit))
                  {
                     if(BaoJi(_loc3_.who))
                     {
                        (Player2.All[_loc7_] as Player2).HpXX(_loc3_,true);
                     }
                     else
                     {
                        (Player2.All[_loc7_] as Player2).HpXX(_loc3_);
                     }
                     if((_loc3_.who as Player).skin.type >= 100)
                     {
                        new BuffEnemy(_loc3_,Player2.All[_loc7_] as Player2);
                     }
                     _loc3_.who.连击计数();
                     _loc3_.objArr[_loc3_.objArr.length] = Player2.All[_loc7_];
                     MusicBox.ActMusicPlayX(_loc3_.who.data.skinArr[_loc3_.who.data.skinNum],_loc3_.who.skin.runType);
                     ACT.Play(_loc3_.who,Player2.All[_loc7_]);
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
               _loc7_ = 0;
               while(_loc7_ < OtherSkin.All.length)
               {
                  _loc8_ = false;
                  _loc9_ = 0;
                  while(_loc9_ < _loc3_.objArr.length)
                  {
                     if(OtherSkin.All[_loc7_] == _loc3_.objArr[_loc9_])
                     {
                        _loc8_ = true;
                        break;
                     }
                     _loc9_++;
                  }
                  if(Boolean(OtherSkin.All[_loc7_].hit && !_loc8_) && Boolean(_loc3_.hitTestObject(OtherSkin.All[_loc7_].hit)) && (MapJG.step == 4 || MapJG.step == 13 || MapJG.step == 22))
                  {
                     if(MapJG.arr[OtherSkin.All[_loc7_].id - 1] - MapJG.attTimes == 1)
                     {
                        oskin = OtherSkin.All[_loc7_];
                        MapJG.attTimes = MapJG.arr[OtherSkin.All[_loc7_].id - 1];
                        OtherSkin.All[_loc7_].skin.gotoAndPlay(2);
                     }
                     if(MapJG.arr[OtherSkin.All[_loc7_].id - 1] - MapJG.attTimes > 1)
                     {
                        if(MapJG.step == 4)
                        {
                           MapJG.step = 6;
                           MapJG.timetemp = 0;
                        }
                        if(MapJG.step == 13)
                        {
                           MapJG.step = 15;
                           MapJG.timetemp = 0;
                        }
                        if(MapJG.step == 22)
                        {
                           MapJG.step = 24;
                           MapJG.timetemp = 0;
                        }
                        MapJG.attTimes = 0;
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
                  _loc10_ = Player.All[_loc7_];
                  _loc8_ = false;
                  _loc9_ = 0;
                  while(_loc9_ < _loc3_.objArr.length)
                  {
                     if(_loc10_ == _loc3_.objArr[_loc9_])
                     {
                        _loc8_ = true;
                        break;
                     }
                     _loc9_++;
                  }
                  if(Boolean(_loc10_.hit && _loc10_.hp.getValue() > 0 && !_loc8_) && Boolean(_loc3_.hitTestObject(_loc10_.hit)) && _loc10_.newLifeTime.getValue() <= InitData.BuyNum_0.getValue())
                  {
                     if(!SanBi(_loc10_))
                     {
                        _loc10_.HpXX(_loc3_);
                     }
                     else
                     {
                        _loc11_ = _loc10_.x + Math.random() * 100 - 50;
                        _loc12_ = _loc10_.y + Math.random() * 100 - 150;
                        NewMC.Open("闪避",Main.world.moveChild_Other,_loc11_,_loc12_,15,0,true,2);
                     }
                     if(_loc3_.type != 0)
                     {
                        new BuffEffect(_loc3_,_loc10_);
                     }
                     _loc3_.objArr[_loc3_.objArr.length] = _loc10_;
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
            else if(_loc3_.who is ChongWu && _loc3_.getWho is Player)
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
                  if(Boolean(!_loc8_ && Enemy.All[_loc7_].hit) && Boolean(Enemy.All[_loc7_].life.getValue() > 0) && _loc3_.hitTestObject(Enemy.All[_loc7_].hit))
                  {
                     (Enemy.All[_loc7_] as Enemy).HpXX(_loc3_);
                     _loc3_.getWho.连击计数();
                     _loc3_.objArr[_loc3_.objArr.length] = Enemy.All[_loc7_];
                     ACT.Play2(0,Enemy.All[_loc7_]);
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
            else if(_loc3_.who is Player2)
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
                        if(BaoJi(_loc3_.who))
                        {
                           (Player.All[_loc7_] as Player).HpXX(_loc3_,true);
                        }
                        else
                        {
                           (Player.All[_loc7_] as Player).HpXX(_loc3_);
                        }
                     }
                     else
                     {
                        _loc11_ = (Player.All[_loc7_] as Player).x + Math.random() * 100 - 50;
                        _loc12_ = (Player.All[_loc7_] as Player).y + Math.random() * 100 - 150;
                        NewMC.Open("闪避",Main.world.moveChild_Other,_loc11_,_loc12_,15,0,true,2);
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
         }
         var _loc2_:* = int(Enemy.All.length - 1);
         while(_loc2_ >= 0)
         {
            if(Enemy.All[_loc2_] is Enemy && (Enemy.All[_loc2_] as Enemy).life.getValue() <= 0)
            {
               Enemy.All.splice(_loc2_,1);
            }
            _loc2_--;
         }
         _loc1_ = int(Player.All.length - 1);
         while(_loc1_ >= 0)
         {
            _loc13_ = int((Player.All[_loc1_] as Player).hp.getValue());
            if(Boolean(Player.All[_loc1_]) && _loc13_ <= 0)
            {
               Player.All.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      private static function SanBi(param1:*) : Boolean
      {
         var _loc2_:Number = Number(InitData.Temp0.getValue());
         if(PK_UI.PK_ing)
         {
            _loc2_ = int(param1.use_sanbi.getValue() * InitData.Temp01.getValue() * InitData.Temp01.getValue() * InitData.Temp01.getValue());
         }
         else
         {
            _loc2_ = int(param1.use_sanbi.getValue() * InitData.Temp01.getValue() * InitData.Temp01.getValue());
         }
         _loc2_ = Math.pow(_loc2_,InitData.Temp8.getValue());
         var _loc3_:int = Math.random() * InitData.Temp100.getValue();
         if(_loc2_ > _loc3_)
         {
            return true;
         }
         return false;
      }
      
      private static function BaoJi(param1:*) : Boolean
      {
         var _loc2_:int = int(param1.use_baoji.getValue() / InitData.Temp7.getValue() * InitData.Temp01.getValue()) + baoJiUP.getValue();
         _loc2_ = Math.pow(_loc2_,InitData.Temp8.getValue());
         var _loc3_:int = Math.random() * InitData.Temp100.getValue();
         if(_loc2_ > _loc3_)
         {
            return true;
         }
         return false;
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
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
         var _loc2_:MovieClip = this.parent as MovieClip;
         while(_loc2_ != _stage)
         {
            if(_loc2_ is Fly)
            {
               硬直 = _loc2_.硬直;
               times = _loc2_.attTimes;
               who = getWho = _loc2_.who;
               if(who is ChongWu)
               {
                  getWho = (_loc2_.who as ChongWu).who;
               }
               RL = _loc2_.RL;
               cross = _loc2_.cross;
               gongJi_hp = _loc2_.gongJi_hp;
               runArr = [_loc2_.runX,_loc2_.runY,_loc2_.runTime];
               type = (_loc2_ as Fly).type;
               space = (_loc2_ as Fly).space;
               totalTime = (_loc2_ as Fly).totalTime;
               numValue = (_loc2_ as Fly).numValue;
               AllHitXX.push(this);
               return;
            }
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player)
            {
               who = _loc2_.parent;
               RL = (who as Player).RL;
               gongJi_hp = who.skin.hpXX.getValue();
               if(who.skin.hpX >= who.skin.hpXX.getValue() + 1)
               {
                  SaveXX.Save(2,who.skin.hpX,true,false,false);
                  return;
               }
               硬直 = who.skin.硬直;
               times = who.skin.attTimes;
               runArr = [who.skin.runX,who.skin.runY,who.skin.runTime];
               AllHitXX.push(this);
               return;
            }
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player2)
            {
               who = _loc2_.parent;
               RL = (who as Player2).RL;
               gongJi_hp = who.skin.hpXX.getValue();
               硬直 = who.skin.硬直;
               times = who.skin.attTimes;
               runArr = [who.skin.runX,who.skin.runY,who.skin.runTime];
               AllHitXX.push(this);
               return;
            }
            if(_loc2_ is EnemySkin && _loc2_.parent is Enemy)
            {
               who = _loc2_.parent;
               RL = (who as Enemy).RL;
               gongJi_hp = _loc2_.hpX;
               硬直 = _loc2_.硬直;
               runArr = [_loc2_.runX,_loc2_.runY,_loc2_.runTime];
               times = (_loc2_ as EnemySkin).attTimes;
               type = (_loc2_ as EnemySkin).type;
               space = (_loc2_ as EnemySkin).space;
               totalTime = (_loc2_ as EnemySkin).totalTime;
               numValue = (_loc2_ as EnemySkin).numValue;
               AllHitXX.push(this);
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

