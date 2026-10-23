package com.hotpoint.braveManIII.views.composePanel
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   
   public class ComSlot
   {
      
      private var _bagArr:Array = [];
      
      private var _pointArr:Array = [];
      
      private var _whoBag:Array = [];
      
      public function ComSlot()
      {
         super();
      }
      
      public static function creatSlot() : ComSlot
      {
         var _loc1_:ComSlot = new ComSlot();
         _loc1_.initBag();
         return _loc1_;
      }
      
      private function initBag() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this._bagArr[_loc1_] = -1;
            this._pointArr[_loc1_] = -1;
            this._whoBag[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function addBag(param1:Array, param2:Number) : void
      {
         var _loc3_:Equip = null;
         var _loc4_:Gem = null;
         if(param1 != null)
         {
            if(param1[0] is Equip)
            {
               _loc3_ = param1[0] as Equip;
               if(this._whoBag[0] == -1)
               {
                  this.addone(param1,param2);
               }
               else if(this._whoBag[0] == 0)
               {
                  if(param2 == 0)
                  {
                     this.addTow(param1,param2);
                  }
                  else if(param2 == 1)
                  {
                     this.changeSlot(param1,param2);
                  }
               }
               else if(this._whoBag[0] == 1)
               {
                  if(param2 == 0)
                  {
                     this.addTow(param1,param2);
                  }
                  else if(param2 == 1)
                  {
                     if(this._pointArr[0] == param1[1])
                     {
                        this.addone(param1,param2);
                     }
                     else
                     {
                        trace("已装备位置不同_____________");
                        this.changeSlot(param1,param2);
                     }
                  }
               }
            }
            else if(param1[0] is Gem)
            {
               _loc4_ = param1[0];
               if(this._bagArr[0] == -1)
               {
                  this.addone(param1,param2);
               }
               else
               {
                  this.addTow(param1,param2);
               }
            }
         }
      }
      
      private function addone(param1:Array, param2:Number) : void
      {
         this._bagArr[0] = param1[0];
         this._pointArr[0] = param1[1];
         this._whoBag[0] = param2;
      }
      
      private function addTow(param1:Array, param2:Number) : void
      {
         this._bagArr[1] = param1[0];
         this._pointArr[1] = param1[1];
         this._whoBag[1] = param2;
      }
      
      private function changeSlot(param1:Array, param2:Number) : void
      {
         var _loc3_:Number = Number((this.getObj(0)[0] as Equip).getId());
         var _loc4_:Equip = param1[0] as Equip;
         if(ComData.towBo(_loc4_.getId(),_loc3_))
         {
            this.addTow(param1,param2);
         }
         else
         {
            this.addone(param1,param2);
         }
      }
      
      public function addFishSlot(param1:Object) : void
      {
         this._bagArr[3] = param1;
         this._pointArr[3] = -1;
         this._whoBag[3] = -1;
      }
      
      public function addHcSlot(param1:Object) : void
      {
         this._bagArr[2] = param1;
         this._pointArr[2] = -1;
         this._whoBag[2] = -1;
      }
      
      public function getObj(param1:Number) : Array
      {
         var _loc2_:Array = [];
         if(this._bagArr[param1] != -1)
         {
            return [this._bagArr[param1],this._pointArr[param1],this._whoBag[param1]];
         }
         return null;
      }
      
      public function clearOnly(param1:Number) : void
      {
         if(this._bagArr[param1] != -1)
         {
            this._bagArr[param1] = -1;
            this._pointArr[param1] = -1;
            this._whoBag[param1] = -1;
         }
      }
      
      public function clearBag() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            this._bagArr[_loc1_] = -1;
            this._pointArr[_loc1_] = -1;
            this._whoBag[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function addTj(param1:Object) : Boolean
      {
         if(ComPosePanel.state == 0)
         {
            if(param1 is Equip)
            {
               return true;
            }
         }
         else if(ComPosePanel.state == 1)
         {
            if(param1 is Gem)
            {
               return true;
            }
         }
         return false;
      }
   }
}

