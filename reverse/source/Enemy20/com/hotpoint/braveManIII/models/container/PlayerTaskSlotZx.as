package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.task.Task;
   
   public class PlayerTaskSlotZx
   {
      
      private var _slotArr:Array = [];
      
      public function PlayerTaskSlotZx()
      {
         super();
      }
      
      public static function creatSlot() : PlayerTaskSlotZx
      {
         var playerSlot:PlayerTaskSlotZx = new PlayerTaskSlotZx();
         playerSlot.initSlotArr();
         return playerSlot;
      }
      
      private function initSlotArr() : void
      {
         for(var i:uint = 0; i < 5; i++)
         {
            this._slotArr[i] = -1;
         }
      }
      
      public function getSlotArr() : Array
      {
         return this._slotArr;
      }
      
      public function addSlot(type:Task) : void
      {
         for(var i:uint = 0; i < 5; i++)
         {
            if(this._slotArr[i] == -1)
            {
               this._slotArr[i] = type;
               break;
            }
         }
      }
      
      public function getTask(num:Number) : Task
      {
         if(this._slotArr[num] != -1)
         {
            return this._slotArr[num];
         }
         return null;
      }
      
      public function clearTask(num:Number) : void
      {
         trace("清除:" + num);
         if(this._slotArr[num] != -1)
         {
            this._slotArr[num] = -1;
         }
      }
      
      public function allclearTask() : void
      {
         for(var i:uint = 0; i < 5; i++)
         {
            this._slotArr[i] = -1;
         }
      }
   }
}

