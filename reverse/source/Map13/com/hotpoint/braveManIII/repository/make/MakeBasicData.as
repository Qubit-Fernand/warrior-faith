package com.hotpoint.braveManIII.repository.make
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.make.*;
   
   public class MakeBasicData
   {
      
      private var _type:VT;
      
      private var _gold:VT;
      
      private var _id:VT;
      
      private var _needType:Array = [];
      
      private var _needNum:Array = [];
      
      private var _name:String;
      
      private var _finishId:VT;
      
      private var _frame:VT;
      
      private var _needId:Array = [];
      
      private var _sm:String;
      
      private var _finishNum:VT;
      
      public function MakeBasicData()
      {
         super();
      }
      
      public static function creatMakeBasic(id:Number, name:String, type:Number, frame:Number, ms:String, needId:Array, needType:Array, needNum:Array, finishId:Number, gold:Number, finishNum:Number) : MakeBasicData
      {
         var data:MakeBasicData = null;
         data = new MakeBasicData();
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
      
      public function getFinishId() : Number
      {
         return _finishId.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get finishId() : VT
      {
         return _finishId;
      }
      
      public function get needNum() : Array
      {
         return _needNum;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getNeedNum() : Array
      {
         return _needNum;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function creatMake() : Make
      {
         return Make.creatMake(_id.getValue());
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set finishId(value:VT) : void
      {
         _finishId = value;
      }
      
      public function set needNum(value:Array) : void
      {
         _needNum = value;
      }
      
      public function set needId(value:Array) : void
      {
         _needId = value;
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function set sm(value:String) : void
      {
         _sm = value;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function getFinishNum() : Number
      {
         return _finishNum.getValue();
      }
      
      public function set gold(value:VT) : void
      {
         _gold = value;
      }
      
      public function getNeedId() : Array
      {
         return _needId;
      }
      
      public function getSm() : String
      {
         return _sm;
      }
      
      public function getGold() : Number
      {
         return _gold.getValue();
      }
      
      public function get needId() : Array
      {
         return _needId;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function set finishNum(value:VT) : void
      {
         _finishNum = value;
      }
      
      public function set needType(value:Array) : void
      {
         _needType = value;
      }
      
      public function get sm() : String
      {
         return _sm;
      }
      
      public function get gold() : VT
      {
         return _gold;
      }
      
      public function get finishNum() : VT
      {
         return _finishNum;
      }
      
      public function set type(value:VT) : void
      {
         _type = value;
      }
      
      public function getNeedType() : Array
      {
         return _needType;
      }
      
      public function get needType() : Array
      {
         return _needType;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
   }
}

