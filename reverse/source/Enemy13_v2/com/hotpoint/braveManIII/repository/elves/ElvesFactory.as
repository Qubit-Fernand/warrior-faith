package com.hotpoint.braveManIII.repository.elves
{
   import com.hotpoint.braveManIII.Tool.*;
   import com.hotpoint.braveManIII.models.elves.Elves;
   import src.*;
   
   public class ElvesFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function ElvesFactory()
      {
         super();
      }
      
      public static function creatElvesFactory() : *
      {
         var _loc1_:ElvesFactory = new ElvesFactory();
         myXml = XMLAsset.createXML(Data2.elves);
         _loc1_.creatElvesFactory();
      }
      
      public static function getElvesById(param1:Number) : ElvesBasicData
      {
         var _loc2_:ElvesBasicData = null;
         var _loc3_:ElvesBasicData = null;
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
         return getElvesById(param1).getId();
      }
      
      public static function getName(param1:Number) : String
      {
         return getElvesById(param1).getName();
      }
      
      public static function getClassName(param1:Number) : String
      {
         return getElvesById(param1).getClassName();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getElvesById(param1).getFrame();
      }
      
      public static function getColor(param1:Number) : Number
      {
         return getElvesById(param1).getColor();
      }
      
      public static function getIntroduction(param1:Number) : String
      {
         return getElvesById(param1).getIntroduction();
      }
      
      public static function getBlueLV(param1:Number) : Number
      {
         return getElvesById(param1).getBlueLV();
      }
      
      public static function getPinkLV(param1:Number) : Number
      {
         return getElvesById(param1).getPinkLV();
      }
      
      public static function getGoldLV(param1:Number) : Number
      {
         return getElvesById(param1).getGoldLV();
      }
      
      public static function getBlueNum(param1:Number) : Number
      {
         return getElvesById(param1).getBlueNum();
      }
      
      public static function getPinkNum(param1:Number) : Number
      {
         return getElvesById(param1).getPinkNum();
      }
      
      public static function getGoldNum(param1:Number) : Number
      {
         return getElvesById(param1).getGoldNum();
      }
      
      public static function getTimeX(param1:Number) : Number
      {
         return getElvesById(param1).getTimeX();
      }
      
      public static function creatElves(param1:Number) : Elves
      {
         return getElvesById(param1).creatElves();
      }
      
      private function creatElvesFactory() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:ElvesBasicData = null;
         for each(_loc1_ in myXml.精灵)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = Number(_loc1_.帧数);
            _loc4_ = String(_loc1_.名字);
            _loc5_ = String(_loc1_.类名);
            _loc6_ = String(_loc1_.描述);
            _loc7_ = Number(_loc1_.颜色);
            _loc8_ = Number(_loc1_.蓝色等级);
            _loc9_ = Number(_loc1_.粉色等级);
            _loc10_ = Number(_loc1_.金色等级);
            _loc11_ = Number(_loc1_.蓝色数量);
            _loc12_ = Number(_loc1_.粉色数量);
            _loc13_ = Number(_loc1_.金色数量);
            _loc14_ = Number(_loc1_.减少时间);
            _loc15_ = ElvesBasicData.creatElvesBasicData(_loc2_,_loc4_,_loc5_,_loc3_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_);
            allData.push(_loc15_);
         }
      }
   }
}

