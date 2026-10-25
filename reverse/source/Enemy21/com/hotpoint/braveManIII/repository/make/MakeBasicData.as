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
      
      public static function creatMakeBasic(id:Number, name:String, type:Number, frame:Number, ms:String, needId:Array, needType:Array, needNum:Array, finishId:Number, gold:Number, finishNum:Number) : MakeBasicData
      {
         var data:MakeBasicData = new MakeBasicData();
         data._id = VT.createVT(id);
         data._name = name;
         data._type = VT.createVT(type);
         data._frame = VT.createVT(frame);
         data._sm = ms;
         data._needId = needId;
         data._needType = needType;
         data._needNum = needNum;
         data._finishId = VT.createVT(finishId);
         data._finishNum = VT.createVT(finishNum);
         data._gold = VT.createVT(gold);
         return data;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get type() : VT
      {
         return this._type;
      }
      
      public function set type(value:VT) : void
      {
         this._type = value;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(value:VT) : void
      {
         this._frame = value;
      }
      
      public function get sm() : String
      {
         return this._sm;
      }
      
      public function set sm(value:String) : void
      {
         this._sm = value;
      }
      
      public function get needId() : Array
      {
         return this._needId;
      }
      
      public function set needId(value:Array) : void
      {
         this._needId = value;
      }
      
      public function get needType() : Array
      {
         return this._needType;
      }
      
      public function set needType(value:Array) : void
      {
         this._needType = value;
      }
      
      public function get finishId() : VT
      {
         return this._finishId;
      }
      
      public function set finishId(value:VT) : void
      {
         this._finishId = value;
      }
      
      public function get needNum() : Array
      {
         return this._needNum;
      }
      
      public function set needNum(value:Array) : void
      {
         this._needNum = value;
      }
      
      public function get gold() : VT
      {
         return this._gold;
      }
      
      public function set gold(value:VT) : void
      {
         this._gold = value;
      }
      
      public function get finishNum() : VT
      {
         return this._finishNum;
      }
      
      public function set finishNum(value:VT) : void
      {
         this._finishNum = value;
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

