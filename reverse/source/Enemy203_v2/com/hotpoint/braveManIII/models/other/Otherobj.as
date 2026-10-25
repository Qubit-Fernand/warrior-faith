package com.hotpoint.braveManIII.models.other
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import src.*;
   
   public class Otherobj
   {
      
      private var _id:VT;
      
      private var _times:VT = VT.createVT(1);
      
      public function Otherobj()
      {
         super();
      }
      
      public static function creatOther(param1:Number, param2:Number) : Otherobj
      {
         var _loc3_:Otherobj = new Otherobj();
         _loc3_._id = VT.createVT(param1);
         _loc3_._times = VT.createVT(param2);
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
      
      public function get times() : VT
      {
         return this._times;
      }
      
      public function set times(param1:VT) : void
      {
         this._times = param1;
      }
      
      public function getId() : Number
      {
         return this._id.getValue();
      }
      
      public function getName() : String
      {
         return OtherFactory.getName(this._id.getValue());
      }
      
      public function getFrame() : Number
      {
         return OtherFactory.getFrame(this._id.getValue());
      }
      
      public function getColor() : Number
      {
         return OtherFactory.getColor(this._id.getValue());
      }
      
      public function getFallLevel() : Number
      {
         return OtherFactory.getFallLevel(this._id.getValue());
      }
      
      public function getType() : Number
      {
         return OtherFactory.getType(this._id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return OtherFactory.getIntroduction(this._id.getValue());
      }
      
      public function isMany() : Boolean
      {
         return OtherFactory.isMany(this._id.getValue());
      }
      
      public function getPileLimit() : Number
      {
         return OtherFactory.getPileLimit(this._id.getValue());
      }
      
      public function getTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function getGold() : Number
      {
         return OtherFactory.getGold(this._id.getValue());
      }
      
      public function getRemaining() : Number
      {
         return OtherFactory.getRemaining(this._id.getValue());
      }
      
      public function getMultiple() : Number
      {
         return OtherFactory.getMultiple(this._id.getValue());
      }
      
      public function getValue_1() : Number
      {
         return OtherFactory.getValue_1(this._id.getValue());
      }
      
      public function getIsUse() : Number
      {
         return OtherFactory.getValue_2(this._id.getValue());
      }
      
      public function compareById(param1:Number) : Boolean
      {
         if(this._id.getValue() == param1)
         {
            return true;
         }
         return false;
      }
      
      public function testOtherobj(param1:Otherobj) : *
      {
         if(this == param1)
         {
            SaveXX.Save(8,321);
         }
      }
      
      public function compareOtherobj(param1:Otherobj) : Boolean
      {
         if(this._id.getValue() == param1._id.getValue())
         {
            return true;
         }
         return false;
      }
      
      public function addOtherobj(param1:Number) : Boolean
      {
         if(this._times.getValue() + param1 <= this.getPileLimit())
         {
            this._times.setValue(this._times.getValue() + param1);
            return true;
         }
         return false;
      }
      
      public function useOtherobj(param1:Number) : Boolean
      {
         if(this._times.getValue() >= param1)
         {
            this._times.setValue(this._times.getValue() - param1);
            if(this._times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function cloneOtherobj(param1:Number) : Otherobj
      {
         return creatOther(this._id.getValue(),param1);
      }
   }
}

