package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.新增双鱼座星灵BOSS，需要游戏成就点数达到50才可解锁","2.新增\'装备祝福-项链\'部位，打败双鱼座星灵时，可以进行项链部位的祝福。新装材料\'双鱼座能源-项链\'，由双鱼座BOSS掉落","3.新增“充值活动大礼包”，赠送各种“徽章”及“卓越4级强化石”“金色时装-尊贵的冥王时装 (含特殊属性: 被攻击时10%的几率回复10%的HP)”“技能点”等稀有道具。","4.修复“成就系统”的各种BUG，并增加“显示未完成成就”功能","5.再次降低“重生”NPC友好度的满值，降低至50点。","6.修复装备祝福后属性加成不正确的bug","","",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 290;
         Strat.说明1 = "勇士的信仰【v2.90】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2012.8.9";
         Strat.VarXX();
         Load.mapArr = ["Map0_v6.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v35.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2_v2.swf","EnemySkill_v5.swf","Data2X_v18.swf","Music.swf","ChongWu_v3.swf","ShiZhuang_X0_v2.swf","ShiZhuang_X1_v2.swf","ShiZhuang_X2_v2.swf"];
      }
   }
}

