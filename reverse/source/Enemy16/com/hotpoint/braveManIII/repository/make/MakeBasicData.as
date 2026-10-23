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
      
      private var _dj:VT;
      
      public function MakeBasicData()
      {
         super();
      }
      
      public static function creatMakeBasic(param1:Number, param2:String, param3:Number, param4:Number, param5:String, param6:Array, param7:Array, param8:Array, param9:Number, param10:Number, param11:Number, param12:Number) : MakeBasicData
      {
         var _loc13_:MakeBasicData = new MakeBasicData();
         _loc13_._id = VT.createVT(param1);
         _loc13_._name = param2;
         _loc13_._type = VT.createVT(param3);
         _loc13_._frame = VT.createVT(param4);
         _loc13_._sm = param5;
         _loc13_._needId = param6;
         _loc13_._needType = param7;
         _loc13_._needNum = param8;
         _loc13_._finishId = VT.createVT(param9);
         _loc13_._finishNum = VT.createVT(param11);
         _loc13_._gold = VT.createVT(param10);
         _loc13_._dj = VT.createVT(param12);
         return _loc13_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(param1:VT) : void
      {
         _type = param1;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(param1:VT) : void
      {
         _frame = param1;
      }
      
      public function get sm() : String
      {
         return _sm;
      }
      
      public function set sm(param1:String) : void
      {
         _sm = param1;
      }
      
      public function get needId() : Array
      {
         return _needId;
      }
      
      public function set needId(param1:Array) : void
      {
         _needId = param1;
      }
      
      public function get needType() : Array
      {
         return _needType;
      }
      
      public function set needType(param1:Array) : void
      {
         _needType = param1;
      }
      
      public function get finishId() : VT
      {
         return _finishId;
      }
      
      public function set finishId(param1:VT) : void
      {
         _finishId = param1;
      }
      
      public function get needNum() : Array
      {
         return _needNum;
      }
      
      public function set needNum(param1:Array) : void
      {
         _needNum = param1;
      }
      
      public function get gold() : VT
      {
         return _gold;
      }
      
      public function set gold(param1:VT) : void
      {
         _gold = param1;
      }
      
      public function get finishNum() : VT
      {
         return _finishNum;
      }
      
      public function set finishNum(param1:VT) : void
      {
         _finishNum = param1;
      }
      
      public function get dj() : VT
      {
         return _dj;
      }
      
      public function set dj(param1:VT) : void
      {
         _dj = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getSm() : String
      {
         return _sm;
      }
      
      public function getNeedId() : Array
      {
         return _needId;
      }
      
      public function getNeedType() : Array
      {
         return _needType;
      }
      
      public function getNeedNum() : Array
      {
         return _needNum;
      }
      
      public function getFinishId() : Number
      {
         return _finishId.getValue();
      }
      
      public function getFinishNum() : Number
      {
         return _finishNum.getValue();
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function getDj() : Number
      {
         return _dj.getValue();
      }
      
      public function creatMake() : Make
      {
         return Make.creatMake(_id.getValue());
      }
   }
}

