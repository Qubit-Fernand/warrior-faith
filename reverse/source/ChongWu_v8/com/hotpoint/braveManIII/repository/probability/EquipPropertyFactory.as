package com.hotpoint.braveManIII.repository.probability
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class EquipPropertyFactory
   {
      
      public static var isPropertyOk:Boolean;
      
      public static var allDataArr:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function EquipPropertyFactory()
      {
         super();
      }
      
      public static function creatEquipData() : *
      {
         var _loc1_:EquipPropertyFactory = new EquipPropertyFactory();
         myXml = XMLAsset.createXML(Data2.property);
         _loc1_.creatLoader();
      }
      
      public static function getProbabilltyByFallId(param1:Number, param2:Number) : EquipPropertyBaseData
      {
         var _loc5_:EquipPropertyBaseData = null;
         var _loc6_:EquipPropertyBaseData = null;
         var _loc3_:EquipPropertyBaseData = null;
         var _loc4_:Array = [];
         for each(_loc5_ in allDataArr)
         {
            if(_loc5_.getFalllevel() == param1)
            {
               _loc3_ = _loc5_;
               _loc4_.push(_loc3_);
            }
         }
         if(_loc4_.length < 1)
         {
         }
         for each(_loc6_ in _loc4_)
         {
            if(_loc6_.getPosi() == param2)
            {
               _loc3_ = _loc6_;
            }
         }
         if(_loc3_ == null)
         {
         }
         return _loc3_;
      }
      
      public static function getProperty(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return getProbabilltyByFallId(param1,param2).getPropety(param3,param4);
      }
      
      private function creatLoader() : void
      {
         xmlLoaded();
      }
      
      internal function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:XMLList = null;
         var _loc6_:XMLList = null;
         var _loc7_:XMLList = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:EquipPropertyBaseData = null;
         for each(_loc1_ in myXml.强化数据)
         {
            _loc2_ = Number(_loc1_.装备部位);
            _loc3_ = Number(_loc1_.掉落等级);
            _loc4_ = Number(_loc1_.颜色);
            _loc5_ = _loc1_.具体值.宝石A.强化等级;
            _loc6_ = _loc1_.具体值.宝石B.强化等级;
            _loc7_ = _loc1_.具体值.宝石C.强化等级;
            _loc8_ = [];
            _loc9_ = [];
            _loc10_ = [];
            for each(_loc1_ in _loc5_)
            {
               _loc8_.push(_loc1_);
            }
            for each(_loc1_ in _loc6_)
            {
               _loc9_.push(_loc1_);
            }
            for each(_loc1_ in _loc7_)
            {
               _loc10_.push(_loc1_);
            }
            _loc11_ = EquipPropertyBaseData.ceatPropertyData(_loc2_,_loc3_,_loc4_,_loc8_,_loc9_,_loc10_);
            allDataArr.push(_loc11_);
         }
         isPropertyOk = true;
      }
   }
}

