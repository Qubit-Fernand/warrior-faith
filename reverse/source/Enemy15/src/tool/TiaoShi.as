package src.tool
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.equip.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.quest.*;
   import com.hotpoint.braveManIII.repository.supplies.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   import src._data.*;
   
   public class TiaoShi extends MovieClip
   {
      
      public static var tempVar:String;
      
      public static var time222:VT = VT.createVT();
      
      public static var arrccc:Array = [];
      
      private var urlLoader:URLLoader = new URLLoader();
      
      private var phpUrl:URLRequest = new URLRequest("http://huodong2.4399.com/2012/liwu/liwu.php");
      
      public function TiaoShi()
      {
         super();
         if(Main.tianShiYN != true)
         {
            this.x = this.y = -5000;
            this.visible = false;
            return;
         }
         if(Main.NoLog)
         {
            JieChu_txt.text = "已锁定";
         }
         else
         {
            JieChu_txt.text = "未锁定";
         }
         this.x = this.y = 0;
         get_1_btn.addEventListener(MouseEvent.CLICK,GetP1Obj);
         get_2_btn.addEventListener(MouseEvent.CLICK,GetP2Obj);
         Op_btn.addEventListener(MouseEvent.CLICK,OP);
         KaiQi_btn.addEventListener(MouseEvent.CLICK,KaiQi);
         KaiQi_All_btn.addEventListener(MouseEvent.CLICK,KaiQiAll);
         P1_btn.addEventListener(MouseEvent.CLICK,P1_ZhuangTai);
         P2_btn.addEventListener(MouseEvent.CLICK,P2_ZhuangTai);
         tet_btn.addEventListener(MouseEvent.CLICK,Txt_show);
         sysTime_btn.addEventListener(MouseEvent.CLICK,sysTime);
         buy1.addEventListener(MouseEvent.CLICK,BuyOpenNum);
         buy2.addEventListener(MouseEvent.CLICK,BuyOpenNum);
         buy3.addEventListener(MouseEvent.CLICK,BuyOpenNum);
         buy4.addEventListener(MouseEvent.CLICK,BuyOpenNum);
         name_btn.addEventListener(MouseEvent.CLICK,NewName);
         JieChu_btn.addEventListener(MouseEvent.CLICK,JieChu_Fun);
         ChongWu1_btn.addEventListener(MouseEvent.CLICK,CW_Fun1);
         ChongWu2_btn.addEventListener(MouseEvent.CLICK,CW_Fun2);
         ChongWu_close1_btn.addEventListener(MouseEvent.CLICK,CW_Fun1_C);
         ChongWu_close2_btn.addEventListener(MouseEvent.CLICK,CW_Fun2_C);
         X61_btn.addEventListener(MouseEvent.CLICK,XX61Fun);
      }
      
      private function OP(e:*) : *
      {
         if(this.x == 880)
         {
            this.x = this.y = 0;
         }
         else
         {
            this.x = 880;
            this.y = 520;
         }
      }
      
      private function GetP1Obj(e:*) : *
      {
         if(get_1_txt.text != -1)
         {
            Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(int(get_1_txt.text)));
         }
         if(get_2_txt.text != -1)
         {
            Main.player_1.data.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(int(get_2_txt.text)));
         }
         if(get_3_txt.text != -1)
         {
            Main.player_1.data.getBag().addGemBag(GemFactory.creatGemById(int(get_3_txt.text)));
         }
         if(get_4_txt.text != -1)
         {
            Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(int(get_4_txt.text)));
         }
         if(get_5_txt.text != -1)
         {
            Main.player_1.data.getBag().addQuestBag(QuestFactory.creatQust(int(get_5_txt.text)));
         }
      }
      
      private function GetP2Obj(e:*) : *
      {
         if(!Main.P1P2)
         {
            return;
         }
         if(get_1_txt.text != -1)
         {
            Main.player_2.data.getBag().addEquipBag(EquipFactory.createEquipByID(int(get_1_txt.text)));
         }
         if(get_2_txt.text != -1)
         {
            Main.player_2.data.getBag().addSuppliesBag(SuppliesFactory.getSuppliesById(int(get_2_txt.text)));
         }
         if(get_3_txt.text != -1)
         {
            Main.player_2.data.getBag().addGemBag(GemFactory.creatGemById(int(get_3_txt.text)));
         }
         if(get_4_txt.text != -1)
         {
            Main.player_2.data.getBag().addOtherobjBag(OtherFactory.creatOther(int(get_4_txt.text)));
         }
         if(get_5_txt.text != -1)
         {
            Main.player_2.data.getBag().addQuestBag(QuestFactory.creatQust(int(get_5_txt.text)));
         }
      }
      
      private function KaiQiAll(e:*) : *
      {
         for(var i:int = 0; i < 150; i++)
         {
            Main.guanKa[i] = int(GuanKa2_txt.text);
         }
      }
      
      private function KaiQi(e:*) : *
      {
         Main.guanKa[int(GuanKa1_txt.text)] = int(GuanKa2_txt.text);
      }
      
      private function P1_ZhuangTai(e:*) : *
      {
         if(int(p1_txt.text) != -1)
         {
            Main.player_1.data.setLevel(int(p1_txt.text));
         }
         if(int(p2_txt.text) != -1)
         {
            Main.player_1.data.AddKillPoint(int(p2_txt.text));
         }
         if(int(p3_txt.text) != -1)
         {
            Main.player_1.MoneyUP(int(p3_txt.text));
         }
         if(int(p4_txt.text) != -1)
         {
            Main.player_1.data.addPoint(int(p4_txt.text));
         }
         if(int(p5_txt.text) != -1)
         {
            Enemy.gongJiPOWER.setValue(int(p5_txt.text));
         }
         if(int(p6_txt.text) != -1)
         {
            Main.player_1.fangYuPOWER.setValue(int(p6_txt.text));
         }
         if(int(p7_txt.text) != -1)
         {
            Main.player_1.ExpUP(int(p7_txt.text),2);
         }
      }
      
      private function P2_ZhuangTai(e:*) : *
      {
         if(!Main.P1P2)
         {
            return;
         }
         if(int(p1_txt.text) != -1)
         {
            Main.player_2.data.setLevel(int(p1_txt.text));
         }
         if(int(p2_txt.text) != -1)
         {
            Main.player_2.data.AddKillPoint(int(p2_txt.text));
         }
         if(int(p3_txt.text) != -1)
         {
            Main.player_2.MoneyUP(int(p3_txt.text));
         }
         if(int(p4_txt.text) != -1)
         {
            Main.player_2.data.addPoint(int(p4_txt.text));
         }
         if(int(p5_txt.text) != -1)
         {
            Enemy.gongJiPOWER.setValue(int(p5_txt.text));
         }
         if(int(p6_txt.text) != -1)
         {
            Main.player_2.fangYuPOWER.setValue(int(p6_txt.text));
         }
         if(int(p7_txt.text) != -1)
         {
            Main.player_2.ExpUP(int(p7_txt.text),2);
         }
      }
      
      private function Txt_show(e:*) : *
      {
         temp_txt.text = "";
         if(int(type_txt.text) == 1)
         {
            ShowInfo();
         }
      }
      
      private function sysTime(e:*) : *
      {
         if(int(sysTime_txt.text) != -1)
         {
            Main.serverTime.setValue(int(sysTime_txt.text));
         }
      }
      
      private function BuyOpenNum(e:MouseEvent) : *
      {
         ShopKillPoint.KaiQiShopArr2[0] = 0;
         var i:int = int((e.target.name as String).substr(3,1));
         if(ShopKillPoint.KaiQiShopArr2[i] == true)
         {
            ShopKillPoint.KaiQiShopArr2[i] = false;
            ShopKillPoint.shopX["shopX_" + i]["skin"].visible = true;
         }
         else
         {
            ShopKillPoint.KaiQiShopArr2[i] = true;
            ShopKillPoint.shopX["shopX_" + i]["skin"].visible = false;
         }
      }
      
      private function NewName(e:*) : *
      {
         if(name_txt.text != -1)
         {
            Main.logName = name_txt.text;
            Main.logNameSave = "";
         }
         if(var_txt.text != -1)
         {
            Main.varX = int(var_txt.text);
         }
         Main.Save();
      }
      
      private function JieChu_Fun(e:*) : *
      {
         Main.logName = Main.logName;
         Main.logNameSave = "";
         Main.varX = 0;
         Main.NoLog = 0;
         Main.NoLogInfo[2] = 0;
         Main.Save();
      }
      
      private function CW_Fun1(e:*) : *
      {
         Main.player_1.playerCW = null;
         Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(73101));
         Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(73500));
      }
      
      private function CW_Fun2(e:*) : *
      {
         Main.player_2.playerCW = null;
         Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(73101));
         Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(73500));
      }
      
      private function CW_Fun1_C(e:*) : *
      {
         if(Main.player_1.playerCW.data.addExp(1000))
         {
            NewMC.Open("宠物升级",Main.player_1.playerCW);
         }
      }
      
      private function CW_Fun2_C(e:*) : *
      {
         if(Main.player_2.playerCW.data.addExp(1000))
         {
            NewMC.Open("宠物升级",Main.player_2.playerCW);
         }
      }
      
      private function ShowInfo() : *
      {
         temp_txt.text += "logName = " + Main.logName + "\n";
         temp_txt.text += "当前版本 = " + Main.varX + " ,存档版本 = " + Main.varX_old + "\n";
         if(Main.logNameSave == "" && Main.varX_old < 182 || Boolean(MD5contrast.contrast(Main.logName,Main.logNameSave,Main.saveNum)))
         {
            temp_txt.text += "验证通过!!\n" + "存档:" + (int(Main.logNameSave.substr(5,1)) + 1) + ", sn:" + Main.logNameSave.substr(6,8) + "\n" + "验证通过信息: " + MD5contrast.contrastID + "\n";
         }
         else
         {
            temp_txt.text += "验证失败!!\n" + "存档:" + (int(Main.logNameSave.substr(5,1)) + 1) + ", sn:" + Main.logNameSave.substr(6,8) + "\n" + "#错误:" + MD5contrast.errorID + "\n";
         }
         if(Shop4399.totalPaiedMoney.getValue() != -1)
         {
            temp_txt.text += "消费 = " + Shop4399.totalPaiedMoney.getValue() + "\n";
         }
         else
         {
            temp_txt.text += "请稍候再试\n";
         }
         if(Main.NoLog == 0)
         {
            temp_txt.text += "\n\n 作弊检测:验证通过\n";
         }
         else if(Main.NoLog == 2)
         {
            temp_txt.text += "\n\n 作弊检测:已锁定#2 \n修改攻击倍数";
            if(Main.NoLogInfo[2])
            {
               temp_txt.text += Main.NoLogInfo[2] + "\n";
            }
         }
         else
         {
            temp_txt.text += "\n\nMain.NoLog = " + Main.NoLog;
         }
         AchPanel.open();
      }
      
      private function XX61Fun(e:*) : *
      {
         phpUrl.method = URLRequestMethod.GET;
         var str:String = X61info_txt.text;
         phpUrl.data = "ac=check&code=" + str + "&game=ysdyx";
         urlLoader.load(phpUrl);
         urlLoader.addEventListener(Event.COMPLETE,completeHandler3);
      }
      
      private function completeHandler3(e:Event) : void
      {
         var str:String = (e.currentTarget as URLLoader).data;
         if(str == "1")
         {
            str = "验证通过";
         }
         else if(str == "0|004")
         {
            str = "兑换码无效";
         }
         else if(str == "0|001")
         {
            str = "活动还没开始";
         }
         else if(str == "0|002")
         {
            str = "活动已经结束";
         }
         else
         {
            str = "未登录";
         }
         X61_txt.text = "" + str;
      }
   }
}

