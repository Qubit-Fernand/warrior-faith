package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.新增“机械试验场”关卡与新BOSS“光影-贝尔”。","2.降低“时之吞食者”宠物任务的难度，约降低50%","3.降低NPC友好度的值，满值降低至80点","4.宠物任务变更为循环任务。","5.每日任务的死亡流沙任务连击数需求降低。","6.时装升星功能开启。","7.新关卡BOSS“光影-贝尔”3星难度将掉落“星级碎片”","8. 一键出售调整 不会出售时装 ","  ",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 270;
         Strat.说明1 = "勇士的信仰【v2.70】版本更新内容:";
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
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf","Enemy15.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v33.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2_v2.swf","EnemySkill_v5.swf","Data2X_v18.swf","Music.swf","ChongWu_v3.swf","ShiZhuang_X0.swf","ShiZhuang_X1.swf","ShiZhuang_X2.swf"];
      }
   }
}

