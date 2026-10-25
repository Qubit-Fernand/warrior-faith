package com.hotpoint.braveManIII.repository.wantedTask
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.wantedTask.*;
   
   public class WantedBasicData
   {
      
      private var _id:VT;
      
      private var _frame:VT;
      
      private var _name:VT;
      
      private var _map:String;
      
      private var _introduction:String;
      
      private var _drop:String;
      
      private var _reward_1:VT;
      
      private var _reward_2:VT;
      
      private var _times:VT;
      
      private var _cooldown:VT;
      
      private var _map1:VT;
      
      private var _map2:VT;
      
      private var _map3:VT;
      
      public function WantedBasicData()
      {
         super();
      }
      
      public static function creatWantedBasicData(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:*, param11:*, param12:*, param13:*) : *
      {
         var _loc14_:WantedBasicData = new WantedBasicData();
         _loc14_._id = VT.createVT(param1);
         _loc14_._name = VT.createVT(param3);
         _loc14_._map = param4;
         _loc14_._introduction = param5;
         _loc14_._drop = param6;
         _loc14_._frame = VT.createVT(param2);
         _loc14_._reward_1 = VT.createVT(param7);
         _loc14_._reward_2 = VT.createVT(param8);
         _loc14_._times = VT.createVT(param9);
         _loc14_._cooldown = VT.createVT(param10);
         _loc14_._map1 = VT.createVT(param11);
         _loc14_._map2 = VT.createVT(param12);
         _loc14_._map3 = VT.createVT(param13);
         return _loc14_;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(param1:VT) : void
      {
         _frame = param1;
      }
      
      public function get name() : VT
      {
         return _name;
      }
      
      public function set name(param1:VT) : void
      {
         _name = param1;
      }
      
      public function get map() : String
      {
         return _map;
      }
      
      public function set map(param1:String) : void
      {
         _map = param1;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(param1:String) : void
      {
         _introduction = param1;
      }
      
      public function get drop() : String
      {
         return _drop;
      }
      
      public function set drop(param1:String) : void
      {
         _drop = param1;
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
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(param1:VT) : void
      {
         _times = param1;
      }
      
      public function get cooldown() : VT
      {
         return _cooldown;
      }
      
      public function set cooldown(param1:VT) : void
      {
         _cooldown = param1;
      }
      
      public function get map1() : VT
      {
         return _map1;
      }
      
      public function set map1(param1:VT) : void
      {
         _map1 = param1;
      }
      
      public function get map2() : VT
      {
         return _map2;
      }
      
      public function set map2(param1:VT) : void
      {
         _map2 = param1;
      }
      
      public function get map3() : VT
      {
         return _map3;
      }
      
      public function set map3(param1:VT) : void
      {
         _map3 = param1;
      }
      
      public function getId() : Number
      {
         return _id.getValue();
      }
      
      public function getFrame() : Number
      {
         return _frame.getValue();
      }
      
      public function getReward_1() : Number
      {
         return _reward_1.getValue();
      }
      
      public function getReward_2() : Number
      {
         return _reward_2.getValue();
      }
      
      public function getTimes() : Number
      {
         return _times.getValue();
      }
      
      public function getCooldown() : Number
      {
         return _cooldown.getValue();
      }
      
      public function getName() : Number
      {
         return _name.getValue();
      }
      
      public function getMap1() : Number
      {
         return _map1.getValue();
      }
      
      public function getMap2() : Number
      {
         return _map2.getValue();
      }
      
      public function getMap3() : Number
      {
         return _map3.getValue();
      }
      
      public function getMap() : String
      {
         return _map;
      }
      
      public function getIntroduction() : String
      {
         return _introduction;
      }
      
      public function getDrop() : String
      {
         return _drop;
      }
      
      public function creatWantedTask() : WantedTask
      {
         return WantedTask.creatWantedTask(_id.getValue());
      }
   }
}

