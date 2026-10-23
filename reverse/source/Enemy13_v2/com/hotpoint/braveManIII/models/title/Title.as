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
      
      public static function creatTitle(param1:*, param2:*) : Title
      {
         var _loc3_:Title = new Title();
         _loc3_._id = VT.createVT(param1);
         _loc3_._attribute = param2;
         _loc3_.setSysTime(Main.serverTime);
         _loc3_.setRemainingTimeNow();
         return _loc3_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get attribute() : Array
      {
         return _attribute;
      }
      
      public function set attribute(param1:Array) : void
      {
         _attribute = param1;
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
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _attribute)
         {
            if(_loc2_.getAttribType() == 1)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
      
      public function getMP() : Number
      {
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _attribute)
         {
            if(_loc2_.getAttribType() == 2)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
      
      public function getAttack() : Number
      {
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _attribute)
         {
            if(_loc2_.getAttribType() == 3)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
      
      public function getDefense() : Number
      {
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _attribute)
         {
            if(_loc2_.getAttribType() == 4)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
      
      public function getMoveSpeed() : Number
      {
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _attribute)
         {
            if(_loc2_.getAttribType() == 7)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
      
      public function getCrit() : Number
      {
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _attribute)
         {
            if(_loc2_.getAttribType() == 5)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
      
      public function getDuck() : Number
      {
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in _attribute)
         {
            if(_loc2_.getAttribType() == 6)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
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

