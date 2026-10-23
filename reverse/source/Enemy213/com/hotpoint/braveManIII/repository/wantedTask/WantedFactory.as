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
         var _loc1_:WantedFactory = new WantedFactory();
         myXml = XMLAsset.createXML(Data2.reward);
         _loc1_.creatWantedFactory();
      }
      
      public static function getWantedById(param1:Number) : WantedBasicData
      {
         var _loc2_:WantedBasicData = null;
         var _loc3_:WantedBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("找不到");
         }
         return _loc2_;
      }
      
      public static function getId(param1:Number) : Number
      {
         return getWantedById(param1).getId();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getWantedById(param1).getFrame();
      }
      
      public static function getReward_1(param1:Number) : Number
      {
         return getWantedById(param1).getReward_1();
      }
      
      public static function getReward_2(param1:Number) : Number
      {
         return getWantedById(param1).getReward_2();
      }
      
      public static function getTimes(param1:Number) : Number
      {
         return getWantedById(param1).getTimes();
      }
      
      public static function getCooldown(param1:Number) : Number
      {
         return getWantedById(param1).getCooldown();
      }
      
      public static function getMap1(param1:Number) : Number
      {
         return getWantedById(param1).getMap1();
      }
      
      public static function getMap2(param1:Number) : Number
      {
         return getWantedById(param1).getMap2();
      }
      
      public static function getMap3(param1:Number) : Number
      {
         return getWantedById(param1).getMap3();
      }
      
      public static function getIntroduction(param1:Number) : String
      {
         return getWantedById(param1).getIntroduction();
      }
      
      public static function getName(param1:Number) : Number
      {
         return getWantedById(param1).getName();
      }
      
      public static function getMap(param1:Number) : String
      {
         return getWantedById(param1).getMap();
      }
      
      public static function getDrop(param1:Number) : String
      {
         return getWantedById(param1).getDrop();
      }
      
      public static function creatWantedTask(param1:Number) : WantedTask
      {
         return getWantedById(param1).creatWantedTask();
      }
      
      private function creatWantedFactory() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:WantedBasicData = null;
         for each(_loc1_ in myXml.悬赏)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = Number(_loc1_.帧数);
            _loc4_ = String(_loc1_.名字);
            _loc5_ = String(_loc1_.地图);
            _loc6_ = String(_loc1_.描述);
            _loc7_ = String(_loc1_.掉落物品);
            _loc8_ = Number(_loc1_.奖励1);
            _loc9_ = Number(_loc1_.奖励2);
            _loc10_ = Number(_loc1_.次数);
            _loc11_ = Number(_loc1_.冷却);
            _loc12_ = Number(_loc1_.地图一);
            _loc13_ = Number(_loc1_.地图二);
            _loc14_ = Number(_loc1_.地图三);
            _loc15_ = WantedBasicData.creatWantedBasicData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_);
            allData.push(_loc15_);
         }
      }
   }
}

