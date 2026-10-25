package com.hotpoint.braveManIII.repository.title
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.title.*;
   
   public class TitleBasicData
   {
      
      private var _id:VT;
      
      private var _frame:VT;
      
      private var _name:String;
      
      private var _introduction:String;
      
      private var _introductionSkill:String;
      
      private var _color:VT;
      
      private var _type:VT;
      
      private var _attrib:Array = [];
      
      private var _remainingTime:VT;
      
      private var _defaultTime:VT;
      
      public function TitleBasicData()
      {
         super();
      }
      
      public static function creatTitleBasicData(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:*) : *
      {
         var _loc11_:TitleBasicData = new TitleBasicData();
         _loc11_._id = VT.createVT(param1);
         _loc11_._name = param3;
         _loc11_._introduction = param4;
         _loc11_._introductionSkill = param5;
         _loc11_._frame = VT.createVT(param2);
         _loc11_._color = VT.createVT(param6);
         _loc11_._type = VT.createVT(param7);
         _loc11_._attrib = param8;
         _loc11_._remainingTime = VT.createVT(param9);
         _loc11_._defaultTime = VT.createVT(param10);
         return _loc11_;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         this._id = param1;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(param1:VT) : void
      {
         this._frame = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get introduction() : String
      {
         return this._introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         this._introduction = param1;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function set color(param1:VT) : void
      {
         this._color = param1;
      }
      
      public function get type() : VT
      {
         return this._type;
      }
      
      public function set type(param1:VT) : void
      {
         this._type = param1;
      }
      
      public function get attrib() : Array
      {
         return this._attrib;
      }
      
      public function set attrib(param1:Array) : void
      {
         this._attrib = param1;
      }
      
      public function get remainingTime() : VT
      {
         return this._remainingTime;
      }
      
      public function set remainingTime(param1:VT) : void
      {
         this._remainingTime = param1;
      }
      
      public function get defaultTime() : VT
      {
         return this._defaultTime;
      }
      
      public function set defaultTime(param1:VT) : void
      {
         this._defaultTime = param1;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getIntroduction() : String
      {
         return this._introduction;
      }
      
      public function getIntroductionSkill() : String
      {
         return this._introductionSkill;
      }
      
      public function getFrame() : Number
      {
         return this._frame.getValue();
      }
      
      public function getColor() : Number
      {
         return this._color.getValue();
      }
      
      public function getType() : Number
      {
         return this._type.getValue();
      }
      
      public function getRemainingTime() : Number
      {
         return this._remainingTime.getValue();
      }
      
      public function getDefaultTime() : Number
      {
         return this._defaultTime.getValue();
      }
      
      public function getArr() : Array
      {
         return this._attrib;
      }
      
      public function creatTitle() : Title
      {
         return Title.creatTitle(this._id.getValue());
      }
   }
}

