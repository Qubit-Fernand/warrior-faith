package src
{
   import com.*;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class Play_Interface extends MovieClip
   {
      
      public static var Xfile_YN:Boolean;
      
      public static var bossID:String;
      
      public static var bossIS:Enemy;
      
      public static var BossLifeYN:Boolean;
      
      public static var interfaceX:Play_Interface;
      
      public static var templianJiNum:Array = [0,0];
      
      private var saveTime:int = 0;
      
      public function Play_Interface()
      {
         super();
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
         renWu.visible = false;
         gameStop_btn.addEventListener(MouseEvent.MOUSE_DOWN,游戏暂停);
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
      }
      
      private function 退出(e:*) : *
      {
         navigateToURL(new URLRequest("javascript:location.reload();"),"_self");
         系统菜单关闭();
      }
      
      private function shop_OPEN(e:*) : *
      {
         Shop4399.Open();
      }
      
      private function File_OPEN(e:*) : *
      {
         if(file_mc.visible == false)
         {
            file_mc.visible = true;
            file_mc.help_mc.addEventListener(MouseEvent.CLICK,帮助);
            file_mc.key_mc.addEventListener(MouseEvent.CLICK,键位);
            file_mc.city_mc.addEventListener(MouseEvent.CLICK,回城);
            file_mc.save_mc.addEventListener(MouseEvent.CLICK,保存);
            file_mc.back_mc.addEventListener(MouseEvent.CLICK,退出);
         }
         else
         {
            file_mc.visible = false;
         }
      }
      
      private function 保存(e:*) : *
      {
         if(saveTime <= 0)
         {
            Main.Save();
            saveTime = 800;
            系统菜单关闭();
            addEventListener(Event.ENTER_FRAME,onTime);
         }
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
      
      private function 怪物技能计数() : *
      {
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            this.Play1_mc.guaiWu.gotoAndStop(Main.player_1.energySlot.getEnergyPer(Main.player_1));
         }
         if(Boolean(Main.P1P2) && Boolean(Main.player2) && Boolean(Main.player_2))
         {
            this.Play2_mc.guaiWu.gotoAndStop(Main.player_2.energySlot.getEnergyPer(Main.player_2));
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
         初始化技能图标();
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
      
      private function 游戏暂停(e:*) : *
      {
         var g:GameStop = null;
         g = new GameStop();
      }
      
      private function 帮助(e:*) : *
      {
         系统菜单关闭();
      }
      
      private function bag_OPEN(e:*) : *
      {
         ItemsPanel.open();
      }
      
      private function onTime(e:*) : *
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
      
      private function TimeNum(num:int) : String
      {
         var t1:int = 0;
         var t2:int = 0;
         var t3:int = 0;
         var str2:String = null;
         var str3:String = null;
         var str:String = null;
         t1 = num / 3600;
         t2 = (num - t1 * 3600) / 60;
         t3 = num - t1 * 3600 - t2 * 60;
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
      
      private function Boss血条() : *
      {
         var bossISXX:int = 0;
         if(BossLifeYN)
         {
            BossLife_mc.visible = true;
            BossLife_mc.touXiang.gotoAndStop(bossID);
            bossISXX = 100 - bossIS.life / bossIS.lifeMAX * 100;
            BossLife_mc.gotoAndStop(bossISXX);
         }
         else
         {
            BossLife_mc.visible = false;
         }
      }
      
      private function 画质提示关闭(e:*) : *
      {
         画质提示_mc.x = 5000;
         画质提示_mc.y = -100;
      }
      
      private function 初始化技能图标() : *
      {
         var s:String = null;
         s = "";
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
      
      private function 回城(e:*) : *
      {
         Main.gameNum = Main.gameNum2 = 0;
         Main._this.Loading();
         Player.一起信春哥();
         系统菜单关闭();
         WinShow.All_0();
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
            if(Main.player_1.lianJiTime < 60)
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
            if(Main.player_2.lianJiTime < 60)
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
         var str:String = null;
         var i:* = 0;
         var ii:int = 0;
         this["Play" + who + "_mc"]["LianJi_mc"]["A_1"].visible = this["Play" + who + "_mc"]["LianJi_mc"]["A_2"].visible = this["Play" + who + "_mc"]["LianJi_mc"]["A_3"].visible = this["Play" + who + "_mc"]["LianJi_mc"]["A_4"].visible = false;
         str = String(num);
         i = str.length;
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
      
      private function onENTER_FRAME(e:*) : *
      {
         Boss血条();
         玩家状态();
         连击计数();
         Cd计数();
         怪物技能计数();
         ShopObjTime_Show();
      }
      
      private function 系统菜单关闭(e:* = null) : *
      {
         file_mc.visible = false;
      }
      
      private function 键位(e:*) : *
      {
         SetKeyPanel.open();
         系统菜单关闭();
      }
      
      private function 画质提示开启(e:*) : *
      {
         画质提示_mc.x = 430;
         画质提示_mc.y = 60;
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
         if(Main.player_1)
         {
            hp = int(Main.player_1.hp.getValue());
            hpMax = int(Main.player_1.use_hp_Max.getValue());
            mp = int(Main.player_1.mp.getValue());
            mpMax = int(Main.player_1.use_mp_Max.getValue());
            exp = int(Main.player_1.data.Exp.getValue());
            expMax = int(Main.player_1.nextExp.getValue());
            hpNum = 100 - hp / hpMax * 100;
            mpNum = 100 - mp / mpMax * 100;
            lv = int(Main.player_1.data.getLevel());
            expXX = Main.player_1.data.getEXP() / Main.player_1.nextExp.getValue() * 100;
            Play1_mc.hp_txt.text = hp + " / " + hpMax;
            Play1_mc.mp_txt.text = mp + " / " + mpMax;
            Play1_mc.exp_txt.text = exp + " / " + expMax;
            Play1_mc.hp_mc.gotoAndStop(hpNum);
            Play1_mc.mp_mc.gotoAndStop(mpNum);
            Play1_mc.lv_txt.text = "lv." + lv;
            Play1_mc.exp_mc.gotoAndStop(expXX);
         }
         if(Main.P1P2)
         {
            hp = int(Main.player_2.hp.getValue());
            hpMax = int(Main.player_2.use_hp_Max.getValue());
            mp = int(Main.player_2.mp.getValue());
            mpMax = int(Main.player_2.use_mp_Max.getValue());
            exp = int(Main.player_2.data.Exp.getValue());
            expMax = int(Main.player_2.nextExp.getValue());
            hpNum = 100 - hp / hpMax * 100;
            mpNum = 100 - mp / mpMax * 100;
            lv = int(Main.player_2.data.getLevel());
            expXX = Main.player_2.data.getEXP() / Main.player_2.nextExp.getValue() * 100;
            Play2_mc.hp_txt.text = hp + " / " + hpMax;
            Play2_mc.mp_txt.text = mp + " / " + mpMax;
            Play2_mc.exp_txt.text = exp + " / " + expMax;
            Play2_mc.hp_mc.gotoAndStop(hpNum);
            Play2_mc.mp_mc.gotoAndStop(mpNum);
            Play2_mc.lv_txt.text = "lv." + lv;
            Play2_mc.exp_mc.gotoAndStop(expXX);
         }
         if(!Main.P1P2 && Boolean(Play2_mc.visible))
         {
            Play2_mc.visible = false;
         }
      }
   }
}

