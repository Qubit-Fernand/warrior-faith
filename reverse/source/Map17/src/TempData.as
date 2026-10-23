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
         Main.varX = 240;
         Strat.说明1 = "勇士的信仰【v2.50】版本更新内容:";
         Strat.说明2 = "1.新增关卡“暗夜遗迹”与新BOSS“时之吞食者”" + "\n" + "2.NPC冒险家艾路斯，新增宠物任务，完成任务后可以获得宠物“时之吞食者（幼体）”" + "\n" + "3.变更“宝石镶嵌”界面与镶嵌规则，已镶嵌宝石的装备再次镶嵌宝石时将替换掉原来已经镶嵌的宝石" + "\n" + "4.新增宠物“时之吞食者（幼体）”可以进化（尚未开启）" + "\n" + "5.新增高级属性石，掉落地点于新关卡“暗夜遗迹”3星难度掉落" + "\n";
         Strat.说明3 = "勇士的信仰团队 2012.6.16";
         Strat.VarXX();
         Load.mapArr = ["Map0_v6.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v5.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf"];
         Load.enemyArr[101] = "Enemy101_v3.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v29.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2.swf","EnemySkill_v5.swf","Data2X_v15.swf","Music.swf","ChongWu_v2.swf","ShiZhuang_X0.swf","ShiZhuang_X1.swf","ShiZhuang_X2.swf"];
      }
   }
}

