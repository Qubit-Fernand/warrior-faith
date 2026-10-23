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
      
      public static var deadMcYN:Boolean = false;
      
      private static var deadTime:int = 135;
      
      public function GameData()
      {
         super();
      }
      
      public static function GetData() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         monsterTime = 0;
         刷怪索引 = 0;
         怪物id = new Array();
         随机id = new Array();
         for(_loc1_ in GameDataXml.关卡)
         {
            大关 = int(GameDataXml.关卡[_loc1_].大关);
            小关 = int(GameDataXml.关卡[_loc1_].小关);
            if(Main.gameNum == 大关 && Main.gameNum2 == 小关)
            {
               BOSS = true;
               过关条件 = int(GameDataXml.关卡[_loc1_].预留1);
               同屏数量 = int(GameDataXml.关卡[_loc1_].同屏数量);
               刷怪频率 = int(GameDataXml.关卡[_loc1_].刷怪频率) * Main.fps;
               刷怪总数 = int(GameDataXml.关卡[_loc1_].刷怪总数);
               BOSSid = int(GameDataXml.关卡[_loc1_].BOSSid);
               _loc2_ = 1;
               while(_loc2_ <= 30)
               {
                  _loc4_ = int(GameDataXml.关卡[_loc1_]["怪物id" + _loc2_]);
                  if(_loc4_ >= 0)
                  {
                     怪物id[怪物id.length] = _loc4_;
                  }
                  _loc2_++;
               }
               _loc3_ = 1;
               while(_loc3_ <= 5)
               {
                  _loc5_ = int(GameDataXml.关卡[_loc1_]["随机id" + _loc3_]);
                  if(_loc5_ > 0)
                  {
                     随机id[随机id.length] = _loc5_;
                  }
                  _loc3_++;
               }
               return;
            }
         }
      }
      
      public static function MonsterGo() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
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
               _loc1_ = 同屏数量 - Enemy.All.length;
               刷怪总数 -= _loc1_;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  WhoAreYou();
                  _loc2_++;
               }
            }
         }
         Win(过关条件);
         Lose();
      }
      
      private static function Where() : int
      {
         var _loc1_:int = 0;
         _loc1_ = Math.random() * 7;
         if(_loc1_ == 0)
         {
            return -200;
         }
         if(_loc1_ == 1)
         {
            return 1800;
         }
         return Math.random() * 1600;
      }
      
      private static function GameOverX() : *
      {
         var _loc1_:GameOver = null;
         _loc1_ = new GameOver();
         Main._stage.addChild(_loc1_);
         deadMcYN = true;
      }
      
      private static function WhoAreYou() : *
      {
         var _loc1_:Enemy = null;
         var _loc2_:int = 0;
         var _loc3_:Enemy = null;
         if(刷怪索引 >= 怪物id.length)
         {
            刷怪索引 = 0;
         }
         if(怪物id[刷怪索引] != 0)
         {
            _loc1_ = new Enemy(怪物id[刷怪索引]);
            Main.world.moveChild_Enemy.addChild(_loc1_);
            _loc2_ = int(Where());
            _loc1_.x = _loc2_;
            _loc1_.y = 380;
         }
         else
         {
            _loc2_ = Math.random() * 随机id.length;
            _loc3_ = new Enemy(随机id[_loc2_]);
            Main.world.moveChild_Enemy.addChild(_loc3_);
            _loc2_ = int(Where());
            _loc3_.x = _loc2_;
            _loc3_.y = 380;
         }
         ++刷怪索引;
      }
      
      private static function Lose() : *
      {
         var _loc1_:Boolean = false;
         _loc1_ = false;
         if(Boolean(Main.P1P2) && Main.player_1.hp.getValue() <= 0 && Main.player_2.hp.getValue() <= 0)
         {
            _loc1_ = true;
         }
         else if(!Main.P1P2 && Main.player_1.hp.getValue() <= 0)
         {
            _loc1_ = true;
         }
         if(_loc1_)
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
      
      private static function Win(param1:int) : *
      {
         var _loc2_:* = undefined;
         if(param1 == 0)
         {
            return;
         }
         if(param1 == 1)
         {
            if(Enemy.All.length <= 0 && 刷怪总数 <= 0 && Main.world.moveChild_Enemy.numChildren <= 0)
            {
               for(_loc2_ in GameDataXml.关卡)
               {
                  if(int(GameDataXml.关卡[_loc2_].大关) == Main.gameNum && int(GameDataXml.关卡[_loc2_].小关) == Main.gameNum2 + 1)
                  {
                     if(Main.world["继续"])
                     {
                        (Main.world["继续"] as Door).Open();
                     }
                     return;
                  }
                  if(Main.world["回村"])
                  {
                     (Main.world["回村"] as Door).Open();
                     Main.guanKa[Main.gameNum + 1] = true;
                  }
               }
            }
         }
         else if(param1 == 2)
         {
            if(Boolean(BossIS) && BossIS.life <= 0)
            {
               if(Main.world["回村"])
               {
                  (Main.world["回村"] as Door).Open();
                  Main.guanKa[Main.gameNum + 1] = true;
               }
               if(Main.world["继续"])
               {
                  (Main.world["继续"] as Door).Open();
               }
            }
         }
      }
   }
}

