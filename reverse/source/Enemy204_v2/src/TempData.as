package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.更新LV2悬赏怪物，需要LV1悬赏BOSS完成100次才可开启","2.新增LV2悬赏BOSS 3个","3.新增“体力印章”,打败悬赏BOSS有几率获得体力印章碎片1.2.3,通过制作机合成获得","4.击杀点商城增加“体力印章制作书”","5.调整了“魔力印章”的效果，调整为吃蓝药时可额外增加魔力值回复量","6.商城增加复活药道具,设置到药品快捷键,死亡后5秒内使用可以时角色满状态复活",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 341;
         Strat.说明1 = "勇士的信仰【v3.41】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2012.11.1";
         Strat.VarXX();
         Load.mapArr = ["Map0_v9.swf","Map1.swf","Map2.swf","Map3_v2.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.mapArr[999] = "Map999.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13_v2.swf","Enemy14_v2.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf","Enemy20.swf","Enemy21.swf","Enemy22.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.enemyArr[201] = "Enemy201.swf";
         Load.enemyArr[202] = "Enemy202.swf";
         Load.enemyArr[203] = "Enemy203.swf";
         Load.enemyArr[204] = "Enemy204_v2.swf";
         Load.enemyArr[205] = "Enemy205_v2.swf";
         Load.enemyArr[206] = "Enemy206_v2.swf";
         Load.otherArr = ["DataX_v46.swf","PlayerMc_X0_v3.swf","PlayerMc_X1_v3.swf","PlayerMc_X2_v3.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0_v3.swf","WuQi_X1_v3.swf","WuQi_X2_v3.swf","EnemySkill_v5.swf","Data2X_v18.swf","Music.swf","ChongWu_v4.swf","ShiZhuang_X0_v3.swf","ShiZhuang_X1_v3.swf","ShiZhuang_X2_v3.swf"];
      }
   }
}

