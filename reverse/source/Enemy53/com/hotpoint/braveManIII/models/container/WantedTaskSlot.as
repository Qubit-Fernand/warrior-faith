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
         var wts:WantedTaskSlot = new WantedTaskSlot();
         for(var i:int = 0; i < 18; i++)
         {
            wts._slot[i] = null;
         }
         wts.addToSlot(WantedFactory.creatWantedTask(1));
         wts.addToSlot(WantedFactory.creatWantedTask(2));
         wts.addToSlot(WantedFactory.creatWantedTask(3));
         wts.addToSlot(WantedFactory.creatWantedTask(4));
         wts.addToSlot(WantedFactory.creatWantedTask(5));
         wts.addToSlot(WantedFactory.creatWantedTask(6));
         wts.addToSlot(WantedFactory.creatWantedTask(7));
         wts.addToSlot(WantedFactory.creatWantedTask(8));
         wts.addToSlot(WantedFactory.creatWantedTask(9));
         wts.addToSlot(WantedFactory.creatWantedTask(10));
         wts.addToSlot(WantedFactory.creatWantedTask(11));
         wts.addToSlot(WantedFactory.creatWantedTask(12));
         return wts;
      }
      
      public function get slot() : Array
      {
         return this._slot;
      }
      
      public function set slot(value:Array) : void
      {
         this._slot = value;
      }
      
      public function get Times() : VT
      {
         return this.jl_Times;
      }
      
      public function set Times(value:VT) : void
      {
         this.jl_Times = value;
      }
      
      public function get Times2() : VT
      {
         return this.jl2_Times;
      }
      
      public function set Times2(value:VT) : void
      {
         this.jl2_Times = value;
      }
      
      public function get Times3() : VT
      {
         return this.jl3_Times;
      }
      
      public function set Times3(value:VT) : void
      {
         this.jl3_Times = value;
      }
      
      public function get Times4() : VT
      {
         return this.jl4_Times;
      }
      
      public function set Times4(value:VT) : void
      {
         this.jl4_Times = value;
      }
      
      public function getWantedTaskFromSlot(num:int) : WantedTask
      {
         if(this._slot[num] == null)
         {
            this.addToSlot(WantedFactory.creatWantedTask(num + 1));
         }
         else if(Boolean(this._slot[3]) && Boolean(this._slot[4]) && this._slot[3].getFrame() == this._slot[4].getFrame())
         {
            this._slot[3] = WantedFactory.creatWantedTask(4);
         }
         if(this._slot[num] != null)
         {
            return this._slot[num];
         }
         return null;
      }
      
      public function addToSlot(value:WantedTask) : Boolean
      {
         for(var i:uint = 0; i < 18; i++)
         {
            if(this._slot[i] == null)
            {
               this._slot[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function delSlot(num:Number) : WantedTask
      {
         var wt:WantedTask = null;
         if(this._slot[num] != null)
         {
            wt = this._slot[num];
            this._slot[num] = null;
         }
         return wt;
      }
      
      public function wantedTaskComplete() : *
      {
         for(var i:int = 0; i < 18; i++)
         {
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getState() == 1)
               {
                  (this._slot[i] as WantedTask).setState(2);
                  (this._slot[i] as WantedTask).addTimes();
               }
            }
         }
      }
      
      public function wantedTaskTimesLV1() : Number
      {
         var count:int = 0;
         for(var i:int = 0; i < 3; i++)
         {
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getTimes() > 0)
               {
                  count += (this._slot[i] as WantedTask).nowTimes();
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
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getTimes() > 0)
               {
                  count += (this._slot[i] as WantedTask).nowTimes();
               }
            }
         }
         return count;
      }
      
      public function wantedTaskTimesLV3() : Number
      {
         var count:int = 0;
         for(var i:int = 6; i < 9; i++)
         {
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getTimes() > 0)
               {
                  count += (this._slot[i] as WantedTask).nowTimes();
               }
            }
         }
         return count;
      }
      
      public function wantedTaskTimesLV4() : Number
      {
         var count:int = 0;
         for(var i:int = 9; i < 12; i++)
         {
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getTimes() > 0)
               {
                  count += (this._slot[i] as WantedTask).nowTimes();
               }
            }
         }
         return count;
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
      
      public function setWantedTaskSlot(num:Number) : *
      {
         if(this._slot[num] != null)
         {
            (this._slot[num] as WantedTask).setState(1);
         }
      }
      
      public function getAccess() : Number
      {
         for(var i:int = 0; i < 18; i++)
         {
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getState() == 1 || (this._slot[i] as WantedTask).getState() == 2)
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      public function getISCD() : Number
      {
         for(var i:int = 0; i < 18; i++)
         {
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getState() == 3)
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      public function delCD(num:Number) : *
      {
         if(this._slot[num] != null)
         {
            if((this._slot[num] as WantedTask).getState() == 3)
            {
               (this._slot[num] as WantedTask).setState(0);
            }
         }
      }
      
      public function getBoss() : Number
      {
         for(var i:int = 0; i < 18; i++)
         {
            if(this._slot[i] != null)
            {
               if((this._slot[i] as WantedTask).getState() == 1)
               {
                  if(Main.gameNum.getValue() == (this._slot[i] as WantedTask).getMap1() || (this._slot[i] as WantedTask).getMap2() == Main.gameNum.getValue() || (this._slot[i] as WantedTask).getMap3() == Main.gameNum.getValue())
                  {
                     return (this._slot[i] as WantedTask).getName();
                  }
               }
            }
         }
         return -1;
      }
   }
}

