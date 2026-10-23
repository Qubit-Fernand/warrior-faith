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
      
      public function get className() : String
      {
         return _className;
      }
      
      public function set className(param1:String) : void
      {
         _className = param1;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(param1:VT) : void
      {
         _frame = param1;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         _introduction = param1;
      }
      
      public function get blueLV() : VT
      {
         return _blueLV;
      }
      
      public function set blueLV(param1:VT) : void
      {
         _blueLV = param1;
      }
      
      public function get pinkLV() : VT
      {
         return _pinkLV;
      }
      
      public function set pinkLV(param1:VT) : void
      {
         _pinkLV = param1;
      }
      
      public function get goldLV() : VT
      {
         return _goldLV;
      }
      
      public function set goldLV(param1:VT) : void
      {
         _goldLV = param1;
      }
      
      public function get blueNum() : VT
      {
         return _blueNum;
      }
      
      public function set blueNum(param1:VT) : void
      {
         _blueNum = param1;
      }
      
      public function get pinkNum() : VT
      {
         return _pinkNum;
      }
      
      public function set pinkNum(param1:VT) : void
      {
         _pinkNum = param1;
      }
      
      public function get goldNum() : VT
      {
         return _goldNum;
      }
      
      public function set goldNum(param1:VT) : void
      {
         _goldNum = param1;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function set color(param1:VT) : void
      {
         _color = param1;
      }
      
      public function get timeX() : VT
      {
         return _timeX;
      }
      
      public function set timeX(param1:VT) : void
      {
         _timeX = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getClassName() : String
      {
         return _className;
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getBlueLV() : Number
      {
         return _blueLV.getValue();
      }
      
      public function getPinkLV() : Number
      {
         return _pinkLV.getValue();
      }
      
      public function getGoldLV() : Number
      {
         return _goldLV.getValue();
      }
      
      public function getBlueNum() : Number
      {
         return _blueNum.getValue();
      }
      
      public function getPinkNum() : Number
      {
         return _pinkNum.getValue();
      }
      
      public function getGoldNum() : Number
      {
         return _goldNum.getValue();
      }
      
      public function getTimeX() : Number
      {
         return _timeX.getValue();
      }
      
      public function creatElves() : Elves
      {
         return Elves.creatElves(_id.getValue(),_blueNum.getValue(),_pinkNum.getValue(),_goldNum.getValue());
      }
   }
}

