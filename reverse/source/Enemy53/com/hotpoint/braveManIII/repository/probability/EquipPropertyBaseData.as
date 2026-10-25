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
         return this._pos;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function get falllevel() : VT
      {
         return this._falllevel;
      }
      
      public function set falllevel(value:VT) : void
      {
         this._falllevel = value;
      }
      
      private function vtOne() : void
      {
         var pone:VT = null;
         for(var i:uint = 0; i < this._oneArr.length; i++)
         {
            pone = VT.createVT(this._oneArr[i]);
            this._propetyOneArr[i] = pone;
         }
      }
      
      private function vtTow() : void
      {
         var ptow:VT = null;
         for(var i:uint = 0; i < this._towArr.length; i++)
         {
            ptow = VT.createVT(this._towArr[i]);
            this._propetyTowArr[i] = ptow;
         }
      }
      
      private function vtThree() : void
      {
         var pthree:VT = null;
         for(var i:uint = 0; i < this._threeArr.length; i++)
         {
            pthree = VT.createVT(this._threeArr[i]);
            this._propetyThreeArr[i] = pthree;
         }
      }
      
      public function getPropety(vo:Number, type:uint) : Number
      {
         var num:Number = type;
         if(vo == 1)
         {
            if(this._propetyOneArr[num] != null)
            {
               return this._propetyOneArr[num].getValue();
            }
         }
         if(vo == 2)
         {
            if(this._propetyTowArr[num] != null)
            {
               return this._propetyTowArr[num].getValue();
            }
         }
         if(vo == 3)
         {
            if(this._propetyThreeArr[num] != null)
            {
               return this._propetyThreeArr[num].getValue();
            }
         }
         return -1;
      }
      
      public function getColor() : Number
      {
         return this._color.getValue();
      }
      
      public function getPosi() : Number
      {
         return this._pos.getValue();
      }
      
      public function getFalllevel() : Number
      {
         return this._falllevel.getValue();
      }
   }
}

