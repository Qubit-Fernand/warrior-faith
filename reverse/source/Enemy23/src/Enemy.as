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
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class Enemy extends MovieClip
   {
      
      public static var EnemyXml:XML;
      
      public static var EnemyArr:Array = new Array();
      
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
      
      private var runX:int = 0;
      
      private var runY:int = 0;
      
      private var runArr:Array = new Array();
      
      public var EnemySkinXml:XML = new XML();
      
      private var 特殊掉落物品:Array = [];
      
      private var 特殊掉落概率:Array = [];
      
      public function Enemy(i:int = 0)
      {
         var name:String = null;
         super();
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         if(i != 0)
         {
            this.id = i;
            name = SkinData(i);
            if(name == null)
            {
               trace("怪物信息错误!! 找不到ID" + i);
            }
            else
            {
               addSkin(name);
               All[All.length] = this;
               this.skin.EnemySkinXml = EnemySkin.EnemySkinXmlArr[GameData.gameLV][关卡];
            }
         }
         else
         {
            trace("无法创建 怪物0");
         }
      }
      
      private function addSkin(str:String) : *
      {
         var classRef:Class = EnemyArr[关卡].getClass(str) as Class;
         this.skin = new classRef();
         addChild(skin);
         set_attack_Time();
         addChild(lifeMC);
         lifeMC.stop();
         lifeMC.y = -this.skin.height;
      }
      
      private function SkinData(num:int) : String
      {
         var i:* = undefined;
         var ID:int = 0;
         var 警戒:int = 0;
         var 警戒randomXX:int = 0;
         var j:int = 0;
         for(i in EnemyXml.怪物)
         {
            ID = int(EnemyXml.怪物[i].ID);
            if(ID == num)
            {
               this.className = String(EnemyXml.怪物[i].名称);
               this.lifeMAX.setValue(int(EnemyXml.怪物[i].HP));
               this.life.setValue(int(EnemyXml.怪物[i].HP));
               this.walk_power = int(EnemyXml.怪物[i].移动速度);
               this.jumptemp = int(EnemyXml.怪物[i].跳跃力);
               this.jump_power = int(EnemyXml.怪物[i].跳跃力);
               this.jump_time = int(EnemyXml.怪物[i].跳跃时间);
               this.gravity = int(EnemyXml.怪物[i].重力);
               攻击力.setValue(Number(EnemyXml.怪物[i].攻击力));
               防御力.setValue(int(EnemyXml.怪物[i].防御力));
               震退值.setValue(Number(EnemyXml.怪物[i].震退值));
               经验.setValue(int(EnemyXml.怪物[i].经验));
               等级.setValue(int(EnemyXml.怪物[i].等级));
               lastTime = int(EnemyXml.怪物[i].存在时间);
               金钱.setValue(int(EnemyXml.怪物[i].金钱));
               掉落数量.setValue(int(EnemyXml.怪物[i].掉落数量));
               硬直.setValue(Number(EnemyXml.怪物[i].硬直));
               关卡 = int(EnemyXml.怪物[i].关卡);
               警戒 = int(EnemyXml.怪物[i].警戒距离x);
               警戒randomXX = 警戒 - Math.random() * 51;
               if(警戒randomXX < 0)
               {
                  警戒randomXX = 0;
               }
               guard_XY = [警戒randomXX,int(EnemyXml.怪物[i].警戒距离y)];
               for(j = 0; j < 6; j++)
               {
                  if(int(EnemyXml.怪物[i]["攻击距离" + (j + 1) + "x"]) != -1)
                  {
                     attack_XY[j] = [int(EnemyXml.怪物[i]["攻击距离" + (j + 1) + "x"]),int(EnemyXml.怪物[i]["攻击距离" + (j + 1) + "y"])];
                  }
               }
               for(j = 0; j < 20; j++)
               {
                  掉落物品[j] = int(EnemyXml.怪物[i]["掉落物品" + (j + 1)]);
               }
               for(j = 0; j < 20; j++)
               {
                  掉落概率[j] = int(EnemyXml.怪物[i]["掉落概率" + (j + 1)]);
               }
               for(j = 0; j < 3; j++)
               {
                  特殊掉落物品[j] = int(EnemyXml.怪物[i]["特殊掉落ID" + (j + 1)]);
               }
               for(j = 0; j < 3; j++)
               {
                  特殊掉落概率[j] = int(EnemyXml.怪物[i]["特殊概率ID" + (j + 1)]);
               }
               return String(EnemyXml.怪物[i].名称);
            }
         }
         return null;
      }
      
      public function getRandom(num:Number) : Boolean
      {
         var rd:Number = Math.random() * 100;
         if(rd < num)
         {
            return true;
         }
         return false;
      }
      
      public function HpXX(hitX:HitXX, bj:Boolean = false, back:Boolean = false) : *
      {
         var p:Player = null;
         var hpDown:int = 0;
         var playHPxx:Number = NaN;
         var hpXX:Number = NaN;
         var getAllSuitSkill:Array = null;
         var skillDown:int = 0;
         var i:int = 0;
         var hpNum:Number = NaN;
         var arr:Array = null;
         var str:String = null;
         var j:int = 0;
         var rrr:int = 0;
         var crit_temp:Number = NaN;
         var c_temp:Number = NaN;
         var ran:int = 0;
         var lifeX:int = 0;
         hitXX = hitX;
         var attTimes:int = hitX.times;
         var 职业附加:Number = 1;
         var xxx:int = this.x + Math.random() * 100 - 50;
         var yyy:int = this.y + Math.random() * 100 - 50;
         if(hitX.who is Player)
         {
            ChongWu.gongJiYn1 = ChongWu.gongJiYn2 = true;
            p = hitX.who as Player;
            if(p.data.skinArr[p.data.skinNum] == 0)
            {
               职业附加 = Number(p.职业附加[0]);
            }
            else if(p.data.skinArr[p.data.skinNum] == 1)
            {
               职业附加 = Number(p.职业附加[1]);
            }
            else if(p.data.skinArr[p.data.skinNum] == 2)
            {
               职业附加 = Number(p.职业附加[2]);
            }
            playHPxx = p.use_gongji.getValue();
            hpXX = playHPxx * hitX.gongJi_hp * 职业附加;
            hpXX = hpXX + hpXX * Math.random() * VT.GetTempVT("2/10/10") + gongJiPOWER.getValue();
            hpDown = hpXX - 防御力.getValue() / attTimes;
            if(hpDown <= 0)
            {
               hpDown = 0;
            }
            if(bj)
            {
               hpDown *= tempXXX2.getValue();
            }
            p.energySlot.addEnergy(hitX.who,hpDown);
            getAllSuitSkill = p.data.getEquipSlot().getAllSuitSkill();
            skillDown = 0;
            for(i in getAllSuitSkill)
            {
               if(getAllSuitSkill[i] == 57359)
               {
                  if(getRandom(30) && p.flagTempSY)
                  {
                     p.setInTimeCDSY();
                     p.flagTempSY = false;
                     p.HpUp(p.use_hp_Max.getValue() * 0.035);
                     hpNum = p.use_hp_Max.getValue() * 0.035 * (p.use_hp_Max.getValue() / 3000);
                     for(i in All)
                     {
                        HpSXX(All[i],hpNum);
                     }
                  }
               }
               else if(getAllSuitSkill[i] == 57360)
               {
                  if(getRandom(5) && p.flagTempSJ)
                  {
                     p.setInTimeCDSJ();
                     p.flagTempSJ = false;
                     arr = [];
                     str = "";
                     if(p.data.skinArr[p.data.skinNum] == 0)
                     {
                        str = "a";
                     }
                     else if(p.data.skinArr[p.data.skinNum] == 1)
                     {
                        str = "b";
                     }
                     else
                     {
                        str = "c";
                     }
                     for(j in p.AllSkillCDXX)
                     {
                        if((p.AllSkillCDXX[j][0] as String).substr(0,1) == str && int((p.AllSkillCDXX[j][0] as String).substr(1,2)) > 7 && int((p.AllSkillCDXX[j][0] as String).substr(1,2)) <= 15)
                        {
                           if(p.data.getSkillLevel(p.AllSkillCDXX[j][0]) > 0 && p.AllSkillCDXX[j][1] != p.AllSkillCD[j][1])
                           {
                              arr.push(j);
                           }
                        }
                     }
                     if(arr.length > 0)
                     {
                        rrr = Math.random() * arr.length;
                        p.AllSkillCDXX[arr[rrr]][1] = p.AllSkillCD[arr[rrr]][1];
                        p.AllSkillCDXX[arr[rrr]][2] = 50;
                     }
                  }
               }
               else if(getAllSuitSkill[i] == 57361)
               {
                  crit_temp = Math.pow(Number(p.use_baoji.getValue() / 70),0.8) / 100;
                  c_temp = Math.pow(1 + crit_temp,4.7);
                  if(p.data.skinNum == 0)
                  {
                     if(getRandom(35) && p.flagTempBJ && bj)
                     {
                        p.setInTimeCDBJ();
                        p.flagTempBJ = false;
                        skillDown = int(p.data.getEquipSlot().getEquipFromSlot(2).getAttack() * c_temp);
                        NewMC.Open("_特殊数字",Main.world.moveChild_Other,xxx,yyy - 50,20,skillDown,true);
                     }
                  }
                  else if(getRandom(35) && p.flagTempBJ && bj)
                  {
                     p.setInTimeCDBJ();
                     p.flagTempBJ = false;
                     skillDown = int(p.data.getEquipSlot().getEquipFromSlot(5).getAttack() * c_temp);
                     NewMC.Open("_特殊数字",Main.world.moveChild_Other,xxx,yyy - 50,20,skillDown,true);
                  }
               }
               else if(getAllSuitSkill[i] != 57362)
               {
                  if(getAllSuitSkill[i] == 57363)
                  {
                     if(getRandom(15) && p.flagTempXL)
                     {
                        p.setInTimeCDXL();
                        p.flagTempXL = false;
                        skillDown = (p.use_mp_Max.getValue() + p.mp.getValue()) * ((p.use_mp_Max.getValue() + p.mp.getValue()) / 10000);
                        NewMC.Open("_特殊数字",Main.world.moveChild_Other,xxx,yyy - 50,20,skillDown,true);
                     }
                  }
               }
            }
         }
         else
         {
            hpDown = hitX.gongJi_hp;
            if(hpDown <= 0)
            {
               hpDown = 0;
            }
         }
         if(this.className == "阿卡利")
         {
            ran = Math.random() * 100;
            if(ran < 3)
            {
               skin.otherGoTo("攻击5");
               return;
            }
         }
         if(bj)
         {
            if(this.id == 31)
            {
               NewMC.Open("_暴击数字",Main.world.moveChild_Other,xxx,yyy - 200,20,hpDown,true);
            }
            else
            {
               NewMC.Open("_暴击数字",Main.world.moveChild_Other,xxx,yyy,20,hpDown,true);
            }
         }
         else if(this.id == 31)
         {
            NewMC.Open("_攻击数字",Main.world.moveChild_Other,xxx,yyy - 200,15,hpDown,true);
         }
         else
         {
            NewMC.Open("_攻击数字",Main.world.moveChild_Other,xxx,yyy,15,hpDown,true);
         }
         if(hpDown > 0 && life.getValue() > 0)
         {
            this.life.setValue(life.getValue() - hpDown);
            this.life.setValue(life.getValue() - skillDown);
            WinShow.txt_4 += hpDown;
            lifeX = 100 - life.getValue() / lifeMAX.getValue() * 100;
            lifeMC.gotoAndStop(lifeX);
            if(this.life.getValue() <= 0)
            {
               life.setValue(0);
               Main.player_1.ExpUP(this.经验.getValue() * InitData.GetEXPxN().getValue());
               Main.player_1.MoneyUP(this.金钱.getValue());
               if(Main.P1P2)
               {
                  Main.player_2.ExpUP(this.经验.getValue() * InitData.GetEXPxN().getValue());
                  Main.player_2.MoneyUP(this.金钱.getValue());
               }
               任务品掉落();
               装备掉落();
               AchData.addEnemyNum(id);
               TaskData.setEnemyNum(id);
               TaskData.isEnemyTaskOk();
               return;
            }
         }
         var rdm:Number = Math.random() * temp3.getValue() / temp10.getValue();
         浮动硬直 += rdm;
         var XX:Number = hitX.硬直 - skin.被攻击硬直 - 浮动硬直;
         if(XX >= skin.continuousTime)
         {
            XX = hitX.硬直 - this.硬直.getValue() - 浮动硬直;
         }
         if(XX >= 0)
         {
            skin.GoTo("被打",int(XX));
            jump_power = 0;
         }
         if(震退值.getValue() != 0)
         {
            runArr = new Array();
            if(hitX.RL)
            {
               runPower(-hitX.runArr[0] * 震退值.getValue(),hitX.runArr[1] * 震退值.getValue(),hitX.runArr[2]);
            }
            else
            {
               runPower(hitX.runArr[0] * 震退值.getValue(),hitX.runArr[1] * 震退值.getValue(),hitX.runArr[2]);
            }
         }
      }
      
      private function HpSXX(e:Enemy, hpNum:Number) : *
      {
         var lifeX:int = 0;
         var xxxx:int = e.x + Math.random() * 100 - 50;
         var yyyy:int = e.y + Math.random() * 100 - 50;
         NewMC.Open("_特殊数字",Main.world.moveChild_Other,xxxx,yyyy - 50,20,hpNum,true);
         if(hpNum > 0 && e.life.getValue() > 0)
         {
            e.life.setValue(e.life.getValue() - hpNum);
            lifeX = 100 - e.life.getValue() / e.lifeMAX.getValue() * 100;
            e.lifeMC.gotoAndStop(lifeX);
            if(e.life.getValue() <= 0)
            {
               e.life.setValue(0);
               Main.player_1.ExpUP(e.经验.getValue() * InitData.GetEXPxN().getValue());
               Main.player_1.MoneyUP(e.金钱.getValue());
               if(Main.P1P2)
               {
                  Main.player_2.ExpUP(e.经验.getValue() * InitData.GetEXPxN().getValue());
                  Main.player_2.MoneyUP(e.金钱.getValue());
               }
               e.任务品掉落();
               e.装备掉落();
               AchData.addEnemyNum(id);
               TaskData.setEnemyNum(id);
               TaskData.isEnemyTaskOk();
            }
         }
      }
      
      private function 装备掉落() : *
      {
         var id:int = 0;
         var type:int = 0;
         var typeOther:int = 0;
         var xx:* = undefined;
         var arr:Array = null;
         var XXX:Equip = null;
         var ob:obj = null;
         var XXX2:Gem = null;
         var XXX3:Otherobj = null;
         for(var i:int = 0; i < 掉落数量.getValue() * InitData.GetDOWNxN().getValue(); i++)
         {
            id = int(掉落物品计算());
            type = int(String(id).substr(1,1));
            typeOther = int(String(id).substr(0,1));
            xx = this.x + Math.random() * 200 - 100;
            if(id != 0)
            {
               if(type == 1)
               {
                  arr = [id];
                  XXX = EquipFactory.createEquipByColorAndLevel(arr);
                  ob = new obj(XXX,xx,this.y - 100);
               }
               else if(type == 2)
               {
                  arr = [id];
                  XXX2 = GemFactory.createGemByColorAndLevel(arr);
                  ob = new obj(XXX2,xx,this.y - 100);
               }
               if(typeOther == 6)
               {
                  XXX3 = OtherFactory.creatOther(id);
                  ob = new obj(XXX3,xx,this.y - 100);
               }
            }
         }
      }
      
      private function 掉落物品计算() : int
      {
         var xx:int = Math.random() * 10000 + 1;
         var num:int = 0;
         for(j = 0; j < 20; ++j)
         {
            num += 掉落概率[j];
            if(num >= xx)
            {
               return 掉落物品[j];
            }
         }
         return 0;
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         Main.world.moveChild_Enemy.addChild(this);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         this.skin.Over();
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function Dead() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
            this.life.setValue(0);
         }
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      private function onENTER_FRAME(e:*) : *
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
         if(life.getValue() > 0)
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
      
      private function MoveData() : *
      {
         var randomNum:int = 0;
         var randomRun:String = null;
         var jump:int = 0;
         WhereAreYou();
         Attack_TimeXX();
         var distance_XX:* = Math.abs(distance_X);
         var distance_YY:* = Math.abs(distance_Y);
         if(skin.runType == "站立" || skin.runType == "移动" || skin.runType == "跳")
         {
            randomNum = Math.random() * attack_XY.length;
            randomRun = "攻击" + (randomNum + 1);
            if(skin.continuousTime <= 0)
            {
               jump_power = jumptemp;
               if(attack_Time[randomNum] == attack_TimeNum[randomNum] && distance_XX < attack_XY[randomNum][0] && distance_YY < attack_XY[randomNum][1])
               {
                  if(distance_X > 0)
                  {
                     getRL(false);
                  }
                  else
                  {
                     getRL(true);
                  }
                  attack_TimeNum[randomNum] = 0;
                  if(this.className == "金牛座")
                  {
                     trace("技能是 = " + randomNum);
                     if(randomNum == 4 && bool_5)
                     {
                        skin.GoTo(randomRun);
                        bool_6 = false;
                        bool_5 = false;
                     }
                     else if(randomNum == 5 && bool_6)
                     {
                        skin.GoTo(randomRun);
                        bool_5 = false;
                        bool_6 = false;
                     }
                     else if(randomNum < 4)
                     {
                        skin.GoTo(randomRun);
                     }
                  }
                  else
                  {
                     skin.GoTo(randomRun);
                  }
                  this.浮动硬直 = 0;
               }
               else
               {
                  if(this.className == "火鸟王")
                  {
                     this.skin.GoTo("移动");
                     return;
                  }
                  if(distance_XX < 50 && distance_YY < 500)
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
            }
            jump = Math.random() * 60;
            if(jump == 0 && !jumping)
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
         for(var i:* = int(runArr.length - 1); i >= 0; i--)
         {
            if(runArr[i][2] > 0)
            {
               runX += runArr[i][0] + runArr[i][3] * runArr[i][2];
               runY -= runArr[i][1] + runArr[i][4] * runArr[i][2];
               --runArr[i][2];
            }
            else
            {
               runArr.splice(i,1);
            }
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
      
      private function WhereAreYou() : *
      {
         var i:int = 0;
         var dx2:* = undefined;
         if(Player.All.length > 0)
         {
            distance_X = this.x - Player.All[0].x;
            distance_Y = this.y - Player.All[0].y;
            for(i = 1; i < Player.All.length; i++)
            {
               dx2 = this.x - Player.All[i].x;
               if(Math.abs(dx2) < Math.abs(distance_X))
               {
                  distance_X = dx2;
                  distance_Y = this.y - Player.All[i].y;
               }
            }
         }
         else
         {
            distance_X = 0;
         }
      }
      
      private function MoveRun() : *
      {
         var xxYN:Boolean = false;
         var i:* = 0;
         var tempX:int = 0;
         var AA:Boolean = false;
         var i2:uint = 0;
         var map:* = undefined;
         var BB:Boolean = false;
         var CC:Boolean = false;
         if(runX > 0)
         {
            xxYN = true;
         }
         var xx:int = int(this.runX);
         var yy:int = int(this.runY);
         var forecast_x:* = int(this.x + Main.world.x);
         var forecast_y:* = int(this.y);
         for(i = int(Math.abs(yy)); i > 0; i--)
         {
            if(this.jumpType == 1)
            {
               AA = Boolean(Main.world.MapData1.hitTestPoint(forecast_x,forecast_y - this.height,true));
               if(!AA)
               {
                  for(i2 = 0; i2 < Main.world.numChildren; i2++)
                  {
                     map = Main.world.getChildAt(i2);
                     if(map is Map && Boolean(map.MapData1.hitTestPoint(forecast_x,forecast_y - this.height,true)))
                     {
                        AA = true;
                        break;
                     }
                  }
               }
               if(!AA)
               {
                  forecast_y--;
               }
            }
            else if(this.jumpType == 2)
            {
               BB = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 3,true));
               AA = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 1,true));
               CC = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y + 6,true));
               for(i2 = 0; i2 < Main.world.numChildren; i2++)
               {
                  map = Main.world.getChildAt(i2);
                  if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x,forecast_y - 3,true)))
                  {
                     BB = true;
                  }
                  else if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x,forecast_y - 1,true)))
                  {
                     AA = true;
                  }
                  else if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x,forecast_y + 6,true)))
                  {
                     CC = true;
                  }
               }
               jumping = false;
               if(BB)
               {
                  forecast_y -= 2;
               }
               else if(AA)
               {
                  runY = 0;
                  gravityNum = 0;
               }
               else if(CC)
               {
                  forecast_y += 3;
               }
               else
               {
                  forecast_y++;
                  this.jumping = true;
               }
            }
            else if(this.jumpType == 3)
            {
               AA = Boolean(Main.world.MapData1.hitTestPoint(forecast_x,forecast_y - 1,true));
               for(i2 = 0; i2 < Main.world.numChildren; i2++)
               {
                  map = Main.world.getChildAt(i2);
                  if(map is Map && Boolean(map.MapData1.hitTestPoint(forecast_x,forecast_y - this.height,true)))
                  {
                     AA = true;
                  }
               }
               if(!AA)
               {
                  jumpType = 2;
                  break;
               }
               forecast_y++;
            }
         }
         this.y = forecast_y;
         if(xx > 0)
         {
            tempX = forecast_x - 20;
         }
         else
         {
            tempX = forecast_x + 20;
         }
         for(i = int(Math.abs(xx)); i > 0; i--)
         {
            AA = Boolean(Main.world.MapData1.hitTestPoint(tempX,forecast_y - 50,true));
            if(!AA)
            {
               for(i2 = 0; i2 < Main.world.numChildren; i2++)
               {
                  map = Main.world.getChildAt(i2);
                  if(map is Map && Boolean(map.MapData.hitTestPoint(tempX,forecast_y - 50,true)))
                  {
                     AA = true;
                     break;
                  }
               }
            }
            if(!AA)
            {
               if(xx > 0)
               {
                  forecast_x--;
               }
               else
               {
                  forecast_x++;
               }
            }
         }
         var xxx:int = forecast_x - Main.world.x;
         if(xxx > Main.world._width + 200)
         {
            this.x = Main.world._width + 200;
         }
         else if(xxx < -200)
         {
            this.x = -200;
         }
         else
         {
            this.x = xxx;
         }
      }
      
      public function runPower(numX:Number = 0, numY:Number = 0, time:int = 0) : *
      {
         if(time <= 3)
         {
            runArr[runArr.length] = [numX,numY,1,0,0,0];
            return;
         }
         var numXX:* = numX / time * parabola;
         var numYY:* = numY / time * parabola;
         var gravityX:Number = numX * (1 - parabola) / (time * time - time * (time - 1) / 2);
         var gravityY:Number = numY * (1 - parabola) / (time * time - time * (time - 1) / 2);
         runArr[runArr.length] = [numXX,numYY,time,gravityX,gravityY];
      }
      
      public function getRL(_RL:Boolean) : *
      {
         this.RL = _RL;
         if(this.className == "金牛座石像" || this.className == "金牛座石像2")
         {
            return;
         }
         if(_RL)
         {
            skin.scaleX = -1;
         }
         else if(!_RL)
         {
            skin.scaleX = 1;
         }
      }
      
      private function set_attack_Time() : *
      {
         var i:* = undefined;
         var idX:int = 0;
         var str:String = null;
         var rTime:int = 0;
         EnemySkinXml = EnemySkin.EnemySkinXmlArr[GameData.gameLV][关卡];
         for(var x:int = 0; x < attack_XY.length; x++)
         {
            for(i in EnemySkinXml.怪物攻击)
            {
               idX = int(EnemySkinXml.怪物攻击[i].ID);
               str = String(EnemySkinXml.怪物攻击[i].帧标签);
               if(id == idX && str == "攻击" + (x + 1))
               {
                  rTime = int(EnemySkinXml.怪物攻击[i].间隔);
                  attack_Time[x] = rTime;
                  attack_TimeNum[x] = int(rTime * Math.random());
                  break;
               }
            }
         }
      }
      
      private function Attack_TimeXX() : *
      {
         for(var i:int = 0; i < attack_TimeNum.length; i++)
         {
            if(attack_TimeNum[i] < attack_Time[i])
            {
               ++attack_TimeNum[i];
            }
         }
      }
      
      private function 任务品掉落() : *
      {
         var XXX3:Quest = null;
         var ob:obj = null;
         var id:int = int(任务概率掉落计算());
         if(id != 0)
         {
            XXX3 = QuestFactory.creatQust(id);
            ob = new obj(XXX3,this.x,this.y);
         }
      }
      
      private function 任务概率掉落计算() : int
      {
         var fallLevel:Number = NaN;
         var type:Number = NaN;
         var questId:Number = NaN;
         var xx:int = 0;
         if(!mainQuest())
         {
            if(!getbagQuestNum())
            {
               xx = Math.random() * 10000 + 1;
            }
            else
            {
               xx = 99999;
            }
         }
         else
         {
            xx = 99999;
         }
         for(j = 0; j < 3; ++j)
         {
            fallLevel = Number(特殊掉落物品[j]);
            if(fallLevel != 0)
            {
               type = Number(QuestFactory.getType(fallLevel));
               if(type == 0)
               {
                  questId = Number(QuestFactory.getTaskId(fallLevel));
                  if(TaskData.isTaskById(questId) != null)
                  {
                     if(!TaskData.getAddBag(questId))
                     {
                        if(xx <= 特殊掉落概率[j])
                        {
                           return fallLevel;
                        }
                     }
                  }
               }
               else if(xx <= 特殊掉落概率[j])
               {
                  return fallLevel;
               }
            }
         }
         return 0;
      }
      
      private function getbagQuestNum() : Boolean
      {
         var fallLevel:Number = NaN;
         var bagNum:Number = NaN;
         var type:Number = NaN;
         for(var i:uint = 0; i < 3; i++)
         {
            if(特殊掉落物品[i] != 0)
            {
               fallLevel = Number(特殊掉落物品[i]);
               type = Number(QuestFactory.getType(fallLevel));
               if(type == 1)
               {
                  if(Main.player2 == null)
                  {
                     return p1bagFall(fallLevel);
                  }
                  if(p1bagFall(fallLevel) || p2bagFall(fallLevel))
                  {
                     return true;
                  }
               }
               else if(type == 2)
               {
                  if(Main.player2 == null)
                  {
                     if(p1bagFall(fallLevel))
                     {
                        return p1bagFall(fallLevel);
                     }
                  }
                  else
                  {
                     if(p1bagFall(fallLevel) && p2bagFall(fallLevel))
                     {
                        return true;
                     }
                     if(Boolean(SetTransferPanel.tbo1()) && p2bagFall(fallLevel))
                     {
                        return true;
                     }
                     if(Boolean(SetTransferPanel.tbo2()) && p1bagFall(fallLevel))
                     {
                        return true;
                     }
                  }
               }
               else if(type == 0)
               {
                  return false;
               }
            }
         }
         return false;
      }
      
      public function p1bagFall(fallLevel:Number) : Boolean
      {
         var bagNum:Number = Number(Main.player1.getBag().fallQusetBag(fallLevel));
         var fallMax:Number = Number(QuestFactory.getFallMax(fallLevel));
         if(bagNum < fallMax)
         {
            return false;
         }
         return true;
      }
      
      public function p2bagFall(fallLevel:Number) : Boolean
      {
         var bagNum:Number = Number(Main.player2.getBag().fallQusetBag(fallLevel));
         var fallMax:Number = Number(QuestFactory.getFallMax(fallLevel));
         if(bagNum < fallMax)
         {
            return false;
         }
         return true;
      }
      
      private function mainQuest() : Boolean
      {
         var fallLevel:Number = NaN;
         var type:Number = NaN;
         var p1:Boolean = false;
         var p2:Boolean = false;
         for(var i:uint = 0; i < 3; i++)
         {
            if(特殊掉落物品[i] != 0)
            {
               fallLevel = Number(特殊掉落物品[i]);
               type = Number(QuestFactory.getType(fallLevel));
               if(type == 1)
               {
                  return Main.getQuest(fallLevel);
               }
               if(type == 2)
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
               else if(type == 0)
               {
                  return false;
               }
            }
         }
         return false;
      }
   }
}

