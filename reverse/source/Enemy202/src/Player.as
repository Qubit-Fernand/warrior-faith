package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
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
   import src.other.*;
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
      
      private static var Temp11:VT = VT.createVT(VT.GetTempVT("10+1/10"));
      
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
         num_1 = VT.createVT(0.1);
         num_15 = VT.createVT(0.15);
         num_20 = VT.createVT(0.2);
         num_25 = VT.createVT(0.25);
         num_30 = VT.createVT(0.3);
         num_35 = VT.createVT(0.35);
         num_7 = VT.createVT(0.07);
         num_27 = VT.createVT(0.27);
      }
      
      public static function getPlayerLvData(param1:PlayerData) : XML
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         for(_loc2_ in LV_data.角色)
         {
            _loc3_ = int(LV_data.角色[_loc2_].等级);
            if(_loc3_ == param1.getLevel())
            {
               return LV_data.角色[_loc2_];
            }
         }
         trace("找不到该等级信息");
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
      
      private function onADDED_TO_STAGE(param1:*) : *
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
            NewMC.Open("死亡倒计时",this.parent,this.x,this.y);
            trace("死亡倒计时");
         }
         this.deadX.frame = this.headFrame;
         this.deadX.head_mc.gotoAndStop(this.deadX.frame);
         this.deadX.visible = true;
         this.skin_Z.visible = false;
         this.skin_W.visible = false;
         this.energySlot.setZero();
      }
      
      public function 信春哥() : *
      {
         this.deadX.visible = false;
         this.skin.visible = true;
         this.skin_Z.visible = true;
         this.skin_W.visible = true;
         this.hp.setValue(999999);
         this.mp.setValue(999999);
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         this.skin.Over();
      }
      
      public function ExpUP(param1:int, param2:int = 1) : String
      {
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         this.data.setEXP(this.data.getEXP() + param1);
         if(this.data.getEXP() >= this.nextExp.getValue())
         {
            return this.LevelUP(param2);
         }
         return "ok";
      }
      
      public function LevelUP(param1:int = 1) : *
      {
         var _loc3_:CS50_Info = null;
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         var _loc2_:int = this.data.getLevel();
         if(_loc2_ < 50 || _loc2_ < Player.maxLevel && this.data.isRebirth())
         {
            if(param1 == 1)
            {
               this.data.setEXP(0);
               this.LevelUP_X();
            }
            else if(param1 == 2)
            {
               while(this.data.getEXP() >= this.nextExp.getValue() && (this.data.getLevel() < 50 || this.data.getLevel() < Player.maxLevel && this.data.isRebirth()))
               {
                  this.data.setEXP(this.data.getEXP() - this.nextExp.getValue());
                  this.LevelUP_X();
               }
            }
            NewMC.Open("升级效果",this);
            if(this.data.getLevel() == 50)
            {
               _loc3_ = new CS50_Info();
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
      
      public function MoneyUP(param1:int) : *
      {
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         this.data.addGold(param1);
         NewMC.Open("掉钱",this,0,0,15,param1,true);
      }
      
      public function Load_All_Player_Data() : *
      {
         this.LoadPlayerLvData();
         this.GetAllSkillCD();
         this.GetAllObjCD();
         this.newSkin();
         this.信春哥();
         this.left_Reight();
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
         var _loc1_:XML = Player.getPlayerLvData(this.data);
         this.nextExp.setValue(int(_loc1_.经验));
         var _loc2_:int = int(_loc1_.HP) + this.data.getEquipSlot().getAllHP();
         this.hp_Max.setValue(_loc2_);
         var _loc3_:int = int(_loc1_.MP) + this.data.getEquipSlot().getAllMP();
         this.mp_Max.setValue(_loc3_);
         var _loc4_:int = (int(_loc1_.攻击) + this.data.getEquipSlot().getAllAttack()) * this.shuangShouBeiShu;
         this.gongji.setValue(_loc4_);
         var _loc5_:int = int(_loc1_.防御) + this.data.getEquipSlot().getAllDefense();
         this.fangyu.setValue(_loc5_);
         var _loc6_:int = int(_loc1_.暴击) + this.data.getEquipSlot().getAllCrit();
         this.baoji.setValue(_loc6_);
         var _loc7_:int = int(_loc1_.闪避) + this.data.getEquipSlot().getAllDuck();
         this.sanbi.setValue(_loc7_);
         var _loc8_:int = int(_loc1_.硬值) + this.data.getEquipSlot().getAllHardValue();
         this.yingzhi.setValue(_loc8_);
         this.walk_power.setValue(6 + this.data.getEquipSlot().getAllMoveSpeed());
         this.LoadAll_D_Skill();
      }
      
      private function LoadAll_D_Skill() : *
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         for(_loc1_ in this.data.getSkillArr())
         {
            _loc2_ = (this.data.getSkillArr()[_loc1_][0] as String).substr(0,1);
            if(_loc2_ == "d")
            {
               if(this.data.getSkillArr()[_loc1_][0] == "d1" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  this.jumpX2 = true;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d2" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  this.hp_Max.setValue(this.hp_Max.getValue() + _loc4_);
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d3" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  this.mp_Max.setValue(this.mp_Max.getValue() + _loc4_);
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d4" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  this.baoji.setValue(this.baoji.getValue() + _loc4_);
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d5" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc4_ = Number((_loc3_[0] as VT).getValue());
                  this.sanbi.setValue(this.sanbi.getValue() + _loc4_);
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d6" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  this.职业附加[0] = 1 + _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d7" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  this.职业附加[1] = 1 + _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d8" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  this.职业附加[2] = 1 + _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d9" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  this.套装强化[0] = _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d10" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  this.套装强化[1] = _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d11" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  _loc5_ = Number((_loc3_[0] as VT).getValue());
                  this.套装强化[2] = _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d12" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  this.套装强化[3] = _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d13" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  _loc3_ = SkillFactory.getSkillByTypeIAndLevel(this.data.getSkillArr()[_loc1_][0],this.data.getSkillArr()[_loc1_][1]).getSkillValueArray();
                  this.套装强化[4] = _loc5_;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d14" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  this.套装强化[5] = true;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d15" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  this.套装强化[6] = true;
               }
               else if(this.data.getSkillArr()[_loc1_][0] == "d16" && this.data.getSkillArr()[_loc1_][1] > 0)
               {
                  this.套装强化[7] = true;
               }
            }
         }
      }
      
      private function Time1() : *
      {
         if(this.getAllMoveSpeed.getValue() == -99 || this.time % (27 * 5) == 0)
         {
            this.getAllMoveSpeed.setValue(this.data.getEquipSlot().getAllMoveSpeed());
         }
      }
      
      private function Time2() : *
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(!this.getAllSuitSkill || this.time % (27 * 5) == 9)
         {
            this.getAllSuitSkill = this.data.equipSlot.getAllSuitSkill();
         }
         if(!this.getAllEquipSkill || this.time % (27 * 5) == 18)
         {
            _loc1_ = this.data.getEquipSlot().getAllEquipSkill();
            this.getAllEquipSkill = new Array();
            for(_loc2_ in _loc1_)
            {
               this.getAllEquipSkill[_loc2_] = SkillFactory.getSkillById(_loc1_[_loc2_]);
            }
         }
      }
      
      private function LoadAll_ZB_Skill() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         this.use_hp_Max.setValue(this.hp_Max.getValue());
         this.use_mp_Max.setValue(this.mp_Max.getValue());
         this.use_gongji.setValue(this.gongji.getValue());
         this.use_fangyu.setValue(this.fangyu.getValue());
         this.use_baoji.setValue(this.baoji.getValue());
         this.use_sanbi.setValue(this.sanbi.getValue());
         this.walk_power.setValue(6 + this.data.getEquipSlot().getAllMoveSpeed());
         this.reSet();
         var _loc1_:Array = this.data.getEquipSlot().getAllEquipSkill();
         for(_loc2_ in _loc1_)
         {
            _loc3_ = int(SkillFactory.getSkillById(_loc1_[_loc2_]).getSkillActOn());
            _loc4_ = SkillFactory.getSkillById(_loc1_[_loc2_]).getSkillValueArray();
            if(_loc3_ == 31)
            {
               _loc6_ = this.hp_Max.getValue() * _loc4_[1].getValue();
               if(this.hp.getValue() < _loc6_)
               {
                  _loc5_ = Number(_loc4_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc5_);
               }
            }
            else if(_loc3_ == 32)
            {
               if(this.lianJi.getValue() > _loc4_[1].getValue())
               {
                  _loc5_ = Number(_loc4_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc5_);
               }
            }
            else if(_loc3_ == 35)
            {
               _loc5_ = this.use_baoji.getValue() + _loc4_[0].getValue();
               this.use_baoji.setValue(_loc5_);
            }
            else if(_loc3_ == 200)
            {
               if(this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
               {
                  num_fy.setValue(num_fy.getValue() + _loc4_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc4_[1].getValue());
               }
            }
            else if(_loc3_ == 201)
            {
               if(this.data.getEquipSlot().getEquipFromSlot(7).getRemainingTime() > 0)
               {
                  num_hp.setValue(num_hp.getValue() + _loc4_[0].getValue());
                  num_bj.setValue(num_bj.getValue() + _loc4_[1].getValue());
               }
            }
         }
         this.TaoZhuangXiaoGuo();
         this.zengFu();
         this.huiZhangJiaCheng();
         this.chongwujiacheng();
         this.QiangHuaJiaCheng();
         this.ALLcompute();
         this.chenghaoJiaCheng();
         for(_loc2_ in _loc1_)
         {
            _loc3_ = int(SkillFactory.getSkillById(_loc1_[_loc2_]).getSkillActOn());
            _loc4_ = SkillFactory.getSkillById(_loc1_[_loc2_]).getSkillValueArray();
            if(_loc3_ == 33)
            {
               if(this.time % (_loc4_[0].getValue() - this.套装强化[0]) == 0)
               {
                  _loc5_ = _loc4_[1].getValue() * this.use_mp_Max.getValue();
                  this.MP_UP(_loc5_);
               }
            }
            else if(_loc3_ == 34)
            {
               if(this.time % (_loc4_[0].getValue() - this.套装强化[1]) == 0)
               {
                  _loc5_ = _loc4_[1].getValue() * this.use_hp_Max.getValue();
                  this.HP_UP(_loc5_);
               }
            }
         }
         this.数值溢出修正();
      }
      
      private function 装备技能() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         for(_loc1_ in this.getAllEquipSkill)
         {
            _loc2_ = int(this.getAllEquipSkill[_loc1_].getSkillActOn());
            _loc3_ = this.getAllEquipSkill[_loc1_].getSkillValueArray();
            if(_loc2_ == 31)
            {
               _loc5_ = this.hp_Max.getValue() * _loc3_[1].getValue();
               if(this.hp.getValue() < _loc5_)
               {
                  _loc4_ = Number(_loc3_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc4_);
               }
            }
            else if(_loc2_ == 32)
            {
               if(this.lianJi.getValue() > _loc3_[1].getValue())
               {
                  _loc4_ = Number(_loc3_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc4_);
               }
            }
            else if(_loc2_ == 35)
            {
               _loc4_ = this.use_baoji.getValue() + _loc3_[0].getValue();
               this.use_baoji.setValue(_loc4_);
            }
            else if(_loc2_ == 200)
            {
               if(this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
               {
                  num_fy.setValue(num_fy.getValue() + _loc3_[0].getValue());
                  num_gj.setValue(num_gj.getValue() + _loc3_[1].getValue());
               }
            }
            else if(_loc2_ == 201)
            {
               if(this.data.getEquipSlot().getEquipFromSlot(7).getRemainingTime() > 0)
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
         for(i in this.getAllEquipSkill)
         {
            _loc1_ = int(this.getAllEquipSkill[i].getSkillActOn());
            _loc2_ = this.getAllEquipSkill[i].getSkillValueArray();
            if(_loc1_ == 33)
            {
               if(this.time % (_loc2_[0].getValue() - this.套装强化[0]) == 0)
               {
                  num = _loc2_[1].getValue() * this.use_mp_Max.getValue();
                  this.MP_UP(num);
               }
            }
            else if(_loc1_ == 34)
            {
               if(this.time % (_loc2_[0].getValue() - this.套装强化[1]) == 0)
               {
                  num = _loc2_[1].getValue() * this.use_hp_Max.getValue();
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
      
      private function zengFu() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:Array = this.data.equipSlot.getAllEquipNewSkill();
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
         this.use_hp_Max.setValue(int(this.use_hp_Max.getValue() * num_hp.getValue()));
         this.use_mp_Max.setValue(int(this.use_mp_Max.getValue() * num_mp.getValue()));
         this.use_gongji.setValue(this.use_gongji.getValue() * num_gj.getValue());
         this.use_fangyu.setValue(this.use_fangyu.getValue() * num_fy.getValue());
         this.use_sanbi.setValue(this.use_sanbi.getValue() * num_sb.getValue());
         this.use_baoji.setValue(this.use_baoji.getValue() * num_bj.getValue());
         this.walk_power.setValue(this.walk_power.getValue() + num_sd.getValue());
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
         var _loc1_:int = this.data.getEquipSlot().getSuitStrength();
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
         for(_loc1_ in this.getAllSuitSkill)
         {
            if(this.getAllSuitSkill[_loc1_] == 57200)
            {
               _loc2_ = this.hp_Max.getValue() * 0.3;
               if(this.hp.getValue() < _loc2_)
               {
                  num_gj.setValue(num_gj.getValue() + num_7.getValue());
               }
            }
            else if(this.getAllSuitSkill[_loc1_] == 57201)
            {
               _loc2_ = this.hp_Max.getValue() * 0.5;
               if(this.hp.getValue() < _loc2_)
               {
                  num_fy.setValue(num_fy.getValue() + num_20.getValue());
               }
            }
            else if(this.getAllSuitSkill[_loc1_] == 57210)
            {
               _loc3_ = this.lianJi.getValue();
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
         if(this.hp.getValue() > this.use_hp_Max.getValue())
         {
            this.hp.setValue(this.use_hp_Max.getValue());
         }
         if(this.mp.getValue() > this.use_mp_Max.getValue())
         {
            this.mp.setValue(this.use_mp_Max.getValue());
         }
      }
      
      private function HP_UP(param1:int) : *
      {
         var _loc2_:int = param1 + this.hp.getValue();
         if(_loc2_ > this.use_hp_Max.getValue())
         {
            this.hp.setValue(this.use_hp_Max.getValue());
         }
         else
         {
            this.hp.setValue(_loc2_);
         }
      }
      
      private function MP_UP(param1:int) : *
      {
         var _loc2_:int = param1 + this.mp.getValue();
         if(_loc2_ > this.use_mp_Max.getValue())
         {
            this.mp.setValue(this.use_mp_Max.getValue());
         }
         else
         {
            this.mp.setValue(_loc2_);
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
         else
         {
            this.lianJi.setValue(0);
         }
      }
      
      public function GetAllSkillCD() : *
      {
         var _loc1_:int = 0;
         this.AllSkillCD = this.data.skillCdArr();
         this.AllSkillCDXX = DeepCopyUtil.clone(this.AllSkillCD);
         for(_loc1_ in this.AllSkillCD)
         {
            this.AllSkillCDXX[_loc1_][2] = 1;
            this.AllSkillCDXX[_loc1_][1] = 0;
            if(this.data.getSkillLevel(this.AllSkillCDXX[_loc1_][0]) > 0)
            {
               this.AllSkillCDXX[_loc1_][2] = 50;
               this.AllSkillCDXX[_loc1_][1] = this.AllSkillCD[_loc1_][1];
            }
         }
      }
      
      public function GetAllObjCD() : *
      {
         var _loc1_:int = 0;
         this.All_ObjCD = this.data.ObjCdArr();
         this.All_ObjCDXX = DeepCopyUtil.clone(this.All_ObjCD);
         for(_loc1_ in this.All_ObjCD)
         {
            this.All_ObjCDXX[_loc1_][2] = 50;
         }
      }
      
      public function GetKeyArr(param1:Array) : *
      {
         var _loc2_:int = 0;
         if(param1.length == this.data._keyArr.length)
         {
            _loc2_ = 0;
            while(_loc2_ < this.data._keyArr.length)
            {
               if(!(param1[_loc2_] is int))
               {
                  trace("GetKeyArr按键设置 参数错误#1 数组类型错误");
               }
               _loc2_++;
            }
            this.KeyArr = this.data._keyArr;
         }
         else
         {
            trace("GetKeyArr按键设置 参数错误#2 数组长度错误");
         }
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         ++this.time;
         this.连击计时();
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
      }
      
      public function 双手加成() : *
      {
         var _loc1_:Array = null;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         this.shuangShouBeiShu = 1;
         if(this.data.isTransferOk())
         {
            _loc1_ = this.data.getTransferOk();
            _loc2_ = this.data.getEquipSlot().getEquipFromSlot(2).getPosition();
            _loc3_ = this.data.getEquipSlot().getEquipFromSlot(5).getPosition();
            for(_loc4_ in _loc1_)
            {
               if(_loc1_[_loc4_] == 0)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 5)
                  {
                     this.shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(_loc1_[_loc4_] == 1)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 6)
                  {
                     this.shuangShouBeiShu = Temp11.getValue();
                     return;
                  }
               }
               else if(_loc1_[_loc4_] == 2)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 7)
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
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Equip = this.data.getEquipSlot().getEquipFromSlot(0);
         if(Boolean(this.skin_Z2) && Boolean(this.skin_Z2_V) && this.data.getEquipSlot().getEquipFromSlot(6).getRemainingTime() > 0)
         {
            _loc2_ = int(this.data.getEquipSlot().getEquipFromSlot(6).getClassName2());
            this.headFrame = _loc2_;
         }
         else if(Boolean(this.data) && Boolean(_loc1_))
         {
            _loc3_ = int(_loc1_.getClassName());
            if(this.headFrame != _loc3_)
            {
               this.headFrame = _loc3_;
            }
         }
         else
         {
            this.headFrame = 1;
         }
         trace("headFrame = = = = = == = == = == = " + this.headFrame);
      }
      
      private function CDtime() : *
      {
         var _loc1_:int = 0;
         for(_loc1_ in this.AllSkillCDXX)
         {
            if(this.AllSkillCDXX[_loc1_][1] < this.AllSkillCD[_loc1_][1] && this.data.getSkillLevel(this.AllSkillCDXX[_loc1_][0]) > 0)
            {
               ++this.AllSkillCDXX[_loc1_][1];
               this.AllSkillCDXX[_loc1_][2] = int(this.AllSkillCDXX[_loc1_][1] / this.AllSkillCD[_loc1_][1] * 50);
            }
         }
         for(_loc1_ in this.All_ObjCDXX)
         {
            if(this.All_ObjCDXX[_loc1_][1] < this.All_ObjCD[_loc1_][1])
            {
               ++this.All_ObjCDXX[_loc1_][1];
               this.All_ObjCDXX[_loc1_][2] = int(this.All_ObjCDXX[_loc1_][1] / this.All_ObjCD[_loc1_][1] * 50);
            }
         }
      }
      
      private function selCD(param1:String) : int
      {
         var _loc2_:int = 0;
         for(_loc2_ in this.AllSkillCDXX)
         {
            if(this.AllSkillCDXX[_loc2_][0] == param1)
            {
               if(this.AllSkillCDXX[_loc2_][1] == this.AllSkillCD[_loc2_][1])
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
         for(_loc2_ in this.All_ObjCD)
         {
            if(this.All_ObjCDXX[_loc2_][0] == param1)
            {
               if(this.All_ObjCDXX[_loc2_][1] == this.All_ObjCD[_loc2_][1])
               {
                  return _loc2_;
               }
               return -1;
            }
         }
         return -1;
      }
      
      public function selCD50(param1:String) : int
      {
         var _loc2_:int = 0;
         for(_loc2_ in this.AllSkillCDXX)
         {
            if(this.AllSkillCDXX[_loc2_][0] == param1)
            {
               return this.AllSkillCDXX[_loc2_][2];
            }
         }
         return 50;
      }
      
      public function sel_objCD50(param1:String) : int
      {
         var _loc2_:int = 0;
         for(_loc2_ in this.All_ObjCDXX)
         {
            if(this.All_ObjCDXX[_loc2_][0] == param1)
            {
               return this.All_ObjCDXX[_loc2_][2];
            }
         }
         return 50;
      }
      
      public function HpXX(param1:*) : *
      {
         var _loc10_:Number = NaN;
         if(this.noHit)
         {
            this.noHit = false;
            return;
         }
         if(param1 is HitXX)
         {
            this.hitXX = param1;
         }
         ++WinShow.txt_3;
         var _loc2_:int = int(param1.gongJi_hp);
         var _loc3_:int = int(param1.times);
         NewMC.Open("被攻击",this);
         if(this.data.skinArr[this.data.skinNum] == 0 && this.skin.runType == "转职技能1" && this.skin.frame < 20)
         {
            if(this.data.getSkillLevel("a12") > 0)
            {
               _loc2_ *= 0.3;
            }
         }
         var _loc4_:int = this.use_fangyu.getValue() + this.fangYuPOWER.getValue();
         var _loc5_:int = _loc2_ - _loc4_ / _loc3_;
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         else
         {
            {};
         }
         _loc5_ += _loc2_ * (Math.random() * 3 + 2) / 100;
         var _loc6_:int = this.hp.getValue() - _loc5_;
         if(_loc6_ <= 0)
         {
            this.hp.setValue(0);
         }
         else
         {
            this.hp.setValue(_loc6_);
         }
         var _loc7_:int = this.x + Math.random() * 100 - 50;
         var _loc8_:int = this.y + Math.random() * 100 - 50;
         if(_loc5_ == 0)
         {
            NewMC.Open("闪避2",Main.world.moveChild_Other,_loc7_,_loc8_,15,0,true,2);
         }
         else
         {
            NewMC.Open("_被打数字",Main.world.moveChild_Other,_loc7_,_loc8_,15,_loc5_,true,2);
         }
         if(this.data.getEquipSlot().getEquipFromSlot(6))
         {
            if(this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14455 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14461 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14462 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14463 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14464 || this.data.getEquipSlot().getEquipFromSlot(6).getId() == 14465)
            {
               _loc10_ = Math.random() * 20;
               if(_loc10_ < 1)
               {
                  this.hp.setValue(this.hp.getValue() + Math.round(this.use_hp_Max.getValue() / 5));
                  NewMC.Open("回血效果",this,0,0,0,Math.round(this.use_hp_Max.getValue() / 5));
               }
            }
         }
         var _loc9_:int = param1.硬直 - this.skin.被攻击硬直;
         if(_loc9_ > this.skin.continuousTime && _loc9_ >= 0)
         {
            this.skin.GoTo("被打",_loc9_);
         }
         this.runArr = new Array();
         if(param1.RL)
         {
            this.runPower(param1.runArr[0],param1.runArr[1],param1.runArr[2]);
         }
         else
         {
            this.runPower(-param1.runArr[0],param1.runArr[1],param1.runArr[2]);
         }
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
      
      private function onKEY_DOWN(param1:KeyboardEvent) : *
      {
         if(param1.keyCode == this.data._keyArr[5])
         {
            this.jKey = true;
         }
      }
      
      private function KeyControl() : *
      {
         this.药品使用();
         if(!this.skin)
         {
            trace("skin is null !!");
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
         if(this.jumping > 0 && this.getKeyStatus("跳",1))
         {
            this.fly = true;
         }
         if(Boolean(this.fly && this.mp.getValue() > 1 && this.getKeyStatus("跳",2) && this.skin_Z3_V) && Boolean(this.data.getEquipSlot().getEquipFromSlot(7)) && this.data.getEquipSlot().getEquipFromSlot(7).getColor() >= 4)
         {
            ++this.flyTime;
            if(this.flyTime % 27 == 26)
            {
               this.mp.setValue(this.mp.getValue() - this.use_mp_Max.getValue() / 100 * 2);
            }
            this.gravity = this.gravityNum = 0;
            if(this.getKeyStatus("左",2))
            {
               this.runPower(-this.walk_power.getValue() * 1.5,0,1);
               this.getRL(false);
            }
            if(this.getKeyStatus("右",2))
            {
               this.runPower(this.walk_power.getValue() * 1.5,0,1);
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
            return;
         }
         if(this.mp.getValue() < 1)
         {
            this.mp.setValue(1);
            if(this.skin_Z3_V)
            {
               this.skin_Z3_V = false;
               this.newSkin();
            }
         }
         this.fly = false;
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
         var _loc1_:String = "站";
         if(this.getKeyStatus("左",3))
         {
            _loc1_ = "跑";
            this.runPower(-this.walk_power.getValue() * 1.5,0,1);
            this.getRL(false);
         }
         else if(this.getKeyStatus("右",3))
         {
            _loc1_ = "跑";
            this.runPower(this.walk_power.getValue() * 1.5,0,1);
            this.getRL(true);
         }
         else if(this.getKeyStatus("左",2))
         {
            _loc1_ = "走";
            this.runPower(-this.walk_power.getValue(),0,1);
            this.getRL(false);
         }
         else if(this.getKeyStatus("右",2))
         {
            _loc1_ = "走";
            this.runPower(this.walk_power.getValue(),0,1);
            this.getRL(true);
         }
         if(this.getKeyStatus("攻击",1))
         {
            if(_loc1_ == "跑" && this.jumping == 0)
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
            this.SkinPlay(_loc1_);
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
      
      private function UserObj(param1:int) : *
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(this.hp.getValue() <= 0 || this.data.getSuppliesSlot().getNumFromSuppliesSlot(this.data.getBag(),param1) < 1)
         {
            return;
         }
         var _loc2_:String = this.data.getSuppliesSlot().getFromSuppliesSlot(param1).getName();
         if(!this.CanUserObj(_loc2_))
         {
            return;
         }
         var _loc3_:Supplies = this.data.getSuppliesSlot().getFromSuppliesSlot(param1);
         var _loc4_:Array = _loc3_.getAffectAttrib();
         for(_loc5_ in _loc4_)
         {
            _loc6_ = int((_loc4_[_loc5_] as SuppliesAffect).getAttribType());
            _loc7_ = int((_loc4_[_loc5_] as SuppliesAffect).getValue());
            _loc8_ = _loc3_.getUseLevel();
            if(_loc6_ == 1 && this.data.getLevel() >= _loc8_)
            {
               _loc9_ = this.hp.getValue() + _loc7_;
               _loc10_ = this.use_hp_Max.getValue();
               if(_loc9_ < _loc10_)
               {
                  this.hp.setValue(_loc9_);
               }
               else
               {
                  this.hp.setValue(_loc10_);
               }
               NewMC.Open("回血效果",this,0,0,0,_loc7_);
               _loc11_ = int(this.sel_objCD(_loc2_));
               this.All_ObjCDXX[_loc11_][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),param1);
            }
            else if(_loc6_ == 2 && this.data.getLevel() >= _loc8_)
            {
               _loc9_ = this.mp.getValue() + _loc7_;
               _loc10_ = this.use_mp_Max.getValue();
               if(_loc9_ < _loc10_)
               {
                  this.mp.setValue(_loc9_);
               }
               else
               {
                  this.mp.setValue(_loc10_);
               }
               NewMC.Open("回蓝效果",this,0,0,0,_loc7_);
               _loc11_ = int(this.sel_objCD(_loc2_));
               this.All_ObjCDXX[_loc11_][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),param1);
            }
         }
         this.刷新背包显示();
      }
      
      public function CanSkill(param1:String, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Skill = SkillFactory.getSkillByTypeIAndLevel(param1,param2);
         if(_loc3_ != null)
         {
            _loc4_ = this.mp.getValue() - _loc3_.getMp();
            _loc5_ = int(this.selCD(param1));
            if(_loc4_ <= 0)
            {
               return false;
            }
            if(_loc5_ == -1)
            {
               return false;
            }
            this.mp.setValue(_loc4_);
            this.AllSkillCDXX[_loc5_][1] = 0;
            return true;
         }
         return true;
      }
      
      public function CanUserObj(param1:String) : Boolean
      {
         var _loc2_:int = int(this.sel_objCD(param1));
         if(_loc2_ == -1)
         {
            return false;
         }
         return true;
      }
      
      private function MoveData() : *
      {
         this.runX = this.runY = 0;
         var _loc1_:* = int(this.runArr.length - 1);
         while(_loc1_ >= 0)
         {
            if(this.runArr[_loc1_][2] > 0)
            {
               this.runX += this.runArr[_loc1_][0] + this.runArr[_loc1_][3] * this.runArr[_loc1_][2];
               this.runY -= this.runArr[_loc1_][1] + this.runArr[_loc1_][4] * this.runArr[_loc1_][2];
               --this.runArr[_loc1_][2];
            }
            else
            {
               this.runArr.splice(_loc1_,1);
            }
            _loc1_--;
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
         var _loc1_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Player = null;
         var _loc11_:Boolean = false;
         var _loc12_:uint = 0;
         var _loc13_:* = undefined;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:uint = 0;
         var _loc18_:Boolean = false;
         var _loc19_:uint = 0;
         var _loc20_:Boolean = false;
         var _loc21_:uint = 0;
         var _loc22_:Boolean = false;
         var _loc23_:uint = 0;
         if(this.runX > 0)
         {
            _loc1_ = true;
         }
         var _loc2_:int = Math.abs(this.runX);
         var _loc3_:int = Math.abs(this.runY);
         var _loc4_:* = int(this.x + Main.world.x);
         var _loc5_:* = int(this.y);
         var _loc6_:* = int(Main.world.x);
         var _loc7_:* = _loc3_;
         while(_loc7_ > 0)
         {
            if(this.jumpType == 1)
            {
               _loc11_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - 100,true));
               if(!_loc11_)
               {
                  _loc12_ = 0;
                  while(_loc12_ < Main.world.numChildren)
                  {
                     _loc13_ = Main.world.getChildAt(_loc12_);
                     if(_loc13_ is Map && Boolean(_loc13_.MapData1.hitTestPoint(_loc4_,_loc5_ - 100,true)))
                     {
                        _loc11_ = true;
                        break;
                     }
                     _loc12_++;
                  }
               }
               if(!_loc11_)
               {
                  _loc5_--;
               }
            }
            else if(this.jumpType == 2)
            {
               _loc14_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ - 3,true));
               _loc15_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true));
               _loc16_ = Boolean(Main.world.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true));
               _loc17_ = 0;
               while(_loc17_ < Main.world.numChildren)
               {
                  _loc13_ = Main.world.getChildAt(_loc17_);
                  if(_loc13_ is Map && Boolean(_loc13_.MapData.hitTestPoint(_loc4_,_loc5_ - 3,true)))
                  {
                     _loc14_ = true;
                  }
                  else if(_loc13_ is Map && Boolean(_loc13_.MapData.hitTestPoint(_loc4_,_loc5_ - 1,true)))
                  {
                     _loc15_ = true;
                  }
                  else if(_loc13_ is Map && Boolean(_loc13_.MapData.hitTestPoint(_loc4_,_loc5_ + 6,true)))
                  {
                     _loc16_ = true;
                  }
                  _loc17_++;
               }
               if(_loc14_)
               {
                  _loc5_ -= 2;
                  this.jumping = 0;
               }
               else if(_loc15_)
               {
                  this.runY = 0;
                  this.gravityNum = 0;
                  this.jumping = 0;
               }
               else if(_loc16_)
               {
                  _loc5_ += 3;
                  this.jumping = 0;
               }
               else
               {
                  _loc5_++;
               }
            }
            else if(this.jumpType == 3)
            {
               _loc18_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - 5,true));
               _loc19_ = 0;
               while(_loc19_ < Main.world.numChildren)
               {
                  _loc13_ = Main.world.getChildAt(_loc19_);
                  if(_loc13_ is Map && Boolean(_loc13_.MapData1.hitTestPoint(_loc4_,_loc5_ - 5,true)))
                  {
                     _loc18_ = true;
                  }
                  _loc19_++;
               }
               if(!_loc18_)
               {
                  this.jumpType = 2;
                  break;
               }
               _loc5_ += 2;
            }
            _loc7_--;
         }
         this.y = _loc5_;
         if(Main.player_2)
         {
            if(Main.player_1.hp.getValue() > 0 && Main.player_2.hp.getValue() > 0)
            {
               _loc8_ = true;
            }
            else
            {
               _loc8_ = false;
            }
            if(this == Main.player_1)
            {
               _loc9_ = Main.player_2;
            }
            else
            {
               _loc9_ = Main.player_1;
            }
         }
         var _loc10_:* = _loc2_;
         while(_loc10_ > 0)
         {
            if(_loc1_ && !Main.world.MapData1.hitTestPoint(_loc4_ + 20,_loc5_ - 50,true))
            {
               _loc20_ = false;
               _loc21_ = 0;
               while(_loc21_ < Main.world.numChildren)
               {
                  _loc13_ = Main.world.getChildAt(_loc21_);
                  if(_loc13_ is Map && Boolean(_loc13_.MapData.hitTestPoint(_loc4_ + 20,_loc5_ - 50,true)))
                  {
                     _loc20_ = true;
                     break;
                  }
                  _loc21_++;
               }
               if(!_loc20_)
               {
                  if(!_loc8_)
                  {
                     if(_loc4_ > 700 && _loc6_ > 940 - Main.world._width)
                     {
                        _loc6_--;
                     }
                     _loc4_++;
                  }
                  else if(_loc4_ > 700 && _loc6_ > 940 - Main.world._width && _loc9_.x + _loc6_ > 10)
                  {
                     _loc4_++;
                     _loc6_--;
                  }
                  else if(_loc4_ < Main.world._width && Math.abs(_loc4_ - _loc9_.x - _loc6_ + 10) < 940)
                  {
                     _loc4_++;
                  }
               }
            }
            else if(!_loc1_ && !Main.world.MapData1.hitTestPoint(_loc4_ - 20,_loc5_ - 50,true))
            {
               _loc22_ = false;
               _loc23_ = 0;
               while(_loc23_ < Main.world.numChildren)
               {
                  _loc13_ = Main.world.getChildAt(_loc23_);
                  if(_loc13_ is Map && Boolean(_loc13_.MapData.hitTestPoint(_loc4_ - 20,_loc5_ - 50,true)))
                  {
                     _loc22_ = true;
                     break;
                  }
                  _loc23_++;
               }
               if(!_loc22_)
               {
                  if(!_loc8_)
                  {
                     if(_loc4_ < 400 && _loc6_ < 0)
                     {
                        _loc6_++;
                     }
                     _loc4_--;
                  }
                  else if(_loc4_ < 400 && _loc6_ < 0 && _loc9_.x + _loc6_ < 835)
                  {
                     _loc4_--;
                     _loc6_++;
                  }
                  else if(_loc4_ > 0 && Math.abs(_loc4_ - _loc9_.x - _loc6_ - 10) < 940)
                  {
                     _loc4_--;
                  }
               }
            }
            _loc10_--;
         }
         if(_loc4_ - Main.world.x > 0 && _loc4_ - Main.world.x < Main.world._width)
         {
            this.x = _loc4_ - Main.world.x;
         }
         Main.world.x = _loc6_;
      }
      
      public function runPower(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:String = "") : *
      {
         var _loc9_:* = 0;
         if(param4 == "跳")
         {
            _loc9_ = int(this.runArr.length - 1);
            while(_loc9_ >= 0)
            {
               if(this.runArr[_loc9_][5] == "跳")
               {
                  this.runArr.splice(_loc9_,1);
               }
               _loc9_--;
            }
         }
         if(param3 <= 3)
         {
            this.runArr[this.runArr.length] = [param1,param2,1,0,0,param4];
            return;
         }
         var _loc5_:* = param1 / param3 * this.parabola;
         var _loc6_:* = param2 / param3 * this.parabola;
         var _loc7_:Number = param1 * (1 - this.parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         var _loc8_:Number = param2 * (1 - this.parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         this.runArr[this.runArr.length] = [_loc5_,_loc6_,param3,_loc7_,_loc8_,param4];
      }
      
      public function getKeyStatus(param1:*, param2:int = 1) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 is String)
         {
            _loc3_ = 0;
            while(_loc3_ < this.data._keyArr.length)
            {
               if(this.KeyArrStr[_loc3_] == param1)
               {
                  return BasicKey.getKeyState(this.data._keyArr[_loc3_],param2);
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
               while(_loc5_ < this.data._keyArr.length)
               {
                  if(this.KeyArrStr[_loc5_] == param1[_loc3_])
                  {
                     _loc4_[_loc4_.length] = this.data._keyArr[_loc5_];
                  }
                  _loc5_++;
               }
               _loc3_++;
            }
            return BasicKey.getTargetState(_loc4_);
         }
         trace("只接受string & string[] 类型参数");
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
         var _loc1_:int = int(this.data.skinArr[this.data.skinNum]);
         var _loc2_:Class = PlayerMcArr[this.data.skinArr[this.data.skinNum]].getClass("src.Skin.Skin_player" + _loc1_) as Class;
         this.skin = new _loc2_();
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
         var _loc2_:String = null;
         var _loc1_:int = int(this.data.skinArr[this.data.skinNum]);
         if(this.data.getEquipSlot().getEquipFromSlot(1) == null)
         {
            _loc2_ = "甲白1";
         }
         else
         {
            _loc2_ = this.data.getEquipSlot().getEquipFromSlot(1).getClassName();
         }
         var _loc3_:Class = Skin_ZhuangBei.PlayerMcArr[this.data.skinArr[this.data.skinNum]].getClass(_loc2_) as Class;
         this.skin_Z = new _loc3_();
         addChild(this.skin_Z);
         this.skin_Z.mouseChildren = this.skin_Z.mouseEnabled = false;
         if(this.data.getEquipSlot().getEquipFromSlot(6) != null)
         {
            _loc2_ = this.data.getEquipSlot().getEquipFromSlot(6).getClassName();
            _loc3_ = Skin_ZhuangBei.PlayerMcArr2[this.data.skinArr[this.data.skinNum]].getClass(_loc2_) as Class;
            this.skin_Z2 = new _loc3_();
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
         var _loc2_:String = null;
         var _loc1_:int = this.data.skinNum;
         if(_loc1_ == 0)
         {
            _loc2_ = this.data.getEquipSlot().getEquipFromSlot(2).getClassName();
         }
         else if(_loc1_ == 1)
         {
            _loc2_ = this.data.getEquipSlot().getEquipFromSlot(5).getClassName();
         }
         var _loc3_:Class = Skin_WuQi.PlayerMcArr[this.data.skinArr[this.data.skinNum]].getClass(_loc2_) as Class;
         this.skin_W = new _loc3_();
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
      
      private function SkinPlay(param1:String) : *
      {
         if(this.skin)
         {
            this.skin.GoTo(param1);
         }
      }
      
      private function getRL(param1:Boolean) : *
      {
         this.RL = param1;
         if(param1)
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
         else if(!param1)
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
      
      public function NewCW(param1:Pet) : *
      {
         if(this.playerCW)
         {
            this.playerCW.Close();
         }
         this.data.playerCW_Data = param1;
         this.playerCW = new ChongWu(param1,this);
      }
      
      public function HpUp(param1:Number, param2:int = 1) : *
      {
         var _loc4_:int = 0;
         if(this.hp.getValue() <= 0)
         {
            return;
         }
         var _loc3_:int = this.use_hp_Max.getValue();
         if(param2 == 1)
         {
            _loc4_ = this.hp.getValue() + param1;
         }
         else if(param2 == 2)
         {
            param1 = _loc3_ * param1 / 100;
            _loc4_ = this.hp.getValue() + param1;
         }
         else
         {
            _loc4_ = param1 = 0;
         }
         if(_loc4_ < _loc3_)
         {
            this.hp.setValue(_loc4_);
         }
         else
         {
            this.hp.setValue(_loc3_);
         }
         NewMC.Open("回血效果",this,0,0,0,param1);
      }
      
      public function MpUp(param1:Number, param2:int = 1) : *
      {
         var _loc4_:int = 0;
         if(this.hp.getValue() <= 0 || param1 <= 0)
         {
            return;
         }
         var _loc3_:int = this.use_mp_Max.getValue();
         if(param2 == 1)
         {
            mpUpNum = this.mp.getValue() + param1;
         }
         else if(param2 == 2)
         {
            param1 = _loc3_ * param1 / 100;
            mpUpNum = this.mp.getValue() + param1;
         }
         else
         {
            mpUpNum = param1 = 0;
         }
         if(mpUpNum < _loc3_)
         {
            this.mp.setValue(mpUpNum);
         }
         else
         {
            this.mp.setValue(_loc3_);
         }
         NewMC.Open("回蓝效果",this,0,0,0,param1);
      }
   }
}

