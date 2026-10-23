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
      
      public static function creatWantedBasicData(id:*, frame:*, name:*, map:*, introduction:*, drop:*, reward_1:*, reward_2:*, times:*, cooldown:*, map1:*, map2:*, map3:*) : *
      {
         var wbd:WantedBasicData = new WantedBasicData();
         wbd._id = VT.createVT(id);
         wbd._name = VT.createVT(name);
         wbd._map = map;
         wbd._introduction = introduction;
         wbd._drop = drop;
         wbd._frame = VT.createVT(frame);
         wbd._reward_1 = VT.createVT(reward_1);
         wbd._reward_2 = VT.createVT(reward_2);
         wbd._times = VT.createVT(times);
         wbd._cooldown = VT.createVT(cooldown);
         wbd._map1 = VT.createVT(map1);
         wbd._map2 = VT.createVT(map2);
         wbd._map3 = VT.createVT(map3);
         return wbd;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
      }
      
      public function get frame() : VT
      {
         return _frame;
      }
      
      public function set frame(value:VT) : void
      {
         _frame = value;
      }
      
      public function get name() : VT
      {
         return _name;
      }
      
      public function set name(value:VT) : void
      {
         _name = value;
      }
      
      public function get map() : String
      {
         return _map;
      }
      
      public function set map(value:String) : void
      {
         _map = value;
      }
      
      public function get introduction() : String
      {
         return _introduction;
      }
      
      public function set introduction(value:String) : void
      {
         _introduction = value;
      }
      
      public function get drop() : String
      {
         return _drop;
      }
      
      public function set drop(value:String) : void
      {
         _drop = value;
      }
      
      public function get reward_1() : VT
      {
         return _reward_1;
      }
      
      public function set reward_1(value:VT) : void
      {
         _reward_1 = value;
      }
      
      public function get reward_2() : VT
      {
         return _reward_2;
      }
      
      public function set reward_2(value:VT) : void
      {
         _reward_2 = value;
      }
      
      public function get times() : VT
      {
         return _times;
      }
      
      public function set times(value:VT) : void
      {
         _times = value;
      }
      
      public function get cooldown() : VT
      {
         return _cooldown;
      }
      
      public function set cooldown(value:VT) : void
      {
         _cooldown = value;
      }
      
      public function get map1() : VT
      {
         return _map1;
      }
      
      public function set map1(value:VT) : void
      {
         _map1 = value;
      }
      
      public function get map2() : VT
      {
         return _map2;
      }
      
      public function set map2(value:VT) : void
      {
         _map2 = value;
      }
      
      public function get map3() : VT
      {
         return _map3;
      }
      
      public function set map3(value:VT) : void
      {
         _map3 = value;
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

