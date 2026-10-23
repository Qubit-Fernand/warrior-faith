package com.hotpoint.braveManIII.repository.elves
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.elves.*;
   
   public class ElvesBasicData
   {
      
      private var _id:VT;
      
      private var _name:String;
      
      private var _className:String;
      
      private var _frame:VT;
      
      private var _introduction:String;
      
      private var _color:VT;
      
      private var _blueLV:VT;
      
      private var _pinkLV:VT;
      
      private var _goldLV:VT;
      
      private var _blueNum:VT;
      
      private var _pinkNum:VT;
      
      private var _goldNum:VT;
      
      private var _timeX:VT;
      
      public function ElvesBasicData()
      {
         super();
      }
      
      public static function creatElvesBasicData(param1:Number, param2:String, param3:String, param4:Number, param5:String, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number) : ElvesBasicData
      {
         var _loc14_:ElvesBasicData = new ElvesBasicData();
         _loc14_._id = VT.createVT(param1);
         _loc14_._name = param2;
         _loc14_._className = param3;
         _loc14_._introduction = param5;
         _loc14_._frame = VT.createVT(param4);
         _loc14_._color = VT.createVT(param6);
         _loc14_._blueLV = VT.createVT(param7);
         _loc14_._blueNum = VT.createVT(param10);
         _loc14_._pinkLV = VT.createVT(param8);
         _loc14_._pinkNum = VT.createVT(param11);
         _loc14_._goldLV = VT.createVT(param9);
         _loc14_._goldNum = VT.createVT(param12);
         _loc14_._timeX = VT.createVT(param13);
         return _loc14_;
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
      
      public function get className() : String
      {
         return this._className;
      }
      
      public function set className(param1:String) : void
      {
         this._className = param1;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(param1:VT) : void
      {
         this._frame = param1;
      }
      
      public function get introduction() : String
      {
         return this._introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         this._introduction = param1;
      }
      
      public function get blueLV() : VT
      {
         return this._blueLV;
      }
      
      public function set blueLV(param1:VT) : void
      {
         this._blueLV = param1;
      }
      
      public function get pinkLV() : VT
      {
         return this._pinkLV;
      }
      
      public function set pinkLV(param1:VT) : void
      {
         this._pinkLV = param1;
      }
      
      public function get goldLV() : VT
      {
         return this._goldLV;
      }
      
      public function set goldLV(param1:VT) : void
      {
         this._goldLV = param1;
      }
      
      public function get blueNum() : VT
      {
         return this._blueNum;
      }
      
      public function set blueNum(param1:VT) : void
      {
         this._blueNum = param1;
      }
      
      public function get pinkNum() : VT
      {
         return this._pinkNum;
      }
      
      public function set pinkNum(param1:VT) : void
      {
         this._pinkNum = param1;
      }
      
      public function get goldNum() : VT
      {
         return this._goldNum;
      }
      
      public function set goldNum(param1:VT) : void
      {
         this._goldNum = param1;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function set color(param1:VT) : void
      {
         this._color = param1;
      }
      
      public function get timeX() : VT
      {
         return this._timeX;
      }
      
      public function set timeX(param1:VT) : void
      {
         this._timeX = param1;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getClassName() : String
      {
         return this._className;
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getColor() : Number
      {
         return this._color.getValue();
      }
      
      public function getIntroduction() : String
      {
         return this._introduction;
      }
      
      public function getBlueLV() : Number
      {
         return this._blueLV.getValue();
      }
      
      public function getPinkLV() : Number
      {
         return this._pinkLV.getValue();
      }
      
      public function getGoldLV() : Number
      {
         return this._goldLV.getValue();
      }
      
      public function getBlueNum() : Number
      {
         return this._blueNum.getValue();
      }
      
      public function getPinkNum() : Number
      {
         return this._pinkNum.getValue();
      }
      
      public function getGoldNum() : Number
      {
         return this._goldNum.getValue();
      }
      
      public function getTimeX() : Number
      {
         return this._timeX.getValue();
      }
      
      public function creatElves() : Elves
      {
         return Elves.creatElves(this._id.getValue(),this._blueNum.getValue(),this._pinkNum.getValue(),this._goldNum.getValue());
      }
   }
}

