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
      
      public function WantedTaskSlot()
      {
         super();
      }
      
      public static function creatWantedTaskSlot() : WantedTaskSlot
      {
         var wts:WantedTaskSlot = new WantedTaskSlot();
         for(var i:int = 0; i < 9; i++)
         {
            wts._slot[i] = null;
         }
         wts.addToSlot(WantedFactory.creatWantedTask(1));
         wts.addToSlot(WantedFactory.creatWantedTask(2));
         wts.addToSlot(WantedFactory.creatWantedTask(3));
         wts.addToSlot(WantedFactory.creatWantedTask(4));
         wts.addToSlot(WantedFactory.creatWantedTask(5));
         wts.addToSlot(WantedFactory.creatWantedTask(6));
         return wts;
      }
      
      public function get slot() : Array
      {
         return _slot;
      }
      
      public function set slot(value:Array) : void
      {
         _slot = value;
      }
      
      public function get Times() : VT
      {
         return jl_Times;
      }
      
      public function set Times(value:VT) : void
      {
         jl_Times = value;
      }
      
      public function get Times2() : VT
      {
         return jl2_Times;
      }
      
      public function set Times2(value:VT) : void
      {
         jl2_Times = value;
      }
      
      public function getWantedTaskFromSlot(num:int) : WantedTask
      {
         if(_slot[num] == null)
         {
            addToSlot(WantedFactory.creatWantedTask(num + 1));
         }
         if(_slot[num] != null)
         {
            return _slot[num];
         }
         return null;
      }
      
      public function addToSlot(value:WantedTask) : Boolean
      {
         for(var i:uint = 0; i < 9; i++)
         {
            if(_slot[i] == null)
            {
               _slot[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function delSlot(num:Number) : WantedTask
      {
         var wt:WantedTask = null;
         if(_slot[num] != null)
         {
            wt = _slot[num];
            _slot[num] = null;
         }
         return wt;
      }
      
      public function wantedTaskComplete() : *
      {
         for(var i:int = 0; i < 9; i++)
         {
            if(_slot[i] != null)
            {
               if((_slot[i] as WantedTask).getState() == 1)
               {
                  (_slot[i] as WantedTask).setState(2);
                  (_slot[i] as WantedTask).addTimes();
               }
            }
         }
      }
      
      public function wantedTaskTimesLV1() : Number
      {
         var count:int = 0;
         for(var i:int = 0; i < 3; i++)
         {
            if(_slot[i] != null)
            {
               if((_slot[i] as WantedTask).getTimes() > 0)
               {
                  count += (_slot[i] as WantedTask).nowTimes();
               }
            }
         }
         return count;
      }
      
      public function wantedTaskTimesLV2() : Number
      {
         var count:int = 0;
         for(var i:int = 3; i < 6; i++)
         {
            if(_slot[i] != null)
            {
               if((_slot[i] as WantedTask).getTimes() > 0)
               {
                  count += (_slot[i] as WantedTask).nowTimes();
               }
            }
         }
         return count;
      }
      
      public function addJLTimes() : *
      {
         jl_Times.setValue(jl_Times.getValue() + 1);
      }
      
      public function addJLTimes2() : *
      {
         jl2_Times.setValue(jl2_Times.getValue() + 1);
      }
      
      public function getJLTimes() : Number
      {
         return jl_Times.getValue();
      }
      
      public function getJLTimes2() : Number
      {
         return jl2_Times.getValue();
      }
      
      public function setWantedTaskSlot(num:Number) : *
      {
         if(_slot[num] != null)
         {
            (_slot[num] as WantedTask).setState(1);
         }
      }
      
      public function getAccess() : Number
      {
         for(var i:int = 0; i < 9; i++)
         {
            if(_slot[i] != null)
            {
               if((_slot[i] as WantedTask).getState() == 1 || (_slot[i] as WantedTask).getState() == 2)
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      public function getISCD() : Number
      {
         for(var i:int = 0; i < 9; i++)
         {
            if(_slot[i] != null)
            {
               if((_slot[i] as WantedTask).getState() == 3)
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      public function delCD(num:Number) : *
      {
         if(_slot[num] != null)
         {
            if((_slot[num] as WantedTask).getState() == 3)
            {
               (_slot[num] as WantedTask).setState(0);
            }
         }
      }
      
      public function getBoss() : Number
      {
         for(var i:int = 0; i < 9; i++)
         {
            if(_slot[i] != null)
            {
               if((_slot[i] as WantedTask).getState() == 1)
               {
                  if(Main.gameNum.getValue() == (_slot[i] as WantedTask).getMap1() || (_slot[i] as WantedTask).getMap2() == Main.gameNum.getValue() || (_slot[i] as WantedTask).getMap3() == Main.gameNum.getValue())
                  {
                     return (_slot[i] as WantedTask).getName();
                  }
               }
            }
         }
         return -1;
      }
   }
}

