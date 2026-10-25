package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import flash.display.*;
   import flash.events.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol37")]
   public class HitXX extends MovieClip
   {
      
      public static var AllHitXX:Array = [];
      
      private static var Temp01:VT = VT.createVT(VT.GetTempVT("1/5/2"));
      
      private static var Temp7:VT = VT.createVT(VT.GetTempVT("7*9/9"));
      
      private static var Temp8:VT = VT.createVT(VT.GetTempVT("8/10"));
      
      private static var Temp0:VT = VT.createVT(VT.GetTempVT("0*0"));
      
      private static var Temp100:VT = VT.createVT(VT.GetTempVT("10*10"));
      
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
         this._stage = Main._this;
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onREMOVED_FROM_STAGE);
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
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
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
                        _loc10_ = (Player.All[_loc7_] as Player).x + Math.random() * 100 - 50;
                        _loc11_ = (Player.All[_loc7_] as Player).y + Math.random() * 100 - 150;
                        NewMC.Open("闪避",Main.world.moveChild_Other,_loc10_,_loc11_,15,0,true,2);
                        _loc12_ = Number((Player.All[_loc7_] as Player).data.getStampSlot().getValueSlot1());
                        (Player.All[_loc7_] as Player).MpUp(_loc12_);
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
                           trace("(hitXX.parent as Fly).life == " + (_loc3_.parent as Fly).life);
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
      
      private static function SanBi(param1:Player) : Boolean
      {
         var _loc2_:int = int(param1.use_sanbi.getValue() * Temp01.getValue());
         var _loc3_:Number = Number(Temp0.getValue());
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ += Temp01.getValue();
            _loc4_++;
         }
         _loc3_ = Math.pow(_loc3_,Temp8.getValue());
         var _loc5_:int = Math.random() * Temp100.getValue();
         if(_loc3_ > _loc5_)
         {
            return true;
         }
         return false;
      }
      
      private static function BaoJi(param1:Player) : Boolean
      {
         var _loc2_:int = int(param1.use_baoji.getValue() / Temp7.getValue());
         var _loc3_:Number = Number(Temp0.getValue());
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ += Temp01.getValue();
            _loc4_++;
         }
         _loc3_ = Math.pow(_loc3_,Temp8.getValue());
         var _loc5_:int = Math.random() * Temp100.getValue();
         if(_loc3_ > _loc5_)
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
         while(_loc2_ != this._stage)
         {
            if(_loc2_ is Fly)
            {
               this.硬直 = _loc2_.硬直;
               this.times = _loc2_.attTimes;
               this.who = this.getWho = _loc2_.who;
               if(this.who is ChongWu)
               {
                  this.getWho = (_loc2_.who as ChongWu).who;
               }
               this.RL = _loc2_.RL;
               this.cross = _loc2_.cross;
               this.gongJi_hp = _loc2_.gongJi_hp;
               this.runArr = [_loc2_.runX,_loc2_.runY,_loc2_.runTime];
               AllHitXX[AllHitXX.length] = this;
               this.type = (_loc2_ as Fly).type;
               this.space = (_loc2_ as Fly).space;
               this.totalTime = (_loc2_ as Fly).totalTime;
               this.numValue = (_loc2_ as Fly).numValue;
               return;
            }
            if(_loc2_ is Skin_WuQi && _loc2_.parent is Player)
            {
               this.who = _loc2_.parent;
               this.RL = (this.who as Player).RL;
               this.gongJi_hp = this.who.skin.hpXX.getValue();
               if(this.who.skin.hpX >= this.who.skin.hpXX.getValue() + 1)
               {
                  SaveXX.Save(2,this.who.skin.hpX,true,false);
               }
               this.硬直 = this.who.skin.硬直;
               this.times = this.who.skin.attTimes;
               this.runArr = [this.who.skin.runX,this.who.skin.runY,this.who.skin.runTime];
               AllHitXX[AllHitXX.length] = this;
               return;
            }
            if(_loc2_ is EnemySkin && _loc2_.parent is Enemy)
            {
               this.who = _loc2_.parent;
               this.RL = (this.who as Enemy).RL;
               this.gongJi_hp = _loc2_.hpX;
               this.硬直 = _loc2_.硬直;
               this.runArr = [_loc2_.runX,_loc2_.runY,_loc2_.runTime];
               AllHitXX[AllHitXX.length] = this;
               this.times = (_loc2_ as EnemySkin).attTimes;
               this.type = (_loc2_ as EnemySkin).type;
               this.space = (_loc2_ as EnemySkin).space;
               this.totalTime = (_loc2_ as EnemySkin).totalTime;
               this.numValue = (_loc2_ as EnemySkin).numValue;
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

