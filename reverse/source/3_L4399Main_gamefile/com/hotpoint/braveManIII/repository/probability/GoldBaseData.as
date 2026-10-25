package com.hotpoint.braveManIII.repository.probability
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class GoldBaseData
   {
      
      private var _fallLevel:VT;
      
      private var _mosaicGold:VT;
      
      private var _deleteGold:VT;
      
      public function GoldBaseData()
      {
         super();
      }
      
      public static function creatGold(param1:Number, param2:Number, param3:Number) : GoldBaseData
      {
         var _loc4_:GoldBaseData = new GoldBaseData();
         _loc4_._fallLevel = VT.createVT(param1);
         _loc4_._mosaicGold = VT.createVT(param2);
         _loc4_._deleteGold = VT.createVT(param3);
         return _loc4_;
      }
      
      public function get fallLevel() : VT
      {
         return _fallLevel;
      }
      
      public function set fallLevel(param1:VT) : void
      {
         _fallLevel = param1;
      }
      
      public function get mosaicGold() : VT
      {
         return _mosaicGold;
      }
      
      public function set mosaicGold(param1:VT) : void
      {
         _mosaicGold = param1;
      }
      
      public function get deleteGold() : VT
      {
         return _deleteGold;
      }
      
      public function set deleteGold(param1:VT) : void
      {
         _deleteGold = param1;
      }
      
      public function getFallLevel() : Number
      {
         return _fallLevel.getValue();
      }
      
      public function getMosaicGold() : Number
      {
         return _mosaicGold.getValue();
      }
      
      public function getDeleteGold() : Number
      {
         return _deleteGold.getValue();
      }
   }
}

