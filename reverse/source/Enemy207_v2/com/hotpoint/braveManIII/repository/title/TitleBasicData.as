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
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(value:String) : void
      {
         _introduction = value;
      }
      
      public function get color() : VT
      {
         return _color;
      }
      
      public function set color(value:VT) : void
      {
         _color = value;
      }
      
      public function get type() : VT
      {
         return _type;
      }
      
      public function set type(value:VT) : void
      {
         _type = value;
      }
      
      public function get attrib() : Array
      {
         return _attrib;
      }
      
      public function set attrib(value:Array) : void
      {
         _attrib = value;
      }
      
      public function get remainingTime() : VT
      {
         return _remainingTime;
      }
      
      public function set remainingTime(value:VT) : void
      {
         _remainingTime = value;
      }
      
      public function get defaultTime() : VT
      {
         return _defaultTime;
      }
      
      public function set defaultTime(value:VT) : void
      {
         _defaultTime = value;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return _name;
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getIntroductionSkill() : String
      {
         return _introductionSkill;
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getColor() : Number
      {
         return _color.getValue();
      }
      
      public function getType() : Number
      {
         return _type.getValue();
      }
      
      public function getRemainingTime() : Number
      {
         return _remainingTime.getValue();
      }
      
      public function getDefaultTime() : Number
      {
         return _defaultTime.getValue();
      }
      
      public function getArr() : Array
      {
         return _attrib;
      }
      
      public function creatTitle() : Title
      {
         return Title.creatTitle(_id.getValue());
      }
   }
}

