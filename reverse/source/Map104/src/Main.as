package src
{
   import com.*;
   import com.ByteArrayXX.*;
   import com.efnx.fps.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.player.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.models.skill.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.probability.*;
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
   import com.hotpoint.braveManIII.views.npcTaskPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.setProfession.*;
   import com.hotpoint.braveManIII.views.setTransfer.*;
   import com.hotpoint.braveManIII.views.skillPanel.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import com.hotpoint.braveManIII.views.strengthenPanel.*;
   import com.hotpoint.braveManIII.views.suppliesShopPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   import src.npc.*;
   import unit4399.events.*;
   
   public class Main extends MovieClip
   {
      
      public static var varX_old:*;
      
      public static var P1P2:Boolean;
      
      public static var _stageHeight:int;
      
      public static var _stageWidth:int;
      
      public static var varX:int;
      
      public static var world:Map;
      
      public static var _stage:*;
      
      public static var player_1:Player;
      
      public static var player_2:Player;
      
      public static var player1:PlayerData;
      
      public static var player2:PlayerData;
      
      public static var verify:int;
      
      public static var _this:*;
      
      public static var fps:int = 30;
      
      public static var gameNum:int = 0;
      
      public static var gameNum2:int = 0;
      
      public static var guanKa:Array = [];
      
      public static var saveNum:int = -1;
      
      public static var stopXX:Boolean = false;
      
      public static var loadSaveOver:Boolean = false;
      
      public static var serverTime:VT = VT.createVT();
      
      public static var black:遮罩 = new 遮罩();
      
      public static var serviceHold:* = null;
      
      public static var questArr:Array = [[false,84110],[false,84111],[false,84112],[false,84113],[false,84114]];
      
      public static var tempDataEnd:Boolean = false;
      
      internal var _4399_function_shop_id:String = "30ea6b51a23275df624b781c3eb43ac6";
      
      private var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
      internal var _4399_function_payMoney_id:String = "10f73c09b41d9f41e761232f5f322f38";
      
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
         var xx:* = undefined;
         xx = new ClassLoader("TempData_v9.swf");
         xx.addEventListener(Event.COMPLETE,onLoadArrEND);
      }
      
      public static function Save() : *
      {
         var titleX:String = null;
         var objX:Object = null;
         var x:int = 0;
         var i:int = 0;
         var byte:ByteArray = null;
         var tmpStr:String = null;
         titleX = "P1:Lv" + player1.getLevel();
         if(Main.P1P2)
         {
            titleX += " / P2:Lv" + player2.getLevel();
         }
         objX = new Object();
         x = 1;
         if(Main.P1P2)
         {
            x = 2;
         }
         else
         {
            x = 1;
         }
         for(i = 1; i <= x; i++)
         {
            objX["p" + i] = new Object();
            objX["p" + i] = Main["player" + i];
         }
         objX["P1P2"] = Main.P1P2;
         objX["changKu"] = StoragePanel.storage;
         objX["guanKa"] = Main.guanKa;
         objX["questArr"] = Main.questArr;
         objX["var"] = Main.varX;
         objX["verify"] = Math.random() * 9999;
         objX["InitDataX"] = InitData.SaveInitData();
         objX["TaskS"] = NpcTaskData.saveTask();
         byte = new ByteArray();
         byte.writeObject(objX);
         byte.position = 0;
         tmpStr = Base64.encodeByteArray(byte);
         if(Main.saveNum == -1)
         {
            Main.serviceHold.saveData(titleX,tmpStr);
         }
         else
         {
            Main.serviceHold.saveData(titleX,tmpStr,false,Main.saveNum);
         }
      }
      
      public static function setQuest(fallLevel:Number) : void
      {
         var i:uint = 0;
         for(i = 0; i < questArr.length; i++)
         {
            if(questArr[i][1] == fallLevel)
            {
               questArr[i][0] = true;
               break;
            }
         }
      }
      
      private static function onLoadArrEND(e:* = null) : *
      {
         tempDataEnd = true;
      }
      
      public static function getQuest(fallLevel:Number) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < questArr.length; i++)
         {
            if(questArr[i][1] == fallLevel)
            {
               return questArr[i][0];
            }
         }
         return false;
      }
      
      public static function getAllQuest() : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < questArr.length; i++)
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
         var i:uint = 0;
         for(i = 0; i < questArr.length; i++)
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
         registerClassAlias("VT",VT);
      }
      
      private function AddMap() : *
      {
         var className:String = null;
         var classRef:Class = null;
         className = "Map_" + gameNum + "_" + gameNum2;
         classRef = Map.MapArr[gameNum].getClass(className as String) as Class;
         world = new classRef();
         addChild(Main.world);
         Main._stage.stageFocusRect = false;
         Main._stage.focus = Main.world;
      }
      
      public function Loading() : *
      {
         Load.Open();
         addEventListener(Event.ENTER_FRAME,onLoading);
      }
      
      private function netSaveErrorHandler(evt:Event) : void
      {
         trace("网络存档失败了！");
      }
      
      public function InitXX(e:* = null) : *
      {
         var fpsX:fpsBox = null;
         removeEventListener(Event.ADDED_TO_STAGE,InitXX);
         _stage = stage;
         _this = this;
         InitData.Init();
         MusicBox.MusicPlay("封面声音");
         fpsX = new fpsBox();
         fpsX.x = 10;
         fpsX.y = 610;
         addChild(fpsX);
         regAllClass();
         onADDED_TO_STAGE();
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
               Main.P1P2 = objXX["P1P2"];
               if(objXX["changKu"])
               {
                  StoragePanel.storage = objXX["changKu"];
               }
               else
               {
                  StoragePanel.storage = Storage.createStorage();
               }
               Main.guanKa = objXX["guanKa"];
               Main.questArr = objXX["questArr"];
               Main.varX_old = objXX["var"];
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
               if(objXX["TaskS"])
               {
                  NpcTaskData.duTask();
               }
               for(i = 1; i <= x; i++)
               {
                  Main["player" + i] = objXX["p" + i] as PlayerData;
               }
               Strat.startGame();
               break;
            case SaveEvent.SAVE_SET:
               if(e.ret as Boolean == true)
               {
                  NewMC.Open("保存成功",this);
               }
               break;
            case SaveEvent.SAVE_LIST:
               data = e.ret as Array;
               if(data == null)
               {
                  break;
               }
               loadSaveOver = true;
               for(i in data)
               {
                  obj = data[i];
                  if(obj == null)
                  {
                     Strat.SAVE_LIST[i] = "空存档";
                  }
                  else
                  {
                     tmpStr = "存档的位置:" + obj.index + "存档时间:" + obj.datetime + "存档标题:" + obj.title;
                     trace(tmpStr);
                     Strat.SAVE_LIST[int(obj.index)] = obj.title + "\n" + obj.datetime;
                  }
               }
         }
      }
      
      private function onADDED_TO_STAGE() : *
      {
         stage.addEventListener(SaveEvent.SAVE_GET,saveProcess);
         stage.addEventListener(SaveEvent.SAVE_SET,saveProcess);
         stage.addEventListener(SaveEvent.SAVE_LIST,saveProcess);
         stage.addEventListener("logreturn",logedHandler);
         stage.addEventListener("netSaveError",netSaveErrorHandler,false,0,true);
         stage.addEventListener("MVC_CLOSE_PANEL",closePanelHandler);
         stage.addEventListener("userLoginOut",onUserLogOutHandler,false,0,true);
         stage.addEventListener("logreturn",saveProcess);
         stage.addEventListener("serverTimeEvent",onGetServerTimeHandler);
         Main.fps = stage.frameRate;
         trace("游戏帧数设定:" + Main.fps);
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
      
      private function onGetServerTimeHandler(evt:DataEvent) : void
      {
         var xx:String = null;
         trace("当前服务器时间为：" + evt.data);
         xx = evt.data.substr(0,4) + evt.data.substr(5,2) + evt.data.substr(8,2);
         serverTime.setValue(int(xx));
      }
      
      public function setHold(hold:*) : void
      {
         serviceHold = hold;
      }
      
      private function onUserLogOutHandler(evt:Event) : void
      {
         trace("用户退出登录了");
         navigateToURL(new URLRequest("javascript:location.reload(); "),"_self");
      }
      
      public function GameStart() : *
      {
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
         Main._stage.addChild(black);
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         trace("关卡:" + Main.gameNum,Main.gameNum2);
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
      
      public function DelGame() : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         Enemy.All = new Array();
         Player.All = new Array();
         HitXX.AllHitXX = new Array();
         if(Main.world)
         {
            Main.world.parent.removeChild(Main.world);
            Main.world.y = 5000;
            Main.world = null;
         }
      }
      
      public function showLogUi() : void
      {
         if(serviceHold)
         {
            serviceHold.showLogPanel();
         }
      }
      
      public function GetServerTime() : *
      {
         if(serviceHold)
         {
            serviceHold.getServerTime();
         }
      }
      
      private function closePanelHandler(e:Event) : void
      {
         var logInfo:Object = null;
         logInfo = serviceHold.isLog;
         if(logInfo == null)
         {
            showLogUi();
         }
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
         if(Main.gameNum != 0)
         {
            HitXX.HitEnemy();
            GameData.MonsterGo();
            ++WinShow.txt_1;
         }
      }
      
      private function logedHandler(evt:SaveEvent) : void
      {
         if(evt.ret)
         {
            Info_txt.text += "\n 已登录!! = " + evt.ret;
            if(!loadSaveOver)
            {
               Main.serviceHold.getList();
            }
         }
         GetServerTime();
      }
   }
}

