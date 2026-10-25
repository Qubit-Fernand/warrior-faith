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
         return this._fallLevel;
      }
      
      public function set fallLevel(value:VT) : void
      {
         this._fallLevel = value;
      }
      
      public function get mosaicGold() : VT
      {
         return this._mosaicGold;
      }
      
      public function set mosaicGold(value:VT) : void
      {
         this._mosaicGold = value;
      }
      
      public function get deleteGold() : VT
      {
         return this._deleteGold;
      }
      
      public function set deleteGold(value:VT) : void
      {
         this._deleteGold = value;
      }
      
      public function getFallLevel() : Number
      {
         return this._fallLevel.getValue();
      }
      
      public function getMosaicGold() : Number
      {
         return this._mosaicGold.getValue();
      }
      
      public function getDeleteGold() : Number
      {
         return this._deleteGold.getValue();
      }
   }
}

