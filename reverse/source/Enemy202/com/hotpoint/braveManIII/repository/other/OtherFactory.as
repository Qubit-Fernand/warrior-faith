package com.hotpoint.braveManIII.repository.other
{
   import com.hotpoint.braveManIII.models.other.Otherobj;
   
   public class OtherFactory
   {
      
      public static var allData:Array = [];
      
      public static var myXml:XML = new XML();
      
      public function OtherFactory()
      {
         super();
      }
      
      public static function creatOtherFactory() : *
      {
         var _loc1_:OtherFactory = new OtherFactory();
         _loc1_.creatOtherFactory();
      }
      
      public static function getOtherById(param1:Number) : OtherBasicData
      {
         var _loc2_:OtherBasicData = null;
         var _loc3_:OtherBasicData = null;
         for each(_loc3_ in allData)
         {
            if(_loc3_.getId() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ == null)
         {
            trace("找不到此其他物品掉落等级");
         }
         return _loc2_;
      }
      
      public static function getId(param1:Number) : Number
      {
         return getOtherById(param1).getId();
      }
      
      public static function getName(param1:Number) : String
      {
         return getOtherById(param1).getName();
      }
      
      public static function getType(param1:Number) : Number
      {
         return getOtherById(param1).getType();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getOtherById(param1).getFrame();
      }
      
      public static function getColor(param1:Number) : Number
      {
         return getOtherById(param1).getColor();
      }
      
      public static function getFallLevel(param1:Number) : Number
      {
         return getOtherById(param1).getFallLevel();
      }
      
      public static function getIntroduction(param1:Number) : String
      {
         return getOtherById(param1).getIntroduction();
      }
      
      public static function isMany(param1:Number) : Boolean
      {
         return getOtherById(param1).isMany();
      }
      
      public static function getPileLimit(param1:Number) : Number
      {
         return getOtherById(param1).getPileLimit();
      }
      
      public static function getTimes(param1:Number) : Number
      {
         return getOtherById(param1).getTimes();
      }
      
      public static function getGold(param1:Number) : Number
      {
         return getOtherById(param1).getGold();
      }
      
      public static function getRemaining(param1:Number) : Number
      {
         return getOtherById(param1).getRemaining();
      }
      
      public static function getMultiple(param1:Number) : Number
      {
         return getOtherById(param1).getMultiple();
      }
      
      public static function getValue_1(param1:Number) : Number
      {
         return getOtherById(param1).getValue_1();
      }
      
      public static function getValue_2(param1:Number) : Number
      {
         return getOtherById(param1).getValue_2();
      }
      
      public static function creatOther(param1:Number) : Otherobj
      {
         return getOtherById(param1).creatOther();
      }
      
      private function creatOtherFactory() : *
      {
         this.xmlLoaded();
      }
      
      private function xmlLoaded() : *
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:OtherBasicData = null;
         for each(_loc1_ in myXml.其他道具)
         {
            _loc2_ = Number(_loc1_.编号);
            _loc3_ = String(_loc1_.名字);
            _loc4_ = Number(_loc1_.类型);
            _loc5_ = Number(_loc1_.帧数);
            _loc6_ = Number(_loc1_.掉落等级);
            _loc7_ = String(_loc1_.介绍);
            _loc8_ = (_loc1_.叠加.toString() == "true") as Boolean;
            _loc9_ = Number(_loc1_.堆叠上限);
            _loc10_ = Number(_loc1_.堆叠次数);
            _loc11_ = Number(_loc1_.金币);
            _loc12_ = Number(_loc1_.剩余时间);
            _loc13_ = Number(_loc1_.倍数);
            _loc14_ = Number(_loc1_.数值1);
            _loc15_ = Number(_loc1_.数值2);
            _loc16_ = Number(_loc1_.数值3);
            _loc17_ = OtherBasicData.creatOtherBasicData(_loc2_,_loc6_,_loc4_,_loc3_,_loc5_,_loc16_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_);
            allData.push(_loc17_);
         }
      }
   }
}

