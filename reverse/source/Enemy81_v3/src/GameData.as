package src
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.views.achPanel.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import src.tool.*;
   
   public class GameData
   {
      
      public static var GameDataXml:XML;
      
      public static var 大关:int;
      
      public static var 小关:int;
      
      public static var 过关条件:int;
      
      public static var 刷怪索引:int;
      
      public static var monsterTime:int;
      
      public static var BossIS:Enemy;
      
      public static var GameDataXmlArr:Array = new Array();
      
      public static var 同屏数量:VT = VT.createVT();
      
      public static var 刷怪频率:VT = VT.createVT();
      
      public static var 刷怪总数:VT = VT.createVT();
      
      public static var BOSSid:VT = VT.createVT();
      
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
         AchData.initGk(Main.gameNum.getValue(),Main.gameNum2.getValue(),GameData.gameLV);
         TaskData.initGk();
         GameDataXml = GameDataXmlArr[gameLV];
         Enemy.EnemyXml = Enemy.EnemyXmlArr[gameLV];
         monsterTime = 0;
         刷怪索引 = 0;
         怪物id = new Array();
         随机id = new Array();
         for(i in GameDataXml.关卡)
         {
            大关 = int(GameDataXml.关卡[i].大关);
            小关 = int(GameDataXml.关卡[i].小关);
            if(Main.gameNum.getValue() == 大关 && Main.gameNum2.getValue() == 小关)
            {
               BOSS.setValue(4399);
               过关条件 = int(GameDataXml.关卡[i].预留1);
               同屏数量.setValue(int(GameDataXml.关卡[i].同屏数量));
               刷怪频率.setValue(int(GameDataXml.关卡[i].刷怪频率) * Main.fps);
               刷怪总数.setValue(int(GameDataXml.关卡[i].刷怪总数));
               BOSSid.setValue(int(GameDataXml.关卡[i].BOSSid));
               for(num = 1; num <= 30; num++)
               {
                  XXid = int(GameDataXml.关卡[i]["怪物id" + num]);
                  if(XXid >= 0)
                  {
                     怪物id[怪物id.length] = VT.createVT(XXid);
                  }
               }
               for(num2 = 1; num2 <= 5; num2++)
               {
                  XXid2 = int(GameDataXml.关卡[i]["随机id" + num2]);
                  if(XXid2 > 0)
                  {
                     随机id[随机id.length] = VT.createVT(XXid2);
                  }
               }
               return;
            }
         }
      }
      
      public static function MonsterGo() : *
      {
         var tempID:int = 0;
         var ee:Enemy = null;
         var num:int = 0;
         var i:int = 0;
         ++monsterTime;
         if(Main.gameNum.getValue() > 50 && Main.gameNum.getValue() < 81 && Main.world.stopYn == false)
         {
            return;
         }
         if(BOSS.getValue() > 0 && BOSSid.getValue() > 0)
         {
            Play_Interface.BossLifeYN = true;
            BossIS = new Enemy(BOSSid.getValue());
            Play_Interface.bossIS = BossIS;
            Main.world.moveChild_Enemy.addChild(BossIS);
            BossIS.x = Main.world._width - 200;
            BossIS.y = 380;
            BOSS.setValue(-4399);
            tempID = int(Main.wts.getBoss());
            if(tempID != -1)
            {
               ee = new Enemy(tempID);
               Main.world.moveChild_Enemy.addChild(ee);
               ee.x = 700;
               ee.y = 380;
               过关条件 = 1;
               刷怪总数.setValue(0);
            }
         }
         if(怪物id.length > 0 && monsterTime >= 刷怪频率.getValue())
         {
            monsterTime = 0;
            if(刷怪总数.getValue() > 0 && Enemy.All.length < 同屏数量.getValue())
            {
               num = 同屏数量.getValue() - Enemy.All.length;
               if(num <= 刷怪总数.getValue())
               {
                  刷怪总数.setValue(刷怪总数.getValue() - num);
               }
               else
               {
                  num = 刷怪总数.getValue();
                  刷怪总数.setValue(0);
               }
               for(i = 0; i < num; i++)
               {
                  if(Enemy.All.length < 同屏数量.getValue())
                  {
                     WhoAreYou();
                  }
               }
            }
         }
         if(monsterTime % 27 == 0)
         {
            if(winYN == false)
            {
               Win(过关条件);
               Lose();
            }
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
         if(怪物id[刷怪索引].getValue() != 0)
         {
            e = new Enemy(怪物id[刷怪索引].getValue());
            Main.world.moveChild_Enemy.addChild(e);
            xx = int(Where());
            e.x = xx;
            e.y = 380;
         }
         else
         {
            xx = Math.random() * 随机id.length;
            e2 = new Enemy(随机id[xx].getValue());
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
         var xx:int = 0;
         if(Main.gameNum.getValue() == 17)
         {
            xx = Math.random() * 1000 + 100;
         }
         else if(num == 0)
         {
            xx = -200 - Main.world.x;
         }
         else if(num == 1)
         {
            xx = 940 + 200 - Main.world.x;
         }
         else
         {
            xx = Math.random() * 940 - Main.world.x;
         }
         return xx;
      }
      
      private static function Win(winNum:int) : *
      {
         var i:* = undefined;
         var ZhuFu:ZhuFuMC = null;
         if(winNum == 0)
         {
            for(i in GameDataXml.关卡)
            {
               if(int(GameDataXml.关卡[i].大关) == Main.gameNum.getValue() && int(GameDataXml.关卡[i].小关) == Main.gameNum2.getValue() + 1)
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
            if(Enemy.All.length <= 0 && 刷怪总数.getValue() <= 0 && Main.world.moveChild_Enemy.numChildren <= 0)
            {
               for(i in GameDataXml.关卡)
               {
                  if(int(GameDataXml.关卡[i].大关) == Main.gameNum.getValue() && int(GameDataXml.关卡[i].小关) == Main.gameNum2.getValue() + 1)
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
                     if(Main.gameNum.getValue() > 17 && Main.gameNum.getValue() < 50)
                     {
                        ZhuFu = new ZhuFuMC();
                        Main.world.addChild(ZhuFu);
                        winYN = true;
                     }
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
               }
               if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
               {
                  (Main.world["回村"] as Door).Open(60);
                  if(Main.gameNum.getValue() > 17 && Main.gameNum.getValue() < 50)
                  {
                     ZhuFu = new ZhuFuMC();
                     Main.world.addChild(ZhuFu);
                     winYN = true;
                  }
               }
            }
         }
         else if(winNum == 3)
         {
            if(Enemy.All.length <= 0 && 刷怪总数.getValue() <= 0 && Main.world.moveChild_Enemy.numChildren <= 0)
            {
               for(i in GameDataXml.关卡)
               {
                  trace("关卡 ===== " + i);
                  if(int(GameDataXml.关卡[i].大关) == Main.gameNum.getValue() && int(GameDataXml.关卡[i].小关) == Main.gameNum2.getValue() + 1)
                  {
                     Main.gameNum2.setValue(Main.gameNum2.getValue() + 1);
                     GameData.GetData();
                     Play_HPMP_up();
                     NewMC.Open("挑战关波数",Main._this,0,0,35,Main.gameNum2.getValue(),true,2);
                     AchData.isTc(Main.gameNum2.getValue());
                     return;
                  }
               }
               if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
               {
                  (Main.world["回村"] as Door).Open(60);
               }
            }
         }
         else if(winNum == 4)
         {
            if(Boolean(Main.world.stopYn) && Enemy.All.length <= 0 && 刷怪总数.getValue() <= 0 && Main.world.moveChild_Enemy.numChildren <= 0)
            {
               for(i in GameDataXml.关卡)
               {
                  trace("海底关卡 ===== " + i);
                  if(int(GameDataXml.关卡[i].大关) == Main.gameNum.getValue() && int(GameDataXml.关卡[i].小关) == Main.gameNum2.getValue() + 1)
                  {
                     Main.gameNum2.setValue(Main.gameNum2.getValue() + 1);
                     GameData.GetData();
                     Main.world.NoStop();
                     return;
                  }
               }
            }
         }
         else if(winNum == 5)
         {
            if(Boolean(BossIS) && BossIS.life.getValue() <= 0)
            {
               if(Boolean(Main.world["继续"]) && !Main.world["继续"].openYN)
               {
                  (Main.world["继续"] as Door).Open(60);
               }
               if(Boolean(Main.world["回村"]) && !Main.world["回村"].openYN)
               {
                  (Main.world["回村"] as Door).Open(60);
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
         if(!Main.guanKa[Main.gameNum.getValue() + 1] || Main.guanKa[Main.gameNum.getValue() + 1] == 0)
         {
            Main.guanKa[Main.gameNum.getValue() + 1] = 1;
         }
         if(GameData.gameLV == 1 && Main.guanKa[Main.gameNum.getValue()] == 1)
         {
            Main.guanKa[Main.gameNum.getValue()] = 2;
         }
         else if(GameData.gameLV == 2 && Main.guanKa[Main.gameNum.getValue()] == 2)
         {
            Main.guanKa[Main.gameNum.getValue()] = 3;
         }
         else if(Main.guanKa[Main.gameNum.getValue()] != 1 && Main.guanKa[Main.gameNum.getValue()] != 2 && Main.guanKa[Main.gameNum.getValue()] != 3)
         {
            Main.guanKa[Main.gameNum.getValue()] = 2;
         }
      }
      
      private static function AddKillPoint_fun() : *
      {
         var N1:int = 0;
         var i:int = 0;
         var x:int = 0;
         if(Main.gameNum.getValue() > 100 || Main.gameNum.getValue() == 9)
         {
            return;
         }
         if(Main.gameNum.getValue() == 17)
         {
            AddKillPoint_P1P2(VT.GetTempVT("6*2*5*2"));
            Add_CW_exp_P1P2(VT.GetTempVT("6*2*5*2"));
         }
         else if(Main.gameNum.getValue() < 51)
         {
            N1 = 1;
            for(i = 2; i < 17; i++)
            {
               if(!(Boolean(Main.guanKa[i]) || Main.guanKa[i] > 0))
               {
                  break;
               }
               N1 = i;
            }
            x = N1 - Main.gameNum.getValue();
            if(x < 0)
            {
               return;
            }
            if(x >= 4)
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
         else
         {
            N1 = 1;
            for(i = 51; i < 81; i++)
            {
               if(!(Boolean(i == 51) || Boolean(Main.guanKa[i]) || Main.guanKa[i] > 0))
               {
                  break;
               }
               N1 = i;
            }
            x = N1 - Main.gameNum.getValue();
            if(x < 0)
            {
               return;
            }
            if(x >= 4)
            {
               AddKillPoint_P1P2(VT.GetTempVT("9/3"));
               Add_CW_exp_P1P2(VT.GetTempVT("9/3"));
            }
            else
            {
               AddKillPoint_P1P2(VT.GetTempVT("9+3") - VT.GetTempVT("6/3") * x);
               Add_CW_exp_P1P2(VT.GetTempVT("9+3") - VT.GetTempVT("6/3") * x);
            }
         }
      }
      
      private static function AddKillPoint_P1P2(i:int) : *
      {
         trace("~~~~~~~~~~~~~~~~~~~~~~~~~~AddKillPoint_P1P2 = " + i);
         if(Main.gameNum.getValue() != 17)
         {
            if(GameData.gameLV > 3 || i > 10)
            {
               return;
            }
         }
         if(GameData.gameLV == 2 && Main.gameNum.getValue() != 17)
         {
            i *= VT.GetTempVT("8+5/5/2");
         }
         else if(GameData.gameLV == 3 && Main.gameNum.getValue() != 17)
         {
            i *= VT.GetTempVT("8+8/5/2");
         }
         for(var j:int = 0; j < Main.player1.getTitleSlot().getListLength(); j++)
         {
            if(Main.player1.getTitleSlot().getTitleFromSlot(j).getId() == 25)
            {
               i *= 1.5;
            }
         }
         WinShow.txt_5 = i;
         Main.player1.AddKillPoint(i);
         if(Main.P1P2)
         {
            Main.player2.AddKillPoint(i);
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
         for(var j:int = 0; j < Main.player1.getTitleSlot().getListLength(); j++)
         {
            if(Main.player1.getTitleSlot().getTitleFromSlot(j).getId() == 25)
            {
               i *= 1.5;
            }
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
         if(Main.player_1.playerJL)
         {
            if(Main.player_1.playerJL.data.addExp(i))
            {
               NewMC.Open("宠物升级",Main.player_1.playerJL);
            }
         }
         if(Boolean(Main.P1P2) && Boolean(Main.player_2.playerJL))
         {
            if(Main.player_2.playerJL.data.addExp(i))
            {
               NewMC.Open("宠物升级",Main.player_2.playerJL);
            }
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
            }
            else if(!deadMcYN)
            {
               deadTime = 5;
               if(Main.gameNum.getValue() == 999)
               {
                  PkJiFun(false);
               }
               else
               {
                  GameOverX();
               }
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
            if(int(GameDataXml.关卡[i].大关) == Main.gameNum.getValue() && int(GameDataXml.关卡[i].小关) == Main.gameNum2.getValue())
            {
               return "Map_" + int(GameDataXml.关卡[i].预留2) + "_" + int(GameDataXml.关卡[i].预留3);
            }
         }
         return "Map_" + Main.gameNum.getValue() + "_" + Main.gameNum2.getValue();
      }
      
      public static function PkJiFun(dead:Boolean = true) : *
      {
         var Jifen:VT = null;
         var PlayerLV:int = 0;
         var x1:Number = NaN;
         var x2:Number = NaN;
         var x3:Number = NaN;
         var x4:Number = NaN;
         var x5:Number = NaN;
         var x6:Number = NaN;
         Main.Save();
         if(Main.gameNum.getValue() == 999 && Boolean(PK_UI.PK_ing))
         {
            Jifen = VT.createVT();
            PlayerLV = 1;
            if(Main.P1P2)
            {
               PlayerLV = (Main.player1.level.getValue() + Main.player2.level.getValue()) / 2;
            }
            else
            {
               PlayerLV = int(Main.player1.level.getValue());
            }
            x1 = PlayerLV * 100;
            x2 = PK_UI.killNum.getValue() * 5000;
            x3 = PK_UI.killNum.getValue() * 19 * Math.pow(110000 - PK_UI.Pk_timeNum,0.5);
            x4 = Main.player1.getEquipSlot().getSuitStrength() * 1000;
            x5 = 0;
            if(dead)
            {
               x5 = 10000;
            }
            x6 = 1.75;
            Jifen.setValue((x1 + x2 + x3 + x4 + x5) * x6 * 0.5);
            TiaoShi.txtShow("积分 = " + Jifen.getValue() + ",  " + x1 + ",  " + x2 + ",  " + x3 + ",  " + x4);
            TiaoShi.txtShow("PK_UI.killNum = " + PK_UI.killNum.getValue() + ",PK_UI.Pk_timeNum = " + PK_UI.Pk_timeNum);
            if(Jifen.getValue() > 1853210)
            {
               Jifen.setValue(Jifen.getValue() - Math.random() * 2000);
            }
            PK_JiFen_UI.Open(dead,Jifen.getValue());
            PK_UI.PK_ing = false;
            TiJiaoFenShu(Jifen.getValue());
         }
      }
      
      private static function TiJiaoFenShu(num:int) : *
      {
         var arr:Array = [];
         arr[0] = new Object();
         if(Main.P1P2)
         {
            arr[0].rId = 111;
         }
         else
         {
            arr[0].rId = 110;
         }
         arr[0].score = num;
         Api_4399_All.SubmitScore(Main.saveNum,arr);
      }
   }
}

