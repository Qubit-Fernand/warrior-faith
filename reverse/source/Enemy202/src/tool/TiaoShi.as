package src.tool
{
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
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.text.*;
   import src.*;
   import src._data.*;
   
   public class TiaoShi extends MovieClip
   {
      
      public static var tempVar:String;
      
      private static var _this:TiaoShi = new TiaoShi();
      
      public static var XXX:Array = [];
      
      private var urlLoader:URLLoader = new URLLoader();
      
      private var phpUrl:URLRequest = new URLRequest("http://huodong2.4399.com/2012/liwu/liwu.php");
      
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
         get_1_btn.addEventListener(MouseEvent.CLICK,this.GetP1Obj);
         get_2_btn.addEventListener(MouseEvent.CLICK,this.GetP2Obj);
         Op_btn.addEventListener(MouseEvent.CLICK,this.OP);
         KaiQi_btn.addEventListener(MouseEvent.CLICK,this.KaiQi);
         KaiQi_All_btn.addEventListener(MouseEvent.CLICK,this.KaiQiAll);
         P1_btn.addEventListener(MouseEvent.CLICK,this.P1_ZhuangTai);
         P2_btn.addEventListener(MouseEvent.CLICK,this.P2_ZhuangTai);
         tet_btn.addEventListener(MouseEvent.CLICK,this.Txt_show);
         sysTime_btn.addEventListener(MouseEvent.CLICK,this.sysTime);
         buy1.addEventListener(MouseEvent.CLICK,this.BuyOpenNum);
         buy2.addEventListener(MouseEvent.CLICK,this.BuyOpenNum);
         buy3.addEventListener(MouseEvent.CLICK,this.BuyOpenNum);
         buy4.addEventListener(MouseEvent.CLICK,this.BuyOpenNum);
         name_btn.addEventListener(MouseEvent.CLICK,this.NewName);
         JieChu_btn.addEventListener(MouseEvent.CLICK,this.JieChu_Fun);
         ChongWu1_btn.addEventListener(MouseEvent.CLICK,this.CW_Fun1);
         ChongWu2_btn.addEventListener(MouseEvent.CLICK,this.CW_Fun2);
         ChongWu_close1_btn.addEventListener(MouseEvent.CLICK,this.CW_Fun1_C);
         ChongWu_close2_btn.addEventListener(MouseEvent.CLICK,this.CW_Fun2_C);
         other_btn.addEventListener(MouseEvent.CLICK,this.other_Fun);
         other2_btn.addEventListener(MouseEvent.CLICK,this.other_Fun2);
         X61_btn.addEventListener(MouseEvent.CLICK,this.XX61Fun);
         CJ_0_btn.addEventListener(MouseEvent.CLICK,this.CJ0_Fun);
         liBaoPoint_btn.addEventListener(MouseEvent.CLICK,this.SetLiBaoPoint);
         liBaoPoint2_btn.addEventListener(MouseEvent.CLICK,this.SetLiBaoPoint2);
         PaiHangTiJiao_btn.addEventListener(MouseEvent.CLICK,this.PaiHangTiJiao);
         Sel_btn.addEventListener(MouseEvent.CLICK,this.SEL_PaiHangTiJiao);
         NewData_btn.addEventListener(MouseEvent.CLICK,this.NewDataXXX);
         NewPlyer_btn.addEventListener(MouseEvent.CLICK,this.NewPlyer);
         temp_btn.addEventListener(MouseEvent.CLICK,this.TempFun);
      }
      
      public static function ShowPaiHang(param1:String = "") : *
      {
         _this.temp_txt.text = "\n回调信息:" + param1;
      }
      
      private function OP(param1:*) : *
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
      
      private function GetP1Obj(param1:*) : *
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
      
      private function GetP2Obj(param1:*) : *
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
      
      private function KaiQiAll(param1:*) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < 150)
         {
            Main.guanKa[_loc2_] = int(GuanKa2_txt.text);
            _loc2_++;
         }
      }
      
      private function KaiQi(param1:*) : *
      {
         Main.guanKa[int(GuanKa1_txt.text)] = int(GuanKa2_txt.text);
      }
      
      private function P1_ZhuangTai(param1:*) : *
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
            Main.player1.addGold(int(p3_txt.text));
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
         if(int(p8_txt.text) != -1)
         {
         }
         if(int(p9_txt.text) != -1)
         {
         }
      }
      
      private function P2_ZhuangTai(param1:*) : *
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
      
      private function Txt_show(param1:*) : *
      {
         temp_txt.text = "";
         if(int(type_txt.text) == 1)
         {
            this.ShowInfo();
         }
      }
      
      private function sysTime(param1:*) : *
      {
         if(int(sysTime_txt.text) != -1)
         {
            Main.serverTime.setValue(int(sysTime_txt.text));
         }
      }
      
      private function BuyOpenNum(param1:MouseEvent) : *
      {
         ShopKillPoint.KaiQiShopArr2[0] = 0;
         var _loc2_:int = int((param1.target.name as String).substr(3,1));
         if(ShopKillPoint.KaiQiShopArr2[_loc2_] == true)
         {
            ShopKillPoint.KaiQiShopArr2[_loc2_] = false;
            ShopKillPoint.shopX["shopX_" + _loc2_]["skin"].visible = true;
         }
         else
         {
            ShopKillPoint.KaiQiShopArr2[_loc2_] = true;
            ShopKillPoint.shopX["shopX_" + _loc2_]["skin"].visible = false;
         }
      }
      
      private function NewName(param1:*) : *
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
      
      private function JieChu_Fun(param1:*) : *
      {
         Main.NoLog = 0;
         Main.NoLogInfo = new Array();
      }
      
      private function CW_Fun1(param1:*) : *
      {
         Main.player_1.playerCW = null;
         Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(73101));
         Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(73500));
      }
      
      private function CW_Fun2(param1:*) : *
      {
         Main.player_2.playerCW = null;
         Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(73101));
         Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(73500));
      }
      
      private function CW_Fun1_C(param1:*) : *
      {
         if(Main.player_1.playerCW.data.addExp(99999))
         {
            NewMC.Open("宠物升级",Main.player_1.playerCW);
         }
      }
      
      private function CW_Fun2_C(param1:*) : *
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
         temp_txt.text += "\n";
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
         if(Main.NoLog == 0)
         {
            temp_txt.text += "\n\n 作弊检测:验证通过\n";
         }
         else if(Main.NoLog >= 2)
         {
            temp_txt.text += "\n>>>>>>>>>>>>>>>>>>>\n 作弊检测:已锁定 \n";
            if(Main.NoLogInfo[2])
            {
               temp_txt.text += "\n #2修改攻击倍数" + Main.NoLogInfo[2] + "\n";
            }
            if(Main.NoLogInfo[3])
            {
               temp_txt.text += "\n #3修改金币" + Main.NoLogInfo[3] + "\n";
            }
            if(Main.NoLogInfo[4])
            {
               temp_txt.text += "\n #4物品堆叠上限" + Main.NoLogInfo[4] + "\n";
            }
            if(Main.NoLogInfo[5])
            {
               temp_txt.text += "\n #5防复制" + Main.NoLogInfo[5] + "\n";
            }
            temp_txt.text += "\n>>>>>>>>>>>>>>>>>>>\n";
            temp_txt.text += "\n #Main.NoLog = " + Main.NoLog + "\nArr = " + Main.NoLogInfo + "\n";
         }
         temp_txt.text += "\n已领取礼包 = " + Main.lingQueArr + ", length" + Main.lingQueArr.length;
         temp_txt.text += "\n已领取累计礼包 = " + Main.lingQueArr2 + ", length" + Main.lingQueArr.length;
         temp_txt.text += "\n特殊领取 = " + TeShuHuoDong.TeShuHuoDongArr;
         CheckTest.Testing();
         temp_txt.text += "\nCheckTest.testStr:" + CheckTest.testStr;
         temp_txt.text += "\nCheckTest.tempStr:" + CheckTest.tempStr;
         Main.wts.wantedTaskComplete();
      }
      
      private function XX61Fun(param1:*) : *
      {
         AchData.cjPoint_1.setValue(int(X61info_txt.text));
         AchData.cjPoint_2.setValue(int(X61_txt.text));
      }
      
      private function completeHandler3(param1:Event) : void
      {
         var _loc2_:String = (param1.currentTarget as URLLoader).data;
         if(_loc2_ == "1")
         {
            _loc2_ = "验证通过";
         }
         else if(_loc2_ == "0|004")
         {
            _loc2_ = "兑换码无效";
         }
         else if(_loc2_ == "0|001")
         {
            _loc2_ = "活动还没开始";
         }
         else if(_loc2_ == "0|002")
         {
            _loc2_ = "活动已经结束";
         }
         else
         {
            _loc2_ = "未登录";
         }
         X61_txt.text = "" + _loc2_;
      }
      
      private function other_Fun(param1:*) : *
      {
         Main.lingQueArr = [0,0,0,0,0,0,0,0,0,0,0];
         Main.lingQueArr2 = [0,0,0,0,0,0,0,0,0,0,0];
      }
      
      private function other_Fun2(param1:*) : *
      {
         TeShuHuoDong.TeShuHuoDongArr[0] += int(liBaoPoint_txt.text);
         Api_4399_All.Money_up(int(liBaoPoint_txt.text));
         Main.Save(false);
      }
      
      private function CJ0_Fun(param1:*) : *
      {
         AchData.initAllAc();
      }
      
      private function SetLiBaoPoint(param1:*) : *
      {
         Shop_LiBao.HDpoint.setValue(int(liBaoPoint2_txt.text));
      }
      
      private function SetLiBaoPoint2(param1:*) : *
      {
         Shop4399.totalRecharged.setValue(int(liBaoPoint3_txt.text));
      }
      
      private function SEL_PaiHangTiJiao(param1:*) : *
      {
         Api_4399_All.GetRankListsData();
      }
      
      private function PaiHangTiJiao(param1:*) : *
      {
         var _loc2_:Array = [];
         _loc2_[0] = new Object();
         _loc2_[0].rId = 14;
         _loc2_[0].score = uint(PaiHangTiJiao_txt.text);
         Api_4399_All.SubmitScore(Main.saveNum,_loc2_);
      }
      
      private function NewDataXXX(param1:*) : *
      {
         Api_4399_All.GetUserData(Main.userId,Main.saveNum);
      }
      
      private function NewPlyer(param1:*) : *
      {
         var _loc2_:Player2 = null;
         if(!Api_4399_All.playerDataArr || Api_4399_All.playerDataArr.length == 0)
         {
            ShortTip.open(11);
            _loc2_ = new Player2();
            _loc2_.data = Main.player_1.data;
            _loc2_.Load_All_Player_Data();
            Main.world.moveChild_Player.addChild(_loc2_);
            _loc2_.x = Math.random() * 700 + 100;
            _loc2_.y = 200;
            _loc2_.newSkin();
            return;
         }
         _loc2_ = new Player2();
         _loc2_.data = Api_4399_All.playerDataArr[Api_4399_All.playerDataArr.length - 1];
         _loc2_.Load_All_Player_Data();
         Main.world.moveChild_Player.addChild(_loc2_);
         _loc2_.x = Math.random() * 700 + 100;
         _loc2_.y = 200;
         _loc2_.newSkin();
      }
      
      private function TempFun(param1:*) : *
      {
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14322));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14347));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14372));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14397));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14445));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14463));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14469));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14475));
         Main.player_1.data.getBag().addEquipBag(EquipFactory.createEquipByID(14481));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63163));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63164));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63165));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63166));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63167));
         Main.player_1.data.getBag().addOtherobjBag(OtherFactory.creatOther(63168));
      }
   }
}

