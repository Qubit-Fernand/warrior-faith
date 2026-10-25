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
      
      public static function creatTitle(param1:*) : Title
      {
         var _loc2_:Title = new Title();
         _loc2_._id = VT.createVT(param1);
         _loc2_.setSysTime(Main.serverTime);
         _loc2_.setRemainingTimeNow();
         return _loc2_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get createTime() : Date
      {
         return _createTime;
      }
      
      public function set createTime(param1:Date) : void
      {
         _createTime = param1;
      }
      
      public function get remainingTime() : VT
      {
         return _remainingTime;
      }
      
      public function set remainingTime(param1:VT) : void
      {
         _remainingTime = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
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
      
      public function setRemainingTime(param1:VT) : *
      {
         var _loc12_:int = 0;
         var _loc2_:int = param1.getValue();
         var _loc3_:String = String(_loc2_);
         var _loc4_:String = _loc3_.substr(0,4);
         var _loc5_:String = _loc3_.substr(4,2);
         var _loc6_:String = _loc3_.substr(6,2);
         var _loc7_:int = new int(_loc4_);
         var _loc8_:int = new int(_loc5_);
         var _loc9_:int = new int(_loc6_);
         var _loc10_:Date = getSysTime();
         var _loc11_:Date = new Date(_loc7_,_loc8_ - 1,_loc9_);
         if(_loc11_.getTime() >= _loc10_.getTime())
         {
            _loc12_ = Math.floor((_loc11_.getTime() - _loc10_.getTime()) / (1000 * 24 * 60 * 60));
            _loc12_ = getDefaultTime() - _loc12_;
            if(_loc12_ < 0)
            {
               _loc12_ = 0;
            }
            _remainingTime.setValue(_loc12_);
         }
      }
      
      public function setSysTime(param1:VT) : *
      {
         var _loc2_:int = param1.getValue();
         if(_loc2_ <= 18991231)
         {
            _createTime = new Date();
            return;
         }
         var _loc3_:String = String(_loc2_);
         var _loc4_:String = _loc3_.substr(0,4);
         var _loc5_:String = _loc3_.substr(4,2);
         var _loc6_:String = _loc3_.substr(6,2);
         var _loc7_:int = new int(_loc4_);
         var _loc8_:int = new int(_loc5_);
         var _loc9_:int = new int(_loc6_);
         _createTime = new Date(_loc7_,_loc8_ - 1,_loc9_);
      }
      
      public function getSysTime() : Date
      {
         return _createTime;
      }
      
      public function getHP() : Number
      {
         return TitleFactory.getHP(_id.getValue());
      }
      
      public function getMP() : Number
      {
         return TitleFactory.getMP(_id.getValue());
      }
      
      public function getAttack() : Number
      {
         return TitleFactory.getAttack(_id.getValue());
      }
      
      public function getDefense() : Number
      {
         return TitleFactory.getDefense(_id.getValue());
      }
      
      public function getMoveSpeed() : Number
      {
         return TitleFactory.getMoveSpeed(_id.getValue());
      }
      
      public function getCrit() : Number
      {
         return TitleFactory.getCrit(_id.getValue());
      }
      
      public function getDuck() : Number
      {
         return TitleFactory.getDuck(_id.getValue());
      }
      
      public function compare(param1:Title) : Boolean
      {
         if(this._id.getValue() == param1._id.getValue())
         {
            return true;
         }
         return false;
      }
   }
}

