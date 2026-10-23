package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.wantedTask.*;
   import com.hotpoint.braveManIII.repository.wantedTask.*;
   import src.*;
   
   public class WantedTaskSlot
   {
      
      private var _slot:Array = new Array();
      
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
      
      public function getWantedTaskFromSlot(param1:Number) : WantedTask
      {
         if(this._slot[param1] != null)
         {
            return this._slot[param1];
         }
         return null;
      }
      
      public function addToSlot(param1:WantedTask) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 9)
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
         while(_loc1_ < 9)
         {
            if(this._slot[_loc1_] != null)
            {
               if((this._slot[_loc1_] as WantedTask).getState() == 1)
               {
                  (this._slot[_loc1_] as WantedTask).setState(2);
               }
            }
            _loc1_++;
         }
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
         while(_loc1_ < 9)
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
         while(_loc1_ < 9)
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
         if(Main.gameNum.getValue() == (this._slot[_loc1_] as WantedTask).getMap1() || (this._slot[_loc1_] as WantedTask).getMap2() == Main.gameNum.getValue() || (this._slot[_loc1_] as WantedTask).getMap3() == Main.gameNum.getValue())
         {
            _loc1_ = 0;
            while(_loc1_ < 9)
            {
               if(this._slot[_loc1_] != null)
               {
                  if((this._slot[_loc1_] as WantedTask).getState() == 1)
                  {
                     return (this._slot[_loc1_] as WantedTask).getName();
                  }
               }
               _loc1_++;
            }
         }
         return -1;
      }
   }
}

