package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.petPanel.*;
   import com.hotpoint.braveManIII.views.playerTaskPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
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
         super();
         info_mc.mouseChildren = info_mc.mouseEnabled = false;
         this.初始化技能图标();
         addEventListener(Event.ENTER_FRAME,this.onENTER_FRAME);
         Xbag_mc.addEventListener(MouseEvent.CLICK,this.bag_OPEN);
         Xfile_mc.addEventListener(MouseEvent.CLICK,this.File_OPEN);
         Xshop_mc.addEventListener(MouseEvent.CLICK,this.shop_OPEN);
         画质_mc.addEventListener(MouseEvent.MOUSE_MOVE,this.画质提示开启);
         画质_mc.addEventListener(MouseEvent.MOUSE_OUT,this.画质提示关闭);
         画质_mc.A.addEventListener(MouseEvent.CLICK,this.画质);
         画质_mc.B.addEventListener(MouseEvent.CLICK,this.画质);
         画质_mc.C.addEventListener(MouseEvent.CLICK,this.画质);
         画质_mc.A.gotoAndStop(1);
         画质_mc.B.gotoAndStop(2);
         画质_mc.C.gotoAndStop(2);
         file_mc.addEventListener(MouseEvent.ROLL_OUT,this.系统菜单关闭);
         file_mc.visible = false;
         gameStop_btn.addEventListener(MouseEvent.MOUSE_DOWN,this.游戏暂停);
         renWuXX_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.任务面板);
         CW_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.CW面板);
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!interfaceX)
         {
            interfaceX = new Play_Interface();
         }
         Main._stage.addChild(interfaceX);
         interfaceX.x = xx;
         interfaceX.y = yy;
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
      
      public static function WhoIsBoss(e:Enemy) : *
      {
         bossIS = e;
      }
      
      private function 游戏暂停(e:*) : *
      {
         var g:GameStop = new GameStop();
      }
      
      private function onENTER_FRAME(e:*) : *
      {
         this.Boss血条();
         this.玩家状态();
         this.连击计数();
         this.Cd计数();
         this.怪物技能计数();
         this.滚动提示();
         this.ShopObjTime_Show();
      }
      
      private function 初始化技能图标() : *
      {
         var s:String = "";
         if(Main.player1.skinArr[Main.player1.skinNum] == 0)
         {
            s = "a";
         }
         else if(Main.player1.skinArr[Main.player1.skinNum] == 1)
         {
            s = "b";
         }
         else
         {
            s = "c";
         }
         for(i = 8; i < 16; ++i)
         {
            Play1_mc["p_" + i]["p_mc"].gotoAndStop(s + "" + i);
         }
         if(Boolean(Main.player2) && Boolean(Main.player_2))
         {
            if(Main.player2.skinArr[Main.player2.skinNum] == 0)
            {
               s = "a";
            }
            else if(Main.player2.skinArr[Main.player2.skinNum] == 1)
            {
               s = "b";
            }
            else
            {
               s = "c";
            }
            for(i = 8; i < 16; ++i)
            {
               Play2_mc["p_" + i]["p_mc"].gotoAndStop(s + "" + i);
            }
         }
      }
      
      private function Boss血条() : *
      {
         var bossLifeXX:int = 0;
         if(Boolean(bossIS) && BossLifeYN)
         {
            BossLife_mc.visible = true;
            BossLife_mc.touXiang.gotoAndStop("a" + bossIS.id);
            bossLifeXX = 100 - bossIS.life.getValue() / bossIS.lifeMAX.getValue() * 100;
            BossLife_mc.gotoAndStop(bossLifeXX);
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
         var hp:int = 0;
         var hpMax:int = 0;
         var mp:int = 0;
         var mpMax:int = 0;
         var exp:int = 0;
         var expMax:int = 0;
         var hpNum:int = 0;
         var mpNum:int = 0;
         var lv:int = 0;
         var expXX:int = 0;
         var headX:int = 0;
         Play2_mc.head_mc.visible = false;
         if(Main.player_1)
         {
            hp = Math.round(Main.player_1.hp.getValue());
            hpMax = Math.round(Main.player_1.use_hp_Max.getValue());
            mp = int(Main.player_1.mp.getValue());
            mpMax = int(Main.player_1.use_mp_Max.getValue());
            exp = int(Main.player_1.data.getEXP());
            expMax = int(Main.player_1.nextExp.getValue());
            hpNum = 100 - hp / hpMax * 100;
            mpNum = 100 - mp / mpMax * 100;
            lv = int(Main.player_1.data.getLevel());
            expXX = Main.player_1.data.getEXP() / Main.player_1.nextExp.getValue() * 100;
            headX = int(Main.player_1.headFrame);
            if(mp == 1)
            {
               mp = 0;
            }
            Play1_mc.hp_txt.text = hp + "/" + hpMax;
            Play1_mc.mp_txt.text = mp + "/" + mpMax;
            Play1_mc.exp_txt.text = exp + "/" + expMax;
            Play1_mc.hp_mc.load_mc.scaleX = 1 - hpNum / 100;
            Play1_mc.mp_mc.load_mc.scaleX = 1 - mpNum / 100;
            this.showLV(lv,1);
            Play1_mc.exp_mc.gotoAndStop(expXX);
            Play1_mc.head_mc.gotoAndStop(headX);
         }
         if(Main.P1P2)
         {
            hp = Math.round(Main.player_2.hp.getValue());
            hpMax = Math.round(Main.player_2.use_hp_Max.getValue());
            mp = int(Main.player_2.mp.getValue());
            mpMax = int(Main.player_2.use_mp_Max.getValue());
            exp = int(Main.player_2.data.getEXP());
            expMax = int(Main.player_2.nextExp.getValue());
            hpNum = 100 - hp / hpMax * 100;
            mpNum = 100 - mp / mpMax * 100;
            lv = int(Main.player_2.data.getLevel());
            expXX = Main.player_2.data.getEXP() / Main.player_2.nextExp.getValue() * 100;
            headX = int(Main.player_2.headFrame);
            if(mp == 1)
            {
               mp = 0;
            }
            Play2_mc.hp_txt.text = hp + "/" + hpMax;
            Play2_mc.mp_txt.text = mp + "/" + mpMax;
            Play2_mc.exp_txt.text = exp + "/" + expMax;
            Play2_mc.hp_mc.load_mc.scaleX = 1 - hpNum / 100;
            Play2_mc.mp_mc.load_mc.scaleX = 1 - mpNum / 100;
            this.showLV(lv,2);
            Play2_mc.exp_mc.gotoAndStop(expXX);
            Play2_mc.head_mc.gotoAndStop(headX);
            Play2_mc.head_mc.visible = true;
         }
         if(!Main.P1P2 && Boolean(Play2_mc.visible))
         {
            Play2_mc.visible = false;
         }
      }
      
      private function showLV(level:Number, p1p2:int) : *
      {
         var str:String = null;
         var left:int = 0;
         var right:int = 0;
         if(level < 10)
         {
            this["Play" + p1p2 + "_mc"]["level_1_mc"].gotoAndStop(level);
            this["Play" + p1p2 + "_mc"]["level_2_mc"].visible = false;
         }
         else
         {
            this["Play" + p1p2 + "_mc"]["level_2_mc"].visible = true;
            str = level.toString();
            left = int(str.substring(0,1));
            right = int(str.substring(1,2));
            this["Play" + p1p2 + "_mc"]["level_1_mc"].gotoAndStop(left);
            if(right == 0)
            {
               this["Play" + p1p2 + "_mc"]["level_2_mc"].gotoAndStop(10);
            }
            else
            {
               this["Play" + p1p2 + "_mc"]["level_2_mc"].gotoAndStop(right);
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
               this.ShowLianJi(1,templianJiNum[0]);
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
               this.ShowLianJi(2,templianJiNum[1]);
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
      
      private function ShowLianJi(who:int, num:int) : *
      {
         var ii:int = 0;
         this["Play" + who + "_mc"]["LianJi_mc"]["A_1"].visible = this["Play" + who + "_mc"]["LianJi_mc"]["A_2"].visible = this["Play" + who + "_mc"]["LianJi_mc"]["A_3"].visible = this["Play" + who + "_mc"]["LianJi_mc"]["A_4"].visible = false;
         var str:String = String(num);
         var i:* = str.length;
         while(i)
         {
            ii = int(str.substr(i - 1,1));
            this["Play" + who + "_mc"]["LianJi_mc"]["A_" + i].visible = true;
            if(ii == 0 && this["Play" + who + "_mc"]["LianJi_mc"]["A_" + i].currentFrame != 10)
            {
               this["Play" + who + "_mc"]["LianJi_mc"]["A_" + i].gotoAndStop(10);
            }
            else if(this["Play" + who + "_mc"]["LianJi_mc"]["A_" + i].currentFrame != ii)
            {
               this["Play" + who + "_mc"]["LianJi_mc"]["A_" + i].gotoAndStop(ii);
            }
            i--;
         }
      }
      
      private function Cd计数() : *
      {
         var s:String = null;
         var i:int = 0;
         var str:String = null;
         var num:int = 0;
         var xx:Supplies = null;
         var name:String = null;
         this.初始化技能图标();
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            if(Main.player1.skinArr[Main.player1.skinNum] == 0)
            {
               s = "a";
            }
            else if(Main.player1.skinArr[Main.player1.skinNum] == 1)
            {
               s = "b";
            }
            else
            {
               s = "c";
            }
            for(i = 8; i < 16; i++)
            {
               str = s + String(i);
               num = int(Main.player_1.selCD50(str));
               Play1_mc["p_" + i]["X50"].gotoAndStop(num);
            }
         }
         if(Boolean(Main.player2) && Boolean(Main.player_2))
         {
            if(Main.player2.skinArr[Main.player2.skinNum] == 0)
            {
               s = "a";
            }
            else if(Main.player2.skinArr[Main.player2.skinNum] == 1)
            {
               s = "b";
            }
            else
            {
               s = "c";
            }
            for(i = 8; i < 16; i++)
            {
               str = s + String(i);
               num = int(Main.player_2.selCD50(str));
               Play2_mc["p_" + i]["X50"].gotoAndStop(num);
            }
         }
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            for(i = 0; i < 3; i++)
            {
               xx = Main.player_1.data.getSuppliesSlot().getFromSuppliesSlot(i);
               if(xx)
               {
                  name = xx.getName();
                  num = int(Main.player_1.sel_objCD50(name));
                  Play1_mc["obj_" + i]["X50"].gotoAndStop(num);
                  Play1_mc["obj_" + i]["pic_mc"].gotoAndStop(Main.player1.getSuppliesSlot().getFromSuppliesSlot(i).getFrame());
                  Play1_mc["obj_" + i]["num_txt"].text = Main.player1.getSuppliesSlot().getNumFromSuppliesSlot(Main.player1.getBag(),i);
               }
            }
         }
         if(Boolean(Main.player2) && Boolean(Main.player_2))
         {
            for(i = 0; i < 3; i++)
            {
               xx = Main.player_2.data.getSuppliesSlot().getFromSuppliesSlot(i);
               if(xx)
               {
                  name = xx.getName();
                  num = int(Main.player_2.sel_objCD50(name));
                  Play2_mc["obj_" + i]["X50"].gotoAndStop(num);
                  Play2_mc["obj_" + i]["pic_mc"].gotoAndStop(Main.player2.getSuppliesSlot().getFromSuppliesSlot(i).getFrame());
                  Play2_mc["obj_" + i]["num_txt"].text = Main.player2.getSuppliesSlot().getNumFromSuppliesSlot(Main.player2.getBag(),i);
               }
            }
         }
      }
      
      private function bag_OPEN(e:*) : *
      {
         ItemsPanel.open();
      }
      
      private function shop_OPEN(e:*) : *
      {
         Shop4399.Open();
      }
      
      private function 系统菜单关闭(e:* = null) : *
      {
         file_mc.visible = false;
      }
      
      private function 画质_OPEN(e:*) : *
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
      
      private function 画质(e:MouseEvent) : *
      {
         画质_mc.A.gotoAndStop(2);
         画质_mc.B.gotoAndStop(2);
         画质_mc.C.gotoAndStop(2);
         if(e.currentTarget.name == "A")
         {
            Main._stage.quality = StageQuality.HIGH;
            画质_mc.A.gotoAndStop(1);
         }
         else if(e.currentTarget.name == "B")
         {
            Main._stage.quality = StageQuality.MEDIUM;
            画质_mc.B.gotoAndStop(1);
         }
         else if(e.currentTarget.name == "C")
         {
            Main._stage.quality = StageQuality.LOW;
            画质_mc.C.gotoAndStop(1);
         }
      }
      
      private function File_OPEN(e:*) : *
      {
         if(file_mc.visible == false)
         {
            file_mc.visible = true;
            file_mc.help_mc.addEventListener(MouseEvent.CLICK,this.帮助);
            file_mc.key_mc.addEventListener(MouseEvent.CLICK,this.键位);
            file_mc.save_mc.addEventListener(MouseEvent.CLICK,this.保存);
            file_mc.city_mc.addEventListener(MouseEvent.CLICK,this.回城);
         }
         else
         {
            file_mc.visible = false;
         }
      }
      
      private function 帮助(e:*) : *
      {
         this.系统菜单关闭();
      }
      
      private function 键位(e:*) : *
      {
         SetKeyPanel.open();
         this.系统菜单关闭();
      }
      
      private function 回城(e:*) : *
      {
         PlayerTaskData.addTaskData();
         Main.gameNum = Main.gameNum2 = 0;
         Load.loadGameNum = 1;
         Main._this.Loading();
         Player.一起信春哥();
         this.系统菜单关闭();
         AchData.gkOk();
         WinShow.All_0();
      }
      
      private function 保存(e:*) : *
      {
         if(this.saveTime <= 0)
         {
            Main.Save();
            this.saveTime = 800;
            this.系统菜单关闭();
            addEventListener(Event.ENTER_FRAME,this.onTime);
         }
      }
      
      private function onTime(e:*) : *
      {
         if(this.saveTime > 0)
         {
            --this.saveTime;
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.onTime);
         }
         file_mc.time_txt.text = int(this.saveTime / 27);
      }
      
      private function 画质提示开启(e:*) : *
      {
         画质提示_mc.x = 430;
         画质提示_mc.y = 60;
      }
      
      private function 画质提示关闭(e:*) : *
      {
         画质提示_mc.x = 5000;
         画质提示_mc.y = -100;
      }
      
      private function ShopObjTime_Show() : *
      {
         if(InitData.EXPxTime.getValue() > 0)
         {
            EXPxTime_mc.x = EXPxTime_mc.y = 0;
            EXPxTime_mc.t1_txt.text = this.TimeNum(InitData.EXPxTime.getValue());
         }
         else
         {
            EXPxTime_mc.x = EXPxTime_mc.y = 5000;
         }
         if(InitData.DOWNxTime.getValue() > 0)
         {
            DOWNxTime_mc.x = DOWNxTime_mc.y = 0;
            DOWNxTime_mc.t1_txt.text = this.TimeNum(InitData.DOWNxTime.getValue());
         }
         else
         {
            DOWNxTime_mc.x = DOWNxTime_mc.y = 5000;
         }
      }
      
      private function TimeNum(num:int) : String
      {
         var str2:String = null;
         var str3:String = null;
         var t1:int = num / 3600;
         var t2:int = (num - t1 * 3600) / 60;
         var t3:int = num - t1 * 3600 - t2 * 60;
         if(t2 < 10)
         {
            str2 = "0" + t2;
         }
         else
         {
            str2 = t2;
         }
         if(t3 < 10)
         {
            str3 = "0" + t3;
         }
         else
         {
            str3 = t3;
         }
         return t1 + ":" + str2 + ":" + str3;
      }
      
      private function 滚动提示() : *
      {
         var i:int = 0;
         ++this.滚动提示time;
         if(this.滚动提示time % 135 == 0)
         {
            if(Main.gameNum == 0)
            {
               info_mc.x = info_mc.y = 0;
               i = Math.random() * this.infoArr0.length;
               info_mc._txt.text = this.infoArr0[i];
            }
            else if(Main.gameNum == 1 && Main.gameNum2 != 5)
            {
               info_mc.x = info_mc.y = 0;
               i = Math.random() * this.infoArr1.length;
               info_mc._txt.text = this.infoArr1[i];
            }
            else
            {
               info_mc.x = info_mc.y = 5000;
            }
         }
      }
      
      private function 任务面板(e:*) : *
      {
         PlayerTaskPanel.open();
      }
      
      private function CW面板(e:*) : *
      {
         PetPanel.open();
      }
   }
}

