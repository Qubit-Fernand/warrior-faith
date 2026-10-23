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
         this.a = setInterval(this.timeStart,1000);
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
         return this._times;
      }
      
      public function set times(value:VT) : void
      {
         this._times = value;
      }
      
      public function get cooldown() : VT
      {
         return this._cooldown;
      }
      
      public function set cooldown(value:VT) : void
      {
         this._cooldown = value;
      }
      
      public function get state() : VT
      {
         return this._state;
      }
      
      public function set state(value:VT) : void
      {
         this._state = value;
      }
      
      public function get id() : VT
      {
         return this._id;
      }
      
      public function set id(value:VT) : void
      {
         this._id = value;
      }
      
      public function getFrame() : Number
      {
         return WantedFactory.getFrame(this._id.getValue());
      }
      
      public function getReward_1() : Number
      {
         return WantedFactory.getReward_1(this._id.getValue());
      }
      
      public function getReward_2() : Number
      {
         return WantedFactory.getReward_2(this._id.getValue());
      }
      
      public function getTimes() : Number
      {
         return WantedFactory.getTimes(this._id.getValue());
      }
      
      public function getCooldown() : Number
      {
         return WantedFactory.getCooldown(this._id.getValue());
      }
      
      public function getMap1() : Number
      {
         return WantedFactory.getMap1(this._id.getValue());
      }
      
      public function getMap2() : Number
      {
         return WantedFactory.getMap2(this._id.getValue());
      }
      
      public function getMap3() : Number
      {
         return WantedFactory.getMap3(this._id.getValue());
      }
      
      public function getIntroduction() : String
      {
         return WantedFactory.getIntroduction(this._id.getValue());
      }
      
      public function getName() : Number
      {
         return WantedFactory.getName(this._id.getValue());
      }
      
      public function getMap() : String
      {
         return WantedFactory.getMap(this._id.getValue());
      }
      
      public function getDrop() : String
      {
         return WantedFactory.getDrop(this._id.getValue());
      }
      
      public function setState(value:Number) : *
      {
         if(value == 3)
         {
            this.temp = 0;
            this._cooldown.setValue(this.getCooldown());
         }
         return this._state.setValue(value);
      }
      
      public function getState() : Number
      {
         return this._state.getValue();
      }
      
      private function timeStart() : *
      {
         if(this._state.getValue() != 3)
         {
            return;
         }
         if(this._cooldown.getValue() > 0)
         {
            this._cooldown.setValue(this._cooldown.getValue() - 1);
         }
         else
         {
            this._state.setValue(0);
         }
      }
      
      public function nowCD() : Number
      {
         return this._cooldown.getValue();
      }
      
      public function nowTimes() : Number
      {
         return this._times.getValue();
      }
      
      public function addTimes(value:Number = 1) : *
      {
         return this._times.setValue(this._times.getValue() + value);
      }
   }
}

