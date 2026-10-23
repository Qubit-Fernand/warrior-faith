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
         return this._id;
      }
      
      public function set id(param1:VT) : void
      {
         this._id = param1;
      }
      
      public function get attribute() : Array
      {
         return this._attribute;
      }
      
      public function set attribute(param1:Array) : void
      {
         this._attribute = param1;
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
         var _loc10_:Date = this.getSysTime();
         var _loc11_:Date = new Date(_loc7_,_loc8_ - 1,_loc9_);
         if(_loc11_.getTime() >= _loc10_.getTime())
         {
            _loc12_ = Math.floor((_loc11_.getTime() - _loc10_.getTime()) / (1000 * 24 * 60 * 60));
            _loc12_ = this.getDefaultTime() - _loc12_;
            if(_loc12_ < 0)
            {
               _loc12_ = 0;
            }
            this._remainingTime.setValue(_loc12_);
         }
      }
      
      public function setSysTime(param1:VT) : *
      {
         var _loc2_:int = param1.getValue();
         if(_loc2_ <= 18991231)
         {
            this._createTime = new Date();
            return;
         }
         var _loc3_:String = String(_loc2_);
         var _loc4_:String = _loc3_.substr(0,4);
         var _loc5_:String = _loc3_.substr(4,2);
         var _loc6_:String = _loc3_.substr(6,2);
         var _loc7_:int = new int(_loc4_);
         var _loc8_:int = new int(_loc5_);
         var _loc9_:int = new int(_loc6_);
         this._createTime = new Date(_loc7_,_loc8_ - 1,_loc9_);
      }
      
      public function getSysTime() : Date
      {
         return this._createTime;
      }
      
      public function getHP() : Number
      {
         var _loc2_:Attribute = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._attribute)
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
         for each(_loc2_ in this._attribute)
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
         for each(_loc2_ in this._attribute)
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
         for each(_loc2_ in this._attribute)
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
         for each(_loc2_ in this._attribute)
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
         for each(_loc2_ in this._attribute)
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
         for each(_loc2_ in this._attribute)
         {
            if(_loc2_.getAttribType() == 6)
            {
               _loc1_ += _loc2_.getValue();
            }
         }
         return _loc1_;
      }
   }
}

