package src
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   
   public class TempData extends MovieClip
   {
      
      private static var infoArr:Array = ["1.游戏画面大改版,变更了新的游戏登录图,加载图,世界地图,新村庄图片,新手形象,2个发型调整,NPC形象等","2.新增悬赏怪物LV6：毁灭者-初号机","3.击杀点商城新增力量印章制作书，力量印章碎片由【毁灭者—初号机】掉落","4.增加2个怪物图鉴:毁灭能源,毁灭者—初号机","5.降低开启下一等级悬赏怪条件,现在只需要击败10次悬赏怪开启下一等级悬赏怪了","6.悬赏称号领取也只需要击败10次对应悬赏怪即可。","7.增加新称号: 悬赏猎人LV6","8.仓库功能转移到NPC“探险家—艾路斯”上"];
      
      public function TempData()
      {
         super();
      }
      
      public static function Init() : *
      {
         Main.varX = 560;
         Strat.说明1 = "勇士的信仰【v5.6】版本更新内容:";
         Strat.说明2 = "";
         var _loc1_:int = 0;
         while(_loc1_ < infoArr.length)
         {
            Strat.说明2 += infoArr[_loc1_] + "\n";
            _loc1_++;
         }
         Strat.说明3 = "勇士的信仰团队 2013.7.4";
         Strat.VarXX();
         Load.mapArr = ["Map0_v26.swf","Map1.swf","Map2.swf","Map3_v2.swf","Map4.swf","Map5.swf","Map6.swf","Map7.swf","Map8.swf","Map9_v2.swf","Map10.swf","Map11_v2.swf","Map12_v6.swf","Map13.swf","Map14.swf","Map15.swf","Map16.swf","Map17.swf","Map18.swf"];
         Load.mapArr[101] = "Map101.swf";
         Load.mapArr[102] = "Map102.swf";
         Load.mapArr[103] = "Map103.swf";
         Load.mapArr[104] = "Map104.swf";
         Load.mapArr[105] = "Map105.swf";
         Load.mapArr[999] = "Map999.swf";
         Load.mapArr[51] = "Map51.swf";
         Load.mapArr[52] = "Map52.swf";
         Load.mapArr[53] = "Map53.swf";
         Load.mapArr[54] = "Map54.swf";
         Load.mapArr[55] = "Map55.swf";
         Load.mapArr[81] = "Map81_v2.swf";
         Load.enemyArr = ["","Enemy1.swf","Enemy2_v2.swf","Enemy3.swf","Enemy4.swf","Enemy5_v2.swf","Enemy6_v2.swf","Enemy7_v2.swf","Enemy8_v6.swf","Enemy9.swf","Enemy10_v6.swf","Enemy11_v2.swf","Enemy12.swf","Enemy13_v2.swf","Enemy14_v2.swf","Enemy15.swf","Enemy16.swf","Enemy17.swf","Enemy18.swf","Enemy19_v2.swf","Enemy20.swf","Enemy21.swf","Enemy22.swf","Enemy23.swf"];
         Load.enemyArr[101] = "Enemy101_v4.swf";
         Load.enemyArr[102] = "Enemy102.swf";
         Load.enemyArr[103] = "Enemy103_v5.swf";
         Load.enemyArr[104] = "Enemy104.swf";
         Load.enemyArr[105] = "Enemy105.swf";
         Load.enemyArr[201] = "Enemy201_v2.swf";
         Load.enemyArr[202] = "Enemy202.swf";
         Load.enemyArr[203] = "Enemy203_v2.swf";
         Load.enemyArr[204] = "Enemy204_v2.swf";
         Load.enemyArr[205] = "Enemy205_v2.swf";
         Load.enemyArr[206] = "Enemy206_v2.swf";
         Load.enemyArr[207] = "Enemy207_v2.swf";
         Load.enemyArr[208] = "Enemy207_v2.swf";
         Load.enemyArr[209] = "Enemy207_v2.swf";
         Load.enemyArr[210] = "Enemy210.swf";
         Load.enemyArr[211] = "Enemy210.swf";
         Load.enemyArr[212] = "Enemy210.swf";
         Load.enemyArr[213] = "Enemy213.swf";
         Load.enemyArr[214] = "Enemy213.swf";
         Load.enemyArr[215] = "Enemy213.swf";
         Load.enemyArr[216] = "Enemy216.swf";
         Load.enemyArr[217] = "Enemy216.swf";
         Load.enemyArr[218] = "Enemy216.swf";
         Load.enemyArr[51] = "Enemy51.swf";
         Load.enemyArr[52] = "Enemy52_v2.swf";
         Load.enemyArr[53] = "Enemy53.swf";
         Load.enemyArr[54] = "Enemy54.swf";
         Load.enemyArr[55] = "Enemy55_v2.swf";
         Load.enemyArr[81] = "Enemy81_v3.swf";
         Load.otherArr = ["DataX_v76.swf","PlayerMc_X0_v10.swf","PlayerMc_X1_v10.swf","PlayerMc_X2_v10.swf","ZhuangBei_X0_v6.swf","ZhuangBei_X1_v6.swf","ZhuangBei_X2_v6.swf","WuQi_X0_v4.swf","WuQi_X1_v6.swf","WuQi_X2_v4.swf","EnemySkill_v7.swf","Data2X_v19.swf","Music_v3.swf","ChongWu_v8.swf","ShiZhuang_X0_v5.swf","ShiZhuang_X1_v5.swf","ShiZhuang_X2_v5.swf"];
      }
   }
}

