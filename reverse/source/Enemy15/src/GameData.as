package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.views.playerTaskPanel.*;
   
   public class GameData
   {
      
      public static var GameDataXml:XML;
      
      public static var 大关:int;
      
      public static var 小关:int;
      
      public static var 过关条件:int;
      
      public static var 同屏数量:int;
      
      public static var 刷怪频率:int;
      
      public static var 刷怪总数:int;
      
      public static var BOSSid:int;
      
      public static var 刷怪索引:int;
      
      public static var monsterTime:int;
      
      public static var BossIS:Enemy;
      
      public static var GameDataXmlArr:Array = new Array();
      
      public static var 怪物id:Array = new Array();
      
      public static var 随机id:Array = new Array();
      
      public static var BOSS:VT = VT.createVT(4399);
      
      public static var winYN:Boolean = false;
      
      public static var gameLV:int = 1;
      
      public static var deadMcYN:Boolean = false;
      
      public static var deadTime:int = 5;
      
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
         GameDataXml = GameDataXmlArr[gameLV];
         Enemy.EnemyXml = Enemy.EnemyXmlArr[gameLV];
         EnemySkin.EnemySkinXml = EnemySkin.EnemySkinXmlArr[gameLV];
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
               BOSS.setValue(4399);
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
         if(BOSS.getValue() > 0 && BOSSid > 0)
         {
            Play_Interface.BossLifeYN = true;
            BossIS = new Enemy(BOSSid);
            Play_Interface.bossIS = BossIS;
            Main.world.moveChild_Enemy.addChild(BossIS);
            BossIS.x = 1200;
            BossIS.y = 380;
            BOSS.setValue(-4399);
         }
         if(怪物id.length > 0 && monsterTime >= 刷怪频率)
         {
            monsterTime = 0;
            if(刷怪总数 > 0 && Enemy.All.length < 同屏数量)
            {
               num = 同屏数量 - Enemy.All.length;
               if(num <= 刷怪总数)
               {
                  刷怪总数 -= num;
               }
               else
               {
                  num = 刷怪总数;
                  刷怪总数 = 0;
               }
               for(i = 0; i < num; i++)
               {
                  if(Enemy.All.length < 同屏数量)
                  {
                     WhoAreYou();
                  }
               }
            }
         }
         if(monsterTime % 27 == 0 && !winYN)
         {
            Win(过关条件);
            Lose();
         }
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
      
      private static function Where() : int
      {
         var num:int = Math.random() * 7;
         if(num == 0 && Main.gameNum != 17)
         {
            return -200;
         }
         if(num == 1 && Main.gameNum != 17)
         {
            return 1800;
         }
         if(Main.gameNum == 17)
         {
            return Math.random() * 1000 + 100;
         }
         return Math.random() * 1600;
      }
      
      private static function Win(winNum:int) : *
      {
         var i:* = undefined;
         if(winNum == 0)
         {
            for(i in GameDataXml.关卡)
            {
               if(int(GameDataXml.关卡[i].大关) == Main.gameNum && int(GameDataXml.关卡[i].小关) == Main.gameNum2 + 1)
               {
                  if(Boolean(Main.world["继续"]) && Boolean(Main.world["继续"] is Door) && !Main.world["继续"].openYN)
                  {
                     (Main.world["继续"] as Door).Open();
                  }
                  return;
               }
               if(Boolean(Main.world["回村"]) && Boolean(Main.world["回村"] is Door) && !Main.world["回村"].openYN)
               {
                  (Main.world["回村"] as Door).Open();
               }
            }
         }
         else if(winNum == 1)
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
                     }
                     return;
                  }
                  if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
                  {
                     (Main.world["回村"] as Door).Open(60);
                  }
               }
            }
         }
         else if(winNum == 2)
         {
            if(Boolean(BossIS) && BossIS.life.getValue() <= 0)
            {
               if(Boolean(Main.world["继续"]) && !Main.world["继续"].openYN)
               {
                  (Main.world["继续"] as Door).Open(60);
                  PlayerTaskData.addTg();
                  PlayerTaskData.addTaskData();
               }
               if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
               {
                  (Main.world["回村"] as Door).Open(60);
                  PlayerTaskData.addTg();
                  PlayerTaskData.addTaskData();
               }
            }
         }
         else if(winNum == 3)
         {
            if(Enemy.All.length <= 0 && 刷怪总数 <= 0 && Main.world.moveChild_Enemy.numChildren <= 0)
            {
               for(i in GameDataXml.关卡)
               {
                  trace("关卡 ===== " + i);
                  if(int(GameDataXml.关卡[i].大关) == Main.gameNum && int(GameDataXml.关卡[i].小关) == Main.gameNum2 + 1)
                  {
                     ++Main.gameNum2;
                     GameData.GetData();
                     Play_HPMP_up();
                     NewMC.Open("挑战关波数",Main._this,0,0,35,Main.gameNum2,true,2);
                     return;
                  }
               }
               if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
               {
                  (Main.world["回村"] as Door).Open(60);
                  PlayerTaskData.addTg();
                  PlayerTaskData.addTaskData();
               }
            }
         }
      }
      
      private static function Play_HPMP_up() : *
      {
         Main.player_1.HpUp(VT.GetTempVT("10/1*2"),2);
         Main.player_1.MpUp(VT.GetTempVT("10/1*4"),2);
         if(Main.P1P2)
         {
            Main.player_2.HpUp(VT.GetTempVT("10/1*2"),2);
            Main.player_2.MpUp(VT.GetTempVT("10/1*4"),2);
         }
      }
      
      public static function GuanKaXX() : *
      {
         AddKillPoint_fun();
         if(!Main.guanKa[Main.gameNum + 1] || Main.guanKa[Main.gameNum + 1] == 0)
         {
            Main.guanKa[Main.gameNum + 1] = 1;
         }
         if(GameData.gameLV == 1 && Main.guanKa[Main.gameNum] == 1)
         {
            Main.guanKa[Main.gameNum] = 2;
         }
         else if(GameData.gameLV == 2 && Main.guanKa[Main.gameNum] == 2)
         {
            Main.guanKa[Main.gameNum] = 3;
         }
         else if(Main.guanKa[Main.gameNum] != 1 && Main.guanKa[Main.gameNum] != 2 && Main.guanKa[Main.gameNum] != 3)
         {
            Main.guanKa[Main.gameNum] = 2;
         }
      }
      
      private static function AddKillPoint_fun() : *
      {
         if(Main.gameNum > 100 || Main.gameNum == 9)
         {
            return;
         }
         var N1:int = 1;
         for(var i:int = 2; i < 50; i++)
         {
            if(!(Boolean(Main.guanKa[i]) || Main.guanKa[i] > 0))
            {
               break;
            }
            N1 = i;
         }
         trace("Main.gameNum =========> " + Main.gameNum + ",N1 ===========>" + N1);
         var x:int = N1 - Main.gameNum;
         if(x < 0)
         {
            return;
         }
         if(Main.gameNum == 17)
         {
            AddKillPoint_P1P2(VT.GetTempVT("5*5*2"));
            Add_CW_exp_P1P2(VT.GetTempVT("5*5*2"));
         }
         else if(x >= 4)
         {
            AddKillPoint_P1P2(VT.GetTempVT("8/4"));
            Add_CW_exp_P1P2(VT.GetTempVT("8/4"));
         }
         else
         {
            AddKillPoint_P1P2(VT.GetTempVT("9+1") - VT.GetTempVT("6/3") * x);
            Add_CW_exp_P1P2(VT.GetTempVT("9+1") - VT.GetTempVT("6/3") * x);
         }
      }
      
      private static function Add_CW_exp_P1P2(i:int) : *
      {
         if(GameData.gameLV == 2)
         {
            i *= VT.GetTempVT("8+5/5/2");
         }
         else if(GameData.gameLV == 3)
         {
            i *= VT.GetTempVT("8+8/5/2");
         }
         WinShow.txt_5 = i;
         if(Main.player_1.playerCW)
         {
            if(Main.player_1.playerCW.data.addExp(i))
            {
               NewMC.Open("宠物升级",Main.player_1.playerCW);
            }
         }
         if(Boolean(Main.P1P2) && Boolean(Main.player_2.playerCW))
         {
            if(Main.player_2.playerCW.data.addExp(i))
            {
               NewMC.Open("宠物升级",Main.player_2.playerCW);
            }
         }
      }
      
      private static function AddKillPoint_P1P2(i:int) : *
      {
         if(Main.gameNum != 17)
         {
            if(GameData.gameLV > 3 || i > 10)
            {
               return;
            }
         }
         if(GameData.gameLV == 2 && Main.gameNum != 17)
         {
            i *= VT.GetTempVT("8+5/5/2");
         }
         else if(GameData.gameLV == 3 && Main.gameNum != 17)
         {
            i *= VT.GetTempVT("8+8/5/2");
         }
         WinShow.txt_5 = i;
         Main.player1.AddKillPoint(i);
         if(Main.P1P2)
         {
            Main.player2.AddKillPoint(i);
         }
      }
      
      private static function Lose() : *
      {
         var loseYN:Boolean = false;
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
               trace("over!!!!!!!!!!!!!!!!!!!!!!!!!!!" + deadTime);
            }
            else if(!deadMcYN)
            {
               deadTime = 5;
               trace("over!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~~~~~~~~!!!");
               GameOverX();
            }
         }
      }
      
      private static function GameOverX() : *
      {
         var gameOver:GameOver = new GameOver();
         Main._stage.addChild(gameOver);
         deadMcYN = true;
         deadTime = 5;
      }
      
      public static function SelMapName() : String
      {
         var str:String = null;
         var i:* = undefined;
         for(i in GameDataXml.关卡)
         {
            if(int(GameDataXml.关卡[i].大关) == Main.gameNum && int(GameDataXml.关卡[i].小关) == Main.gameNum2)
            {
               return "Map_" + int(GameDataXml.关卡[i].预留2) + "_" + int(GameDataXml.关卡[i].预留3);
            }
         }
         return "Map_" + Main.gameNum + "_" + Main.gameNum2;
      }
   }
}

