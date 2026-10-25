package src
{
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.repository.skill.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class Skin extends MovieClip
   {
      
      public static var XmlLoaded:Boolean = false;
      
      public static var PlayerXml:Array = new Array();
      
      public var 硬直:int;
      
      private var myTimeTemp:int = 0;
      
      public var hpX:Number;
      
      public var skillArr:Array = ["攻击1","攻击2","攻击3","攻击4","跑攻","上挑","下斩","技能1","技能2","技能3","技能4","转职技能1","转职技能2","转职技能3","转职技能4"];
      
      public var gravity:int;
      
      private var fyValue:int;
      
      public var runType:String = "站立";
      
      private var isDef:Boolean = true;
      
      public var continuousTime:int;
      
      public var moveYN:Boolean;
      
      public var skinNum:int;
      
      public var 作用类型:int;
      
      public var moveArr:Array = [];
      
      public var 数值1:Number;
      
      public var 数值2:Number;
      
      public var 数值3:Number;
      
      public var 数值4:Number;
      
      public var 数值5:Number;
      
      public var skill_Id_Arr:Array = [["a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14","a15"],["b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","b14","b15"],["c1","c2","c3","c4","c5","c6","c7","c8","c9","c10","c11","c12","c13","c14","c15"]];
      
      public var continuous:Boolean;
      
      public var attTimes:int;
      
      public var stopRun:Boolean;
      
      public var runX:int;
      
      public var runY:int;
      
      public var 魔法消耗:int;
      
      public var 被攻击硬直:int;
      
      public var frame:int;
      
      private var runNum:int = 1;
      
      public var yingZhi:int;
      
      public var timeNum:int = 0;
      
      public var 能量消耗:int;
      
      public var playX:Player;
      
      public var run_X:int;
      
      public var run_Y:int;
      
      public var 持续时间:int;
      
      public var runArr:Array = [];
      
      public var 技能冷却:int;
      
      public var Xml:XML;
      
      public var runTime:int;
      
      public var runOver:Boolean;
      
      public function Skin()
      {
         super();
         mouseEnabled = mouseChildren = false;
         GoTo("站");
         addEventListener(Event.REMOVED_FROM_STAGE,Over);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function 震动(param1:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(param1);
         }
      }
      
      public function OtherGoTo(param1:String) : String
      {
         var _loc2_:String = null;
         if(timeNum <= 0)
         {
            runNum = 1;
         }
         if(timeNum > 0 && param1 == "攻击")
         {
            _loc2_ = param1 + runNum;
            if(runNum == 4)
            {
               runNum = 1;
            }
            else
            {
               ++runNum;
            }
            return _loc2_;
         }
         return param1;
      }
      
      public function otherGoTo(param1:String) : *
      {
      }
      
      public function Get_StopRun() : Boolean
      {
         return this.stopRun;
      }
      
      public function get_Skill_Id_and_LV(param1:String = "") : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         if(param1 == "")
         {
            param1 = runType;
         }
         for(_loc2_ in skillArr)
         {
            if(param1 == skillArr[_loc2_])
            {
               _loc3_ = skill_Id_Arr[skinNum][_loc2_];
               _loc4_ = int((this.parent as Player).data.getSkillLevel(_loc3_));
               return [_loc3_,_loc4_];
            }
         }
         return [-1,-1];
      }
      
      private function FindFrame() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         moveArr = null;
         for(_loc1_ in Xml.技能)
         {
            _loc2_ = String(Xml.技能[_loc1_].帧标签);
            _loc3_ = int(Xml.技能[_loc1_].当前帧);
            if(runType == _loc2_ && frame == _loc3_)
            {
               continuous = String(Xml.技能[_loc1_].循环).toString() == "true" ? true : false;
               stopRun = String(Xml.技能[_loc1_].中断).toString() == "true" ? true : false;
               moveYN = String(Xml.技能[_loc1_].移动).toString() == "true" ? true : false;
               gravity = int(Xml.技能[_loc1_].重力调整);
               moveArr = [int(Xml.技能[_loc1_].移动参数.X),int(Xml.技能[_loc1_].移动参数.Y),int(Xml.技能[_loc1_].移动参数.持续)];
               hpX = Number(Xml.技能[_loc1_].伤害.hp) * NowHPxx();
               被攻击硬直 = int(Xml.技能[_loc1_].被攻击硬直);
               硬直 = int(Xml.技能[_loc1_].硬直) + yingZhi;
               runX = int(Xml.技能[_loc1_].伤害.震退) + run_X;
               runY = int(Xml.技能[_loc1_].伤害.挑高) + run_Y;
               runTime = int(Xml.技能[_loc1_].伤害.持续);
               return;
            }
         }
      }
      
      public function Over(param1:* = null) : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function CanGoTo(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         _loc2_ = get_Skill_Id_and_LV(param1);
         if(_loc2_[1] == 0)
         {
            return false;
         }
         if((this.parent as Player).CanSkill(_loc2_[0],_loc2_[1]))
         {
            return true;
         }
         return false;
      }
      
      private function isRunOver() : *
      {
         if(this.currentLabel != runType)
         {
            runOver = true;
         }
         else
         {
            runOver = false;
         }
      }
      
      private function GoToPlay() : *
      {
         isRunOver();
         if(runOver)
         {
            if(continuous || continuousTime > 0)
            {
               gotoAndPlay(runType);
               playX.skin_W.gotoAndPlay(runType);
               playX.skin_Z.gotoAndPlay(runType);
               runOver = false;
               frame = 0;
            }
            else
            {
               GoTo("站");
            }
         }
         else
         {
            ++frame;
         }
         FindFrame();
      }
      
      private function enemySkill() : *
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:Skill = null;
         var _loc4_:Array = null;
         var _loc5_:Class = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:Class = null;
         if((this.parent as Player).energySlot.getEnergyPer(this.parent) != 100)
         {
            return;
         }
         if((this.parent as Player).data.skinNum == 0)
         {
            (this.parent as Player).energySlot.energyLeftNum = 0;
            if((this.parent as Player).data.getEquipSkillSlot().getGemFromSkillSlot(0) != null)
            {
               _loc2_ = int((this.parent as Player).data.getEquipSkillSlot().getGemFromSkillSlot(0).getGemSkill());
            }
         }
         else
         {
            (this.parent as Player).energySlot.energyRightNum = 0;
            if((this.parent as Player).data.getEquipSkillSlot().getGemFromSkillSlot(1) != null)
            {
               _loc2_ = int((this.parent as Player).data.getEquipSkillSlot().getGemFromSkillSlot(1).getGemSkill());
            }
         }
         _loc3_ = SkillFactory.getSkillById(_loc2_);
         _loc1_ = _loc3_.getSkillName();
         _loc4_ = _loc3_.getSkillValueArray();
         if(_loc1_ == "眼镜蛇冲击")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            (this.parent as Player).skin_W.addChild(new 眼镜蛇冲击());
            hpX = _loc4_[0].getValue();
            _loc5_ = Player.enemySkillMC.getClass("眼镜蛇冲击") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "双头狗冲击")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("双头狗冲击") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "双头狗冲击波")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("双头狗冲击波") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "蝎王地刺")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("蝎王地刺") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "雪女落冰")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("雪女落冰") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "金太郎斧劈")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("金太郎斧劈") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "生命复苏")
         {
            _loc5_ = Player.enemySkillMC.getClass("生命复苏") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
            _loc6_ = Number(_loc4_[0].getValue());
            _loc7_ = int((this.parent as Player).hp_Max.getValue());
            _loc8_ = int((this.parent as Player).hp.getValue());
            _loc9_ = int(_loc7_ * _loc6_);
            if(_loc9_ + _loc8_ <= _loc7_)
            {
               (this.parent as Player).hp.setValue(_loc9_ + _loc8_);
            }
            else
            {
               (this.parent as Player).hp.setValue(_loc7_);
            }
            NewMC.Open("回血效果",this.parent,0,0,0,_loc9_);
         }
         else if(_loc1_ == "法力再生")
         {
            _loc5_ = Player.enemySkillMC.getClass("法力再生") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
            _loc10_ = Number(_loc4_[0].getValue());
            _loc11_ = int((this.parent as Player).mp_Max.getValue());
            _loc12_ = int((this.parent as Player).mp.getValue());
            _loc13_ = int(_loc11_ * _loc10_);
            if(_loc13_ + _loc12_ <= _loc11_)
            {
               (this.parent as Player).mp.setValue(_loc13_ + _loc12_);
            }
            else
            {
               (this.parent as Player).mp.setValue(_loc11_);
            }
            NewMC.Open("回蓝效果",this.parent,0,0,0,_loc13_);
         }
         else if(_loc1_ == "熔岩魔天火")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("熔岩魔天火") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "死灵爆裂")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("死灵爆裂") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "鳄鱼旋风斩")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("鳄鱼旋风斩") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "狮王裂地斩")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("狮王裂地斩") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "杀戮狂魔波")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("狂魔波技能") as Class;
            _loc14_ = Player.enemySkillMC.getClass("杀戮狂魔波") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
            (this.parent as Player).skin_W.addChild(new _loc14_());
         }
         else if(_loc1_ == "暗黑风暴")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("暗黑风暴") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
         else if(_loc1_ == "黑洞")
         {
            hpX = _loc4_[0].getValue();
            attTimes = _loc4_[1].getValue();
            硬直 = _loc4_[2].getValue();
            runY = _loc4_[3].getValue();
            runX = _loc4_[4].getValue();
            _loc5_ = Player.enemySkillMC.getClass("黑洞") as Class;
            (this.parent as Player).skin_W.addChild(new _loc5_());
         }
      }
      
      public function GoTo(param1:String, param2:int = 0, param3:Boolean = false) : *
      {
         if(param3 == true)
         {
            stopRun = true;
         }
         if(param1 == "怪物技能")
         {
            enemySkill();
         }
         if(param1 == "被打")
         {
            runType = param1;
            runOver = false;
            stopRun = false;
            gotoAndPlay(runType);
            playX.skin_W.gotoAndPlay(runType);
            playX.skin_Z.gotoAndPlay(runType);
         }
         if((runOver || stopRun) && runType != param1)
         {
            param1 = OtherGoTo(param1);
            if(CanGoTo(param1))
            {
               runType = param1;
               otherGoTo(runType);
               gotoAndPlay(runType);
               playX.skin_W.gotoAndPlay(runType);
               playX.skin_Z.gotoAndPlay(runType);
               runOver = false;
               frame = 0;
               MusicBox.ActMusicPlay(playX.data.skinArr[playX.data.skinNum],runType);
            }
         }
         continuousTime = param2;
      }
      
      private function NowHPxx() : Number
      {
         var _loc1_:Array = null;
         var _loc2_:XML = null;
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         _loc1_ = get_Skill_Id_and_LV();
         if(_loc1_ == null || _loc1_[1] <= 0)
         {
            return 0;
         }
         _loc2_ = SkillFactory.myXml;
         for(_loc3_ in _loc2_.数据)
         {
            _loc4_ = String(_loc2_.数据[_loc3_].技能类型);
            _loc5_ = int(_loc2_.数据[_loc3_].技能等级);
            if(_loc4_ == _loc1_[0] && _loc5_ == _loc1_[1])
            {
               _loc6_ = Number(_loc2_.数据[_loc3_].具体数值.数值1);
               attTimes = Number(_loc2_.数据[_loc3_].具体数值.次数);
               yingZhi = int(_loc2_.数据[_loc3_].具体数值.硬直);
               run_X = int(_loc2_.数据[_loc3_].具体数值.震退);
               run_Y = int(_loc2_.数据[_loc3_].具体数值.挑高);
               return _loc6_;
            }
         }
         trace("找不到伤害系数");
         return 0;
      }
      
      public function onENTER_FRAME(param1:*) : *
      {
         if(timeNum > 0)
         {
            --timeNum;
         }
         if(continuousTime > 0)
         {
            --continuousTime;
         }
         else if(runType == "被打")
         {
            stopRun = true;
            GoTo("站立");
         }
         GoToPlay();
      }
   }
}

