package com.hotpoint.braveManIII.models.plan
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.plan.*;
   
   public class Plan
   {
      
      private var _id:VT;
      
      private var _state:VT = VT.createVT(0);
      
      public function Plan()
      {
         super();
      }
      
      public static function creatPlan(param1:*) : Plan
      {
         var _loc2_:Plan = new Plan();
         _loc2_._id = VT.createVT(param1);
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
      
      public function get state() : VT
      {
         return _state;
      }
      
      public function set state(param1:VT) : void
      {
         _state = param1;
      }
      
      public function getGroupId() : Number
      {
         return PlanFactory.findGroupId(_id.getValue());
      }
      
      public function getGroup() : Number
      {
         return PlanFactory.findXiaoZu(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return PlanFactory.findIntroduction(_id.getValue());
      }
      
      public function getRewardType_1() : Number
      {
         return PlanFactory.findRewardType_1(_id.getValue());
      }
      
      public function getRewardType_2() : Number
      {
         return PlanFactory.findRewardType_2(_id.getValue());
      }
      
      public function getReward_1() : Number
      {
         return PlanFactory.findReward_1(_id.getValue());
      }
      
      public function getReward_2() : Number
      {
         return PlanFactory.findReward_2(_id.getValue());
      }
      
      public function getFrame_1() : Number
      {
         return PlanFactory.findFrame_1(_id.getValue());
      }
      
      public function getFrame_2() : Number
      {
         return PlanFactory.findFrame_2(_id.getValue());
      }
      
      public function getCount_1() : Number
      {
         return PlanFactory.findCount_1(_id.getValue());
      }
      
      public function getCount_2() : Number
      {
         return PlanFactory.findCount_2(_id.getValue());
      }
      
      public function setState(param1:Number) : void
      {
         _state.setValue(param1);
      }
      
      public function getState() : Number
      {
         return _state.getValue();
      }
   }
}

