package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 232;
         Strat.说明1 = "勇士的信仰【v2.32】版本更新内容:";
         Strat.说明2 = "1.绚丽时装系统上线，所有玩家都可通过物品制作机制作获得" + "\n" + "2.击杀点商城内增加最新时装制作书。" + "\n" + "3.商城内增加出售最新款白色时装。" + "\n" + "4.强化、合成系统界面变更，新版界面可获得更直观体验。" + "\n" + "5.合成系统新增时装合成功能，相同时装合成之后能够升级成为更高级装备," + "\n" + "最高等级时装将拥有一条额外的神秘附加隐藏属性" + "\n";
         Strat.说明3 = "勇士的信仰团队 2012.6.11";
         Strat.VarXX();
         Load.mapArr = ["Map0_v6.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v5.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf"];
         Load.enemyArr[101] = "Enemy101_v3.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v28.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2.swf","EnemySkill_v5.swf","Data2X_v10.swf","Music.swf","ChongWu.swf","ShiZhuang_X0.swf","ShiZhuang_X1.swf","ShiZhuang_X2.swf"];
      }
   }
}

