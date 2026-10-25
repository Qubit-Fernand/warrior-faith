package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.增加新关卡“熔岩城堡”新BOSS“熔岩城主”","2.增加新循环任务“熔岩城主”有几率获得“熔火之心”称号","3.增加炼狱30层循环任务，有几率获得“炼狱终结者LV2”称号","4.增加3张怪物卡片“熔岩精灵”“熔岩骑士”“熔岩领主”","5.圣诞树活动下线,元旦商城折扣活动下线，道具恢复原价","6.法师技能调整增强:","  1）烈凤天舞调整:施放技能时短暂无敌,且技能不会被打断","  2）光之裁决调整:技能持续时间调整为7秒,且技能不会被打断","  3）圣光印天调整:光球发射距离增加3分之1,光球束缚时间增加1秒"];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 420;
         Strat.说明1 = "勇士的信仰【v4.2】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2013.1.11";
         Strat.VarXX();
         Load.mapArr = ["Map0_v14.swf","Map1.swf","Map2.swf","Map3_v2.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v5.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.mapArr[105] = "Map105.swf";
         Load.mapArr[999] = "Map999.swf";
         Load.mapArr[1000] = "Map1000.swf";
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
         Load.enemyArr[1000] = "Enemy1000.swf";
         Load.otherArr = ["DataX_v55.swf","PlayerMc_X0_v6.swf","PlayerMc_X1_v7.swf","PlayerMc_X2_v6.swf","ZhuangBei_X0_v4.swf","ZhuangBei_X1_v4.swf","ZhuangBei_X2_v4.swf","WuQi_X0_v3.swf","WuQi_X1_v4.swf","WuQi_X2_v4.swf","EnemySkill_v6.swf","Data2X_v19.swf","Music.swf","ChongWu_v6.swf","ShiZhuang_X0_v5.swf","ShiZhuang_X1_v5.swf","ShiZhuang_X2_v5.swf","Card_v4.swf"];
      }
   }
}

