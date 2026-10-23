package com.hotpoint.braveManIII.models.title
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.title.*;
   import flash.display.*;
   import flash.events.*;
   import src.*;
   
   public class Title
   {
      
      private var _id:VT;
      
      private var _createTime:Date;
      
      private var _remainingTime:VT = VT.createVT(1);
      
      public function Title()
      {
         super();
      }
      
      public static function creatTitle(id:*) : Title
      {
         var tt:Title = new Title();
         tt._id = VT.createVT(id);
         tt.setSysTime(Main.serverTime);
         tt.setRemainingTimeNow();
         return tt;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get createTime() : Date
      {
         return this._createTime;
      }
      
      public function set createTime(value:Date) : void
      {
         this._createTime = value;
      }
      
      public function get remainingTime() : VT
      {
         return this._remainingTime;
      }
      
      public function set remainingTime(value:VT) : void
      {
         this._remainingTime = value;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getFrame() : Number
      {
         return TitleFactory.getFrame(this._id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return TitleFactory.getIntroduction(this._id.getValue());
      }
      
      public function getIntroductionSkill() : String
      {
         return TitleFactory.getIntroductionSkill(this._id.getValue());
      }
      
      public function getName() : String
      {
         return TitleFactory.getName(this._id.getValue());
      }
      
      public function getColor() : Number
      {
         return TitleFactory.getColor(this._id.getValue());
      }
      
      public function getType() : Number
      {
         return TitleFactory.getType(this._id.getValue());
      }
      
      public function getDefaultTime() : Number
      {
         return TitleFactory.getDefaultTime(this._id.getValue());
      }
      
      public function getRemainingTime() : Number
      {
         return this._remainingTime.getValue();
      }
      
      public function setRemainingTimeNow() : *
      {
         this._remainingTime.setValue(this.getDefaultTime());
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
         var dd:Date = this.getSysTime();
         var nd:Date = new Date(yeanum,munnum - 1,daynum);
         if(nd.getTime() >= dd.getTime())
         {
            tt = Math.floor((nd.getTime() - dd.getTime()) / (1000 * 24 * 60 * 60));
            tt = this.getDefaultTime() - tt;
            if(tt < 0)
            {
               tt = 0;
            }
            this._remainingTime.setValue(tt);
         }
      }
      
      public function setSysTime(time:VT) : *
      {
         var mytime:int = time.getValue();
         if(mytime <= 18991231)
         {
            this._createTime = new Date();
            return;
         }
         var str:String = String(mytime);
         var yea:String = str.substr(0,4);
         var mun:String = str.substr(4,2);
         var day:String = str.substr(6,2);
         var yeanum:int = new int(yea);
         var munnum:int = new int(mun);
         var daynum:int = new int(day);
         this._createTime = new Date(yeanum,munnum - 1,daynum);
      }
      
      public function getSysTime() : Date
      {
         return this._createTime;
      }
      
      public function getHP() : Number
      {
         return TitleFactory.getHP(this._id.getValue());
      }
      
      public function getMP() : Number
      {
         return TitleFactory.getMP(this._id.getValue());
      }
      
      public function getAttack() : Number
      {
         return TitleFactory.getAttack(this._id.getValue());
      }
      
      public function getDefense() : Number
      {
         return TitleFactory.getDefense(this._id.getValue());
      }
      
      public function getMoveSpeed() : Number
      {
         return TitleFactory.getMoveSpeed(this._id.getValue());
      }
      
      public function getCrit() : Number
      {
         return TitleFactory.getCrit(this._id.getValue());
      }
      
      public function getDuck() : Number
      {
         return TitleFactory.getDuck(this._id.getValue());
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

