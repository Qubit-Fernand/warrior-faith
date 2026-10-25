package com.hotpoint.braveManIII.repository.chest
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class ChestFactory
   {
      
      public static var allData:Array = [];
      
      public function ChestFactory()
      {
         super();
      }
      
      public static function creatChestFactory() : *
      {
         var data:ChestFactory = new ChestFactory();
         myXml = XMLAsset.createXML(Data2.chestData);
         data.creatChestXml();
      }
      
      public static function getId() : Number
      {
         return getDataByPro(gl).getId();
      }
      
      public static function getRewardId(gl:Number) : Number
      {
         return getDataByPro(gl).getRewardId();
      }
      
      public static function getType(id:Number) : Number
      {
         return getDataByPro(id).getType();
      }
      
      public static function getDataByPro(num:Number) : ChecstBasicData
      {
         var data:ChecstBasicData = null;
         var xx:Number = 0;
         for each(data in allData)
         {
            xx += data.getProbability();
            if(xx >= num)
            {
               return data;
            }
         }
         return null;
      }
      
      private function creatChestXml() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var property:XML = null;
         var id:Number = NaN;
         var rewardId:Number = NaN;
         var type:Number = NaN;
         var probability:Number = NaN;
         var data:ChecstBasicData = null;
         for each(property in myXml.宝箱)
         {
            id = Number(property.ID);
            rewardId = Number(property.奖励ID);
            type = Number(property.奖励类型);
            probability = Number(property.概率);
            data = ChecstBasicData.creatChestBasicData(id,rewardId,type,probability);
            allData.push(data);
         }
      }
   }
}

