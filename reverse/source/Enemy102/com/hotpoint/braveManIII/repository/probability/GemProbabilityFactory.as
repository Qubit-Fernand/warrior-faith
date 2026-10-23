package com.hotpoint.braveManIII.repository.probability
{
   public class GemProbabilityFactory
   {
      
      public static var isProbabilityOk:Boolean;
      
      public static var probabilityArr:Array = [];
      
      public static var probabilityData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function GemProbabilityFactory()
      {
         super();
      }
      
      public static function getPorbabillty(param1:Number, param2:Number) : Number
      {
         return getProbabilltyByFallId(param1).getProbabil(param2);
      }
      
      public static function getProbabilltyByFallId(param1:Number) : EquipBaseProbabilityData
      {
         var _loc2_:EquipBaseProbabilityData = null;
         var _loc3_:EquipBaseProbabilityData = null;
         _loc2_ = null;
         for each(_loc3_ in probabilityData)
         {
            if(_loc3_.getfallLevel() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("找不到此掉落等级！！");
         }
         return _loc2_;
      }
      
      public static function creatProbabilltyData() : void
      {
         var _loc1_:GemProbabilityFactory = null;
         _loc1_ = new GemProbabilityFactory();
         _loc1_.creatLoard();
      }
      
      public static function getGold(param1:Number, param2:Number) : Number
      {
         return getProbabilltyByFallId(param1).getGold(param2);
      }
      
      public function EquipProbabilityFactory() : *
      {
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
         var _loc4_:XMLList = null;
         var _loc5_:XMLList = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:EquipBaseProbabilityData = null;
         for each(_loc1_ in myXml.强化成功率)
         {
            _loc2_ = Number(_loc1_.掉落等级);
            _loc3_ = Number(_loc1_.颜色);
            _loc4_ = _loc1_.成功率.强化等级;
            _loc5_ = _loc1_.金币.强化等级;
            _loc6_ = [];
            _loc7_ = [];
            for each(_loc1_ in _loc4_)
            {
               _loc6_.push(_loc1_);
            }
            for each(_loc1_ in _loc5_)
            {
               _loc7_.push(_loc1_);
            }
            _loc8_ = EquipBaseProbabilityData.creatProbabilityData(_loc2_,_loc6_,_loc7_);
            probabilityData.push(_loc8_);
         }
         isProbabilityOk = true;
      }
   }
}

