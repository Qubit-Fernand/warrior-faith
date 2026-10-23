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
      
      public static function createSuppliesBaseData(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Number, param13:Number, param14:Array) : SuppliesBaseData
      {
         var _loc15_:SuppliesBaseData = new SuppliesBaseData();
         _loc15_._id = VT.createVT(param1);
         _loc15_._frame = VT.createVT(param2);
         _loc15_._name = param3;
         _loc15_._descript = param4;
         _loc15_._useLevel = VT.createVT(param5);
         _loc15_._dropLevel = VT.createVT(param6);
         _loc15_._price = VT.createVT(param7);
         _loc15_._coolDowns = VT.createVT(param8);
         _loc15_._times = VT.createVT(param9);
         _loc15_._color = VT.createVT(param10);
         _loc15_._isPile = param11;
         _loc15_._affectMode = VT.createVT(param12);
         _loc15_._duration = VT.createVT(param13);
         _loc15_._affect = param14;
         return _loc15_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(param1:VT) : void
      {
         _frame = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get useLevel() : VT
      {
         return _useLevel;
      }
      
      public function set useLevel(param1:VT) : void
      {
         _useLevel = param1;
      }
      
      public function get price() : VT
      {
         return _price;
      }
      
      public function set price(param1:VT) : void
      {
         _price = param1;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(param1:VT) : void
      {
         _times = param1;
      }
      
      public function get isPile() : Boolean
      {
         return _isPile;
      }
      
      public function set isPile(param1:Boolean) : void
      {
         _isPile = param1;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function set color(param1:VT) : void
      {
         _color = param1;
      }
      
      public function get dropLevel() : VT
      {
         return _dropLevel;
      }
      
      public function set dropLevel(param1:VT) : void
      {
         _dropLevel = param1;
      }
      
      public function get coolDowns() : VT
      {
         return _coolDowns;
      }
      
      public function set coolDowns(param1:VT) : void
      {
         _coolDowns = param1;
      }
      
      public function get affectMode() : VT
      {
         return _affectMode;
      }
      
      public function set affectMode(param1:VT) : void
      {
         _affectMode = param1;
      }
      
      public function get duration() : VT
      {
         return _duration;
      }
      
      public function set duration(param1:VT) : void
      {
         _duration = param1;
      }
      
      public function get descript() : String
      {
         return _descript;
      }
      
      public function set descript(param1:String) : void
      {
         _descript = param1;
      }
      
      public function get affect() : Array
      {
         return _affect;
      }
      
      public function set affect(param1:Array) : void
      {
         _affect = param1;
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

