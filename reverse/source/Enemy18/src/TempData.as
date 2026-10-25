package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.新增\'成就系统\'分别为：每日成就与游戏成就。完成对应类型的成就可获得对应类型的成就点数","2.新增“星灵擂台”挑战关与新BOSS“巨蟹座星灵”需消耗”每日成就点数“才可进行挑战。","3.新装“装备祝福”功能，打败BOSS“巨蟹座星灵”后在地图中将出现魔盒，点击后，消耗一定的材料，","\t可对装备进行“祝福”，祝福后可获得一条额外的随机属性。巨蟹座的祝福仅针对“戒指”。","4.新增“强化等级清除“功能，在击杀点商城购买\'消亡魔盒\'道具，点击使用，可对已强化过的装备进行","\t强化等级清除为0的操作。","5.新增材料\'巨蟹座能源-戒指\'，由BOSS巨蟹座星灵掉落，用于装备祝福","6.时装升星的属性提升，神技套装效果调整","7.修复时装不可强化，镶嵌bug，友好度满值bug修复","",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 280;
         Strat.说明1 = "勇士的信仰【v2.80】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2012.7.26";
         Strat.VarXX();
         Load.mapArr = ["Map0_v6.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf","Map19.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v34.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2_v2.swf","EnemySkill_v5.swf","Data2X_v18.swf","Music.swf","ChongWu_v3.swf","ShiZhuang_X0.swf","ShiZhuang_X1.swf","ShiZhuang_X2.swf"];
      }
   }
}

