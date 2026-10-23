package src
{
   import com.*;
   import com.efnx.fps.*;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.petPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class Play_Interface extends MovieClip
   {
      
      public static var interfaceX:Play_Interface;
      
      public static var Xfile_YN:Boolean;
      
      public static var BossLifeYN:Boolean;
      
      public static var bossIS:Enemy;
      
      public static var templianJiNum:Array = [0,0];
      
      private var saveTime:int = 0;
      
      private var infoArr0:Array = ["找“技能导师-奥古斯汀”可以学习各系武器的技能噢","去挑战关卡时，记得检查一下药品是否足够。如果不够，可以找“妮蒂亚”购买。","收集到第一块女神碎片后，村庄的左边会开启通往女神像地图的入口。","修复第一块女神碎片后，会在“技能导师”背后开启通往“神秘之地”的入口","装备属性低的话，可以找“装备商人-道格拉斯”进行装备强化，宝石合成、宝石镶嵌来提升。","2个“强化石”可以合成1个“精良的强化石”，用“精良的强化石”强化装备得到的属性会更高","2个“低级属性石”可以合成一个“中级属性石”，“中级属性石”会有两条属性噢。","“强化石碎片”可以强化史诗级以下的技能石，2个“强化石碎片”可以合成一个1级强化石。","到达25级时，可以找“技能导师”进行转职，转职后可学习4个新的转职技能。","在背包里“鼠标双击”或“拖动”装备可以进行穿戴，右手武器需要拖动武器到右手武器栏才能替换。","2段跳可以在“技能导师”的“通用技能”里习得。","“菜单”栏里可以进行“快捷键设置”“返回城镇”等操作。","如果游戏过程中比较卡，可以通过降低画质提升流畅性。","在仓库中可以进行1P和2P的物品交换。"];
      
      private var infoArr1:Array = ["注意观察怪物的发招动作，并采取相应的行动进行躲避，可以让你更轻松的过关","按“上+攻击”和“下+攻击”可以发动各职业的2种特有攻击方式","多使用技能攻击怪物，可以更快更安全的过关","按2次“A（←）”或者“D（→）”可以跑动，跑动中按“攻击”可以进行“跑攻”","注入“技能石”后，打怪时能量条会开始蓄气，满了之后按“N”可以发动怪物技能，2P按“PageDown”发动"];
      
      private var 滚动提示time:int = 135;
      
      public function Play_Interface()
      {
         var _loc1_:fpsBox = null;
         super();
         interfaceX = this;
         if(Main.tianShiYN)
         {
            _loc1_ = new fpsBox();
            _loc1_.x = 450;
            _loc1_.y = 5;
            addChild(_loc1_);
         }
         info_mc.mouseChildren = info_mc.mouseEnabled = false;
         初始化技能图标();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         Xbag_mc.addEventListener(MouseEvent.CLICK,bag_OPEN);
         Xfile_mc.addEventListener(MouseEvent.CLICK,File_OPEN);
         Xshop_mc.addEventListener(MouseEvent.CLICK,shop_OPEN);
         画质_mc.addEventListener(MouseEvent.MOUSE_MOVE,画质提示开启);
         画质_mc.addEventListener(MouseEvent.MOUSE_OUT,画质提示关闭);
         画质_mc.A.addEventListener(MouseEvent.CLICK,画质);
         画质_mc.B.addEventListener(MouseEvent.CLICK,画质);
         画质_mc.C.addEventListener(MouseEvent.CLICK,画质);
         画质_mc.A.gotoAndStop(1);
         画质_mc.B.gotoAndStop(2);
         画质_mc.C.gotoAndStop(2);
         file_mc.addEventListener(MouseEvent.ROLL_OUT,系统菜单关闭);
         file_mc.visible = false;
         gameStop_btn.addEventListener(MouseEvent.MOUSE_DOWN,游戏暂停);
         renWuXX_mc.addEventListener(MouseEvent.MOUSE_DOWN,任务面板);
         CW_mc.addEventListener(MouseEvent.MOUSE_DOWN,CW面板);
         TiShiShow(false);
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!interfaceX)
         {
            interfaceX = new Play_Interface();
         }
         Main._this.addChild(interfaceX);
         interfaceX.x = param1;
         interfaceX.y = param2;
         interfaceX.visible = true;
         BossLifeYN = false;
      }
      
      public static function Close() : *
      {
         if(!interfaceX)
         {
            interfaceX = new Play_Interface();
         }
         interfaceX.x = 5000;
         interfaceX.y = 5000;
         interfaceX.visible = false;
         BossLifeYN = false;
      }
      
      public static function WhoIsBoss(param1:Enemy) : *
      {
         bossIS = param1;
      }
      
      public static function TiShiShow(param1:Boolean = true) : *
      {
         if(!interfaceX)
         {
            return;
         }
         if(param1)
         {
            interfaceX.RenWuTiShi_mc.visible = true;
         }
         else
         {
            interfaceX.RenWuTiShi_mc.visible = false;
         }
      }
      
      private function 游戏暂停(param1:*) : *
      {
         var _loc2_:GameStop = new GameStop();
      }
      
      private function onENTER_FRAME(param1:*) : *
      {
         Boss血条();
         玩家状态();
         连击计数();
         Cd计数();
         怪物技能计数();
         滚动提示();
         ShopObjTime_Show();
         Pk_mc();
      }
      
      private function Pk_mc() : *
      {
         if(PK_UI.PK_ing)
         {
            _PK_time_mc.visible = true;
            if(uint(PK_UI.Pk_timeNum / 27 % 60) < 10)
            {
               _PK_time_mc._time_txt.text = uint(PK_UI.Pk_timeNum / 27 / 60) + ":0" + uint(PK_UI.Pk_timeNum / 27 % 60);
            }
            else
            {
               _PK_time_mc._time_txt.text = uint(PK_UI.Pk_timeNum / 27 / 60) + ":" + uint(PK_UI.Pk_timeNum / 27 % 60);
            }
            _PK_time_mc._kill_txt.text = PK_UI.killNum;
         }
         else
         {
            _PK_time_mc.visible = false;
         }
      }
      
      private function 初始化技能图标() : *
      {
         var _loc1_:String = "";
         if(Main.player1.skinArr[Main.player1.skinNum] == 0)
         {
            _loc1_ = "a";
         }
         else if(Main.player1.skinArr[Main.player1.skinNum] == 1)
         {
            _loc1_ = "b";
         }
         else
         {
            _loc1_ = "c";
         }
         i = 8;
         while(i < 16)
         {
            Play1_mc["p_" + i]["p_mc"].gotoAndStop(_loc1_ + "" + i);
            ++i;
         }
         if(Boolean(Main.player2) && Boolean(Main.player_2))
         {
            if(Main.player2.skinArr[Main.player2.skinNum] == 0)
            {
               _loc1_ = "a";
            }
            else if(Main.player2.skinArr[Main.player2.skinNum] == 1)
            {
               _loc1_ = "b";
            }
            else
            {
               _loc1_ = "c";
            }
            i = 8;
            while(i < 16)
            {
               Play2_mc["p_" + i]["p_mc"].gotoAndStop(_loc1_ + "" + i);
               ++i;
            }
         }
      }
      
      private function Boss血条() : *
      {
         var _loc1_:int = 0;
         if(Boolean(bossIS) && BossLifeYN)
         {
            BossLife_mc.visible = true;
            BossLife_mc.touXiang.gotoAndStop("a" + bossIS.id);
            _loc1_ = 100 - bossIS.life.getValue() / bossIS.lifeMAX.getValue() * 100;
            BossLife_mc.gotoAndStop(_loc1_);
         }
         else
         {
            BossLife_mc.visible = false;
         }
      }
      
      private function 怪物技能计数() : *
      {
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            if(this.Play1_mc.guaiWu.currentFrame != Main.player_1.energySlot.getEnergyPer(Main.player_1))
            {
               this.Play1_mc.guaiWu.gotoAndStop(Main.player_1.energySlot.getEnergyPer(Main.player_1));
            }
         }
         if(Boolean(Main.P1P2) && Boolean(Main.player2) && Boolean(Main.player_2))
         {
            if(this.Play2_mc.guaiWu.currentFrame != Main.player_2.energySlot.getEnergyPer(Main.player_2))
            {
               this.Play2_mc.guaiWu.gotoAndStop(Main.player_2.energySlot.getEnergyPer(Main.player_2));
            }
         }
      }
      
      private function 玩家状态() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         Play2_mc.head_mc.visible = false;
         if(Main.player_1)
         {
            _loc1_ = Math.round(Main.player_1.hp.getValue());
            _loc2_ = Math.round(Main.player_1.use_hp_Max.getValue());
            _loc3_ = int(Main.player_1.mp.getValue());
            _loc4_ = int(Main.player_1.use_mp_Max.getValue());
            _loc5_ = int(Main.player_1.data.getEXP());
            _loc6_ = int(Main.player_1.nextExp.getValue());
            _loc7_ = 100 - _loc1_ / _loc2_ * 100;
            _loc8_ = 100 - _loc3_ / _loc4_ * 100;
            _loc9_ = int(Main.player_1.data.getLevel());
            _loc10_ = Main.player_1.data.getEXP() / Main.player_1.nextExp.getValue() * 100;
            _loc11_ = int(Main.player_1.headFrame);
            if(_loc3_ == 1)
            {
               _loc3_ = 0;
            }
            Play1_mc.hp_txt.text = _loc1_ + "/" + _loc2_;
            Play1_mc.mp_txt.text = _loc3_ + "/" + _loc4_;
            Play1_mc.exp_txt.text = _loc5_ + "/" + _loc6_;
            Play1_mc.hp_mc.load_mc.scaleX = 1 - _loc7_ / 100;
            Play1_mc.mp_mc.load_mc.scaleX = 1 - _loc8_ / 100;
            showLV(_loc9_,1);
            Play1_mc.exp_mc.gotoAndStop(_loc10_);
            Play1_mc.head_mc.gotoAndStop(_loc11_);
         }
         if(Main.P1P2)
         {
            _loc1_ = Math.round(Main.player_2.hp.getValue());
            _loc2_ = Math.round(Main.player_2.use_hp_Max.getValue());
            _loc3_ = int(Main.player_2.mp.getValue());
            _loc4_ = int(Main.player_2.use_mp_Max.getValue());
            _loc5_ = int(Main.player_2.data.getEXP());
            _loc6_ = int(Main.player_2.nextExp.getValue());
            _loc7_ = 100 - _loc1_ / _loc2_ * 100;
            _loc8_ = 100 - _loc3_ / _loc4_ * 100;
            _loc9_ = int(Main.player_2.data.getLevel());
            _loc10_ = Main.player_2.data.getEXP() / Main.player_2.nextExp.getValue() * 100;
            _loc11_ = int(Main.player_2.headFrame);
            if(_loc3_ == 1)
            {
               _loc3_ = 0;
            }
            Play2_mc.hp_txt.text = _loc1_ + "/" + _loc2_;
            Play2_mc.mp_txt.text = _loc3_ + "/" + _loc4_;
            Play2_mc.exp_txt.text = _loc5_ + "/" + _loc6_;
            Play2_mc.hp_mc.load_mc.scaleX = 1 - _loc7_ / 100;
            Play2_mc.mp_mc.load_mc.scaleX = 1 - _loc8_ / 100;
            showLV(_loc9_,2);
            Play2_mc.exp_mc.gotoAndStop(_loc10_);
            Play2_mc.head_mc.gotoAndStop(_loc11_);
            Play2_mc.head_mc.visible = true;
         }
         if(!Main.P1P2 && Boolean(Play2_mc.visible))
         {
            Play2_mc.visible = false;
         }
      }
      
      private function showLV(param1:Number, param2:int) : *
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 < 10)
         {
            this["Play" + param2 + "_mc"]["level_1_mc"].gotoAndStop(param1);
            this["Play" + param2 + "_mc"]["level_2_mc"].visible = false;
         }
         else
         {
            this["Play" + param2 + "_mc"]["level_2_mc"].visible = true;
            _loc3_ = param1.toString();
            _loc4_ = int(_loc3_.substring(0,1));
            _loc5_ = int(_loc3_.substring(1,2));
            this["Play" + param2 + "_mc"]["level_1_mc"].gotoAndStop(_loc4_);
            if(_loc5_ == 0)
            {
               this["Play" + param2 + "_mc"]["level_2_mc"].gotoAndStop(10);
            }
            else
            {
               this["Play" + param2 + "_mc"]["level_2_mc"].gotoAndStop(_loc5_);
            }
         }
      }
      
      private function 连击计数() : *
      {
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            if(templianJiNum[0] != Main.player_1.lianJi.getValue() && Main.player_1.lianJi.getValue() != 0)
            {
               templianJiNum[0] = Main.player_1.lianJi.getValue();
               ShowLianJi(1,templianJiNum[0]);
            }
            if(Main.player_1.lianJiTime.getValue() < 60)
            {
               this["Play1_mc"]["LianJi_mc"].visible = true;
            }
            else
            {
               this["Play1_mc"]["LianJi_mc"].visible = false;
            }
         }
         if(Boolean(Main.P1P2) && Boolean(Main.player2) && Boolean(Main.player_2))
         {
            if(templianJiNum[1] != Main.player_2.lianJi.getValue() && Main.player_2.lianJi.getValue() != 0)
            {
               templianJiNum[1] = Main.player_2.lianJi.getValue();
               ShowLianJi(2,templianJiNum[1]);
            }
            if(Main.player_2.lianJiTime.getValue() < 60)
            {
               this["Play2_mc"]["LianJi_mc"].visible = true;
            }
            else
            {
               this["Play2_mc"]["LianJi_mc"].visible = false;
            }
         }
      }
      
      private function ShowLianJi(param1:int, param2:int) : *
      {
         var _loc5_:int = 0;
         this["Play" + param1 + "_mc"]["LianJi_mc"]["A_1"].visible = this["Play" + param1 + "_mc"]["LianJi_mc"]["A_2"].visible = this["Play" + param1 + "_mc"]["LianJi_mc"]["A_3"].visible = this["Play" + param1 + "_mc"]["LianJi_mc"]["A_4"].visible = false;
         var _loc3_:String = String(param2);
         var _loc4_:* = _loc3_.length;
         while(_loc4_)
         {
            _loc5_ = int(_loc3_.substr(_loc4_ - 1,1));
            this["Play" + param1 + "_mc"]["LianJi_mc"]["A_" + _loc4_].visible = true;
            if(_loc5_ == 0 && this["Play" + param1 + "_mc"]["LianJi_mc"]["A_" + _loc4_].currentFrame != 10)
            {
               this["Play" + param1 + "_mc"]["LianJi_mc"]["A_" + _loc4_].gotoAndStop(10);
            }
            else if(this["Play" + param1 + "_mc"]["LianJi_mc"]["A_" + _loc4_].currentFrame != _loc5_)
            {
               this["Play" + param1 + "_mc"]["LianJi_mc"]["A_" + _loc4_].gotoAndStop(_loc5_);
            }
            _loc4_--;
         }
      }
      
      private function Cd计数() : *
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Supplies = null;
         var _loc6_:String = null;
         初始化技能图标();
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            if(Main.player1.skinArr[Main.player1.skinNum] == 0)
            {
               _loc1_ = "a";
            }
            else if(Main.player1.skinArr[Main.player1.skinNum] == 1)
            {
               _loc1_ = "b";
            }
            else
            {
               _loc1_ = "c";
            }
            _loc2_ = 8;
            while(_loc2_ < 16)
            {
               _loc3_ = _loc1_ + String(_loc2_);
               _loc4_ = int(Main.player_1.selCD50(_loc3_));
               Play1_mc["p_" + _loc2_]["X50"].gotoAndStop(_loc4_);
               _loc2_++;
            }
         }
         if(Boolean(Main.player2) && Boolean(Main.player_2))
         {
            if(Main.player2.skinArr[Main.player2.skinNum] == 0)
            {
               _loc1_ = "a";
            }
            else if(Main.player2.skinArr[Main.player2.skinNum] == 1)
            {
               _loc1_ = "b";
            }
            else
            {
               _loc1_ = "c";
            }
            _loc2_ = 8;
            while(_loc2_ < 16)
            {
               _loc3_ = _loc1_ + String(_loc2_);
               _loc4_ = int(Main.player_2.selCD50(_loc3_));
               Play2_mc["p_" + _loc2_]["X50"].gotoAndStop(_loc4_);
               _loc2_++;
            }
         }
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc5_ = Main.player_1.data.getSuppliesSlot().getFromSuppliesSlot(_loc2_);
               if(_loc5_)
               {
                  _loc6_ = _loc5_.getName();
                  _loc4_ = int(Main.player_1.sel_objCD50(_loc6_));
                  Play1_mc["obj_" + _loc2_]["X50"].gotoAndStop(_loc4_);
                  Play1_mc["obj_" + _loc2_]["pic_mc"].gotoAndStop(Main.player1.getSuppliesSlot().getFromSuppliesSlot(_loc2_).getFrame());
                  Play1_mc["obj_" + _loc2_]["num_txt"].text = Main.player1.getSuppliesSlot().getNumFromSuppliesSlot(Main.player1.getBag(),_loc2_);
               }
               _loc2_++;
            }
         }
         if(Boolean(Main.player2) && Boolean(Main.player_2))
         {
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc5_ = Main.player_2.data.getSuppliesSlot().getFromSuppliesSlot(_loc2_);
               if(_loc5_)
               {
                  _loc6_ = _loc5_.getName();
                  _loc4_ = int(Main.player_2.sel_objCD50(_loc6_));
                  Play2_mc["obj_" + _loc2_]["X50"].gotoAndStop(_loc4_);
                  Play2_mc["obj_" + _loc2_]["pic_mc"].gotoAndStop(Main.player2.getSuppliesSlot().getFromSuppliesSlot(_loc2_).getFrame());
                  Play2_mc["obj_" + _loc2_]["num_txt"].text = Main.player2.getSuppliesSlot().getNumFromSuppliesSlot(Main.player2.getBag(),_loc2_);
               }
               _loc2_++;
            }
         }
      }
      
      private function bag_OPEN(param1:*) : *
      {
         ItemsPanel.open();
      }
      
      private function shop_OPEN(param1:*) : *
      {
         Shop4399.Open();
      }
      
      private function 系统菜单关闭(param1:* = null) : *
      {
         file_mc.visible = false;
      }
      
      private function 画质_OPEN(param1:*) : *
      {
         if(Main._stage.quality == StageQuality.HIGH)
         {
            画质_mc.A.gotoAndStop(1);
         }
         else if(Main._stage.quality == StageQuality.MEDIUM)
         {
            画质_mc.B.gotoAndStop(1);
         }
         else if(Main._stage.quality == StageQuality.LOW)
         {
            画质_mc.C.gotoAndStop(1);
         }
      }
      
      private function 画质(param1:MouseEvent) : *
      {
         画质_mc.A.gotoAndStop(2);
         画质_mc.B.gotoAndStop(2);
         画质_mc.C.gotoAndStop(2);
         if(param1.currentTarget.name == "A")
         {
            Main._stage.quality = StageQuality.HIGH;
            画质_mc.A.gotoAndStop(1);
         }
         else if(param1.currentTarget.name == "B")
         {
            Main._stage.quality = StageQuality.MEDIUM;
            画质_mc.B.gotoAndStop(1);
         }
         else if(param1.currentTarget.name == "C")
         {
            Main._stage.quality = StageQuality.LOW;
            画质_mc.C.gotoAndStop(1);
         }
      }
      
      private function File_OPEN(param1:*) : *
      {
         if(file_mc.visible == false)
         {
            file_mc.visible = true;
            file_mc.help_mc.addEventListener(MouseEvent.CLICK,帮助);
            file_mc.key_mc.addEventListener(MouseEvent.CLICK,键位);
            file_mc.save_mc.addEventListener(MouseEvent.CLICK,保存);
            file_mc.city_mc.addEventListener(MouseEvent.CLICK,回城);
         }
         else
         {
            file_mc.visible = false;
         }
      }
      
      private function 帮助(param1:*) : *
      {
         系统菜单关闭();
      }
      
      private function 键位(param1:*) : *
      {
         SetKeyPanel.open();
         系统菜单关闭();
      }
      
      private function 回城(param1:*) : *
      {
         Main.gameNum.setValue(0);
         Main.gameNum2.setValue(0);
         Load.loadGameNum = 1;
         Main._this.Loading();
         Player.一起信春哥();
         系统菜单关闭();
         AchData.gkOk();
         TaskData.isOk();
         WinShow.All_0();
      }
      
      private function 保存(param1:*) : *
      {
         if(saveTime <= 0)
         {
            Main.Save();
            saveTime = 800;
            系统菜单关闭();
            addEventListener(Event.ENTER_FRAME,onTime);
         }
      }
      
      private function onTime(param1:*) : *
      {
         if(saveTime > 0)
         {
            --saveTime;
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,onTime);
         }
         file_mc.time_txt.text = int(saveTime / 27);
      }
      
      private function 画质提示开启(param1:*) : *
      {
         画质提示_mc.x = 430;
         画质提示_mc.y = 60;
      }
      
      private function 画质提示关闭(param1:*) : *
      {
         画质提示_mc.x = 5000;
         画质提示_mc.y = -100;
      }
      
      private function ShopObjTime_Show() : *
      {
         if(InitData.EXPxTime.getValue() > 0)
         {
            EXPxTime_mc.x = EXPxTime_mc.y = 0;
            EXPxTime_mc.t1_txt.text = TimeNum(InitData.EXPxTime.getValue());
         }
         else
         {
            EXPxTime_mc.x = EXPxTime_mc.y = 5000;
         }
         if(InitData.DOWNxTime.getValue() > 0)
         {
            DOWNxTime_mc.x = DOWNxTime_mc.y = 0;
            DOWNxTime_mc.t1_txt.text = TimeNum(InitData.DOWNxTime.getValue());
         }
         else
         {
            DOWNxTime_mc.x = DOWNxTime_mc.y = 5000;
         }
      }
      
      private function TimeNum(param1:int) : String
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:int = param1 / 3600;
         var _loc3_:int = (param1 - _loc2_ * 3600) / 60;
         var _loc4_:int = param1 - _loc2_ * 3600 - _loc3_ * 60;
         if(_loc3_ < 10)
         {
            _loc5_ = "0" + _loc3_;
         }
         else
         {
            _loc5_ = _loc3_;
         }
         if(_loc4_ < 10)
         {
            _loc6_ = "0" + _loc4_;
         }
         else
         {
            _loc6_ = _loc4_;
         }
         return _loc2_ + ":" + _loc5_ + ":" + _loc6_;
      }
      
      private function 滚动提示() : *
      {
         var _loc1_:int = 0;
         ++滚动提示time;
         if(滚动提示time % 135 == 0)
         {
            if(Main.gameNum.getValue() == 0)
            {
               info_mc.x = info_mc.y = 0;
               _loc1_ = Math.random() * infoArr0.length;
               info_mc._txt.text = infoArr0[_loc1_];
            }
            else if(Main.gameNum.getValue() == 1 && Main.gameNum2.getValue() != 5)
            {
               info_mc.x = info_mc.y = 0;
               _loc1_ = Math.random() * infoArr1.length;
               info_mc._txt.text = infoArr1[_loc1_];
            }
            else
            {
               info_mc.x = info_mc.y = 5000;
            }
         }
      }
      
      private function 任务面板(param1:*) : *
      {
         TaskPanel.open();
      }
      
      private function CW面板(param1:*) : *
      {
         PetPanel.open();
      }
   }
}

