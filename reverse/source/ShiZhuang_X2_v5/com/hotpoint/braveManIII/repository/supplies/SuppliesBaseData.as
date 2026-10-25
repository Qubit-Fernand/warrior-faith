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
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get useLevel() : VT
      {
         return _useLevel;
      }
      
      public function set useLevel(value:VT) : void
      {
         _useLevel = value;
      }
      
      public function get price() : VT
      {
         return _price;
      }
      
      public function set price(value:VT) : void
      {
         _price = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
      }
      
      public function get isPile() : Boolean
      {
         return _isPile;
      }
      
      public function set isPile(value:Boolean) : void
      {
         _isPile = value;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function set color(value:VT) : void
      {
         _color = value;
      }
      
      public function get dropLevel() : VT
      {
         return _dropLevel;
      }
      
      public function set dropLevel(value:VT) : void
      {
         _dropLevel = value;
      }
      
      public function get coolDowns() : VT
      {
         return _coolDowns;
      }
      
      public function set coolDowns(value:VT) : void
      {
         _coolDowns = value;
      }
      
      public function get affectMode() : VT
      {
         return _affectMode;
      }
      
      public function set affectMode(value:VT) : void
      {
         _affectMode = value;
      }
      
      public function get duration() : VT
      {
         return _duration;
      }
      
      public function set duration(value:VT) : void
      {
         _duration = value;
      }
      
      public function get descript() : String
      {
         return _descript;
      }
      
      public function set descript(value:String) : void
      {
         _descript = value;
      }
      
      public function get affect() : Array
      {
         return _affect;
      }
      
      public function set affect(value:Array) : void
      {
         _affect = value;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getUseLevel() : Number
      {
         return _useLevel.getValue();
      }
      
      public function getPrice() : Number
      {
         return _price.getValue();
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getIsPile() : Boolean
      {
         return _isPile;
      }
      
      public function getAffect() : Array
      {
         return _affect;
      }
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getDropLevel() : Number
      {
         return _dropLevel.getValue();
      }
      
      public function getDescript() : String
      {
         return _descript;
      }
      
      public function getCoolDowns() : Number
      {
         return _coolDowns.getValue();
      }
      
      public function getAffectMode() : Number
      {
         return _affectMode.getValue();
      }
      
      public function getDuration() : Number
      {
         return _duration.getValue();
      }
      
      public function createSupplies() : Supplies
      {
         return Supplies.creatSupplies(_id.getValue(),_times.getValue());
      }
   }
}

