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
      
      public static function creatElvesBasicData(id:Number, name:String, className:String, frame:Number, introduction:String, color:Number, blueLV:Number, pinkLV:Number, goldLV:Number, blueNum:Number, pinkNum:Number, goldNum:Number, timeX:Number) : ElvesBasicData
      {
         var elves:ElvesBasicData = new ElvesBasicData();
         elves._id = VT.createVT(id);
         elves._name = name;
         elves._className = className;
         elves._introduction = introduction;
         elves._frame = VT.createVT(frame);
         elves._color = VT.createVT(color);
         elves._blueLV = VT.createVT(blueLV);
         elves._blueNum = VT.createVT(blueNum);
         elves._pinkLV = VT.createVT(pinkLV);
         elves._pinkNum = VT.createVT(pinkNum);
         elves._goldLV = VT.createVT(goldLV);
         elves._goldNum = VT.createVT(goldNum);
         elves._timeX = VT.createVT(timeX);
         return elves;
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
      
      public function get className() : String
      {
         return this._className;
      }
      
      public function set className(value:String) : void
      {
         this._className = value;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(value:VT) : void
      {
         this._frame = value;
      }
      
      public function get introduction() : String
      {
         return this._introduction;
      }
      
      public function set introduction(value:String) : void
      {
         this._introduction = value;
      }
      
      public function get blueLV() : VT
      {
         return this._blueLV;
      }
      
      public function set blueLV(value:VT) : void
      {
         this._blueLV = value;
      }
      
      public function get pinkLV() : VT
      {
         return this._pinkLV;
      }
      
      public function set pinkLV(value:VT) : void
      {
         this._pinkLV = value;
      }
      
      public function get goldLV() : VT
      {
         return this._goldLV;
      }
      
      public function set goldLV(value:VT) : void
      {
         this._goldLV = value;
      }
      
      public function get blueNum() : VT
      {
         return this._blueNum;
      }
      
      public function set blueNum(value:VT) : void
      {
         this._blueNum = value;
      }
      
      public function get pinkNum() : VT
      {
         return this._pinkNum;
      }
      
      public function set pinkNum(value:VT) : void
      {
         this._pinkNum = value;
      }
      
      public function get goldNum() : VT
      {
         return this._goldNum;
      }
      
      public function set goldNum(value:VT) : void
      {
         this._goldNum = value;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function set color(value:VT) : void
      {
         this._color = value;
      }
      
      public function get timeX() : VT
      {
         return this._timeX;
      }
      
      public function set timeX(value:VT) : void
      {
         this._timeX = value;
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

