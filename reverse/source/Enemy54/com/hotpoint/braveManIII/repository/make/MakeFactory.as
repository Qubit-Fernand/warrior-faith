package com.hotpoint.braveManIII.repository.make
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class MakeFactory
   {
      
      public static var myXml:XML = new XML();
      
      public static var allData:Array = [];
      
      public static var makeData:Array = [];
      
      public function MakeFactory()
      {
         super();
      }
      
      public static function creatMakeFactory() : void
      {
         var _loc1_:MakeFactory = new MakeFactory();
         _loc1_.creatLoard();
      }
      
      private static function getDataById(param1:Number) : MakeBasicData
      {
         var _loc2_:MakeBasicData = null;
         for each(_loc2_ in allData)
         {
            if(_loc2_.getId() == param1)
            {
               return _loc2_;
            }
         }
         trace("没有此ID卷轴");
         return null;
      }
      
      public static function getDataByType(param1:Number) : Array
      {
         var _loc3_:MakeBasicData = null;
         var _loc2_:Array = [];
         for each(_loc3_ in allData)
         {
            if(_loc3_.getType() == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function getType(param1:Number) : Number
      {
         return getDataById(param1).getType();
      }
      
      public static function getName(param1:Number) : String
      {
         return getDataById(param1).getName();
      }
      
      public static function getFrame(param1:Number) : Number
      {
         return getDataById(param1).getFrame();
      }
      
      public static function getSm(param1:Number) : String
      {
         return getDataById(param1).getSm();
      }
      
      public static function getNeedId(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = getDataById(param1).getNeedId();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_.push(_loc3_[_loc4_].getValue());
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function getNeedType(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = getDataById(param1).getNeedType();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_.push(_loc3_[_loc4_].getValue());
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function getNeedNum(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = getDataById(param1).getNeedNum();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_.push(_loc3_[_loc4_].getValue());
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function getFinishNum(param1:Number) : Number
      {
         return getDataById(param1).getFinishNum();
      }
      
      public static function getGold(param1:Number) : Number
      {
         return getDataById(param1).getGold();
      }
      
      public static function getDj(param1:Number) : Number
      {
         return getDataById(param1).getDj();
      }
      
      public static function getFinishId(param1:Number) : Number
      {
         return getDataById(param1).getFinishId();
      }
      
      private function creatLoard() : *
      {
         xmlLoaded();
      }
      
      private function xmlLoaded() : void
      {
         var _loc1_:XML = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:XMLList = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:Array = null;
         var _loc15_:MakeBasicData = null;
         for each(_loc1_ in myXml.卷轴)
         {
            _loc2_ = Number(_loc1_.id);
            _loc3_ = _loc1_.名称;
            _loc4_ = Number(_loc1_.类型);
            _loc5_ = Number(_loc1_.帧数);
            _loc6_ = _loc1_.说明;
            _loc7_ = Number(_loc1_.金币);
            _loc8_ = _loc1_.必需品;
            _loc9_ = Number(_loc1_.完成品Id);
            _loc10_ = Number(_loc1_.完成品数量);
            _loc7_ = Number(_loc1_.金币);
            _loc11_ = Number(_loc1_.点卷);
            _loc12_ = [];
            _loc13_ = [];
            _loc14_ = [];
            for each(_loc1_ in _loc8_)
            {
               _loc12_.push(VT.createVT(_loc8_.需要品id0));
               _loc12_.push(VT.createVT(_loc8_.需要品id1));
               _loc12_.push(VT.createVT(_loc8_.需要品id2));
               _loc12_.push(VT.createVT(_loc8_.需要品id3));
               _loc12_.push(VT.createVT(_loc8_.需要品id4));
               _loc13_.push(VT.createVT(_loc8_.需要品类型0));
               _loc13_.push(VT.createVT(_loc8_.需要品类型1));
               _loc13_.push(VT.createVT(_loc8_.需要品类型2));
               _loc13_.push(VT.createVT(_loc8_.需要品类型3));
               _loc13_.push(VT.createVT(_loc8_.需要品类型4));
               _loc14_.push(VT.createVT(_loc8_.需要品数量0));
               _loc14_.push(VT.createVT(_loc8_.需要品数量1));
               _loc14_.push(VT.createVT(_loc8_.需要品数量2));
               _loc14_.push(VT.createVT(_loc8_.需要品数量3));
               _loc14_.push(VT.createVT(_loc8_.需要品数量4));
            }
            _loc15_ = MakeBasicData.creatMakeBasic(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc12_,_loc13_,_loc14_,_loc9_,_loc7_,_loc10_,_loc11_);
            allData.push(_loc15_);
            makeData.push(_loc15_.creatMake());
         }
      }
   }
}

