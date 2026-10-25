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
         var data:ComSlot = new ComSlot();
         data.initBag();
         return data;
      }
      
      private function initBag() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            this._bagArr[i] = -1;
            this._pointArr[i] = -1;
            this._whoBag[i] = -1;
         }
      }
      
      public function addBag(arr:Array, num:Number) : void
      {
         var equip:Equip = null;
         var gem:Gem = null;
         if(arr != null)
         {
            if(arr[0] is Equip)
            {
               equip = arr[0] as Equip;
               if(this._whoBag[0] == -1)
               {
                  this.addone(arr,num);
               }
               else if(this._whoBag[0] == 0)
               {
                  if(num == 0)
                  {
                     this.addTow(arr,num);
                  }
                  else if(num == 1)
                  {
                     this.changeSlot(arr,num);
                  }
               }
               else if(this._whoBag[0] == 1)
               {
                  if(num == 0)
                  {
                     this.addTow(arr,num);
                  }
                  else if(num == 1)
                  {
                     if(this._pointArr[0] == arr[1])
                     {
                        this.addone(arr,num);
                     }
                     else
                     {
                        trace("已装备位置不同_____________");
                        this.changeSlot(arr,num);
                     }
                  }
               }
            }
            else if(arr[0] is Gem)
            {
               gem = arr[0];
               if(this._bagArr[0] == -1)
               {
                  this.addone(arr,num);
               }
               else
               {
                  this.addTow(arr,num);
               }
            }
         }
      }
      
      private function addone(arr:Array, num:Number) : void
      {
         this._bagArr[0] = arr[0];
         this._pointArr[0] = arr[1];
         this._whoBag[0] = num;
      }
      
      private function addTow(arr:Array, num:Number) : void
      {
         this._bagArr[1] = arr[0];
         this._pointArr[1] = arr[1];
         this._whoBag[1] = num;
      }
      
      private function changeSlot(arr:Array, num:Number) : void
      {
         var id1:Number = Number((this.getObj(0)[0] as Equip).getId());
         var equip:Equip = arr[0] as Equip;
         if(ComData.towBo(equip.getId(),id1))
         {
            this.addTow(arr,num);
         }
         else
         {
            this.addone(arr,num);
         }
      }
      
      public function addFishSlot(ob:Object) : void
      {
         this._bagArr[3] = ob;
         this._pointArr[3] = -1;
         this._whoBag[3] = -1;
      }
      
      public function addHcSlot(ob:Object) : void
      {
         this._bagArr[2] = ob;
         this._pointArr[2] = -1;
         this._whoBag[2] = -1;
      }
      
      public function getObj(num:Number) : Array
      {
         var arr:Array = [];
         if(this._bagArr[num] != -1)
         {
            return [this._bagArr[num],this._pointArr[num],this._whoBag[num]];
         }
         return null;
      }
      
      public function clearOnly(num:Number) : void
      {
         if(this._bagArr[num] != -1)
         {
            this._bagArr[num] = -1;
            this._pointArr[num] = -1;
            this._whoBag[num] = -1;
         }
      }
      
      public function clearBag() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            this._bagArr[i] = -1;
            this._pointArr[i] = -1;
            this._whoBag[i] = -1;
         }
      }
      
      public function addTj(ob:Object) : Boolean
      {
         if(ComPosePanel.state == 0)
         {
            if(ob is Equip)
            {
               return true;
            }
         }
         else if(ComPosePanel.state == 1)
         {
            if(ob is Gem)
            {
               return true;
            }
         }
         return false;
      }
   }
}

