package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.新增宠物进化功能，当宠物达到20级时，点击进化按钮，消耗2个“生命之源”","\t即可进化到下一形态（钢盔鸡暂不支持进化）","2.新增宠物领悟技能功能，当宠物进化到最终形态后，宠物每升5级即可获得","\t一次领悟技能的机会，领悟技能的数量与宠物的悟性值成正比","3.击杀点商城的特殊购买栏增加“生命之源”道具，用于宠物进化用，用于宠物","\t进化用，可用击杀点购买","4.延长宠物饥饿的时间","5.“宠物界面”增加宠物升级按钮","6.“一键出售”调整,不会出售时装",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 260;
         Strat.说明1 = "勇士的信仰【v2.60】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2012.7.16";
         Strat.VarXX();
         Load.mapArr = ["Map0_v6.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf","Map19.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf","Enemy15.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v32.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2_v2.swf","EnemySkill_v5.swf","Data2X_v17.swf","Music.swf","ChongWu_v3.swf","ShiZhuang_X0.swf","ShiZhuang_X1.swf","ShiZhuang_X2.swf"];
      }
   }
}

