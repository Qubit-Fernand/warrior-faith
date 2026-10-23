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
      
      public static function creatOther(id:Number, times:Number) : Otherobj
      {
         var other:Otherobj = new Otherobj();
         other._id = VT.createVT(id);
         other._times = VT.createVT(times);
         return other;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function get times() : VT
      {
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         this._times = value;
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
      
      public function compareById(id:Number) : Boolean
      {
         if(this._id.getValue() == id)
         {
            return true;
         }
         return false;
      }
      
      public function testOtherobj(oo:Otherobj) : *
      {
         if(this == oo)
         {
            SaveXX.Save(8,321);
         }
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
            this._times.setValue(this._times.getValue() + ts);
            return true;
         }
         return false;
      }
      
      public function useOtherobj(ts:Number) : Boolean
      {
         if(this._times.getValue() >= ts)
         {
            this._times.setValue(this._times.getValue() - ts);
            if(this._times.getValue() > 0)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function cloneOtherobj(ts:Number) : Otherobj
      {
         return creatOther(this._id.getValue(),ts);
      }
   }
}

