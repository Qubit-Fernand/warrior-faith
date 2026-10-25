package com.hotpoint.braveManIII.repository.plan
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.plan.*;
   
   public class PlanBasicData
   {
      
      private var _id:VT;
      
      private var _groupid:VT;
      
      private var _group:VT;
      
      private var _introduction:String;
      
      private var _rewardtype_1:VT;
      
      private var _rewardtype_2:VT;
      
      private var _reward_1:VT;
      
      private var _reward_2:VT;
      
      private var _frame_1:VT;
      
      private var _frame_2:VT;
      
      private var _count_1:VT;
      
      private var _count_2:VT;
      
      public function PlanBasicData()
      {
         super();
      }
      
      public static function creatPlanBasicData(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:*, param11:*, param12:*) : *
      {
         var _loc13_:PlanBasicData = new PlanBasicData();
         _loc13_._id = VT.createVT(param1);
         _loc13_._groupid = VT.createVT(param2);
         _loc13_._group = VT.createVT(param3);
         _loc13_._introduction = param4;
         _loc13_.rewardtype_1 = VT.createVT(param5);
         _loc13_.rewardtype_2 = VT.createVT(param6);
         _loc13_._reward_1 = VT.createVT(param7);
         _loc13_._reward_2 = VT.createVT(param8);
         _loc13_._frame_1 = VT.createVT(param9);
         _loc13_._frame_2 = VT.createVT(param10);
         _loc13_._count_1 = VT.createVT(param11);
         _loc13_._count_2 = VT.createVT(param12);
         return _loc13_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get groupid() : VT
      {
         return _groupid;
      }
      
      public function set groupid(param1:VT) : void
      {
         _groupid = param1;
      }
      
      public function get group() : VT
      {
         return _group;
      }
      
      public function set group(param1:VT) : void
      {
         _group = param1;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         _introduction = param1;
      }
      
      public function get rewardtype_1() : VT
      {
         return _rewardtype_1;
      }
      
      public function set rewardtype_1(param1:VT) : void
      {
         _rewardtype_1 = param1;
      }
      
      public function get rewardtype_2() : VT
      {
         return _rewardtype_2;
      }
      
      public function set rewardtype_2(param1:VT) : void
      {
         _rewardtype_2 = param1;
      }
      
      public function get reward_1() : VT
      {
         return _reward_1;
      }
      
      public function set reward_1(param1:VT) : void
      {
         _reward_1 = param1;
      }
      
      public function get reward_2() : VT
      {
         return _reward_2;
      }
      
      public function set reward_2(param1:VT) : void
      {
         _reward_2 = param1;
      }
      
      public function get frame_1() : VT
      {
         return _frame_1;
      }
      
      public function set frame_1(param1:VT) : void
      {
         _frame_1 = param1;
      }
      
      public function get frame_2() : VT
      {
         return _frame_2;
      }
      
      public function set frame_2(param1:VT) : void
      {
         _frame_2 = param1;
      }
      
      public function get count_1() : VT
      {
         return _count_1;
      }
      
      public function set count_1(param1:VT) : void
      {
         _count_1 = param1;
      }
      
      public function get count_2() : VT
      {
         return _count_2;
      }
      
      public function set count_2(param1:VT) : void
      {
         _count_2 = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getGroupId() : Number
      {
         return _groupid.getValue();
      }
      
      public function getGroup() : Number
      {
         return _group.getValue();
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getRewardType_1() : Number
      {
         return _rewardtype_1.getValue();
      }
      
      public function getRewardType_2() : Number
      {
         return _rewardtype_2.getValue();
      }
      
      public function getReward_1() : Number
      {
         return _reward_1.getValue();
      }
      
      public function getReward_2() : Number
      {
         return _reward_2.getValue();
      }
      
      public function getFrame_1() : Number
      {
         return _frame_1.getValue();
      }
      
      public function getFrame_2() : Number
      {
         return _frame_2.getValue();
      }
      
      public function getCount_1() : Number
      {
         return _count_1.getValue();
      }
      
      public function getCount_2() : Number
      {
         return _count_2.getValue();
      }
      
      public function creatPlan() : Plan
      {
         return Plan.creatPlan(_id.getValue());
      }
   }
}

