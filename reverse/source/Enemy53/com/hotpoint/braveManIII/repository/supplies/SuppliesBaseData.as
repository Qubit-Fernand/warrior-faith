package com.hotpoint.braveManIII.repository.supplies
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   
   public class SuppliesBaseData
   {
      
      private var _id:VT;
      
      private var _frame:VT;
      
      private var _name:String;
      
      private var _useLevel:VT;
      
      private var _price:VT;
      
      private var _times:VT;
      
      private var _isPile:Boolean;
      
      private var _color:VT;
      
      private var _dropLevel:VT;
      
      private var _coolDowns:VT;
      
      private var _affectMode:VT;
      
      private var _duration:VT;
      
      private var _descript:String;
      
      private var _affect:Array = [];
      
      public function SuppliesBaseData()
      {
         super();
      }
      
      public static function createSuppliesBaseData(id:Number, frame:Number, name:String, descript:String, useLevel:Number, dropLevel:Number, price:Number, coolDowns:Number, times:Number, color:Number, ispile:Boolean, affectMode:Number, duration:Number, affect:Array) : SuppliesBaseData
      {
         var suppliesBaseData:SuppliesBaseData = new SuppliesBaseData();
         suppliesBaseData._id = VT.createVT(id);
         suppliesBaseData._frame = VT.createVT(frame);
         suppliesBaseData._name = name;
         suppliesBaseData._descript = descript;
         suppliesBaseData._useLevel = VT.createVT(useLevel);
         suppliesBaseData._dropLevel = VT.createVT(dropLevel);
         suppliesBaseData._price = VT.createVT(price);
         suppliesBaseData._coolDowns = VT.createVT(coolDowns);
         suppliesBaseData._times = VT.createVT(times);
         suppliesBaseData._color = VT.createVT(color);
         suppliesBaseData._isPile = ispile;
         suppliesBaseData._affectMode = VT.createVT(affectMode);
         suppliesBaseData._duration = VT.createVT(duration);
         suppliesBaseData._affect = affect;
         return suppliesBaseData;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(value:VT) : void
      {
         this._frame = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get useLevel() : VT
      {
         return this._useLevel;
      }
      
      public function set useLevel(value:VT) : void
      {
         this._useLevel = value;
      }
      
      public function get price() : VT
      {
         return this._price;
      }
      
      public function set price(value:VT) : void
      {
         this._price = value;
      }
      
      public function get times() : VT
      {
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         this._times = value;
      }
      
      public function get isPile() : Boolean
      {
         return this._isPile;
      }
      
      public function set isPile(value:Boolean) : void
      {
         this._isPile = value;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function set color(value:VT) : void
      {
         this._color = value;
      }
      
      public function get dropLevel() : VT
      {
         return this._dropLevel;
      }
      
      public function set dropLevel(value:VT) : void
      {
         this._dropLevel = value;
      }
      
      public function get coolDowns() : VT
      {
         return this._coolDowns;
      }
      
      public function set coolDowns(value:VT) : void
      {
         this._coolDowns = value;
      }
      
      public function get affectMode() : VT
      {
         return this._affectMode;
      }
      
      public function set affectMode(value:VT) : void
      {
         this._affectMode = value;
      }
      
      public function get duration() : VT
      {
         return this._duration;
      }
      
      public function set duration(value:VT) : void
      {
         this._duration = value;
      }
      
      public function get descript() : String
      {
         return this._descript;
      }
      
      public function set descript(value:String) : void
      {
         this._descript = value;
      }
      
      public function get affect() : Array
      {
         return this._affect;
      }
      
      public function set affect(value:Array) : void
      {
         this._affect = value;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getUseLevel() : Number
      {
         return this._useLevel.getValue();
      }
      
      public function getPrice() : Number
      {
         return this._price.getValue();
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function getIsPile() : Boolean
      {
         return this._isPile;
      }
      
      public function getAffect() : Array
      {
         return this._affect;
      }
      
      public function getColor() : Number
      {
         return this._color.getValue();
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getDropLevel() : Number
      {
         return this._dropLevel.getValue();
      }
      
      public function getDescript() : String
      {
         return this._descript;
      }
      
      public function getCoolDowns() : Number
      {
         return this._coolDowns.getValue();
      }
      
      public function getAffectMode() : Number
      {
         return this._affectMode.getValue();
      }
      
      public function getDuration() : Number
      {
         return this._duration.getValue();
      }
      
      public function createSupplies() : Supplies
      {
         return Supplies.creatSupplies(this._id.getValue(),this._times.getValue());
      }
   }
}

