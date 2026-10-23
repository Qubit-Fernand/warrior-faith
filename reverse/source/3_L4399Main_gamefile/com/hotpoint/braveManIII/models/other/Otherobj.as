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
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(param1:VT) : void
      {
         _times = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return OtherFactory.getName(_id.getValue());
      }
      
      public function getFrame() : Number
      {
         return OtherFactory.getFrame(_id.getValue());
      }
      
      public function getColor() : Number
      {
         return OtherFactory.getColor(_id.getValue());
      }
      
      public function getFallLevel() : Number
      {
         return OtherFactory.getFallLevel(_id.getValue());
      }
      
      public function getType() : Number
      {
         return OtherFactory.getType(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return OtherFactory.getIntroduction(_id.getValue());
      }
      
      public function isMany() : Boolean
      {
         return OtherFactory.isMany(_id.getValue());
      }
      
      public function getPileLimit() : Number
      {
         return OtherFactory.getPileLimit(_id.getValue());
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getGold() : Number
      {
         return OtherFactory.getGold(_id.getValue());
      }
      
      public function getRemaining() : Number
      {
         return OtherFactory.getRemaining(_id.getValue());
      }
      
      public function getMultiple() : Number
      {
         return OtherFactory.getMultiple(_id.getValue());
      }
      
      public function getValue_1() : Number
      {
         return OtherFactory.getValue_1(_id.getValue());
      }
      
      public function getIsUse() : Number
      {
         return OtherFactory.getValue_2(_id.getValue());
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
            _times.setValue(_times.getValue() + param1);
            return true;
         }
         return false;
      }
      
      public function useOtherobj(param1:Number) : Boolean
      {
         if(_times.getValue() >= param1)
         {
            _times.setValue(_times.getValue() - param1);
            if(_times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function cloneOtherobj(param1:Number) : Otherobj
      {
         return creatOther(_id.getValue(),param1);
      }
   }
}

