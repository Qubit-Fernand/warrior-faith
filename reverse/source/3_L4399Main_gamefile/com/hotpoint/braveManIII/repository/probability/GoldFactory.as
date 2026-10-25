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
         var _loc1_:GoldFactory = new GoldFactory();
         _loc1_.creatLoard();
      }
      
      public static function getProbabilltyByFallId(param1:Number) : GoldBaseData
      {
         var _loc3_:GoldBaseData = null;
         var _loc2_:GoldBaseData = null;
         for each(_loc3_ in goldAllData)
         {
            if(_loc3_.getFallLevel() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
         }
         return _loc2_;
      }
      
      public static function getMosaicGold(param1:Number) : Number
      {
         return getProbabilltyByFallId(param1).getMosaicGold();
      }
      
      public static function getDeleteGold(param1:Number) : Number
      {
         return getProbabilltyByFallId(param1).getDeleteGold();
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:GoldBaseData = null;
         for each(_loc1_ in myXml.金币)
         {
            _loc2_ = Number(_loc1_.掉落等级);
            _loc3_ = Number(_loc1_.镶嵌);
            _loc4_ = Number(_loc1_.挖空);
            _loc5_ = GoldBaseData.creatGold(_loc2_,_loc3_,_loc4_);
            goldAllData.push(_loc5_);
         }
         goldIsOk = true;
      }
   }
}

