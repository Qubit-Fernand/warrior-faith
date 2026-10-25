package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Load extends MovieClip
   {
      
      public static var All_Loaded:Boolean;
      
      public static var percentLoaded:int;
      
      public static var loadingX:Load;
      
      public static var XMLclass:ClassLoader;
      
      private static var DataLoaded:Boolean;
      
      public static var loadName:String = "";
      
      public static var loadName2:String = "13";
      
      public static var txtArr:Array = ["勇士的信仰相较勇者之路2增加了拳手职业。","购买消耗品时也可在购买数量窗口内输入数字进行快速购买。","装备时可双击装备或将装备拖入对应装备格中进行穿戴。","系统菜单栏内可以设置快捷键。","打怪过程中可以通过系统菜单栏内的“返回城镇”按钮快速回城。","游戏流程中只要任意一玩家等级达到25级并且拥有“胜利的凭证”与“8000金币”，\n即可寻找奥古斯汀进行转职。","转职之后可以学习更多更炫的转职技能。","一个角色只能转职一次。","女神碎片可在冰雪废墟、废弃都市与幽灵船关卡内获得。","村落地图内左下角的传送门入口，进入后可找到女神—格蕾丽丝。","每修补一块女神碎片便开启一个神秘副本。","拥有女神像碎片后，只需点击女神像相应缺口即可对女神像进行修补。","村落地图内左上角的传送门入口，进入后可发现神秘副本。","神秘副本1内打败Boss鳄鱼公爵即有一定机率获得“胜利的凭证”。","胜利的凭证所有玩家获取一次后将不再掉落（1P与2P玩家各获得一次）。","为装备镶嵌上怪物属性石可以更好的提高人物属性。","仓库系统可以实现双人玩家的物品赠送。","装备商人—道格拉斯可以进行装备强化和镶嵌宝石等功能。","可以通过 “画质调整”按钮进行画质调整，以此提高游戏整体流畅度。","打开背包后可在道具栏左侧查看角色的详细属性。","技能导师—奥古斯汀处可学习各系职业的主动技能和通用被动技能。","怪物在每次攻击时都会有极短的攻击蓄力时间，操作适当可快速闪避。","关卡内的所有小怪都有一定机率掉落稀有装备。","Boss在使用一些技能时最好做出适当闪避，\n因为此时BOSS攻击将不会因为玩家的攻击而被中断。","打败关卡Boss后即可开启下一个全新关卡。","“女神像碎片”与“胜利的凭证”拾取之后将存放在在道具栏内的任务分页中。","如果游戏卡在加载界面，建议清理下IE缓存然后再重新进入。","遇见无法通过的关卡时，可以试试集齐整套适应等级套装之后再前往。"];
      
      public static var mapArr:Array = ["Map0.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf"];
      
      public static var enemyArr:Array = ["","Enemy1.swf","Enemy2.swf","Enemy3.swf","Enemy4.swf","Enemy5.swf","Enemy6.swf","Enemy7.swf","Enemy8.swf","Enemy9.swf"];
      
      public static var otherArr:Array = ["Data_X.swf","PlayerMc_X0.swf","PlayerMc_X1.swf","PlayerMc_X2.swf","ZhuangBei_X0.swf","ZhuangBei_X1.swf","ZhuangBei_X2.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2.swf","EnemySkill.swf"];
      
      public function Load()
      {
         super();
      }
      
      public static function Loading_Enemy() : *
      {
         var _loc1_:String = null;
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
               _loc1_ = enemyArr[Main.gameNum];
               Enemy.EnemyArr[Main.gameNum] = new ClassLoader(_loc1_);
               Enemy.EnemyArr[Main.gameNum].addEventListener(Event.COMPLETE,onLoaded_Enemy);
            }
         }
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
      
      public static function Loading_Map() : *
      {
         var _loc1_:String = null;
         if(Map.MapArr[Main.gameNum])
         {
            Load.Loading("2/");
         }
         else
         {
            _loc1_ = mapArr[Main.gameNum];
            Map.MapArr[Main.gameNum] = new ClassLoader(_loc1_);
            Map.MapArr[Main.gameNum].addEventListener(Event.COMPLETE,onLoaded_Map);
         }
      }
      
      public static function Loading(param1:String = "") : *
      {
         if(param1 == "")
         {
            loadName = "1/";
         }
         else
         {
            loadName = param1;
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
         else if(loadName == "结束")
         {
            All_Loaded = true;
         }
      }
      
      private static function onLoaded_Enemy(param1:* = null) : *
      {
         trace("怪物数据读取完毕!");
         Load.Loading("3/");
      }
      
      public static function InitLoad() : *
      {
         mapArr[101] = "Map101.swf";
         mapArr[102] = "Map102.swf";
         mapArr[103] = "Map103.swf";
         enemyArr[101] = "Enemy101.swf";
         enemyArr[102] = "Enemy102.swf";
         enemyArr[103] = "Enemy103.swf";
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
      
      private static function onWuQi1(param1:* = null) : *
      {
         Load.Loading("11/");
      }
      
      private static function onZhuangBei1(param1:* = null) : *
      {
         Load.Loading("8/");
      }
      
      private static function onZhuangBei2(param1:* = null) : *
      {
         Load.Loading("9/");
      }
      
      private static function onZhuangBei3(param1:* = null) : *
      {
         Load.Loading("10/");
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
      
      private static function onLoaded_Map(param1:* = null) : *
      {
         Load.Loading("2/");
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
      
      private static function onWuQi2(param1:* = null) : *
      {
         Load.Loading("12/");
      }
      
      private static function onWuQi3(param1:* = null) : *
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
            Load.Loading("结束");
         }
      }
      
      private static function onLoaded_Player1(param1:* = null) : *
      {
         Load.Loading("5/");
      }
      
      private static function onLoaded_Player2(param1:* = null) : *
      {
         Load.Loading("6/");
      }
      
      private static function onLoaded_Player3(param1:* = null) : *
      {
         Load.Loading("7/");
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
      
      private static function onLoading(param1:*) : *
      {
         loadingX.load_mc.gotoAndStop(Load.percentLoaded);
         loadingX.load_txt.text = Load.percentLoaded + "%";
         loadingX.load_name_txt.text = Load.loadName + "";
         loadingX.load_name2_txt.text = Load.loadName2 + "";
      }
      
      private static function onEnemySkill(param1:* = null) : *
      {
         Load.Loading("结束");
      }
      
      public static function Open(param1:int = 0, param2:int = 0) : *
      {
         InitLoad();
         if(!loadingX)
         {
            loadingX = new Load();
         }
         Main._stage.addChild(loadingX);
         loadingX.x = param1;
         loadingX.y = param2;
         loadingX.visible = true;
         Loading();
         loadingX.addEventListener(Event.ENTER_FRAME,onLoading);
         提示();
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
      
      private static function onLoaded_Data(param1:* = null) : *
      {
         trace("关卡数据读取完毕!2");
         DataLoaded = true;
         Load.Loading("4/");
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
      
      private static function 提示() : *
      {
         var _loc1_:int = 0;
         _loc1_ = Math.random() * txtArr.length;
         loadingX.gun_txt.text = txtArr[_loc1_];
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
   }
}

