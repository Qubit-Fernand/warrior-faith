package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.elves.Elves;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.pet.Pet;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.views.cardPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import src.other.*;
   import src.tool.*;
   
   public class Player extends MovieClip
   {
      
      public static var LV_data:XML;
      
      public static var enemySkillMC:*;
      
      public static var maxLevel:int = 85;
      
      public static var All:Array = [];
      
      public static var PlayerMcLoaded:Boolean = false;
      
      public static var PlayerMcArr:Array = new Array();
      
      public static var num_hp:VT = VT.createVT();
      
      public static var num_mp:VT = VT.createVT();
      
      public static var num_gj:VT = VT.createVT();
      
      public static var num_fy:VT = VT.createVT();
      
      public static var num_sb:VT = VT.createVT();
      
      public static var num_bj:VT = VT.createVT();
      
      public static var num_sd:VT = VT.createVT();
      
      public static var num_1:VT = VT.createVT();
      
      public static var num_15:VT = VT.createVT();
      
      public static var num_20:VT = VT.createVT();
      
      public static var num_25:VT = VT.createVT();
      
      public static var num_30:VT = VT.createVT();
      
      public static var num_35:VT = VT.createVT();
      
      public static var num_7:VT = VT.createVT();
      
      public static var num_5:VT = VT.createVT();
      
      public static var num_27:VT = VT.createVT();
      
      public static var num_13:VT = VT.createVT();
      
      public static var num_65:VT = VT.createVT();
      
      private static var Temp11:VT = VT.createVT(VT.GetTempVT("10+1/10"));
      
      public var lianjiBool:Boolean = false;
      
      public var noMove:Boolean = false;
      
      private var tempXXX2:VT = VT.createVT(VT.GetTempVT("8/4"));
      
      public var hitXX:HitXX;
      
      public var shuangShouBeiShu:Number = 1;
      
      public var energySlot:EnergySlot = new EnergySlot();
      
      public var skin:Skin;
      
      public var cengHao_mc:CengHao = new CengHao();
      
      public var skin_Z:Skin_ZhuangBei;
      
      public var skin_Z2:Skin_ZhuangBei;
      
      public var skin_Z3:Skin_ZhuangBei;
      
      public var skin_Z2_V:Boolean = true;
      
      public var skin_Z3_V:Boolean = true;
      
      public var headFrame:int = 1;
      
      public var skin_W:Skin_WuQi;
      
      public var playerCW:ChongWu;
      
      public var playerJL:JingLing;
      
      public var hit:MovieClip = null;
      
      private var nodead:MovieClip = new undeath();
      
      public var deadX:Dead;
      
      public var 职业附加:Array = [1,1,1];
      
      public var 套装强化:Array = [0,0,0,0,0,false,false,false];
      
      public var 装备附加:Array = [];
      
      public var time:int = 1000;
      
      public var lianJi:VT = VT.createVT(0);
      
      public var lianJiTime:VT = VT.createVT(60);
      
      public var data:PlayerData;
      
      public var nextExp:VT = VT.createVT();
      
      public var speedTemp:VT = VT.createVT(0);
      
      public var hp:VT = VT.createVT();
      
      public var mp:VT = VT.createVT();
      
      public var hp_Max:VT = VT.createVT();
      
      public var mp_Max:VT = VT.createVT();
      
      public var gongji:VT = VT.createVT();
      
      public var fangyu:VT = VT.createVT();
      
      public var baoji:VT = VT.createVT();
      
      public var sanbi:VT = VT.createVT();
      
      public var walk_power:VT = VT.createVT();
      
      public var yingzhi:VT = VT.createVT();
      
      public var use_hp_Max:VT = VT.createVT();
      
      public var use_mp_Max:VT = VT.createVT();
      
      public var use_gongji:VT = VT.createVT();
      
      public var use_gongji2:VT = VT.createVT();
      
      public var use_fangyu:VT = VT.createVT();
      
      public var use_fangyu2:VT = VT.createVT();
      
      public var use_baoji:VT = VT.createVT();
      
      public var use_sanbi:VT = VT.createVT();
      
      public var temp_hp_Max:VT = VT.createVT();
      
      public var temp_mp_Max:VT = VT.createVT();
      
      public var temp_gongji:VT = VT.createVT();
      
      public var temp_fangyu:VT = VT.createVT();
      
      public var temp_baoji:VT = VT.createVT();
      
      public var temp_sanbi:VT = VT.createVT();
      
      public var AllSkillCD:Array = new Array();
      
      public var AllSkillCDXX:Array = new Array();
      
      public var All_ObjCD:Array = new Array();
      
      public var All_ObjCDXX:Array = new Array();
      
      public var RL:Boolean = true;
      
      private var jump_power:* = 145;
      
      private var jump_time:* = 8;
      
      private var parabola:Number = 0.3;
      
      private var jumping:int = 0;
      
      private var jumpX2:Boolean = false;
      
      private var jumpType:int = 2;
      
      private var gravity:int = 2;
      
      private var gravityNum:* = 0;
      
      private var SwitchingTime:int;
      
      public var noHit:Boolean = false;
      
      public var fangYuPOWER:VT = VT.createVT();
      
      private var KeyArrStr:Array = ["上","下","左","右","攻击","跳","切换","技能1","技能2","技能3","技能4","消耗1","消耗2","消耗3","转职","怪物"];
      
      private var getAllMoveSpeed:VT = VT.createVT(-99);
      
      private var getAllSuitSkill:Array;
      
      private var getAllEquipSkill:Array;
      
      private var Vip_Point_YN:Boolean = true;
      
      public var noHead:Boolean = false;
      
      public var flagTempMP:Boolean = true;
      
      public var flagTempXL:Boolean = true;
      
      public var flagTempSY:Boolean = true;
      
      public var flagTempSJ:Boolean = true;
      
      public var flagTempRX:Boolean = true;
      
      public var flagTempBJ:Boolean = true;
      
      public var timeTemp:int = 0;
      
      public var timeTempmp:int = 0;
      
      public var rexuewudi:Boolean = false;
      
      internal var jKey:Boolean = false;
      
      public var flyTime:int = 0;
      
      public var fly:Boolean = false;
      
      public var newLifeTime:VT = VT.createVT();
      
      private var runX:int = 0;
      
      private var runY:int = 0;
      
      private var runArr:Array = new Array();
      
      public function Player()
      {
         super();
         mouseEnabled = mouseChildren = false;
         this.deadX = new Dead();
         addChild(this.deadX);
         this.deadX.visible = false;
         addEventListener(Event.ADDED_TO_STAGE,this.onADDED_TO_STAGE);
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
      }
      
      public static function Init() : *
      {
         num_hp = VT.createVT(1);
         num_mp = VT.createVT(1);
         num_gj = VT.createVT(1);
         num_fy = VT.createVT(1);
         num_sb = VT.createVT(1);
         num_bj = VT.createVT(1);
         num_sd = VT.createVT(0);
         num_5 = VT.createVT(0.05);
         num_1 = VT.createVT(0.1);
         num_15 = VT.createVT(0.15);
         num_20 = VT.createVT(0.2);
         num_25 = VT.createVT(0.25);
         num_30 = VT.createVT(0.3);
         num_35 = VT.createVT(0.35);
         num_7 = VT.createVT(0.07);
         num_13 = VT.createVT(0.13);
         num_27 = VT.createVT(0.27);
         num_65 = VT.createVT(0.65);
      }
      
      public static function getPlayerLvData(pd:PlayerData) : XML
      {
         var i:* = undefined;
         var lv:int = 0;
         for(i in LV_data.角色)
         {
            lv = int(LV_data.角色[i].等级);
            if(lv == pd.getLevel())
            {
               return LV_data.角色[i];
            }
         }
         return null;
      }
      
      public static function 一起信春哥() : *
      {
         Main.player_1.deadX.visible = false;
         Main.player_1.信春哥();
         Main.player_1.energySlot.setZero();
         Main.player_1.runArr = new Array();
         if(Main.P1P2)
         {
            Main.player_2.deadX.visible = false;
            Main.player_2.信春哥();
            Main.player_2.runArr = new Array();
            Main.player_2.energySlot.setZero();
         }
      }
      
      public static function getEquipDataXX() : *
      {
         Main.player_1.getEquipData(true);
         if(Main.P1P2)
         {
            Main.player_2.getEquipData(true);
         }
      }
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         Main.world.moveChild_Player.addChild(this);
         All[All.length] = this;
         Main._stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKEY_DOWN);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onREMOVED_FROM_STAGE);
      }
      
      public function 不信春哥() : *
      {
         if(!this.deadX.visible)
         {
            NewMC.Open("死亡倒计时",this);
         }
         this.deadX.frame = this.headFrame;
         if(this.noHead)
         {
            this.deadX.head_mc.gotoAndStop(24);
            this.deadX.head_mc.visible = true;
         }
         else
         {
            this.deadX.head_mc.gotoAndStop(this.deadX.frame);
         }
         this.deadX.visible = true;
         this.skin_Z.visible = false;
         this.skin_W.visible = false;
         if(this.skin_Z2)
         {
            this.skin_Z2.visible = false;
         }
         if(this.skin_Z3)
         {
            this.skin_Z3.visible = false;
         }
         this.energySlot.setZero();
      }
      
      public function 信春哥() : *
      {
         this.deadX.visible = false;
         this.skin.visible = true;
         this.skin_Z.visible = true;
         this.skin_W.visible = true;
         this.PK_hpMax();
         this.hp.setValue(9999999);
         this.mp.setValue(9999999);
         continuousTime = 0;
         this.skin.GoTo("站立",1,true);
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         this.skin.Over();
      }
      
      public function ExpUP(num:int, type:int = 1) : String
      {
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         this.data.setEXP(this.data.getEXP() + num);
         if(this.data.getEXP() >= this.nextExp.getValue())
         {
            return this.LevelUP(type);
         }
         return "ok";
      }
      
      public function LevelUP(type:int = 1) : *
      {
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         var levelX:int = this.data.getLevel();
         if(levelX < Player.maxLevel)
         {
            if(type == 1)
            {
               this.data.setEXP(0);
               this.LevelUP_X();
            }
            else if(type == 2)
            {
               while(this.data.getEXP() >= this.nextExp.getValue())
               {
                  this.data.setEXP(this.data.getEXP() - this.nextExp.getValue());
                  this.LevelUP_X();
               }
            }
            NewMC.Open("升级效果",this);
            if(this.data.getLevel() >= 50)
            {
               this.data.setRebirth();
            }
         }
      }
      
      public function LevelUP_X() : *
      {
         this.data.setLevel(this.data.getLevel() + VT.GetTempVT("8/8"));
         TiaoShi.tempVar = "data.getLevel() = " + this.data.getLevel() + " , data.getEXP() = " + this.data.getEXP();
         if(this.data.isRebirth())
         {
            this.data.addPoint(VT.GetTempVT("10/2"));
         }
         else
         {
            this.data.addPoint(VT.GetTempVT("8/2"));
         }
         this.LoadPlayerLvData();
         this.信春哥();
      }
      
      public function MoneyUP(m:int) : *
      {
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         this.data.addGold(m);
         NewMC.Open("掉钱",this,0,0,15,m,true);
      }
      
      public function Load_All_Player_Data() : *
      {
         this.LoadPlayerLvData();
         this.GetAllSkillCD();
         this.GetAllObjCD();
         this.newSkin();
         this.信春哥();
         this.left_Reight();
         this.ChongSeng_no50lv();
      }
      
      private function ChongSeng_no50lv() : *
      {
         if(this.data.getLevel() >= 50)
         {
            this.data.setRebirth();
         }
      }
      
      public function left_Reight() : *
      {
         if(this.data.getEquipSkillSlot().getGemFromSkillSlot(0) != null)
         {
            this.energySlot.energyLeftNum.setValue(0);
            this.energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(this.data.getEquipSkillSlot().getGemFromSkillSlot(0).getGemSkill()).getEp());
         }
         if(this.data.getEquipSkillSlot().getGemFromSkillSlot(1) != null)
         {
            this.energySlot.energyRightNum.setValue(0);
            this.energySlot.energyRightMax.setValue(SkillFactory.getSkillById(this.data.getEquipSkillSlot().getGemFromSkillSlot(1).getGemSkill()).getEp());
         }
      }
      
      public function LoadPlayerLvData() : *
      {
         this.双手加成();
         var xml:XML = Player.getPlayerLvData(this.data);
         this.nextExp.setValue(int(xml.经验));
         var hpMaxX:int = int(xml.HP) + this.data.getEquipSlot().getAllHP();
         this.hp_Max.setValue(hpMaxX);
         var mpMaxX:int = int(xml.MP) + this.data.getEquipSlot().getAllMP();
         this.mp_Max.setValue(mpMaxX);
         var gongJiX:int = (int(xml.攻击) + this.data.getEquipSlot().getAllAttack()) * this.shuangShouBeiShu;
         this.gongji.setValue(gongJiX);
         var fangyuX:int = int(xml.防御) + this.data.getEquipSlot().getAllDefense();
         this.fangyu.setValue(fangyuX);
         var baojibaojiX:int = int(xml.暴击) + this.data.getEquipSlot().getAllCrit();
         this.baoji.setValue(baojibaojiX);
         var sanbiX:int = int(xml.闪避) + this.data.getEquipSlot().getAllDuck();
         this.sanbi.setValue(sanbiX);
         var yingzhiX:int = int(xml.硬值) + this.data.getEquipSlot().getAllHardValue();
         this.yingzhi.setValue(yingzhiX);
         var gj2:int = this.data.getEquipSlot().getAllPOMO();
         this.use_gongji2.setValue(gj2);
         var fy2:int = this.data.getEquipSlot().getAllMOKANG();
         this.use_fangyu2.setValue(fy2);
         this.walk_power.setValue(6 + this.data.getEquipSlot().getAllMoveSpeed());
         this.LoadAll_D_Skill();
      }
      
      private function LoadAll_D_Skill() : *
      {
         var i:int = 0;
         var s:String = null;
         var arr:Array = null;
         var num:Number = NaN;
         var num2:Number = NaN;
         for(i in this.data.getSkillArr())
         {
            s = (this.data.getSkillArr()[i][0] as String).substr(0,1);
            if(s == "d")
            {
               if(this.data.getSkillArr()[i][0] == "d1" && this.data.getSkillArr()[i][1] > 0)
               {
                  this.jumpX2 = true;
               }
               else if(this.data.getSkillArr()[i][0] == "d2" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  this.hp_Max.setValue(this.hp_Max.getValue() + num);
               }
               else if(this.data.getSkillArr()[i][0] == "d3" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  this.mp_Max.setValue(this.mp_Max.getValue() + num);
               }
               else if(this.data.getSkillArr()[i][0] == "d4" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  this.baoji.setValue(this.baoji.getValue() + num);
               }
               else if(this.data.getSkillArr()[i][0] == "d5" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  this.sanbi.setValue(this.sanbi.getValue() + num);
               }
               else if(this.data.getSkillArr()[i][0] == "d6" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  this.职业附加[0] = 1 + num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d7" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  this.职业附加[1] = 1 + num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d8" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  this.职业附加[2] = 1 + num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d9" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  this.套装强化[0] = num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d10" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  this.套装强化[1] = num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d11" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  this.套装强化[2] = num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d12" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  this.套装强化[3] = num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d13" && this.data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[i][0],this.data.getSkillArr()[i][1]).getSkillValueArray();
                  this.套装强化[4] = num2;
               }
               else if(this.data.getSkillArr()[i][0] == "d14" && this.data.getSkillArr()[i][1] > 0)
               {
                  this.套装强化[5] = true;
               }
               else if(this.data.getSkillArr()[i][0] == "d15" && this.data.getSkillArr()[i][1] > 0)
               {
                  this.套装强化[6] = true;
               }
               else if(this.data.getSkillArr()[i][0] == "d16" && this.data.getSkillArr()[i][1] > 0)
               {
                  this.套装强化[7] = true;
               }
            }
         }
      }
      
      private function getEquipData(now:Boolean = false) : *
      {
         var getAllEquipSkillXX:Array = null;
         var i:int = 0;
         if(this.getAllMoveSpeed.getValue() == -99 || now)
         {
            this.getAllMoveSpeed.setValue(this.data.getEquipSlot().getAllMoveSpeed());
         }
         if(!this.getAllSuitSkill || now)
         {
            this.getAllSuitSkill = this.data.equipSlot.getAllSuitSkill();
         }
         if(!this.getAllEquipSkill || now)
         {
            getAllEquipSkillXX = this.data.getEquipSlot().getAllEquipSkill();
            this.getAllEquipSkill = new Array();
            for(i in getAllEquipSkillXX)
            {
               this.getAllEquipSkill[i] = SkillFactory.getSkillById(getAllEquipSkillXX[i]);
            }
         }
      }
      
      private function LoadAll_ZB_Skill() : *
      {
         this.getEquipData();
         this.use_hp_Max.setValue(this.hp_Max.getValue());
         this.use_mp_Max.setValue(this.mp_Max.getValue());
         this.use_gongji.setValue(this.gongji.getValue());
         this.use_fangyu.setValue(this.fangyu.getValue());
         this.use_baoji.setValue(this.baoji.getValue());
         this.use_sanbi.setValue(this.sanbi.getValue());
         this.walk_power.setValue(6 + this.getAllMoveSpeed.getValue() + this.speedTemp.getValue());
         this.reSet();
         this.装备技能();
         this.zengFu();
         this.huiZhangJiaCheng();
         this.chongwujiacheng();
         this.QiangHuaJiaCheng();
         this.chenghaoJiaCheng();
         this.VIPJiaCheng();
         this.jinglingjiacheng();
         this.cardjiacheng();
         this.stampjiacheng();
         this.ALLTempcompute();
         this.TaoZhuangXiaoGuo();
         this.ALLcompute();
         this.PK_hpMax();
         this.ZB_HpMpUP();
         this.数值溢出修正();
      }
      
      private function PK_hpMax() : *
      {
         if(Main.gameNum.getValue() == 999)
         {
            this.use_hp_Max.setValue(this.use_hp_Max.getValue() * InitData.pkHpMaxNum_Player.getValue());
         }
         else
         {
            this.use_hp_Max.setValue(this.use_hp_Max.getValue());
         }
      }
      
      private function 装备技能() : *
      {
         var i:int = 0;
         var idX:int = 0;
         var sk_ValueArr:Array = null;
         var num:Number = NaN;
         var hpXX:int = 0;
         for(i in this.getAllEquipSkill)
         {
            idX = int(this.getAllEquipSkill[i].getSkillActOn());
            sk_ValueArr = this.getAllEquipSkill[i].getSkillValueArray();
            if(idX == 31)
            {
               hpXX = this.hp_Max.getValue() * sk_ValueArr[1].getValue();
               if(this.hp.getValue() < hpXX)
               {
                  num = Number(sk_ValueArr[0].getValue());
                  num_gj.setValue(num_gj.getValue() + num);
               }
            }
            else if(idX == 32)
            {
               if(this.lianJi.getValue() > sk_ValueArr[1].getValue())
               {
                  num = Number(sk_ValueArr[0].getValue());
                  num_gj.setValue(num_gj.getValue() + num);
               }
            }
            else if(idX == 35)
            {
               num = this.use_baoji.getValue() + sk_ValueArr[0].getValue();
               this.use_baoji.setValue(num);
            }
            else if(idX == 200)
            {
               if(Boolean(this.data.getEquipSlot().getEquipFromSlot(6)) && this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
               {
                  num_fy.setValue(num_fy.getValue() + sk_ValueArr[0].getValue());
                  num_gj.setValue(num_gj.getValue() + sk_ValueArr[1].getValue());
               }
            }
            else if(idX == 201)
            {
               if(Boolean(this.data.getEquipSlot().getEquipFromSlot(7)) && this.data.getEquipSlot().getEquipFromSlot(7).getRemainingTime() > 0)
               {
                  num_hp.setValue(num_hp.getValue() + sk_ValueArr[0].getValue());
                  num_bj.setValue(num_bj.getValue() + sk_ValueArr[1].getValue());
               }
            }
         }
      }
      
      private function ZB_HpMpUP() : *
      {
         var idX:int = 0;
         var sk_ValueArr:Array = null;
         for(i in this.getAllEquipSkill)
         {
            idX = int(this.getAllEquipSkill[i].getSkillActOn());
            sk_ValueArr = this.getAllEquipSkill[i].getSkillValueArray();
            if(idX == 33)
            {
               if(this.time % (sk_ValueArr[0].getValue() - this.套装强化[0]) == 0)
               {
                  num = sk_ValueArr[1].getValue() * this.use_mp_Max.getValue();
                  this.MP_UP(num);
               }
            }
            else if(idX == 34)
            {
               if(this.time % (sk_ValueArr[0].getValue() - this.套装强化[1]) == 0)
               {
                  if(PK_UI.PK_ing)
                  {
                     num = sk_ValueArr[1].getValue() * this.use_hp_Max.getValue() / 20;
                  }
                  else
                  {
                     num = sk_ValueArr[1].getValue() * this.use_hp_Max.getValue();
                  }
                  this.HP_UP(num);
               }
            }
         }
      }
      
      private function huiZhangJiaCheng() : *
      {
         num_hp.setValue(this.data.getBadgeSlot().getHP() + num_hp.getValue());
         num_bj.setValue(this.data.getBadgeSlot().getCRIT() + num_bj.getValue());
         num_gj.setValue(this.data.getBadgeSlot().getATT() + num_gj.getValue());
         num_fy.setValue(this.data.getBadgeSlot().getDEF() + num_fy.getValue());
         num_mp.setValue(this.data.getBadgeSlot().getMP() + num_mp.getValue());
         num_sd.setValue(this.data.getBadgeSlot().getSPEED() + num_sd.getValue());
      }
      
      private function VIPJiaCheng() : *
      {
         for(var j:int = 0; j < Main.player1.getTitleSlot().getListLength(); j++)
         {
            if(Main.player1.getTitleSlot().getTitleFromSlot(j).getId() == 25)
            {
               num_hp.setValue(num_5.getValue() + num_hp.getValue());
               num_bj.setValue(num_5.getValue() + num_bj.getValue());
               num_gj.setValue(num_5.getValue() + num_gj.getValue());
               num_fy.setValue(num_5.getValue() + num_fy.getValue());
               num_mp.setValue(num_5.getValue() + num_mp.getValue());
               num_sb.setValue(num_5.getValue() + num_sb.getValue());
               this.Vip_Point();
            }
         }
      }
      
      private function Vip_Point() : *
      {
         if(Shop4399.totalPaiedMoney.getValue() < 0)
         {
            if(Boolean(this.Vip_Point_YN) && this == Main.player_1)
            {
               Api_4399_All.TotalPaied();
               this.Vip_Point_YN = false;
            }
         }
         else if(Shop4399.totalPaiedMoney.getValue() < 2900)
         {
            SaveXX.Save(13,2990,true,false,false);
         }
      }
      
      private function zengFu() : *
      {
         var i:int = 0;
         var idX:int = 0;
         var sk_ValueArr:Array = null;
         var arr:Array = this.data.equipSlot.getAllEquipNewSkill();
         for(i in arr)
         {
            idX = int(SkillFactory.getSkillById(arr[i]).getSkillActOn());
            sk_ValueArr = SkillFactory.getSkillById(arr[i]).getSkillValueArray();
            if(idX == 39)
            {
               num_gj.setValue(num_gj.getValue() + sk_ValueArr[0].getValue());
            }
            else if(idX == 40)
            {
               num_bj.setValue(num_bj.getValue() + sk_ValueArr[0].getValue());
            }
            else if(idX == 41)
            {
               num_sb.setValue(num_sb.getValue() + sk_ValueArr[0].getValue());
            }
            else if(idX == 42)
            {
               num_hp.setValue(num_hp.getValue() + sk_ValueArr[0].getValue());
            }
            else if(idX == 43)
            {
               num_fy.setValue(num_fy.getValue() + sk_ValueArr[0].getValue());
            }
         }
      }
      
      private function reSet() : *
      {
         num_gj.setValue(InitData.BuyNum_1.getValue());
         num_fy.setValue(InitData.BuyNum_1.getValue());
         num_hp.setValue(InitData.BuyNum_1.getValue());
         num_mp.setValue(InitData.BuyNum_1.getValue());
         num_sb.setValue(InitData.BuyNum_1.getValue());
         num_bj.setValue(InitData.BuyNum_1.getValue());
         num_sd.setValue(InitData.BuyNum_0.getValue());
      }
      
      private function ALLcompute() : *
      {
         this.use_hp_Max.setValue(int(this.use_hp_Max.getValue() * num_hp.getValue()));
         this.use_mp_Max.setValue(int(this.use_mp_Max.getValue() * num_mp.getValue()));
         this.use_gongji.setValue(this.use_gongji.getValue() * num_gj.getValue());
         this.use_fangyu.setValue(this.use_fangyu.getValue() * num_fy.getValue());
         this.use_sanbi.setValue(this.use_sanbi.getValue() * num_sb.getValue());
         this.use_baoji.setValue(this.use_baoji.getValue() * num_bj.getValue());
         this.walk_power.setValue(this.walk_power.getValue() + num_sd.getValue());
      }
      
      private function ALLTempcompute() : *
      {
         this.temp_hp_Max.setValue(int(this.use_hp_Max.getValue() * num_hp.getValue()));
         this.temp_mp_Max.setValue(int(this.use_mp_Max.getValue() * num_mp.getValue()));
         this.temp_gongji.setValue(this.use_gongji.getValue() * num_gj.getValue());
         this.temp_fangyu.setValue(this.use_fangyu.getValue() * num_fy.getValue());
         this.temp_sanbi.setValue(this.use_sanbi.getValue() * num_sb.getValue());
         this.temp_baoji.setValue(this.use_baoji.getValue() * num_bj.getValue());
      }
      
      private function chenghaoJiaCheng() : *
      {
         if(this.data.getTitleSlot().getTitleAttrib())
         {
            this.use_hp_Max.setValue(this.data.getTitleSlot().getTitleAttrib().getHP() + this.use_hp_Max.getValue());
            this.use_baoji.setValue(this.data.getTitleSlot().getTitleAttrib().getCrit() + this.use_baoji.getValue());
            this.use_gongji.setValue(this.data.getTitleSlot().getTitleAttrib().getAttack() + this.use_gongji.getValue());
            this.use_fangyu.setValue(this.data.getTitleSlot().getTitleAttrib().getDefense() + this.use_fangyu.getValue());
            this.use_mp_Max.setValue(this.data.getTitleSlot().getTitleAttrib().getMP() + this.use_mp_Max.getValue());
            this.walk_power.setValue(this.data.getTitleSlot().getTitleAttrib().getMoveSpeed() + this.walk_power.getValue());
         }
      }
      
      private function jinglingjiacheng() : *
      {
         if(this.data.playerJL_Data)
         {
            this.use_hp_Max.setValue(int(this.data.playerJL_Data.getHP() * 13.3) + this.use_hp_Max.getValue());
            this.use_baoji.setValue(int(this.data.playerJL_Data.getCRIT() * 7.3) + this.use_baoji.getValue());
            this.use_gongji.setValue(int(this.data.playerJL_Data.getATT()) + this.use_gongji.getValue());
            this.use_fangyu.setValue(int(this.data.playerJL_Data.getDEF() * 1.9) + this.use_fangyu.getValue());
            this.use_mp_Max.setValue(int(this.data.playerJL_Data.getMP() * 8.8) + this.use_mp_Max.getValue());
         }
      }
      
      private function stampjiacheng() : *
      {
         num_gj.setValue(this.data.getStampSlot().getValueSlot3() + num_gj.getValue());
         num_fy.setValue(this.data.getStampSlot().getValueSlot4() + num_fy.getValue());
      }
      
      private function cardjiacheng() : *
      {
         if(CardPanel.monsterSlot)
         {
            this.use_hp_Max.setValue(int(CardPanel.monsterSlot.getAllHpup()) + this.use_hp_Max.getValue());
            this.use_baoji.setValue(int(CardPanel.monsterSlot.getAllCritup()) + this.use_baoji.getValue());
            this.use_gongji.setValue(int(CardPanel.monsterSlot.getAllAttup()) + this.use_gongji.getValue());
            this.use_fangyu.setValue(int(CardPanel.monsterSlot.getAllDefup()) + this.use_fangyu.getValue());
            this.use_mp_Max.setValue(int(CardPanel.monsterSlot.getAllMpup()) + this.use_mp_Max.getValue());
         }
      }
      
      private function chongwujiacheng() : *
      {
         if(this.playerCW)
         {
            num_hp.setValue(this.playerCW.data.getLife() + num_hp.getValue());
            num_bj.setValue(this.playerCW.data.getCrit() + num_bj.getValue());
            num_gj.setValue(this.playerCW.data.getAtt() + num_gj.getValue());
            num_fy.setValue(this.playerCW.data.getDef() + num_fy.getValue());
         }
      }
      
      private function QiangHuaJiaCheng() : *
      {
         var sLV:int = this.data.getEquipSlot().getSuitStrength();
         if(sLV < 4)
         {
            return;
         }
         switch(sLV)
         {
            case 4:
               num_hp.setValue(num_hp.getValue() + num_1.getValue());
               break;
            case 5:
               num_hp.setValue(num_hp.getValue() + num_15.getValue());
               num_sb.setValue(num_sb.getValue() + num_1.getValue());
               break;
            case 6:
               num_hp.setValue(num_hp.getValue() + num_15.getValue());
               num_sb.setValue(num_sb.getValue() + num_15.getValue());
               num_sd.setValue(num_sd.getValue() + 1);
               break;
            case 7:
               num_hp.setValue(num_hp.getValue() + num_15.getValue());
               num_sb.setValue(num_sb.getValue() + num_20.getValue());
               num_fy.setValue(num_fy.getValue() + num_7.getValue());
               num_sd.setValue(num_sd.getValue() + 1);
               break;
            case 8:
               num_hp.setValue(num_hp.getValue() + num_20.getValue());
               num_sb.setValue(num_sb.getValue() + num_25.getValue());
               num_fy.setValue(num_fy.getValue() + num_7.getValue());
               num_sd.setValue(num_sd.getValue() + 1);
               break;
            case 9:
               num_hp.setValue(num_hp.getValue() + num_20.getValue());
               num_sb.setValue(num_sb.getValue() + num_30.getValue());
               num_fy.setValue(num_fy.getValue() + num_1.getValue());
               num_sd.setValue(num_sd.getValue() + 1);
               break;
            case 10:
               num_hp.setValue(num_hp.getValue() + num_27.getValue());
               num_sb.setValue(num_sb.getValue() + num_35.getValue());
               num_fy.setValue(num_fy.getValue() + num_15.getValue());
               num_sd.setValue(num_sd.getValue() + 2);
               num_gj.setValue(num_gj.getValue() + num_20.getValue());
         }
      }
      
      private function TaoZhuangXiaoGuo() : *
      {
         var i:int = 0;
         var hpXX:int = 0;
         var lianjiX:int = 0;
         var attack:Number = NaN;
         var lljj:int = 0;
         for(i in this.getAllSuitSkill)
         {
            if(this.getAllSuitSkill[i] == 57200)
            {
               hpXX = this.temp_hp_Max.getValue() * 0.3;
               if(this.hp.getValue() < hpXX)
               {
                  num_gj.setValue(num_gj.getValue() + num_13.getValue());
               }
            }
            if(this.getAllSuitSkill[i] == 57362)
            {
               hpXX = this.temp_hp_Max.getValue() * 0.3;
               if(this.hp.getValue() < hpXX)
               {
                  num_gj.setValue(num_gj.getValue() + num_65.getValue());
               }
            }
            else if(this.getAllSuitSkill[i] == 57201)
            {
               hpXX = this.temp_hp_Max.getValue() * 0.4;
               if(this.hp.getValue() < hpXX)
               {
                  num_fy.setValue(num_fy.getValue() + num_20.getValue());
               }
            }
            else if(this.getAllSuitSkill[i] == 57210)
            {
               lianjiX = this.lianJi.getValue();
               if(lianjiX > 2000)
               {
                  lianjiX = 2000;
               }
               attack = lianjiX / 10 * 0.01;
               if(attack > 5)
               {
                  attack = 5;
               }
               num_gj.setValue(num_gj.getValue() + attack);
            }
            else if(this.getAllSuitSkill[i] == 57360)
            {
               this.lianjiBool = true;
               lianjiX = this.lianJi.getValue();
               if(lianjiX > 500)
               {
                  lianjiX = 500;
               }
               lljj = int(lianjiX / 50);
               attack = lljj * 0.23;
               if(attack > 5)
               {
                  attack = 5;
               }
               num_gj.setValue(num_gj.getValue() + attack);
            }
         }
      }
      
      private function 数值溢出修正() : *
      {
         if(this.hp.getValue() > this.use_hp_Max.getValue())
         {
            this.hp.setValue(this.use_hp_Max.getValue());
         }
         if(this.mp.getValue() > this.use_mp_Max.getValue())
         {
            this.mp.setValue(this.use_mp_Max.getValue());
         }
      }
      
      private function HP_UP(num:int) : *
      {
         if(num <= 0)
         {
            return;
         }
         var hpXX:int = num + this.hp.getValue();
         if(hpXX > this.use_hp_Max.getValue())
         {
            this.hp.setValue(this.use_hp_Max.getValue());
         }
         else
         {
            this.hp.setValue(hpXX);
         }
      }
      
      private function MP_UP(num:int) : *
      {
         if(num <= 0)
         {
            return;
         }
         var mpXX:int = num + this.mp.getValue();
         if(mpXX > this.use_mp_Max.getValue())
         {
            this.mp.setValue(this.use_mp_Max.getValue());
         }
         else
         {
            this.mp.setValue(mpXX);
         }
      }
      
      public function 连击计数() : *
      {
         this.lianJiTime = VT.createVT();
         this.lianJi.setValue(this.lianJi.getValue() + 1);
         WinShow.LianJi(this.lianJi.getValue());
      }
      
      private function 连击计时() : *
      {
         if(this.lianJiTime.getValue() < 60)
         {
            this.lianJiTime.setValue(this.lianJiTime.getValue() + 1);
         }
         else if(this.lianjiBool)
         {
            if(this.lianJiTime.getValue() < 87)
            {
               this.lianJiTime.setValue(this.lianJiTime.getValue() + 1);
            }
            else
            {
               this.lianJi = VT.createVT();
            }
            this.lianjiBool = false;
         }
         else
         {
            this.lianJi = VT.createVT();
         }
      }
      
      public function GetAllSkillCD() : *
      {
         var i:int = 0;
         this.AllSkillCD = this.data.skillCdArr();
         this.AllSkillCDXX = DeepCopyUtil.clone(this.AllSkillCD);
         for(i in this.AllSkillCD)
         {
            this.AllSkillCDXX[i][2] = 1;
            this.AllSkillCDXX[i][1] = 0;
            if(this.data.getSkillLevel(this.AllSkillCDXX[i][0]) > 0)
            {
               this.AllSkillCDXX[i][2] = 50;
               this.AllSkillCDXX[i][1] = this.AllSkillCD[i][1];
            }
         }
      }
      
      public function GetAllObjCD() : *
      {
         var i:int = 0;
         this.All_ObjCD = this.data.ObjCdArr();
         this.All_ObjCDXX = DeepCopyUtil.clone(this.All_ObjCD);
         for(i in this.All_ObjCD)
         {
            this.All_ObjCDXX[i][2] = 50;
         }
      }
      
      public function GetKeyArr(arr:Array) : *
      {
         var i:int = 0;
         if(arr.length == this.data._keyArr.length)
         {
            for(i = 0; i < this.data._keyArr.length; i++)
            {
               if(arr[i] is int)
               {
               }
            }
            this.KeyArr = this.data._keyArr;
         }
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         ++this.time;
         this.连击计时();
         this.药品使用();
         if(this.hp.getValue() <= 0)
         {
            this.skin.visible = false;
            this.不信春哥();
            return;
         }
         this.visible = true;
         this.LoadAll_ZB_Skill();
         if(Main.world)
         {
            this.CDtime();
            this.SkinValue();
            this.KeyControl();
            this.MoveData();
            this.MoveRun();
         }
         if(Boolean(this.skin_Z2) && Boolean(this.skin_Z2_V) && this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
         {
            this.skin_Z2.visible = true;
            this.skin_Z.visible = false;
         }
      }
      
      public function 双手加成() : *
      {
         var arr:Array = null;
         var leftWQ:* = undefined;
         var rightWQ:* = undefined;
         var i:int = 0;
         this.shuangShouBeiShu = 1;
         if(this.data.isTransferOk())
         {
            arr = this.data.getTransferOk();
            leftWQ = this.data.getEquipSlot().getEquipFromSlot(2).getPosition();
            rightWQ = this.data.getEquipSlot().getEquipFromSlot(5).getPosition();
            for(i in arr)
            {
               if(arr[i] == 0)
               {
                  if(leftWQ == rightWQ && rightWQ == 5)
                  {
                     this.shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(arr[i] == 1)
               {
                  if(leftWQ == rightWQ && rightWQ == 6)
                  {
                     this.shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(arr[i] == 2)
               {
                  if(leftWQ == rightWQ && rightWQ == 7)
                  {
                     this.shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
            }
         }
      }
      
      private function 发型变换() : *
      {
         var z2Frame:int = 0;
         var newHeadFrame:int = 0;
         var headEquip:Equip = this.data.getEquipSlot().getEquipFromSlot(0);
         var equipXX:Equip = this.data.getEquipSlot().getEquipFromSlot(1);
         if(Main.water.getValue() != 1)
         {
            headEquip = this.data.getEquipSlot().getEquipFromSlot(8);
         }
         if(Boolean(this.skin_Z2) && Boolean(this.skin_Z2_V) && this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
         {
            z2Frame = int(this.data.getEquipSlot().getEquipFromSlot(6).getClassName2());
            this.headFrame = z2Frame;
            this.noHead = false;
         }
         else if(Boolean(this.data) && Boolean(headEquip))
         {
            newHeadFrame = int(headEquip.getClassName());
            this.headFrame = newHeadFrame;
            this.noHead = false;
            if(newHeadFrame == 24)
            {
               if(Boolean(equipXX) && Boolean(equipXX.getClassName() == "甲红6") && Main.water.getValue() == 1)
               {
                  this.noHead = true;
               }
               else
               {
                  this.noHead = false;
               }
            }
         }
         else
         {
            this.headFrame = 1;
            if(Boolean(equipXX) && Boolean(equipXX.getClassName() == "甲红6") && Main.water.getValue() == 1)
            {
               this.noHead = true;
            }
            else
            {
               this.noHead = false;
            }
         }
      }
      
      private function CDtime() : *
      {
         var i:int = 0;
         for(i in this.AllSkillCDXX)
         {
            if(this.AllSkillCDXX[i][1] < this.AllSkillCD[i][1] && this.data.getSkillLevel(this.AllSkillCDXX[i][0]) > 0)
            {
               ++this.AllSkillCDXX[i][1];
               this.AllSkillCDXX[i][2] = int(this.AllSkillCDXX[i][1] / this.AllSkillCD[i][1] * 50);
            }
         }
         for(i in this.All_ObjCDXX)
         {
            if(this.All_ObjCDXX[i][1] < this.All_ObjCD[i][1])
            {
               ++this.All_ObjCDXX[i][1];
               this.All_ObjCDXX[i][2] = int(this.All_ObjCDXX[i][1] / this.All_ObjCD[i][1] * 50);
            }
         }
      }
      
      private function selCD(str:String) : int
      {
         var i:int = 0;
         for(i in this.AllSkillCDXX)
         {
            if(this.AllSkillCDXX[i][0] == str)
            {
               if(this.AllSkillCDXX[i][1] == this.AllSkillCD[i][1])
               {
                  return i;
               }
               return -1;
            }
         }
         return -1;
      }
      
      private function sel_objCD(str:String) : int
      {
         var i:int = 0;
         for(i in this.All_ObjCD)
         {
            if(this.All_ObjCDXX[i][0] == str)
            {
               if(this.All_ObjCDXX[i][1] == this.All_ObjCD[i][1])
               {
                  return i;
               }
               return -1;
            }
         }
         return -1;
      }
      
      public function selCD50(str:String) : int
      {
         var i:int = 0;
         for(i in this.AllSkillCDXX)
         {
            if(this.AllSkillCDXX[i][0] == str)
            {
               return this.AllSkillCDXX[i][2];
            }
         }
         return 50;
      }
      
      public function sel_objCD50(str:String) : int
      {
         var i:int = 0;
         for(i in this.All_ObjCDXX)
         {
            if(this.All_ObjCDXX[i][0] == str)
            {
               return this.All_ObjCDXX[i][2];
            }
         }
         return 50;
      }
      
      public function wudi(e:*) : *
      {
         ++this.timeTemp;
         if(this.timeTemp > 81)
         {
            removeChild(this.nodead);
            this.rexuewudi = false;
            this.timeTemp = 0;
            this.flagTempRX = true;
            removeEventListener(Event.ENTER_FRAME,this.wudi);
         }
      }
      
      public function timeLimitBJ(e:*) : *
      {
         ++this.timeTemp;
         if(this.timeTemp > 54)
         {
            this.timeTemp = 0;
            this.flagTempBJ = true;
            removeEventListener(Event.ENTER_FRAME,this.timeLimitBJ);
         }
      }
      
      public function timeLimitSJ(e:*) : *
      {
         ++this.timeTemp;
         if(this.timeTemp > 351)
         {
            this.timeTemp = 0;
            this.flagTempSJ = true;
            removeEventListener(Event.ENTER_FRAME,this.timeLimitSJ);
         }
      }
      
      public function timeLimitSY(e:*) : *
      {
         ++this.timeTemp;
         if(this.timeTemp > 284)
         {
            this.timeTemp = 0;
            this.flagTempSY = true;
            removeEventListener(Event.ENTER_FRAME,this.timeLimitSY);
         }
      }
      
      public function timeLimitXL(e:*) : *
      {
         ++this.timeTemp;
         if(this.timeTemp > 284)
         {
            this.timeTemp = 0;
            this.flagTempXL = true;
            removeEventListener(Event.ENTER_FRAME,this.timeLimitXL);
         }
      }
      
      public function timeLimitMP(e:*) : *
      {
         ++this.timeTempmp;
         if(this.timeTempmp > 216)
         {
            this.timeTempmp = 0;
            this.flagTempMP = true;
            removeEventListener(Event.ENTER_FRAME,this.timeLimitMP);
         }
      }
      
      public function setInTimeCDMP() : *
      {
         addEventListener(Event.ENTER_FRAME,this.timeLimitMP);
      }
      
      public function setInTimeCDXL() : *
      {
         addEventListener(Event.ENTER_FRAME,this.timeLimitXL);
      }
      
      public function setInTimeCDBJ() : *
      {
         addEventListener(Event.ENTER_FRAME,this.timeLimitBJ);
      }
      
      public function setInTimeCDSJ() : *
      {
         addEventListener(Event.ENTER_FRAME,this.timeLimitSJ);
      }
      
      public function setInTimeCDSY() : *
      {
         addEventListener(Event.ENTER_FRAME,this.timeLimitSY);
      }
      
      public function HpXX(hitX:*, bj:Boolean = false) : *
      {
         var p:Player2 = null;
         var playHPxx:Number = NaN;
         var 职业附加:Number = NaN;
         var fangYU:int = 0;
         var value:Number = NaN;
         var getAllSuitSkill:Array = null;
         var i:int = 0;
         var rdm:Number = NaN;
         var hxx:HitXX = null;
         if(this.newLifeTime.getValue() > InitData.BuyNum_0.getValue() + InitData.BuyNum_1.getValue())
         {
            return;
         }
         if(this.noHit)
         {
            this.noHit = false;
            return;
         }
         if(this.rexuewudi)
         {
            return;
         }
         if(hitX is HitXX)
         {
            this.hitXX = hitX;
         }
         ++WinShow.txt_3;
         var gongJi_hpX:Number = Number(hitX.gongJi_hp);
         var attTimes:int = int(hitX.times);
         var hpX:int = 0;
         NewMC.Open("被攻击",this);
         if(hitX is HitXX && hitX.who is Player2)
         {
            p = hitX.who as Player2;
            playHPxx = p.use_gongji.getValue();
            职业附加 = 1;
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
            if(this.data.skinArr[this.data.skinNum] == 0 && this.skin.runType == "转职技能1" && this.skin.frame < 20)
            {
               if(this.data.getSkillLevel("a12") > 0)
               {
                  gongJi_hpX *= 0.3;
               }
            }
            fangYU = this.use_fangyu.getValue() + this.fangYuPOWER.getValue();
            playHPxx = p.use_gongji.getValue();
            hpX = gongJi_hpX * 职业附加 * playHPxx - fangYU / attTimes;
            if(hpX < 0)
            {
               hpX = 0;
            }
            else
            {
               {};
            }
            hpX += gongJi_hpX * (Math.random() * 3 + 2) / 100;
            if(bj)
            {
               hpX *= this.tempXXX2.getValue();
            }
         }
         else
         {
            if(this.data.skinArr[this.data.skinNum] == 0 && this.skin.runType == "转职技能1" && this.skin.frame < 20)
            {
               if(this.data.getSkillLevel("a12") > 0)
               {
                  gongJi_hpX *= 0.3;
               }
            }
            fangYU = this.use_fangyu.getValue() + this.fangYuPOWER.getValue();
            hpX = gongJi_hpX - fangYU / attTimes;
            if(hpX < 0)
            {
               hpX = 0;
            }
            else
            {
               {};
            }
            hpX += gongJi_hpX * (Math.random() * 3 + 2) / 100;
            if(bj)
            {
               hpX *= this.tempXXX2.getValue();
            }
         }
         if(hitX.who is Enemy && Main.water.getValue() != 1)
         {
            hpX = hpX * (1 + (hitX.who as Enemy).魔攻力.getValue() / 100) / (1 + this.use_fangyu2.getValue() / 100);
         }
         var hpHP:int = this.hp.getValue() - hpX;
         if(hpHP <= 0)
         {
            value = 0;
            getAllSuitSkill = this.data.getEquipSlot().getAllSuitSkill();
            for(i in getAllSuitSkill)
            {
               if(getAllSuitSkill[i] == 57362)
               {
                  if(Boolean(this.getRandom(50)) && this.flagTempRX)
                  {
                     addChild(this.nodead);
                     this.rexuewudi = true;
                     addEventListener(Event.ENTER_FRAME,this.wudi);
                     this.flagTempRX = false;
                     value = 1;
                  }
               }
            }
            this.hp.setValue(value);
         }
         else
         {
            this.hp.setValue(hpHP);
         }
         var xxx:int = this.x + Math.random() * 50 - 25;
         var yyy:int = this.y + Math.random() * 50 - 25;
         if(hpX == 0)
         {
            NewMC.Open("闪避2",Main.world.moveChild_Other,xxx,yyy,15,0,true,2);
         }
         else if(!bj)
         {
            NewMC.Open("_被打数字",Main.world.moveChild_Other,xxx,yyy,15,hpX,true,2);
         }
         else
         {
            NewMC.Open("_暴击数字",Main.world.moveChild_Other,xxx,yyy,20,hpX,true);
         }
         if(this.data.getEquipSlot().getEquipFromSlot(6))
         {
            if(this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14455 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14461 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14462 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14463 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14464 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14465)
            {
               rdm = Math.random() * 20;
               if(rdm < 1)
               {
                  if(Main.gameNum.getValue() == 999)
                  {
                     this.hp.setValue(this.hp.getValue() + Math.round(this.use_hp_Max.getValue() / 5 / InitData.pkHpMaxNum_Player.getValue()));
                     NewMC.Open("回血效果",this,0,0,0,Math.round(this.use_hp_Max.getValue() / 5 / InitData.pkHpMaxNum_Player.getValue()));
                  }
                  else
                  {
                     this.hp.setValue(this.hp.getValue() + Math.round(this.use_hp_Max.getValue() / 5));
                     NewMC.Open("回血效果",this,0,0,0,Math.round(this.use_hp_Max.getValue() / 5));
                  }
               }
            }
            else if(this.data.getEquipSlot().getEquipFromSlot(6).getId() >= 14622 && this.data.getEquipSlot().getEquipFromSlot(6).getId() <= 14627 || this.data.getEquipSlot().getEquipFromSlot(6).getId() >= 14613 && this.data.getEquipSlot().getEquipFromSlot(6).getId() <= 14618)
            {
               hxx = new HitXX();
               hxx.type = 102;
               hxx.space = 81;
               hxx.totalTime = 81;
               hxx.numValue = 0;
               rdm = Math.random() * 100;
               if(rdm <= 10)
               {
                  new BuffEnemy(hxx,this.hitXX.who);
               }
            }
         }
         var XX:int = hitX.硬直 - this.skin.被攻击硬直;
         if(Boolean(hitX.who) && hitX.who is Player2)
         {
            XX = XX / 5 * 4;
         }
         if(XX > this.skin.continuousTime && XX >= 0)
         {
            this.skin.GoTo("被打",XX);
         }
         this.runArr = new Array();
         if(hitX.RL)
         {
            this.runPower(hitX.runArr[0],hitX.runArr[1],hitX.runArr[2]);
         }
         else
         {
            this.runPower(-hitX.runArr[0],hitX.runArr[1],hitX.runArr[2]);
         }
      }
      
      private function getRandom(num:Number) : Boolean
      {
         var rd:Number = Math.random() * 100;
         if(rd < num)
         {
            return true;
         }
         return false;
      }
      
      private function SkinValue() : *
      {
         if(this.skin != null)
         {
            this.gravity = this.skin.gravity;
            if(this.skin.moveArr != null)
            {
               if(this.RL)
               {
                  this.runPower(this.skin.moveArr[0],this.skin.moveArr[1],this.skin.moveArr[2]);
               }
               else
               {
                  this.runPower(-this.skin.moveArr[0],this.skin.moveArr[1],this.skin.moveArr[2]);
               }
            }
         }
      }
      
      private function onKEY_DOWN(e:KeyboardEvent) : *
      {
         if(e.keyCode == this.data._keyArr[5])
         {
            this.jKey = true;
         }
      }
      
      private function KeyControl() : *
      {
         var flySpeed:int = 0;
         var equipID:uint = 0;
         var mpXX:int = 0;
         if(DuoKai_Info._noSave)
         {
            return;
         }
         if(!this.skin)
         {
            return;
         }
         if(this.skin.continuousTime > 0)
         {
            return;
         }
         if(!this.skin.Get_StopRun())
         {
            if(this.jumping > 0 && this.skin.runType.substr(0,2) == "攻击")
            {
               this.MoveFun();
            }
            return;
         }
         if(this.jumping > 0 && this.getKeyStatus("跳",1) && !PK_UI.PK_ing)
         {
            if(this.mp.getValue() < 1)
            {
               this.mp.setValue(1);
               this.fly = false;
               this.flyTime = 0;
            }
            else
            {
               this.fly = true;
            }
         }
         if(this.getKeyStatus("跳",2) == false)
         {
            this.flyTime = 0;
         }
         if(PK_UI.PK_ing)
         {
            this.fly = false;
            this.flyTime = 0;
         }
         if(Boolean(this.fly && this.mp.getValue() > 1 && this.getKeyStatus("跳",2) && this.skin_Z3_V) && Boolean(this.data.getEquipSlot().getEquipFromSlot(7)) && this.data.getEquipSlot().getEquipFromSlot(7).getColor() >= 4)
         {
            ++this.flyTime;
            if(this.flyTime > 4)
            {
               if(this.flyTime % 24 == 10)
               {
                  mpXX = this.mp.getValue() - this.use_mp_Max.getValue() / 100 * 2;
                  if(mpXX < 1)
                  {
                     this.mp.setValue(1);
                  }
                  else
                  {
                     this.mp.setValue(mpXX);
                  }
               }
               this.gravity = this.gravityNum = 0;
               flySpeed = this.walk_power.getValue() * 1.5;
               equipID = this.data.getEquipSlot().getEquipFromSlot(7).getId();
               if(equipID >= 14604 && equipID <= 14609)
               {
                  flySpeed += 2;
               }
               if(this.getKeyStatus("左",2))
               {
                  this.runPower(-flySpeed,0,1);
                  this.getRL(false);
               }
               if(this.getKeyStatus("右",2))
               {
                  this.runPower(flySpeed,0,1);
                  this.getRL(true);
               }
               if(this.getKeyStatus("上",2))
               {
                  this.runPower(0,8,1);
               }
               if(this.getKeyStatus("下",2))
               {
                  this.runPower(0,-8,1);
               }
               this.SkinPlay("跳");
               return;
            }
         }
         if(this.jKey && (this.jumping == 0 || Boolean(this.jumpX2) && this.jumping < 2))
         {
            this.jKey = false;
            this.runPower(0,this.jump_power,this.jump_time,"跳");
            this.SkinPlay("跳");
            this.jumping += 1;
            if(Boolean(this.jumpX2) && this.jumping == 2)
            {
               NewMC.Open("二段跳效果",Main.world.moveChild_Other,this.x,this.y);
            }
         }
         else if(this.jKey)
         {
            this.jKey = false;
         }
         var typeStr:String = "站";
         if(this.getKeyStatus("左",3))
         {
            typeStr = "跑";
            if(!this.noMove)
            {
               this.runPower(-this.walk_power.getValue() * 1.5,0,1);
            }
            this.getRL(false);
         }
         else if(this.getKeyStatus("右",3))
         {
            typeStr = "跑";
            if(!this.noMove)
            {
               this.runPower(this.walk_power.getValue() * 1.5,0,1);
            }
            this.getRL(true);
         }
         else if(this.getKeyStatus("左",2))
         {
            typeStr = "走";
            if(!this.noMove)
            {
               this.runPower(-this.walk_power.getValue(),0,1);
            }
            this.getRL(false);
         }
         else if(this.getKeyStatus("右",2))
         {
            typeStr = "走";
            if(!this.noMove)
            {
               this.runPower(this.walk_power.getValue(),0,1);
            }
            this.getRL(true);
         }
         if(this.getKeyStatus("攻击",1))
         {
            if(typeStr == "跑" && this.jumping == 0)
            {
               this.SkinPlay("跑攻");
            }
            else if(this.getKeyStatus("上",2))
            {
               this.SkinPlay("上挑");
            }
            else if(this.getKeyStatus("下",2))
            {
               this.SkinPlay("下斩");
            }
            else if(this.jumping > 0)
            {
               this.SkinPlay("攻击1");
            }
            else
            {
               this.skin.timeNum = 15;
               this.SkinPlay("攻击");
            }
         }
         else if(this.getKeyStatus("怪物",1))
         {
            this.SkinPlay("怪物技能");
         }
         else if(this.getKeyStatus("技能1",1))
         {
            this.SkinPlay("技能1");
         }
         else if(this.getKeyStatus("技能2",1))
         {
            this.SkinPlay("技能2");
         }
         else if(this.getKeyStatus("技能3",1))
         {
            this.SkinPlay("技能3");
         }
         else if(this.getKeyStatus("技能4",1))
         {
            this.SkinPlay("技能4");
         }
         else if(this.getKeyStatus("转职",1))
         {
            if(this.getKeyStatus("上",3))
            {
               this.SkinPlay("转职技能4");
            }
            else if(this.getKeyStatus("下",2))
            {
               this.SkinPlay("转职技能3");
            }
            else if(this.getKeyStatus("上",2))
            {
               this.SkinPlay("转职技能2");
            }
            else
            {
               this.SkinPlay("转职技能1");
            }
         }
         else if(this.jumping == 0)
         {
            this.SkinPlay(typeStr);
         }
         else
         {
            this.SkinPlay("跳");
         }
         --this.SwitchingTime;
         if(this.getKeyStatus("切换",1) && this.SwitchingTime <= 0)
         {
            this.SwitchingTime = 6;
            this.QieHuanSkin();
         }
      }
      
      public function QieHuanSkin() : *
      {
         if(this.data.skinNum == 0)
         {
            this.data.skinNum = 1;
            this.newSkin();
         }
         else
         {
            this.data.skinNum = 0;
            this.newSkin();
         }
      }
      
      private function 药品使用() : *
      {
         if(GameOver.noFuHuo)
         {
            return;
         }
         if(this.getKeyStatus("消耗1",1) && !SuppliesShopPanel.ssp.visible)
         {
            this.UserObj(0);
         }
         else if(this.getKeyStatus("消耗2",1) && !SuppliesShopPanel.ssp.visible)
         {
            this.UserObj(1);
         }
         else if(this.getKeyStatus("消耗3",1) && !SuppliesShopPanel.ssp.visible)
         {
            this.UserObj(2);
         }
      }
      
      private function 复活药使用() : *
      {
         this.信春哥();
         this.alpha = 0.7;
         this.newLifeTime.setValue(InitData.BuyNum_1.getValue());
         addEventListener(Event.ENTER_FRAME,this.NewLife);
         All[All.length] = this;
         GameData.deadTime = 5;
         this.newSkin();
      }
      
      private function 刷新背包显示() : *
      {
         BagItemsShow.suppliesShow();
         ShopItemsShow.suppliesShow();
         if(Main.player_2)
         {
            BagItemsShow.suppliesShow2P();
            ShopItemsShow.suppliesShow2P();
         }
      }
      
      private function NewLife(e:*) : *
      {
         this.newLifeTime.setValue(this.newLifeTime.getValue() + InitData.BuyNum_1.getValue());
         if(this.newLifeTime.getValue() % 10 > 4)
         {
            this.alpha = 1;
         }
         else
         {
            this.alpha = 0.7;
         }
         if(this.newLifeTime.getValue() > InitData.BuyNum_80.getValue())
         {
            this.newLifeTime = VT.createVT();
            this.alpha = 1;
            removeEventListener(Event.ENTER_FRAME,this.NewLife);
         }
      }
      
      private function UserObj(num:int) : *
      {
         var XX:Supplies = null;
         var i:int = 0;
         var mode:int = 0;
         var xa:int = 0;
         var va:int = 0;
         var lv:int = 0;
         var xv:int = 0;
         var max:int = 0;
         var tempValue:Number = NaN;
         var tempCd:int = 0;
         if(this.data.getSuppliesSlot().getNumFromSuppliesSlot(this.data.getBag(),num) < 1)
         {
            return;
         }
         if(this.hp.getValue() <= 0)
         {
            XX = this.data.getSuppliesSlot().getFromSuppliesSlot(num);
            mode = XX.getAffectMode();
            if(mode == 2)
            {
               this.复活药使用();
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),num);
            }
            return;
         }
         var name:String = this.data.getSuppliesSlot().getFromSuppliesSlot(num).getName();
         if(!this.CanUserObj(name))
         {
            return;
         }
         XX = this.data.getSuppliesSlot().getFromSuppliesSlot(num);
         var arr:Array = XX.getAffectAttrib();
         for(i in arr)
         {
            xa = int((arr[i] as SuppliesAffect).getAttribType());
            va = int((arr[i] as SuppliesAffect).getValue());
            lv = XX.getUseLevel();
            if(xa == 1 && this.data.getLevel() >= lv)
            {
               tempValue = this.data.getStampSlot().getValueSlot2();
               va *= 1 + tempValue;
               xv = this.hp.getValue() + va;
               max = this.use_hp_Max.getValue();
               if(xv < max)
               {
                  this.hp.setValue(xv);
               }
               else
               {
                  this.hp.setValue(max);
               }
               NewMC.Open("回血效果",this,0,0,0,va);
               tempCd = int(this.sel_objCD(name));
               this.All_ObjCDXX[tempCd][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),num);
            }
            else if(xa == 2 && this.data.getLevel() >= lv)
            {
               tempValue = this.data.getStampSlot().getValueSlot1();
               va *= 1 + tempValue;
               xv = this.mp.getValue() + va;
               max = this.use_mp_Max.getValue();
               if(xv < max)
               {
                  this.mp.setValue(xv);
               }
               else
               {
                  this.mp.setValue(max);
               }
               NewMC.Open("回蓝效果",this,0,0,0,va);
               tempCd = int(this.sel_objCD(name));
               this.All_ObjCDXX[tempCd][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),num);
            }
         }
         this.刷新背包显示();
      }
      
      public function CanSkill(skill_ID:String, lv:int) : Boolean
      {
         var tempMP:int = 0;
         var tempCd:int = 0;
         var getAllSuitSkill:Array = null;
         var i:int = 0;
         var s:Skill = SkillFactory.getSkillByTypeIAndLevel(skill_ID,lv);
         if(s != null)
         {
            tempMP = this.mp.getValue() - s.getMp();
            tempCd = int(this.selCD(skill_ID));
            if(tempMP <= 0)
            {
               return false;
            }
            if(tempCd == -1)
            {
               return false;
            }
            getAllSuitSkill = this.data.getEquipSlot().getAllSuitSkill();
            for(i in getAllSuitSkill)
            {
               if(getAllSuitSkill[i] == 57363)
               {
                  if(this.flagTempMP)
                  {
                     this.flagTempMP = false;
                     this.setInTimeCDMP();
                     this.AllSkillCDXX[tempCd][1] = 0;
                     return true;
                  }
               }
            }
            this.mp.setValue(tempMP);
            this.AllSkillCDXX[tempCd][1] = 0;
            return true;
         }
         return true;
      }
      
      public function CanUserObj(obj_ID:String) : Boolean
      {
         var tempCd:int = int(this.sel_objCD(obj_ID));
         if(tempCd == -1)
         {
            return false;
         }
         return true;
      }
      
      public function runPower(numX:Number = 0, numY:Number = 0, time:int = 0, str:String = "") : *
      {
         var i:* = 0;
         if(str == "跳")
         {
            for(i = int(this.runArr.length - 1); i >= 0; i--)
            {
               if(this.runArr[i][5] == "跳")
               {
                  this.runArr.splice(i,1);
               }
            }
         }
         if(time <= 3)
         {
            this.runArr[this.runArr.length] = [numX,numY,1,0,0,str];
            return;
         }
         var numXX:* = numX * this.parabola / time;
         var numYY:* = numY * this.parabola / time;
         var gravityX:Number = numX * (1 - this.parabola) / (time * time - time * (time - 1) / 2);
         var gravityY:Number = numY * (1 - this.parabola) / (time * time - time * (time - 1) / 2);
         this.runArr[this.runArr.length] = [numXX,numYY,time,gravityX,gravityY,str];
      }
      
      private function MoveData() : *
      {
         this.runX = this.runY = 0;
         for(var i:* = int(this.runArr.length - 1); i >= 0; i--)
         {
            if(this.runArr[i][2] > 0)
            {
               this.runX += this.runArr[i][0] + this.runArr[i][3] * this.runArr[i][2];
               this.runY -= this.runArr[i][1] + this.runArr[i][4] * this.runArr[i][2];
               --this.runArr[i][2];
            }
            else
            {
               this.runArr.splice(i,1);
            }
         }
         if(this.runY < 0)
         {
            this.jumpType = 1;
            this.gravityNum = 0;
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
      
      private function MoveRun() : *
      {
         var xxYN:Boolean = false;
         var playerX2:Boolean = false;
         var otherPlayer:Player = null;
         var AA:Boolean = false;
         var BB2:Boolean = false;
         var AA2:Boolean = false;
         var CC:Boolean = false;
         var AA3:Boolean = false;
         if(this.runX > 0)
         {
            xxYN = true;
         }
         var xx:int = Math.abs(this.runX);
         var yy:int = Math.abs(this.runY);
         var forecast_x:* = int(this.x + Main.world.x);
         var forecast_y:* = int(this.y);
         var mapX:* = int(Main.world.x);
         for(var i:* = yy; i > 0; i--)
         {
            if(this.jumpType == 1)
            {
               AA = Boolean(Main.world.MapData1.hitTestPoint(forecast_x,forecast_y - 100,true));
               if(!AA)
               {
                  forecast_y--;
               }
            }
            else if(this.jumpType == 2)
            {
               BB2 = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 3,true));
               AA2 = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 1,true));
               CC = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y + 6,true));
               if(BB2)
               {
                  forecast_y -= 2;
                  this.jumping = 0;
               }
               else if(AA2)
               {
                  this.runY = 0;
                  this.gravityNum = 0;
                  this.jumping = 0;
               }
               else if(CC)
               {
                  forecast_y += 3;
                  this.jumping = 0;
               }
               else
               {
                  forecast_y++;
               }
            }
            else if(this.jumpType == 3)
            {
               AA3 = Boolean(Main.world.MapData1.hitTestPoint(forecast_x,forecast_y - 5,true));
               if(!AA3)
               {
                  this.jumpType = 2;
                  break;
               }
               forecast_y += 2;
            }
         }
         this.y = forecast_y;
         if(Main.player_2)
         {
            if(Main.player_1.hp.getValue() > 0 && Main.player_2.hp.getValue() > 0)
            {
               playerX2 = true;
            }
            else
            {
               playerX2 = false;
            }
            if(this == Main.player_1)
            {
               otherPlayer = Main.player_2;
            }
            else
            {
               otherPlayer = Main.player_1;
            }
         }
         for(var ii:* = xx; ii > 0; ii--)
         {
            if(xxYN && !Main.world.MapData1.hitTestPoint(forecast_x + 20,forecast_y - 50,true))
            {
               if(!playerX2)
               {
                  if(forecast_x > 700 && mapX > 940 - Main.world.stopX_2)
                  {
                     mapX--;
                  }
                  if(forecast_x - Main.world.x < Main.world.stopX_2)
                  {
                     forecast_x++;
                  }
               }
               else
               {
                  if(forecast_x > 700 && mapX > 940 - Main.world.stopX_2 && otherPlayer.x + mapX > 0)
                  {
                     mapX--;
                  }
                  if(forecast_x - Main.world.x < Main.world.stopX_2 && Math.abs(forecast_x - otherPlayer.x - mapX + 2) < 940)
                  {
                     forecast_x++;
                  }
               }
            }
            else if(!xxYN && !Main.world.MapData1.hitTestPoint(forecast_x - 20,forecast_y - 50,true))
            {
               if(!playerX2)
               {
                  if(forecast_x < 240 && mapX < -Main.world.stopX_1)
                  {
                     mapX++;
                  }
                  if(forecast_x - Main.world.x > Main.world.stopX_1)
                  {
                     forecast_x--;
                  }
               }
               else
               {
                  if(forecast_x < 240 && mapX < -Main.world.stopX_1 && otherPlayer.x + mapX < 940)
                  {
                     mapX++;
                  }
                  if(forecast_x - Main.world.x > Main.world.stopX_1 && Math.abs(forecast_x - otherPlayer.x - mapX - 2) < 940)
                  {
                     forecast_x--;
                  }
               }
            }
         }
         this.x = forecast_x - Main.world.x;
         Main.world.x = mapX;
      }
      
      public function getKeyStatus(str:*, type:int = 1) : Boolean
      {
         var i:int = 0;
         var Arr:Array = null;
         var j:int = 0;
         if(str is String)
         {
            for(i = 0; i < this.data._keyArr.length; i++)
            {
               if(this.KeyArrStr[i] == str)
               {
                  return BasicKey.getKeyState(this.data._keyArr[i],type);
               }
            }
            return false;
         }
         if(str is Array)
         {
            Arr = new Array();
            for(i = 0; i < (str as Array).length; i++)
            {
               for(j = 0; j < this.data._keyArr.length; j++)
               {
                  if(this.KeyArrStr[j] == str[i])
                  {
                     Arr[Arr.length] = this.data._keyArr[j];
                  }
               }
            }
            return BasicKey.getTargetState(Arr);
         }
         return false;
      }
      
      public function newSkin() : *
      {
         this.newZhuangBei3();
         if(this.skin)
         {
            this.skin.gotoAndStop("站");
            this.skin.parent.removeChild(this.skin);
            this.skin = null;
         }
         this.AddSkin();
         this.newZhuangBei();
         this.发型变换();
         this.newWuQi();
         this.OpenCW();
         this.OpenJL();
         this.LoadPlayerLvData();
         this.getRL(this.RL);
         addChild(this.cengHao_mc);
      }
      
      private function newZhuangBei3() : *
      {
         if(this.skin_Z3)
         {
            this.skin_Z3.parent.removeChild(this.skin_Z3);
            this.skin_Z3 = null;
         }
         this.AddSkin_Z3();
      }
      
      public function newZhuangBei() : *
      {
         if(this.skin_Z2)
         {
            this.skin_Z2.parent.removeChild(this.skin_Z2);
            this.skin_Z2 = null;
         }
         if(this.skin_Z)
         {
            this.skin_Z.parent.removeChild(this.skin_Z);
            this.skin_Z = null;
         }
         this.AddSkin_Z();
      }
      
      public function newWuQi() : *
      {
         if(this.skin_W)
         {
            this.skin_W.parent.removeChild(this.skin_W);
            this.skin_W = null;
         }
         this.AddSkin_W();
      }
      
      private function AddSkin() : *
      {
         var skinNumX:int = int(this.data.skinArr[this.data.skinNum]);
         var classRef:Class = PlayerMcArr[this.data.skinArr[this.data.skinNum]].getClass("src.Skin.Skin_player" + skinNumX) as Class;
         this.skin = new classRef();
         this.skin.skinNum = this.data.skinArr[this.data.skinNum];
         this.skin.Xml = Skin.PlayerXml[this.data.skinArr[this.data.skinNum]];
         this.skin.playX = this;
         addChild(this.skin);
         this.skin.mouseChildren = this.skin.mouseEnabled = false;
      }
      
      private function AddSkin_Z3() : *
      {
         if(this.data.getEquipSlot().getEquipFromSlot(7) != null)
         {
            name = this.data.getEquipSlot().getEquipFromSlot(7).getClassName();
            classRef = Skin_ZhuangBei.PlayerMcArr2[this.data.skinArr[this.data.skinNum]].getClass(name) as Class;
            this.skin_Z3 = new classRef();
            addChild(this.skin_Z3);
            if(this.skin_Z3)
            {
               if(this.skin_Z3_V && this.data.getEquipSlot().getEquipFromSlot(7).getRemainingTime() > 0)
               {
                  this.skin_Z3.visible = true;
               }
               else
               {
                  this.skin_Z3.visible = false;
               }
            }
         }
      }
      
      private function AddSkin_Z() : *
      {
         var name:String = null;
         var skinNumX:int = int(this.data.skinArr[this.data.skinNum]);
         var xxx:uint = 1;
         if(Main.water.getValue() != 1)
         {
            xxx = 9;
         }
         if(this.data.getEquipSlot().getEquipFromSlot(xxx) == null)
         {
            name = "甲白1";
         }
         else
         {
            name = this.data.getEquipSlot().getEquipFromSlot(xxx).getClassName();
         }
         var classRef:Class = Skin_ZhuangBei.PlayerMcArr[this.data.skinArr[this.data.skinNum]].getClass(name) as Class;
         this.skin_Z = new classRef();
         addChild(this.skin_Z);
         this.skin_Z.mouseChildren = this.skin_Z.mouseEnabled = false;
         if(this.data.getEquipSlot().getEquipFromSlot(6) != null)
         {
            name = this.data.getEquipSlot().getEquipFromSlot(6).getClassName();
            classRef = Skin_ZhuangBei.PlayerMcArr2[this.data.skinArr[this.data.skinNum]].getClass(name) as Class;
            this.skin_Z2 = new classRef();
            addChild(this.skin_Z2);
            this.skin_Z.visible = false;
         }
         if(Boolean(this.skin_Z2) && Boolean(this.skin_Z2_V) && this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
         {
            this.skin_Z2.visible = true;
            this.skin_Z.visible = false;
            this.skin_Z2.mouseChildren = this.skin_Z2.mouseEnabled = false;
         }
         else if(!this.skin_Z2_V || Boolean(this.skin_Z2) && Boolean(this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() <= 0))
         {
            if(this.skin_Z2)
            {
               this.skin_Z2.visible = false;
            }
            this.skin_Z.visible = true;
         }
      }
      
      private function AddSkin_W() : *
      {
         var name:String = null;
         var skinNumX:int = this.data.skinNum;
         if(skinNumX == 0)
         {
            name = this.data.getEquipSlot().getEquipFromSlot(2).getClassName();
         }
         else if(skinNumX == 1)
         {
            name = this.data.getEquipSlot().getEquipFromSlot(5).getClassName();
         }
         var classRef:Class = Skin_WuQi.PlayerMcArr[this.data.skinArr[this.data.skinNum]].getClass(name) as Class;
         this.skin_W = new classRef();
         addChild(this.skin_W);
         this.skin_W.mouseChildren = this.skin_W.mouseEnabled = false;
      }
      
      private function Add_ChongWu() : *
      {
         if(this.playerCW)
         {
            this.playerCW.Close();
         }
         this.playerCW = new ChongWu();
      }
      
      private function SkinPlay(str:String) : *
      {
         if(this.skin)
         {
            this.skin.GoTo(str);
         }
      }
      
      private function getRL(_RL:Boolean) : *
      {
         this.RL = _RL;
         if(_RL)
         {
            this.skin.scaleX = this.skin_Z.scaleX = this.skin_W.scaleX = -1;
            if(this.skin_Z2)
            {
               this.skin_Z2.scaleX = -1;
            }
            if(this.skin_Z3)
            {
               this.skin_Z3.scaleX = -1;
            }
         }
         else if(!_RL)
         {
            this.skin.scaleX = this.skin_Z.scaleX = this.skin_W.scaleX = 1;
            if(this.skin_Z2)
            {
               this.skin_Z2.scaleX = 1;
            }
            if(this.skin_Z3)
            {
               this.skin_Z3.scaleX = 1;
            }
         }
      }
      
      private function MoveFun() : *
      {
         if(this.getKeyStatus("左",3))
         {
            this.runPower(-this.walk_power.getValue() * 1.5,0,1);
         }
         else if(this.getKeyStatus("右",3))
         {
            this.runPower(this.walk_power.getValue() * 1.5,0,1);
         }
         else if(this.getKeyStatus("左",2))
         {
            this.runPower(-this.walk_power.getValue(),0,1);
         }
         else if(this.getKeyStatus("右",2))
         {
            this.runPower(this.walk_power.getValue(),0,1);
         }
      }
      
      public function OpenCW() : *
      {
         if(Boolean(this.data.playerCW_Data) && this.data.playerCW_Data.getType() != 1)
         {
            this.data.playerCW_Data = null;
            return;
         }
         if(this.data.playerCW_Data)
         {
            this.NewCW(this.data.playerCW_Data);
         }
      }
      
      public function NewCW(data:Pet) : *
      {
         if(this.playerCW)
         {
            this.playerCW.Close();
         }
         this.data.playerCW_Data = data;
         this.playerCW = new ChongWu(data,this);
      }
      
      public function OpenJL() : *
      {
         if(this.data.playerJL_Data)
         {
            this.NewJL(this.data.playerJL_Data);
         }
      }
      
      public function NewJL(data:Elves) : *
      {
         if(this.playerJL)
         {
            this.playerJL.Close();
         }
         this.data.playerJL_Data = data;
         this.playerJL = new JingLing(data,this);
      }
      
      public function HpUp(xxx:Number, type:int = 1) : *
      {
         var hpUpNum:int = 0;
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         var max:int = this.use_hp_Max.getValue();
         if(type == 1)
         {
            hpUpNum = this.hp.getValue() + xxx;
         }
         else if(type == 2)
         {
            xxx = max * xxx / 100;
            hpUpNum = this.hp.getValue() + xxx;
         }
         else
         {
            hpUpNum = xxx = 0;
         }
         if(hpUpNum < max)
         {
            this.hp.setValue(hpUpNum);
         }
         else
         {
            this.hp.setValue(max);
         }
         NewMC.Open("回血效果",this,0,0,0,xxx);
      }
      
      public function MpUp(xxx:Number, type:int = 1) : *
      {
         var hpUpNum:int = 0;
         if(this.hp.getValue() <= 0 || xxx <= 0)
         {
            return;
         }
         var max:int = this.use_mp_Max.getValue();
         if(type == 1)
         {
            mpUpNum = this.mp.getValue() + xxx;
         }
         else if(type == 2)
         {
            xxx = max * xxx / 100;
            mpUpNum = this.mp.getValue() + xxx;
         }
         else
         {
            mpUpNum = xxx = 0;
         }
         if(mpUpNum < max)
         {
            this.mp.setValue(mpUpNum);
         }
         else
         {
            this.mp.setValue(max);
         }
         NewMC.Open("回蓝效果",this,0,0,0,xxx);
      }
   }
}

