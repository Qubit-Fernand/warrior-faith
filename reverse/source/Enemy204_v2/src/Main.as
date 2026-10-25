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
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.pet.*;
   import com.hotpoint.braveManIII.models.player.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.models.skill.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.models.title.*;
   import com.hotpoint.braveManIII.models.wantedTask.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.probability.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
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
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
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
      
      public static var black:BlackXX = new BlackXX();
      
      public static var userId:uint = 0;
      
      public static var logName:String = "";
      
      public static var logNameSave:String = "";
      
      public static var logYN:Boolean = false;
      
      public static var NoLog:int = 0;
      
      public static var NoLogInfo:Array = new Array();
      
      public static var tianShiYN:Boolean = false;
      
      public static var noSave:Boolean = false;
      
      public static var serviceHold:* = null;
      
      public static var questArr:Array = [[false,84110],[false,84111],[false,84112],[false,84113],[false,84114]];
      
      public static var tempDataEnd:Boolean = false;
      
      public static var saveMc_YN:Boolean = true;
      
      public static var p1Slot_numXX:int = -99;
      
      public static var p1BAG_numXX:int = -99;
      
      private var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
      internal var _4399_function_payMoney_id:String = "10f73c09b41d9f41e761232f5f322f38";
      
      internal var _4399_function_shop_id:String = "30ea6b51a23275df624b781c3eb43ac6";
      
      internal var _4399_function_rankList_id:String = "69f52ab6eb1061853a761ee8c26324ae";
      
      public function Main()
      {
         super();
         if(stage)
         {
            InitXX();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,InitXX);
         }
      }
      
      public static function LoadTempDataArr() : *
      {
         TempData.Init();
         tempDataEnd = true;
      }
      
      public static function Save(bool:Boolean = true) : *
      {
         saveMc_YN = bool;
         if(noSave)
         {
            return;
         }
         var titleX:String = "";
         titleX += "P1:Lv" + player1.getLevel();
         if(Main.P1P2)
         {
            titleX += " / P2:Lv" + player2.getLevel();
         }
         var objX:Object = new Object();
         objX["var"] = Main.varX;
         if(Main.logNameSave == "" && Main.varX_old < 182)
         {
            objX["logNameSave"] = MD5contrast.SaveStr(logName.toLocaleLowerCase(),saveNum);
         }
         else
         {
            objX["logNameSave"] = Main.logNameSave;
         }
         objX["NoLog"] = Main.NoLog;
         objX["NoLogInfo"] = Main.NoLogInfo;
         var x:int = 1;
         if(Main.P1P2)
         {
            x = 2;
         }
         else
         {
            x = 1;
         }
         for(var i:int = 1; i <= x; i++)
         {
            objX["p" + i] = new Object();
            objX["p" + i] = Main["player" + i];
         }
         objX["P1P2"] = Main.P1P2;
         objX["changKu"] = StoragePanel.storage;
         objX["guanKa"] = Main.guanKa;
         objX["questArr"] = Main.questArr;
         objX["verify"] = Math.random() * 9999;
         objX["InitDataX"] = InitData.SaveInitData();
         objX["RenWu"] = TaskData.saveTask();
         objX["buyTime"] = Data_KillShop.buyTime;
         objX["buyArr"] = Data_KillShop.buyArr;
         objX["KaiQiShopArr2"] = ShopKillPoint.KaiQiShopArr2;
         objX["MakeData"] = MakeData.saveMake();
         objX["lingQueArr"] = lingQueArr;
         objX["lingQueArr2"] = lingQueArr2;
         objX["TeShuHuoDongArr"] = TeShuHuoDong.TeShuHuoDongArr;
         objX["chengjiu"] = AchData.save();
         objX["xuansang"] = Main.wts;
         var byte:ByteArray = new ByteArray();
         byte.writeObject(objX);
         byte.position = 0;
         var tmpStr:String = Base64.encodeByteArray(byte);
         if(Main.saveNum == -1)
         {
            Main.serviceHold.saveData(titleX,tmpStr);
         }
         else
         {
            Main.serviceHold.saveData(titleX,tmpStr,false,Main.saveNum);
         }
      }
      
      public static function GetServerTime() : *
      {
         if(serviceHold)
         {
            serviceHold.getServerTime();
         }
      }
      
      public static function allClosePanel() : *
      {
         SuppliesShopPanel.close();
         StrengthenPanel.close();
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
         ElvesPanel.close();
         PK_UI.Close();
         PK_UI_Sel.Close();
      }
      
      public static function getQuest(fallLevel:Number) : Boolean
      {
         for(var i:uint = 0; i < questArr.length; i++)
         {
            if(questArr[i][1] == fallLevel)
            {
               return questArr[i][0];
            }
         }
         return false;
      }
      
      public static function setQuest(fallLevel:Number) : void
      {
         for(var i:uint = 0; i < questArr.length; i++)
         {
            if(questArr[i][1] == fallLevel)
            {
               questArr[i][0] = true;
               break;
            }
         }
      }
      
      public static function getAllQuest() : Boolean
      {
         for(var i:uint = 0; i < questArr.length; i++)
         {
            if(questArr[i][0])
            {
               return true;
            }
         }
         return false;
      }
      
      public static function questBag() : Boolean
      {
         for(var i:uint = 0; i < questArr.length; i++)
         {
            if(Boolean(Main.player1) && Main.player1.getBag().fallQusetBag(questArr[i][1]) > 0)
            {
               return true;
            }
            if(Boolean(Main.P1P2) && Boolean(Main.player2) && Main.player2.getBag().fallQusetBag(questArr[i][1]) > 0)
            {
               return true;
            }
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
         return false;
      }
      
      public static function JiaoYanNoLog() : *
      {
         var i:int = 0;
         if(NoLog == 2)
         {
            return;
         }
         if(Shop4399.totalRecharged.getValue() != -1)
         {
            if(Shop4399.totalRecharged.getValue() > InitData.no_jiaoYan.getValue())
            {
               return;
            }
            p1Slot_numXX = -99;
            p1BAG_numXX = -99;
            NoLog = 0;
            if(Shop4399.totalRecharged.getValue() < InitData.jiaoYan_num.getValue())
            {
               for(i = 0; i < 6; i++)
               {
                  if(player1.getEquipSlot().getEquipFromSlot(i) != null && player1.getEquipSlot().getEquipFromSlot(i).getReinforceLevel() > 9)
                  {
                     NoLog = 1;
                     p1Slot_numXX = i;
                     return;
                  }
                  if(P1P2 && player2.getEquipSlot().getEquipFromSlot(i) != null && player2.getEquipSlot().getEquipFromSlot(i).getReinforceLevel() > 9)
                  {
                     NoLog = 1;
                     return;
                  }
               }
            }
         }
      }
      
      public function setHold(hold:*) : void
      {
         serviceHold = hold;
      }
      
      public function InitXX(e:* = null) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,InitXX);
         _stage = stage;
         _this = this;
         InitData.Init();
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
         stage.quality == StageQuality.MEDIUM;
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
      
      private function closePanelHandler(e:Event) : void
      {
         var logInfo:Object = serviceHold.isLog;
         if(logInfo == null)
         {
            showLogUi();
         }
      }
      
      public function showLogUi() : void
      {
         var logInfo:Object = null;
         if(serviceHold)
         {
            logInfo = serviceHold.isLog;
            if(logInfo == null)
            {
               serviceHold.showLogPanel();
            }
         }
      }
      
      private function netSaveErrorHandler(evt:Event) : void
      {
      }
      
      private function onUserLogOutHandler(evt:Event) : void
      {
         navigateToURL(new URLRequest("javascript:location.reload(); "),"_self");
      }
      
      private function saveProcess(e:SaveEvent) : void
      {
         var tmpStr:String = null;
         var newByteArray:ByteArray = null;
         var objXX:Object = null;
         var data:Array = null;
         var i:int = 0;
         var obj:Object = null;
         switch(e.type)
         {
            case SaveEvent.SAVE_GET:
               tmpStr = String(e.ret.data);
               newByteArray = Base64.decodeToByteArray(tmpStr) as ByteArray;
               newByteArray.position = 0;
               Main.saveNum = e.ret.index;
               objXX = newByteArray.readObject();
               Main.varX_old = objXX["var"];
               if(objXX["logNameSave"])
               {
                  logNameSave = objXX["logNameSave"];
               }
               NoLog = 0;
               if(objXX["NoLog"])
               {
                  NoLog = objXX["NoLog"];
               }
               if(Boolean(objXX["NoLogInfo"]) && !(objXX["NoLogInfo"] is Array))
               {
                  objXX["NoLogInfo"] = null;
               }
               if(objXX["NoLogInfo"])
               {
                  Main.NoLogInfo = objXX["NoLogInfo"];
               }
               if(JiaoYan() != true || JiaoYan2() != true)
               {
                  return;
               }
               Main.P1P2 = objXX["P1P2"];
               if(objXX["changKu"])
               {
                  StoragePanel.storage = objXX["changKu"];
               }
               if(objXX["chengjiu"])
               {
                  if(Main.varX_old > 275)
                  {
                     AchData.xxx = objXX["chengjiu"];
                  }
               }
               for(i = 0; i < 151; i++)
               {
                  if(!objXX["guanKa"][i])
                  {
                     Main.guanKa[i] = 0;
                  }
                  else
                  {
                     Main.guanKa[i] = objXX["guanKa"][i];
                  }
                  if(Main.guanKa[i] is Boolean)
                  {
                     if(Main.guanKa[i] == true)
                     {
                        Main.guanKa[i] = 1;
                     }
                     else
                     {
                        Main.guanKa[i] = 0;
                     }
                  }
               }
               if(Main.guanKa[1] != 0 && Main.guanKa[1] != 1 && Main.guanKa[1] != 2 && Main.guanKa[1] != 3)
               {
                  Main.guanKa[1] = 1;
               }
               Main.questArr = objXX["questArr"];
               Main.verify = objXX["verify"];
               if(Main.P1P2)
               {
                  x = 2;
               }
               else
               {
                  x = 1;
               }
               if(objXX["InitDataX"])
               {
                  InitData.LoadInitData(objXX["InitDataX"]);
               }
               if(objXX["buyTime"])
               {
                  Data_KillShop.buyTime = objXX["buyTime"];
                  Data_KillShop.buyArr = objXX["buyArr"];
                  ShopKillPoint.KaiQiShopArr2 = objXX["KaiQiShopArr2"];
               }
               if(objXX["RenWu"])
               {
                  TaskData.saveArr = objXX["RenWu"];
               }
               if(objXX["MakeData"])
               {
                  MakeData.duMake(objXX["MakeData"]);
               }
               for(i = 1; i <= x; i++)
               {
                  Main["player" + i] = objXX["p" + i] as PlayerData;
               }
               if(Boolean(objXX["lingQueArr"]) && objXX["lingQueArr"].length == 11)
               {
                  lingQueArr = objXX["lingQueArr"];
               }
               if(Boolean(objXX["lingQueArr2"]) && objXX["lingQueArr2"].length == 11)
               {
                  lingQueArr2 = objXX["lingQueArr2"];
               }
               if(objXX["TeShuHuoDongArr"])
               {
                  TeShuHuoDong.TeShuHuoDongArr = objXX["TeShuHuoDongArr"];
               }
               TeShuHuoDong.Init();
               if(objXX["xuansang"])
               {
                  Main.wts = objXX["xuansang"];
               }
               SaveXX.TestGoldMax();
               Strat.startGame();
               break;
            case SaveEvent.SAVE_SET:
               if(e.ret as Boolean == true)
               {
                  if(Main.saveMc_YN)
                  {
                     NewMC.Open("保存成功",this);
                  }
               }
               break;
            case SaveEvent.SAVE_LIST:
               data = e.ret as Array;
               loadSaveOver = true;
               if(data == null)
               {
                  for(i = 0; i < 8; i++)
                  {
                     Strat.SAVE_LIST[i] = "空存档";
                  }
               }
               else
               {
                  for(i in data)
                  {
                     obj = data[i];
                     if(obj == null)
                     {
                        Strat.SAVE_LIST[i] = "空存档";
                     }
                     else
                     {
                        Strat.SAVE_LIST[int(obj.index)] = obj.title + "\n" + obj.datetime;
                     }
                  }
               }
               Shop_LiBao.subString();
               break;
            case "logreturn":
               userId = e.ret.uid;
               logName = e.ret.name;
               logYN = true;
               if(!loadSaveOver)
               {
                  Main.serviceHold.getList();
               }
         }
      }
      
      private function multipleErrorHandler(evt:Event) : void
      {
         TiaoShi.txtShow("游戏多开了!");
      }
      
      private function onGetServerTimeHandler(evt:DataEvent) : void
      {
         if(evt.data == "")
         {
            GetServerTime();
            return;
         }
         var xx:String = evt.data.substr(0,4) + evt.data.substr(5,2) + evt.data.substr(8,2);
         serverTime.setValue(int(xx));
         Data_KillShop.BuyArrInit();
         AchData.upPoint();
      }
      
      public function Loading() : *
      {
         Load.Open();
         addEventListener(Event.ENTER_FRAME,onLoading);
      }
      
      private function onLoading(e:*) : *
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
         Play_Interface.BossLifeYN = false;
         MakeData.initAllMake();
         AchData.getAllAch();
         TaskData.initAllTask();
         Main.GetServerTime();
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
         var className:String = GameData.SelMapName();
         var classRef:Class = Map.MapArr[gameNum.getValue()].getClass(className as String) as Class;
         world = new classRef();
         addChild(Main.world);
         stage.addChild(Main.black);
         Main._stage.stageFocusRect = false;
         Main._stage.focus = Main.world;
      }
      
      private function AddPlayer(num:int = 1) : *
      {
         if(num == 1)
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
         else if(num == 2)
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
      
      private function onENTER_FRAME(e:Event) : *
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
      }
   }
}

