package com.hotpoint.braveManIII.repository.make
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.make.*;
   
   public class MakeBasicData
   {
      
      private var _id:VT;
      
      private var _name:String;
      
      private var _type:VT;
      
      private var _frame:VT;
      
      private var _sm:String;
      
      private var _needId:Array = [];
      
      private var _needType:Array = [];
      
      private var _needNum:Array = [];
      
      private var _finishId:VT;
      
      private var _gold:VT;
      
      private var _finishNum:VT;
      
      public function MakeBasicData()
      {
         super();
      }
      
      public static function creatMakeBasic(param1:Number, param2:String, param3:Number, param4:Number, param5:String, param6:Array, param7:Array, param8:Array, param9:Number, param10:Number, param11:Number) : MakeBasicData
      {
         var _loc12_:MakeBasicData = new MakeBasicData();
         _loc12_._id = VT.createVT(param1);
         _loc12_._name = param2;
         _loc12_._type = VT.createVT(param3);
         _loc12_._frame = VT.createVT(param4);
         _loc12_._sm = param5;
         _loc12_._needId = param6;
         _loc12_._needType = param7;
         _loc12_._needNum = param8;
         _loc12_._finishId = VT.createVT(param9);
         _loc12_._finishNum = VT.createVT(param11);
         _loc12_._gold = VT.createVT(param10);
         return _loc12_;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         this._id = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get type() : VT
      {
         return this._type;
      }
      
      public function set type(param1:VT) : void
      {
         this._type = param1;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(param1:VT) : void
      {
         this._frame = param1;
      }
      
      public function get sm() : String
      {
         return this._sm;
      }
      
      public function set sm(param1:String) : void
      {
         this._sm = param1;
      }
      
      public function get needId() : Array
      {
         return this._needId;
      }
      
      public function set needId(param1:Array) : void
      {
         this._needId = param1;
      }
      
      public function get needType() : Array
      {
         return this._needType;
      }
      
      public function set needType(param1:Array) : void
      {
         this._needType = param1;
      }
      
      public function get finishId() : VT
      {
         return this._finishId;
      }
      
      public function set finishId(param1:VT) : void
      {
         this._finishId = param1;
      }
      
      public function get needNum() : Array
      {
         return this._needNum;
      }
      
      public function set needNum(param1:Array) : void
      {
         this._needNum = param1;
      }
      
      public function get gold() : VT
      {
         return this._gold;
      }
      
      public function set gold(param1:VT) : void
      {
         this._gold = param1;
      }
      
      public function get finishNum() : VT
      {
         return this._finishNum;
      }
      
      public function set finishNum(param1:VT) : void
      {
         this._finishNum = param1;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getType() : Number
      {
         return this._type.getValue();
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getSm() : String
      {
         return this._sm;
      }
      
      public function getNeedId() : Array
      {
         return this._needId;
      }
      
      public function getNeedType() : Array
      {
         return this._needType;
      }
      
      public function getNeedNum() : Array
      {
         return this._needNum;
      }
      
      public function getFinishId() : Number
      {
         return this._finishId.getValue();
      }
      
      public function getFinishNum() : Number
      {
         return this._finishNum.getValue();
      }
      
      public function getGold() : Number
      {
         return this._gold.getValue();
      }
      
      public function creatMake() : Make
      {
         return Make.creatMake(this._id.getValue());
      }
   }
}

