package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.使用复活药复活时增加3秒无敌时间","2.宠物栏增加2格","3.3套套装特效调整","4.增加春节论坛活动的奖励领取","5.修正了3星难度关卡的数据","6.降低熔岩城堡的关卡难度","7.皓月系列不能洗练的BUG修复"];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 452;
         Strat.说明1 = "勇士的信仰【v4.52】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2013.2.7";
         Strat.VarXX();
         Load.mapArr = ["Map0_v17.swf","Map1.swf","Map2.swf","Map3_v2.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9_v2.swf","Map10.swf","Map11_v2.swf","Map12_v6.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.mapArr[105] = "Map105.swf";
         Load.mapArr[999] = "Map999.swf";
         Load.mapArr[51] = "Map51.swf";
         Load.mapArr[52] = "Map52.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v5.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13_v2.swf","Enemy14_v2.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf","Enemy20.swf","Enemy21.swf","Enemy22.swf","Enemy23.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.enemyArr[105] = "Enemy105.swf";
         Load.enemyArr[201] = "Enemy201.swf";
         Load.enemyArr[202] = "Enemy202.swf";
         Load.enemyArr[203] = "Enemy203.swf";
         Load.enemyArr[204] = "Enemy204_v2.swf";
         Load.enemyArr[205] = "Enemy205_v2.swf";
         Load.enemyArr[206] = "Enemy206_v2.swf";
         Load.enemyArr[207] = "Enemy207_v2.swf";
         Load.enemyArr[208] = "Enemy207_v2.swf";
         Load.enemyArr[209] = "Enemy207_v2.swf";
         Load.enemyArr[210] = "Enemy210.swf";
         Load.enemyArr[211] = "Enemy210.swf";
         Load.enemyArr[212] = "Enemy210.swf";
         Load.enemyArr[51] = "Enemy51.swf";
         Load.enemyArr[52] = "Enemy52.swf";
         Load.otherArr = ["DataX_v60.swf","PlayerMc_X0_v8.swf","PlayerMc_X1_v8.swf","PlayerMc_X2_v8.swf","ZhuangBei_X0_v5.swf","ZhuangBei_X1_v5.swf","ZhuangBei_X2_v5.swf","WuQi_X0_v4.swf","WuQi_X1_v5.swf","WuQi_X2_v4.swf","EnemySkill_v6.swf","Data2X_v19.swf","Music_v2.swf","ChongWu_v7.swf","ShiZhuang_X0_v5.swf","ShiZhuang_X1_v5.swf","ShiZhuang_X2_v5.swf","Card_v7.swf"];
      }
   }
}

