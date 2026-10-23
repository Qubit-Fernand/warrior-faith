package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.新增“悬赏任务”系统，点击村庄的悬赏情报板可以领取。","2.新增“潜能印章”系统","3.新增“称号系统”","4.新增悬赏3个BOSS“风速河马”“刺头象王”“黑锤巨角犀”","5.新增第一种潜力印章“魔力印章”","6.击杀点商城增加“魔力印章制作书”","7.每日任务的仙人掌任务调整，去掉需要达到30连击的要求。",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 300;
         Strat.说明1 = "勇士的信仰【v3.0】版本更新内容:";
         Strat.说明2 = "";
         var _loc1_:int = 0;
         while(_loc1_ < infoArr.length)
         {
            Strat.说明2 += infoArr[_loc1_] + "\n";
            _loc1_++;
         }
         Strat.说明3 = "勇士的信仰团队 2012.9.6";
         Strat.VarXX();
         Load.mapArr = ["Map0_v7.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf","Enemy20.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.enemyArr[201] = "Enemy201.swf";
         Load.enemyArr[202] = "Enemy202.swf";
         Load.enemyArr[203] = "Enemy203.swf";
         Load.otherArr = ["DataX_v37.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1_v2.swf","WuQi_X2_v2.swf","EnemySkill_v5.swf","Data2X_v18.swf","Music.swf","ChongWu_v3.swf","ShiZhuang_X0_v2.swf","ShiZhuang_X1_v2.swf","ShiZhuang_X2_v2.swf"];
      }
   }
}

