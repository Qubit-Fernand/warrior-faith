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
      
      public static function creatGold(fallLevel:Number, mosaicGold:Number, deleteGold:Number) : GoldBaseData
      {
         var gold:GoldBaseData = new GoldBaseData();
         gold._fallLevel = VT.createVT(fallLevel);
         gold._mosaicGold = VT.createVT(mosaicGold);
         gold._deleteGold = VT.createVT(deleteGold);
         return gold;
      }
      
      public function get fallLevel() : VT
      {
         return _fallLevel;
      }
      
      public function set fallLevel(value:VT) : void
      {
         _fallLevel = value;
      }
      
      public function get mosaicGold() : VT
      {
         return _mosaicGold;
      }
      
      public function set mosaicGold(value:VT) : void
      {
         _mosaicGold = value;
      }
      
      public function get deleteGold() : VT
      {
         return _deleteGold;
      }
      
      public function set deleteGold(value:VT) : void
      {
         _deleteGold = value;
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

