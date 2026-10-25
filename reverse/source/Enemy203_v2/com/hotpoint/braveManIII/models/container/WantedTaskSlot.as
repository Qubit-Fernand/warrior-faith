package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.wantedTask.*;
   import com.hotpoint.braveManIII.repository.wantedTask.*;
   import src.*;
   
   public class WantedTaskSlot
   {
      
      private var _slot:Array = new Array();
      
      private var jl_Times:VT = VT.createVT(0);
      
      private var jl2_Times:VT = VT.createVT(0);
      
      private var jl3_Times:VT = VT.createVT(0);
      
      private var jl4_Times:VT = VT.createVT(0);
      
      public function WantedTaskSlot()
      {
         super();
      }
      
      public static function creatWantedTaskSlot() : WantedTaskSlot
      {
         var _loc1_:WantedTaskSlot = new WantedTaskSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 18)
         {
            _loc1_._slot[_loc2_] = null;
            _loc2_++;
         }
         _loc1_.addToSlot(WantedFactory.creatWantedTask(1));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(2));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(3));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(4));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(5));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(6));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(7));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(8));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(9));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(10));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(11));
         _loc1_.addToSlot(WantedFactory.creatWantedTask(12));
         return _loc1_;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(param1:Array) : void
      {
         this._slot = param1;
      }
      
      public function get Times() : VT
      {
         return this.jl_Times;
      }
      
      public function set Times(param1:VT) : void
      {
         this.jl_Times = param1;
      }
      
      public function get Times2() : VT
      {
         return this.jl2_Times;
      }
      
      public function set Times2(param1:VT) : void
      {
         this.jl2_Times = param1;
      }
      
      public function get Times3() : VT
      {
         return this.jl3_Times;
      }
      
      public function set Times3(param1:VT) : void
      {
         this.jl3_Times = param1;
      }
      
      public function get Times4() : VT
      {
         return this.jl4_Times;
      }
      
      public function set Times4(param1:VT) : void
      {
         this.jl4_Times = param1;
      }
      
      public function getWantedTaskFromSlot(param1:int) : WantedTask
      {
         if(this._slot[param1] == null)
         {
            this.addToSlot(WantedFactory.creatWantedTask(param1 + 1));
         }
         else if(Boolean(this._slot[3]) && Boolean(this._slot[4]) && this._slot[3].getFrame() == this._slot[4].getFrame())
         {
            this._slot[3] = WantedFactory.creatWantedTask(4);
         }
         if(this._slot[param1] != null)
         {
            return this._slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:WantedTask) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 18)
         {
            if(this._slot[_loc2_] == null)
            {
               this._slot[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function delSlot(param1:Number) : WantedTask
      {
         var _loc2_:WantedTask = null;
         if(this._slot[param1] != null)
         {
            _loc2_ = this._slot[param1];
            this._slot[param1] = null;
         }
         return _loc2_;
      }
      
      public function wantedTaskComplete() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 18)
         {
            if(this._slot[_loc1_] != null)
            {
               if((this._slot[_loc1_] as WantedTask).getState() == 1)
               {
                  (this._slot[_loc1_] as WantedTask).setState(2);
                  (this._slot[_loc1_] as WantedTask).addTimes();
               }
            }
            _loc1_++;
         }
      }
      
      public function wantedTaskTimesLV1() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            if(this._slot[_loc2_] != null)
            {
               if((this._slot[_loc2_] as WantedTask).getTimes() > 0)
               {
                  _loc1_ += (this._slot[_loc2_] as WantedTask).nowTimes();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function wantedTaskTimesLV2() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 3;
         while(_loc2_ < 6)
         {
            if(this._slot[_loc2_] != null)
            {
               if((this._slot[_loc2_] as WantedTask).getTimes() > 0)
               {
                  _loc1_ += (this._slot[_loc2_] as WantedTask).nowTimes();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function wantedTaskTimesLV3() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 6;
         while(_loc2_ < 9)
         {
            if(this._slot[_loc2_] != null)
            {
               if((this._slot[_loc2_] as WantedTask).getTimes() > 0)
               {
                  _loc1_ += (this._slot[_loc2_] as WantedTask).nowTimes();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function wantedTaskTimesLV4() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 9;
         while(_loc2_ < 12)
         {
            if(this._slot[_loc2_] != null)
            {
               if((this._slot[_loc2_] as WantedTask).getTimes() > 0)
               {
                  _loc1_ += (this._slot[_loc2_] as WantedTask).nowTimes();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addJLTimes() : *
      {
         this.jl_Times.setValue(this.jl_Times.getValue() + 1);
      }
      
      public function addJLTimes2() : *
      {
         this.jl2_Times.setValue(this.jl2_Times.getValue() + 1);
      }
      
      public function addJLTimes3() : *
      {
         this.jl3_Times.setValue(this.jl3_Times.getValue() + 1);
      }
      
      public function addJLTimes4() : *
      {
         this.jl4_Times.setValue(this.jl4_Times.getValue() + 1);
      }
      
      public function getJLTimes() : Number
      {
         return this.jl_Times.getValue();
      }
      
      public function getJLTimes2() : Number
      {
         return this.jl2_Times.getValue();
      }
      
      public function getJLTimes3() : Number
      {
         return this.jl3_Times.getValue();
      }
      
      public function getJLTimes4() : Number
      {
         return this.jl4_Times.getValue();
      }
      
      public function setWantedTaskSlot(param1:Number) : *
      {
         if(this._slot[param1] != null)
         {
            (this._slot[param1] as WantedTask).setState(1);
         }
      }
      
      public function getAccess() : Number
      {
         var _loc1_:int = 0;
         while(_loc1_ < 18)
         {
            if(this._slot[_loc1_] != null)
            {
               if((this._slot[_loc1_] as WantedTask).getState() == 1 || (this._slot[_loc1_] as WantedTask).getState() == 2)
               {
                  return _loc1_;
               }
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function getISCD() : Number
      {
         var _loc1_:int = 0;
         while(_loc1_ < 18)
         {
            if(this._slot[_loc1_] != null)
            {
               if((this._slot[_loc1_] as WantedTask).getState() == 3)
               {
                  return _loc1_;
               }
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function delCD(param1:Number) : *
      {
         if(this._slot[param1] != null)
         {
            if((this._slot[param1] as WantedTask).getState() == 3)
            {
               (this._slot[param1] as WantedTask).setState(0);
            }
         }
      }
      
      public function getBoss() : Number
      {
         var _loc1_:int = 0;
         while(_loc1_ < 18)
         {
            if(this._slot[_loc1_] != null)
            {
               if((this._slot[_loc1_] as WantedTask).getState() == 1)
               {
                  if(Main.gameNum.getValue() == (this._slot[_loc1_] as WantedTask).getMap1() || (this._slot[_loc1_] as WantedTask).getMap2() == Main.gameNum.getValue() || (this._slot[_loc1_] as WantedTask).getMap3() == Main.gameNum.getValue())
                  {
                     trace("悬赏getBoss i = " + _loc1_);
                     return (this._slot[_loc1_] as WantedTask).getName();
                  }
               }
            }
            _loc1_++;
         }
         return -1;
      }
   }
}

