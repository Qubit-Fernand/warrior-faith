package com.hotpoint.braveManIII.repository.wantedTask
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.wantedTask.WantedTask;
   import src.*;
   
   public class WantedFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function WantedFactory()
      {
         super();
      }
      
      public static function creatWantedFactory() : *
      {
         var wanted:WantedFactory = new WantedFactory();
         myXml = XMLAsset.createXML(Data2.reward);
         wanted.creatWantedFactory();
      }
      
      public static function getWantedById(id:Number) : WantedBasicData
      {
         var wData:WantedBasicData = null;
         var data:WantedBasicData = null;
         for each(data in allData)
         {
            if(data.getId() == id)
            {
               wData = data;
            }
         }
         if(wData == null)
         {
         }
         return wData;
      }
      
      public static function getId(id:Number) : Number
      {
         return getWantedById(id).getId();
      }
      
      public static function getFrame(id:Number) : Number
      {
         return getWantedById(id).getFrame();
      }
      
      public static function getReward_1(id:Number) : Number
      {
         return getWantedById(id).getReward_1();
      }
      
      public static function getReward_2(id:Number) : Number
      {
         return getWantedById(id).getReward_2();
      }
      
      public static function getTimes(id:Number) : Number
      {
         return getWantedById(id).getTimes();
      }
      
      public static function getCooldown(id:Number) : Number
      {
         return getWantedById(id).getCooldown();
      }
      
      public static function getMap1(id:Number) : Number
      {
         return getWantedById(id).getMap1();
      }
      
      public static function getMap2(id:Number) : Number
      {
         return getWantedById(id).getMap2();
      }
      
      public static function getMap3(id:Number) : Number
      {
         return getWantedById(id).getMap3();
      }
      
      public static function getIntroduction(id:Number) : String
      {
         return getWantedById(id).getIntroduction();
      }
      
      public static function getName(id:Number) : Number
      {
         return getWantedById(id).getName();
      }
      
      public static function getMap(id:Number) : String
      {
         return getWantedById(id).getMap();
      }
      
      public static function getDrop(id:Number) : String
      {
         return getWantedById(id).getDrop();
      }
      
      public static function creatWantedTask(id:Number) : WantedTask
      {
         return getWantedById(id).creatWantedTask();
      }
      
      private function creatWantedFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var property:XML = null;
         var id:Number = NaN;
         var frame:Number = NaN;
         var name:String = null;
         var map:String = null;
         var introduction:String = null;
         var drop:String = null;
         var reward_1:Number = NaN;
         var reward_2:Number = NaN;
         var times:Number = NaN;
         var cooldown:Number = NaN;
         var map1:Number = NaN;
         var map2:Number = NaN;
         var map3:Number = NaN;
         var data:WantedBasicData = null;
         for each(property in myXml.悬赏)
         {
            id = Number(property.编号);
            frame = Number(property.帧数);
            name = String(property.名字);
            map = String(property.地图);
            introduction = String(property.描述);
            drop = String(property.掉落物品);
            reward_1 = Number(property.奖励1);
            reward_2 = Number(property.奖励2);
            times = Number(property.次数);
            cooldown = Number(property.冷却);
            map1 = Number(property.地图一);
            map2 = Number(property.地图二);
            map3 = Number(property.地图三);
            data = WantedBasicData.creatWantedBasicData(id,frame,name,map,introduction,drop,reward_1,reward_2,times,cooldown,map1,map2,map3);
            allData.push(data);
         }
      }
   }
}

