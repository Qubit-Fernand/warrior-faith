package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.models.skill.Skill;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import src.other.*;
   
   public class Player extends MovieClip
   {
      
      public static var LV_data:XML;
      
      public static var enemySkillMC:*;
      
      public static var All:Array = [];
      
      public static var PlayerMcLoaded:Boolean = false;
      
      public static var PlayerMcArr:Array = new Array();
      
      public static var fangyuTuTeng:Number = 0;
      
      private var SwitchingTime:int;
      
      public var skin_Z:Skin_ZhuangBei;
      
      public var skin_W:Skin_WuQi;
      
      public var sanbi:VT = VT.createVT(0);
      
      private var jump_time:* = 8;
      
      public var RL:Boolean = true;
      
      public var nextExp:VT = VT.createVT(99999999);
      
      private var gravityNum:* = 0;
      
      public var use_mp_Max:VT = VT.createVT(0);
      
      private var parabola:Number = 0.3;
      
      private var gravity:int = 2;
      
      public var AllSkillCDXX:Array = new Array();
      
      public var deadX:Dead;
      
      private var jumpType:int = 2;
      
      public var use_baoji:VT = VT.createVT(0);
      
      public var energySlot:EnergySlot = new EnergySlot();
      
      public var mp_Max:VT = VT.createVT(80);
      
      public var 职业附加:Array = [1,1,1];
      
      public var time:int = 1000;
      
      public var hp:VT = VT.createVT(9999999);
      
      public var walk_power:VT = VT.createVT(6);
      
      private var jumping:int = 0;
      
      private var KeyArrStr:Array = ["上","下","左","右","攻击","跳","切换","技能1","技能2","技能3","技能4","消耗1","消耗2","消耗3","转职","怪物"];
      
      private var runY:int = 0;
      
      public var All_ObjCD:Array = new Array();
      
      private var runX:int = 0;
      
      public var 装备附加:Array = [];
      
      public var use_hp_Max:VT = VT.createVT(0);
      
      public var lianJi:int = 0;
      
      public var baoji:VT = VT.createVT(0);
      
      public var use_gongji:VT = VT.createVT(0);
      
      public var headFrame:int = 1;
      
      public var use_sanbi:VT = VT.createVT(0);
      
      public var skin:Skin;
      
      public var use_fangyu:VT = VT.createVT(0);
      
      public var yingzhi:VT = VT.createVT(0);
      
      public var hit:MovieClip = null;
      
      internal var jKey:Boolean = false;
      
      public var hp_Max:VT = VT.createVT(100);
      
      public var gongji:VT = VT.createVT(0);
      
      public var data:PlayerData;
      
      public var AllSkillCD:Array = new Array();
      
      public var mp:VT = VT.createVT(9999999);
      
      private var jump_power:* = 145;
      
      public var lianJiTime:int = 60;
      
      public var All_ObjCDXX:Array = new Array();
      
      public var fangyu:VT = VT.createVT(0);
      
      private var runArr:Array = new Array();
      
      private var jumpingX:Boolean = false;
      
      public var shuangShouBeiShu:Number = 1;
      
      public var 套装强化:Array = [0,0,0,0,0,false,false,false];
      
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
         if(Main.P1P2)
         {
            Main.player_2.deadX.visible = false;
            Main.player_2.信春哥();
         }
      }
      
      private function AddSkin_W() : *
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Class = null;
         _loc1_ = data.skinNum;
         if(_loc1_ == 0)
         {
            _loc2_ = data.getEquipSlot().getEquipFromSlot(2).getClassName();
         }
         else if(_loc1_ == 1)
         {
            _loc2_ = data.getEquipSlot().getEquipFromSlot(5).getClassName();
         }
         _loc3_ = Skin_WuQi.PlayerMcArr[data.skinArr[data.skinNum]].getClass(_loc2_) as Class;
         this.skin_W = new _loc3_();
         addChild(skin_W);
         skin_W.mouseChildren = skin_W.mouseEnabled = false;
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
      
      public function selCD50(param1:String) : int
      {
         var _loc2_:int = 0;
         for(_loc2_ in AllSkillCDXX)
         {
            if(AllSkillCDXX[_loc2_][0] == param1)
            {
               return AllSkillCDXX[_loc2_][2];
            }
         }
         return 50;
      }
      
      private function getRL(param1:Boolean) : *
      {
         this.RL = param1;
         if(param1)
         {
            skin.scaleX = skin_Z.scaleX = skin_W.scaleX = -1;
         }
         else if(!param1)
         {
            skin.scaleX = skin_Z.scaleX = skin_W.scaleX = 1;
         }
      }
      
      private function KeyControl() : *
      {
         var _loc1_:String = null;
         药品使用();
         if(!skin)
         {
            trace("skin is null !!");
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
         if(jKey && (jumping == 0 || Boolean(jumpingX) && jumping < 2))
         {
            jKey = false;
            runPower(0,jump_power,jump_time,"跳");
            SkinPlay("跳");
            jumping += 1;
            if(Boolean(jumpingX) && jumping == 2)
            {
               NewMC.Open("二段跳效果",Main.world.moveChild_Other,this.x,this.y);
            }
         }
         else if(jKey)
         {
            jKey = false;
         }
         _loc1_ = "站";
         if(getKeyStatus("左",3))
         {
            _loc1_ = "跑";
            runPower(-walk_power.getValue() * 1.5,0,1);
            getRL(false);
         }
         else if(getKeyStatus("右",3))
         {
            _loc1_ = "跑";
            runPower(walk_power.getValue() * 1.5,0,1);
            getRL(true);
         }
         else if(getKeyStatus("左",2))
         {
            _loc1_ = "走";
            runPower(-walk_power.getValue(),0,1);
            getRL(false);
         }
         else if(getKeyStatus("右",2))
         {
            _loc1_ = "走";
            runPower(walk_power.getValue(),0,1);
            getRL(true);
         }
         if(getKeyStatus("攻击",1))
         {
            if(_loc1_ == "跑" && jumping == 0)
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
            SkinPlay(_loc1_);
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
      
      public function HpXX(param1:HitXX) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc2_ = param1.gongJi_hp;
         _loc3_ = param1.times;
         NewMC.Open("被攻击",this);
         if(data.skinArr[data.skinNum] == 0 && skin.runType == "转职技能1" && skin.frame < 20)
         {
            if(data.getSkillLevel("a12") > 0)
            {
               _loc2_ *= 0.3;
            }
         }
         _loc4_ = this.fangyu.getValue() * NewMC.F_J3_fanfYu + fangyuTuTeng;
         _loc5_ = _loc2_ - _loc4_ / _loc3_;
         if(_loc5_ > 0)
         {
            _loc9_ = hp.getValue() - _loc5_;
            if(_loc9_ < 0)
            {
               hp.setValue(0);
            }
            else
            {
               hp.setValue(_loc9_);
            }
         }
         else
         {
            _loc5_ = 0;
         }
         _loc6_ = this.x + Math.random() * 100 - 50;
         _loc7_ = this.y + Math.random() * 100 - 50;
         if(_loc5_ == 0)
         {
            NewMC.Open("闪避2",Main.world.moveChild_Other,_loc6_,_loc7_,15,0,true,2);
         }
         else
         {
            NewMC.Open("_被打数字",Main.world.moveChild_Other,_loc6_,_loc7_,20,_loc5_,true,2);
         }
         _loc8_ = param1.硬直 - this.skin.被攻击硬直;
         if(_loc8_ > skin.continuousTime && _loc8_ >= 0)
         {
            skin.GoTo("被打",_loc8_);
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
      
      private function onADDED_TO_STAGE(param1:*) : *
      {
         Main.world.moveChild_Player.addChild(this);
         All[All.length] = this;
         Main._stage.addEventListener(KeyboardEvent.KEY_DOWN,onKEY_DOWN);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
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
      
      public function GetKeyArr(param1:Array) : *
      {
         var _loc2_:int = 0;
         if(param1.length == data._keyArr.length)
         {
            _loc2_ = 0;
            while(_loc2_ < data._keyArr.length)
            {
               if(!(param1[_loc2_] is int))
               {
                  trace("GetKeyArr按键设置 参数错误#1 数组类型错误");
               }
               _loc2_++;
            }
            this.KeyArr = data._keyArr;
         }
         else
         {
            trace("GetKeyArr按键设置 参数错误#2 数组长度错误");
         }
      }
      
      public function newZhuangBei() : *
      {
         if(skin_Z)
         {
            skin_Z.parent.removeChild(skin_Z);
            skin_Z = null;
         }
         AddSkin_Z();
      }
      
      private function SkinPlay(param1:String) : *
      {
         if(skin)
         {
            this.skin.GoTo(param1);
         }
      }
      
      public function 连击计数() : *
      {
         lianJiTime = 0;
         ++lianJi;
      }
      
      public function CanSkill(param1:String, param2:int) : Boolean
      {
         var _loc3_:Skill = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = SkillFactory.getSkillByTypeIAndLevel(param1,param2);
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
         trace("只接受string & string[] 类型参数");
         return false;
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
      
      public function LoadPlayerLvData() : *
      {
         var _loc1_:XML = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc1_ = Player.getPlayerLvData(this.data);
         nextExp.setValue(int(_loc1_.经验));
         _loc2_ = int(_loc1_.HP) + data.getEquipSlot().getAllHP();
         hp_Max.setValue(_loc2_);
         _loc3_ = int(_loc1_.MP) + data.getEquipSlot().getAllMP();
         mp_Max.setValue(_loc3_);
         _loc4_ = int(_loc1_.攻击) + data.getEquipSlot().getAllAttack();
         gongji.setValue(_loc4_);
         _loc5_ = int(_loc1_.防御) + data.getEquipSlot().getAllDefense();
         fangyu.setValue(_loc5_);
         _loc6_ = int(_loc1_.暴击) + data.getEquipSlot().getAllCrit();
         baoji.setValue(_loc6_);
         _loc7_ = int(_loc1_.闪避) + data.getEquipSlot().getAllDuck();
         sanbi.setValue(_loc7_);
         _loc8_ = int(_loc1_.硬值) + data.getEquipSlot().getAllHardValue();
         yingzhi.setValue(_loc8_);
         walk_power.setValue(6 + data.getEquipSlot().getAllMoveSpeed());
         LoadAll_D_Skill();
      }
      
      private function MP_UP(param1:int) : *
      {
         var _loc2_:int = 0;
         _loc2_ = param1 + mp.getValue();
         if(_loc2_ > mp_Max.getValue())
         {
            mp.setValue(mp_Max.getValue());
         }
         else
         {
            mp.setValue(_loc2_);
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
         var _loc7_:* = 0;
         var _loc8_:Boolean = false;
         var _loc9_:Player = null;
         var _loc10_:* = 0;
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
         if(runX > 0)
         {
            _loc1_ = true;
         }
         _loc2_ = Math.abs(this.runX);
         _loc3_ = Math.abs(this.runY);
         _loc4_ = int(this.x + Main.world.x);
         _loc5_ = int(this.y);
         _loc6_ = int(Main.world.x);
         _loc7_ = _loc3_;
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
                  jumping = 0;
               }
               else if(_loc15_)
               {
                  runY = 0;
                  gravityNum = 0;
                  jumping = 0;
               }
               else if(_loc16_)
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
               _loc18_ = Boolean(Main.world.MapData1.hitTestPoint(_loc4_,_loc5_ - 1,true));
               _loc19_ = 0;
               while(_loc19_ < Main.world.numChildren)
               {
                  _loc13_ = Main.world.getChildAt(_loc19_);
                  if(_loc13_ is Map && Boolean(_loc13_.MapData1.hitTestPoint(_loc4_,_loc5_ - 100,true)))
                  {
                     _loc18_ = true;
                  }
                  _loc19_++;
               }
               if(!_loc18_)
               {
                  jumpType = 2;
                  break;
               }
               _loc5_++;
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
         _loc10_ = _loc2_;
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
                     if(_loc4_ > 700 && _loc6_ > -660)
                     {
                        _loc6_--;
                     }
                     _loc4_++;
                  }
                  else if(_loc4_ > 700 && _loc6_ > -660 && _loc9_.x + _loc6_ > 10)
                  {
                     _loc4_++;
                     _loc6_--;
                  }
                  else if(_loc4_ < 1600 && Math.abs(_loc4_ - _loc9_.x - _loc6_ + 10) < 940)
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
         if(_loc4_ - Main.world.x > 0 && _loc4_ - Main.world.x < 1600)
         {
            this.x = _loc4_ - Main.world.x;
         }
         Main.world.x = _loc6_;
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
                  this.jumpingX = true;
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
      
      public function LevelUP() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = data.level.getValue();
         _loc2_ = data.points.getValue();
         if(_loc1_ < 50)
         {
            data.level.setValue(_loc1_ + 1);
            data.points.setValue(_loc2_ + 4);
            LoadPlayerLvData();
            信春哥();
            NewMC.Open("升级效果",this);
         }
      }
      
      private function 连击计时() : *
      {
         if(lianJiTime < 60)
         {
            ++lianJiTime;
         }
         else
         {
            lianJi = 0;
         }
      }
      
      private function UserObj(param1:int) : *
      {
         var _loc2_:String = null;
         var _loc3_:Supplies = null;
         var _loc4_:Array = null;
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
         _loc2_ = this.data.getSuppliesSlot().getFromSuppliesSlot(param1).getName();
         if(!CanUserObj(_loc2_))
         {
            return;
         }
         _loc3_ = this.data.getSuppliesSlot().getFromSuppliesSlot(param1);
         _loc4_ = _loc3_.getAffectAttrib();
         for(_loc5_ in _loc4_)
         {
            _loc6_ = int((_loc4_[_loc5_] as SuppliesAffect).getAttribType());
            _loc7_ = int((_loc4_[_loc5_] as SuppliesAffect).getValue());
            _loc8_ = _loc3_.getUseLevel();
            if(_loc6_ == 1 && this.data.getLevel() >= _loc8_)
            {
               _loc9_ = hp.getValue() + _loc7_;
               _loc10_ = hp_Max.getValue();
               if(_loc9_ < _loc10_)
               {
                  hp.setValue(_loc9_);
               }
               else
               {
                  hp.setValue(_loc10_);
               }
               NewMC.Open("回血效果",this,0,0,0,_loc7_);
               _loc11_ = int(sel_objCD(_loc2_));
               All_ObjCDXX[_loc11_][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),param1);
            }
            else if(_loc6_ == 2 && this.data.getLevel() >= _loc8_)
            {
               _loc9_ = mp.getValue() + _loc7_;
               _loc10_ = mp_Max.getValue();
               if(_loc9_ < _loc10_)
               {
                  mp.setValue(_loc9_);
               }
               else
               {
                  mp.setValue(_loc10_);
               }
               NewMC.Open("回蓝效果",this,0,0,0,_loc7_);
               _loc11_ = int(sel_objCD(_loc2_));
               All_ObjCDXX[_loc11_][1] = 0;
               this.data.getSuppliesSlot().useSupplies(this.data.getBag(),param1);
            }
         }
         刷新背包显示();
      }
      
      public function 信春哥() : *
      {
         deadX.visible = false;
         this.skin.visible = true;
         skin_Z.visible = true;
         skin_W.visible = true;
         this.hp.setValue(this.hp_Max.getValue());
         this.mp.setValue(this.mp_Max.getValue());
      }
      
      private function HP_UP(param1:int) : *
      {
         var _loc2_:int = 0;
         _loc2_ = param1 + hp.getValue();
         if(_loc2_ > hp_Max.getValue())
         {
            hp.setValue(hp_Max.getValue());
         }
         else
         {
            hp.setValue(_loc2_);
         }
      }
      
      public function MoneyUP(param1:int) : *
      {
         data.addGold(param1);
         NewMC.Open("掉钱",this,0,0,20,param1,true);
      }
      
      public function newSkin() : *
      {
         if(skin)
         {
            skin.gotoAndStop("站");
            skin.parent.removeChild(skin);
            skin = null;
         }
         AddSkin();
         newZhuangBei();
         newWuQi();
         LoadPlayerLvData();
         getRL(RL);
      }
      
      private function MoveData() : *
      {
         var _loc1_:* = 0;
         runX = runY = 0;
         _loc1_ = int(runArr.length - 1);
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
      
      public function sel_objCD50(param1:String) : int
      {
         var _loc2_:int = 0;
         for(_loc2_ in All_ObjCDXX)
         {
            if(All_ObjCDXX[_loc2_][0] == param1)
            {
               return All_ObjCDXX[_loc2_][2];
            }
         }
         return 50;
      }
      
      public function runPower(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:String = "") : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = 0;
         if(param4 == "跳")
         {
            _loc9_ = int(runArr.length - 1);
            while(_loc9_ >= 0)
            {
               if(runArr[_loc9_][5] == "跳")
               {
                  runArr.splice(_loc9_,1);
               }
               _loc9_--;
            }
         }
         if(param3 <= 3)
         {
            runArr[runArr.length] = [param1,param2,1,0,0,param4];
            return;
         }
         _loc5_ = param1 / param3 * parabola;
         _loc6_ = param2 / param3 * parabola;
         _loc7_ = param1 * (1 - parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         _loc8_ = param2 * (1 - parabola) / (param3 * param3 - param3 * (param3 - 1) / 2);
         runArr[runArr.length] = [_loc5_,_loc6_,param3,_loc7_,_loc8_,param4];
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
      
      public function ExpUP(param1:int) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = data.getEXP();
         _loc3_ = nextExp.getValue();
         if(_loc2_ + param1 >= _loc3_)
         {
            LevelUP();
            data.setEXP(0);
         }
         else
         {
            data.setEXP(_loc2_ + param1);
         }
      }
      
      public function CanUserObj(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = int(sel_objCD(param1));
         if(_loc2_ == -1)
         {
            return false;
         }
         return true;
      }
      
      private function LoadAll_ZB_Skill() : *
      {
         var _loc1_:Number = NaN;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         use_hp_Max.setValue(hp_Max.getValue());
         use_mp_Max.setValue(mp_Max.getValue());
         use_gongji.setValue(gongji.getValue());
         use_fangyu.setValue(fangyu.getValue());
         use_baoji.setValue(baoji.getValue());
         use_sanbi.setValue(sanbi.getValue());
         walk_power.setValue(6 + data.getEquipSlot().getAllMoveSpeed());
         _loc1_ = 1;
         _loc2_ = data.equipSlot.getAllEquipSkill();
         for(_loc3_ in _loc2_)
         {
            _loc4_ = int(SkillFactory.getSkillById(_loc2_[_loc3_]).getSkillActOn());
            _loc5_ = SkillFactory.getSkillById(_loc2_[_loc3_]).getSkillValueArray();
            if(_loc4_ == 31)
            {
               _loc7_ = hp_Max.getValue() * _loc5_[1].getValue();
               if(hp.getValue() < _loc7_)
               {
                  _loc8_ = Number(_loc5_[0].getValue());
                  _loc1_ += _loc8_;
               }
            }
            else if(_loc4_ == 32)
            {
               trace("神技 = " + _loc5_[0].getValue() + "," + _loc5_[1].getValue());
               if(lianJi > _loc5_[1].getValue())
               {
                  _loc6_ = Number(_loc5_[0].getValue());
                  _loc1_ += _loc6_;
               }
            }
            else if(_loc4_ == 33)
            {
               if(time % (_loc5_[0].getValue() - 套装强化[0]) == 0)
               {
                  _loc6_ = _loc5_[1].getValue() * use_mp_Max.getValue();
                  MP_UP(_loc6_);
               }
            }
            else if(_loc4_ == 34)
            {
               if(time % (_loc5_[0].getValue() - 套装强化[1]) == 0)
               {
                  _loc6_ = _loc5_[1].getValue() * use_hp_Max.getValue();
                  HP_UP(_loc6_);
               }
            }
            else if(_loc4_ == 35)
            {
               _loc6_ = use_baoji.getValue() + _loc5_[0].getValue();
               use_baoji.setValue(_loc6_);
            }
         }
         use_gongji.setValue(gongji.getValue() * _loc1_);
         数值溢出修正();
      }
      
      public function Load_All_Player_Data() : *
      {
         LoadPlayerLvData();
         GetAllSkillCD();
         GetAllObjCD();
         newSkin();
         信春哥();
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
      
      private function onKEY_DOWN(param1:KeyboardEvent) : *
      {
         if(param1.keyCode == data._keyArr[5])
         {
            jKey = true;
         }
      }
      
      private function onREMOVED_FROM_STAGE(param1:*) : *
      {
         this.skin.Over();
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
      
      private function AddSkin() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         _loc1_ = int(data.skinArr[data.skinNum]);
         _loc2_ = PlayerMcArr[data.skinArr[data.skinNum]].getClass("src.Skin.Skin_player" + _loc1_) as Class;
         this.skin = new _loc2_();
         skin.skinNum = data.skinArr[data.skinNum];
         skin.Xml = Skin.PlayerXml[data.skinArr[data.skinNum]];
         skin.playX = this;
         addChild(skin);
         skin.mouseChildren = skin.mouseEnabled = false;
      }
      
      private function 双手加成() : *
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
                     shuangShouBeiShu = 1.1;
                     return;
                  }
               }
               else if(_loc1_[_loc4_] == 1)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 6)
                  {
                     shuangShouBeiShu = 1.1;
                     return;
                  }
               }
               else if(_loc1_[_loc4_] == 2)
               {
                  if(_loc2_ == _loc3_ && _loc3_ == 7)
                  {
                     shuangShouBeiShu = 1.1;
                     return;
                  }
               }
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
      
      private function onENTER_FRAME(param1:*) : *
      {
         ++time;
         连击计时();
         发型变换();
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
         双手加成();
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
      
      public function 不信春哥() : *
      {
         if(!deadX.visible)
         {
            NewMC.Open("死亡倒计时",this.parent,this.x,this.y);
            trace("死亡倒计时");
         }
         deadX.frame = this.headFrame;
         deadX.visible = true;
         skin_Z.visible = false;
         skin_W.visible = false;
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
      
      private function 发型变换() : *
      {
         var _loc1_:Equip = null;
         var _loc2_:int = 0;
         _loc1_ = data.getEquipSlot().getEquipFromSlot(0);
         if(Boolean(data) && Boolean(_loc1_))
         {
            _loc2_ = int(_loc1_.getClassName());
            if(headFrame != _loc2_)
            {
               headFrame = _loc2_;
               newSkin();
            }
         }
         else
         {
            headFrame = 1;
         }
      }
      
      private function AddSkin_Z() : *
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Class = null;
         _loc1_ = int(data.skinArr[data.skinNum]);
         if(data.getEquipSlot().getEquipFromSlot(1) == null)
         {
            _loc2_ = "甲白1";
         }
         else
         {
            _loc2_ = data.getEquipSlot().getEquipFromSlot(1).getClassName();
         }
         _loc3_ = Skin_ZhuangBei.PlayerMcArr[data.skinArr[data.skinNum]].getClass(_loc2_) as Class;
         this.skin_Z = new _loc3_();
         addChild(skin_Z);
         skin_Z.mouseChildren = skin_Z.mouseEnabled = false;
      }
   }
}

