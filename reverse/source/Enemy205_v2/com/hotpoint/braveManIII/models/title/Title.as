package com.hotpoint.braveManIII.models.title
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.gem.Attribute;
   import com.hotpoint.braveManIII.repository.title.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class Title
   {
      
      private var _id:VT;
      
      private var _attribute:Array = [];
      
      private var _createTime:Date;
      
      private var _remainingTime:VT = VT.createVT(1);
      
      public function Title()
      {
         super();
      }
      
      public static function creatTitle(id:*, arr:*) : Title
      {
         var tt:Title = new Title();
         tt._id = VT.createVT(id);
         tt._attribute = arr;
         tt.setSysTime(Main.serverTime);
         tt.setRemainingTimeNow();
         return tt;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get attribute() : Array
      {
         return _attribute;
      }
      
      public function set attribute(value:Array) : void
      {
         _attribute = value;
      }
      
      public function get createTime() : Date
      {
         return _createTime;
      }
      
      public function set createTime(value:Date) : void
      {
         _createTime = value;
      }
      
      public function get remainingTime() : VT
      {
         return _remainingTime;
      }
      
      public function set remainingTime(value:VT) : void
      {
         _remainingTime = value;
      }
      
      public function getFrame() : Number
      {
         return TitleFactory.getFrame(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return TitleFactory.getIntroduction(_id.getValue());
      }
      
      public function getIntroductionSkill() : String
      {
         return TitleFactory.getIntroductionSkill(_id.getValue());
      }
      
      public function getName() : String
      {
         return TitleFactory.getName(_id.getValue());
      }
      
      public function getColor() : Number
      {
         return TitleFactory.getColor(_id.getValue());
      }
      
      public function getType() : Number
      {
         return TitleFactory.getType(_id.getValue());
      }
      
      public function getDefaultTime() : Number
      {
         return TitleFactory.getDefaultTime(_id.getValue());
      }
      
      public function getRemainingTime() : Number
      {
         return _remainingTime.getValue();
      }
      
      public function setRemainingTimeNow() : *
      {
         _remainingTime.setValue(getDefaultTime());
      }
      
      public function setRemainingTime(time:VT) : *
      {
         var tt:int = 0;
         var mytime:int = time.getValue();
         var str:String = String(mytime);
         var yea:String = str.substr(0,4);
         var mun:String = str.substr(4,2);
         var day:String = str.substr(6,2);
         var yeanum:int = new int(yea);
         var munnum:int = new int(mun);
         var daynum:int = new int(day);
         var dd:Date = getSysTime();
         var nd:Date = new Date(yeanum,munnum - 1,daynum);
         if(nd.getTime() >= dd.getTime())
         {
            tt = Math.floor((nd.getTime() - dd.getTime()) / (1000 * 24 * 60 * 60));
            tt = getDefaultTime() - tt;
            if(tt < 0)
            {
               tt = 0;
            }
            _remainingTime.setValue(tt);
         }
      }
      
      public function setSysTime(time:VT) : *
      {
         var mytime:int = time.getValue();
         if(mytime <= 18991231)
         {
            _createTime = new Date();
            return;
         }
         var str:String = String(mytime);
         var yea:String = str.substr(0,4);
         var mun:String = str.substr(4,2);
         var day:String = str.substr(6,2);
         var yeanum:int = new int(yea);
         var munnum:int = new int(mun);
         var daynum:int = new int(day);
         _createTime = new Date(yeanum,munnum - 1,daynum);
      }
      
      public function getSysTime() : Date
      {
         return _createTime;
      }
      
      public function getHP() : Number
      {
         var attrib:Attribute = null;
         var count:int = 0;
         for each(attrib in _attribute)
         {
            if(attrib.getAttribType() == 1)
            {
               count += attrib.getValue();
            }
         }
         return count;
      }
      
      public function getMP() : Number
      {
         var attrib:Attribute = null;
         var count:int = 0;
         for each(attrib in _attribute)
         {
            if(attrib.getAttribType() == 2)
            {
               count += attrib.getValue();
            }
         }
         return count;
      }
      
      public function getAttack() : Number
      {
         var attrib:Attribute = null;
         var count:int = 0;
         for each(attrib in _attribute)
         {
            if(attrib.getAttribType() == 3)
            {
               count += attrib.getValue();
            }
         }
         return count;
      }
      
      public function getDefense() : Number
      {
         var attrib:Attribute = null;
         var count:int = 0;
         for each(attrib in _attribute)
         {
            if(attrib.getAttribType() == 4)
            {
               count += attrib.getValue();
            }
         }
         return count;
      }
      
      public function getMoveSpeed() : Number
      {
         var attrib:Attribute = null;
         var count:int = 0;
         for each(attrib in _attribute)
         {
            if(attrib.getAttribType() == 7)
            {
               count += attrib.getValue();
            }
         }
         return count;
      }
      
      public function getCrit() : Number
      {
         var attrib:Attribute = null;
         var count:int = 0;
         for each(attrib in _attribute)
         {
            if(attrib.getAttribType() == 5)
            {
               count += attrib.getValue();
            }
         }
         return count;
      }
      
      public function getDuck() : Number
      {
         var attrib:Attribute = null;
         var count:int = 0;
         for each(attrib in _attribute)
         {
            if(attrib.getAttribType() == 6)
            {
               count += attrib.getValue();
            }
         }
         return count;
      }
      
      public function compare(value:Title) : Boolean
      {
         if(this._id.getValue() == value._id.getValue())
         {
            return true;
         }
         return false;
      }
   }
}

