package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["v3.11更新:","1.缩短每日任务流程，增加每日任务福利","2.增加循环任务物品获得。调整人造人G1循环任务的奖励物品。","3.增加积分兑换物品功能，网页提供勇士的信仰体验礼包供玩家兑换限量10000份，详见群组官方公告","v3.0更新:","1.任务系统改版，并新增大量循环任务与每日任务。（所有任务重置）","2.新增悬赏BOSS击杀100次时获得称号“悬赏猎人LV.1”","3.悬赏BOSS击杀次数统计方式调整","4.新增5个粉色品质称号。分别通过：悬赏击杀次数获得，循环任务有几率获得（星灵擂台的循环任务与炼狱的循环任务）","5.新增兑换码兑换功能。","6.修复多处BUG：热血效果防御失效，神技套装效果失效，合成增加物品BUG，增加2P祝福，生命复苏技能石效果修复等","7.取消时之吞食者的炼狱入场券掉落，取消1,2,3级强化石副本掉落，取消火鸟合成剂掉落，调整为循环任务几率获得。",""];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 311;
         Strat.说明1 = "勇士的信仰【v3.2】版本更新内容:";
         Strat.说明2 = "";
         for(var i:int = 0; i < infoArr.length; i++)
         {
            Strat.说明2 += infoArr[i] + "\n";
         }
         Strat.说明3 = "勇士的信仰团队 2012.9.28";
         Strat.VarXX();
         Load.mapArr = ["Map0_v8.swf","Map1.swf","Map2.swf","Map3.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9.swf","Map10.swf","Map11_v2.swf","Map12_v4.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v4.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13.swf","Enemy14.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf","Enemy20.swf","Enemy21.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.enemyArr[201] = "Enemy201.swf";
         Load.enemyArr[202] = "Enemy202.swf";
         Load.enemyArr[203] = "Enemy203.swf";
         Load.otherArr = ["DataX_v41.swf","PlayerMc_X0_v3.swf","PlayerMc_X1_v3.swf","PlayerMc_X2_v3.swf","ZhuangBei_X0_v3.swf","ZhuangBei_X1_v3.swf","ZhuangBei_X2_v3.swf","WuQi_X0_v3.swf","WuQi_X1_v3.swf","WuQi_X2_v3.swf","EnemySkill_v5.swf","Data2X_v18.swf","Music.swf","ChongWu_v4.swf","ShiZhuang_X0_v2.swf","ShiZhuang_X1_v2.swf","ShiZhuang_X2_v2.swf"];
      }
   }
}

