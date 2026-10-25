package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.quest.Quest;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.cardPanel.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import src.Skin.*;
   import src.tool.*;
   
   public class Enemy extends MovieClip
   {
      
      public static var EnemyXml:XML;
      
      public static var xuanshang5:Boolean = true;
      
      public static var EnemyArr:Array = new Array();
      
      public static var EnemyXmlArrMd5:Array = new Array();
      
      public static var EnemyXmlArr:Array = new Array();
      
      public static var All:Array = [];
      
      public static var gongJiPOWER:VT = VT.createVT();
      
      public static var bool_5:Boolean = true;
      
      public static var bool_6:Boolean = true;
      
      public var cengshu:Array = [];
      
      public var iii:int = 0;
      
      public var id:int;
      
      public var className:String;
      
      public var lifeMAX:VT = VT.createVT();
      
      public var life:VT = VT.createVT();
      
      public var RL:Boolean = true;
      
      public var over:Boolean;
      
      public var skinArr:Array = [0,1];
      
      public var skinNum:int = 0;
      
      public var skin:EnemySkin;
      
      public var hitXX:HitXX;
      
      public var hit:MovieClip = null;
      
      private var jumptemp:int;
      
      private var walk_power:* = 3;
      
      private var jump_power:* = 120;
      
      private var jump_time:* = 8;
      
      private var parabola:Number = 0.2;
      
      private var jumping:Boolean;
      
      private var jumpType:int = 2;
      
      private var gravity:int = 2;
      
      private var gravityNum:* = 0;
      
      private var lastTime:int;
      
      public var 硬直:VT = VT.createVT();
      
      public var 攻击力:VT = VT.createVT();
      
      public var 防御力:VT = VT.createVT();
      
      public var 魔攻力:VT = VT.createVT();
      
      public var 魔防力:VT = VT.createVT();
      
      private var 震退值:VT = VT.createVT();
      
      private var 经验:VT = VT.createVT();
      
      private var 等级:VT = VT.createVT();
      
      private var 掉落物品:Array = [];
      
      private var 掉落概率:Array = [];
      
      public var 金钱:VT = VT.createVT();
      
      private var 掉落数量:VT = VT.createVT();
      
      private var 浮动硬直:Number = 0;
      
      public var 关卡:int = 0;
      
      public var distance_X:int;
      
      public var distance_Y:int;
      
      private var guard_XY:Array = [10,10];
      
      private var attack_XY:Array = [];
      
      public var attack_Time:Array = [];
      
      public var attack_TimeNum:Array = [];
      
      public var runType:String = "自由";
      
      public var noMove:Boolean = false;
      
      public var lifeMC:EnemyLife = new EnemyLife();
      
      private var temp2:VT = VT.createVT(2);
      
      private var temp3:VT = VT.createVT(3);
      
      private var temp10:VT = VT.createVT(10);
      
      private var tempXXX2:VT = VT.createVT(VT.GetTempVT("8/4"));
      
      internal var temp:String;
      
      internal var tempXX:String;
      
      internal var tempTimeXX:int = 0;
      
      private var runX:int = 0;
      
      private var runY:int = 0;
      
      private var runArr:Array = new Array();
      
      public var EnemySkinXml:XML = new XML();
      
      private var 特殊掉落物品:Array = [];
      
      private var 特殊掉落概率:Array = [];
      
      public function Enemy(param1:int = 0)
      {
         var _loc2_:String = null;
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         if(param1 != 0)
         {
            this.id = param1;
            _loc2_ = this.SkinData(param1);
            if(_loc2_ == null)
            {
               trace("怪物信息错误!! 找不到ID" + param1);
            }
            else
            {
               this.addSkin(_loc2_);
               All[All.length] = this;
               this.skin.EnemySkinXml = EnemySkin.EnemySkinXmlArr[GameData.gameLV][this.关卡];
            }
         }
         else
         {
            trace("无法创建 怪物0");
         }
      }
      
      private function addSkin(param1:String) : *
      {
         var _loc2_:Class = EnemyArr[this.关卡].getClass(param1) as Class;
         this.skin = new _loc2_();
         addChild(this.skin);
         this.set_attack_Time();
         addChild(this.lifeMC);
         this.lifeMC.stop();
         this.lifeMC.y = -this.skin.height;
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
               this.lifeMAX.setValue(int(EnemyXml.怪物[_loc2_].HP));
               this.life.setValue(int(EnemyXml.怪物[_loc2_].HP));
               this.walk_power = int(EnemyXml.怪物[_loc2_].移动速度);
               this.jumptemp = int(EnemyXml.怪物[_loc2_].跳跃力);
               this.jump_power = int(EnemyXml.怪物[_loc2_].跳跃力);
               this.jump_time = int(EnemyXml.怪物[_loc2_].跳跃时间);
               this.gravity = int(EnemyXml.怪物[_loc2_].重力);
               this.攻击力.setValue(Number(EnemyXml.怪物[_loc2_].攻击力));
               this.防御力.setValue(int(EnemyXml.怪物[_loc2_].防御力));
               this.魔攻力.setValue(int(EnemyXml.怪物[_loc2_].魔攻力));
               this.魔防力.setValue(int(EnemyXml.怪物[_loc2_].魔防力));
               this.震退值.setValue(Number(EnemyXml.怪物[_loc2_].震退值));
               this.经验.setValue(int(EnemyXml.怪物[_loc2_].经验));
               this.等级.setValue(int(EnemyXml.怪物[_loc2_].等级));
               this.lastTime = int(EnemyXml.怪物[_loc2_].存在时间);
               this.金钱.setValue(int(EnemyXml.怪物[_loc2_].金钱));
               this.掉落数量.setValue(int(EnemyXml.怪物[_loc2_].掉落数量));
               this.硬直.setValue(Number(EnemyXml.怪物[_loc2_].硬直));
               this.关卡 = int(EnemyXml.怪物[_loc2_].关卡);
               _loc4_ = int(EnemyXml.怪物[_loc2_].警戒距离x);
               _loc5_ = _loc4_ - Math.random() * 51;
               if(_loc5_ < 0)
               {
                  _loc5_ = 0;
               }
               this.guard_XY = [_loc5_,int(EnemyXml.怪物[_loc2_].警戒距离y)];
               _loc6_ = 0;
               while(_loc6_ < 6)
               {
                  if(int(EnemyXml.怪物[_loc2_]["攻击距离" + (_loc6_ + 1) + "x"]) != -1)
                  {
                     this.attack_XY[_loc6_] = [int(EnemyXml.怪物[_loc2_]["攻击距离" + (_loc6_ + 1) + "x"]),int(EnemyXml.怪物[_loc2_]["攻击距离" + (_loc6_ + 1) + "y"])];
                  }
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 20)
               {
                  this.掉落物品[_loc6_] = int(EnemyXml.怪物[_loc2_]["掉落物品" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 20)
               {
                  this.掉落概率[_loc6_] = int(EnemyXml.怪物[_loc2_]["掉落概率" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 3)
               {
                  this.特殊掉落物品[_loc6_] = int(EnemyXml.怪物[_loc2_]["特殊掉落ID" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               _loc6_ = 0;
               while(_loc6_ < 3)
               {
                  this.特殊掉落概率[_loc6_] = int(EnemyXml.怪物[_loc2_]["特殊概率ID" + (_loc6_ + 1)]);
                  _loc6_++;
               }
               return String(EnemyXml.怪物[_loc2_].名称);
            }
         }
         return null;
      }
      
      public function getRandom(param1:Number) : Boolean
      {
         var _loc2_:Number = Math.random() * 100;
         if(_loc2_ < param1)
         {
            return true;
         }
         return false;
      }
      
      public function HpXX(param1:HitXX, param2:Boolean = false, param3:Boolean = false) : *
      {
         var _loc6_:Player = null;
         var _loc7_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Array = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Array = null;
         var _loc19_:String = null;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         this.hitXX = param1;
         var _loc4_:int = param1.times;
         var _loc5_:Number = 1;
         var _loc8_:int = this.x + Math.random() * 100 - 50;
         var _loc9_:int = this.y + Math.random() * 100 - 50;
         if(param1.who is Player)
         {
            ChongWu.gongJiYn1 = ChongWu.gongJiYn2 = true;
            _loc6_ = param1.who as Player;
            if(_loc6_.data.skinArr[_loc6_.data.skinNum] == 0)
            {
               _loc5_ = Number(_loc6_.职业附加[0]);
            }
            else if(_loc6_.data.skinArr[_loc6_.data.skinNum] == 1)
            {
               _loc5_ = Number(_loc6_.职业附加[1]);
            }
            else if(_loc6_.data.skinArr[_loc6_.data.skinNum] == 2)
            {
               _loc5_ = Number(_loc6_.职业附加[2]);
            }
            _loc12_ = _loc6_.use_gongji.getValue();
            _loc13_ = _loc12_ * param1.gongJi_hp * _loc5_;
            _loc13_ = _loc13_ + _loc13_ * Math.random() * InitData.X002.getValue() + gongJiPOWER.getValue();
            _loc7_ = _loc13_ - this.防御力.getValue() / _loc4_;
            if(_loc7_ <= 0)
            {
               _loc7_ = 0;
            }
            if(param2)
            {
               _loc7_ *= this.tempXXX2.getValue();
            }
            _loc6_.energySlot.addEnergy(param1.who,_loc7_);
            _loc14_ = _loc6_.data.getEquipSlot().getAllSuitSkill();
            _loc15_ = 0;
            for(_loc16_ in _loc14_)
            {
               if(_loc14_[_loc16_] == 57359)
               {
                  if(this.getRandom(30) && _loc6_.flagTempSY)
                  {
                     _loc6_.setInTimeCDSY();
                     _loc6_.flagTempSY = false;
                     _loc6_.HpUp(_loc6_.use_hp_Max.getValue() * 0.035);
                     _loc17_ = _loc6_.use_hp_Max.getValue();
                     if(param1.who is Player && Main.water.getValue() != 1)
                     {
                        _loc17_ = _loc17_ * (1 + (param1.who as Player).use_gongji2.getValue() / 100) / (1 + this.魔防力.getValue() / 100);
                     }
                     for(_loc16_ in All)
                     {
                        this.HpSXX(All[_loc16_],_loc17_);
                     }
                  }
               }
               else if(_loc14_[_loc16_] == 57360)
               {
                  if(this.getRandom(5) && _loc6_.flagTempSJ)
                  {
                     _loc6_.setInTimeCDSJ();
                     _loc6_.flagTempSJ = false;
                     _loc18_ = [];
                     _loc19_ = "";
                     if(_loc6_.data.skinArr[_loc6_.data.skinNum] == 0)
                     {
                        _loc19_ = "a";
                     }
                     else if(_loc6_.data.skinArr[_loc6_.data.skinNum] == 1)
                     {
                        _loc19_ = "b";
                     }
                     else
                     {
                        _loc19_ = "c";
                     }
                     for(_loc20_ in _loc6_.AllSkillCDXX)
                     {
                        if((_loc6_.AllSkillCDXX[_loc20_][0] as String).substr(0,1) == _loc19_ && int((_loc6_.AllSkillCDXX[_loc20_][0] as String).substr(1,2)) > 7 && int((_loc6_.AllSkillCDXX[_loc20_][0] as String).substr(1,2)) <= 15)
                        {
                           if(_loc6_.data.getSkillLevel(_loc6_.AllSkillCDXX[_loc20_][0]) > 0 && _loc6_.AllSkillCDXX[_loc20_][1] != _loc6_.AllSkillCD[_loc20_][1])
                           {
                              _loc18_.push(_loc20_);
                           }
                        }
                     }
                     if(_loc18_.length > 0)
                     {
                        _loc21_ = Math.random() * _loc18_.length;
                        _loc6_.AllSkillCDXX[_loc18_[_loc21_]][1] = _loc6_.AllSkillCD[_loc18_[_loc21_]][1];
                        _loc6_.AllSkillCDXX[_loc18_[_loc21_]][2] = 50;
                     }
                  }
               }
               else if(_loc14_[_loc16_] == 57361)
               {
                  _loc22_ = Math.pow(Number(_loc6_.use_baoji.getValue() / 70),0.8) / 100;
                  _loc23_ = Math.pow(1 + _loc22_,4.7);
                  if(this.getRandom(1.8) && _loc6_.flagTempBJ && param2)
                  {
                     _loc6_.setInTimeCDBJ();
                     _loc6_.flagTempBJ = false;
                     if(_loc6_.data.skinNum == 0)
                     {
                        _loc15_ = int(_loc6_.data.getEquipSlot().getEquipFromSlot(2).getAttack() * _loc23_);
                     }
                     else
                     {
                        _loc15_ = int(_loc6_.data.getEquipSlot().getEquipFromSlot(5).getAttack() * _loc23_);
                     }
                     if(param1.who is Player && Main.water.getValue() != 1)
                     {
                        _loc15_ = _loc15_ * (1 + (param1.who as Player).use_gongji2.getValue() / 100) / (1 + this.魔防力.getValue() / 100);
                     }
                     if(_loc15_ > 650000)
                     {
                        _loc15_ = 650000;
                     }
                     NewMC.Open("_特殊数字",Main.world.moveChild_Other,_loc8_,_loc9_ - 50,20,_loc15_,true);
                  }
                  else if(param2)
                  {
                     _loc24_ = Number(Math.pow(Number((param1.who as Player).use_baoji.getValue() / 70),InitData.Temp8.getValue()).toFixed(1));
                     _loc7_ *= 1 + _loc24_ / InitData.BuyNum_2000.getValue();
                  }
               }
               else if(_loc14_[_loc16_] != 57362)
               {
                  if(_loc14_[_loc16_] == 57363)
                  {
                     if(this.getRandom(15) && _loc6_.flagTempXL)
                     {
                        _loc6_.setInTimeCDXL();
                        _loc6_.flagTempXL = false;
                        _loc15_ = (_loc6_.use_mp_Max.getValue() + _loc6_.mp.getValue()) * ((_loc6_.use_mp_Max.getValue() + _loc6_.mp.getValue()) / 10000);
                        if(param1.who is Player && Main.water.getValue() != 1)
                        {
                           _loc15_ = _loc15_ * (1 + (param1.who as Player).use_gongji2.getValue() / 100) / (1 + this.魔防力.getValue() / 100);
                        }
                        if(_loc15_ > 650000)
                        {
                           _loc15_ = 650000;
                        }
                        NewMC.Open("_特殊数字",Main.world.moveChild_Other,_loc8_,_loc9_ - 50,20,_loc15_,true);
                     }
                  }
               }
            }
         }
         else
         {
            _loc7_ = param1.gongJi_hp;
            if(_loc7_ <= 0)
            {
               _loc7_ = 0;
            }
         }
         if(param1.who is Player && Main.water.getValue() != 1)
         {
            _loc7_ = _loc7_ * (1 + (param1.who as Player).use_gongji2.getValue() / 100) / (1 + this.魔防力.getValue() / 100);
         }
         if(this.className == "阿卡利")
         {
            _loc25_ = Math.random() * 100;
            if(_loc25_ < 3)
            {
               this.skin.otherGoTo("攻击5");
               return;
            }
         }
         if(param2)
         {
            if(this.id == 31)
            {
               NewMC.Open("_暴击数字",Main.world.moveChild_Other,_loc8_,_loc9_ - 200,20,_loc7_,true);
            }
            else if(this.id != 5003)
            {
               NewMC.Open("_暴击数字",Main.world.moveChild_Other,_loc8_,_loc9_,20,_loc7_,true);
            }
         }
         else if(this.id == 31)
         {
            NewMC.Open("_攻击数字",Main.world.moveChild_Other,_loc8_,_loc9_ - 200,15,_loc7_,true);
         }
         else if(this.id != 5003)
         {
            NewMC.Open("_攻击数字",Main.world.moveChild_Other,_loc8_,_loc9_,15,_loc7_,true);
         }
         if(_loc7_ > 0 && this.life.getValue() > 0)
         {
            this.life.setValue(this.life.getValue() - _loc7_);
            this.life.setValue(this.life.getValue() - _loc15_);
            WinShow.txt_4 += _loc7_;
            _loc26_ = 100 - this.life.getValue() / this.lifeMAX.getValue() * 100;
            this.lifeMC.gotoAndStop(_loc26_);
            if(this.life.getValue() <= 0)
            {
               this.life.setValue(0);
               Main.player_1.ExpUP(this.经验.getValue() * InitData.GetEXPxN().getValue());
               Main.player_1.MoneyUP(this.金钱.getValue());
               if(Main.P1P2)
               {
                  Main.player_2.ExpUP(this.经验.getValue() * InitData.GetEXPxN().getValue());
                  Main.player_2.MoneyUP(this.金钱.getValue());
               }
               this.任务品掉落();
               this.装备掉落();
               AchData.addEnemyNum(this.id);
               TaskData.setEnemyNum(this.id);
               TaskData.isEnemyTaskOk();
               CardPanel.monsterSlot.addMonsterCard(this.id);
               return;
            }
         }
         var _loc10_:Number = Math.random() * this.temp3.getValue() / this.temp10.getValue();
         this.浮动硬直 += _loc10_;
         var _loc11_:Number = param1.硬直 - this.skin.被攻击硬直 - this.浮动硬直;
         if(_loc11_ >= this.skin.continuousTime)
         {
            _loc11_ = param1.硬直 - this.硬直.getValue() - this.浮动硬直;
         }
         if(_loc11_ >= 0)
         {
            this.skin.GoTo("被打",int(_loc11_));
            this.jump_power = 0;
         }
         if(this.震退值.getValue() != 0)
         {
            this.runArr = new Array();
            if(param1.RL)
            {
               this.runPower(-param1.runArr[0] * this.震退值.getValue(),param1.runArr[1] * this.震退值.getValue(),param1.runArr[2]);
            }
            else
            {
               this.runPower(param1.runArr[0] * this.震退值.getValue(),param1.runArr[1] * this.震退值.getValue(),param1.runArr[2]);
            }
         }
      }
      
      private function HpSXX(param1:Enemy, param2:Number) : *
      {
         var _loc5_:int = 0;
         if(param2 > 650000)
         {
            param2 = 650000;
         }
         var _loc3_:int = param1.x + Math.random() * 100 - 50;
         var _loc4_:int = param1.y + Math.random() * 100 - 50;
         NewMC.Open("_特殊数字",Main.world.moveChild_Other,_loc3_,_loc4_ - 50,20,param2,true);
         if(param2 > 0 && param1.life.getValue() > 0)
         {
            param1.life.setValue(param1.life.getValue() - param2);
            _loc5_ = 100 - param1.life.getValue() / param1.lifeMAX.getValue() * 100;
            param1.lifeMC.gotoAndStop(_loc5_);
            if(param1.life.getValue() <= 0)
            {
               param1.life.setValue(0);
               Main.player_1.ExpUP(param1.经验.getValue() * InitData.GetEXPxN().getValue());
               Main.player_1.MoneyUP(param1.金钱.getValue());
               if(Main.P1P2)
               {
                  Main.player_2.ExpUP(param1.经验.getValue() * InitData.GetEXPxN().getValue());
                  Main.player_2.MoneyUP(param1.金钱.getValue());
               }
               param1.任务品掉落();
               param1.装备掉落();
               AchData.addEnemyNum(param1.id);
               TaskData.setEnemyNum(param1.id);
               TaskData.isEnemyTaskOk();
            }
         }
      }
      
      private function shengdandiaoluo(param1:int) : *
      {
         var _loc2_:int = Math.random() * 100;
         var _loc3_:int = 0;
         while(_loc3_ < InitData.shengdanArr.length)
         {
            if(InitData.shengdanArr[_loc3_][0] == param1)
            {
               if(InitData.shengdanArr[_loc3_][1] > _loc2_)
               {
                  Main.addShengDan();
               }
            }
            _loc3_++;
         }
      }
      
      private function 装备掉落() : *
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:Array = null;
         var _loc9_:Equip = null;
         var _loc10_:obj = null;
         var _loc11_:Gem = null;
         var _loc12_:Otherobj = null;
         var _loc1_:uint = this.掉落数量.getValue() * InitData.GetDOWNxN().getValue();
         var _loc2_:int = 0;
         while(_loc2_ < Main.player1.getTitleSlot().getListLength())
         {
            if(Main.player1.getTitleSlot().getTitleFromSlot(_loc2_).getId() == 25)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = int(this.掉落物品计算());
            _loc5_ = int(String(_loc4_).substr(1,1));
            _loc6_ = int(String(_loc4_).substr(0,1));
            _loc7_ = this.x + Math.random() * 200 - 100;
            if(_loc4_ != 0)
            {
               if(_loc5_ == 1)
               {
                  _loc8_ = [_loc4_];
                  _loc9_ = EquipFactory.createEquipByColorAndLevel(_loc8_);
                  _loc10_ = new obj(_loc9_,_loc7_,this.y - 100);
               }
               else if(_loc5_ == 2)
               {
                  _loc8_ = [_loc4_];
                  _loc11_ = GemFactory.createGemByColorAndLevel(_loc8_);
                  _loc10_ = new obj(_loc11_,_loc7_,this.y - 100);
               }
               if(_loc6_ == 6)
               {
                  _loc12_ = OtherFactory.creatOther(_loc4_);
                  _loc10_ = new obj(_loc12_,_loc7_,this.y - 100);
               }
            }
            _loc3_++;
         }
      }
      
      private function 掉落物品计算() : int
      {
         var _loc1_:int = Math.random() * 10000 + 1;
         var _loc2_:int = 0;
         j = 0;
         while(j < 20)
         {
            _loc2_ += this.掉落概率[j];
            if(_loc2_ >= _loc1_)
            {
               return this.掉落物品[j];
            }
            ++j;
         }
         return 0;
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         Main.world.moveChild_Enemy.addChild(this);
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onREMOVED_FROM_STAGE);
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         this.skin.Over();
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function Dead() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
            this.life.setValue(0);
         }
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         if(this.lastTime > -1)
         {
            --this.lastTime;
            if(this.lastTime == 0)
            {
               this.life.setValue(0);
               removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
            }
         }
         if(this.life.getValue() > 0)
         {
            this.MoveData();
            if(!this.noMove)
            {
               this.MoveRun();
            }
         }
         else
         {
            this.skin.GoTo("死亡");
            removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         }
      }
      
      internal function test() : *
      {
         if(Main.player_1.skin.runType == "技能1" || Main.player_1.skin.runType == "技能2" || Main.player_1.skin.runType == "技能3" || Main.player_1.skin.runType == "技能4" || Main.player_1.skin.runType == "转职技能1" || Main.player_1.skin.runType == "转职技能2" || Main.player_1.skin.runType == "转职技能3" || Main.player_1.skin.runType == "转职技能4")
         {
            this.temp = Main.player_1.skin.runType;
            if(this.temp != this.tempXX && this.tempTimeXX > 5)
            {
               this.tempXX = this.temp;
               this.tempTimeXX = 0;
               this.skin.GoTo("攻击5");
            }
            return;
         }
      }
      
      private function MoveData() : *
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         this.WhereAreYou();
         this.Attack_TimeXX();
         var _loc1_:* = Math.abs(this.distance_X);
         var _loc2_:* = Math.abs(this.distance_Y);
         if(this.skin.runType == "站立" || this.skin.runType == "移动" || this.skin.runType == "跳")
         {
            _loc4_ = Math.random() * this.attack_XY.length;
            _loc5_ = "攻击" + (_loc4_ + 1);
            if(this.skin.continuousTime <= 0)
            {
               this.jump_power = this.jumptemp;
               if(this.attack_Time[_loc4_] == this.attack_TimeNum[_loc4_] && _loc1_ < this.attack_XY[_loc4_][0] && _loc2_ < this.attack_XY[_loc4_][1])
               {
                  if(this.distance_X > 0)
                  {
                     this.getRL(false);
                  }
                  else
                  {
                     this.getRL(true);
                  }
                  this.attack_TimeNum[_loc4_] = 0;
                  if(this.className == "金牛座")
                  {
                     trace("技能是 = " + _loc4_);
                     if(_loc4_ == 4 && bool_5)
                     {
                        this.skin.GoTo(_loc5_);
                        bool_6 = false;
                        bool_5 = false;
                     }
                     else if(_loc4_ == 5 && bool_6)
                     {
                        this.skin.GoTo(_loc5_);
                        bool_5 = false;
                        bool_6 = false;
                     }
                     else if(_loc4_ < 4)
                     {
                        this.skin.GoTo(_loc5_);
                     }
                  }
                  else
                  {
                     if(this.className == "BOSS_53")
                     {
                        ++this.tempTimeXX;
                        this.test();
                        if(_loc4_ == 4)
                        {
                           return;
                        }
                     }
                     if(this.className == "悬赏5")
                     {
                        if(_loc4_ == 3 && xuanshang5 == false || _loc4_ == 4 && xuanshang5 == false)
                        {
                           return;
                        }
                        if(_loc4_ == 3 && xuanshang5 == true)
                        {
                           xuanshang5 = false;
                        }
                        if(_loc4_ == 4 && xuanshang5 == true)
                        {
                           xuanshang5 = false;
                        }
                     }
                     this.skin.GoTo(_loc5_);
                  }
                  this.浮动硬直 = 0;
               }
               else
               {
                  if(this.className == "火鸟王" || this.id == 5005 || this.id == 5006)
                  {
                     this.skin.GoTo("移动");
                     return;
                  }
                  if(_loc1_ < 50 && _loc2_ < 500)
                  {
                     this.skin.GoTo("站立");
                  }
                  else if(this.distance_X > this.guard_XY[0])
                  {
                     this.runPower(this.walk_power,0,1);
                     this.getRL(false);
                     this.skin.GoTo("移动");
                  }
                  else if(this.distance_X < -this.guard_XY[0])
                  {
                     this.runPower(-this.walk_power,0,1);
                     this.getRL(true);
                     this.skin.GoTo("移动");
                  }
                  else
                  {
                     this.skin.GoTo("站立");
                  }
               }
            }
            _loc6_ = Math.random() * 60;
            if(_loc6_ == 0 && !this.jumping)
            {
               if(this.RL)
               {
                  this.runPower(-this.walk_power * 0.8,this.jump_power,this.jump_time);
               }
               else
               {
                  this.runPower(this.walk_power * 0.8,this.jump_power,this.jump_time);
               }
            }
         }
         this.runX = this.runY = 0;
         var _loc3_:* = int(this.runArr.length - 1);
         while(_loc3_ >= 0)
         {
            if(this.runArr[_loc3_][2] > 0)
            {
               this.runX += this.runArr[_loc3_][0] + this.runArr[_loc3_][3] * this.runArr[_loc3_][2];
               this.runY -= this.runArr[_loc3_][1] + this.runArr[_loc3_][4] * this.runArr[_loc3_][2];
               --this.runArr[_loc3_][2];
            }
            else
            {
               this.runArr.splice(_loc3_,1);
            }
            _loc3_--;
         }
         if(this.runY < 0)
         {
            this.jumpType = 1;
            this.gravityNum = 0;
            this.jumping = true;
         }
         else
         {
            this.jumpType = 2;
            if(this.gravity != 0)
            {
               this.gravityNum += 1;
            }
            this.runY += this.gravity * this.gravityNum;
         }
      }
      
      private function WhereAreYou() : *
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         if(Player.All.length > 0)
         {
            this.distance_X = this.x - Player.All[0].x;
            this.distance_Y = this.y - Player.All[0].y;
            _loc1_ = 1;
            while(_loc1_ < Player.All.length)
            {
               _loc2_ = this.x - Player.All[_loc1_].x;
               if(Math.abs(_loc2_) < Math.abs(this.distance_X))
               {
                  this.distance_X = _loc2_;
                  this.distance_Y = this.y - Player.All[_loc1_].y;
               }
               _loc1_++;
            }
         }
         else
         {
            this.distance_X = 0;
         }
      }
      
      private function MoveRun() : *
      {
         var _loc1_:Boolean = false;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:uint = 0;
         var _loc11_:* = undefined;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         if(this.runX > 0)
         {
            _loc1_ = true;
         }
         var _loc2_:int = int(this.runX);
         var _loc3_:int = int(this.runY);
         var _loc4_:* = int(this.x + Main.world.x);
         var _loc5_:* = int(this.y);
         _loc6_ = int(Math.abs(_loc3_));
         while(_loc6_ > 0)
         {
            if(this.jumpType == 1)
            {
               _loc9_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - this.height,true));
               if(!_loc9_)
               {
                  _loc10_ = 0;
                  while(_loc10_ < Main.world.numChildren)
                  {
                     _loc11_ = Main.world.getChildAt(_loc10_);
                     if(_loc11_ is Map && Boolean(_loc11_.MapData1.hitTestPoint(_loc4_,_loc5_ - this.height,true)))
                     {
                        _loc9_ = true;
                        break;
                     }
                     _loc10_++;
                  }
               }
               if(!_loc9_)
               {
                  _loc5_--;
               }
            }
            else if(this.jumpType == 2)
            {
               _loc12_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ - 3,true));
               _loc9_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true));
               _loc13_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true));
               _loc10_ = 0;
               while(_loc10_ < Main.world.numChildren)
               {
                  _loc11_ = Main.world.getChildAt(_loc10_);
                  if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_,_loc5_ - 3,true)))
                  {
                     _loc12_ = true;
                  }
                  else if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true)))
                  {
                     _loc9_ = true;
                  }
                  else if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true)))
                  {
                     _loc13_ = true;
                  }
                  _loc10_++;
               }
               this.jumping = false;
               if(_loc12_)
               {
                  _loc5_ -= 2;
               }
               else if(_loc9_)
               {
                  this.runY = 0;
                  this.gravityNum = 0;
               }
               else if(_loc13_)
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
               _loc9_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - 1,true));
               _loc10_ = 0;
               while(_loc10_ < Main.world.numChildren)
               {
                  _loc11_ = Main.world.getChildAt(_loc10_);
                  if(_loc11_ is Map && Boolean(_loc11_.MapData1.hitTestPoint(_loc4_,_loc5_ - this.height,true)))
                  {
                     _loc9_ = true;
                  }
                  _loc10_++;
               }
               if(!_loc9_)
               {
                  this.jumpType = 2;
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
            _loc9_ = Boolean(Main.world.MapData1.hitTestPoint(_loc7_,_loc5_ - 50,true));
            if(!_loc9_)
            {
               _loc10_ = 0;
               while(_loc10_ < Main.world.numChildren)
               {
                  _loc11_ = Main.world.getChildAt(_loc10_);
                  if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc7_,_loc5_ - 50,true)))
                  {
                     _loc9_ = true;
                     break;
                  }
                  _loc10_++;
               }
            }
            if(!_loc9_)
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
         var _loc8_:int = _loc4_ - Main.world.x;
         if(_loc8_ > Main.world._width + 200)
         {
            this.x = Main.world._width + 200;
         }
         else if(_loc8_ < -200)
         {
            this.x = -200;
         }
         else
         {
            this.x = _loc8_;
         }
      }
      
      public function runPower(param1:Number = 0, param2:Number = 0, param3:int = 0) : *
      {
         if(param3 <= 3)
         {
            this.runArr[this.runArr.length] = [param1,param2,1,0,0,0];
            return;
         }
         var _loc4_:* = param1 / param3 * this.parabola;
         var _loc5_:* = param2 / param3 * this.parabola;
         var _loc6_:Number = param1 * (1 - this.parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         var _loc7_:Number = param2 * (1 - this.parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         this.runArr[this.runArr.length] = [_loc4_,_loc5_,param3,_loc6_,_loc7_];
      }
      
      public function getRL(param1:Boolean) : *
      {
         this.RL = param1;
         if(this.className == "金牛座石像" || this.className == "金牛座石像2" || this.id == 5001 || this.id == 5002 || this.id == 5003)
         {
            return;
         }
         if(param1)
         {
            this.skin.scaleX = -1;
         }
         else if(!param1)
         {
            this.skin.scaleX = 1;
         }
      }
      
      private function set_attack_Time() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         this.EnemySkinXml = EnemySkin.EnemySkinXmlArr[GameData.gameLV][this.关卡];
         var _loc1_:int = 0;
         while(_loc1_ < this.attack_XY.length)
         {
            for(_loc2_ in this.EnemySkinXml.怪物攻击)
            {
               _loc3_ = int(this.EnemySkinXml.怪物攻击[_loc2_].ID);
               _loc4_ = String(this.EnemySkinXml.怪物攻击[_loc2_].帧标签);
               if(this.id == _loc3_ && _loc4_ == "攻击" + (_loc1_ + 1))
               {
                  _loc5_ = int(this.EnemySkinXml.怪物攻击[_loc2_].间隔);
                  this.attack_Time[_loc1_] = _loc5_;
                  this.attack_TimeNum[_loc1_] = int(_loc5_ * Math.random());
                  break;
               }
            }
            _loc1_++;
         }
      }
      
      private function Attack_TimeXX() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.attack_TimeNum.length)
         {
            if(this.attack_TimeNum[_loc1_] < this.attack_Time[_loc1_])
            {
               ++this.attack_TimeNum[_loc1_];
            }
            _loc1_++;
         }
      }
      
      private function 任务品掉落() : *
      {
         var _loc2_:Quest = null;
         var _loc3_:obj = null;
         var _loc1_:int = int(this.任务概率掉落计算());
         if(_loc1_ != 0)
         {
            _loc2_ = QuestFactory.creatQust(_loc1_);
            _loc3_ = new obj(_loc2_,this.x,this.y);
         }
      }
      
      private function 任务概率掉落计算() : int
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:int = 0;
         if(!this.mainQuest())
         {
            if(!this.getbagQuestNum())
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
         j = 0;
         while(j < 3)
         {
            _loc2_ = Number(this.特殊掉落物品[j]);
            if(_loc2_ != 0)
            {
               _loc3_ = Number(QuestFactory.getType(_loc2_));
               if(_loc3_ == 0)
               {
                  _loc4_ = Number(QuestFactory.getTaskId(_loc2_));
                  if(TaskData.isTaskById(_loc4_) != null)
                  {
                     if(!TaskData.getAddBag(_loc4_))
                     {
                        if(_loc1_ <= this.特殊掉落概率[j])
                        {
                           return _loc2_;
                        }
                     }
                  }
               }
               else if(_loc1_ <= this.特殊掉落概率[j])
               {
                  return _loc2_;
               }
            }
            ++j;
         }
         return 0;
      }
      
      private function getbagQuestNum() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         while(_loc4_ < 3)
         {
            if(this.特殊掉落物品[_loc4_] != 0)
            {
               _loc1_ = Number(this.特殊掉落物品[_loc4_]);
               _loc3_ = Number(QuestFactory.getType(_loc1_));
               if(_loc3_ == 1)
               {
                  if(Main.player2 == null)
                  {
                     return this.p1bagFall(_loc1_);
                  }
                  if(this.p1bagFall(_loc1_) || this.p2bagFall(_loc1_))
                  {
                     return true;
                  }
               }
               else if(_loc3_ == 2)
               {
                  if(Main.player2 == null)
                  {
                     if(this.p1bagFall(_loc1_))
                     {
                        return this.p1bagFall(_loc1_);
                     }
                  }
                  else
                  {
                     if(this.p1bagFall(_loc1_) && this.p2bagFall(_loc1_))
                     {
                        return true;
                     }
                     if(Boolean(SetTransferPanel.tbo1()) && this.p2bagFall(_loc1_))
                     {
                        return true;
                     }
                     if(Boolean(SetTransferPanel.tbo2()) && this.p1bagFall(_loc1_))
                     {
                        return true;
                     }
                  }
               }
               else if(_loc3_ == 0)
               {
                  return false;
               }
            }
            _loc4_++;
         }
         return false;
      }
      
      public function p1bagFall(param1:Number) : Boolean
      {
         var _loc2_:Number = Number(Main.player1.getBag().fallQusetBag(param1));
         var _loc3_:Number = Number(QuestFactory.getFallMax(param1));
         if(_loc2_ < _loc3_)
         {
            return false;
         }
         return true;
      }
      
      public function p2bagFall(param1:Number) : Boolean
      {
         var _loc2_:Number = Number(Main.player2.getBag().fallQusetBag(param1));
         var _loc3_:Number = Number(QuestFactory.getFallMax(param1));
         if(_loc2_ < _loc3_)
         {
            return false;
         }
         return true;
      }
      
      private function mainQuest() : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         while(_loc3_ < 3)
         {
            if(this.特殊掉落物品[_loc3_] != 0)
            {
               _loc4_ = Number(this.特殊掉落物品[_loc3_]);
               _loc5_ = Number(QuestFactory.getType(_loc4_));
               if(_loc5_ == 1)
               {
                  return Main.getQuest(_loc4_);
               }
               if(_loc5_ == 2)
               {
                  if(Main.player2 == null)
                  {
                     return SetTransferPanel.tbo1();
                  }
                  if(Boolean(SetTransferPanel.tbo1()) && Boolean(SetTransferPanel.tbo2()))
                  {
                     return true;
                  }
               }
               else if(_loc5_ == 0)
               {
                  return false;
               }
            }
            _loc3_++;
         }
         return false;
      }
   }
}

