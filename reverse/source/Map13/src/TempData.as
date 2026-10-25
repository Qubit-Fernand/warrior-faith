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
         Main.varX = 190;
         Strat.说明1 = "勇士的信仰正式版V1.9更新内容:";
         Strat.说明2 = "1.更新每日任务，完成每日任务可获得大量经验与物品。每日任务找”药品商人-妮蒂亚“领取。" + "\n" + "2.更新角色等级上限，最高等级可提至65级。" + "\n";
         Strat.说明3 = "勇士的信仰团队 2012.5.5";
         Strat.VarXX();
         Load.mapArr = ["Map0_v6.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v3.swf","Enemy9.swf","Enemy10_v5.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf"];
         Load.enemyArr[101] = "Enemy101_v3.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v21.swf","PlayerMc_X0.swf","PlayerMc_X1.swf","PlayerMc_X2.swf","ZhuangBei_X0.swf","ZhuangBei_X1_v2.swf","ZhuangBei_X2_v2.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2.swf","EnemySkill_v4.swf","Data2X_v6.swf"];
      }
   }
}

