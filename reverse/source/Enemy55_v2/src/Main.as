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
   import com.hotpoint.braveManIII.views.shortTip.*;
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
      
      public static var serverTime:VT = VT.createVT();
      
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
         if(serviceHold)
         {
            serviceHold.getStoreState();
         }
      }
      
      public static function Save(param1:Boolean = true, param2:int = 0) : *
      {
         if(param2 == 1)
         {
            JiHua_Interface.ppp4_9 = true;
         }
         saveStop[0] = true;
         saveStop[1] = param1;
         saveID.setValue(param2);
         DuoKai_Fun();
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
         var _loc2_:String = "";
         _loc2_ += "P1:Lv" + player1.getLevel();
         if(Main.P1P2)
         {
            _loc2_ += " / P2:Lv" + player2.getLevel();
         }
         var _loc3_:Object = new Object();
         _loc3_["var"] = Main.varX;
         if(Main.logNameSave == "" && Main.varX_old < 182)
         {
            _loc3_["logNameSave"] = MD5contrast.SaveStr(logName.toLocaleLowerCase(),saveNum);
         }
         else
         {
            _loc3_["logNameSave"] = Main.logNameSave;
         }
         _loc3_["NoLog"] = Main.NoLog;
         _loc3_["NoLogInfo"] = Main.NoLogInfo;
         var _loc4_:int = 1;
         if(Main.P1P2)
         {
            _loc4_ = 2;
         }
         else
         {
            _loc4_ = 1;
         }
         var _loc5_:int = 1;
         while(_loc5_ <= _loc4_)
         {
            _loc3_["p" + _loc5_] = new Object();
            _loc3_["p" + _loc5_] = Main["player" + _loc5_];
            _loc5_++;
         }
         _loc3_["P1P2"] = Main.P1P2;
         _loc3_["changKu"] = StoragePanel.storage;
         _loc3_["guanKa"] = Main.guanKa;
         _loc3_["questArr"] = Main.questArr;
         _loc3_["verify"] = Math.random() * 9999;
         _loc3_["InitDataX"] = InitData.SaveInitData();
         _loc3_["RenWu"] = TaskData.saveTask();
         _loc3_["buyTime"] = Data_KillShop.buyTime;
         _loc3_["buyArr"] = Data_KillShop.buyArr;
         _loc3_["KaiQiShopArr2"] = ShopKillPoint.KaiQiShopArr2;
         _loc3_["MakeData"] = MakeData.saveMake();
         _loc3_["lingQueArr"] = lingQueArr;
         _loc3_["lingQueArr2"] = lingQueArr2;
         _loc3_["TeShuHuoDongArr"] = TeShuHuoDong.TeShuHuoDongArr;
         _loc3_["chengjiu"] = AchData.save();
         _loc3_["xuansang"] = Main.wts;
         _loc3_["kaPian"] = CardPanel.monsterSlot;
         _loc3_["shengdan"] = Main.shengdan;
         _loc3_["shengdanTimes"] = shengdanTimes;
         _loc3_["huaZhi"] = Play_Interface.huaZhi;
         _loc3_["Map0_YN"] = Main.Map0_YN;
         _loc3_["Map0_YN2"] = Main.Map0_YN2;
         _loc3_["water"] = Main.water;
         _loc3_["LuoPanSuiPian"] = Main.LuoPanArr;
         _loc3_["JiHua"] = PlanFactory.JiHuaData;
         _loc3_["XinglingUp"] = XingLingFactory.xingLingData;
         _loc3_["vipUserArr"] = Vip_Interface.vipUserArr;
         _loc3_["TaskDataBoXX5"] = TaskData.BoXX;
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.writeObject(_loc3_);
         _loc6_.position = 0;
         var _loc7_:String = Base64.encodeByteArray(_loc6_);
         if(Main.saveNum == -1)
         {
            Main.serviceHold.saveData(_loc2_,_loc7_);
         }
         else
         {
            Main.serviceHold.saveData(_loc2_,_loc7_,false,Main.saveNum);
         }
      }
      
      public static function GetServerTime() : *
      {
         if(Boolean(serviceHold) && ServerTimeNum <= 0)
         {
            serviceHold.getServerTime();
            ServerTimeNum = 90000;
         }
         else
         {
            --ServerTimeNum;
         }
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
            if(Boolean(Main.P1P2) && Boolean(Main.player2) && Main.player2.getBag().fallQusetBag(questArr[_loc1_][1]) > 0)
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
      
      public static function NoGame() : *
      {
         if(Main.tianShiYN)
         {
            return;
         }
         while(true)
         {
            _this.visible = false;
         }
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
         stage.addEventListener(SaveEvent.SAVE_GET,saveProcess);
         stage.addEventListener(SaveEvent.SAVE_SET,saveProcess);
         stage.addEventListener(SaveEvent.SAVE_LIST,saveProcess);
         stage.addEventListener("netSaveError",netSaveErrorHandler,false,0,true);
         stage.addEventListener("MVC_CLOSE_PANEL",closePanelHandler);
         stage.addEventListener("userLoginOut",onUserLogOutHandler,false,0,true);
         stage.addEventListener("logreturn",saveProcess);
         stage.addEventListener("serverTimeEvent",onGetServerTimeHandler);
         Main.fps = stage.frameRate;
         trace("游戏帧数设定:" + Main.fps);
         stage.addEventListener("multipleError",multipleErrorHandler,false,0,true);
         stage.addEventListener("StoreStateEvent",getStoreStateHandler,false,0,true);
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         Main._stage = stage;
         Main._this = this;
         Main._stageWidth = stage.width;
         Main._stageHeight = stage.height;
         Strat.Open();
         BasicKey.Start(Main._stage);
         LoadTempDataArr();
      }
      
      private function closePanelHandler(param1:Event) : void
      {
         var _loc2_:Object = serviceHold.isLog;
         if(_loc2_ == null)
         {
            showLogUi();
         }
      }
      
      public function showLogUi() : void
      {
         var _loc1_:Object = null;
         if(serviceHold)
         {
            _loc1_ = serviceHold.isLog;
            if(_loc1_ == null)
            {
               serviceHold.showLogPanel();
            }
         }
      }
      
      private function netSaveErrorHandler(param1:Event) : void
      {
         trace("网络存档失败了！");
      }
      
      private function onUserLogOutHandler(param1:Event) : void
      {
         trace("用户退出登录了");
         navigateToURL(new URLRequest("javascript:location.reload(); "),"_self");
      }
      
      private function saveProcess(param1:SaveEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:ByteArray = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         switch(param1.type)
         {
            case SaveEvent.SAVE_GET:
               if(param1.ret == null || param1.ret.data == null)
               {
                  return;
               }
               _loc2_ = String(param1.ret.data);
               _loc3_ = Base64.decodeToByteArray(_loc2_) as ByteArray;
               _loc3_.position = 0;
               Main.saveNum = param1.ret.index;
               _loc4_ = _loc3_.readObject();
               Main.varX_old = _loc4_["var"];
               if(_loc4_["logNameSave"])
               {
                  logNameSave = _loc4_["logNameSave"];
               }
               NoLog = 0;
               if(_loc4_["NoLog"])
               {
                  NoLog = _loc4_["NoLog"];
               }
               if(Boolean(_loc4_["NoLogInfo"]) && !(_loc4_["NoLogInfo"] is Array))
               {
                  _loc4_["NoLogInfo"] = null;
               }
               if(_loc4_["NoLogInfo"])
               {
                  Main.NoLogInfo = _loc4_["NoLogInfo"];
               }
               if(JiaoYan() != true || JiaoYan2() != true)
               {
                  return;
               }
               Main.P1P2 = _loc4_["P1P2"];
               if(_loc4_["changKu"])
               {
                  StoragePanel.storage = _loc4_["changKu"];
               }
               if(_loc4_["chengjiu"])
               {
                  if(Main.varX_old > 275)
                  {
                     AchData.xxx = _loc4_["chengjiu"];
                  }
               }
               _loc6_ = 0;
               while(_loc6_ <= 150)
               {
                  if(!_loc4_["guanKa"][_loc6_])
                  {
                     Main.guanKa[_loc6_] = 0;
                  }
                  else
                  {
                     Main.guanKa[_loc6_] = _loc4_["guanKa"][_loc6_];
                  }
                  if(Main.guanKa[_loc6_] is Boolean)
                  {
                     if(Main.guanKa[_loc6_] == true)
                     {
                        Main.guanKa[_loc6_] = 1;
                     }
                     else
                     {
                        Main.guanKa[_loc6_] = 0;
                     }
                  }
                  _loc6_++;
               }
               if(Main.guanKa[1] != 0 && Main.guanKa[1] != 1 && Main.guanKa[1] != 2 && Main.guanKa[1] != 3)
               {
                  Main.guanKa[1] = 1;
               }
               Main.questArr = _loc4_["questArr"];
               Main.verify = _loc4_["verify"];
               if(Main.P1P2)
               {
                  x = 2;
               }
               else
               {
                  x = 1;
               }
               if(_loc4_["InitDataX"])
               {
                  InitData.LoadInitData(_loc4_["InitDataX"]);
               }
               if(_loc4_["buyTime"])
               {
                  Data_KillShop.buyTime = _loc4_["buyTime"];
                  Data_KillShop.buyArr = _loc4_["buyArr"];
                  ShopKillPoint.KaiQiShopArr2 = _loc4_["KaiQiShopArr2"];
               }
               if(_loc4_["RenWu"])
               {
                  TaskData.saveArr = _loc4_["RenWu"];
               }
               if(_loc4_["MakeData"])
               {
                  MakeData.duMake(_loc4_["MakeData"]);
               }
               _loc6_ = 1;
               while(_loc6_ <= x)
               {
                  Main["player" + _loc6_] = _loc4_["p" + _loc6_] as PlayerData;
                  _loc6_++;
               }
               if(Boolean(_loc4_["lingQueArr"]) && _loc4_["lingQueArr"].length == 11)
               {
                  lingQueArr = _loc4_["lingQueArr"];
               }
               if(Boolean(_loc4_["lingQueArr2"]) && _loc4_["lingQueArr2"].length == 11)
               {
                  lingQueArr2 = _loc4_["lingQueArr2"];
               }
               if(_loc4_["TeShuHuoDongArr"])
               {
                  TeShuHuoDong.TeShuHuoDongArr = _loc4_["TeShuHuoDongArr"];
               }
               TeShuHuoDong.Init();
               if(_loc4_["xuansang"])
               {
                  Main.wts = _loc4_["xuansang"];
               }
               if(_loc4_["kaPian"])
               {
                  CardPanel.monsterSlot = _loc4_["kaPian"];
               }
               if(_loc4_["shengdan"])
               {
                  shengdan = _loc4_["shengdan"];
               }
               if(_loc4_["shengdanTimes"])
               {
                  shengdanTimes = _loc4_["shengdanTimes"];
               }
               if(_loc4_["huaZhi"])
               {
                  Play_Interface.huaZhi = _loc4_["huaZhi"];
               }
               if(_loc4_["Map0_YN"])
               {
                  Main.Map0_YN = _loc4_["Map0_YN"];
               }
               if(_loc4_["Map0_YN2"])
               {
                  Main.Map0_YN2 = _loc4_["Map0_YN2"];
               }
               if(_loc4_["water"])
               {
                  Main.water = _loc4_["water"];
               }
               if(_loc4_["LuoPanSuiPian"])
               {
                  Main.LuoPanArr = _loc4_["LuoPanSuiPian"];
               }
               if(_loc4_["XinglingUp"])
               {
                  XingLingFactory.xingLingData = _loc4_["XinglingUp"];
               }
               if(_loc4_["JiHua"])
               {
                  PlanFactory.JiHuaData = _loc4_["JiHua"];
               }
               if(_loc4_["vipUserArr"])
               {
                  Vip_Interface.vipUserArr = _loc4_["vipUserArr"];
               }
               if(_loc4_["TaskDataBoXX5"])
               {
                  TaskData.BoXX = _loc4_["TaskDataBoXX5"];
               }
               Vip_Interface.SetData();
               SaveXX.TestGoldMax();
               Strat.startGame();
               break;
            case SaveEvent.SAVE_SET:
               if(param1.ret as Boolean == true)
               {
                  if(Main.saveMc_YN)
                  {
                     NewMC.Open("保存成功",this);
                     xilianPanel.xlPanel["xilian_ZZ"].visible = false;
                     xilianPanel.xlPanel["xl_btn"].visible = true;
                     Main.SaveFun();
                  }
               }
               break;
            case SaveEvent.SAVE_LIST:
               _loc5_ = param1.ret as Array;
               loadSaveOver = true;
               trace("读取存档列表------->" + _loc5_);
               if(_loc5_ == null)
               {
                  trace("存档列表 null");
                  _loc6_ = 0;
                  while(_loc6_ < 8)
                  {
                     Strat.SAVE_LIST[_loc6_] = "空存档";
                     _loc6_++;
                  }
               }
               else
               {
                  for(_loc6_ in _loc5_)
                  {
                     _loc7_ = _loc5_[_loc6_];
                     if(_loc7_ == null)
                     {
                        Strat.SAVE_LIST[_loc6_] = "空存档";
                     }
                     else
                     {
                        _loc2_ = "存档的位置:" + _loc7_.index + "存档时间:" + _loc7_.datetime + "存档标题:" + _loc7_.title;
                        trace(_loc2_);
                        Strat.SAVE_LIST[int(_loc7_.index)] = _loc7_.title + "\n" + _loc7_.datetime;
                     }
                  }
               }
               Shop_LiBao.subString();
               break;
            case "logreturn":
               userId = param1.ret.uid;
               logName = param1.ret.name;
               logYN = true;
               if(!loadSaveOver)
               {
                  Main.serviceHold.getList();
               }
         }
      }
      
      private function multipleErrorHandler(param1:Event) : void
      {
         TiaoShi.txtShow("游戏多开了!");
         DuoKai_Info.Open();
      }
      
      private function getStoreStateHandler(param1:Event) : void
      {
         switch(param1.data)
         {
            case "1":
               duoKai_num = 0;
               TiaoShi.txtShow("多开检测正常!");
               if(saveStop[0])
               {
                  saveStop[0] = false;
                  Save2(saveStop[1]);
               }
               if(Shop4399.duokai_Buy)
               {
                  Shop4399.duokai_Buy = false;
                  Shop4399.BuyObj();
               }
               break;
            case "0":
               DuoKai_Info.Open(1);
               break;
            case "-1":
               if(duoKai_num > 3)
               {
                  DuoKai_Info.Open(2);
               }
               else
               {
                  DuoKai_Fun();
                  ++duoKai_num;
               }
               break;
            case "-2":
               DuoKai_Info.Open(2);
               break;
            case "-3":
               DuoKai_Info.Open(2);
         }
      }
      
      private function onGetServerTimeHandler(param1:DataEvent) : void
      {
         if(param1.data == "")
         {
            ServerTimeNum = 0;
            GetServerTime();
            return;
         }
         var _loc2_:String = param1.data.substr(0,4) + param1.data.substr(5,2) + param1.data.substr(8,2);
         serverTime.setValue(int(_loc2_));
         trace("当前服务器时间为:" + param1.data);
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
         trace("关卡:" + Main.gameNum.getValue(),Main.gameNum2.getValue());
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
            player_1.x = 220;
            if(player_1.hp.getValue() > 0)
            {
               player_1.y = 400;
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
            player_2.x = 180;
            if(player_1.hp.getValue() > 0)
            {
               player_1.y = 400;
            }
            else
            {
               player_1.y = -50;
            }
            player_2.y = 400;
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
         Main.GetServerTime();
         --Shop4399.SelMoneyTime;
      }
   }
}

