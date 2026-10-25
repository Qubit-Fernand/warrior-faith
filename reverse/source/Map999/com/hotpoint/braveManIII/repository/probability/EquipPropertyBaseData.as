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
      
      public static function ceatPropertyData(position:Number, falllevel:Number, color:Number, oneArr:Array, towArr:Array, threeArr:Array) : EquipPropertyBaseData
      {
         var pro:EquipPropertyBaseData = new EquipPropertyBaseData();
         pro._pos = VT.createVT(position);
         pro._falllevel = VT.createVT(falllevel);
         pro._color = VT.createVT(color);
         pro._oneArr = oneArr;
         pro._towArr = towArr;
         pro._threeArr = threeArr;
         pro.vtOne();
         pro.vtTow();
         pro.vtThree();
         return pro;
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
      
      public function set falllevel(value:VT) : void
      {
         _falllevel = value;
      }
      
      private function vtOne() : void
      {
         var pone:VT = null;
         for(var i:uint = 0; i < _oneArr.length; i++)
         {
            pone = VT.createVT(_oneArr[i]);
            _propetyOneArr[i] = pone;
         }
      }
      
      private function vtTow() : void
      {
         var ptow:VT = null;
         for(var i:uint = 0; i < _towArr.length; i++)
         {
            ptow = VT.createVT(_towArr[i]);
            _propetyTowArr[i] = ptow;
         }
      }
      
      private function vtThree() : void
      {
         var pthree:VT = null;
         for(var i:uint = 0; i < _threeArr.length; i++)
         {
            pthree = VT.createVT(_threeArr[i]);
            _propetyThreeArr[i] = pthree;
         }
      }
      
      public function getPropety(vo:Number, type:uint) : Number
      {
         var num:Number = type;
         if(vo == 1)
         {
            if(_propetyOneArr[num] != null)
            {
               return _propetyOneArr[num].getValue();
            }
         }
         if(vo == 2)
         {
            if(_propetyTowArr[num] != null)
            {
               return _propetyTowArr[num].getValue();
            }
         }
         if(vo == 3)
         {
            if(_propetyThreeArr[num] != null)
            {
               return _propetyThreeArr[num].getValue();
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

