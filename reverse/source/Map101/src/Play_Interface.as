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
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         if(!interfaceX)
         {
            interfaceX = new Play_Interface();
         }
         Main._stage.addChild(interfaceX);
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
      }
      
      private function 退出(param1:*) : *
      {
         navigateToURL(new URLRequest("javascript:location.reload();"),"_self");
         系统菜单关闭();
      }
      
      private function shop_OPEN(param1:*) : *
      {
      }
      
      private function File_OPEN(param1:*) : *
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
      
      private function 游戏暂停(param1:*) : *
      {
         var _loc2_:GameStop = null;
         _loc2_ = new GameStop();
      }
      
      private function 帮助(param1:*) : *
      {
         系统菜单关闭();
      }
      
      private function bag_OPEN(param1:*) : *
      {
         ItemsPanel.open();
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
      
      private function Boss血条() : *
      {
         var _loc1_:int = 0;
         if(BossLifeYN)
         {
            BossLife_mc.visible = true;
            BossLife_mc.touXiang.gotoAndStop(bossID);
            _loc1_ = 100 - bossIS.life / bossIS.lifeMAX * 100;
            BossLife_mc.gotoAndStop(_loc1_);
         }
         else
         {
            BossLife_mc.visible = false;
         }
      }
      
      private function 初始化技能图标() : *
      {
         var _loc1_:String = null;
         _loc1_ = "";
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
      
      private function 回城(param1:*) : *
      {
         Main.gameNum = Main.gameNum2 = 0;
         Main._this.Loading();
         Player.一起信春哥();
         系统菜单关闭();
      }
      
      private function 连击计数() : *
      {
         if(Boolean(Main.player1) && Boolean(Main.player_1))
         {
            if(templianJiNum[0] != Main.player_1.lianJi && Main.player_1.lianJi != 0)
            {
               templianJiNum[0] = Main.player_1.lianJi;
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
            if(templianJiNum[1] != Main.player_2.lianJi && Main.player_2.lianJi != 0)
            {
               templianJiNum[1] = Main.player_2.lianJi;
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
      
      private function ShowLianJi(param1:int, param2:int) : *
      {
         var _loc3_:String = null;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         this["Play" + param1 + "_mc"]["LianJi_mc"]["A_1"].visible = this["Play" + param1 + "_mc"]["LianJi_mc"]["A_2"].visible = this["Play" + param1 + "_mc"]["LianJi_mc"]["A_3"].visible = this["Play" + param1 + "_mc"]["LianJi_mc"]["A_4"].visible = false;
         _loc3_ = String(param2);
         _loc4_ = _loc3_.length;
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
      
      private function onENTER_FRAME(param1:*) : *
      {
         Boss血条();
         玩家状态();
         连击计数();
         Cd计数();
         怪物技能计数();
      }
      
      private function 系统菜单关闭(param1:* = null) : *
      {
         file_mc.visible = false;
      }
      
      private function 键位(param1:*) : *
      {
         SetKeyPanel.open();
         系统菜单关闭();
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
         if(Main.player_1)
         {
            _loc1_ = int(Main.player_1.hp.getValue());
            _loc2_ = int(Main.player_1.use_hp_Max.getValue());
            _loc3_ = int(Main.player_1.mp.getValue());
            _loc4_ = int(Main.player_1.use_mp_Max.getValue());
            _loc5_ = 100 - _loc1_ / _loc2_ * 100;
            _loc6_ = 100 - _loc3_ / _loc4_ * 100;
            _loc7_ = int(Main.player_1.data.getLevel());
            _loc8_ = Main.player_1.data.getEXP() / Main.player_1.nextExp.getValue() * 100;
            Play1_mc.hp_txt.text = _loc1_ + " / " + _loc2_;
            Play1_mc.mp_txt.text = _loc3_ + " / " + _loc4_;
            Play1_mc.hp_mc.gotoAndStop(_loc5_);
            Play1_mc.mp_mc.gotoAndStop(_loc6_);
            Play1_mc.lv_txt.text = "lv." + _loc7_;
            Play1_mc.exp_mc.gotoAndStop(_loc8_);
         }
         if(Main.P1P2)
         {
            _loc1_ = int(Main.player_2.hp.getValue());
            _loc2_ = int(Main.player_2.use_hp_Max.getValue());
            _loc3_ = int(Main.player_2.mp.getValue());
            _loc4_ = int(Main.player_2.use_mp_Max.getValue());
            _loc5_ = 100 - _loc1_ / _loc2_ * 100;
            _loc6_ = 100 - _loc3_ / _loc4_ * 100;
            _loc7_ = int(Main.player_2.data.getLevel());
            _loc8_ = Main.player_2.data.getEXP() / Main.player_2.nextExp.getValue() * 100;
            Play2_mc.hp_txt.text = _loc1_ + " / " + _loc2_;
            Play2_mc.mp_txt.text = _loc3_ + " / " + _loc4_;
            Play2_mc.hp_mc.gotoAndStop(_loc5_);
            Play2_mc.mp_mc.gotoAndStop(_loc6_);
            Play2_mc.lv_txt.text = "lv." + _loc7_;
            Play2_mc.exp_mc.gotoAndStop(_loc8_);
         }
         if(!Main.P1P2 && Boolean(Play2_mc.visible))
         {
            Play2_mc.visible = false;
         }
      }
   }
}

