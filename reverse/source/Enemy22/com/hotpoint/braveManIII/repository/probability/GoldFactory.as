package com.hotpoint.braveManIII.repository.probability
{
   public class GoldFactory
   {
      
      public static var goldIsOk:Boolean;
      
      public static var goldAllData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function GoldFactory()
      {
         super();
      }
      
      public static function creatGoldFactory() : void
      {
         var goldDataFactory:GoldFactory = new GoldFactory();
         goldDataFactory.creatLoard();
      }
      
      public static function getProbabilltyByFallId(fallId:Number) : GoldBaseData
      {
         var data:GoldBaseData = null;
         var gData:GoldBaseData = null;
         for each(data in goldAllData)
         {
            if(data.getFallLevel() == fallId)
            {
               gData = data;
            }
         }
         if(gData == null)
         {
            trace("找不到此掉落等级！！");
         }
         return gData;
      }
      
      public static function getMosaicGold(fallId:Number) : Number
      {
         trace(fallId);
         return getProbabilltyByFallId(fallId).getMosaicGold();
      }
      
      public static function getDeleteGold(fallId:Number) : Number
      {
         return getProbabilltyByFallId(fallId).getDeleteGold();
      }
      
      private function creatLoard() : *
      {
         this.xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var property:XML = null;
         var fallLevel:Number = NaN;
         var mGold:Number = NaN;
         var dGold:Number = NaN;
         var goldData:GoldBaseData = null;
         for each(property in myXml.金币)
         {
            fallLevel = Number(property.掉落等级);
            mGold = Number(property.镶嵌);
            dGold = Number(property.挖空);
            goldData = GoldBaseData.creatGold(fallLevel,mGold,dGold);
            goldAllData.push(goldData);
         }
         goldIsOk = true;
      }
   }
}

