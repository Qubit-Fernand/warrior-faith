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
   
   public class Player extends MovieClip
   {
      
      public static var LV_data:XML;
      
      public static var enemySkillMC:*;
      
      public static var All:Array = [];
      
      public static var PlayerMcLoaded:Boolean = false;
      
      public static var PlayerMcArr:Array = new Array();
      
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
      
      public var lianJi:VT = VT.createVT(0);
      
      public var baoji:VT = VT.createVT(0);
      
      public var use_gongji:VT = VT.createVT(0);
      
      public var headFrame:int = 1;
      
      public var use_sanbi:VT = VT.createVT(0);
      
      public var skin:Skin;
      
      public var use_fangyu:VT = VT.createVT(0);
      
      public var yingzhi:VT = VT.createVT(0);
      
      public var hit:MovieClip = null;
      
      internal var jKey:Boolean = false;
      
      private var jumpX2:Boolean = false;
      
      public var hp_Max:VT = VT.createVT(100);
      
      public var gongji:VT = VT.createVT();
      
      public var data:PlayerData;
      
      public var AllSkillCD:Array = new Array();
      
      public var mp:VT = VT.createVT(9999999);
      
      private var jump_power:* = 145;
      
      public var lianJiTime:int = 60;
      
      public var All_ObjCDXX:Array = new Array();
      
      public var fangyu:VT = VT.createVT(0);
      
      private var runArr:Array = new Array();
      
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
      
      private function AddSkin_W() : *
      {
         var skinNumX:int = 0;
         var name:String = null;
         var classRef:Class = null;
         skinNumX = data.skinNum;
         if(skinNumX == 0)
         {
            name = data.getEquipSlot().getEquipFromSlot(2).getClassName();
         }
         else if(skinNumX == 1)
         {
            name = data.getEquipSlot().getEquipFromSlot(5).getClassName();
         }
         classRef = Skin_WuQi.PlayerMcArr[data.skinArr[data.skinNum]].getClass(name) as Class;
         this.skin_W = new classRef();
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
      
      private function getRL(_RL:Boolean) : *
      {
         this.RL = _RL;
         if(_RL)
         {
            skin.scaleX = skin_Z.scaleX = skin_W.scaleX = -1;
         }
         else if(!_RL)
         {
            skin.scaleX = skin_Z.scaleX = skin_W.scaleX = 1;
         }
      }
      
      private function KeyControl() : *
      {
         var typeStr:String = null;
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
         typeStr = "站";
         if(getKeyStatus("左",3))
         {
            typeStr = "跑";
            runPower(-walk_power.getValue() * 1.5,0,1);
            getRL(false);
         }
         else if(getKeyStatus("右",3))
         {
            typeStr = "跑";
            runPower(walk_power.getValue() * 1.5,0,1);
            getRL(true);
         }
         else if(getKeyStatus("左",2))
         {
            typeStr = "走";
            runPower(-walk_power.getValue(),0,1);
            getRL(false);
         }
         else if(getKeyStatus("右",2))
         {
            typeStr = "走";
            runPower(walk_power.getValue(),0,1);
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
      
      public function HpXX(hitX:HitXX) : *
      {
         var gongJi_hpX:int = 0;
         var attTimes:int = 0;
         var fangYU:int = 0;
         var hpX:int = 0;
         var xxx:int = 0;
         var yyy:int = 0;
         var XX:int = 0;
         var hpHP:int = 0;
         ++WinShow.txt_3;
         gongJi_hpX = hitX.gongJi_hp;
         attTimes = hitX.times;
         NewMC.Open("被攻击",this);
         if(data.skinArr[data.skinNum] == 0 && skin.runType == "转职技能1" && skin.frame < 20)
         {
            if(data.getSkillLevel("a12") > 0)
            {
               gongJi_hpX *= 0.3;
            }
         }
         fangYU = this.use_fangyu.getValue();
         hpX = gongJi_hpX - fangYU / attTimes;
         if(hpX > 0)
         {
            hpHP = hp.getValue() - hpX;
            if(hpHP < 0)
            {
               hp.setValue(0);
            }
            else
            {
               hp.setValue(hpHP);
            }
         }
         else
         {
            hpX = 0;
         }
         xxx = this.x + Math.random() * 100 - 50;
         yyy = this.y + Math.random() * 100 - 50;
         if(hpX == 0)
         {
            NewMC.Open("闪避2",Main.world.moveChild_Other,xxx,yyy,15,0,true,2);
         }
         else
         {
            NewMC.Open("_被打数字",Main.world.moveChild_Other,xxx,yyy,15,hpX,true,2);
         }
         XX = hitX.硬直 - this.skin.被攻击硬直;
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
      
      private function onADDED_TO_STAGE(e:*) : *
      {
         Main.world.moveChild_Player.addChild(this);
         All[All.length] = this;
         Main._stage.addEventListener(KeyboardEvent.KEY_DOWN,onKEY_DOWN);
         addEventListener(Event.REMOVED_FROM_STAGE,onREMOVED_FROM_STAGE);
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
      
      public function GetKeyArr(arr:Array) : *
      {
         var i:int = 0;
         if(arr.length == data._keyArr.length)
         {
            for(i = 0; i < data._keyArr.length; i++)
            {
               if(!(arr[i] is int))
               {
                  trace("GetKeyArr按键设置 参数错误#1 数组类型错误");
               }
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
      
      private function SkinPlay(str:String) : *
      {
         if(skin)
         {
            this.skin.GoTo(str);
         }
      }
      
      public function 连击计数() : *
      {
         lianJiTime = 0;
         lianJi.setValue(lianJi.getValue() + 1);
         WinShow.LianJi(lianJi.getValue());
      }
      
      public function CanSkill(skill_ID:String, lv:int) : Boolean
      {
         var s:Skill = null;
         var tempMP:int = 0;
         var tempCd:int = 0;
         s = SkillFactory.getSkillByTypeIAndLevel(skill_ID,lv);
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
         trace("只接受string & string[] 类型参数");
         return false;
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
      
      private function TaoZhuangXiaoGuo() : *
      {
         var arr:Array = null;
         var i:int = 0;
         var hpXX:int = 0;
         var lianjiX:int = 0;
         var 攻击系数:Number = NaN;
         arr = data.equipSlot.getAllSuitSkill();
         for(i in arr)
         {
            if(arr[i] == 57200)
            {
               hpXX = hp_Max.getValue() * 0.3;
               if(hp.getValue() < hpXX)
               {
                  use_gongji.setValue(use_gongji.getValue() * 1.05);
               }
            }
            else if(arr[i] == 57201)
            {
               hpXX = hp_Max.getValue() * 0.5;
               if(hp.getValue() < hpXX)
               {
                  use_fangyu.setValue(use_fangyu.getValue() * 1.2);
               }
            }
            else if(arr[i] == 57210)
            {
               lianjiX = lianJi.getValue();
               if(lianjiX > 2000)
               {
                  lianjiX = 2000;
               }
               攻击系数 = 1 + lianjiX / 60 * 0.02;
               if(攻击系数 > 3)
               {
                  攻击系数 = 1;
               }
               use_gongji.setValue(use_gongji.getValue() * 攻击系数);
            }
         }
      }
      
      public function left_Reight() : *
      {
         if(this.data.getEquipSkillSlot().getGemFromSkillSlot(0) != null)
         {
            energySlot.energyLeftNum = 0;
            energySlot.energyLeftMax = SkillFactory.getSkillById(this.data.getEquipSkillSlot().getGemFromSkillSlot(0).getGemSkill()).getEp();
         }
         if(this.data.getEquipSkillSlot().getGemFromSkillSlot(1) != null)
         {
            energySlot.energyRightNum = 0;
            energySlot.energyRightMax = SkillFactory.getSkillById(this.data.getEquipSkillSlot().getGemFromSkillSlot(1).getGemSkill()).getEp();
         }
      }
      
      public function LoadPlayerLvData() : *
      {
         var xml:XML = null;
         var hpMaxX:int = 0;
         var mpMaxX:int = 0;
         var gongJiX:int = 0;
         var fangyuX:int = 0;
         var baojibaojiX:int = 0;
         var sanbiX:int = 0;
         var yingzhiX:int = 0;
         双手加成();
         xml = Player.getPlayerLvData(this.data);
         nextExp.setValue(int(xml.经验));
         hpMaxX = int(xml.HP) + data.getEquipSlot().getAllHP();
         hp_Max.setValue(hpMaxX);
         mpMaxX = int(xml.MP) + data.getEquipSlot().getAllMP();
         mp_Max.setValue(mpMaxX);
         gongJiX = (int(xml.攻击) + data.getEquipSlot().getAllAttack()) * shuangShouBeiShu;
         gongji.setValue(gongJiX);
         fangyuX = int(xml.防御) + data.getEquipSlot().getAllDefense();
         fangyu.setValue(fangyuX);
         baojibaojiX = int(xml.暴击) + data.getEquipSlot().getAllCrit();
         baoji.setValue(baojibaojiX);
         sanbiX = int(xml.闪避) + data.getEquipSlot().getAllDuck();
         sanbi.setValue(sanbiX);
         yingzhiX = int(xml.硬值) + data.getEquipSlot().getAllHardValue();
         yingzhi.setValue(yingzhiX);
         walk_power.setValue(6 + data.getEquipSlot().getAllMoveSpeed());
         LoadAll_D_Skill();
      }
      
      private function MP_UP(num:int) : *
      {
         var mpXX:int = 0;
         mpXX = num + mp.getValue();
         if(mpXX > mp_Max.getValue())
         {
            mp.setValue(mp_Max.getValue());
         }
         else
         {
            mp.setValue(mpXX);
         }
      }
      
      private function MoveRun() : *
      {
         var xxYN:Boolean = false;
         var xx:int = 0;
         var yy:int = 0;
         var forecast_x:* = 0;
         var forecast_y:* = 0;
         var mapX:* = 0;
         var i:* = 0;
         var playerX2:Boolean = false;
         var otherPlayer:Player = null;
         var ii:* = 0;
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
         xx = Math.abs(this.runX);
         yy = Math.abs(this.runY);
         forecast_x = int(this.x + Main.world.x);
         forecast_y = int(this.y);
         mapX = int(Main.world.x);
         for(i = yy; i > 0; i--)
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
         for(ii = xx; ii > 0; ii--)
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
                     if(forecast_x > 700 && mapX > -660)
                     {
                        mapX--;
                     }
                     forecast_x++;
                  }
                  else if(forecast_x > 700 && mapX > -660 && otherPlayer.x + mapX > 10)
                  {
                     forecast_x++;
                     mapX--;
                  }
                  else if(forecast_x < 1600 && Math.abs(forecast_x - otherPlayer.x - mapX + 10) < 940)
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
         if(forecast_x - Main.world.x > 0 && forecast_x - Main.world.x < 1600)
         {
            this.x = forecast_x - Main.world.x;
         }
         Main.world.x = mapX;
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
      
      public function LevelUP() : *
      {
         var levelX:int = 0;
         var pointsX:int = 0;
         if(hp.getValue() <= 0)
         {
            return;
         }
         levelX = data.level.getValue();
         pointsX = data.points.getValue();
         if(levelX < 50)
         {
            data.level.setValue(levelX + 1);
            data.setEXP(0);
            data.points.setValue(pointsX + 4);
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
            lianJi.setValue(0);
         }
      }
      
      private function UserObj(num:int) : *
      {
         var name:String = null;
         var XX:Supplies = null;
         var arr:Array = null;
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
         name = this.data.getSuppliesSlot().getFromSuppliesSlot(num).getName();
         if(!CanUserObj(name))
         {
            return;
         }
         XX = this.data.getSuppliesSlot().getFromSuppliesSlot(num);
         arr = XX.getAffectAttrib();
         for(i in arr)
         {
            xa = int((arr[i] as SuppliesAffect).getAttribType());
            va = int((arr[i] as SuppliesAffect).getValue());
            lv = XX.getUseLevel();
            if(xa == 1 && this.data.getLevel() >= lv)
            {
               xv = hp.getValue() + va;
               max = hp_Max.getValue();
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
               max = mp_Max.getValue();
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
      
      public function 信春哥() : *
      {
         deadX.visible = false;
         this.skin.visible = true;
         skin_Z.visible = true;
         skin_W.visible = true;
         this.hp.setValue(this.hp_Max.getValue());
         this.mp.setValue(this.mp_Max.getValue());
      }
      
      private function HP_UP(num:int) : *
      {
         var hpXX:int = 0;
         hpXX = num + hp.getValue();
         if(hpXX > hp_Max.getValue())
         {
            hp.setValue(hp_Max.getValue());
         }
         else
         {
            hp.setValue(hpXX);
         }
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
         var i:* = 0;
         runX = runY = 0;
         for(i = int(runArr.length - 1); i >= 0; i--)
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
      
      public function runPower(numX:Number = 0, numY:Number = 0, time:int = 0, str:String = "") : *
      {
         var numXX:* = undefined;
         var numYY:* = undefined;
         var gravityX:Number = NaN;
         var gravityY:Number = NaN;
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
         numXX = numX / time * parabola;
         numYY = numY / time * parabola;
         gravityX = numX * (1 - parabola) / (time * time - time * (time - 1) / 2);
         gravityY = numY * (1 - parabola) / (time * time - time * (time - 1) / 2);
         runArr[runArr.length] = [numXX,numYY,time,gravityX,gravityY,str];
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
      
      public function ExpUP(num:int) : *
      {
         var exp:int = 0;
         var next_exp:int = 0;
         if(hp.getValue() <= 0)
         {
            return;
         }
         exp = data.getEXP();
         next_exp = nextExp.getValue();
         if(exp + num >= next_exp)
         {
            LevelUP();
         }
         else
         {
            data.setEXP(exp + num);
         }
      }
      
      public function CanUserObj(obj_ID:String) : Boolean
      {
         var tempCd:int = 0;
         tempCd = int(sel_objCD(obj_ID));
         if(tempCd == -1)
         {
            return false;
         }
         return true;
      }
      
      private function LoadAll_ZB_Skill() : *
      {
         var 攻击系数:Number = NaN;
         var arr:Array = null;
         var i:int = 0;
         var idX:int = 0;
         var sk_ValueArr:Array = null;
         var num:Number = NaN;
         var hpXX:int = 0;
         var 攻击附加2:Number = NaN;
         use_hp_Max.setValue(hp_Max.getValue());
         use_mp_Max.setValue(mp_Max.getValue());
         use_gongji.setValue(gongji.getValue());
         use_fangyu.setValue(fangyu.getValue());
         use_baoji.setValue(baoji.getValue());
         use_sanbi.setValue(sanbi.getValue());
         walk_power.setValue(6 + data.getEquipSlot().getAllMoveSpeed());
         攻击系数 = 1;
         arr = data.equipSlot.getAllEquipSkill();
         for(i in arr)
         {
            idX = int(SkillFactory.getSkillById(arr[i]).getSkillActOn());
            sk_ValueArr = SkillFactory.getSkillById(arr[i]).getSkillValueArray();
            if(idX == 31)
            {
               hpXX = hp_Max.getValue() * sk_ValueArr[1].getValue();
               if(hp.getValue() < hpXX)
               {
                  攻击附加2 = Number(sk_ValueArr[0].getValue());
                  攻击系数 += 攻击附加2;
               }
            }
            else if(idX == 32)
            {
               if(lianJi.getValue() > sk_ValueArr[1].getValue())
               {
                  num = Number(sk_ValueArr[0].getValue());
                  攻击系数 += num;
               }
            }
            else if(idX == 33)
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
            else if(idX == 35)
            {
               num = use_baoji.getValue() + sk_ValueArr[0].getValue();
               use_baoji.setValue(num);
            }
         }
         use_gongji.setValue(gongji.getValue() * 攻击系数);
         数值溢出修正();
         TaoZhuangXiaoGuo();
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
      
      private function onKEY_DOWN(e:KeyboardEvent) : *
      {
         if(e.keyCode == data._keyArr[5])
         {
            jKey = true;
         }
      }
      
      private function onREMOVED_FROM_STAGE(e:*) : *
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
         var skinNumX:int = 0;
         var classRef:Class = null;
         skinNumX = int(data.skinArr[data.skinNum]);
         classRef = PlayerMcArr[data.skinArr[data.skinNum]].getClass("src.Skin.Skin_player" + skinNumX) as Class;
         this.skin = new classRef();
         skin.skinNum = data.skinArr[data.skinNum];
         skin.Xml = Skin.PlayerXml[data.skinArr[data.skinNum]];
         skin.playX = this;
         addChild(skin);
         skin.mouseChildren = skin.mouseEnabled = false;
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
                     shuangShouBeiShu = 1.1;
                     xxxx = 10000;
                     return;
                  }
               }
               else if(arr[i] == 1)
               {
                  if(leftWQ == rightWQ && rightWQ == 6)
                  {
                     shuangShouBeiShu = 1.1;
                     xxxx = 20000;
                     return;
                  }
               }
               else if(arr[i] == 2)
               {
                  if(leftWQ == rightWQ && rightWQ == 7)
                  {
                     shuangShouBeiShu = 1.1;
                     xxxx = 30000;
                     return;
                  }
               }
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
      
      private function onENTER_FRAME(e:*) : *
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
         energySlot.setZero();
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
         var headEquip:Equip = null;
         var newHeadFrame:int = 0;
         headEquip = data.getEquipSlot().getEquipFromSlot(0);
         if(Boolean(data) && Boolean(headEquip))
         {
            newHeadFrame = int(headEquip.getClassName());
            if(headFrame != newHeadFrame)
            {
               headFrame = newHeadFrame;
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
         var skinNumX:int = 0;
         var name:String = null;
         var classRef:Class = null;
         skinNumX = int(data.skinArr[data.skinNum]);
         if(data.getEquipSlot().getEquipFromSlot(1) == null)
         {
            name = "甲白1";
         }
         else
         {
            name = data.getEquipSlot().getEquipFromSlot(1).getClassName();
         }
         classRef = Skin_ZhuangBei.PlayerMcArr[data.skinArr[data.skinNum]].getClass(name) as Class;
         this.skin_Z = new classRef();
         addChild(skin_Z);
         skin_Z.mouseChildren = skin_Z.mouseEnabled = false;
      }
   }
}

