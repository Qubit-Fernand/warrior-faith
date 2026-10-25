package src.tool
{
   import com.*;
   import com.adobe.serialization.json.*;
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
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   import src._data.*;
   
   public class TiaoShi extends MovieClip
   {
      
      public static var tempVar:String;
      
      public static var _this:TiaoShi = new TiaoShi();
      
      public static var XXX:Array = [];
      
      private var urlLoader:URLLoader = new URLLoader();
      
      private var phpUrl:URLRequest = new URLRequest("http://my.4399.com/score/api-apply");
      
      public function TiaoShi()
      {
         super();
         _this = this;
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
         other_btn.addEventListener(MouseEvent.CLICK,other_Fun);
         X61_btn.addEventListener(MouseEvent.CLICK,XX61Fun);
         CJ_0_btn.addEventListener(MouseEvent.CLICK,CJ0_Fun);
         liBaoPoint_btn.addEventListener(MouseEvent.CLICK,SetLiBaoPoint);
         liBaoPoint2_btn.addEventListener(MouseEvent.CLICK,SetLiBaoPoint2);
         PaiHangTiJiao_btn.addEventListener(MouseEvent.CLICK,PaiHangTiJiao);
         Sel_btn.addEventListener(MouseEvent.CLICK,SEL_PaiHangTiJiao);
         NewData_btn.addEventListener(MouseEvent.CLICK,NewDataXXX);
         temp_btn.addEventListener(MouseEvent.CLICK,TempFun);
         QingKong_btn.addEventListener(MouseEvent.CLICK,QingKong_Fun);
      }
      
      public static function ShowPaiHang(str:String = "") : *
      {
         _this.temp_txt.text = "\n回调信息:" + str;
      }
      
      public static function txtShow(str:String) : *
      {
         _this.temp_txt.text += "\n" + str;
      }
      
      private function QingKong_Fun(e:*) : *
      {
         temp_txt.text = "";
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
            TaskData.setOk(int(get_5_txt.text));
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
            TaskData.setOk(int(get_5_txt.text));
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
            Main.player_1.data.killPoint.setValue(int(p2_txt.text));
         }
         if(int(p3_txt.text) != -1)
         {
            Main.player1.gold.setValue(int(p3_txt.text));
         }
         if(int(p4_txt.text) != -1)
         {
            Main.player_1.data.points.setValue(int(p4_txt.text));
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
         if(int(p8_txt.text) != -1)
         {
         }
         if(int(p9_txt.text) != -1)
         {
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
            Main.player2.addGold(int(p3_txt.text));
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
         if(int(p8_txt.text) != -1)
         {
         }
         if(int(p9_txt.text) != -1)
         {
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
         if(name_txt.text != 0)
         {
            Main.logName = name_txt.text;
            Main.logNameSave = "";
            Main.varX_old = 0;
         }
         if(var_txt.text != 0)
         {
            Main.varX = int(var_txt.text);
         }
      }
      
      private function JieChu_Fun(e:*) : *
      {
         Main.NoLog = 0;
         Main.NoLogInfo = new Array();
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
         if(Boolean(Main.player_1.playerCW) && Boolean(Main.player_1.playerCW.data.addExp(99999)))
         {
            NewMC.Open("宠物升级",Main.player_1.playerCW);
         }
         if(Boolean(Main.player_1.playerJL) && Boolean(Main.player_1.playerJL.data.addExp(99999)))
         {
            NewMC.Open("宠物升级",Main.player_1.playerCW);
         }
      }
      
      private function CW_Fun2_C(e:*) : *
      {
         if(Main.player_2.playerCW.data.addExp(99999))
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
            temp_txt.text += "存档:" + (int(Main.logNameSave.substr(5,1)) + 1) + ", sn:" + Main.logNameSave.substr(6,8) + "\n" + "验证信息: " + MD5contrast.contrastID + "\n";
         }
         else
         {
            temp_txt.text += "验证失败!!\n" + "存档:" + (int(Main.logNameSave.substr(5,1)) + 1) + ", sn:" + Main.logNameSave.substr(6,8) + "\n" + "验证信息: 错误#" + MD5contrast.errorID + "\n";
         }
         if(Main.NoLog == 0)
         {
            temp_txt.text += "作弊检测:验证通过\n";
         }
         else if(Main.NoLog >= 2)
         {
            temp_txt.text += "\n>>>>>>>>>>>>>>>>>>>\n 作弊检测:已锁定 \n";
            if(Main.NoLogInfo[2])
            {
               temp_txt.text += "\n #2 修改攻击倍数" + Main.NoLogInfo[2] + "\n";
            }
            if(Main.NoLogInfo[3])
            {
               temp_txt.text += "\n #3 修改金币" + Main.NoLogInfo[3] + "\n";
            }
            if(Main.NoLogInfo[4])
            {
               temp_txt.text += "\n #4 物品堆叠上限" + Main.NoLogInfo[4] + "\n";
            }
            if(Main.NoLogInfo[5])
            {
               temp_txt.text += "\n #5 防复制" + Main.NoLogInfo[5] + "\n";
            }
            if(Main.NoLogInfo[7])
            {
               temp_txt.text += "\n #7 宝石类复制" + Main.NoLogInfo[7] + "\n";
            }
            if(Main.NoLogInfo[8])
            {
               temp_txt.text += "\n #8 其他类复制" + Main.NoLogInfo[8] + "\n";
            }
            if(Main.NoLogInfo[10])
            {
               temp_txt.text += "\n #10 修改技能表XML \n";
            }
            if(Main.NoLogInfo[11])
            {
               temp_txt.text += "\n #11 修改暴击闪避" + Main.NoLogInfo[11] + " \n";
            }
            temp_txt.text += "\n #Main.NoLog = " + Main.NoLog + ", NoLogInfo = " + Main.NoLogInfo + "\n";
            temp_txt.text += "\n>>>>>>>>>>>>>>>>>>>\n";
         }
         temp_txt.text += "\n已领取礼包 = " + Main.lingQueArr + ", length" + Main.lingQueArr.length;
         temp_txt.text += "\n已领取累计礼包 = " + Main.lingQueArr2 + ", length" + Main.lingQueArr.length;
         temp_txt.text += "\n特殊领取 = " + TeShuHuoDong.TeShuHuoDongArr;
         if(Shop4399.totalRecharged.getValue() != -2)
         {
            temp_txt.text += "累计充值:" + Shop4399.totalRecharged.getValue() + "点券\n";
            temp_txt.text += "礼包前充值:" + Shop_LiBao.HDpoint.getValue() + "点券\n";
            temp_txt.text += "活动赠送卷:" + TeShuHuoDong.TeShuHuoDongArr[0] + "点券\n";
         }
         else
         {
            temp_txt.text += "请稍候再试\n";
         }
         CheckTest.Testing();
         CheckTest.TestingOther();
         Main.wts.wantedTaskComplete();
      }
      
      private function XX61Fun(e:*) : *
      {
         AchData.cjPoint_1.setValue(int(X61info_txt.text));
         AchData.cjPoint_2.setValue(int(X61_txt.text));
      }
      
      private function other_Fun(e:*) : *
      {
         Main.lingQueArr = [0,0,0,0,0,0,0,0,0,0,0];
         Main.lingQueArr2 = [0,0,0,0,0,0,0,0,0,0,0];
      }
      
      private function other_Fun2(e:*) : *
      {
         TeShuHuoDong.TeShuHuoDongArr[0] += int(liBaoPoint_txt.text);
         Api_4399_All.Money_up(int(liBaoPoint_txt.text));
         Main.Save(false);
      }
      
      private function CJ0_Fun(e:*) : *
      {
         AchData.initAllAc();
      }
      
      private function SetLiBaoPoint(e:*) : *
      {
         Shop_LiBao.HDpoint.setValue(int(liBaoPoint2_txt.text));
      }
      
      private function SetLiBaoPoint2(e:*) : *
      {
         Shop4399.totalRecharged.setValue(int(liBaoPoint3_txt.text));
      }
      
      private function SEL_PaiHangTiJiao(e:*) : *
      {
         PK_UI.Open();
      }
      
      private function PaiHangTiJiao(e:*) : *
      {
         var arr:Array = [];
         arr[0] = new Object();
         if(Main.P1P2)
         {
            arr[0].rId = 111;
         }
         else
         {
            arr[0].rId = 110;
         }
         arr[0].score = uint(PaiHangTiJiao_txt.text);
         Api_4399_All.SubmitScore(Main.saveNum,arr);
      }
      
      private function NewDataXXX(e:*) : *
      {
         TiaoShi.txtShow(TimeBox.TimeXX(CeShiMd5_PLayerData));
      }
      
      private function CeShiMd5_PLayerData() : *
      {
         TiaoShi.txtShow("Main.player1 - md5:" + MD5contrast.getObj_MD5String(Main.player1));
      }
      
      private function completeHandler3(e:Event) : void
      {
         var str:String = (e.currentTarget as URLLoader).data;
         var objX:Object = JSON.decode(str);
         if(objX.code == 100)
         {
            str = "验证通过";
         }
         else if(objX.code == 101)
         {
            str = "参数错误";
         }
         else if(objX.code == 102)
         {
            str = "验证码不存在";
         }
         else if(objX.code == 103)
         {
            str = "验证码还没被兑换";
         }
         else if(objX.code == 104)
         {
            str = "验证码被使用过";
         }
         else if(objX.code == 105)
         {
            str = "验证码只能被领取者使用";
         }
         else if(objX.code == 106)
         {
            str = "每个帐号只能领取一次";
         }
         else
         {
            str = "验证码错误";
         }
         X61_txt.text = "" + str;
      }
      
      private function ScoreApi() : *
      {
         phpUrl.method = URLRequestMethod.POST;
         var str:String = X61info_txt.text;
         var uv:URLVariables = new URLVariables();
         uv.gid = 20;
         uv.uid = Main.userId;
         uv.activation = X61info_txt.text;
         var tempStr:String = uv.uid + "||" + uv.gid + "||" + uv.activation + "||" + "e3d9c23d017ea5e434126fa0fc5efe88";
         var tokenStr:String = MD5contrast.GetScoreMD5(tempStr);
         temp_txt.text = "积分兑换md5: " + tokenStr;
         uv.token = tokenStr;
         phpUrl.data = uv;
         urlLoader.load(phpUrl);
         urlLoader.addEventListener(Event.COMPLETE,completeHandler3);
      }
      
      private function TempFun(e:*) : *
      {
         if(Main.wts.getWantedTaskFromSlot(4))
         {
            Main.wts.getWantedTaskFromSlot(4).addTimes(100);
         }
         if(Main.wts.getWantedTaskFromSlot(0))
         {
            Main.wts.getWantedTaskFromSlot(0).addTimes(100);
         }
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63163));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63164));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63165));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63166));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63167));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63168));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14484));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14490));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14496));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14502));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14508));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14514));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14520));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14526));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14532));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14538));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14544));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14550));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14556));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14562));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14568));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14574));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14580));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14586));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14592));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14598));
         for(var i:int = 0; i < 30; i++)
         {
            Main.player_1.data.getBag().addGemBag(GemFactory.creatGemById(33213));
            Main.player_1.data.getBag().addGemBag(GemFactory.creatGemById(34610));
            Main.player_1.data.getBag().addGemBag(GemFactory.creatGemById(33512));
         }
         Main.player_1.data._transferArr = [true,true,true];
         Main.player_1.data._rebirth = true;
      }
   }
}

