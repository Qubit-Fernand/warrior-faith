package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import src.other.*;
   import src.tool.*;
   
   public class Player2 extends MovieClip
   {
      
      public static var LV_data:XML;
      
      public static var enemySkillMC:*;
      
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
      
      public var idXX:String = "??";
      
      public var pkmc:PKmc = new PKmc();
      
      public var lifeMC:EnemyLife = new EnemyLife();
      
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
      
      public var dead_Visible:Boolean = false;
      
      public var dead_Visible_Time:uint = 0;
      
      private var getAllMoveSpeed:VT = VT.createVT(-99);
      
      private var getAllSuitSkill:Array;
      
      private var getAllEquipSkill:Array;
      
      public var noHead:Boolean = false;
      
      public var distance_X:int;
      
      public var distance_Y:int;
      
      private var RunArr:Array = ["攻击1","上挑","下斩","跑攻","技能1","技能2","技能3","技能4","转职技能1","转职技能2","转职技能3","转职技能4"];
      
      private var runXYArr:Array = [[120,120,150,200,300,200,300,500,200,160,350,120],[400,150,150,400,400,350,400,300,300,400,200,300],[60,80,200,80,200,200,220,350,150,400,200,80]];
      
      public var flyTime:int = 0;
      
      public var fly:Boolean = false;
      
      private var runX:int = 0;
      
      private var runY:int = 0;
      
      private var runArr:Array = new Array();
      
      public function Player2()
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
      
      public static function getPlayerLvData(param1:PlayerData) : XML
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         for(_loc2_ in Player.LV_data.角色)
         {
            _loc3_ = int(Player.LV_data.角色[_loc2_].等级);
            if(_loc3_ == param1.getLevel())
            {
               return Player.LV_data.角色[_loc2_];
            }
         }
         return null;
      }
      
      public static function getEquipDataXX() : *
      {
         Main.player_1.getEquipData(true);
         if(Main.P1P2)
         {
            Main.player_2.getEquipData(true);
         }
      }
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         Main.world.moveChild_Enemy.addChild(this);
         All[All.length] = this;
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
      }
      
      public function 不信春哥() : *
      {
         if(dead_Visible)
         {
            ++dead_Visible_Time;
            if(dead_Visible_Time > 160)
            {
               deadX.visible = false;
               pkmc.visible = false;
               lifeMC.visible = false;
               this.x = this.y = 5000;
               removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
               skin.Over();
               this.parent.removeChild(this);
            }
            return;
         }
         if(!deadX.visible)
         {
            NewMC.Open("死亡倒计时2",this.parent,this.x,this.y,160);
            --PK_UI.PlayerNum_XX;
            PK_UI.killNum.setValue(PK_UI.killNum.getValue() + 1);
            dead_Visible = true;
            Main.player_1.MpUp(40,2);
            if(Main.P1P2)
            {
               Main.player_2.MpUp(40,2);
            }
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
         PK_hpMax();
         this.hp.setValue(9999999);
         this.mp.setValue(9999999);
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         this.skin.Over();
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
      }
      
      public function ExpUP(param1:int, param2:int = 1) : String
      {
         if(hp.getValue() <= 0)
         {
            return;
         }
         data.setEXP(data.getEXP() + param1);
         if(data.getEXP() >= nextExp.getValue())
         {
            return LevelUP(param2);
         }
         return "ok";
      }
      
      public function LevelUP(param1:int = 1) : *
      {
         var _loc3_:CS50_Info = null;
         if(hp.getValue() <= 0)
         {
            return;
         }
         var _loc2_:int = data.getLevel();
         if(_loc2_ < 50 || _loc2_ < Player.maxLevel && data.isRebirth())
         {
            if(param1 == 1)
            {
               data.setEXP(0);
               LevelUP_X();
            }
            else if(param1 == 2)
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
               _loc3_ = new CS50_Info();
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
      
      public function MoneyUP(param1:int) : *
      {
         if(hp.getValue() <= 0)
         {
            return;
         }
         data.addGold(param1);
         NewMC.Open("掉钱",this,0,0,15,param1,true);
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
         var _loc1_:XML = Player.getPlayerLvData(this.data);
         nextExp.setValue(int(_loc1_.经验));
         var _loc2_:int = int(_loc1_.HP) + data.getEquipSlot().getAllHP();
         hp_Max.setValue(_loc2_);
         var _loc3_:int = int(_loc1_.MP) + data.getEquipSlot().getAllMP();
         mp_Max.setValue(_loc3_);
         var _loc4_:int = (int(_loc1_.攻击) + data.getEquipSlot().getAllAttack()) * shuangShouBeiShu;
         gongji.setValue(_loc4_);
         var _loc5_:int = int(_loc1_.防御) + data.getEquipSlot().getAllDefense();
         fangyu.setValue(_loc5_);
         var _loc6_:int = int(_loc1_.暴击) + data.getEquipSlot().getAllCrit();
         baoji.setValue(_loc6_);
         var _loc7_:int = int(_loc1_.闪避) + data.getEquipSlot().getAllDuck();
         sanbi.setValue(_loc7_);
         var _loc8_:int = int(_loc1_.硬值) + data.getEquipSlot().getAllHardValue();
         yingzhi.setValue(_loc8_);
         walk_power.setValue(6 + data.getEquipSlot().getAllMoveSpeed());
         LoadAll_D_Skill();
      }
      
      private function LoadAll_D_Skill() : *
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         for(_loc1_ in data.getSkillArr())
         {
            _loc2_ = (data.getSkillArr()[_loc1_][0] as String).substr(0,1);
            if(_loc2_ == "d")
            {
               if(data.getSkillArr()[_loc1_][0] == "d1" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  this.jumpX2 = true;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d2" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  hp_Max.setValue(hp_Max.getValue() + _loc4_);
               }
               else if(data.getSkillArr()[_loc1_][0] == "d3" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  mp_Max.setValue(mp_Max.getValue() + _loc4_);
               }
               else if(data.getSkillArr()[_loc1_][0] == "d4" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  baoji.setValue(baoji.getValue() + _loc4_);
               }
               else if(data.getSkillArr()[_loc1_][0] == "d5" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  sanbi.setValue(sanbi.getValue() + _loc4_);
               }
               else if(data.getSkillArr()[_loc1_][0] == "d6" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  职业附加[0] = 1 + _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d7" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  职业附加[1] = 1 + _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d8" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  职业附加[2] = 1 + _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d9" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  套装强化[0] = _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d10" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  套装强化[1] = _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d11" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  套装强化[2] = _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d12" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  套装强化[3] = _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d13" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(data.getSkillArr()[_loc1_][0],data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  套装强化[4] = _loc5_;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d14" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  套装强化[5] = true;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d15" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  套装强化[6] = true;
               }
               else if(data.getSkillArr()[_loc1_][0] == "d16" && data.getSkillArr()[_loc1_][1] > 0)
               {
                  套装强化[7] = true;
               }
            }
         }
      }
      
      private function getEquipData(param1:Boolean = false) : *
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(getAllMoveSpeed.getValue() == -99)
         {
            getAllMoveSpeed.setValue(data.getEquipSlot().getAllMoveSpeed());
         }
         if(!getAllSuitSkill)
         {
            getAllSuitSkill = data.equipSlot.getAllSuitSkill();
         }
         if(!getAllEquipSkill)
         {
            _loc2_ = data.getEquipSlot().getAllEquipSkill();
            getAllEquipSkill = new Array();
            for(_loc3_ in _loc2_)
            {
               getAllEquipSkill[_loc3_] = SkillFactory.getSkillById(_loc2_[_loc3_]);
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
         walk_power.setValue(6 + getAllMoveSpeed.getValue());
         reSet();
         装备技能();
         TaoZhuangXiaoGuo();
         zengFu();
         huiZhangJiaCheng();
         chongwujiacheng();
         QiangHuaJiaCheng();
         ALLcompute();
         chenghaoJiaCheng();
         PK_hpMax();
         ZB_HpMpUP();
         数值溢出修正();
      }
      
      private function PK_hpMax() : *
      {
         if(Main.gameNum.getValue() == 999)
         {
            use_hp_Max.setValue(use_hp_Max.getValue() * InitData.pkHpMaxNum_Player.getValue());
            use_mp_Max.setValue(use_mp_Max.getValue() * InitData.pkHpMaxNum_Player.getValue());
         }
         else
         {
            use_hp_Max.setValue(use_hp_Max.getValue());
            use_mp_Max.setValue(use_mp_Max.getValue());
         }
      }
      
      private function 装备技能() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         for(_loc1_ in getAllEquipSkill)
         {
            _loc2_ = int(getAllEquipSkill[_loc1_].getSkillActOn());
            _loc3_ = getAllEquipSkill[_loc1_].getSkillValueArray();
            if(_loc2_ == 31)
            {
               _loc5_ = hp_Max.getValue() * _loc3_[1].getValue();
               if(hp.getValue() < _loc5_)
               {
                  _loc4_ = Number(_loc3_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc4_);
               }
            }
            else if(_loc2_ == 32)
            {
               if(lianJi.getValue() > _loc3_[1].getValue())
               {
                  _loc4_ = Number(_loc3_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc4_);
               }
            }
            else if(_loc2_ == 35)
            {
               _loc4_ = use_baoji.getValue() + _loc3_[0].getValue();
               use_baoji.setValue(_loc4_);
            }
            else if(_loc2_ == 200)
            {
               if(Boolean(data.getEquipSlot().getEquipFromSlot(6)) && data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
               {
                  num_fy.setValue(num_fy.getValue() + _loc3_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc3_[1].getValue());
               }
            }
            else if(_loc2_ == 201)
            {
               if(Boolean(data.getEquipSlot().getEquipFromSlot(7)) && data.getEquipSlot().getEquipFromSlot(7).getRemainingTime() > 0)
               {
                  num_hp.setValue(num_hp.getValue() + _loc3_[0].getValue());
                  num_bj.setValue(num_bj.getValue() + _loc3_[1].getValue());
               }
            }
         }
      }
      
      private function ZB_HpMpUP() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         for(i in getAllEquipSkill)
         {
            _loc1_ = int(getAllEquipSkill[i].getSkillActOn());
            _loc2_ = getAllEquipSkill[i].getSkillValueArray();
            if(_loc1_ == 33)
            {
               if(time % (_loc2_[0].getValue() - 套装强化[0]) == 0)
               {
                  num = _loc2_[1].getValue() * use_mp_Max.getValue();
                  MP_UP(num);
               }
            }
            else if(_loc1_ == 34)
            {
               if(time % (_loc2_[0].getValue() - 套装强化[1]) == 0)
               {
                  num = _loc2_[1].getValue() * use_hp_Max.getValue();
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
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:Array = data.equipSlot.getAllEquipNewSkill();
         for(_loc2_ in _loc1_)
         {
            _loc3_ = int(SkillFactory.getSkillById(_loc1_[_loc2_]).getSkillActOn());
            _loc4_ = SkillFactory.getSkillById(_loc1_[_loc2_]).getSkillValueArray();
            if(_loc3_ == 39)
            {
               num_gj.setValue(num_gj.getValue() + _loc4_[0].getValue());
            }
            else if(_loc3_ == 40)
            {
               num_bj.setValue(num_bj.getValue() + _loc4_[0].getValue());
            }
            else if(_loc3_ == 41)
            {
               num_sb.setValue(num_sb.getValue() + _loc4_[0].getValue());
            }
            else if(_loc3_ == 42)
            {
               num_hp.setValue(num_hp.getValue() + _loc4_[0].getValue());
            }
            else if(_loc3_ == 43)
            {
               num_fy.setValue(num_fy.getValue() + _loc4_[0].getValue());
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
         var _loc1_:int = data.getEquipSlot().getSuitStrength();
         if(_loc1_ < 4)
         {
            return;
         }
         switch(_loc1_)
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         for(_loc1_ in getAllSuitSkill)
         {
            if(getAllSuitSkill[_loc1_] == 57200)
            {
               _loc2_ = hp_Max.getValue() * 0.3;
               if(hp.getValue() < _loc2_)
               {
                  num_gj.setValue(num_gj.getValue() + num_13.getValue());
               }
            }
            else if(getAllSuitSkill[_loc1_] == 57201)
            {
               _loc2_ = hp_Max.getValue() * 0.4;
               if(hp.getValue() < _loc2_)
               {
                  num_fy.setValue(num_fy.getValue() + num_20.getValue());
               }
            }
            else if(getAllSuitSkill[_loc1_] == 57210)
            {
               _loc3_ = lianJi.getValue();
               if(_loc3_ > 2000)
               {
                  _loc3_ = 2000;
               }
               _loc4_ = _loc3_ / 60 * 0.02;
               if(_loc4_ > 3)
               {
                  _loc4_ = 1;
               }
               num_gj.setValue(num_gj.getValue() + _loc4_);
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
      
      private function HP_UP(param1:int) : *
      {
         var _loc2_:int = param1 + hp.getValue();
         if(_loc2_ > use_hp_Max.getValue())
         {
            hp.setValue(use_hp_Max.getValue());
         }
         else
         {
            hp.setValue(_loc2_);
         }
      }
      
      private function MP_UP(param1:int) : *
      {
         var _loc2_:int = param1 + mp.getValue();
         if(_loc2_ > use_mp_Max.getValue())
         {
            mp.setValue(use_mp_Max.getValue());
         }
         else
         {
            mp.setValue(_loc2_);
         }
      }
      
      public function 连击计数() : *
      {
         lianJiTime = VT.createVT();
         lianJi.setValue(lianJi.getValue() + 1);
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
         var _loc1_:int = 0;
         AllSkillCD = data.skillCdArr();
         AllSkillCDXX = DeepCopyUtil.clone(AllSkillCD);
         for(_loc1_ in AllSkillCD)
         {
            AllSkillCDXX[_loc1_][2] = 1;
            AllSkillCDXX[_loc1_][1] = 0;
            if(data.getSkillLevel(AllSkillCDXX[_loc1_][0]) > 0)
            {
               AllSkillCDXX[_loc1_][2] = 50;
               AllSkillCDXX[_loc1_][1] = AllSkillCD[_loc1_][1];
            }
         }
      }
      
      public function GetAllObjCD() : *
      {
         var _loc1_:int = 0;
         All_ObjCD = data.ObjCdArr();
         All_ObjCDXX = DeepCopyUtil.clone(All_ObjCD);
         for(_loc1_ in All_ObjCD)
         {
            All_ObjCDXX[_loc1_][2] = 50;
         }
      }
      
      public function GetKeyArr(param1:Array) : *
      {
         var _loc2_:int = 0;
         if(param1.length == data._keyArr.length)
         {
            _loc2_ = 0;
            while(_loc2_ < data._keyArr.length)
            {
               if(param1[_loc2_] is int)
               {
               }
               _loc2_++;
            }
            this.KeyArr = data._keyArr;
         }
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         ++time;
         if(this.hp.getValue() <= 0 || !PK_UI.PK_ing)
         {
            this.hp.setValue(0);
            this.skin.visible = false;
            不信春哥();
            if(!PK_UI.PK_ing)
            {
               deadX.visible = false;
            }
            return;
         }
         this.visible = true;
         连击计时();
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
         var _loc1_:Array = null;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         shuangShouBeiShu = 1;
         if(data.isTransferOk())
         {
            _loc1_ = data.getTransferOk();
            _loc2_ = data.getEquipSlot().getEquipFromSlot(2).getPosition();
            _loc3_ = data.getEquipSlot().getEquipFromSlot(5).getPosition();
            for(_loc4_ in _loc1_)
            {
               if(_loc1_[_loc4_] == 0)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 5)
                  {
                     shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(_loc1_[_loc4_] == 1)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 6)
                  {
                     shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(_loc1_[_loc4_] == 2)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 7)
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
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Equip = null;
         var _loc1_:Equip = data.getEquipSlot().getEquipFromSlot(0);
         if(Boolean(skin_Z2) && Boolean(skin_Z2_V) && data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
         {
            _loc2_ = int(data.getEquipSlot().getEquipFromSlot(6).getClassName2());
            headFrame = _loc2_;
         }
         else if(Boolean(data) && Boolean(_loc1_))
         {
            _loc3_ = int(_loc1_.getClassName());
            if(headFrame != _loc3_)
            {
               headFrame = _loc3_;
            }
            if(_loc3_ == 24)
            {
               _loc4_ = data.getEquipSlot().getEquipFromSlot(1);
               if((Boolean(_loc4_)) && (_loc4_.getClassName() == "甲红6" || _loc4_.getClassName() == "甲红10"))
               {
                  noHead = true;
               }
               else
               {
                  noHead = false;
                  headFrame = 24;
               }
            }
         }
         else
         {
            headFrame = 1;
         }
      }
      
      private function CDtime() : *
      {
         var _loc1_:int = 0;
         for(_loc1_ in AllSkillCDXX)
         {
            if(AllSkillCDXX[_loc1_][1] < AllSkillCD[_loc1_][1] && data.getSkillLevel(AllSkillCDXX[_loc1_][0]) > 0)
            {
               ++AllSkillCDXX[_loc1_][1];
               AllSkillCDXX[_loc1_][2] = int(AllSkillCDXX[_loc1_][1] / AllSkillCD[_loc1_][1] * 50);
            }
         }
         for(_loc1_ in All_ObjCDXX)
         {
            if(All_ObjCDXX[_loc1_][1] < All_ObjCD[_loc1_][1])
            {
               ++All_ObjCDXX[_loc1_][1];
               All_ObjCDXX[_loc1_][2] = int(All_ObjCDXX[_loc1_][1] / All_ObjCD[_loc1_][1] * 50);
            }
         }
      }
      
      private function selCD(param1:String) : int
      {
         var _loc2_:int = 0;
         for(_loc2_ in AllSkillCDXX)
         {
            if(AllSkillCDXX[_loc2_][0] == param1)
            {
               if(AllSkillCDXX[_loc2_][1] == AllSkillCD[_loc2_][1])
               {
                  return _loc2_;
               }
               return -1;
            }
         }
         return -1;
      }
      
      private function sel_objCD(param1:String) : int
      {
         var _loc2_:int = 0;
         for(_loc2_ in All_ObjCD)
         {
            if(All_ObjCDXX[_loc2_][0] == param1)
            {
               if(All_ObjCDXX[_loc2_][1] == All_ObjCD[_loc2_][1])
               {
                  return _loc2_;
               }
               return -1;
            }
         }
         return -1;
      }
      
      public function HpXX(param1:*, param2:Boolean = false) : *
      {
         var _loc6_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         if(noHit)
         {
            noHit = false;
            return;
         }
         if(param1 is HitXX)
         {
            hitXX = param1;
         }
         var _loc3_:Number = Number(param1.gongJi_hp);
         var _loc4_:int = int(param1.times);
         var _loc5_:Player = param1.who as Player;
         _loc6_ = _loc5_.use_gongji.getValue();
         var _loc7_:Number = 1;
         var _loc8_:int = 0;
         NewMC.Open("被攻击",this);
         if(param1.who is Player)
         {
            if(_loc5_.data.skinArr[_loc5_.data.skinNum] == 0)
            {
               _loc7_ = Number(_loc5_.职业附加[0]);
            }
            else if(_loc5_.data.skinArr[_loc5_.data.skinNum] == 1)
            {
               _loc7_ = Number(_loc5_.职业附加[1]);
            }
            else if(_loc5_.data.skinArr[_loc5_.data.skinNum] == 2)
            {
               _loc7_ = Number(_loc5_.职业附加[2]);
            }
            if(data.skinArr[data.skinNum] == 0 && skin.runType == "转职技能1" && skin.frame < 20)
            {
               if(data.getSkillLevel("a12") > 0)
               {
                  _loc3_ *= 0.3;
               }
            }
            _loc14_ = this.use_fangyu.getValue() + fangYuPOWER.getValue();
            _loc6_ = _loc5_.use_gongji.getValue() + Enemy.gongJiPOWER.getValue();
            _loc8_ = _loc3_ * _loc7_ * _loc6_ - _loc14_ / _loc4_;
            if(_loc8_ < 0)
            {
               _loc8_ = 0;
            }
            else
            {
               {};
            }
            _loc8_ += _loc3_ * (Math.random() * 3 + 2) / 100;
            if(param2)
            {
               _loc8_ *= tempXXX2.getValue();
            }
         }
         var _loc9_:int = hp.getValue() - _loc8_;
         if(_loc9_ <= 0)
         {
            hp.setValue(0);
         }
         else
         {
            hp.setValue(_loc9_);
         }
         var _loc10_:int = 100 - hp.getValue() / use_hp_Max.getValue() * 100;
         lifeMC.gotoAndStop(_loc10_);
         var _loc11_:int = this.x + Math.random() * 100 - 50;
         var _loc12_:int = this.y + Math.random() * 100 - 50;
         if(_loc8_ == 0)
         {
            NewMC.Open("闪避2",Main.world.moveChild_Other,_loc11_,_loc12_,15,0,true,2);
         }
         else if(!param2)
         {
            NewMC.Open("_被打数字",Main.world.moveChild_Other,_loc11_,_loc12_,15,_loc8_,true,2);
         }
         else
         {
            NewMC.Open("_暴击数字",Main.world.moveChild_Other,_loc11_,_loc12_,20,_loc8_,true);
         }
         if(data.getEquipSlot().getEquipFromSlot(6))
         {
            if(data.getEquipSlot().getEquipFromSlot(6).getId() == 14455 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14461 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14462 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14463 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14464 || data.getEquipSlot().getEquipFromSlot(6).getId() == 14465)
            {
               _loc15_ = Math.random() * 20;
               if(_loc15_ < 1)
               {
                  if(Main.gameNum.getValue() == 999)
                  {
                     hp.setValue(hp.getValue() + Math.round(use_hp_Max.getValue() / 5 / InitData.pkHpMaxNum_Player2.getValue()));
                     NewMC.Open("回血效果",this,0,0,0,Math.round(use_hp_Max.getValue() / 5 / InitData.pkHpMaxNum_Player2.getValue()));
                  }
                  else
                  {
                     hp.setValue(hp.getValue() + Math.round(use_hp_Max.getValue() / 5));
                     NewMC.Open("回血效果",this,0,0,0,Math.round(use_hp_Max.getValue() / 5));
                  }
               }
            }
         }
         var _loc13_:int = (param1.硬直 - this.skin.被攻击硬直) / 2;
         if(_loc13_ > skin.continuousTime && _loc13_ >= 0)
         {
            skin.GoTo("被打",_loc13_);
         }
         runArr = new Array();
         if(param1.RL)
         {
            runPower(param1.runArr[0],param1.runArr[1],param1.runArr[2]);
         }
         else
         {
            runPower(-param1.runArr[0],param1.runArr[1],param1.runArr[2]);
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
      
      private function KeyControl() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!skin)
         {
            return;
         }
         if(skin.continuousTime > 0)
         {
            return;
         }
         WhereAreYou();
         if(skin.stopRun)
         {
            _loc1_ = int(data.skinArr[data.skinNum]);
            _loc2_ = 0;
            if(_loc1_ == 0)
            {
               _loc2_ = 150;
            }
            else if(_loc1_ == 1)
            {
               _loc2_ = 300;
            }
            else if(_loc1_ == 2)
            {
               _loc2_ = 150;
            }
            if(distance_X < -_loc2_)
            {
               if(!noMove)
               {
                  runPower(this.walk_power.getValue() * 1.5,0,1);
                  getRL(true);
                  SkinPlay("跑");
               }
            }
            else if(distance_X > _loc2_)
            {
               if(!noMove)
               {
                  runPower(-this.walk_power.getValue() * 1.5,0,1);
                  getRL(false);
                  SkinPlay("跑");
               }
            }
            else
            {
               _loc3_ = 2;
               _loc4_ = Math.random() * (RunArr.length + _loc3_);
               if(_loc4_ > RunArr.length && (jumping == 0 || Boolean(jumpX2) && jumping < 2))
               {
                  SkinPlay("跳");
                  runPower(0,145,8,"跳");
                  return;
               }
               if(distance_X > 10)
               {
                  getRL(false);
               }
               else if(distance_X < -10)
               {
                  getRL(true);
               }
               _loc5_ = Math.abs(distance_X);
               if(_loc5_ < runXYArr[_loc1_][_loc4_])
               {
                  SkinPlay(RunArr[_loc4_]);
               }
            }
         }
      }
      
      public function CanSkill(param1:String, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Skill = SkillFactory.getSkillByTypeIAndLevel(param1,param2);
         if(_loc3_ != null)
         {
            _loc4_ = this.mp.getValue() - _loc3_.getMp();
            _loc5_ = int(selCD(param1));
            if(_loc4_ <= 0)
            {
               return false;
            }
            if(_loc5_ == -1)
            {
               return false;
            }
            this.mp.setValue(_loc4_);
            AllSkillCDXX[_loc5_][1] = 0;
            return true;
         }
         return true;
      }
      
      private function MoveData() : *
      {
         runX = runY = 0;
         var _loc1_:* = int(runArr.length - 1);
         while(_loc1_ >= 0)
         {
            if(runArr[_loc1_][2] > 0)
            {
               runX += runArr[_loc1_][0] + runArr[_loc1_][3] * runArr[_loc1_][2];
               runY -= runArr[_loc1_][1] + runArr[_loc1_][4] * runArr[_loc1_][2];
               --runArr[_loc1_][2];
            }
            else
            {
               runArr.splice(_loc1_,1);
            }
            _loc1_--;
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
         var _loc1_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:uint = 0;
         var _loc11_:* = undefined;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:uint = 0;
         var _loc16_:Boolean = false;
         var _loc17_:uint = 0;
         var _loc18_:Boolean = false;
         var _loc19_:uint = 0;
         var _loc20_:Boolean = false;
         var _loc21_:uint = 0;
         if(runX > 0)
         {
            _loc1_ = true;
         }
         var _loc2_:int = Math.abs(this.runX);
         var _loc3_:int = Math.abs(this.runY);
         var _loc4_:* = int(this.x + Main.world.x);
         var _loc5_:* = int(this.y);
         var _loc6_:int = int(Main.world.x);
         var _loc7_:* = _loc3_;
         while(_loc7_ > 0)
         {
            if(this.jumpType == 1)
            {
               _loc9_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - 100,true));
               if(!_loc9_)
               {
                  _loc10_ = 0;
                  while(_loc10_ < Main.world.numChildren)
                  {
                     _loc11_ = Main.world.getChildAt(_loc10_);
                     if(_loc11_ is Map && Boolean(_loc11_.MapData1.hitTestPoint(_loc4_,_loc5_ - 100,true)))
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
               _loc13_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true));
               _loc14_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true));
               _loc15_ = 0;
               while(_loc15_ < Main.world.numChildren)
               {
                  _loc11_ = Main.world.getChildAt(_loc15_);
                  if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_,_loc5_ - 3,true)))
                  {
                     _loc12_ = true;
                  }
                  else if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true)))
                  {
                     _loc13_ = true;
                  }
                  else if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true)))
                  {
                     _loc14_ = true;
                  }
                  _loc15_++;
               }
               if(_loc12_)
               {
                  _loc5_ -= 2;
                  jumping = 0;
               }
               else if(_loc13_)
               {
                  runY = 0;
                  gravityNum = 0;
                  jumping = 0;
               }
               else if(_loc14_)
               {
                  _loc5_ += 3;
                  jumping = 0;
               }
               else
               {
                  _loc5_++;
               }
            }
            else if(this.jumpType == 3)
            {
               _loc16_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - 5,true));
               _loc17_ = 0;
               while(_loc17_ < Main.world.numChildren)
               {
                  _loc11_ = Main.world.getChildAt(_loc17_);
                  if(_loc11_ is Map && Boolean(_loc11_.MapData1.hitTestPoint(_loc4_,_loc5_ - 5,true)))
                  {
                     _loc16_ = true;
                  }
                  _loc17_++;
               }
               if(!_loc16_)
               {
                  jumpType = 2;
                  break;
               }
               _loc5_ += 2;
            }
            _loc7_--;
         }
         this.y = _loc5_;
         var _loc8_:* = _loc2_;
         while(_loc8_ > 0)
         {
            if(_loc1_ && !Main.world.MapData1.hitTestPoint(_loc4_ + 20,_loc5_ - 50,true))
            {
               _loc18_ = false;
               _loc19_ = 0;
               while(_loc19_ < Main.world.numChildren)
               {
                  _loc11_ = Main.world.getChildAt(_loc19_);
                  if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_ + 20,_loc5_ - 50,true)))
                  {
                     _loc18_ = true;
                     break;
                  }
                  _loc19_++;
               }
               if(!_loc18_)
               {
                  _loc4_++;
               }
            }
            else if(!_loc1_ && !Main.world.MapData1.hitTestPoint(_loc4_ - 20,_loc5_ - 50,true))
            {
               _loc20_ = false;
               _loc21_ = 0;
               while(_loc21_ < Main.world.numChildren)
               {
                  _loc11_ = Main.world.getChildAt(_loc21_);
                  if(_loc11_ is Map && Boolean(_loc11_.MapData.hitTestPoint(_loc4_ - 20,_loc5_ - 50,true)))
                  {
                     _loc20_ = true;
                     break;
                  }
                  _loc21_++;
               }
               if(!_loc20_)
               {
                  _loc4_--;
               }
            }
            _loc8_--;
         }
         this.x = _loc4_ - Main.world.x;
      }
      
      public function runPower(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:String = "") : *
      {
         var _loc9_:* = 0;
         if(param4 == "跳")
         {
            _loc9_ = int(runArr.length - 1);
            while(_loc9_ >= 0)
            {
               if(runArr[_loc9_][5] == "跳")
               {
                  runArr.splice(_loc9_,1);
                  jumping += 1;
               }
               _loc9_--;
            }
         }
         if(param3 <= 3)
         {
            runArr[runArr.length] = [param1,param2,1,0,0,param4];
            return;
         }
         var _loc5_:* = param1 / param3 * parabola;
         var _loc6_:* = param2 / param3 * parabola;
         var _loc7_:Number = param1 * (1 - parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         var _loc8_:Number = param2 * (1 - parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         runArr[runArr.length] = [_loc5_,_loc6_,param3,_loc7_,_loc8_,param4];
      }
      
      public function getKeyStatus(param1:*, param2:int = 1) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 is String)
         {
            _loc3_ = 0;
            while(_loc3_ < data._keyArr.length)
            {
               if(KeyArrStr[_loc3_] == param1)
               {
                  return BasicKey.getKeyState(data._keyArr[_loc3_],param2);
               }
               _loc3_++;
            }
            return false;
         }
         if(param1 is Array)
         {
            _loc4_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < (param1 as Array).length)
            {
               _loc5_ = 0;
               while(_loc5_ < data._keyArr.length)
               {
                  if(KeyArrStr[_loc5_] == param1[_loc3_])
                  {
                     _loc4_[_loc4_.length] = data._keyArr[_loc5_];
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
            return BasicKey.getTargetState(_loc4_);
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
         LoadPlayerLvData();
         getRL(RL);
         addChild(cengHao_mc);
         addChild(pkmc);
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
         var _loc1_:int = int(data.skinArr[data.skinNum]);
         var _loc2_:Class = Player.PlayerMcArr[data.skinArr[data.skinNum]].getClass("src.Skin.Skin_player" + _loc1_) as Class;
         this.skin = new _loc2_();
         skin.skinNum = data.skinArr[data.skinNum];
         skin.Xml = Skin.PlayerXml[data.skinArr[data.skinNum]];
         skin.playX = this;
         addChild(skin);
         skin.mouseChildren = skin.mouseEnabled = false;
         addChild(lifeMC);
         lifeMC.stop();
         lifeMC.y = -this.skin.height;
      }
      
      private function AddSkin_Z3() : *
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:Class = null;
         if(data.getEquipSlot().getEquipFromSlot(7) != null)
         {
            _loc1_ = int(data.skinArr[data.skinNum]);
            _loc2_ = data.getEquipSlot().getEquipFromSlot(7).getClassName();
            _loc3_ = data.getEquipSlot().getEquipFromSlot(7).getClassName3();
            _loc4_ = NewLoad.zhuangBeiSkin[_loc1_][_loc3_].getClass(_loc2_) as Class;
            this.skin_Z3 = new _loc4_();
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
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc1_:int = int(data.skinArr[data.skinNum]);
         if(data.getEquipSlot().getEquipFromSlot(1) == null)
         {
            _loc2_ = "甲白1";
            _loc3_ = 1;
         }
         else
         {
            _loc2_ = data.getEquipSlot().getEquipFromSlot(1).getClassName();
            _loc3_ = data.getEquipSlot().getEquipFromSlot(1).getClassName3();
         }
         var _loc4_:Class = NewLoad.zhuangBeiSkin[_loc1_][_loc3_].getClass(_loc2_) as Class;
         this.skin_Z = new _loc4_();
         addChild(skin_Z);
         skin_Z.mouseChildren = skin_Z.mouseEnabled = false;
         if(data.getEquipSlot().getEquipFromSlot(6) != null)
         {
            _loc2_ = data.getEquipSlot().getEquipFromSlot(6).getClassName();
            _loc3_ = data.getEquipSlot().getEquipFromSlot(6).getClassName3();
            _loc4_ = NewLoad.zhuangBeiSkin[_loc1_][_loc3_].getClass(_loc2_) as Class;
            this.skin_Z2 = new _loc4_();
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
         var _loc2_:String = null;
         var _loc1_:int = data.skinNum;
         if(_loc1_ == 0)
         {
            _loc2_ = data.getEquipSlot().getEquipFromSlot(2).getClassName();
         }
         else if(_loc1_ == 1)
         {
            _loc2_ = data.getEquipSlot().getEquipFromSlot(5).getClassName();
         }
         var _loc3_:Class = Skin_WuQi.PlayerMcArr[data.skinArr[data.skinNum]].getClass(_loc2_) as Class;
         this.skin_W = new _loc3_();
         addChild(skin_W);
         skin_W.mouseChildren = skin_W.mouseEnabled = false;
      }
      
      private function SkinPlay(param1:String) : *
      {
         if(skin)
         {
            this.skin.GoTo(param1);
         }
      }
      
      private function getRL(param1:Boolean) : *
      {
         this.RL = param1;
         if(param1)
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
         else if(!param1)
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
      
      public function HpUp(param1:Number, param2:int = 1) : *
      {
         var _loc4_:int = 0;
         if(hp.getValue() <= 0)
         {
            return;
         }
         var _loc3_:int = use_hp_Max.getValue();
         if(param2 == 1)
         {
            _loc4_ = hp.getValue() + param1;
         }
         else if(param2 == 2)
         {
            param1 = _loc3_ * param1 / 100;
            _loc4_ = hp.getValue() + param1;
         }
         else
         {
            _loc4_ = param1 = 0;
         }
         if(_loc4_ < _loc3_)
         {
            hp.setValue(_loc4_);
         }
         else
         {
            hp.setValue(_loc3_);
         }
         NewMC.Open("回血效果",this,0,0,0,param1);
      }
      
      public function MpUp(param1:Number, param2:int = 1) : *
      {
         var _loc4_:int = 0;
         if(hp.getValue() <= 0 || param1 <= 0)
         {
            return;
         }
         var _loc3_:int = use_mp_Max.getValue();
         if(param2 == 1)
         {
            mpUpNum = mp.getValue() + param1;
         }
         else if(param2 == 2)
         {
            param1 = _loc3_ * param1 / 100;
            mpUpNum = mp.getValue() + param1;
         }
         else
         {
            mpUpNum = param1 = 0;
         }
         if(mpUpNum < _loc3_)
         {
            mp.setValue(mpUpNum);
         }
         else
         {
            mp.setValue(_loc3_);
         }
         NewMC.Open("回蓝效果",this,0,0,0,param1);
      }
   }
}

