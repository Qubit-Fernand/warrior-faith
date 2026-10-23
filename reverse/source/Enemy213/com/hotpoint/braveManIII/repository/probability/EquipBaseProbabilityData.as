package com.hotpoint.braveManIII.repository.probability
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
   public class EquipBaseProbabilityData
   {
      
      private var _fallLevel:VT;
      
      private var _proArr:Array = [];
      
      private var _probabiltyArr:Array = [];
      
      private var _gArr:Array = [];
      
      private var _goldArr:Array = [];
      
      public function EquipBaseProbabilityData()
      {
         super();
      }
      
      public static function creatProbabilityData(param1:Number, param2:Array, param3:Array) : EquipBaseProbabilityData
      {
         var _loc4_:EquipBaseProbabilityData = new EquipBaseProbabilityData();
         _loc4_._fallLevel = VT.createVT(param1);
         _loc4_._proArr = param2;
         _loc4_.vtProArr();
         _loc4_._gArr = param3;
         _loc4_.vtGlodArr();
         return _loc4_;
      }
      
      public function get fallLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._fallLevel;
      }
      
      public function set fallLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._fallLevel = param1;
      }
      
      public function get probabiltyArr() : Array
      {
         return this._probabiltyArr;
      }
      
      public function set probabiltyArr(param1:Array) : void
      {
         this._probabiltyArr = param1;
      }
      
      private function vtProArr() : void
      {
         var _loc1_:VT = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._proArr.length)
         {
            if(this._proArr[_loc2_] != null)
            {
               _loc1_ = VT.createVT(this._proArr[_loc2_]);
               this._probabiltyArr[_loc2_] = _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function vtGlodArr() : void
      {
         var _loc1_:VT = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._gArr.length)
         {
            if(this._gArr[_loc2_] != null)
            {
               _loc1_ = VT.createVT(this._gArr[_loc2_]);
               this._goldArr[_loc2_] = _loc1_;
            }
            _loc2_++;
         }
      }
      
      public function getProbabil(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         if(this._probabiltyArr[_loc2_] != null)
         {
            return this._probabiltyArr[_loc2_].getValue();
         }
         return -1;
      }
      
      public function getGold(param1:Number) : Number
      {
         if(this._goldArr[param1] != null)
         {
            return this._goldArr[param1].getValue();
         }
         return -1;
      }
      
      public function getfallLevel() : Number
      {
         return this._fallLevel.getValue();
      }
   }
}

