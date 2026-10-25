package com.hotpoint.braveManIII.models.achievement
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.achievement.*;
   
   public class Achievement
   {
      
      private var _id:VT;
      
      private var _obj:Object;
      
      private var _state:VT;
      
      private var _overTimer:VT;
      
      public function Achievement()
      {
         super();
      }
      
      public static function creatAch(id:Number) : Achievement
      {
         var ach:Achievement = new Achievement();
         ach._id = VT.createVT(id);
         ach.initObj();
         ach._state = VT.createVT(0);
         ach._overTimer = VT.createVT(0);
         return ach;
      }
      
      public function initObj() : void
      {
         var type:Number = getWhoType();
         if(type == 0)
         {
            _obj = AchEneFactory.getAcForEne(_id.getValue());
            trace("初始条件_______________:" + _obj);
         }
      }
      
      public function getObj() : Object
      {
         return _obj;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getName() : String
      {
         return AchSmFactory.getName(_id.getValue());
      }
      
      public function getFrame() : Number
      {
         return AchSmFactory.getFrame(_id.getValue());
      }
      
      public function getSm() : String
      {
         return AchSmFactory.getSm(_id.getValue());
      }
      
      public function isEveryDady() : Boolean
      {
         return AchSmFactory.isEveryDady(_id.getValue());
      }
      
      public function getType() : Number
      {
         return AchSmFactory.getType(_id.getValue());
      }
      
      public function getWhoType() : Number
      {
         return AchSmFactory.getWhoType(_id.getValue());
      }
      
      public function getRewardAc() : Number
      {
         return AchSmFactory.getRewardAc(_id.getValue());
      }
      
      public function isOk() : Boolean
      {
         var type:Number = getWhoType();
         if(type == 0)
         {
            return (_obj as AchForEne).isEnemyOk();
         }
         return false;
      }
      
      public function getStata() : Number
      {
         return _state.getValue();
      }
      
      public function setStata(num:Number) : void
      {
         _state.setValue(num);
      }
      
      public function getOverTimer() : Number
      {
         return _overTimer.getValue();
      }
      
      public function setOverTimer(t:Number) : void
      {
         _overTimer.setValue(t);
      }
   }
}

