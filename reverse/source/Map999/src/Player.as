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
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import src.tool.*;
   
   public class Player extends MovieClip
   {
      
      public static var LV_data:XML;
      
      public static var enemySkillMC:*;
      
      public static var maxLevel:int = 75;
      
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
      
      public static var num_27:VT = VT.createVT();
      
      public static var num_13:VT = VT.createVT();
      
      private static var Temp11:VT = VT.createVT(VT.GetTempVT("10+1/10"));
      
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
      
      public var use_fangyu:VT = VT.createVT();
      
      public var use_baoji:VT = VT.createVT();
      
      public var use_sanbi:VT = VT.createVT();
      
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
      
      internal var jKey:Boolean = false;
      
      public var flyTime:int = 0;
      
      public var fly:Boolean = false;
      
      private var runX:int = 0;
      
      private var runY:int = 0;
      
      private var runArr:Array = new Array();
      
      public function Player()
      {
         super();
         mouseEnabled = mouseChildren = false;
         deadX = new Dead();
         addChild(deadX);
         deadX.visible = false;
         addEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
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
         num_1 = VT.createVT(0.1);
         num_15 = VT.createVT(0.15);
         num_20 = VT.createVT(0.2);
         num_25 = VT.createVT(0.25);
         num_30 = VT.createVT(0.3);
         num_35 = VT.createVT(0.35);
         num_7 = VT.createVT(0.07);
         num_13 = VT.createVT(0.13);
         num_27 = VT.createVT(0.27);
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
         Main._stage.addEventListener(KeyboardEvent.KEY_DOWN,onKEY_DOWN);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      public function 不信春哥() : *
      {
         if(!deadX.visible)
         {
            NewMC.Open("死亡倒计时",this.parent,this.x,this.y);
         }
         deadX.frame = this.headFrame;
         deadX.head_mc.gotoAndStop(deadX.frame);
         deadX.visible = true;
         skin_Z.visible = false;
         skin_W.visible = false;
         if(skin_Z2)
         {
            skin_Z2.visible = false;
         }
         if(skin_Z3)
         {
            skin_Z3.visible = false;
         }
         energySlot.setZero();
      }
      
      public function 信春哥() : *
      {
         deadX.visible = false;
         this.skin.visible = true;
         skin_Z.visible = true;
         skin_W.visible = true;
         this.hp.setValue(999999);
         this.mp.setValue(999999);
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
      {
         this.skin.Over();
      }
      
      public function ExpUP(num:int, type:int = 1) : String
      {
         if(hp.getValue() <= 0)
         {
            return;
         }
         data.setEXP(data.getEXP() + num);
         if(data.getEXP() >= nextExp.getValue())
         {
            return LevelUP(type);
         }
         return "ok";
      }
      
      public function LevelUP(type:int = 1) : *
      {
         var cs:CS50_Info = null;
         if(hp.getValue() <= 0)
         {
            return;
         }
         var levelX:int = data.getLevel();
         if(levelX < 50 || levelX < Player.maxLevel && data.isRebirth())
         {
            if(type == 1)
            {
               data.setEXP(0);
               LevelUP_X();
            }
            else if(type == 2)
            {
               while(data.getEXP() >= nextExp.getValue() && (data.getLevel() < 50 || data.getLevel() < Player.maxLevel && data.isRebirth()))
               {
                  data.setEXP(data.getEXP() - nextExp.getValue());
                  LevelUP_X();
               }
            }
            NewMC.Open("升级效果",this);
            if(data.getLevel() == 50)
            {
               cs = new CS50_Info();
            }
         }
      }
      
      public function LevelUP_X() : *
      {
         data.setLevel(data.getLevel() + VT.GetTempVT("8/8"));
         TiaoShi.tempVar = "data.getLevel() = " + data.getLevel() + " , data.getEXP() = " + data.getEXP();
         if(data.isRebirth())
         {
            data.addPoint(VT.GetTempVT("10/2"));
         }
         else
         {
            data.addPoint(VT.GetTempVT("8/2"));
         }
         LoadPlayerLvData();
         信春哥();
      }
      
      public function MoneyUP(m:int) : *
      {
         if(hp.getValue() <= 0)
         {
            return;
         }
         data.addGold(m);
         NewMC.Open("掉钱",this,0,0,15,m,true);
      }
      
      public function Load_All_Player_Data() : *
      {
         LoadPlayerLvData();
         GetAllSkillCD();
         GetAllObjCD();
         newSkin();
         信春哥();
         left_Reight();
      }
      
      public function left_Reight() : *
      {
         if(this.data.getEquipSkillSlot().getGemFromSkillSlot(0) != null)
         {
            energySlot.energyLeftNum.setValue(0);
            energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(this.data.getEquipSkillSlot().getGemFromSkillSlot(0).getGemSkill()).getEp());
         }
         if(this.data.getEquipSkillSlot().getGemFromSkillSlot(1) != null)
         {
            energySlot.energyRightNum.setValue(0);
            energySlot.energyRightMax.setValue(SkillFactory.getSkillById(this.data.getEquipSkillSlot().getGemFromSkillSlot(1).getGemSkill()).getEp());
         }
      }
      
      public function LoadPlayerLvData() : *
      {
         双手加成();
         var xml:XML = Player.getPlayerLvData(this.data);
         nextExp.setValue(int(xml.经验));
         var hpMaxX:int = int(xml.HP) + data.getEquipSlot().getAllHP();
         hp_Max.setValue(hpMaxX);
         var mpMaxX:int = int(xml.MP) + data.getEquipSlot().getAllMP();
         mp_Max.setValue(mpMaxX);
         var gongJiX:int = (int(xml.攻击) + data.getEquipSlot().getAllAttack()) * shuangShouBeiShu;
         gongji.setValue(gongJiX);
         var fangyuX:int = int(xml.防御) + data.getEquipSlot().getAllDefense();
         fangyu.setValue(fangyuX);
         var baojibaojiX:int = int(xml.暴击) + data.getEquipSlot().getAllCrit();
         baoji.setValue(baojibaojiX);
         var sanbiX:int = int(xml.闪避) + data.getEquipSlot().getAllDuck();
         sanbi.setValue(sanbiX);
         var yingzhiX:int = int(xml.硬值) + data.getEquipSlot().getAllHardValue();
         yingzhi.setValue(yingzhiX);
         walk_power.setValue(6 + data.getEquipSlot().getAllMoveSpeed());
         LoadAll_D_Skill();
      }
      
      private function LoadAll_D_Skill() : *
      {
         var i:int = 0;
         var s:String = null;
         var arr:Array = null;
         var num:Number = NaN;
         var num2:Number = NaN;
         for(i in data.getSkillArr())
         {
            s = (data.getSkillArr()[i][0] as String).substr(0,1);
            if(s == "d")
            {
               if(data.getSkillArr()[i][0] == "d1" && data.getSkillArr()[i][1] > 0)
               {
                  this.jumpX2 = true;
               }
               else if(data.getSkillArr()[i][0] == "d2" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  hp_Max.setValue(hp_Max.getValue() + num);
               }
               else if(data.getSkillArr()[i][0] == "d3" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  mp_Max.setValue(mp_Max.getValue() + num);
               }
               else if(data.getSkillArr()[i][0] == "d4" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  baoji.setValue(baoji.getValue() + num);
               }
               else if(data.getSkillArr()[i][0] == "d5" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num = Number((arr[0] as VT).getValue());
                  sanbi.setValue(sanbi.getValue() + num);
               }
               else if(data.getSkillArr()[i][0] == "d6" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  职业附加[0] = 1 + num2;
               }
               else if(data.getSkillArr()[i][0] == "d7" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  职业附加[1] = 1 + num2;
               }
               else if(data.getSkillArr()[i][0] == "d8" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  职业附加[2] = 1 + num2;
               }
               else if(data.getSkillArr()[i][0] == "d9" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  套装强化[0] = num2;
               }
               else if(data.getSkillArr()[i][0] == "d10" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  套装强化[1] = num2;
               }
               else if(data.getSkillArr()[i][0] == "d11" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  num2 = Number((arr[0] as VT).getValue());
                  套装强化[2] = num2;
               }
               else if(data.getSkillArr()[i][0] == "d12" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  套装强化[3] = num2;
               }
               else if(data.getSkillArr()[i][0] == "d13" && data.getSkillArr()[i][1] > 0)
               {
                  arr = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[i][0],data.getSkillArr()[i][1]).getSkillValueArray();
                  套装强化[4] = num2;
               }
               else if(data.getSkillArr()[i][0] == "d14" && data.getSkillArr()[i][1] > 0)
               {
                  套装强化[5] = true;
               }
               else if(data.getSkillArr()[i][0] == "d15" && data.getSkillArr()[i][1] > 0)
               {
                  套装强化[6] = true;
               }
               else if(data.getSkillArr()[i][0] == "d16" && data.getSkillArr()[i][1] > 0)
               {
                  套装强化[7] = true;
               }
            }
         }
      }
      
      private function getEquipData(now:Boolean = false) : *
      {
         var getAllEquipSkillXX:Array = null;
         var i:int = 0;
         if(getAllMoveSpeed.getValue() == -99 || now)
         {
            getAllMoveSpeed.setValue(data.getEquipSlot().getAllMoveSpeed());
         }
         if(!getAllSuitSkill || now)
         {
            getAllSuitSkill = data.equipSlot.getAllSuitSkill();
         }
         if(!getAllEquipSkill || now)
         {
            getAllEquipSkillXX = data.getEquipSlot().getAllEquipSkill();
            getAllEquipSkill = new Array();
            for(i in getAllEquipSkillXX)
            {
               getAllEquipSkill[i] = SkillFactory.getSkillById(getAllEquipSkillXX[i]);
            }
         }
      }
      
      private function LoadAll_ZB_Skill() : *
      {
         getEquipData();
         use_hp_Max.setValue(hp_Max.getValue());
         use_mp_Max.setValue(mp_Max.getValue());
         use_gongji.setValue(gongji.getValue());
         use_fangyu.setValue(fangyu.getValue());
         use_baoji.setValue(baoji.getValue());
         use_sanbi.setValue(sanbi.getValue());
         walk_power.setValue(6 + getAllMoveSpeed.getValue() + speedTemp.getValue());
         reSet();
         装备技能();
         TaoZhuangXiaoGuo();
         zengFu();
         huiZhangJiaCheng();
         chongwujiacheng();
         QiangHuaJiaCheng();
         ALLcompute();
         chenghaoJiaCheng();
         jinglingjiacheng();
         PK_hpMax();
         ZB_HpMpUP();
         数值溢出修正();
      }
      
      private function PK_hpMax() : *
      {
         if(InitData.pkHpMaxNum_yn.getValue() > 0)
         {
            use_hp_Max.setValue(use_hp_Max.getValue() * InitData.pkHpMaxNum_Player.getValue());
         }
         else
         {
            use_hp_Max.setValue(use_hp_Max.getValue());
         }
      }
      
      private function 装备技能() : *
      {
         var i:int = 0;
         var idX:int = 0;
         var sk_ValueArr:Array = null;
         var num:Number = NaN;
         var hpXX:int = 0;
         for(i in getAllEquipSkill)
         {
            idX = int(getAllEquipSkill[i].getSkillActOn());
            sk_ValueArr = getAllEquipSkill[i].getSkillValueArray();
            if(idX == 31)
            {
               hpXX = hp_Max.getValue() * sk_ValueArr[1].getValue();
               if(hp.getValue() < hpXX)
               {
                  num = Number(sk_ValueArr[0].getValue());
                  num_gj.setValue(num_gj.getValue() + num);
               }
            }
            else if(idX == 32)
            {
               if(lianJi.getValue() > sk_ValueArr[1].getValue())
               {
                  num = Number(sk_ValueArr[0].getValue());
                  num_gj.setValue(num_gj.getValue() + num);
               }
            }
            else if(idX == 35)
            {
               num = use_baoji.getValue() + sk_ValueArr[0].getValue();
               use_baoji.setValue(num);
            }
            else if(idX == 200)
            {
               if(Boolean(data.getEquipSlot().getEquipFromSlot(6)) && data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
               {
                  num_fy.setValue(num_fy.getValue() + sk_ValueArr[0].getValue());
                  num_gj.setValue(num_gj.getValue() + sk_ValueArr[1].getValue());
               }
            }
            else if(idX == 201)
            {
               if(Boolean(data.getEquipSlot().getEquipFromSlot(7)) && data.getEquipSlot().getEquipFromSlot(7).getRemainingTime() > 0)
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
         for(i in getAllEquipSkill)
         {
            idX = int(getAllEquipSkill[i].getSkillActOn());
            sk_ValueArr = getAllEquipSkill[i].getSkillValueArray();
            if(idX == 33)
            {
               if(time % (sk_ValueArr[0].getValue() - 套装强化[0]) == 0)
               {
                  num = sk_ValueArr[1].getValue() * use_mp_Max.getValue();
                  MP_UP(num);
               }
            }
            else if(idX == 34)
            {
               if(time % (sk_ValueArr[0].getValue() - 套装强化[1]) == 0)
               {
                  num = sk_ValueArr[1].getValue() * use_hp_Max.getValue();
                  HP_UP(num);
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
      
      private function zengFu() : *
      {
         var i:int = 0;
         var idX:int = 0;
         var sk_ValueArr:Array = null;
         var arr:Array = data.equipSlot.getAllEquipNewSkill();
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
         use_hp_Max.setValue(int(use_hp_Max.getValue() * num_hp.getValue()));
         use_mp_Max.setValue(int(use_mp_Max.getValue() * num_mp.getValue()));
         use_gongji.setValue(use_gongji.getValue() * num_gj.getValue());
         use_fangyu.setValue(use_fangyu.getValue() * num_fy.getValue());
         use_sanbi.setValue(use_sanbi.getValue() * num_sb.getValue());
         use_baoji.setValue(use_baoji.getValue() * num_bj.getValue());
         walk_power.setValue(walk_power.getValue() + num_sd.getValue());
      }
      
      private function chenghaoJiaCheng() : *
      {
         if(this.data.getTitleSlot().getTitleAttrib())
         {
            use_hp_Max.setValue(this.data.getTitleSlot().getTitleAttrib().getHP() + use_hp_Max.getValue());
            use_baoji.setValue(this.data.getTitleSlot().getTitleAttrib().getCrit() + use_baoji.getValue());
            use_gongji.setValue(this.data.getTitleSlot().getTitleAttrib().getAttack() + use_gongji.getValue());
            use_fangyu.setValue(this.data.getTitleSlot().getTitleAttrib().getDefense() + use_fangyu.getValue());
            use_mp_Max.setValue(this.data.getTitleSlot().getTitleAttrib().getMP() + use_mp_Max.getValue());
            walk_power.setValue(this.data.getTitleSlot().getTitleAttrib().getMoveSpeed() + walk_power.getValue());
         }
      }
      
      private function jinglingjiacheng() : *
      {
         if(this.data.playerJL_Data)
         {
            use_hp_Max.setValue(int(this.data.playerJL_Data.getHP() * 13.3) + use_hp_Max.getValue());
            use_baoji.setValue(int(this.data.playerJL_Data.getCRIT() * 7.3) + use_baoji.getValue());
            use_gongji.setValue(int(this.data.playerJL_Data.getATT()) + use_gongji.getValue());
            use_fangyu.setValue(int(this.data.playerJL_Data.getDEF() * 1.9) + use_fangyu.getValue());
            use_mp_Max.setValue(int(this.data.playerJL_Data.getMP() * 8.8) + use_mp_Max.getValue());
         }
      }
      
      private function chongwujiacheng() : *
      {
         if(playerCW)
         {
            num_hp.setValue(playerCW.data.getLife() + num_hp.getValue());
            num_bj.setValue(playerCW.data.getCrit() + num_bj.getValue());
            num_gj.setValue(playerCW.data.getAtt() + num_gj.getValue());
            num_fy.setValue(playerCW.data.getDef() + num_fy.getValue());
         }
      }
      
      private function QiangHuaJiaCheng() : *
      {
         var sLV:int = data.getEquipSlot().getSuitStrength();
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
         for(i in getAllSuitSkill)
         {
            if(getAllSuitSkill[i] == 57200)
            {
               hpXX = use_hp_Max.getValue() * 0.3;
               if(hp.getValue() < hpXX)
               {
                  num_gj.setValue(num_gj.getValue() + num_13.getValue());
               }
            }
            else if(getAllSuitSkill[i] == 57201)
            {
               hpXX = use_hp_Max.getValue() * 0.4;
               if(hp.getValue() < hpXX)
               {
                  num_fy.setValue(num_fy.getValue() + num_20.getValue());
               }
            }
            else if(getAllSuitSkill[i] == 57210)
            {
               lianjiX = lianJi.getValue();
               if(lianjiX > 2000)
               {
                  lianjiX = 2000;
               }
               attack = lianjiX / 60 * 0.02;
               if(attack > 3)
               {
                  attack = 1;
               }
               num_gj.setValue(num_gj.getValue() + attack);
            }
         }
      }
      
      private function 数值溢出修正() : *
      {
         if(hp.getValue() > use_hp_Max.getValue())
         {
            hp.setValue(use_hp_Max.getValue());
         }
         if(mp.getValue() > use_mp_Max.getValue())
         {
            mp.setValue(use_mp_Max.getValue());
         }
      }
      
      private function HP_UP(num:int) : *
      {
         if(num <= 0)
         {
            return;
         }
         var hpXX:int = num + hp.getValue();
         if(hpXX > use_hp_Max.getValue())
         {
            hp.setValue(use_hp_Max.getValue());
         }
         else
         {
            hp.setValue(hpXX);
         }
      }
      
      private function MP_UP(num:int) : *
      {
         if(num <= 0)
         {
            return;
         }
         var mpXX:int = num + mp.getValue();
         if(mpXX > use_mp_Max.getValue())
         {
            mp.setValue(use_mp_Max.getValue());
         }
         else
         {
            mp.setValue(mpXX);
         }
      }
      
      public function 连击计数() : *
      {
         lianJiTime = VT.createVT();
         lianJi.setValue(lianJi.getValue() + 1);
         WinShow.LianJi(lianJi.getValue());
      }
      
      private function 连击计时() : *
      {
         if(lianJiTime.getValue() < 60)
         {
            lianJiTime.setValue(lianJiTime.getValue() + 1);
         }
         else
         {
            lianJi.setValue(0);
         }
      }
      
      public function GetAllSkillCD() : *
      {
         var i:int = 0;
         AllSkillCD = data.skillCdArr();
         AllSkillCDXX = DeepCopyUtil.clone(AllSkillCD);
         for(i in AllSkillCD)
         {
            AllSkillCDXX[i][2] = 1;
            AllSkillCDXX[i][1] = 0;
            if(data.getSkillLevel(AllSkillCDXX[i][0]) > 0)
            {
               AllSkillCDXX[i][2] = 50;
               AllSkillCDXX[i][1] = AllSkillCD[i][1];
            }
         }
      }
      
      public function GetAllObjCD() : *
      {
         var i:int = 0;
         All_ObjCD = data.ObjCdArr();
         All_ObjCDXX = DeepCopyUtil.clone(All_ObjCD);
         for(i in All_ObjCD)
         {
            All_ObjCDXX[i][2] = 50;
         }
      }
      
      public function GetKeyArr(arr:Array) : *
      {
         var i:int = 0;
         if(arr.length == data._keyArr.length)
         {
            for(i = 0; i < data._keyArr.length; i++)
            {
               if(arr[i] is int)
               {
               }
            }
            this.KeyArr = data._keyArr;
         }
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         ++time;
         连击计时();
         if(this.hp.getValue() <= 0)
         {
            this.skin.visible = false;
            不信春哥();
            return;
         }
         this.visible = true;
         LoadAll_ZB_Skill();
         if(Main.world)
         {
            CDtime();
            SkinValue();
            KeyControl();
            MoveData();
            MoveRun();
         }
      }
      
      public function 双手加成() : *
      {
         var arr:Array = null;
         var leftWQ:* = undefined;
         var rightWQ:* = undefined;
         var i:int = 0;
         shuangShouBeiShu = 1;
         if(data.isTransferOk())
         {
            arr = data.getTransferOk();
            leftWQ = data.getEquipSlot().getEquipFromSlot(2).getPosition();
            rightWQ = data.getEquipSlot().getEquipFromSlot(5).getPosition();
            for(i in arr)
            {
               if(arr[i] == 0)
               {
                  if(leftWQ == rightWQ && rightWQ == 5)
                  {
                     shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(arr[i] == 1)
               {
                  if(leftWQ == rightWQ && rightWQ == 6)
                  {
                     shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(arr[i] == 2)
               {
                  if(leftWQ == rightWQ && rightWQ == 7)
                  {
                     shuangShouBeiShu = Temp11.getValue();
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
         var headEquip:Equip = data.getEquipSlot().getEquipFromSlot(0);
         if(Boolean(skin_Z2) && Boolean(skin_Z2_V) && data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
         {
            z2Frame = int(data.getEquipSlot().getEquipFromSlot(6).getClassName2());
            headFrame = z2Frame;
         }
         else if(Boolean(data) && Boolean(headEquip))
         {
            newHeadFrame = int(headEquip.getClassName());
            if(headFrame != newHeadFrame)
            {
               headFrame = newHeadFrame;
            }
         }
         else
         {
            headFrame = 1;
         }
      }
      
      private function CDtime() : *
      {
         var i:int = 0;
         for(i in AllSkillCDXX)
         {
            if(AllSkillCDXX[i][1] < AllSkillCD[i][1] && data.getSkillLevel(AllSkillCDXX[i][0]) > 0)
            {
               ++AllSkillCDXX[i][1];
               AllSkillCDXX[i][2] = int(AllSkillCDXX[i][1] / AllSkillCD[i][1] * 50);
            }
         }
         for(i in All_ObjCDXX)
         {
            if(All_ObjCDXX[i][1] < All_ObjCD[i][1])
            {
               ++All_ObjCDXX[i][1];
               All_ObjCDXX[i][2] = int(All_ObjCDXX[i][1] / All_ObjCD[i][1] * 50);
            }
         }
      }
      
      private function selCD(str:String) : int
      {
         var i:int = 0;
         for(i in AllSkillCDXX)
         {
            if(AllSkillCDXX[i][0] == str)
            {
               if(AllSkillCDXX[i][1] == AllSkillCD[i][1])
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
         for(i in All_ObjCD)
         {
            if(All_ObjCDXX[i][0] == str)
            {
               if(All_ObjCDXX[i][1] == All_ObjCD[i][1])
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
         for(i in AllSkillCDXX)
         {
            if(AllSkillCDXX[i][0] == str)
            {
               return AllSkillCDXX[i][2];
            }
         }
         return 50;
      }
      
      public function sel_objCD50(str:String) : int
      {
         var i:int = 0;
         for(i in All_ObjCDXX)
         {
            if(All_ObjCDXX[i][0] == str)
            {
               return All_ObjCDXX[i][2];
            }
         }
         return 50;
      }
      
      public function HpXX(hitX:*, bj:Boolean = false) : *
      {
         var p:Player2 = null;
         var playHPxx:Number = NaN;
         var 职业附加:Number = NaN;
         var fangYU:int = 0;
         var rdm:Number = NaN;
         if(noHit)
         {
            noHit = false;
            return;
         }
         if(hitX is HitXX)
         {
            hitXX = hitX;
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
            if(data.skinArr[data.skinNum] == 0 && skin.runType == "转职技能1" && skin.frame < 20)
            {
               if(data.getSkillLevel("a12") > 0)
               {
                  gongJi_hpX *= 0.3;
               }
            }
            fangYU = this.use_fangyu.getValue() + fangYuPOWER.getValue();
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
               hpX *= tempXXX2.getValue();
            }
         }
         else
         {
            if(data.skinArr[data.skinNum] == 0 && skin.runType == "转职技能1" && skin.frame < 20)
            {
               if(data.getSkillLevel("a12") > 0)
               {
                  gongJi_hpX *= 0.3;
               }
            }
            fangYU = this.use_fangyu.getValue() + fangYuPOWER.getValue();
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
               hpX *= tempXXX2.getValue();
            }
         }
         var hpHP:int = hp.getValue() - hpX;
         if(hpHP <= 0)
         {
            hp.setValue(0);
         }
         else
         {
            hp.setValue(hpHP);
         }
         var xxx:int = this.x + Math.random() * 100 - 50;
         var yyy:int = this.y + Math.random() * 100 - 50;
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
         if(data.getEquipSlot().getEquipFromSlot(6))
         {
            if(data.getEquipSlot().getEquipFromSlot(6).getId() == 14455 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14461 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14462 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14463 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14464 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14465)
            {
               rdm = Math.random() * 20;
               if(rdm < 1)
               {
                  if(InitData.pkHpMaxNum_yn.getValue() > 0)
                  {
                     hp.setValue(hp.getValue() + Math.round(use_hp_Max.getValue() / 5 / InitData.pkHpMaxNum_Player.getValue()));
                     NewMC.Open("回血效果",this,0,0,0,Math.round(use_hp_Max.getValue() / 5 / InitData.pkHpMaxNum_Player.getValue()));
                  }
                  else
                  {
                     hp.setValue(hp.getValue() + Math.round(use_hp_Max.getValue() / 5));
                     NewMC.Open("回血效果",this,0,0,0,Math.round(use_hp_Max.getValue() / 5));
                  }
               }
            }
         }
         var XX:int = hitX.硬直 - this.skin.被攻击硬直;
         if(XX > skin.continuousTime && XX >= 0)
         {
            skin.GoTo("被打",XX);
         }
         runArr = new Array();
         if(hitX.RL)
         {
            runPower(hitX.runArr[0],hitX.runArr[1],hitX.runArr[2]);
         }
         else
         {
            runPower(-hitX.runArr[0],hitX.runArr[1],hitX.runArr[2]);
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
      
      private function onKEY_DOWN(e:KeyboardEvent) : *
      {
         if(e.keyCode == data._keyArr[5])
         {
            jKey = true;
         }
      }
      
      private function KeyControl() : *
      {
         药品使用();
         if(!skin)
         {
            return;
         }
         if(skin.continuousTime > 0)
         {
            return;
         }
         if(!this.skin.Get_StopRun())
         {
            if(jumping > 0 && skin.runType.substr(0,2) == "攻击")
            {
               MoveFun();
            }
            return;
         }
         if(jumping > 0 && getKeyStatus("跳",1))
         {
            fly = true;
         }
         if(Boolean(fly && mp.getValue() > 1 && getKeyStatus("跳",2) && skin_Z3_V) && Boolean(data.getEquipSlot().getEquipFromSlot(7)) && data.getEquipSlot().getEquipFromSlot(7).getColor() >= 4)
         {
            ++flyTime;
            if(flyTime % 27 == 26)
            {
               this.mp.setValue(mp.getValue() - use_mp_Max.getValue() / 100 * 2);
            }
            gravity = gravityNum = 0;
            if(getKeyStatus("左",2))
            {
               runPower(-walk_power.getValue() * 1.5,0,1);
               getRL(false);
            }
            if(getKeyStatus("右",2))
            {
               runPower(walk_power.getValue() * 1.5,0,1);
               getRL(true);
            }
            if(getKeyStatus("上",2))
            {
               runPower(0,8,1);
            }
            if(getKeyStatus("下",2))
            {
               runPower(0,-8,1);
            }
            return;
         }
         if(mp.getValue() < 1)
         {
            mp.setValue(1);
            if(skin_Z3_V)
            {
               skin_Z3_V = false;
               newSkin();
            }
         }
         fly = false;
         if(jKey && (jumping == 0 || Boolean(jumpX2) && jumping < 2))
         {
            jKey = false;
            runPower(0,jump_power,jump_time,"跳");
            SkinPlay("跳");
            jumping += 1;
            if(Boolean(jumpX2) && jumping == 2)
            {
               NewMC.Open("二段跳效果",Main.world.moveChild_Other,this.x,this.y);
            }
         }
         else if(jKey)
         {
            jKey = false;
         }
         var typeStr:String = "站";
         if(getKeyStatus("左",3))
         {
            typeStr = "跑";
            if(!noMove)
            {
               runPower(-walk_power.getValue() * 1.5,0,1);
            }
            getRL(false);
         }
         else if(getKeyStatus("右",3))
         {
            typeStr = "跑";
            if(!noMove)
            {
               runPower(walk_power.getValue() * 1.5,0,1);
            }
            getRL(true);
         }
         else if(getKeyStatus("左",2))
         {
            typeStr = "走";
            if(!noMove)
            {
               runPower(-walk_power.getValue(),0,1);
            }
            getRL(false);
         }
         else if(getKeyStatus("右",2))
         {
            typeStr = "走";
            if(!noMove)
            {
               runPower(walk_power.getValue(),0,1);
            }
            getRL(true);
         }
         if(getKeyStatus("攻击",1))
         {
            if(typeStr == "跑" && jumping == 0)
            {
               SkinPlay("跑攻");
            }
            else if(getKeyStatus("上",2))
            {
               SkinPlay("上挑");
            }
            else if(getKeyStatus("下",2))
            {
               SkinPlay("下斩");
            }
            else if(jumping > 0)
            {
               SkinPlay("攻击1");
            }
            else
            {
               skin.timeNum = 15;
               SkinPlay("攻击");
            }
         }
         else if(getKeyStatus("怪物",1))
         {
            SkinPlay("怪物技能");
         }
         else if(getKeyStatus("技能1",1))
         {
            SkinPlay("技能1");
         }
         else if(getKeyStatus("技能2",1))
         {
            SkinPlay("技能2");
         }
         else if(getKeyStatus("技能3",1))
         {
            SkinPlay("技能3");
         }
         else if(getKeyStatus("技能4",1))
         {
            SkinPlay("技能4");
         }
         else if(getKeyStatus("转职",1))
         {
            if(getKeyStatus("上",3))
            {
               SkinPlay("转职技能4");
            }
            else if(getKeyStatus("下",2))
            {
               SkinPlay("转职技能3");
            }
            else if(getKeyStatus("上",2))
            {
               SkinPlay("转职技能2");
            }
            else
            {
               SkinPlay("转职技能1");
            }
         }
         else if(jumping == 0)
         {
            SkinPlay(typeStr);
         }
         else
         {
            SkinPlay("跳");
         }
         --SwitchingTime;
         if(getKeyStatus("切换",1) && SwitchingTime <= 0)
         {
            SwitchingTime = 6;
            QieHuanSkin();
         }
      }
      
      public function QieHuanSkin() : *
      {
         if(data.skinNum == 0)
         {
            data.skinNum = 1;
            newSkin();
         }
         else
         {
            data.skinNum = 0;
            newSkin();
         }
      }
      
      private function 药品使用() : *
      {
         if(getKeyStatus("消耗1",1) && !SuppliesShopPanel.ssp.visible)
         {
            UserObj(0);
         }
         else if(getKeyStatus("消耗2",1) && !SuppliesShopPanel.ssp.visible)
         {
            UserObj(1);
         }
         else if(getKeyStatus("消耗3",1) && !SuppliesShopPanel.ssp.visible)
         {
            UserObj(2);
         }
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
      
      private function UserObj(num:int) : *
      {
         var i:int = 0;
         var xa:int = 0;
         var va:int = 0;
         var lv:int = 0;
         var xv:int = 0;
         var max:int = 0;
         var tempCd:int = 0;
         if(this.hp.getValue() <= 0 || this.data.getSuppliesSlot().getNumFromSuppliesSlot(this.data.getBag(),num) < 1)
         {
            return;
         }
         var name:String = this.data.getSuppliesSlot().getFromSuppliesSlot(num).getName();
         if(!CanUserObj(name))
         {
            return;
         }
         var XX:Supplies = this.data.getSuppliesSlot().getFromSuppliesSlot(num);
         var arr:Array = XX.getAffectAttrib();
         for(i in arr)
         {
            xa = int((arr[i] as SuppliesAffect).getAttribType());
            va = int((arr[i] as SuppliesAffect).getValue());
            lv = XX.getUseLevel();
            if(xa == 1 && this.data.getLevel() >= lv)
            {
               xv = hp.getValue() + va;
               max = use_hp_Max.getValue();
               if(xv < max)
               {
                  hp.setValue(xv);
               }
               else
               {
                  hp.setValue(max);
               }
               NewMC.Open("回血效果",this,0,0,0,va);
               tempCd = int(sel_objCD(name));
               All_ObjCDXX[tempCd][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),num);
            }
            else if(xa == 2 && this.data.getLevel() >= lv)
            {
               xv = mp.getValue() + va;
               max = use_mp_Max.getValue();
               if(xv < max)
               {
                  mp.setValue(xv);
               }
               else
               {
                  mp.setValue(max);
               }
               NewMC.Open("回蓝效果",this,0,0,0,va);
               tempCd = int(sel_objCD(name));
               All_ObjCDXX[tempCd][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),num);
            }
         }
         刷新背包显示();
      }
      
      public function CanSkill(skill_ID:String, lv:int) : Boolean
      {
         var tempMP:int = 0;
         var tempCd:int = 0;
         var s:Skill = SkillFactory.getSkillByTypeIAndLevel(skill_ID,lv);
         if(s != null)
         {
            tempMP = this.mp.getValue() - s.getMp();
            tempCd = int(selCD(skill_ID));
            if(tempMP <= 0)
            {
               return false;
            }
            if(tempCd == -1)
            {
               return false;
            }
            this.mp.setValue(tempMP);
            AllSkillCDXX[tempCd][1] = 0;
            return true;
         }
         return true;
      }
      
      public function CanUserObj(obj_ID:String) : Boolean
      {
         var tempCd:int = int(sel_objCD(obj_ID));
         if(tempCd == -1)
         {
            return false;
         }
         return true;
      }
      
      private function MoveData() : *
      {
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
      
      private function MoveRun() : *
      {
         var xxYN:Boolean = false;
         var playerX2:Boolean = false;
         var otherPlayer:Player = null;
         var AA:Boolean = false;
         var i2:uint = 0;
         var map:* = undefined;
         var BB2:Boolean = false;
         var AA2:Boolean = false;
         var CC:Boolean = false;
         var i3:uint = 0;
         var AA3:Boolean = false;
         var i4:uint = 0;
         var AA4:Boolean = false;
         var i5:uint = 0;
         var AA5:Boolean = false;
         var i6:uint = 0;
         if(runX > 0)
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
                  for(i2 = 0; i2 < Main.world.numChildren; i2++)
                  {
                     map = Main.world.getChildAt(i2);
                     if(map is Map && Boolean(map.MapData1.hitTestPoint(forecast_x,forecast_y - 100,true)))
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
               BB2 = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 3,true));
               AA2 = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y - 1,true));
               CC = Boolean(Main.world.MapData.hitTestPoint(forecast_x,forecast_y + 6,true));
               for(i3 = 0; i3 < Main.world.numChildren; i3++)
               {
                  map = Main.world.getChildAt(i3);
                  if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x,forecast_y - 3,true)))
                  {
                     BB2 = true;
                  }
                  else if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x,forecast_y - 1,true)))
                  {
                     AA2 = true;
                  }
                  else if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x,forecast_y + 6,true)))
                  {
                     CC = true;
                  }
               }
               if(BB2)
               {
                  forecast_y -= 2;
                  jumping = 0;
               }
               else if(AA2)
               {
                  runY = 0;
                  gravityNum = 0;
                  jumping = 0;
               }
               else if(CC)
               {
                  forecast_y += 3;
                  jumping = 0;
               }
               else
               {
                  forecast_y++;
               }
            }
            else if(this.jumpType == 3)
            {
               AA3 = Boolean(Main.world.MapData1.hitTestPoint(forecast_x,forecast_y - 5,true));
               for(i4 = 0; i4 < Main.world.numChildren; i4++)
               {
                  map = Main.world.getChildAt(i4);
                  if(map is Map && Boolean(map.MapData1.hitTestPoint(forecast_x,forecast_y - 5,true)))
                  {
                     AA3 = true;
                  }
               }
               if(!AA3)
               {
                  jumpType = 2;
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
               AA4 = false;
               for(i5 = 0; i5 < Main.world.numChildren; i5++)
               {
                  map = Main.world.getChildAt(i5);
                  if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x + 20,forecast_y - 50,true)))
                  {
                     AA4 = true;
                     break;
                  }
               }
               if(!AA4)
               {
                  if(!playerX2)
                  {
                     if(forecast_x > 700 && mapX > 940 - Main.world._width)
                     {
                        mapX--;
                     }
                     forecast_x++;
                  }
                  else if(forecast_x > 700 && mapX > 940 - Main.world._width && otherPlayer.x + mapX > 10)
                  {
                     forecast_x++;
                     mapX--;
                  }
                  else if(forecast_x < Main.world._width && Math.abs(forecast_x - otherPlayer.x - mapX + 10) < 940)
                  {
                     forecast_x++;
                  }
               }
            }
            else if(!xxYN && !Main.world.MapData1.hitTestPoint(forecast_x - 20,forecast_y - 50,true))
            {
               AA5 = false;
               for(i6 = 0; i6 < Main.world.numChildren; i6++)
               {
                  map = Main.world.getChildAt(i6);
                  if(map is Map && Boolean(map.MapData.hitTestPoint(forecast_x - 20,forecast_y - 50,true)))
                  {
                     AA5 = true;
                     break;
                  }
               }
               if(!AA5)
               {
                  if(!playerX2)
                  {
                     if(forecast_x < 400 && mapX < 0)
                     {
                        mapX++;
                     }
                     forecast_x--;
                  }
                  else if(forecast_x < 400 && mapX < 0 && otherPlayer.x + mapX < 835)
                  {
                     forecast_x--;
                     mapX++;
                  }
                  else if(forecast_x > 0 && Math.abs(forecast_x - otherPlayer.x - mapX - 10) < 940)
                  {
                     forecast_x--;
                  }
               }
            }
         }
         if(forecast_x - Main.world.x > 0 && forecast_x - Main.world.x < Main.world._width)
         {
            this.x = forecast_x - Main.world.x;
         }
         Main.world.x = mapX;
      }
      
      public function runPower(numX:Number = 0, numY:Number = 0, time:int = 0, str:String = "") : *
      {
         var i:* = 0;
         if(str == "跳")
         {
            for(i = int(runArr.length - 1); i >= 0; i--)
            {
               if(runArr[i][5] == "跳")
               {
                  runArr.splice(i,1);
               }
            }
         }
         if(time <= 3)
         {
            runArr[runArr.length] = [numX,numY,1,0,0,str];
            return;
         }
         var numXX:* = numX / time * parabola;
         var numYY:* = numY / time * parabola;
         var gravityX:Number = numX * (1 - parabola) / (time * time - time * (time - 1) / 2);
         var gravityY:Number = numY * (1 - parabola) / (time * time - time * (time - 1) / 2);
         runArr[runArr.length] = [numXX,numYY,time,gravityX,gravityY,str];
      }
      
      public function getKeyStatus(str:*, type:int = 1) : Boolean
      {
         var i:int = 0;
         var Arr:Array = null;
         var j:int = 0;
         if(str is String)
         {
            for(i = 0; i < data._keyArr.length; i++)
            {
               if(KeyArrStr[i] == str)
               {
                  return BasicKey.getKeyState(data._keyArr[i],type);
               }
            }
            return false;
         }
         if(str is Array)
         {
            Arr = new Array();
            for(i = 0; i < (str as Array).length; i++)
            {
               for(j = 0; j < data._keyArr.length; j++)
               {
                  if(KeyArrStr[j] == str[i])
                  {
                     Arr[Arr.length] = data._keyArr[j];
                  }
               }
            }
            return BasicKey.getTargetState(Arr);
         }
         return false;
      }
      
      public function newSkin() : *
      {
         newZhuangBei3();
         if(skin)
         {
            skin.gotoAndStop("站");
            skin.parent.removeChild(skin);
            skin = null;
         }
         AddSkin();
         newZhuangBei();
         发型变换();
         newWuQi();
         OpenCW();
         OpenJL();
         LoadPlayerLvData();
         getRL(RL);
         addChild(cengHao_mc);
      }
      
      private function newZhuangBei3() : *
      {
         if(skin_Z3)
         {
            skin_Z3.parent.removeChild(skin_Z3);
            skin_Z3 = null;
         }
         AddSkin_Z3();
      }
      
      public function newZhuangBei() : *
      {
         if(skin_Z2)
         {
            skin_Z2.parent.removeChild(skin_Z2);
            skin_Z2 = null;
         }
         if(skin_Z)
         {
            skin_Z.parent.removeChild(skin_Z);
            skin_Z = null;
         }
         AddSkin_Z();
      }
      
      public function newWuQi() : *
      {
         if(skin_W)
         {
            skin_W.parent.removeChild(skin_W);
            skin_W = null;
         }
         AddSkin_W();
      }
      
      private function AddSkin() : *
      {
         var skinNumX:int = int(data.skinArr[data.skinNum]);
         var classRef:Class = PlayerMcArr[data.skinArr[data.skinNum]].getClass("src.Skin.Skin_player" + skinNumX) as Class;
         this.skin = new classRef();
         skin.skinNum = data.skinArr[data.skinNum];
         skin.Xml = Skin.PlayerXml[data.skinArr[data.skinNum]];
         skin.playX = this;
         addChild(skin);
         skin.mouseChildren = skin.mouseEnabled = false;
      }
      
      private function AddSkin_Z3() : *
      {
         if(data.getEquipSlot().getEquipFromSlot(7) != null)
         {
            name = data.getEquipSlot().getEquipFromSlot(7).getClassName();
            classRef = Skin_ZhuangBei.PlayerMcArr2[data.skinArr[data.skinNum]].getClass(name) as Class;
            this.skin_Z3 = new classRef();
            addChild(skin_Z3);
            if(skin_Z3)
            {
               if(skin_Z3_V && data.getEquipSlot().getEquipFromSlot(7).getRemainingTime() > 0)
               {
                  skin_Z3.visible = true;
               }
               else
               {
                  skin_Z3.visible = false;
               }
            }
         }
      }
      
      private function AddSkin_Z() : *
      {
         var name:String = null;
         var skinNumX:int = int(data.skinArr[data.skinNum]);
         if(data.getEquipSlot().getEquipFromSlot(1) == null)
         {
            name = "甲白1";
         }
         else
         {
            name = data.getEquipSlot().getEquipFromSlot(1).getClassName();
         }
         var classRef:Class = Skin_ZhuangBei.PlayerMcArr[data.skinArr[data.skinNum]].getClass(name) as Class;
         this.skin_Z = new classRef();
         addChild(skin_Z);
         skin_Z.mouseChildren = skin_Z.mouseEnabled = false;
         if(data.getEquipSlot().getEquipFromSlot(6) != null)
         {
            name = data.getEquipSlot().getEquipFromSlot(6).getClassName();
            classRef = Skin_ZhuangBei.PlayerMcArr2[data.skinArr[data.skinNum]].getClass(name) as Class;
            this.skin_Z2 = new classRef();
            addChild(skin_Z2);
            skin_Z.visible = false;
         }
         if(Boolean(skin_Z2) && Boolean(skin_Z2_V) && data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
         {
            skin_Z2.visible = true;
            skin_Z.visible = false;
            skin_Z2.mouseChildren = skin_Z2.mouseEnabled = false;
         }
         else if(!skin_Z2_V || Boolean(skin_Z2) && Boolean(data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() <= 0))
         {
            if(skin_Z2)
            {
               skin_Z2.visible = false;
            }
            skin_Z.visible = true;
         }
      }
      
      private function AddSkin_W() : *
      {
         var name:String = null;
         var skinNumX:int = data.skinNum;
         if(skinNumX == 0)
         {
            name = data.getEquipSlot().getEquipFromSlot(2).getClassName();
         }
         else if(skinNumX == 1)
         {
            name = data.getEquipSlot().getEquipFromSlot(5).getClassName();
         }
         var classRef:Class = Skin_WuQi.PlayerMcArr[data.skinArr[data.skinNum]].getClass(name) as Class;
         this.skin_W = new classRef();
         addChild(skin_W);
         skin_W.mouseChildren = skin_W.mouseEnabled = false;
      }
      
      private function Add_ChongWu() : *
      {
         if(this.playerCW)
         {
            playerCW.Close();
         }
         this.playerCW = new ChongWu();
      }
      
      private function SkinPlay(str:String) : *
      {
         if(skin)
         {
            this.skin.GoTo(str);
         }
      }
      
      private function getRL(_RL:Boolean) : *
      {
         this.RL = _RL;
         if(_RL)
         {
            skin.scaleX = skin_Z.scaleX = skin_W.scaleX = -1;
            if(skin_Z2)
            {
               skin_Z2.scaleX = -1;
            }
            if(skin_Z3)
            {
               skin_Z3.scaleX = -1;
            }
         }
         else if(!_RL)
         {
            skin.scaleX = skin_Z.scaleX = skin_W.scaleX = 1;
            if(skin_Z2)
            {
               skin_Z2.scaleX = 1;
            }
            if(skin_Z3)
            {
               skin_Z3.scaleX = 1;
            }
         }
      }
      
      private function MoveFun() : *
      {
         if(getKeyStatus("左",3))
         {
            runPower(-walk_power.getValue() * 1.5,0,1);
         }
         else if(getKeyStatus("右",3))
         {
            runPower(walk_power.getValue() * 1.5,0,1);
         }
         else if(getKeyStatus("左",2))
         {
            runPower(-walk_power.getValue(),0,1);
         }
         else if(getKeyStatus("右",2))
         {
            runPower(walk_power.getValue(),0,1);
         }
      }
      
      public function OpenCW() : *
      {
         if(Boolean(data.playerCW_Data) && data.playerCW_Data.getType() != 1)
         {
            data.playerCW_Data = null;
            return;
         }
         if(data.playerCW_Data)
         {
            NewCW(data.playerCW_Data);
         }
      }
      
      public function NewCW(data:Pet) : *
      {
         if(playerCW)
         {
            playerCW.Close();
         }
         this.data.playerCW_Data = data;
         playerCW = new ChongWu(data,this);
      }
      
      public function OpenJL() : *
      {
         if(data.playerJL_Data)
         {
            NewJL(data.playerJL_Data);
         }
      }
      
      public function NewJL(data:Elves) : *
      {
         if(playerJL)
         {
            playerJL.Close();
         }
         this.data.playerJL_Data = data;
         playerJL = new JingLing(data,this);
      }
      
      public function HpUp(xxx:Number, type:int = 1) : *
      {
         var hpUpNum:int = 0;
         if(hp.getValue() <= 0)
         {
            return;
         }
         var max:int = use_hp_Max.getValue();
         if(type == 1)
         {
            hpUpNum = hp.getValue() + xxx;
         }
         else if(type == 2)
         {
            xxx = max * xxx / 100;
            hpUpNum = hp.getValue() + xxx;
         }
         else
         {
            hpUpNum = xxx = 0;
         }
         if(hpUpNum < max)
         {
            hp.setValue(hpUpNum);
         }
         else
         {
            hp.setValue(max);
         }
         NewMC.Open("回血效果",this,0,0,0,xxx);
      }
      
      public function MpUp(xxx:Number, type:int = 1) : *
      {
         var hpUpNum:int = 0;
         if(hp.getValue() <= 0 || xxx <= 0)
         {
            return;
         }
         var max:int = use_mp_Max.getValue();
         if(type == 1)
         {
            mpUpNum = mp.getValue() + xxx;
         }
         else if(type == 2)
         {
            xxx = max * xxx / 100;
            mpUpNum = mp.getValue() + xxx;
         }
         else
         {
            mpUpNum = xxx = 0;
         }
         if(mpUpNum < max)
         {
            mp.setValue(mpUpNum);
         }
         else
         {
            mp.setValue(max);
         }
         NewMC.Open("回蓝效果",this,0,0,0,xxx);
      }
   }
}

