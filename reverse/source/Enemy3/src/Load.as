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
      
      public static var mapArr:Array = ["Map0.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf"];
      
      public static var enemyArr:Array = ["","Enemy1.swf","Enemy2.swf","Enemy3.swf","Enemy4.swf","Enemy5.swf","Enemy6.swf","Enemy7.swf","Enemy8v02.swf","Enemy9.swf"];
      
      public static var otherArr:Array = ["Data_X.swf","PlayerMc_X0.swf","PlayerMc_X1.swf","PlayerMc_X2.swf","ZhuangBei_X0.swf","ZhuangBei_X1.swf","ZhuangBei_X2.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2.swf","EnemySkill.swf"];
      
      public function Load()
      {
         super();
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
         else if(loadName == "结束")
         {
            All_Loaded = true;
         }
      }
      
      private static function onLoaded_Enemy(e:* = null) : *
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
      
      private static function onWuQi1(e:* = null) : *
      {
         Load.Loading("11/");
      }
      
      private static function onZhuangBei1(e:* = null) : *
      {
         Load.Loading("8/");
      }
      
      private static function onWuQi3(e:* = null) : *
      {
         Load.Loading("13/");
      }
      
      private static function onZhuangBei3(e:* = null) : *
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
      
      private static function onLoaded_Map(e:* = null) : *
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
      
      private static function onWuQi2(e:* = null) : *
      {
         Load.Loading("12/");
      }
      
      private static function onZhuangBei2(e:* = null) : *
      {
         Load.Loading("9/");
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
      
      private static function onLoaded_Player1(e:* = null) : *
      {
         Load.Loading("5/");
      }
      
      private static function onLoaded_Player2(e:* = null) : *
      {
         Load.Loading("6/");
      }
      
      private static function onLoaded_Player3(e:* = null) : *
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
      
      private static function onLoading(e:*) : *
      {
         loadingX.load_mc.gotoAndStop(Load.percentLoaded);
         loadingX.load_txt.text = Load.percentLoaded + "%";
         loadingX.load_name_txt.text = Load.loadName + "";
         loadingX.load_name2_txt.text = Load.loadName2 + "";
      }
      
      private static function onEnemySkill(e:* = null) : *
      {
         Load.Loading("结束");
      }
      
      public static function Open(xx:int = 0, yy:int = 0) : *
      {
         InitLoad();
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
      
      private static function onLoaded_Data(e:* = null) : *
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

