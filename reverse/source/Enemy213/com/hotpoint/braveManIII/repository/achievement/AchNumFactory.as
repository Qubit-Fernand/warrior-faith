package com.hotpoint.braveManIII.repository.achievement
{
   import com.hotpoint.braveManIII.Tool.*;
   import src.*;
   
   public class AchNumFactory
   {
      
      public static var allData:Array = [];
      
      public static var allAc:Array = [];
      
      public function AchNumFactory()
      {
         super();
      }
      
      public static function creatAchNumFactory() : *
      {
         var _loc1_:AchNumFactory = new AchNumFactory();
         myXml = XMLAsset.createXML(Data2.AchNum);
         _loc1_.creatNumXml();
      }
      
      public static function getDatabyId(param1:Number) : AchNumBasicData
      {
         var _loc2_:AchNumBasicData = null;
         var _loc3_:AchNumBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("没有此ID数据");
         }
         return _loc2_;
      }
      
      public static function getGoodId(param1:Number) : Array
      {
         return getDatabyId(param1).getGoddsId();
      }
      
      public static function getName(param1:Number) : String
      {
         return getDatabyId(param1).getName();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getDatabyId(param1).getFrame();
      }
      
      public static function getSm(param1:Number) : String
      {
         return getDatabyId(param1).getIntroduction();
      }
      
      public static function isEveryDady(param1:Number) : Boolean
      {
         return getDatabyId(param1).isEveryDady();
      }
      
      public static function getType(param1:Number) : Number
      {
         return getDatabyId(param1).getNumType();
      }
      
      public static function getRewardAc(param1:Number) : Number
      {
         return getDatabyId(param1).getRewardAc();
      }
      
      public static function getSmallType(param1:Number) : Number
      {
         return getDatabyId(param1).getSmall();
      }
      
      public static function getFinishNum(param1:Number) : Number
      {
         return getDatabyId(param1).getNum();
      }
      
      public static function getTs(param1:Number) : Number
      {
         return getDatabyId(param1).getTs();
      }
      
      public static function getGoodsType(param1:Number) : Array
      {
         return getDatabyId(param1).getGoodsType();
      }
      
      public static function isRy(param1:Number) : Boolean
      {
         return getDatabyId(param1).getRy();
      }
      
      public static function getNeedType(param1:Number) : Number
      {
         return getDatabyId(param1).getNeedType();
      }
      
      private function creatNumXml() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Boolean = false;
         var _loc14_:String = null;
         var _loc15_:Number = NaN;
         var _loc16_:AchNumBasicData = null;
         for each(_loc1_ in myXml.成就)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = String(_loc1_.名字);
            _loc4_ = Number(_loc1_.帧数);
            _loc5_ = String(_loc1_.说明);
            _loc6_ = (_loc1_.是否每日.toString() == "true") as Boolean;
            _loc7_ = Number(_loc1_.类型);
            _loc8_ = Number(_loc1_.奖励成就点);
            _loc9_ = String(_loc1_.指定id);
            _loc10_ = Number(_loc1_.具体类型);
            _loc11_ = Number(_loc1_.数量1);
            _loc12_ = Number(_loc1_.数量2);
            _loc13_ = (_loc1_.是否同时.toString() == "true") as Boolean;
            _loc14_ = String(_loc1_.id类型);
            _loc15_ = Number(_loc1_.获取方式);
            _loc16_ = AchNumBasicData.ceartAchNum(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc14_,_loc10_,_loc11_,_loc12_,_loc13_,_loc15_);
            allData.push(_loc16_);
            allAc.push(_loc16_.creatAcForNum());
         }
      }
   }
}

