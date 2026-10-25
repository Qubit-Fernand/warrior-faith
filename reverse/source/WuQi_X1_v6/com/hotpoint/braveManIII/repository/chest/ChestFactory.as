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
         var _loc1_:ChestFactory = new ChestFactory();
         myXml = XMLAsset.createXML(Data2.chestData);
         _loc1_.creatChestXml();
      }
      
      public static function getId() : Number
      {
         return getDataByPro(gl).getId();
      }
      
      public static function getRewardId(param1:Number) : Number
      {
         return getDataByPro(param1).getRewardId();
      }
      
      public static function getType(param1:Number) : Number
      {
         return getDataByPro(param1).getType();
      }
      
      public static function getDataByPro(param1:Number) : ChecstBasicData
      {
         var _loc3_:ChecstBasicData = null;
         var _loc2_:Number = 0;
         for each(_loc3_ in allData)
         {
            _loc2_ += _loc3_.getProbability();
            if(_loc2_ >= param1)
            {
               return _loc3_;
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
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:ChecstBasicData = null;
         for each(_loc1_ in myXml.宝箱)
         {
            _loc2_ = Number(_loc1_.ID);
            _loc3_ = Number(_loc1_.奖励ID);
            _loc4_ = Number(_loc1_.奖励类型);
            _loc5_ = Number(_loc1_.概率);
            _loc6_ = ChecstBasicData.creatChestBasicData(_loc2_,_loc3_,_loc4_,_loc5_);
            allData.push(_loc6_);
         }
      }
   }
}

