package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.新增关卡[炼狱]BOSS组合挑战关卡，消耗一个[炼狱入场券]可以进入","2.新增3个[星]武器制作书，击杀点商城出售","\t制作所需材料的[星级碎片]在[炼狱]关卡的第5.10.15.20波都有几率掉落","3.物品制作机新增\'武器制作\'分类，使用制作书后可解锁制作功能","4.新增[节日任务]一个与[暗影城每日任务][暗夜遗迹每日任务]","\t与[炼狱入场券每日任务]找药品NPC妮蒂亚领取","5.新增[2级升星石][星级碎片]，[炼狱]关卡第5.10.15.20波有几率掉落","6.等级上限提升至70级","7.三星暗夜遗迹，BOSS有几率掉落[炼狱入场券]"];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 250;
         Strat.说明1 = "勇士的信仰【v2.50】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2012.6.21";
         Strat.VarXX();
         Load.mapArr = ["Map0_v6.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.otherArr = ["DataX_v30.swf","PlayerMc_X0_v2.swf","PlayerMc_X1_v2.swf","PlayerMc_X2_v2.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0.swf","WuQi_X1.swf","WuQi_X2.swf","EnemySkill_v5.swf","Data2X_v16.swf","Music.swf","ChongWu_v2.swf","ShiZhuang_X0.swf","ShiZhuang_X1.swf","ShiZhuang_X2.swf"];
      }
   }
}

