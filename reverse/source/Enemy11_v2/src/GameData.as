package src
{
   public class GameData
   {
      
      public static var 过关条件:int;
      
      public static var 刷怪索引:int;
      
      public static var monsterTime:int;
      
      public static var 小关:int;
      
      public static var BOSSid:int;
      
      public static var GameDataXml:XML;
      
      public static var 刷怪总数:int;
      
      public static var 刷怪频率:int;
      
      public static var 大关:int;
      
      public static var 同屏数量:int;
      
      public static var BossIS:Enemy;
      
      public static var 怪物id:Array = new Array();
      
      public static var 随机id:Array = new Array();
      
      public static var BOSS:Boolean = true;
      
      public static var winYN:Boolean = false;
      
      public static var deadMcYN:Boolean = false;
      
      public static var deadTime:int = 135;
      
      public function GameData()
      {
         super();
      }
      
      public static function GetData() : *
      {
         var i:* = undefined;
         var num:int = 0;
         var num2:int = 0;
         var XXid:int = 0;
         var XXid2:int = 0;
         monsterTime = 0;
         刷怪索引 = 0;
         怪物id = new Array();
         随机id = new Array();
         for(i in GameDataXml.关卡)
         {
            大关 = int(GameDataXml.关卡[i].大关);
            小关 = int(GameDataXml.关卡[i].小关);
            if(Main.gameNum == 大关 && Main.gameNum2 == 小关)
            {
               BOSS = true;
               过关条件 = int(GameDataXml.关卡[i].预留1);
               同屏数量 = int(GameDataXml.关卡[i].同屏数量);
               刷怪频率 = int(GameDataXml.关卡[i].刷怪频率) * Main.fps;
               刷怪总数 = int(GameDataXml.关卡[i].刷怪总数);
               BOSSid = int(GameDataXml.关卡[i].BOSSid);
               for(num = 1; num <= 30; num++)
               {
                  XXid = int(GameDataXml.关卡[i]["怪物id" + num]);
                  if(XXid >= 0)
                  {
                     怪物id[怪物id.length] = XXid;
                  }
               }
               for(num2 = 1; num2 <= 5; num2++)
               {
                  XXid2 = int(GameDataXml.关卡[i]["随机id" + num2]);
                  if(XXid2 > 0)
                  {
                     随机id[随机id.length] = XXid2;
                  }
               }
               return;
            }
         }
      }
      
      public static function MonsterGo() : *
      {
         var num:int = 0;
         var i:int = 0;
         ++monsterTime;
         if(BOSS && BOSSid > 0)
         {
            Play_Interface.bossID = "a" + BOSSid;
            Play_Interface.BossLifeYN = true;
            BossIS = new Enemy(BOSSid);
            Play_Interface.bossIS = BossIS;
            Main.world.moveChild_Enemy.addChild(BossIS);
            BossIS.x = 1200;
            BossIS.y = 380;
            BOSS = false;
         }
         if(怪物id.length > 0 && monsterTime >= 刷怪频率)
         {
            monsterTime = 0;
            if(刷怪总数 > 0 && Enemy.All.length < 同屏数量)
            {
               num = 同屏数量 - Enemy.All.length;
               刷怪总数 -= num;
               for(i = 0; i < num; i++)
               {
                  WhoAreYou();
               }
            }
         }
         if(!winYN)
         {
            Win(过关条件);
            Lose();
         }
      }
      
      private static function Where() : int
      {
         var num:int = 0;
         num = Math.random() * 7;
         if(num == 0)
         {
            return -200;
         }
         if(num == 1)
         {
            return 1800;
         }
         return Math.random() * 1600;
      }
      
      private static function GameOverX() : *
      {
         var gameOver:GameOver = null;
         gameOver = new GameOver();
         Main._stage.addChild(gameOver);
         deadMcYN = true;
         deadTime = 135;
      }
      
      private static function WhoAreYou() : *
      {
         var e:Enemy = null;
         var xx:int = 0;
         var e2:Enemy = null;
         if(刷怪索引 >= 怪物id.length)
         {
            刷怪索引 = 0;
         }
         if(怪物id[刷怪索引] != 0)
         {
            e = new Enemy(怪物id[刷怪索引]);
            Main.world.moveChild_Enemy.addChild(e);
            xx = int(Where());
            e.x = xx;
            e.y = 380;
         }
         else
         {
            xx = Math.random() * 随机id.length;
            e2 = new Enemy(随机id[xx]);
            Main.world.moveChild_Enemy.addChild(e2);
            xx = int(Where());
            e2.x = xx;
            e2.y = 380;
         }
         ++刷怪索引;
      }
      
      private static function Lose() : *
      {
         var loseYN:Boolean = false;
         loseYN = false;
         if(Boolean(Main.P1P2) && Main.player_1.hp.getValue() <= 0 && Main.player_2.hp.getValue() <= 0)
         {
            loseYN = true;
         }
         else if(!Main.P1P2 && Main.player_1.hp.getValue() <= 0)
         {
            loseYN = true;
         }
         if(loseYN)
         {
            if(deadTime > 0)
            {
               --deadTime;
            }
            else if(!deadMcYN)
            {
               deadTime = 135;
               GameOverX();
            }
         }
      }
      
      private static function Win(winNum:int) : *
      {
         var i:* = undefined;
         if(winNum == 0)
         {
            return;
         }
         if(winNum == 1)
         {
            if(Enemy.All.length <= 0 && 刷怪总数 <= 0 && Main.world.moveChild_Enemy.numChildren <= 0)
            {
               for(i in GameDataXml.关卡)
               {
                  if(int(GameDataXml.关卡[i].大关) == Main.gameNum && int(GameDataXml.关卡[i].小关) == Main.gameNum2 + 1)
                  {
                     if(Boolean(Main.world["继续"]) && !Main.world["继续"].openYN)
                     {
                        (Main.world["继续"] as Door).Open(60);
                        trace("------------------------------------------open");
                     }
                     return;
                  }
                  if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
                  {
                     (Main.world["回村"] as Door).Open(60);
                     Main.guanKa[Main.gameNum + 1] = true;
                  }
               }
            }
         }
         else if(winNum == 2)
         {
            if(Boolean(BossIS) && BossIS.life.getValue() <= 0)
            {
               if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
               {
                  (Main.world["回村"] as Door).Open(60);
                  Main.guanKa[Main.gameNum + 1] = true;
               }
               if(Boolean(Main.world["继续"]) && !Main.world["继续"].openYN)
               {
                  (Main.world["继续"] as Door).Open(60);
               }
            }
         }
      }
   }
}

