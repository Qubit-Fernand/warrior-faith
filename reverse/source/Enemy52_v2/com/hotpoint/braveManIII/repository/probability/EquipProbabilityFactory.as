package com.hotpoint.braveManIII.repository.probability
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class EquipProbabilityFactory
   {
      
      public static var probabilityArr:Array = [];
      
      public static var probabilityData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function EquipProbabilityFactory()
      {
         super();
      }
      
      public static function creatProbabilltyData() : void
      {
         var data:EquipProbabilityFactory = new EquipProbabilityFactory();
         myXml = XMLAsset.createXML(Data2.probability);
         data.creatLoard();
      }
      
      public static function getProbabilltyByFallId(fallId:Number) : EquipBaseProbabilityData
      {
         var data:EquipBaseProbabilityData = null;
         var proData:EquipBaseProbabilityData = null;
         for each(data in probabilityData)
         {
            if(data.getfallLevel() == fallId)
            {
               proData = data;
            }
         }
         if(proData == null)
         {
            trace("找不到此掉落等级！！");
         }
         return proData;
      }
      
      public static function getPorbabillty(fallId:Number, strengthenLevel:Number) : Number
      {
         trace(fallId,strengthenLevel,getProbabilltyByFallId(fallId).getProbabil(strengthenLevel),"+++++++++++++++++++");
         return getProbabilltyByFallId(fallId).getProbabil(strengthenLevel);
      }
      
      public static function getGold(fallId:Number, strengthenLevel:Number) : Number
      {
         return getProbabilltyByFallId(fallId).getGold(strengthenLevel);
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var property:XML = null;
         var fallLevel:Number = NaN;
         var color:Number = NaN;
         var probabilityArr:XMLList = null;
         var goldArr:XMLList = null;
         var myArr:Array = null;
         var myArr2:Array = null;
         var equipProData:EquipBaseProbabilityData = null;
         for each(property in myXml.强化成功率)
         {
            fallLevel = Number(property.掉落等级);
            color = Number(property.颜色);
            probabilityArr = property.成功率.强化等级;
            goldArr = property.金币.强化等级;
            myArr = [];
            myArr2 = [];
            for each(property in probabilityArr)
            {
               myArr.push(property);
            }
            for each(property in goldArr)
            {
               myArr2.push(property);
            }
            equipProData = EquipBaseProbabilityData.creatProbabilityData(fallLevel,myArr,myArr2);
            probabilityData.push(equipProData);
         }
      }
   }
}

