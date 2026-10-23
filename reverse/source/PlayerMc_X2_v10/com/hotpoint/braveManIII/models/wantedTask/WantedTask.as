package com.hotpoint.braveManIII.models.wantedTask
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.repository.wantedTask.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class WantedTask
   {
      
      internal var a:uint;
      
      private var _id:VT;
      
      private var _times:VT;
      
      private var _cooldown:VT;
      
      private var _state:VT;
      
      private var temp:Number;
      
      public function WantedTask()
      {
         super();
         a = setInterval(timeStart,1000);
      }
      
      public static function creatWantedTask(param1:*) : WantedTask
      {
         var _loc2_:WantedTask = new WantedTask();
         _loc2_._id = VT.createVT(param1);
         _loc2_._times = VT.createVT(0);
         _loc2_._cooldown = VT.createVT(0);
         _loc2_._state = VT.createVT(0);
         return _loc2_;
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
      
      public function get state() : VT
      {
         return _state;
      }
      
      public function set state(param1:VT) : void
      {
         _state = param1;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(param1:VT) : void
      {
         _id = param1;
      }
      
      public function getFrame() : Number
      {
         return WantedFactory.getFrame(_id.getValue());
      }
      
      public function getReward_1() : Number
      {
         return WantedFactory.getReward_1(_id.getValue());
      }
      
      public function getReward_2() : Number
      {
         return WantedFactory.getReward_2(_id.getValue());
      }
      
      public function getTimes() : Number
      {
         return WantedFactory.getTimes(_id.getValue());
      }
      
      public function getCooldown() : Number
      {
         return WantedFactory.getCooldown(_id.getValue());
      }
      
      public function getMap1() : Number
      {
         return WantedFactory.getMap1(_id.getValue());
      }
      
      public function getMap2() : Number
      {
         return WantedFactory.getMap2(_id.getValue());
      }
      
      public function getMap3() : Number
      {
         return WantedFactory.getMap3(_id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return WantedFactory.getIntroduction(_id.getValue());
      }
      
      public function getName() : Number
      {
         return WantedFactory.getName(_id.getValue());
      }
      
      public function getMap() : String
      {
         return WantedFactory.getMap(_id.getValue());
      }
      
      public function getDrop() : String
      {
         return WantedFactory.getDrop(_id.getValue());
      }
      
      public function setState(param1:Number) : *
      {
         if(param1 == 3)
         {
            temp = 0;
            _cooldown.setValue(getCooldown());
         }
         return _state.setValue(param1);
      }
      
      public function getState() : Number
      {
         return _state.getValue();
      }
      
      private function timeStart() : *
      {
         if(_state.getValue() != 3)
         {
            return;
         }
         if(_cooldown.getValue() > 0)
         {
            _cooldown.setValue(_cooldown.getValue() - 1);
         }
         else
         {
            _state.setValue(0);
         }
      }
      
      public function nowCD() : Number
      {
         return _cooldown.getValue();
      }
      
      public function nowTimes() : Number
      {
         return _times.getValue();
      }
      
      public function addTimes(param1:Number = 1) : *
      {
         return _times.setValue(_times.getValue() + param1);
      }
   }
}

