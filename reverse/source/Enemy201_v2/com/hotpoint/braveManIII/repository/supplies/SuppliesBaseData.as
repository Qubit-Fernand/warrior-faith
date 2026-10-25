package com.hotpoint.braveManIII.repository.supplies
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import flash.utils.*;
   
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
         trace("禁止get:",getQualifiedClassName(this));
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._id = param1;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._frame;
      }
      
      public function set frame(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._frame = param1;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._name = param1;
      }
      
      public function get useLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._useLevel;
      }
      
      public function set useLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._useLevel = param1;
      }
      
      public function get price() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._price;
      }
      
      public function set price(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._price = param1;
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._times;
      }
      
      public function set times(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._times = param1;
      }
      
      public function get isPile() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._isPile;
      }
      
      public function set isPile(param1:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._isPile = param1;
      }
      
      public function get color() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._color;
      }
      
      public function set color(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._color = param1;
      }
      
      public function get dropLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._dropLevel;
      }
      
      public function set dropLevel(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._dropLevel = param1;
      }
      
      public function get coolDowns() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._coolDowns;
      }
      
      public function set coolDowns(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._coolDowns = param1;
      }
      
      public function get affectMode() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._affectMode;
      }
      
      public function set affectMode(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._affectMode = param1;
      }
      
      public function get duration() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._duration;
      }
      
      public function set duration(param1:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._duration = param1;
      }
      
      public function get descript() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._descript;
      }
      
      public function set descript(param1:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._descript = param1;
      }
      
      public function get affect() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._affect;
      }
      
      public function set affect(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._affect = param1;
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

