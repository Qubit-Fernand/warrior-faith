package src
{
   import com.*;
   import com.ByteArrayXX.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.elves.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.make.*;
   import com.hotpoint.braveManIII.models.monsterCard.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.pet.*;
   import com.hotpoint.braveManIII.models.plan.*;
   import com.hotpoint.braveManIII.models.player.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.models.skill.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.models.title.*;
   import com.hotpoint.braveManIII.models.wantedTask.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.plan.*;
   import com.hotpoint.braveManIII.repository.probability.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.cardPanel.*;
   import com.hotpoint.braveManIII.views.composePanel.*;
   import com.hotpoint.braveManIII.views.elvesPanel.*;
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.makePanel.*;
   import com.hotpoint.braveManIII.views.petPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.stampPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.strPanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import com.hotpoint.braveManIII.views.titelPanel.*;
   import com.hotpoint.braveManIII.views.wantedPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import src._data.*;
   import src.npc.*;
   import src.other.*;
   import src.tool.*;
   import unit4399.events.*;
   
   [SWF(width="940", height="580", backgroundColor="#333333", frameRate="27")]
   public class Main extends MovieClip
   {
      
      public static var wts:WantedTaskSlot;
      
      public static var _stage:*;
      
      public static var _this:*;
      
      public static var _stageWidth:int;
      
      public static var _stageHeight:int;
      
      public static var world:Map;
      
      public static var player_1:Player;
      
      public static var player_2:Player;
      
      public static var P1P2:Boolean;
      
      public static var player1:PlayerData;
      
      public static var player2:PlayerData;
      
      public static var varX:int;
      
      public static var verify:int;
      
      public static var LuoPanArr:Array = [0,0,0,0];
      
      public static var shengdan:Array = [VT.createVT(0),VT.createVT(0),VT.createVT(0),VT.createVT(0),VT.createVT(0),VT.createVT(0),VT.createVT(0),VT.createVT(0),VT.createVT(0)];
      
      public static var shengdanTimes:VT = VT.createVT(0);
      
      public static var lingQueArr:Array = [0,0,0,0,0,0,0,0,0,0,0];
      
      public static var lingQueArr2:Array = [0,0,0,0,0,0,0,0,0,0,0];
      
      public static var fps:int = 30;
      
      public static var gameNum:VT = VT.createVT();
      
      public static var gameNum2:VT = VT.createVT();
      
      public static var varX_old:int = 0;
      
      public static var guanKa:Array = [];
      
      public static var saveNum:int = -1;
      
      public static var stopXX:Boolean = false;
      
      public static var loadSaveOver:Boolean = false;
      
      public static var serverTime:VT = VT.createVT(getTodayZero());
      
      public static var userId:uint = 0;
      
      public static var logName:String = "";
      
      public static var logNameSave:String = "";
      
      public static var logYN:Boolean = false;
      
      public static var NoLog:int = 0;
      
      public static var NoLogInfo:Array = new Array();
      
      public static var tianShiYN:Boolean = false;
      
      public static var noSave:int = -43994399;
      
      public static var Map0_YN:Boolean = false;
      
      public static var Map0_YN2:Boolean = false;
      
      public static var water:VT = VT.createVT(1);
      
      public static var serviceHold:* = null;
      
      public static var questArr:Array = [[false,84110],[false,84111],[false,84112],[false,84113],[false,84114]];
      
      public static var senDanArr:* = ["彩球","圣诞帽","圣诞靴","驯鹿","糖果","雪花","礼物","铃铛","糖果棒"];
      
      public static var tempDataEnd:Boolean = false;
      
      public static var saveMc_YN:Boolean = true;
      
      public static var saveStop:Array = [false,true];
      
      public static var saveID:VT = VT.createVT();
      
      public static var ServerTimeNum:int = 0;
      
      public var blackXXXX:遮罩 = new 遮罩();
      
      private var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
      internal var _4399_function_payMoney_id:String = "10f73c09b41d9f41e761232f5f322f38";
      
      internal var _4399_function_shop_id:String = "30ea6b51a23275df624b781c3eb43ac6";
      
      internal var _4399_function_rankList_id:String = "69f52ab6eb1061853a761ee8c26324ae";
      
      private var duoKai_num:int = 0;
      
      public function Main()
      {
         super();
         InitData.Init();
         if(stage)
         {
            InitXX();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,InitXX);
         }
      }
      
      private static function getTodayZero(base:Date = null) : Date
      {
         var d:Date = base != null ? base : new Date();
         return new Date(d.fullYear,d.month,d.date,0,0,0,0);
      }
      
      public static function addShengDan() : void
      {
         var _loc1_:int = Math.random() * 9;
         NewMC.Open("圣诞挂件",Main._this,480,290,30,0,true,2,senDanArr[_loc1_]);
         if((shengdan[_loc1_] as VT).getValue() == 0)
         {
            (shengdan[_loc1_] as VT).setValue(1);
         }
      }
      
      public static function LoadTempDataArr() : *
      {
         TempData.Init();
         tempDataEnd = true;
      }
      
      public static function DuoKai_Fun() : *
      {
      }
      
      public static function applySaveObject(save:Object) : void
      {
         if(save == null)
         {
            return;
         }
         Main.varX_old = save["var"];
         if(save["logNameSave"])
         {
            logNameSave = save["logNameSave"];
         }
         NoLog = 0;
         if(save["NoLog"])
         {
            NoLog = save["NoLog"];
         }
         if(save["NoLogInfo"] && !(save["NoLogInfo"] is Array))
         {
            save["NoLogInfo"] = null;
         }
         if(save["NoLogInfo"])
         {
            Main.NoLogInfo = save["NoLogInfo"];
         }
         if(JiaoYan() != true || JiaoYan2() != true)
         {
            return;
         }
         Main.P1P2 = save["P1P2"];
         if(save["changKu"])
         {
            StoragePanel.storage = save["changKu"];
         }
         if(save["chengjiu"])
         {
            if(Main.varX_old > 275)
            {
               AchData.xxx = save["chengjiu"];
            }
         }
         var i:int = 0;
         while(i <= 150)
         {
            if(!save["guanKa"][i])
            {
               Main.guanKa[i] = 0;
            }
            else
            {
               Main.guanKa[i] = save["guanKa"][i];
            }
            if(Main.guanKa[i] is Boolean)
            {
               Main.guanKa[i] = Main.guanKa[i] ? 1 : 0;
            }
            i++;
         }
         if(Main.guanKa[1] != 0 && Main.guanKa[1] != 1 && Main.guanKa[1] != 2 && Main.guanKa[1] != 3)
         {
            Main.guanKa[1] = 1;
         }
         Main.questArr = save["questArr"];
         Main.verify = save["verify"];
         var pCount:int = Main.P1P2 ? 2 : 1;
         if(save["InitDataX"])
         {
            InitData.LoadInitData(save["InitDataX"]);
         }
         if(save["buyTime"])
         {
            Data_KillShop.buyTime = save["buyTime"];
            Data_KillShop.buyArr = save["buyArr"];
            ShopKillPoint.KaiQiShopArr2 = save["KaiQiShopArr2"];
         }
         if(save["RenWu"])
         {
            TaskData.saveArr = save["RenWu"];
         }
         if(save["MakeData"])
         {
            MakeData.duMake(save["MakeData"]);
         }
         i = 1;
         while(i <= pCount)
         {
            Main["player" + i] = save["p" + i] as PlayerData;
            i++;
         }
         if(save["lingQueArr"] && save["lingQueArr"].length == 11)
         {
            lingQueArr = save["lingQueArr"];
         }
         if(save["lingQueArr2"] && save["lingQueArr2"].length == 11)
         {
            lingQueArr2 = save["lingQueArr2"];
         }
         if(save["TeShuHuoDongArr"])
         {
            TeShuHuoDong.TeShuHuoDongArr = save["TeShuHuoDongArr"];
         }
         TeShuHuoDong.Init();
         if(save["xuansang"])
         {
            Main.wts = save["xuansang"];
         }
         if(save["kaPian"])
         {
            CardPanel.monsterSlot = save["kaPian"];
         }
         if(save["shengdan"])
         {
            shengdan = save["shengdan"];
         }
         if(save["shengdanTimes"])
         {
            shengdanTimes = save["shengdanTimes"];
         }
         if(save["huaZhi"])
         {
            Play_Interface.huaZhi = save["huaZhi"];
         }
         if(save["Map0_YN"])
         {
            Main.Map0_YN = save["Map0_YN"];
         }
         if(save["Map0_YN2"])
         {
            Main.Map0_YN2 = save["Map0_YN2"];
         }
         if(save["water"])
         {
            Main.water = save["water"];
         }
         if(save["LuoPanSuiPian"])
         {
            Main.LuoPanArr = save["LuoPanSuiPian"];
         }
         if(save["XinglingUp"])
         {
            XingLingFactory.xingLingData = save["XinglingUp"];
         }
         if(save["JiHua"])
         {
            PlanFactory.JiHuaData = save["JiHua"];
         }
         if(save["vipUserArr"])
         {
            Vip_Interface.vipUserArr = save["vipUserArr"];
            Vip_Interface.SetData();
         }
         if(save["TaskDataBoXX5"])
         {
            TaskData.BoXX = save["TaskDataBoXX5"];
         }
         SaveXX.TestGoldMax();
      }
      
      public static function Save(param1:Boolean = true, param2:int = 0) : *
      {
         if(param2 == 1)
         {
            JiHua_Interface.ppp4_9 = true;
         }
         Save2(param1);
      }
      
      public static function SaveFun() : *
      {
         if(saveID.getValue() > 0)
         {
            if(saveID.getValue() == 1)
            {
               saveID.setValue(2);
            }
         }
         XingLing_Interface.saveOK = true;
         StrPanel.QiangHuaOK();
      }
      
      public static function Save2(param1:Boolean = true) : *
      {
         saveMc_YN = param1;
         if(noSave > InitData.BuyNum_0.getValue() || Boolean(DuoKai_Info._noSave))
         {
            return;
         }
         var title:String = "";
         title += "P1:Lv" + player1.getLevel();
         if(Main.P1P2)
         {
            title += " / P2:Lv" + player2.getLevel();
         }
         var save:Object = {};
         save["var"] = Main.varX;
         if(Main.logNameSave == "" && Main.varX_old < 182)
         {
            save["logNameSave"] = MD5contrast.SaveStr(logName.toLocaleLowerCase(),saveNum);
         }
         else
         {
            save["logNameSave"] = Main.logNameSave;
         }
         save["NoLog"] = Main.NoLog;
         save["NoLogInfo"] = Main.NoLogInfo;
         var pCount:int = Main.P1P2 ? 2 : 1;
         var i:int = 1;
         while(i <= pCount)
         {
            save["p" + i] = Main["player" + i];
            i++;
         }
         save["P1P2"] = Main.P1P2;
         save["changKu"] = StoragePanel.storage;
         save["guanKa"] = Main.guanKa;
         save["questArr"] = Main.questArr;
         save["verify"] = Math.random() * 9999;
         save["InitDataX"] = InitData.SaveInitData();
         save["RenWu"] = TaskData.saveTask();
         save["buyTime"] = Data_KillShop.buyTime;
         save["buyArr"] = Data_KillShop.buyArr;
         save["KaiQiShopArr2"] = ShopKillPoint.KaiQiShopArr2;
         save["MakeData"] = MakeData.saveMake();
         save["lingQueArr"] = lingQueArr;
         save["lingQueArr2"] = lingQueArr2;
         save["TeShuHuoDongArr"] = TeShuHuoDong.TeShuHuoDongArr;
         save["chengjiu"] = AchData.save();
         save["xuansang"] = Main.wts;
         save["kaPian"] = CardPanel.monsterSlot;
         save["shengdan"] = Main.shengdan;
         save["shengdanTimes"] = shengdanTimes;
         save["huaZhi"] = Play_Interface.huaZhi;
         save["Map0_YN"] = Main.Map0_YN;
         save["Map0_YN2"] = Main.Map0_YN2;
         save["water"] = Main.water;
         save["LuoPanSuiPian"] = Main.LuoPanArr;
         save["JiHua"] = PlanFactory.JiHuaData;
         save["XinglingUp"] = XingLingFactory.xingLingData;
         save["vipUserArr"] = Vip_Interface.vipUserArr;
         save["TaskDataBoXX5"] = TaskData.BoXX;
         if(Main.saveNum < 0)
         {
            Main.saveNum = 0;
         }
         LocalSaveManager.saveSlot(Main.saveNum,title,save);
         Strat.SAVE_LIST = LocalSaveManager.getSlotTitles();
         if(Strat.stratX && Strat.stratX.save_mc && Strat.stratX.save_mc.visible)
         {
            i = 0;
            while(i < 8)
            {
               Strat.stratX.save_mc["txt_" + i].text = "" + Strat.SAVE_LIST[i];
               i++;
            }
         }
         if(Main.saveMc_YN)
         {
            NewMC.Open("保存成功",Main._this);
         }
         Main.SaveFun();
      }
      
      public static function GetServerTime() : *
      {
      }
      
      public static function allClosePanel() : *
      {
         SuppliesShopPanel.close();
         SkillPanel.close();
         SetTransferPanel.close();
         SetKeyPanel.close();
         ItemsPanel.close();
         EquipShopPanel.close();
         StoragePanel.close();
         装备商人界面.Close();
         药水商人界面.Close();
         技能导师界面.Close();
         村长任务界面.Close();
         探险家界面.Close();
         Shop4399.Close();
         ShopKillPoint.Close();
         xilianPanel.close();
         PetPanel.close();
         StrPanel.close();
         ComPosePanel.close();
         MakePanel.close();
         Shop_LiBao.Close();
         Shop_LiBao2.Close();
         AchPanel.close();
         WantedPanel.close();
         StampPanel.close();
         ItemsPanel.szcbTime();
         TaskPanel.close();
         TitelPanel.CengHaoShow();
         CardPanel.close();
         ElvesPanel.close();
         PK_UI.Close();
         PK_UI_Sel.Close();
         AchData.upPoint();
         Shop_LiBao.JianCe();
         Shop_LiBao2.JianCe();
         XingLing_Interface.CloseX();
      }
      
      public static function isVip() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < Main.player1.getTitleSlot().getListLength())
         {
            if(Main.player1.getTitleSlot().getTitleFromSlot(_loc1_).getId() == 25)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public static function getQuest(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < questArr.length)
         {
            if(questArr[_loc2_][1] == param1)
            {
               return questArr[_loc2_][0];
            }
            _loc2_++;
         }
         return false;
      }
      
      public static function setQuest(param1:Number) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < questArr.length)
         {
            if(questArr[_loc2_][1] == param1)
            {
               questArr[_loc2_][0] = true;
               break;
            }
            _loc2_++;
         }
      }
      
      public static function getAllQuest() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < questArr.length)
         {
            if(questArr[_loc1_][0])
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public static function questBag() : Boolean
      {
         var _loc1_:uint = 0;
         while(_loc1_ < questArr.length)
         {
            if(Boolean(Main.player1) && Main.player1.getBag().fallQusetBag(questArr[_loc1_][1]) > 0)
            {
               return true;
            }
            if(Main.P1P2 && Main.player2 && Main.player2.getBag().fallQusetBag(questArr[_loc1_][1]) > 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public static function JiaoYan() : Boolean
      {
         if(tianShiYN == true)
         {
            return true;
         }
         if(Main.varX < Main.varX_old)
         {
            Strat.stratX.游戏盒信息();
            return false;
         }
         return true;
      }
      
      public static function JiaoYan2() : Boolean
      {
         if(tianShiYN == true)
         {
            XiuZheng();
            return true;
         }
         if(NoLog < 2 && (Main.logNameSave == "" && Main.varX_old < 182 || Boolean(MD5contrast.contrast(Main.logName,Main.logNameSave,Main.saveNum))))
         {
            return true;
         }
         if(XiuZheng())
         {
            return true;
         }
         Strat.stratX.复制存档信息();
         return false;
      }
      
      private static function XiuZheng() : Boolean
      {
         if(Main.NoLogInfo[5] == 888 || Main.NoLogInfo[5] == 111 || Main.NoLogInfo[5] == 122 || Main.NoLogInfo[5] == 333 || Main.NoLogInfo[5] == 444)
         {
            Main.NoLog = 0;
            Main.NoLogInfo[5] = null;
            return true;
         }
         if(Main.NoLogInfo[4] < 1000)
         {
            Main.NoLogInfo[4] = null;
            return true;
         }
         return false;
      }
      
      public static function NoGame(param1:String = "未知") : *
      {
      }
      
      public function setHold(param1:*) : void
      {
         serviceHold = param1;
      }
      
      public function InitXX(param1:* = null) : *
      {
         noSave = -(Math.random() * 999999 + 999);
         removeEventListener(Event.ADDED_TO_STAGE,InitXX);
         _stage = stage;
         _this = this;
         Data_KillShop.Init();
         Data_qinMiDu.Init();
         PetFactory.AddLVDataInit();
         MusicBox.MusicPlay("封面声音");
         regAllClass();
         onADDED_TO_STAGE();
      }
      
      public function regAllClass() : void
      {
         registerClassAlias("PlayerData",PlayerData);
         registerClassAlias("Attribute",Attribute);
         registerClassAlias("Bag",Bag);
         registerClassAlias("Equip",Equip);
         registerClassAlias("EquipBaseAttrib",EquipBaseAttrib);
         registerClassAlias("EquipBaseAttribTypeConst",EquipBaseAttribTypeConst);
         registerClassAlias("EquipReinforce",EquipReinforce);
         registerClassAlias("EquipSkillSlot",EquipSkillSlot);
         registerClassAlias("EquipSlot",EquipSlot);
         registerClassAlias("Gem",Gem);
         registerClassAlias("GemTypeConst",GemTypeConst);
         registerClassAlias("Otherobj",Otherobj);
         registerClassAlias("PlayerData",PlayerData);
         registerClassAlias("promptSlot",promptSlot);
         registerClassAlias("Quest",Quest);
         registerClassAlias("Skill",Skill);
         registerClassAlias("SkillSlot",SkillSlot);
         registerClassAlias("Storage",Storage);
         registerClassAlias("StrengthenDeleteSlot",StrengthenDeleteSlot);
         registerClassAlias("StrengthenMosaicSlot",StrengthenMosaicSlot);
         registerClassAlias("StrengthenSlot",StrengthenSlot);
         registerClassAlias("StrengthenSynthesisSlot",StrengthenSynthesisSlot);
         registerClassAlias("SuitEquipAttrib",SuitEquipAttrib);
         registerClassAlias("Supplies",Supplies);
         registerClassAlias("SuppliesAffect",SuppliesAffect);
         registerClassAlias("SuppliesSlot",SuppliesSlot);
         registerClassAlias("Task",Task);
         registerClassAlias("Make",Make);
         registerClassAlias("VT",VT);
         registerClassAlias("Pet",Pet);
         registerClassAlias("PetSlot",PetSlot);
         registerClassAlias("BadgeSlot",BadgeSlot);
         registerClassAlias("TitleSlot",TitleSlot);
         registerClassAlias("Title",Title);
         registerClassAlias("WantedTaskSlot",WantedTaskSlot);
         registerClassAlias("WantedTask",WantedTask);
         registerClassAlias("StampSlot",StampSlot);
         registerClassAlias("Elves",Elves);
         registerClassAlias("ElvesSlot",ElvesSlot);
         registerClassAlias("MonsterSlot",MonsterSlot);
         registerClassAlias("MonsterCard",MonsterCard);
         registerClassAlias("Plan",Plan);
      }
      
      private function onADDED_TO_STAGE() : *
      {
         stage.addEventListener("netSaveError",netSaveErrorHandler,false,0,true);
         stage.addEventListener("MVC_CLOSE_PANEL",closePanelHandler);
         stage.addEventListener("userLoginOut",onUserLogOutHandler,false,0,true);
         Main.fps = stage.frameRate;
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         Main._stage = stage;
         Main._this = this;
         Main._stageWidth = stage.width;
         Main._stageHeight = stage.height;
         LocalSaveManager.init();
         Strat.SAVE_LIST = LocalSaveManager.getSlotTitles();
         Main.loadSaveOver = true;
         Strat.Open();
         BasicKey.Start(Main._stage);
         LoadTempDataArr();
      }
      
      private function closePanelHandler(param1:Event) : void
      {
         if(serviceHold)
         {
            var _loc2_:Object = serviceHold.isLog;
            if(_loc2_ == null)
            {
               showLogUi();
            }
         }
      }
      
      public function showLogUi() : void
      {
         if(serviceHold)
         {
            var _loc1_:Object = serviceHold.isLog;
            if(_loc1_ == null)
            {
               serviceHold.showLogPanel();
            }
         }
      }
      
      private function netSaveErrorHandler(param1:Event) : void
      {
      }
      
      private function onUserLogOutHandler(param1:Event) : void
      {
         navigateToURL(new URLRequest("javascript:location.reload(); "),"_self");
      }
      
      public function Loading() : *
      {
         Load.Open();
         addEventListener(Event.ENTER_FRAME,onLoading);
      }
      
      private function onLoading(param1:*) : *
      {
         if(Load.All_Loaded)
         {
            Load.All_Loaded = false;
            GameData.GetData();
            GameStart();
            removeEventListener(Event.ENTER_FRAME,onLoading);
            Load.Close();
         }
      }
      
      public function GameStart() : *
      {
         if(Main.gameNum.getValue() == 0 && Main.gameNum2.getValue() == 0)
         {
            if(Main.water.getValue() != 1)
            {
               Main.gameNum2.setValue(4);
            }
            else if(Main.Map0_YN)
            {
               Main.gameNum2.setValue(3);
            }
            GameData.winYN = false;
            Play_Interface.jihuaTiShi();
         }
         Play_Interface.BossLifeYN = false;
         MakeData.initAllMake();
         AchData.getAllAch();
         TaskData.initAllTask();
         MusicBox.MusicPlay();
         DelGame();
         AddMap();
         AddPlayer(1);
         if(P1P2)
         {
            AddPlayer(2);
         }
         ItemsPanel.open();
         ItemsPanel.close();
         GameData.GetData();
         Play_Interface.Open();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         CheckTest.startTest();
         SaveXX.TestGoldMax();
         if(Main.gameNum2.getValue() < 1 || Main.gameNum.getValue() == 999)
         {
            Player.一起信春哥();
            WinShow.All_0();
         }
         Main.player_1.noMove = false;
         if(Main.P1P2)
         {
            Main.player_2.noMove = false;
         }
         if(Main.gameNum.getValue() != 999)
         {
            PK_UI.PK_ing = false;
         }
         else
         {
            PK_UI.PK_ing = true;
         }
         if(Main.gameNum.getValue() > 17 && Main.gameNum.getValue() < 29)
         {
            JiHua_Interface.ppp5_4 = true;
         }
         _stage.addChild(blackXXXX);
      }
      
      public function DelGame() : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         Enemy.All = new Array();
         Player.All = new Array();
         Player2.All = new Array();
         HitXX.AllHitXX = new Array();
         if(Main.world)
         {
            Main.world.parent.removeChild(Main.world);
            Main.world.y = 5000;
            Main.world = null;
         }
      }
      
      private function AddMap() : *
      {
         var _loc1_:String = GameData.SelMapName();
         var _loc2_:uint = gameNum.getValue();
         var _loc3_:Class = Map.MapArr[_loc2_].getClass(_loc1_ as String) as Class;
         world = new _loc3_();
         addChild(Main.world);
         Main._stage.stageFocusRect = false;
         Main._stage.focus = Main.world;
         if(Main.gameNum.getValue() == 81)
         {
            if(Main.world["_back"])
            {
               Main.world["_back"].addChild(new MapJG());
            }
         }
      }
      
      private function AddPlayer(param1:int = 1) : *
      {
         if(param1 == 1)
         {
            if(!player_1)
            {
               player_1 = new Player();
               if(Main.player1)
               {
                  player_1.data = Main.player1;
               }
               else
               {
                  player_1.data = Main.player1 = PlayerData.creatPlayerData(1);
                  player_1.data.skinArr = SetProfession.skinArr1;
               }
               player_1.Load_All_Player_Data();
            }
            Main.world.moveChild_Player.addChild(player_1);
            player_1.x = 280;
            if(player_1.hp.getValue() > 0)
            {
               player_1.y = 450;
            }
            else
            {
               player_1.y = -50;
            }
            player_1.newSkin();
         }
         else if(param1 == 2)
         {
            if(!player_2)
            {
               player_2 = new Player();
               if(Main.player2)
               {
                  player_2.data = Main.player2;
               }
               else
               {
                  player_2.data = Main.player2 = PlayerData.creatPlayerData(2);
                  player_2.data.skinArr = SetProfession.skinArr2;
               }
               player_2.Load_All_Player_Data();
            }
            Main.world.moveChild_Player.addChild(player_2);
            player_2.x = 240;
            if(player_1.hp.getValue() > 0)
            {
               player_1.y = 450;
            }
            else
            {
               player_1.y = -50;
            }
            player_2.y = 450;
            player_2.newSkin();
         }
         Main.world.开启Show0();
      }
      
      private function onENTER_FRAME(param1:Event) : *
      {
         if(Main.gameNum.getValue() != 0)
         {
            HitXX.HitEnemy();
            HitF.HitFly();
            HitP.HitPlayer();
            GameData.MonsterGo();
            ++WinShow.txt_1;
            if(Main.gameNum.getValue() == 999)
            {
               PK_UI.AddOtherPlayer();
            }
         }
         Load.md5_Start();
         --Shop4399.SelMoneyTime;
      }
   }
}

