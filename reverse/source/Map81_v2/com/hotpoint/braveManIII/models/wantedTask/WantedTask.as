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
      
      public static function creatWantedTask(id:*) : WantedTask
      {
         var wt:WantedTask = new WantedTask();
         wt._id = VT.createVT(id);
         wt._times = VT.createVT(0);
         wt._cooldown = VT.createVT(0);
         wt._state = VT.createVT(0);
         return wt;
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
      
      public function get state() : VT
      {
         return _state;
      }
      
      public function set state(value:VT) : void
      {
         _state = value;
      }
      
      public function get id() : VT
      {
         return _id;
      }
      
      public function set id(value:VT) : void
      {
         _id = value;
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
      
      public function setState(value:Number) : *
      {
         if(value == 3)
         {
            temp = 0;
            _cooldown.setValue(getCooldown());
         }
         return _state.setValue(value);
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
      
      public function addTimes(value:Number = 1) : *
      {
         return _times.setValue(_times.getValue() + value);
      }
   }
}

