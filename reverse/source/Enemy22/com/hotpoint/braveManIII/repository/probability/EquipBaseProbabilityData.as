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
      
      public static function creatProbabilityData(fallLevel:Number, proArr:Array, gArr:Array) : EquipBaseProbabilityData
      {
         var pro:EquipBaseProbabilityData = new EquipBaseProbabilityData();
         pro._fallLevel = VT.createVT(fallLevel);
         pro._proArr = proArr;
         pro.vtProArr();
         pro._gArr = gArr;
         pro.vtGlodArr();
         return pro;
      }
      
      public function get fallLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._fallLevel;
      }
      
      public function set fallLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._fallLevel = value;
      }
      
      public function get probabiltyArr() : Array
      {
         return this._probabiltyArr;
      }
      
      public function set probabiltyArr(value:Array) : void
      {
         this._probabiltyArr = value;
      }
      
      private function vtProArr() : void
      {
         var pone:VT = null;
         for(var i:uint = 0; i < this._proArr.length; i++)
         {
            if(this._proArr[i] != null)
            {
               pone = VT.createVT(this._proArr[i]);
               this._probabiltyArr[i] = pone;
            }
         }
      }
      
      private function vtGlodArr() : void
      {
         var pone:VT = null;
         for(var i:uint = 0; i < this._gArr.length; i++)
         {
            if(this._gArr[i] != null)
            {
               pone = VT.createVT(this._gArr[i]);
               this._goldArr[i] = pone;
            }
         }
      }
      
      public function getProbabil(type:Number) : Number
      {
         var num:Number = type;
         if(this._probabiltyArr[num] != null)
         {
            return this._probabiltyArr[num].getValue();
         }
         return -1;
      }
      
      public function getGold(num:Number) : Number
      {
         if(this._goldArr[num] != null)
         {
            return this._goldArr[num].getValue();
         }
         return -1;
      }
      
      public function getfallLevel() : Number
      {
         return this._fallLevel.getValue();
      }
   }
}

