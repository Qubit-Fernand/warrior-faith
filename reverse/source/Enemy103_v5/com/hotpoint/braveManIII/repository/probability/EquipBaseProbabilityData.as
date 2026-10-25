package com.hotpoint.braveManIII.repository.probability
{
   import com.hotpoint.braveManIII.models.common.*;
   import flash.utils.*;
   
   public class EquipBaseProbabilityData
   {
      
      private var _goldArr:Array = [];
      
      private var _probabiltyArr:Array = [];
      
      private var _fallLevel:VT;
      
      private var _proArr:Array = [];
      
      private var _gArr:Array = [];
      
      public function EquipBaseProbabilityData()
      {
         super();
      }
      
      public static function creatProbabilityData(fallLevel:Number, proArr:Array, gArr:Array) : EquipBaseProbabilityData
      {
         var pro:EquipBaseProbabilityData = null;
         pro = new EquipBaseProbabilityData();
         pro._fallLevel = VT.createVT(fallLevel);
         pro._proArr = proArr;
         pro.vtProArr();
         pro._gArr = gArr;
         pro.vtGlodArr();
         return pro;
      }
      
      public function get probabiltyArr() : Array
      {
         return _probabiltyArr;
      }
      
      public function get fallLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _fallLevel;
      }
      
      public function set probabiltyArr(value:Array) : void
      {
         _probabiltyArr = value;
      }
      
      private function vtGlodArr() : void
      {
         var pone:VT = null;
         var i:uint = 0;
         for(i = 0; i < _gArr.length; i++)
         {
            if(_gArr[i] != null)
            {
               pone = VT.createVT(_gArr[i]);
               _goldArr[i] = pone;
            }
         }
      }
      
      public function getfallLevel() : Number
      {
         return _fallLevel.getValue();
      }
      
      public function getProbabil(type:Number) : Number
      {
         var num:Number = NaN;
         num = type;
         if(_probabiltyArr[num] != null)
         {
            return _probabiltyArr[num].getValue();
         }
         return -1;
      }
      
      private function vtProArr() : void
      {
         var pone:VT = null;
         var i:uint = 0;
         for(i = 0; i < _proArr.length; i++)
         {
            if(_proArr[i] != null)
            {
               pone = VT.createVT(_proArr[i]);
               _probabiltyArr[i] = pone;
            }
         }
      }
      
      public function getGold(num:Number) : Number
      {
         if(_goldArr[num] != null)
         {
            return _goldArr[num].getValue();
         }
         return -1;
      }
      
      public function set fallLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _fallLevel = value;
      }
   }
}

