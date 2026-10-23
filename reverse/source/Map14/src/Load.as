package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Load extends MovieClip
   {
      
      public static var loadingX:Load;
      
      public static var percentLoaded:int;
      
      public static var All_Loaded:Boolean;
      
      private static var DataLoaded:Boolean;
      
      public static var XMLclass:ClassLoader;
      
      public static var XMLclass2:ClassLoader;
      
      public static var loadName:String = "";
      
      public static var loadName2:String = "19";
      
      public static var txtArr:Array = ["右手的武器需要将背包中的武器拖动到右手武器槽里才能替换","点击“菜单”栏内的“键位设置”按钮可以设置游戏快捷键","在关卡中可以点击“菜单”栏内的“返回城镇”按钮快速回城","玩家等级达到25级并且拥有“胜利的凭证”与“8000金币”，即可在奥古斯汀处进行转职","转职之后可以学习更多更炫的转职技能","您只能从两个职业中选择一个进行转职","女神碎片可在“冰雪废墟”、“废弃都市”与“幽灵船”关卡内获得","每为女神像修补一块女神碎片便可以开启一个神秘副本","获得女神像碎片后，只需点击女神像相应缺口即可对女神像进行修补","神秘副本的Boss鳄鱼公爵有一定机率掉落转职物品“胜利的凭证”","可以通过“镶嵌属性石”让装备更加强劲","1P和2P的仓库是共用的，可以通过仓库进行1P、2P间的物品交换","“装备商人—道格拉斯”可以进行“强化”“合成”“镶嵌”等功能","如果游戏过程比较卡，可以适当降低游戏画质","在“技能导师—奥古斯汀”处可学习各系职业的“主动技能”和“被动技能”","如果游戏卡在加载界面，建议刷新游戏页面尝试","剑系的“断空追击”“狱火天焰”技能，发动时有无敌状态","属性石分为“防御”“攻击”“生命”“魔法”“暴击”“闪避”六种类型","神秘副本的BOSS都有几率掉落“史诗武器”“强化石”等稀有物品","所有BOSS都有几率掉落该BOSS的“技能石”","通过“强化装备”可以大幅度提升装备属性","转职后装备两把相同类型的武器，可以大幅提升玩家属性噢","熟练连击技巧可以使你更轻松的过关","打低级关卡赚钱是一个很好的赚钱办法噢"];
      
      public static var mapArr:Array = [];
      
      public static var enemyArr:Array = [];
      
      public static var otherArr:Array = [];
      
      private static var 提示time:int = 135;
      
      public function Load()
      {
         super();
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         if(!loadingX)
         {
            loadingX = new Load();
         }
         Main._stage.addChild(loadingX);
         loadingX.x = xx;
         loadingX.y = yy;
         loadingX.visible = true;
         Loading();
         loadingX.addEventListener(Event.ENTER_FRAME,onLoading);
      }
      
      public static function Close() : *
      {
         if(!loadingX)
         {
            loadingX = new Load();
         }
         loadingX.x = 5000;
         loadingX.y = 5000;
         loadingX.visible = false;
         loadingX.removeEventListener(Event.ENTER_FRAME,onLoading);
      }
      
      private static function onLoading(e:*) : *
      {
         loadingX.load_mc.load100_mc.scaleX = Load.percentLoaded / 100;
         loadingX.load_txt.text = Load.percentLoaded + "%";
         loadingX.load_name_txt.text = Load.loadName + "";
         loadingX.load_name2_txt.text = Load.loadName2 + "";
         ++提示time;
         if(提示time % 135 == 0)
         {
            提示();
         }
      }
      
      private static function 提示() : *
      {
         var i:int = Math.random() * txtArr.length;
         loadingX.gun_txt.text = txtArr[i];
      }
      
      public static function Loading(str:String = "") : *
      {
         if(str == "")
         {
            loadName = "1/";
         }
         else
         {
            loadName = str;
         }
         if(loadName == "1/")
         {
            Loading_Map();
         }
         else if(loadName == "2/")
         {
            Loading_Enemy();
         }
         else if(loadName == "3/")
         {
            Loading_Data();
         }
         else if(loadName == "4/")
         {
            Loading_Player_1();
         }
         else if(loadName == "5/")
         {
            Loading_Player_2();
         }
         else if(loadName == "6/")
         {
            Loading_Player_3();
         }
         else if(loadName == "7/")
         {
            Loading_ZhuangBei_1();
         }
         else if(loadName == "8/")
         {
            Loading_ZhuangBei_2();
         }
         else if(loadName == "9/")
         {
            Loading_ZhuangBei_3();
         }
         else if(loadName == "10/")
         {
            Loading_WuQi_1();
         }
         else if(loadName == "11/")
         {
            Loading_WuQi_2();
         }
         else if(loadName == "12/")
         {
            Loading_WuQi_3();
         }
         else if(loadName == "13/")
         {
            Loading_EnemySkill();
         }
         else if(loadName == "14/")
         {
            Loading_Data2();
         }
         else if(loadName == "15/")
         {
            Loading_Music();
         }
         else if(loadName == "16/")
         {
            Loading_ChongWu();
         }
         else if(loadName == "17/")
         {
            Loading_ZhuangBeiX_1();
         }
         else if(loadName == "18/")
         {
            Loading_ZhuangBeiX_2();
         }
         else if(loadName == "19/")
         {
            Loading_ZhuangBeiX_3();
         }
         else if(loadName == "结束")
         {
            Load.loadName2 = "2";
            All_Loaded = true;
         }
      }
      
      public static function Loading_Map() : *
      {
         var nameStr:String = null;
         if(Map.MapArr[Main.gameNum])
         {
            Load.Loading("2/");
         }
         else
         {
            nameStr = mapArr[Main.gameNum];
            Map.MapArr[Main.gameNum] = new ClassLoader(nameStr);
            Map.MapArr[Main.gameNum].addEventListener(Event.COMPLETE,onLoaded_Map);
         }
      }
      
      private static function onLoaded_Map(e:* = null) : *
      {
         Load.Loading("2/");
      }
      
      public static function Loading_Enemy() : *
      {
         var nameStr:String = null;
         if(Main.gameNum == 0)
         {
            Load.Loading("3/");
         }
         else
         {
            Enemy.EnemyLoaded = false;
            if(Enemy.EnemyArr[Main.gameNum])
            {
               Load.Loading("3/");
            }
            else
            {
               nameStr = enemyArr[Main.gameNum];
               Enemy.EnemyArr[Main.gameNum] = new ClassLoader(nameStr);
               Enemy.EnemyArr[Main.gameNum].addEventListener(Event.COMPLETE,onLoaded_Enemy);
            }
         }
      }
      
      private static function onLoaded_Enemy(e:* = null) : *
      {
         trace("怪物数据读取完毕!");
         Load.Loading("3/");
      }
      
      public static function Loading_Data() : *
      {
         if(!DataLoaded)
         {
            XMLclass = new ClassLoader(otherArr[0]);
            XMLclass.addEventListener(Event.COMPLETE,onLoaded_Data);
         }
         else
         {
            Load.Loading("4/");
         }
      }
      
      private static function onLoaded_Data(e:* = null) : *
      {
         trace("关卡数据读取完毕!2");
         DataLoaded = true;
         Load.Loading("4/");
      }
      
      public static function Loading_Player_1() : *
      {
         if(!Player.PlayerMcArr[0])
         {
            Player.PlayerMcArr[0] = new ClassLoader(otherArr[1]);
            Player.PlayerMcArr[0].addEventListener(Event.COMPLETE,onLoaded_Player1);
         }
         else
         {
            Load.Loading("5/");
         }
      }
      
      private static function onLoaded_Player1(e:* = null) : *
      {
         Load.Loading("5/");
      }
      
      public static function Loading_Player_2() : *
      {
         if(!Player.PlayerMcArr[1])
         {
            Player.PlayerMcArr[1] = new ClassLoader(otherArr[2]);
            Player.PlayerMcArr[1].addEventListener(Event.COMPLETE,onLoaded_Player2);
         }
         else
         {
            Load.Loading("6/");
         }
      }
      
      private static function onLoaded_Player2(e:* = null) : *
      {
         Load.Loading("6/");
      }
      
      public static function Loading_Player_3() : *
      {
         if(!Player.PlayerMcArr[2])
         {
            Player.PlayerMcArr[2] = new ClassLoader(otherArr[3]);
            Player.PlayerMcArr[2].addEventListener(Event.COMPLETE,onLoaded_Player3);
         }
         else
         {
            Load.Loading("7/");
         }
      }
      
      private static function onLoaded_Player3(e:* = null) : *
      {
         Load.Loading("7/");
      }
      
      public static function Loading_ZhuangBei_1() : *
      {
         if(!Skin_ZhuangBei.PlayerMcArr[0])
         {
            Skin_ZhuangBei.PlayerMcArr[0] = new ClassLoader(otherArr[4]);
            Skin_ZhuangBei.PlayerMcArr[0].addEventListener(Event.COMPLETE,onZhuangBei1);
         }
         else
         {
            Load.Loading("8/");
         }
      }
      
      private static function onZhuangBei1(e:* = null) : *
      {
         Load.Loading("8/");
      }
      
      public static function Loading_ZhuangBei_2() : *
      {
         if(!Skin_ZhuangBei.PlayerMcArr[1])
         {
            Skin_ZhuangBei.PlayerMcArr[1] = new ClassLoader(otherArr[5]);
            Skin_ZhuangBei.PlayerMcArr[1].addEventListener(Event.COMPLETE,onZhuangBei2);
         }
         else
         {
            Load.Loading("9/");
         }
      }
      
      private static function onZhuangBei2(e:* = null) : *
      {
         Load.Loading("9/");
      }
      
      public static function Loading_ZhuangBei_3() : *
      {
         if(!Skin_ZhuangBei.PlayerMcArr[2])
         {
            Skin_ZhuangBei.PlayerMcArr[2] = new ClassLoader(otherArr[6]);
            Skin_ZhuangBei.PlayerMcArr[2].addEventListener(Event.COMPLETE,onZhuangBei3);
         }
         else
         {
            Load.Loading("10/");
         }
      }
      
      private static function onZhuangBei3(e:* = null) : *
      {
         Load.Loading("10/");
      }
      
      public static function Loading_WuQi_1() : *
      {
         if(!Skin_WuQi.PlayerMcArr[0])
         {
            Skin_WuQi.PlayerMcArr[0] = new ClassLoader(otherArr[7]);
            Skin_WuQi.PlayerMcArr[0].addEventListener(Event.COMPLETE,onWuQi1);
         }
         else
         {
            Load.Loading("11/");
         }
      }
      
      private static function onWuQi1(e:* = null) : *
      {
         Load.Loading("11/");
      }
      
      public static function Loading_WuQi_2() : *
      {
         if(!Skin_WuQi.PlayerMcArr[1])
         {
            Skin_WuQi.PlayerMcArr[1] = new ClassLoader(otherArr[8]);
            Skin_WuQi.PlayerMcArr[1].addEventListener(Event.COMPLETE,onWuQi2);
         }
         else
         {
            Load.Loading("12/");
         }
      }
      
      private static function onWuQi2(e:* = null) : *
      {
         Load.Loading("12/");
      }
      
      public static function Loading_WuQi_3() : *
      {
         if(!Skin_WuQi.PlayerMcArr[2])
         {
            Skin_WuQi.PlayerMcArr[2] = new ClassLoader(otherArr[9]);
            Skin_WuQi.PlayerMcArr[2].addEventListener(Event.COMPLETE,onWuQi3);
         }
         else
         {
            Load.Loading("13/");
         }
      }
      
      private static function onWuQi3(e:* = null) : *
      {
         Load.Loading("13/");
      }
      
      private static function Loading_EnemySkill() : *
      {
         if(!Player.enemySkillMC)
         {
            Player.enemySkillMC = new ClassLoader(otherArr[10]);
            Player.enemySkillMC.addEventListener(Event.COMPLETE,onEnemySkill);
         }
         else
         {
            Load.Loading("14/");
         }
      }
      
      private static function onEnemySkill(e:* = null) : *
      {
         Load.Loading("14/");
      }
      
      private static function Loading_Data2() : *
      {
         if(!XMLclass2)
         {
            XMLclass2 = new ClassLoader(otherArr[11]);
            XMLclass2.addEventListener(Event.COMPLETE,onLoading_Data2);
         }
         else
         {
            Load.Loading("15/");
         }
      }
      
      private static function onLoading_Data2(e:* = null) : *
      {
         Load.Loading("15/");
      }
      
      private static function Loading_Music() : *
      {
         if(!MusicBox.MusicData)
         {
            MusicBox.MusicData = new ClassLoader(otherArr[12]);
            MusicBox.MusicData.addEventListener(Event.COMPLETE,onLoading_Music);
         }
         else
         {
            Load.Loading("16/");
         }
      }
      
      private static function onLoading_Music(e:* = null) : *
      {
         Load.Loading("16/");
      }
      
      private static function Loading_ChongWu() : *
      {
         if(!ChongWu.loadData)
         {
            ChongWu.loadData = new ClassLoader(otherArr[13]);
            ChongWu.loadData.addEventListener(Event.COMPLETE,onLoading_ChongWu);
         }
         else
         {
            Load.Loading("17/");
         }
      }
      
      private static function onLoading_ChongWu(e:* = null) : *
      {
         Load.Loading("17/");
      }
      
      public static function Loading_ZhuangBeiX_1() : *
      {
         if(!Skin_ZhuangBei.PlayerMcArr2[0])
         {
            Skin_ZhuangBei.PlayerMcArr2[0] = new ClassLoader(otherArr[14]);
            Skin_ZhuangBei.PlayerMcArr2[0].addEventListener(Event.COMPLETE,onZhuangBeiX1);
         }
         else
         {
            Load.Loading("18/");
         }
      }
      
      private static function onZhuangBeiX1(e:* = null) : *
      {
         Load.Loading("18/");
      }
      
      public static function Loading_ZhuangBeiX_2() : *
      {
         if(!Skin_ZhuangBei.PlayerMcArr2[1])
         {
            Skin_ZhuangBei.PlayerMcArr2[1] = new ClassLoader(otherArr[15]);
            Skin_ZhuangBei.PlayerMcArr2[1].addEventListener(Event.COMPLETE,onZhuangBeiX2);
         }
         else
         {
            Load.Loading("19/");
         }
      }
      
      private static function onZhuangBeiX2(e:* = null) : *
      {
         Load.Loading("19/");
      }
      
      public static function Loading_ZhuangBeiX_3() : *
      {
         if(!Skin_ZhuangBei.PlayerMcArr2[2])
         {
            Skin_ZhuangBei.PlayerMcArr2[2] = new ClassLoader(otherArr[16]);
            Skin_ZhuangBei.PlayerMcArr2[2].addEventListener(Event.COMPLETE,onZhuangBeiX3);
         }
         else
         {
            Load.Loading("结束");
         }
      }
      
      private static function onZhuangBeiX3(e:* = null) : *
      {
         Load.Loading("结束");
      }
   }
}

