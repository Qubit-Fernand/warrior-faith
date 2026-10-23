package com.hotpoint.braveManIII.repository.probability
{
   import com.hotpoint.braveManIII.models.common.*;
   
   public class EquipPropertyBaseData
   {
      
      private var _pos:VT;
      
      private var _falllevel:VT;
      
      private var _color:VT;
      
      private var _oneArr:Array;
      
      private var _towArr:Array;
      
      private var _threeArr:Array;
      
      private var _propetyOneArr:Array = [];
      
      private var _propetyTowArr:Array = [];
      
      private var _propetyThreeArr:Array = [];
      
      public function EquipPropertyBaseData()
      {
         super();
      }
      
      public static function ceatPropertyData(param1:Number, param2:Number, param3:Number, param4:Array, param5:Array, param6:Array) : EquipPropertyBaseData
      {
         var _loc7_:EquipPropertyBaseData = new EquipPropertyBaseData();
         _loc7_._pos = VT.createVT(param1);
         _loc7_._falllevel = VT.createVT(param2);
         _loc7_._color = VT.createVT(param3);
         _loc7_._oneArr = param4;
         _loc7_._towArr = param5;
         _loc7_._threeArr = param6;
         _loc7_.vtOne();
         _loc7_.vtTow();
         _loc7_.vtThree();
         return _loc7_;
      }
      
      public function get pos() : VT
      {
         return _pos;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function get falllevel() : VT
      {
         return _falllevel;
      }
      
      public function set falllevel(param1:VT) : void
      {
         _falllevel = param1;
      }
      
      private function vtOne() : void
      {
         var _loc1_:VT = null;
         var _loc2_:uint = 0;
         while(_loc2_ < _oneArr.length)
         {
            _loc1_ = VT.createVT(_oneArr[_loc2_]);
            _propetyOneArr[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function vtTow() : void
      {
         var _loc1_:VT = null;
         var _loc2_:uint = 0;
         while(_loc2_ < _towArr.length)
         {
            _loc1_ = VT.createVT(_towArr[_loc2_]);
            _propetyTowArr[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function vtThree() : void
      {
         var _loc1_:VT = null;
         var _loc2_:uint = 0;
         while(_loc2_ < _threeArr.length)
         {
            _loc1_ = VT.createVT(_threeArr[_loc2_]);
            _propetyThreeArr[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      public function getPropety(param1:Number, param2:uint) : Number
      {
         var _loc3_:Number = param2;
         if(param1 == 1)
         {
            if(_propetyOneArr[_loc3_] != null)
            {
               return _propetyOneArr[_loc3_].getValue();
            }
         }
         if(param1 == 2)
         {
            if(_propetyTowArr[_loc3_] != null)
            {
               return _propetyTowArr[_loc3_].getValue();
            }
         }
         if(param1 == 3)
         {
            if(_propetyThreeArr[_loc3_] != null)
            {
               return _propetyThreeArr[_loc3_].getValue();
            }
         }
         return -1;
      }
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      public function getPosi() : Number
      {
         return _pos.getValue();
      }
      
      public function getFalllevel() : Number
      {
         return _falllevel.getValue();
      }
   }
}

