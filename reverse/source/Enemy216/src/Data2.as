package src
{
   import com.hotpoint.braveManIII.repository.achievement.*;
   import com.hotpoint.braveManIII.repository.chest.*;
   import com.hotpoint.braveManIII.repository.elves.*;
   import com.hotpoint.braveManIII.repository.monsterCard.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.plan.*;
   import com.hotpoint.braveManIII.repository.probability.*;
   import com.hotpoint.braveManIII.repository.task.*;
   import com.hotpoint.braveManIII.repository.title.*;
   import com.hotpoint.braveManIII.repository.wantedTask.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import src._data.*;
   import src.tool.*;
   
   public class Data2 extends MovieClip
   {
      
      public static const petHit_data:Class = Data2_petHit_data;
      
      public static const pet_set:Class = Data2_pet_set;
      
      public static const AchNum:Class = Data2_AchNum;
      
      public static const title:Class = Data2_title;
      
      public static const reward:Class = Data2_reward;
      
      public static const taskData:Class = Data2_taskData;
      
      public static const elves:Class = Data2_elves;
      
      public static const chestData:Class = Data2_chestData;
      
      public static const probability:Class = Data2_probability;
      
      public static const property:Class = Data2_property;
      
      public static const monster:Class = Data2_monster;
      
      public static const xingLing:Class = Data2_xingLing;
      
      public static const jihua:Class = Data2_jihua;
      
      public static const shopData:Class = Data2_shopData;
      
      public static const gameObjData:Class = Data2_gameObjData;
      
      public function Data2()
      {
         super();
         Data2_data.关卡数据1();
         Data2_data.关卡数据2();
         Data2_data.关卡数据3();
         Data2_data.关卡数据4();
         Data2_data.EnemyXML_1();
         Data2_data.EnemyXML_2();
         Data2_data.EnemyXML_3();
         Data2_data.EnemyXML_4();
         Data2_data.EnemySkinXML_1();
         Data2_data.EnemySkinXML_2();
         Data2_data.EnemySkinXML_3();
         Data2_data.EnemySkinXML_4();
         Data2_data.EnemySkinXML_CaiFen();
         PetFactory.creatPetFactory();
         ChongWu.get_XML_data();
         AchNumFactory.creatAchNumFactory();
         TitleFactory.creatTitleFactory();
         WantedFactory.creatWantedFactory();
         TaskFactory.creatTaskFactory();
         ElvesFactory.creatElvesFactory();
         ChestFactory.creatChestFactory();
         EquipProbabilityFactory.creatProbabilltyData();
         EquipPropertyFactory.creatEquipData();
         MonsterFactory.creatMonsterFactory();
         PlanFactory.creatPlanFactory();
         XingLingFactory.creatFactory();
         GaneObjFactory.creatFactory();
         ShopFactory.creatFactory();
         EmenyDataMD5();
      }
      
      private function EmenyDataMD5() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < Enemy.EnemyXmlArr.length)
         {
            Enemy.EnemyXmlArrMd5[_loc1_] = Obj_Compare.getObj_ByteArray(Enemy.EnemyXmlArr[_loc1_]);
            _loc1_++;
         }
      }
   }
}

