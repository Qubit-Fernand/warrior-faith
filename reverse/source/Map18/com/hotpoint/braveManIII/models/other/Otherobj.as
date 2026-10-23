package com.hotpoint.braveManIII.models.other
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.other.*;
   
   public class Otherobj
   {
      
      private var _id:VT;
      
      private var _times:VT = VT.createVT(1);
      
      public function Otherobj()
      {
         super();
      }
      
      public static function creatOther(id:Number, times:Number) : Otherobj
      {
         var other:Otherobj = new Otherobj();
         other._id = VT.createVT(id);
         other._times = VT.createVT(times);
         return other;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
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
      
      public function compareById(id:Number) : Boolean
      {
         if(this._id.getValue() == id)
         {
            return true;
         }
         return false;
      }
      
      public function compareOtherobj(oo:Otherobj) : Boolean
      {
         if(this._id.getValue() == oo._id.getValue())
         {
            return true;
         }
         return false;
      }
      
      public function addOtherobj(ts:Number) : Boolean
      {
         if(this._times.getValue() + ts <= this.getPileLimit())
         {
            _times.setValue(_times.getValue() + ts);
            return true;
         }
         return false;
      }
      
      public function useOtherobj(ts:Number) : Boolean
      {
         if(_times.getValue() >= ts)
         {
            _times.setValue(_times.getValue() - ts);
            if(_times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function cloneOtherobj(ts:Number) : Otherobj
      {
         return creatOther(_id.getValue(),ts);
      }
   }
}

