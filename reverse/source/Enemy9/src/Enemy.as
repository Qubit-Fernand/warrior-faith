package src
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.quest.Quest;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class Enemy extends MovieClip
   {
      
      public static var EnemyLoaded:Boolean;
      
      public static var EnemyXml:XML;
      
      public static var EnemyArr:Array = new Array();
      
      public static var All:Array = [];
      
      private var 硬直:Number;
      
      public var className:String;
      
      private var jump_time:* = 8;
      
      public var RL:Boolean = true;
      
      private var 掉落物品:Array = [];
      
      private var gravityNum:* = 0;
      
      private var gravity:int = 2;
      
      private var attack_XY:Array = [];
      
      private var parabola:Number = 0.2;
      
      public var runType:String = "自由";
      
      public var attack_TimeNum:Array = [];
      
      private var 掉落编号:int;
      
      public var 攻击力:Number;
      
      private var 等级:int;
      
      private var lastTime:int;
      
      public var attack_Time:Array = [];
      
      private var jumpType:int = 2;
      
      private var 浮动硬直:Number;
      
      public var distance_X:int;
      
      public var distance_Y:int;
      
      public var skinNum:int = 0;
      
      public var 防御力:int;
      
      public var lifeMAX:int = 100;
      
      private var 特殊掉落概率:Array = [];
      
      public var over:Boolean;
      
      private var guard_XY:Array = [10,10];
      
      private var jumping:Boolean;
      
      public var life:int = 100;
      
      public var 金钱:int;
      
      private var jumptemp:int;
      
      private var 原始硬直:Number;
      
      private var 掉落概率:Array = [];
      
      public var id:int;
      
      private var walk_power:* = 3;
      
      private var runY:int = 0;
      
      public var noMove:Boolean = false;
      
      private var runX:int = 0;
      
      public var iii:int = 0;
      
      public var skin:EnemySkin;
      
      private var 震退值:Number;
      
      public var hit:MovieClip = null;
      
      public var lifeMC:EnemyLife = new EnemyLife();
      
      private var 经验:int;
      
      public var skinArr:Array = [0,1];
      
      private var jump_power:* = 120;
      
      private var runArr:Array = new Array();
      
      private var 特殊掉落物品:Array = [];
      
      public function Enemy(param1:int = 0)
      {
         var _loc2_:String = null;
         super();
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         if(param1 != 0)
         {
            this.id = param1;
            _loc2_ = SkinData(param1);
            if(_loc2_ == null)
            {
               trace("怪物信息错误!! 找不到ID" + param1);
            }
            else
            {
               addSkin(_loc2_);
            }
         }
         else
         {
            trace("无法创建 怪物0");
         }
      }
      
      private function getRL(param1:Boolean) : *
      {
         this.RL = param1;
         if(param1)
         {
            skin.scaleX = -1;
         }
         else if(!param1)
         {
            skin.scaleX = 1;
         }
      }
      
      private function set_attack_Time() : *
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < attack_XY.length)
         {
            for(_loc2_ in EnemySkin.EnemySkinXml.怪物攻击)
            {
               _loc3_ = int(EnemySkin.EnemySkinXml.怪物攻击[_loc2_].ID);
               _loc4_ = String(EnemySkin.EnemySkinXml.怪物攻击[_loc2_].帧标签);
               if(id == _loc3_ && _loc4_ == "攻击" + (_loc1_ + 1))
               {
                  _loc5_ = int(EnemySkin.EnemySkinXml.怪物攻击[_loc2_].间隔);
                  attack_Time[_loc1_] = _loc5_;
                  attack_TimeNum[_loc1_] = int(_loc5_ * Math.random());
                  break;
               }
            }
            _loc1_++;
         }
      }
      
      public function HpXX(param1:HitXX, param2:Boolean = false) : *
      {
         var _loc3_:int = 0;
         var _loc4_:Player = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         _loc3_ = param1.times;
         _loc4_ = param1.who as Player;
         _loc5_ = 1;
         if(_loc4_.data.skinNum == 0)
         {
            _loc5_ = Number(_loc4_.职业附加[0]);
         }
         else if(_loc4_.data.skinNum == 1)
         {
            _loc5_ = Number(_loc4_.职业附加[1]);
         }
         else if(_loc4_.data.skinNum == 2)
         {
            _loc5_ = Number(_loc4_.职业附加[2]);
         }
         _loc6_ = _loc4_.use_gongji.getValue();
         _loc7_ = _loc6_ * param1.gongJi_hp * _loc5_;
         _loc7_ = _loc7_ + Math.random() * _loc7_ * 0.020001548555 + (Math.random() * 4 - 2);
         _loc8_ = _loc7_ * param1.who.shuangShouBeiShu - 防御力 / _loc3_;
         (param1.who as Player).energySlot.addEnergy(param1.who,_loc8_);
         _loc9_ = this.x + Math.random() * 100 - 50;
         _loc10_ = this.y + Math.random() * 100 - 50;
         if(param2)
         {
            NewMC.Open("_暴击数字",Main.world.moveChild_Other,_loc9_,_loc10_,25,_loc8_,true);
         }
         else
         {
            NewMC.Open("_攻击数字",Main.world.moveChild_Other,_loc9_,_loc10_,15,_loc8_,true);
         }
         if(_loc8_ > 0)
         {
            this.life -= _loc8_;
            _loc13_ = 100 - life / lifeMAX * 100;
            lifeMC.gotoAndStop(_loc13_);
            if(this.life <= 0)
            {
               life = 0;
               (param1.who as Player).ExpUP(this.经验);
               (param1.who as Player).MoneyUP(this.金钱);
               任务品掉落();
               装备掉落();
               return;
            }
         }
         _loc11_ = Math.random() * 2.000000757 / 10.000005588 + 0.200008498;
         浮动硬直 += _loc11_;
         _loc12_ = param1.硬直 - this.skin.被攻击硬直 - 浮动硬直;
         trace("XX = " + _loc12_ + ", rdm = " + _loc11_);
         if(_loc12_ >= 0)
         {
            skin.GoTo("被打",int(_loc12_));
            jump_power = 0;
         }
         if(震退值 != 0)
         {
            runArr = new Array();
            if(param1.RL)
            {
               runPower(-param1.runArr[0] * 震退值,param1.runArr[1] * 震退值,param1.runArr[2]);
            }
            else
            {
               runPower(param1.runArr[0] * 震退值,param1.runArr[1] * 震退值,param1.runArr[2]);
            }
         }
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         Main.world.moveChild_Enemy.addChild(this);
         All[All.length] = this;
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function 装备掉落() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Equip = null;
         var _loc5_:obj = null;
         var _loc6_:Gem = null;
         _loc1_ = int(掉落物品计算());
         _loc2_ = int(String(_loc1_).substr(1,1));
         if(_loc1_ != 0)
         {
            if(_loc2_ == 1)
            {
               _loc3_ = [_loc1_];
               _loc4_ = EquipFactory.createEquipByColorAndLevel(_loc3_);
               _loc5_ = new obj(_loc4_,this.x,this.y);
            }
            else if(_loc2_ == 2)
            {
               _loc3_ = [_loc1_];
               _loc6_ = GemFactory.createGemByColorAndLevel(_loc3_);
               _loc5_ = new obj(_loc6_,this.x,this.y);
            }
         }
      }
      
      private function getbagQuestNum() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if(特殊掉落物品[_loc4_] != 0)
            {
               _loc1_ = Number(特殊掉落物品[_loc4_]);
               _loc3_ = Number(QuestFactory.getType(_loc1_));
               if(_loc3_ == 1)
               {
                  if(Main.player2 == null)
                  {
                     return p1bagFall(_loc1_);
                  }
                  if(p1bagFall(_loc1_) || p2bagFall(_loc1_))
                  {
                     return true;
                  }
               }
               else if(_loc3_ == 2)
               {
                  if(Main.player2 == null)
                  {
                     if(p1bagFall(_loc1_))
                     {
                        return p1bagFall(_loc1_);
                     }
                  }
                  else
                  {
                     if(p1bagFall(_loc1_) && p2bagFall(_loc1_))
                     {
                        return true;
                     }
                     if(Boolean(SetTransferPanel.tbo1()) && p2bagFall(_loc1_))
                     {
                        return true;
                     }
                     if(Boolean(SetTransferPanel.tbo2()) && p1bagFall(_loc1_))
                     {
                        return true;
                     }
                  }
               }
            }
            _loc4_++;
         }
         return false;
      }
      
      private function Attack_TimeXX() : *
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < attack_TimeNum.length)
         {
            if(attack_TimeNum[_loc1_] < attack_Time[_loc1_])
            {
               ++attack_TimeNum[_loc1_];
            }
            _loc1_++;
         }
      }
      
      public function Dead() : *
      {
         this.parent.removeChild(this);
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function mainQuest() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc1_ = false;
         _loc2_ = false;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            if(特殊掉落物品[_loc3_] != 0)
            {
               _loc4_ = Number(特殊掉落物品[_loc3_]);
               _loc5_ = Number(QuestFactory.getType(_loc4_));
               if(_loc5_ == 1)
               {
                  return Main.getQuest(_loc4_);
               }
               if(_loc5_ == 2)
               {
                  _loc3_ = 0;
                  while(_loc3_ < 3)
                  {
                     if(Main.player2 == null)
                     {
                        return SetTransferPanel.tbo1();
                     }
                     if(Boolean(SetTransferPanel.tbo1()) && Boolean(SetTransferPanel.tbo2()))
                     {
                        return true;
                     }
                     _loc3_++;
                  }
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function p1bagFall(param1:Number) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = Number(Main.player1.getBag().fallQusetBag(param1));
         _loc3_ = Number(QuestFactory.getFallMax(param1));
         if(_loc2_ < _loc3_)
         {
            return false;
         }
         return true;
      }
      
      private function WhereAreYou() : *
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         if(Player.All.length > 0)
         {
            distance_X = this.x - Player.All[0].x;
            distance_Y = this.y - Player.All[0].y;
            _loc1_ = 1;
            while(_loc1_ < Player.All.length)
            {
               _loc2_ = this.x - Player.All[_loc1_].x;
               if(Math.abs(_loc2_) < Math.abs(distance_X))
               {
                  distance_X = _loc2_;
                  distance_Y = this.y - Player.All[_loc1_].y;
               }
               _loc1_++;
            }
         }
         else
         {
            distance_X = 0;
         }
      }
      
      private function MoveRun() : *
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 0;
         var _loc10_:* = undefined;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         if(runX > 0)
         {
            _loc1_ = true;
         }
         _loc2_ = int(this.runX);
         _loc3_ = int(this.runY);
         _loc4_ = int(this.x + Main.world.x);
         _loc5_ = int(this.y);
         _loc6_ = int(Math.abs(_loc3_));
         while(_loc6_ > 0)
         {
            if(this.jumpType == 1)
            {
               _loc8_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - this.height,true));
               if(!_loc8_)
               {
                  _loc9_ = 0;
                  while(_loc9_ < Main.world.numChildren)
                  {
                     _loc10_ = Main.world.getChildAt(_loc9_);
                     if(_loc10_ is Map && Boolean(_loc10_.MapData1.hitTestPoint(_loc4_,_loc5_ - this.height,true)))
                     {
                        _loc8_ = true;
                        break;
                     }
                     _loc9_++;
                  }
               }
               if(!_loc8_)
               {
                  _loc5_--;
               }
            }
            else if(this.jumpType == 2)
            {
               _loc11_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ - 3,true));
               _loc8_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true));
               _loc12_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true));
               _loc9_ = 0;
               while(_loc9_ < Main.world.numChildren)
               {
                  _loc10_ = Main.world.getChildAt(_loc9_);
                  if(_loc10_ is Map && Boolean(_loc10_.MapData.hitTestPoint(_loc4_,_loc5_ - 3,true)))
                  {
                     _loc11_ = true;
                  }
                  else if(_loc10_ is Map && Boolean(_loc10_.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true)))
                  {
                     _loc8_ = true;
                  }
                  else if(_loc10_ is Map && Boolean(_loc10_.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true)))
                  {
                     _loc12_ = true;
                  }
                  _loc9_++;
               }
               jumping = false;
               if(_loc11_)
               {
                  _loc5_ -= 2;
               }
               else if(_loc8_)
               {
                  runY = 0;
                  gravityNum = 0;
               }
               else if(_loc12_)
               {
                  _loc5_ += 3;
               }
               else
               {
                  _loc5_++;
                  this.jumping = true;
               }
            }
            else if(this.jumpType == 3)
            {
               _loc8_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - 1,true));
               _loc9_ = 0;
               while(_loc9_ < Main.world.numChildren)
               {
                  _loc10_ = Main.world.getChildAt(_loc9_);
                  if(_loc10_ is Map && Boolean(_loc10_.MapData1.hitTestPoint(_loc4_,_loc5_ - this.height,true)))
                  {
                     _loc8_ = true;
                  }
                  _loc9_++;
               }
               if(!_loc8_)
               {
                  jumpType = 2;
                  break;
               }
               _loc5_++;
            }
            _loc6_--;
         }
         this.y = _loc5_;
         if(_loc2_ > 0)
         {
            _loc7_ = _loc4_ - 20;
         }
         else
         {
            _loc7_ = _loc4_ + 20;
         }
         _loc6_ = int(Math.abs(_loc2_));
         while(_loc6_ > 0)
         {
            _loc8_ = Boolean(Main.world.MapData1.hitTestPoint(_loc7_,_loc5_ - 50,true));
            if(!_loc8_)
            {
               _loc9_ = 0;
               while(_loc9_ < Main.world.numChildren)
               {
                  _loc10_ = Main.world.getChildAt(_loc9_);
                  if(_loc10_ is Map && Boolean(_loc10_.MapData.hitTestPoint(_loc7_,_loc5_ - 50,true)))
                  {
                     _loc8_ = true;
                     break;
                  }
                  _loc9_++;
               }
            }
            if(!_loc8_)
            {
               if(_loc2_ > 0)
               {
                  _loc4_--;
               }
               else
               {
                  _loc4_++;
               }
            }
            _loc6_--;
         }
         this.x = _loc4_ - Main.world.x;
      }
      
      private function SkinData(param1:int) : String
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         for(_loc2_ in EnemyXml.怪物)
         {
            _loc3_ = int(EnemyXml.怪物[_loc2_].ID);
            if(_loc3_ == param1)
            {
               this.className = String(EnemyXml.怪物[_loc2_].名称);
               this.lifeMAX = this.life = int(EnemyXml.怪物[_loc2_].HP);
               this.walk_power = int(EnemyXml.怪物[_loc2_].移动速度);
               this.jumptemp = int(EnemyXml.怪物[_loc2_].跳跃力);
               this.jump_power = int(EnemyXml.怪物[_loc2_].跳跃力);
               this.jump_time = int(EnemyXml.怪物[_loc2_].跳跃时间);
               this.gravity = int(EnemyXml.怪物[_loc2_].重力);
               硬直 = 原始硬直 = int(EnemyXml.怪物[_loc2_].硬直);
               攻击力 = Number(EnemyXml.怪物[_loc2_].攻击力);
               防御力 = int(EnemyXml.怪物[_loc2_].防御力);
               震退值 = Number(EnemyXml.怪物[_loc2_].震退值);
               经验 = int(EnemyXml.怪物[_loc2_].经验);
               等级 = int(EnemyXml.怪物[_loc2_].等级);
               lastTime = int(EnemyXml.怪物[_loc2_].存在时间);
               金钱 = int(EnemyXml.怪物[_loc2_].金钱);
               _loc4_ = int(EnemyXml.怪物[_loc2_].警戒距离x);
               _loc5_ = _loc4_ * Math.random();
               guard_XY = [_loc5_,int(EnemyXml.怪物[_loc2_].警戒距离y)];
               _loc6_ = 0;
               while(_loc6_ < 6)
               {
                  if(int(EnemyXml.怪物[_loc2_]["攻击距离" + (_loc6_ + 1) + "x"]) != -1)
                  {
                     attack_XY[_loc6_] = [int(EnemyXml.怪物[_loc2_]["攻击距离" + (_loc6_ + 1) + "x"]),int(EnemyXml.怪物[_loc2_]["攻击距离" + (_loc6_ + 1) + "y"])];
                  }
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 20)
               {
                  掉落物品[_loc6_] = int(EnemyXml.怪物[_loc2_]["掉落物品" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 20)
               {
                  掉落概率[_loc6_] = int(EnemyXml.怪物[_loc2_]["掉落概率" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 3)
               {
                  特殊掉落物品[_loc6_] = int(EnemyXml.怪物[_loc2_]["特殊掉落ID" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 3)
               {
                  特殊掉落概率[_loc6_] = int(EnemyXml.怪物[_loc2_]["特殊概率ID" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               return String(EnemyXml.怪物[_loc2_].名称);
            }
         }
         return null;
      }
      
      private function 任务概率掉落计算() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         if(!mainQuest())
         {
            if(!getbagQuestNum())
            {
               _loc1_ = Math.random() * 10000 + 1;
            }
            else
            {
               _loc1_ = 99999;
            }
         }
         else
         {
            _loc1_ = 99999;
         }
         _loc2_ = 0;
         j = 0;
         while(j < 3)
         {
            _loc2_ += 特殊掉落概率[j];
            if(_loc2_ > _loc1_)
            {
               return 特殊掉落物品[j];
            }
            ++j;
         }
         return 0;
      }
      
      private function MoveData() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         WhereAreYou();
         Attack_TimeXX();
         _loc1_ = Math.abs(distance_X);
         _loc2_ = Math.abs(distance_Y);
         if(skin.runType == "站立" || skin.runType == "移动" || skin.runType == "跳")
         {
            _loc4_ = Math.random() * 20 + 20;
            _loc5_ = Math.random() * attack_XY.length;
            _loc6_ = "攻击" + (_loc5_ + 1);
            if(skin.continuousTime <= 0)
            {
               jump_power = jumptemp;
               if(attack_Time[_loc5_] == attack_TimeNum[_loc5_] && _loc1_ < attack_XY[_loc5_][0] && _loc2_ < attack_XY[_loc5_][1])
               {
                  if(distance_X > 0)
                  {
                     getRL(false);
                  }
                  else
                  {
                     getRL(true);
                  }
                  attack_TimeNum[_loc5_] = 0;
                  skin.GoTo(_loc6_);
                  this.浮动硬直 = 0;
               }
               else if(_loc1_ < 50 && _loc2_ < 500)
               {
                  this.skin.GoTo("站立");
               }
               else if(distance_X > guard_XY[0])
               {
                  runPower(this.walk_power,0,1);
                  getRL(false);
                  skin.GoTo("移动");
               }
               else if(distance_X < -guard_XY[0])
               {
                  runPower(-this.walk_power,0,1);
                  getRL(true);
                  skin.GoTo("移动");
               }
               else
               {
                  this.skin.GoTo("站立");
               }
            }
            _loc7_ = Math.random() * 60;
            if(_loc7_ == 0 && !jumping)
            {
               if(RL)
               {
                  runPower(-walk_power * 0.8,jump_power,jump_time);
               }
               else
               {
                  runPower(walk_power * 0.8,jump_power,jump_time);
               }
            }
         }
         runX = runY = 0;
         _loc3_ = int(runArr.length - 1);
         while(_loc3_ >= 0)
         {
            if(runArr[_loc3_][2] > 0)
            {
               runX += runArr[_loc3_][0] + runArr[_loc3_][3] * runArr[_loc3_][2];
               runY -= runArr[_loc3_][1] + runArr[_loc3_][4] * runArr[_loc3_][2];
               --runArr[_loc3_][2];
            }
            else
            {
               runArr.splice(_loc3_,1);
            }
            _loc3_--;
         }
         if(runY < 0)
         {
            jumpType = 1;
            gravityNum = 0;
            jumping = true;
         }
         else
         {
            jumpType = 2;
            if(gravity != 0)
            {
               gravityNum += 1;
            }
            runY += gravity * gravityNum;
         }
      }
      
      public function runPower(param1:Number = 0, param2:Number = 0, param3:int = 0) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param3 <= 3)
         {
            runArr[runArr.length] = [param1,param2,1,0,0,0];
            return;
         }
         _loc4_ = param1 / param3 * parabola;
         _loc5_ = param2 / param3 * parabola;
         _loc6_ = param1 * (1 - parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         _loc7_ = param2 * (1 - parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         runArr[runArr.length] = [_loc4_,_loc5_,param3,_loc6_,_loc7_];
      }
      
      private function 掉落物品计算() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = Math.random() * 10000 + 1;
         _loc2_ = 0;
         j = 0;
         while(j < 20)
         {
            _loc2_ += 掉落概率[j];
            if(_loc2_ > _loc1_)
            {
               return 掉落物品[j];
            }
            ++j;
         }
         return 0;
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         this.skin.Over();
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function 任务品掉落() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Quest = null;
         var _loc3_:obj = null;
         _loc1_ = int(任务概率掉落计算());
         if(_loc1_ != 0)
         {
            _loc2_ = QuestFactory.creatQust(_loc1_);
            _loc3_ = new obj(_loc2_,this.x,this.y);
         }
      }
      
      public function p2bagFall(param1:Number) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = Number(Main.player2.getBag().fallQusetBag(param1));
         _loc3_ = Number(QuestFactory.getFallMax(param1));
         if(_loc2_ < _loc3_)
         {
            return false;
         }
         return true;
      }
      
      private function addSkin(param1:String) : *
      {
         var _loc2_:Class = null;
         _loc2_ = EnemyArr[Main.gameNum].getClass(param1) as Class;
         this.skin = new _loc2_();
         addChild(skin);
         set_attack_Time();
         addChild(lifeMC);
         lifeMC.stop();
         lifeMC.y = -this.skin.height;
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         if(lastTime > -1)
         {
            --lastTime;
            if(lastTime == 0)
            {
               skin.GoTo("死亡");
               removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
            }
         }
         if(life > 0)
         {
            MoveData();
            if(!noMove)
            {
               MoveRun();
            }
         }
         else
         {
            skin.GoTo("死亡");
            removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         }
      }
      
      private function SkinValue() : *
      {
         if(skin != null)
         {
            this.gravity = this.skin.gravity;
            if(skin.moveArr != null)
            {
               if(RL)
               {
                  runPower(skin.moveArr[0],skin.moveArr[1],skin.moveArr[2]);
               }
               else
               {
                  runPower(-skin.moveArr[0],skin.moveArr[1],skin.moveArr[2]);
               }
            }
         }
      }
   }
}

