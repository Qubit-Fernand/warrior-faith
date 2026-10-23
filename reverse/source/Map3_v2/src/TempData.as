package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.新增“白羊座”BOSS，需要游戏成就点数达到90时解锁","2.开放装备祝福的“武器祝福”功能，打败白羊座后可以使用","3.新增“白羊座循环任务”","4.新增“白羊座”称号，通过“白羊座循环任务”几率获得","5.竞技场的战绩分数计算方式调整","6.开放等级上限到80级","7.法师光之裁决技能持续时间缩短至5秒","8.修复了白羊座循环任务的奖励bug",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 332;
         Strat.说明1 = "勇士的信仰【v3.32】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2012.10.24";
         Strat.VarXX();
         Load.mapArr = ["Map0_v9.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.mapArr[999] = "Map999.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14_v2.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf","Enemy20.swf","Enemy21.swf","Enemy22.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.enemyArr[201] = "Enemy201.swf";
         Load.enemyArr[202] = "Enemy202.swf";
         Load.enemyArr[203] = "Enemy203.swf";
         Load.enemyArr[204] = "Enemy204.swf";
         Load.enemyArr[205] = "Enemy205.swf";
         Load.enemyArr[206] = "Enemy206.swf";
         Load.otherArr = ["DataX_v45.swf","PlayerMc_X0_v3.swf","PlayerMc_X1_v3.swf","PlayerMc_X2_v3.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0_v3.swf","WuQi_X1_v3.swf","WuQi_X2_v3.swf","EnemySkill_v5.swf","Data2X_v18.swf","Music.swf","ChongWu_v4.swf","ShiZhuang_X0_v3.swf","ShiZhuang_X1_v3.swf","ShiZhuang_X2_v3.swf"];
      }
   }
}

