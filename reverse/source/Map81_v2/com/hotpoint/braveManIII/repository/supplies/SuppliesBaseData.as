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
         trace("禁止get:",getQualifiedClassName(this));
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _id = value;
      }
      
      public function get frame() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _frame = value;
      }
      
      public function get name() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _name;
      }
      
      public function set name(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _name = value;
      }
      
      public function get useLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _useLevel;
      }
      
      public function set useLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _useLevel = value;
      }
      
      public function get price() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _price;
      }
      
      public function set price(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _price = value;
      }
      
      public function get times() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _times = value;
      }
      
      public function get isPile() : Boolean
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _isPile;
      }
      
      public function set isPile(value:Boolean) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _isPile = value;
      }
      
      public function get color() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _color;
      }
      
      public function set color(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _color = value;
      }
      
      public function get dropLevel() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _dropLevel;
      }
      
      public function set dropLevel(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _dropLevel = value;
      }
      
      public function get coolDowns() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _coolDowns;
      }
      
      public function set coolDowns(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _coolDowns = value;
      }
      
      public function get affectMode() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _affectMode;
      }
      
      public function set affectMode(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _affectMode = value;
      }
      
      public function get duration() : VT
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _duration;
      }
      
      public function set duration(value:VT) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _duration = value;
      }
      
      public function get descript() : String
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _descript;
      }
      
      public function set descript(value:String) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _descript = value;
      }
      
      public function get affect() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _affect;
      }
      
      public function set affect(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
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

