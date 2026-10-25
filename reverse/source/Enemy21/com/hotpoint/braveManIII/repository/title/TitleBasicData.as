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
      
      public static function creatTitleBasicData(id:*, frame:*, name:*, introduction:*, introductionSkill:*, color:*, type:*, attrib:*, remainingTime:*, defaultTime:*) : *
      {
         var tbd:TitleBasicData = new TitleBasicData();
         tbd._id = VT.createVT(id);
         tbd._name = name;
         tbd._introduction = introduction;
         tbd._introductionSkill = introductionSkill;
         tbd._frame = VT.createVT(frame);
         tbd._color = VT.createVT(color);
         tbd._type = VT.createVT(type);
         tbd._attrib = attrib;
         tbd._remainingTime = VT.createVT(remainingTime);
         tbd._defaultTime = VT.createVT(defaultTime);
         return tbd;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get frame() : VT
      {
         return this._frame;
      }
      
      public function set frame(value:VT) : void
      {
         this._frame = value;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(value:String) : void
      {
         this._name = value;
      }
      
      public function get introduction() : String
      {
         return this._introduction;
      }
      
      public function set introduction(value:String) : void
      {
         this._introduction = value;
      }
      
      public function get color() : VT
      {
         return this._color;
      }
      
      public function set color(value:VT) : void
      {
         this._color = value;
      }
      
      public function get type() : VT
      {
         return this._type;
      }
      
      public function set type(value:VT) : void
      {
         this._type = value;
      }
      
      public function get attrib() : Array
      {
         return this._attrib;
      }
      
      public function set attrib(value:Array) : void
      {
         this._attrib = value;
      }
      
      public function get remainingTime() : VT
      {
         return this._remainingTime;
      }
      
      public function set remainingTime(value:VT) : void
      {
         this._remainingTime = value;
      }
      
      public function get defaultTime() : VT
      {
         return this._defaultTime;
      }
      
      public function set defaultTime(value:VT) : void
      {
         this._defaultTime = value;
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
      
      public function creatTitle() : Title
      {
         return Title.creatTitle(this._id.getValue(),this._attrib);
      }
   }
}

