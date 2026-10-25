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
      
      public function Over(e:* = null) : *
      {
         gotoAndStop(1);
         removeEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public function onENTER_FRAME(e:*) : *
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
         var i:* = undefined;
         var 帧标签:String = null;
         var 当前帧:int = 0;
         this.moveArr = null;
         for(i in this.Xml.技能)
         {
            帧标签 = String(this.Xml.技能[i].帧标签);
            当前帧 = int(this.Xml.技能[i].当前帧);
            if(this.runType == 帧标签 && this.frame == 当前帧)
            {
               this.continuous = String(this.Xml.技能[i].循环).toString() == "true" ? true : false;
               this.stopRun = String(this.Xml.技能[i].中断).toString() == "true" ? true : false;
               this.moveYN = String(this.Xml.技能[i].移动).toString() == "true" ? true : false;
               this.gravity = int(this.Xml.技能[i].重力调整);
               this.moveArr = [int(this.Xml.技能[i].移动参数.X),int(this.Xml.技能[i].移动参数.Y),int(this.Xml.技能[i].移动参数.持续)];
               this.hpX = Number(this.Xml.技能[i].伤害.hp) * this.NowHPxx();
               this.hpXX.setValue(Number(this.Xml.技能[i].伤害.hp) * this.NowHPxx());
               this.被攻击硬直 = int(this.Xml.技能[i].被攻击硬直);
               this.硬直 = int(this.Xml.技能[i].硬直) + this.yingZhi;
               this.runX = int(this.Xml.技能[i].伤害.震退) + this.run_X;
               this.runY = int(this.Xml.技能[i].伤害.挑高) + this.run_Y;
               this.runTime = int(this.Xml.技能[i].伤害.持续) + this.chiXu;
               return;
            }
         }
      }
      
      public function get_Skill_Id_and_LV(str:String = "") : Array
      {
         var i:* = undefined;
         var sId:String = null;
         var slv:int = 0;
         var arr:Array = null;
         if(str == "")
         {
            str = this.runType;
         }
         for(i in this.skillArr)
         {
            if(str == this.skillArr[i])
            {
               sId = this.skill_Id_Arr[this.skinNum][i];
               slv = int(this.parent.data.getSkillLevel(sId));
               return [sId,slv];
            }
         }
         return [-1,-1];
      }
      
      private function NowHPxx() : Number
      {
         var i:* = undefined;
         var s:String = null;
         var lv:int = 0;
         var hpxx:Number = NaN;
         var akillArr:Array = this.get_Skill_Id_and_LV();
         if(akillArr == null || akillArr[1] <= 0)
         {
            return 0;
         }
         var xml:XML = SkillFactory.myXml;
         for(i in xml.数据)
         {
            s = String(xml.数据[i].技能类型);
            lv = int(xml.数据[i].技能等级);
            if(s == akillArr[0] && lv == akillArr[1])
            {
               hpxx = Number(xml.数据[i].具体数值.数值1);
               this.attTimes = Number(xml.数据[i].具体数值.次数);
               this.yingZhi = int(xml.数据[i].具体数值.硬直);
               this.run_X = int(xml.数据[i].具体数值.震退);
               this.run_Y = int(xml.数据[i].具体数值.挑高);
               this.chiXu = int(xml.数据[i].具体数值.持续);
               return hpxx;
            }
         }
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
      
      public function OtherGoTo(str:String) : String
      {
         var tempStr:String = null;
         if(this.timeNum <= 0)
         {
            this.runNum = 1;
         }
         if(this.timeNum > 0 && str == "攻击")
         {
            tempStr = str + this.runNum;
            if(this.runNum == 4)
            {
               this.runNum = 1;
            }
            else
            {
               ++this.runNum;
            }
            return tempStr;
         }
         return str;
      }
      
      public function GoTo(tempRun:String, timeX:int = 0, isStop:Boolean = false) : *
      {
         if(isStop == true)
         {
            this.stopRun = true;
         }
         if(tempRun == "怪物技能")
         {
            this.enemySkill();
         }
         if(tempRun == "被打")
         {
            this.runType = tempRun;
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
         if((this.runOver || this.stopRun) && this.runType != tempRun)
         {
            tempRun = this.OtherGoTo(tempRun);
            if(this.CanGoTo(tempRun))
            {
               this.runType = tempRun;
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
         this.continuousTime = timeX;
      }
      
      private function CanGoTo(tempRun:String) : Boolean
      {
         var arr:Array = this.get_Skill_Id_and_LV(tempRun);
         if(arr[1] == 0)
         {
            return false;
         }
         if(this.parent.CanSkill(arr[0],arr[1]))
         {
            return true;
         }
         return false;
      }
      
      public function otherGoTo(str:String) : *
      {
      }
      
      public function Get_StopRun() : Boolean
      {
         return this.stopRun;
      }
      
      private function enemySkill() : *
      {
         var esName:String = null;
         var classRef:Class = null;
         var percent1:Number = NaN;
         var hpMax:int = 0;
         var hpReal:int = 0;
         var percent2:Number = NaN;
         var mpMax:int = 0;
         var mpReal:int = 0;
         var classRef2:Class = null;
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
         var sk:Skill = SkillFactory.getSkillById(this.skill_ID);
         esName = sk.getSkillName();
         var arr:Array = sk.getSkillValueArray();
         var typeTemp:Number = sk.getSkillActOn();
         if(esName == "眼镜蛇冲击")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("眼镜蛇冲击") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "双头狗冲击")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("双头狗冲击") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "双头狗冲击波")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("双头狗冲击波") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "蝎王地刺")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("蝎王地刺") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "雪女落冰")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("雪女落冰") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "金太郎斧劈")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("金太郎斧劈") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "生命复苏")
         {
            classRef = Player.enemySkillMC.getClass("生命复苏") as Class;
            this.parent.skin_W.addChild(new classRef());
            percent1 = Number(arr[0].getValue());
            hpMax = int((this.parent as Player).use_hp_Max.getValue());
            hpReal = int(hpMax * percent1);
            (this.parent as Player).HpUp(hpReal);
         }
         else if(esName == "法力再生")
         {
            classRef = Player.enemySkillMC.getClass("法力再生") as Class;
            this.parent.skin_W.addChild(new classRef());
            percent2 = Number(arr[0].getValue());
            mpMax = int((this.parent as Player).use_mp_Max.getValue());
            mpReal = int(mpMax * percent2);
            (this.parent as Player).MpUp(mpReal);
         }
         else if(esName == "熔岩魔天火")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("熔岩魔天火") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "死灵爆裂")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("死灵爆裂") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "鳄鱼旋风斩")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("鳄鱼旋风斩") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "狮王裂地斩")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("狮王裂地斩") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "杀戮狂魔波")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("狂魔波技能") as Class;
            classRef2 = Player.enemySkillMC.getClass("杀戮狂魔波") as Class;
            this.parent.skin_W.addChild(new classRef());
            this.parent.skin_W.addChild(new classRef2());
         }
         else if(esName == "白狼滚石")
         {
            setTimeout(this.gunshi,1000);
            setTimeout(this.gunshi,1300);
            classRef2 = Player.enemySkillMC.getClass("白狼滚石") as Class;
            this.parent.skin_W.addChild(new classRef2());
         }
         else if(esName == "白狼怒吼")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("白狼怒吼") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "暗黑风暴")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("暗黑风暴") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "真·暗黑风暴")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("暗黑风暴") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "黑洞")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("黑洞") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "魔轮转")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("魔轮转") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "真·魔轮转")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("魔轮转") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "缩小术")
         {
            this.type = typeTemp;
            this.hpX = arr[0].getValue();
            this.numValue = arr[1].getValue();
            this.space = arr[2].getValue();
            this.totalTime = arr[3].getValue();
            this.attTimes = arr[4].getValue();
            this.硬直 = arr[5].getValue();
            this.runY = arr[6].getValue();
            this.runX = arr[7].getValue();
            this.runTime = arr[8].getValue();
            classRef = Player.enemySkillMC.getClass("缩小术") as Class;
            classRef2 = Player.enemySkillMC.getClass("缩小吸引") as Class;
            this.parent.skin_W.addChild(new classRef());
            this.parent.skin_W.addChild(new classRef2());
         }
         else if(esName == "缩小术")
         {
            this.type = typeTemp;
            this.hpX = arr[0].getValue();
            this.numValue = arr[1].getValue();
            this.space = arr[2].getValue();
            this.totalTime = arr[3].getValue();
            this.attTimes = arr[4].getValue();
            this.硬直 = arr[5].getValue();
            this.runY = arr[6].getValue();
            this.runX = arr[7].getValue();
            this.runTime = arr[8].getValue();
            classRef = Player.enemySkillMC.getClass("缩小术") as Class;
            classRef2 = Player.enemySkillMC.getClass("缩小吸引") as Class;
            this.parent.skin_W.addChild(new classRef());
            this.parent.skin_W.addChild(new classRef2());
         }
         else if(esName == "雪女风雪")
         {
            this.type = typeTemp;
            this.hpX = arr[0].getValue();
            this.numValue = arr[1].getValue();
            this.space = arr[2].getValue();
            this.totalTime = arr[3].getValue();
            this.attTimes = arr[4].getValue();
            this.硬直 = arr[5].getValue();
            this.runY = arr[6].getValue();
            this.runX = arr[7].getValue();
            this.runTime = arr[8].getValue();
            classRef = Player.enemySkillMC.getClass("雪女风雪") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
         else if(esName == "机械反弹")
         {
            this.beiShu = arr[0].getValue();
            TweenMax.to(this,3,{"dropShadowFilter":{
               "color":16711680,
               "alpha":1,
               "blurX":18,
               "blurY":18
            }});
            this.addEventListener(Event.ENTER_FRAME,this.fanshang);
         }
         else if(esName == "无敌罩")
         {
            this.hpX = arr[0].getValue();
            this.attTimes = arr[1].getValue();
            this.硬直 = arr[2].getValue();
            this.runY = arr[3].getValue();
            this.runX = arr[4].getValue();
            this.runTime = arr[5].getValue();
            classRef = Player.enemySkillMC.getClass("无敌罩") as Class;
            this.parent.skin_W.addChild(new classRef());
         }
      }
      
      internal function fanshang(e:*) : *
      {
         var i:* = undefined;
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
            for(i in HitXX.AllHitXX)
            {
               if(Boolean(HitXX.AllHitXX[i]) && this.parent.hitXX == HitXX.AllHitXX[i])
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
         var sk:Skill = SkillFactory.getSkillById(this.skill_ID);
         esName = sk.getSkillName();
         var arr:Array = sk.getSkillValueArray();
         var typeTemp:Number = sk.getSkillActOn();
         this.hpX = arr[0].getValue();
         this.attTimes = arr[1].getValue();
         this.硬直 = arr[2].getValue();
         this.runY = arr[3].getValue();
         this.runX = arr[4].getValue();
         this.runTime = arr[5].getValue();
         var classRef:Class = Player.enemySkillMC.getClass("滚石") as Class;
         this.parent.skin_W.addChild(new classRef());
      }
      
      public function 震动(num:int = 4) : *
      {
         if(Main.world)
         {
            Main.world.Quake(num);
         }
      }
   }
}

