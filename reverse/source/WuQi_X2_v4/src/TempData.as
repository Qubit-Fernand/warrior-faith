package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["v4.1更新内容:","\t修正印章开启价格为60点券","\t增加画质设置储存","v4.0更新内容:"," 1.增加lv4悬赏BOSS"," 2.增加悬赏猎人LV4称号"," 3.增加防御印章"," 4.新增LV3与LV4悬赏BOSS卡片"," 5.画质与暂停功能，调整至“系统菜单内”"," 6.商城新增:VIP称号 (使用后即可生效，无需佩戴)"," 7.元旦点券消费折扣活动，折扣内容如下: ","\t通用印章开启价格5折，仅60点券(原价120点券)","\t击杀点商城特殊购买槽每格仅80点券(原价129点券)","\t星灵财宝每个仅售10点券(原价12点券)","\t大经验要7折出售，仅133点券每个(原价190点券)","\t商城新增:卓越4级强化石，仅150点券每个(原价3个兑换券)","\t以上让利内容在下次更新后恢复原价，卓越强化石下次更新下架。"];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 411;
         Strat.说明1 = "勇士的信仰【v4.11】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2013.1.5";
         Strat.VarXX();
         Load.mapArr = ["Map0_v13.swf","Map1.swf","Map2.swf","Map3_v2.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v5.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.mapArr[999] = "Map999.swf";
         Load.mapArr[1000] = "Map1000.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v5.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13_v2.swf","Enemy14_v2.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf","Enemy20.swf","Enemy21.swf","Enemy22.swf","Enemy23.swf"];
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
         Load.enemyArr[207] = "Enemy207_v2.swf";
         Load.enemyArr[208] = "Enemy207_v2.swf";
         Load.enemyArr[209] = "Enemy207_v2.swf";
         Load.enemyArr[210] = "Enemy210.swf";
         Load.enemyArr[211] = "Enemy210.swf";
         Load.enemyArr[212] = "Enemy210.swf";
         Load.enemyArr[1000] = "Enemy1000.swf";
         Load.otherArr = ["DataX_v53.swf","PlayerMc_X0_v6.swf","PlayerMc_X1_v6.swf","PlayerMc_X2_v6.swf","ZhuangBei_X0_v4.swf","ZhuangBei_X1_v4.swf","ZhuangBei_X2_v4.swf","WuQi_X0_v3.swf","WuQi_X1_v4.swf","WuQi_X2_v4.swf","EnemySkill_v6.swf","Data2X_v18.swf","Music.swf","ChongWu_v5.swf","ShiZhuang_X0_v5.swf","ShiZhuang_X1_v5.swf","ShiZhuang_X2_v5.swf","Card_v3.swf"];
      }
   }
}

