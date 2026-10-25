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
   import com.hotpoint.braveManIII.repository.probability.*;
   import com.hotpoint.braveManIII.views.equipShopPanel.*;
   import com.hotpoint.braveManIII.views.itemsPanel.*;
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
      
      public static var P1P2:Boolean;
      
      public static var _stageHeight:int;
      
      public static var _stageWidth:int;
      
      public static var varX:int;
      
      public static var player_1:Player;
      
      public static var player_2:Player;
      
      public static var world:Map;
      
      public static var player1:PlayerData;
      
      public static var player2:PlayerData;
      
      public static var verify:int;
      
      public static var _this:*;
      
      public static var _stage:*;
      
      public static var fps:int = 30;
      
      public static var gameNum:int = 0;
      
      public static var gameNum2:int = 0;
      
      public static var guanKa:Array = [];
      
      public static var saveNum:int = -1;
      
      public static var questArr:Array = [[false,84110],[false,84111],[false,84112],[false,84113],[false,84114]];
      
      public static var serviceHold:* = null;
      
      private var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
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
      
      public static function Save() : *
      {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:String = null;
         _loc1_ = "P1:Lv" + player1.getLevel();
         if(Main.P1P2)
         {
            _loc1_ += " / P2:Lv" + player2.getLevel();
         }
         _loc2_ = new Object();
         _loc3_ = 1;
         if(Main.P1P2)
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 1;
         }
         _loc4_ = 1;
         while(_loc4_ <= _loc3_)
         {
            _loc2_["p" + _loc4_] = new Object();
            _loc2_["p" + _loc4_] = Main["player" + _loc4_];
            _loc4_++;
         }
         _loc2_["P1P2"] = Main.P1P2;
         _loc2_["changKu"] = StoragePanel.storage;
         _loc2_["guanKa"] = Main.guanKa;
         _loc2_["questArr"] = Main.questArr;
         _loc2_["var"] = 1;
         _loc2_["verify"] = Math.random() * 9999;
         _loc5_ = new ByteArray();
         _loc5_.writeObject(_loc2_);
         _loc5_.position = 0;
         _loc6_ = Base64.encodeByteArray(_loc5_);
         if(Main.saveNum == -1)
         {
            Main.serviceHold.saveData(_loc1_,_loc6_);
         }
         else
         {
            Main.serviceHold.saveData(_loc1_,_loc6_,false,Main.saveNum);
         }
      }
      
      public static function setQuest(param1:Number) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
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
      
      public static function getQuest(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
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
         registerClassAlias("VT",VT);
      }
      
      private function AddMap() : *
      {
         var _loc1_:String = null;
         var _loc2_:Class = null;
         _loc1_ = "Map_" + gameNum + "_" + gameNum2;
         _loc2_ = Map.MapArr[gameNum].getClass(_loc1_ as String) as Class;
         world = new _loc2_();
         addChild(Main.world);
         Main._stage.stageFocusRect = false;
         Main._stage.focus = Main.world;
      }
      
      public function Loading() : *
      {
         Load.Open();
         addEventListener(Event.ENTER_FRAME,onLoading);
      }
      
      private function netSaveErrorHandler(param1:Event) : void
      {
         trace("网络存档失败了！");
      }
      
      public function InitXX(param1:* = null) : *
      {
         var _loc2_:fpsBox = null;
         MusicBox.MusicPlay("封面声音");
         removeEventListener(Event.ADDED_TO_STAGE,InitXX);
         _loc2_ = new fpsBox();
         _loc2_.x = 10;
         _loc2_.y = 610;
         addChild(_loc2_);
         regAllClass();
         onADDED_TO_STAGE();
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
               _loc2_ = String(param1.ret.data);
               _loc3_ = Base64.decodeToByteArray(_loc2_) as ByteArray;
               _loc3_.position = 0;
               Main.saveNum = param1.ret.index;
               _loc4_ = _loc3_.readObject();
               Main.P1P2 = _loc4_["P1P2"];
               if(_loc4_["changKu"])
               {
                  StoragePanel.storage = _loc4_["changKu"];
               }
               else
               {
                  StoragePanel.storage = Storage.createStorage();
               }
               Main.guanKa = _loc4_["guanKa"];
               Main.questArr = _loc4_["questArr"];
               Main.varX = _loc4_["var"];
               Main.verify = _loc4_["verify"];
               if(Main.P1P2)
               {
                  x = 2;
               }
               else
               {
                  x = 1;
               }
               _loc6_ = 1;
               while(_loc6_ <= x)
               {
                  Main["player" + _loc6_] = _loc4_["p" + _loc6_] as PlayerData;
                  _loc6_++;
               }
               Strat.startGame();
               break;
            case SaveEvent.SAVE_SET:
               trace("存档------------->" + param1.ret);
               if(param1.ret as Boolean == true)
               {
                  Info_txt.text += "\n存档成功? ------>" + Main.saveNum;
                  NewMC.Open("保存成功",this);
               }
               break;
            case SaveEvent.SAVE_LIST:
               _loc5_ = param1.ret as Array;
               if(_loc5_ == null)
               {
                  break;
               }
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
      }
      
      private function onADDED_TO_STAGE(param1:* = null) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,onADDED_TO_STAGE);
         stage.addEventListener(SaveEvent.SAVE_GET,saveProcess);
         stage.addEventListener(SaveEvent.SAVE_SET,saveProcess);
         stage.addEventListener(SaveEvent.SAVE_LIST,saveProcess);
         stage.addEventListener("logreturn",logedHandler);
         stage.addEventListener("netSaveError",netSaveErrorHandler,false,0,true);
         stage.addEventListener("MVC_CLOSE_PANEL",closePanelHandler);
         stage.addEventListener("userLoginOut",onUserLogOutHandler,false,0,true);
         stage.addEventListener("logreturn",saveProcess);
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
      }
      
      public function setHold(param1:*) : void
      {
         serviceHold = param1;
      }
      
      private function onUserLogOutHandler(param1:Event) : void
      {
         trace("用户退出登录了");
         Info_txt.text += "\n 退出登录";
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
         GameData.GetData();
         Play_Interface.Open();
         addEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         trace("关卡:" + Main.gameNum,Main.gameNum2);
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
      
      public function DelGame() : *
      {
         removeEventListener(Event.ENTER_FRAME,onENTER_FRAME);
         Enemy.All = new Array();
         Player.All = new Array();
         HitXX.AllHitXX = new Array();
         if(Main.world)
         {
            Main.world.parent.removeChild(Main.world);
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
      
      private function closePanelHandler(param1:Event) : void
      {
         var _loc2_:Object = null;
         Info_txt.text += "\n 关闭登录";
         _loc2_ = serviceHold.isLog;
         if(_loc2_ == null)
         {
            showLogUi();
         }
      }
      
      private function AddPlayer(param1:int = 1) : *
      {
         var _loc2_:PlayerData = null;
         if(param1 == 1)
         {
            if(!player_1)
            {
               player_1 = new Player();
               _loc2_ = Main.player1;
               trace(Main.player1);
               if(Main.player1)
               {
                  player_1.data = Main.player1;
               }
               else
               {
                  player_1.data = Main.player1 = PlayerData.creatPlayerData(1);
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
         if(Main.gameNum != 0)
         {
            HitXX.HitEnemy();
            GameData.MonsterGo();
         }
      }
      
      private function logedHandler(param1:SaveEvent) : void
      {
         Info_txt.text += "\n 检查登录 = " + param1.ret;
         if(param1.ret)
         {
            Info_txt.text += "\n 已登录!! = " + param1.ret;
            Main.serviceHold.getList();
            if(Strat.isGetData)
            {
               return;
            }
         }
      }
   }
}

