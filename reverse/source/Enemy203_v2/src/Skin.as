package src
{
   import com.greensock.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class Skin extends MovieClip
   {
      
      public static var XmlLoaded:Boolean = false;
      
      public static var PlayerXml:Array = new Array();
      
      private var myTimeTemp:int = 0;
      
      private var isDef:Boolean = true;
      
      private var fyValue:int;
      
      public var playX:MovieClip;
      
      public var skinNum:int;
      
      public var Xml:XML;
      
      public var frame:int;
      
      public var runOver:Boolean;
      
      public var continuous:Boolean;
      
      public var stopRun:Boolean;
      
      public var gravity:int;
      
      public var moveYN:Boolean;
      
      public var 硬直:int;
      
      public var 被攻击硬直:int;
      
      public var 魔法消耗:int;
      
      public var 能量消耗:int;
      
      public var 技能冷却:int;
      
      public var 持续时间:int;
      
      public var 作用类型:int;
      
      public var 数值1:Number;
      
      public var 数值2:Number;
      
      public var 数值3:Number;
      
      public var 数值4:Number;
      
      public var 数值5:Number;
      
      public var hpX:Number;
      
      public var hpXX:VT = VT.createVT();
      
      public var runX:int;
      
      public var runY:int;
      
      public var runTime:int;
      
      public var timeNum:int = 0;
      
      public var continuousTime:int;
      
      public var chiXu:int;
      
      public var yingZhi:int;
      
      public var run_X:int;
      
      public var run_Y:int;
      
      public var attTimes:int;
      
      public var type:int = 0;
      
      public var space:int = 0;
      
      public var totalTime:int = 0;
      
      public var numValue:int = 0;
      
      public var showYN:Boolean = false;
      
      public var runType:String = "站立";
      
      public var runArr:Array = [];
      
      public var moveArr:Array = [];
      
      public var skillArr:Array = ["攻击1","攻击2","攻击3","攻击4","跑攻","上挑","下斩","技能1","技能2","技能3","技能4","转职技能1","转职技能2","转职技能3","转职技能4"];
      
      public var skill_Id_Arr:Array = [["a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14","a15"],["b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","b14","b15"],["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13","c14","c15"]];
      
      private var runNum:int = 1;
      
      internal var skill_ID:int;
      
      internal var kk:HitXX = null;
      
      internal var time_Temp:int = 0;
      
      internal var fanBool:Boolean = false;
      
      internal var beiShu:Number;
      
      public function Skin()
      {
         super();
         mouseEnabled = mouseChildren = false;
         this.GoTo("站");
         addEventListener(Event.REMOVED_FROM_STAGE,this.Over);
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function Stop() : *
      {
         gotoAndStop("站");
         removeEventListener(Event.REMOVED_FROM_STAGE,this.Over);
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function Over(param1:* = null) : *
      {
         gotoAndStop(1);
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function onENTER_FRAME(param1:*) : *
      {
         if(Boolean(this.playX) && !this.playX is Player2)
         {
            removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         }
         if(this.showYN)
         {
            this.Over();
            return;
         }
         if(this.timeNum > 0)
         {
            --this.timeNum;
         }
         if(this.continuousTime > 0)
         {
            --this.continuousTime;
         }
         else if(this.runType == "被打")
         {
            this.stopRun = true;
            this.GoTo("站");
         }
         this.GoToPlay();
      }
      
      private function GoToPlay() : *
      {
         this.isRunOver();
         if(this.runOver)
         {
            if(this.continuous || this.continuousTime > 0)
            {
               gotoAndPlay(this.runType);
               this.playX.skin_W.gotoAndPlay(this.runType);
               this.playX.skin_Z.gotoAndPlay(this.runType);
               if(this.playX.skin_Z2)
               {
                  this.playX.skin_Z2.gotoAndPlay(this.runType);
               }
               if(this.playX.skin_Z3)
               {
                  if(this.runType == "跳")
                  {
                     this.playX.skin_Z3.gotoAndStop(this.runType);
                  }
                  else
                  {
                     this.playX.skin_Z3.gotoAndPlay(this.runType);
                  }
               }
               this.runOver = false;
               this.frame = 0;
            }
            else
            {
               this.GoTo("站");
            }
         }
         else
         {
            ++this.frame;
         }
         this.FindFrame();
      }
      
      private function FindFrame() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         this.moveArr = null;
         for(_loc1_ in this.Xml.技能)
         {
            _loc2_ = String(this.Xml.技能[_loc1_].帧标签);
            _loc3_ = int(this.Xml.技能[_loc1_].当前帧);
            if(this.runType == _loc2_ && this.frame == _loc3_)
            {
               this.continuous = String(this.Xml.技能[_loc1_].循环).toString() == "true" ? true : false;
               this.stopRun = String(this.Xml.技能[_loc1_].中断).toString() == "true" ? true : false;
               this.moveYN = String(this.Xml.技能[_loc1_].移动).toString() == "true" ? true : false;
               this.gravity = int(this.Xml.技能[_loc1_].重力调整);
               this.moveArr = [int(this.Xml.技能[_loc1_].移动参数.X),int(this.Xml.技能[_loc1_].移动参数.Y),int(this.Xml.技能[_loc1_].移动参数.持续)];
               this.hpX = Number(this.Xml.技能[_loc1_].伤害.hp) * this.NowHPxx();
               this.hpXX.setValue(Number(this.Xml.技能[_loc1_].伤害.hp) * this.NowHPxx());
               this.被攻击硬直 = int(this.Xml.技能[_loc1_].被攻击硬直);
               this.硬直 = int(this.Xml.技能[_loc1_].硬直) + this.yingZhi;
               this.runX = int(this.Xml.技能[_loc1_].伤害.震退) + this.run_X;
               this.runY = int(this.Xml.技能[_loc1_].伤害.挑高) + this.run_Y;
               this.runTime = int(this.Xml.技能[_loc1_].伤害.持续) + this.chiXu;
               return;
            }
         }
      }
      
      public function get_Skill_Id_and_LV(param1:String = "") : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         if(param1 == "")
         {
            param1 = this.runType;
         }
         for(_loc2_ in this.skillArr)
         {
            if(param1 == this.skillArr[_loc2_])
            {
               _loc3_ = this.skill_Id_Arr[this.skinNum][_loc2_];
               _loc4_ = int(this.parent.data.getSkillLevel(_loc3_));
               return [_loc3_,_loc4_];
            }
         }
         return [-1,-1];
      }
      
      private function NowHPxx() : Number
      {
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc1_:Array = this.get_Skill_Id_and_LV();
         if(_loc1_ == null || _loc1_[1] <= 0)
         {
            return 0;
         }
         var _loc2_:XML = SkillFactory.myXml;
         for(_loc3_ in _loc2_.数据)
         {
            _loc4_ = String(_loc2_.数据[_loc3_].技能类型);
            _loc5_ = int(_loc2_.数据[_loc3_].技能等级);
            if(_loc4_ == _loc1_[0] && _loc5_ == _loc1_[1])
            {
               _loc6_ = Number(_loc2_.数据[_loc3_].具体数值.数值1);
               this.attTimes = Number(_loc2_.数据[_loc3_].具体数值.次数);
               this.yingZhi = int(_loc2_.数据[_loc3_].具体数值.硬直);
               this.run_X = int(_loc2_.数据[_loc3_].具体数值.震退);
               this.run_Y = int(_loc2_.数据[_loc3_].具体数值.挑高);
               this.chiXu = int(_loc2_.数据[_loc3_].具体数值.持续);
               return _loc6_;
            }
         }
         trace("找不到伤害系数");
         return 0;
      }
      
      private function isRunOver() : *
      {
         if(this.currentLabel != this.runType)
         {
            this.runOver = true;
         }
         else
         {
            this.runOver = false;
         }
      }
      
      public function OtherGoTo(param1:String) : String
      {
         var _loc2_:String = null;
         if(this.timeNum <= 0)
         {
            this.runNum = 1;
         }
         if(this.timeNum > 0 && param1 == "攻击")
         {
            _loc2_ = param1 + this.runNum;
            if(this.runNum == 4)
            {
               this.runNum = 1;
            }
            else
            {
               ++this.runNum;
            }
            return _loc2_;
         }
         return param1;
      }
      
      public function GoTo(param1:String, param2:int = 0, param3:Boolean = false) : *
      {
         if(param3 == true)
         {
            this.stopRun = true;
         }
         if(param1 == "怪物技能")
         {
            this.enemySkill();
         }
         if(param1 == "被打")
         {
            this.runType = param1;
            this.runOver = false;
            this.stopRun = false;
            gotoAndPlay(this.runType);
            this.playX.skin_W.gotoAndPlay(this.runType);
            this.playX.skin_Z.gotoAndPlay(this.runType);
            if(this.playX.skin_Z2)
            {
               this.playX.skin_Z2.gotoAndPlay(this.runType);
            }
            if(this.playX.skin_Z3)
            {
               this.playX.skin_Z3.gotoAndPlay(this.runType);
            }
         }
         if((this.runOver || this.stopRun) && this.runType != param1)
         {
            param1 = this.OtherGoTo(param1);
            if(this.CanGoTo(param1))
            {
               this.runType = param1;
               this.otherGoTo(this.runType);
               gotoAndPlay(this.runType);
               this.playX.skin_W.gotoAndPlay(this.runType);
               this.playX.skin_Z.gotoAndPlay(this.runType);
               if(this.playX.skin_Z2)
               {
                  this.playX.skin_Z2.gotoAndPlay(this.runType);
               }
               if(this.playX.skin_Z3)
               {
                  if(this.runType == "跳")
                  {
                     this.playX.skin_Z3.gotoAndStop(this.runType);
                  }
                  else
                  {
                     this.playX.skin_Z3.gotoAndPlay(this.runType);
                  }
               }
               this.runOver = false;
               this.frame = 0;
               MusicBox.ActMusicPlay(this.playX.data.skinArr[this.playX.data.skinNum],this.runType);
            }
         }
         this.continuousTime = param2;
      }
      
      private function CanGoTo(param1:String) : Boolean
      {
         var _loc2_:Array = this.get_Skill_Id_and_LV(param1);
         if(_loc2_[1] == 0)
         {
            return false;
         }
         if(this.parent.CanSkill(_loc2_[0],_loc2_[1]))
         {
            return true;
         }
         return false;
      }
      
      public function otherGoTo(param1:String) : *
      {
      }
      
      public function Get_StopRun() : Boolean
      {
         return this.stopRun;
      }
      
      private function enemySkill() : *
      {
         var _loc1_:String = null;
         var _loc5_:Class = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Class = null;
         if(this.parent.energySlot.getEnergyPer(this.parent) != 100)
         {
            return;
         }
         if(this.parent.data.skinNum == 0)
         {
            this.parent.energySlot.energyLeftNum.setValue(0);
            if(this.parent.data.getEquipSkillSlot().getGemFromSkillSlot(0) != null)
            {
               this.skill_ID = this.parent.data.getEquipSkillSlot().getGemFromSkillSlot(0).getGemSkill();
            }
         }
         else
         {
            this.parent.energySlot.energyRightNum.setValue(0);
            if(this.parent.data.getEquipSkillSlot().getGemFromSkillSlot(1) != null)
            {
               this.skill_ID = this.parent.data.getEquipSkillSlot().getGemFromSkillSlot(1).getGemSkill();
            }
         }
         var _loc2_:Skill = SkillFactory.getSkillById(this.skill_ID);
         _loc1_ = _loc2_.getSkillName();
         var _loc3_:Array = _loc2_.getSkillValueArray();
         var _loc4_:Number = _loc2_.getSkillActOn();
         if(_loc1_ == "眼镜蛇冲击")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("眼镜蛇冲击") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "双头狗冲击")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("双头狗冲击") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "双头狗冲击波")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("双头狗冲击波") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "蝎王地刺")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("蝎王地刺") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "雪女落冰")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("雪女落冰") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "金太郎斧劈")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("金太郎斧劈") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "生命复苏")
         {
            _loc5_ = Player.enemySkillMC.getClass("生命复苏") as Class;
            this.parent.skin_W.addChild(new _loc5_());
            _loc6_ = Number(_loc3_[0].getValue());
            _loc7_ = int((this.parent as Player).use_hp_Max.getValue());
            _loc8_ = int(_loc7_ * _loc6_);
            (this.parent as Player).HpUp(_loc8_);
         }
         else if(_loc1_ == "法力再生")
         {
            _loc5_ = Player.enemySkillMC.getClass("法力再生") as Class;
            this.parent.skin_W.addChild(new _loc5_());
            _loc9_ = Number(_loc3_[0].getValue());
            _loc10_ = int((this.parent as Player).use_mp_Max.getValue());
            _loc11_ = int(_loc10_ * _loc9_);
            (this.parent as Player).MpUp(_loc11_);
         }
         else if(_loc1_ == "熔岩魔天火")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("熔岩魔天火") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "死灵爆裂")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("死灵爆裂") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "鳄鱼旋风斩")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("鳄鱼旋风斩") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "狮王裂地斩")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("狮王裂地斩") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "杀戮狂魔波")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("狂魔波技能") as Class;
            _loc12_ = Player.enemySkillMC.getClass("杀戮狂魔波") as Class;
            this.parent.skin_W.addChild(new _loc5_());
            this.parent.skin_W.addChild(new _loc12_());
         }
         else if(_loc1_ == "白狼滚石")
         {
            setTimeout(this.gunshi,1000);
            setTimeout(this.gunshi,1300);
            _loc12_ = Player.enemySkillMC.getClass("白狼滚石") as Class;
            this.parent.skin_W.addChild(new _loc12_());
         }
         else if(_loc1_ == "白狼怒吼")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("白狼怒吼") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "暗黑风暴")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("暗黑风暴") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "真·暗黑风暴")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("暗黑风暴") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "黑洞")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("黑洞") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "魔轮转")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("魔轮转") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "真·魔轮转")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("魔轮转") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "缩小术")
         {
            this.type = _loc4_;
            this.hpX = _loc3_[0].getValue();
            this.numValue = _loc3_[1].getValue();
            this.space = _loc3_[2].getValue();
            this.totalTime = _loc3_[3].getValue();
            this.attTimes = _loc3_[4].getValue();
            this.硬直 = _loc3_[5].getValue();
            this.runY = _loc3_[6].getValue();
            this.runX = _loc3_[7].getValue();
            this.runTime = _loc3_[8].getValue();
            _loc5_ = Player.enemySkillMC.getClass("缩小术") as Class;
            _loc12_ = Player.enemySkillMC.getClass("缩小吸引") as Class;
            this.parent.skin_W.addChild(new _loc5_());
            this.parent.skin_W.addChild(new _loc12_());
         }
         else if(_loc1_ == "缩小术")
         {
            this.type = _loc4_;
            this.hpX = _loc3_[0].getValue();
            this.numValue = _loc3_[1].getValue();
            this.space = _loc3_[2].getValue();
            this.totalTime = _loc3_[3].getValue();
            this.attTimes = _loc3_[4].getValue();
            this.硬直 = _loc3_[5].getValue();
            this.runY = _loc3_[6].getValue();
            this.runX = _loc3_[7].getValue();
            this.runTime = _loc3_[8].getValue();
            _loc5_ = Player.enemySkillMC.getClass("缩小术") as Class;
            _loc12_ = Player.enemySkillMC.getClass("缩小吸引") as Class;
            this.parent.skin_W.addChild(new _loc5_());
            this.parent.skin_W.addChild(new _loc12_());
         }
         else if(_loc1_ == "雪女风雪")
         {
            this.type = _loc4_;
            this.hpX = _loc3_[0].getValue();
            this.numValue = _loc3_[1].getValue();
            this.space = _loc3_[2].getValue();
            this.totalTime = _loc3_[3].getValue();
            this.attTimes = _loc3_[4].getValue();
            this.硬直 = _loc3_[5].getValue();
            this.runY = _loc3_[6].getValue();
            this.runX = _loc3_[7].getValue();
            this.runTime = _loc3_[8].getValue();
            _loc5_ = Player.enemySkillMC.getClass("雪女风雪") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "机械反弹")
         {
            this.beiShu = _loc3_[0].getValue();
            TweenMax.to(this,3,{"dropShadowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":18,
               "blurY":18
            }});
            this.addEventListener(Event.ENTER_FRAME,this.fanshang);
         }
         else if(_loc1_ == "无敌罩")
         {
            this.hpX = _loc3_[0].getValue();
            this.attTimes = _loc3_[1].getValue();
            this.硬直 = _loc3_[2].getValue();
            this.runY = _loc3_[3].getValue();
            this.runX = _loc3_[4].getValue();
            this.runTime = _loc3_[5].getValue();
            _loc5_ = Player.enemySkillMC.getClass("无敌罩") as Class;
            this.parent.skin_W.addChild(new _loc5_());
         }
      }
      
      internal function fanshang(param1:*) : *
      {
         var _loc2_:* = undefined;
         this.fanBool = true;
         ++this.time_Temp;
         if(this.time_Temp > 400)
         {
            this.time_Temp = 0;
            this.fanBool = false;
            TweenMax.to(this,1,{"dropShadowFilter":{
               "color":16711680,
               "alpha":0
            }});
            this.removeEventListener(Event.ENTER_FRAME,this.fanshang);
         }
         if(this.fanBool == true)
         {
            for(_loc2_ in HitXX.AllHitXX)
            {
               if(Boolean(HitXX.AllHitXX[_loc2_]) && this.parent.hitXX == HitXX.AllHitXX[_loc2_])
               {
                  this.parent.hitXX.runArr = [0,0,0];
                  this.parent.hitXX.硬直 = 0;
                  this.parent.hitXX.times = 200;
                  this.parent.hitXX.gongJi_hp *= this.beiShu;
                  if(this.parent.hitXX != this.kk)
                  {
                     this.kk = this.parent.hitXX;
                     if((this.parent.hitXX.who as Enemy).life.getValue() > 0)
                     {
                        (this.parent.hitXX.who as Enemy).HpXX(this.parent.hitXX);
                     }
                  }
               }
            }
         }
      }
      
      public function gunshi() : *
      {
         var _loc1_:Skill = SkillFactory.getSkillById(this.skill_ID);
         esName = _loc1_.getSkillName();
         var _loc2_:Array = _loc1_.getSkillValueArray();
         var _loc3_:Number = _loc1_.getSkillActOn();
         this.hpX = _loc2_[0].getValue();
         this.attTimes = _loc2_[1].getValue();
         this.硬直 = _loc2_[2].getValue();
         this.runY = _loc2_[3].getValue();
         this.runX = _loc2_[4].getValue();
         this.runTime = _loc2_[5].getValue();
         var _loc4_:Class = Player.enemySkillMC.getClass("滚石") as Class;
         this.parent.skin_W.addChild(new _loc4_());
      }
      
      public function 震动(param1:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(param1);
         }
      }
   }
}

