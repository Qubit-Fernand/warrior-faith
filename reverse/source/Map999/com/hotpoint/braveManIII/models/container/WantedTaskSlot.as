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
         var wts:WantedTaskSlot = new WantedTaskSlot();
         for(var i:int = 0; i < 9; i++)
         {
            wts._slot[i] = null;
         }
         wts.addToSlot(WantedFactory.creatWantedTask(1));
         wts.addToSlot(WantedFactory.creatWantedTask(2));
         wts.addToSlot(WantedFactory.creatWantedTask(3));
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
      
      public function getWantedTaskFromSlot(num:Number) : WantedTask
      {
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
      
      public function wantedTaskTimes() : Number
      {
         var count:int = 0;
         for(var i:int = 0; i < 9; i++)
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
      
      public function getJLTimes() : Number
      {
         return jl_Times.getValue();
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
         var i:int = 0;
         if(Main.gameNum.getValue() == (_slot[i] as WantedTask).getMap1() || (_slot[i] as WantedTask).getMap2() == Main.gameNum.getValue() || (_slot[i] as WantedTask).getMap3() == Main.gameNum.getValue())
         {
            for(i = 0; i < 9; i++)
            {
               if(_slot[i] != null)
               {
                  if((_slot[i] as WantedTask).getState() == 1)
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

