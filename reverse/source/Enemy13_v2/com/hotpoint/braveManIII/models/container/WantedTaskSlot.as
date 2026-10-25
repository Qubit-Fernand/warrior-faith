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
      
      public function WantedTaskSlot()
      {
         super();
      }
      
      public static function creatWantedTaskSlot() : WantedTaskSlot
      {
         var _loc1_:WantedTaskSlot = new WantedTaskSlot();
         var _loc2_:int = 0;
         while(_loc2_ < 9)
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
         return _loc1_;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(param1:Array) : void
      {
         _slot = param1;
      }
      
      public function get Times() : VT
      {
         return jl_Times;
      }
      
      public function set Times(param1:VT) : void
      {
         jl_Times = param1;
      }
      
      public function getWantedTaskFromSlot(param1:int) : WantedTask
      {
         if(_slot[param1] == null)
         {
            addToSlot(WantedFactory.creatWantedTask(param1 + 1));
         }
         if(_slot[param1] != null)
         {
            return _slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:WantedTask) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 9)
         {
            if(_slot[_loc2_] == null)
            {
               _slot[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function delSlot(param1:Number) : WantedTask
      {
         var _loc2_:WantedTask = null;
         if(_slot[param1] != null)
         {
            _loc2_ = _slot[param1];
            _slot[param1] = null;
         }
         return _loc2_;
      }
      
      public function wantedTaskComplete() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            if(_slot[_loc1_] != null)
            {
               if((_slot[_loc1_] as WantedTask).getState() == 1)
               {
                  (_slot[_loc1_] as WantedTask).setState(2);
                  (_slot[_loc1_] as WantedTask).addTimes();
               }
            }
            _loc1_++;
         }
      }
      
      public function wantedTaskTimes() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            if(_slot[_loc2_] != null)
            {
               if((_slot[_loc2_] as WantedTask).getTimes() > 0)
               {
                  _loc1_ += (_slot[_loc2_] as WantedTask).nowTimes();
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addJLTimes() : *
      {
         jl_Times.setValue(jl_Times.getValue() + 1);
      }
      
      public function getJLTimes() : Number
      {
         return jl_Times.getValue();
      }
      
      public function setWantedTaskSlot(param1:Number) : *
      {
         if(_slot[param1] != null)
         {
            (_slot[param1] as WantedTask).setState(1);
         }
      }
      
      public function getAccess() : Number
      {
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            if(_slot[_loc1_] != null)
            {
               if((_slot[_loc1_] as WantedTask).getState() == 1 || (_slot[_loc1_] as WantedTask).getState() == 2)
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
         while(_loc1_ < 9)
         {
            if(_slot[_loc1_] != null)
            {
               if((_slot[_loc1_] as WantedTask).getState() == 3)
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
         if(_slot[param1] != null)
         {
            if((_slot[param1] as WantedTask).getState() == 3)
            {
               (_slot[param1] as WantedTask).setState(0);
            }
         }
      }
      
      public function getBoss() : Number
      {
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            if(_slot[_loc1_] != null)
            {
               if((_slot[_loc1_] as WantedTask).getState() == 1)
               {
                  if(Main.gameNum.getValue() == (_slot[_loc1_] as WantedTask).getMap1() || (_slot[_loc1_] as WantedTask).getMap2() == Main.gameNum.getValue() || (_slot[_loc1_] as WantedTask).getMap3() == Main.gameNum.getValue())
                  {
                     trace("悬赏getBoss i = " + _loc1_);
                     return (_slot[_loc1_] as WantedTask).getName();
                  }
               }
            }
            _loc1_++;
         }
         return -1;
      }
   }
}

