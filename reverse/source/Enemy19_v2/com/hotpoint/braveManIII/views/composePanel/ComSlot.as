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
            _bagArr[i] = -1;
            _pointArr[i] = -1;
            _whoBag[i] = -1;
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
               if(_whoBag[0] == -1)
               {
                  addone(arr,num);
               }
               else if(_whoBag[0] == 0)
               {
                  if(num == 0)
                  {
                     addTow(arr,num);
                  }
                  else if(num == 1)
                  {
                     changeSlot(arr,num);
                  }
               }
               else if(_whoBag[0] == 1)
               {
                  if(num == 0)
                  {
                     addTow(arr,num);
                  }
                  else if(num == 1)
                  {
                     if(_pointArr[0] == arr[1])
                     {
                        addone(arr,num);
                     }
                     else
                     {
                        changeSlot(arr,num);
                     }
                  }
               }
            }
            else if(arr[0] is Gem)
            {
               gem = arr[0];
               if(_bagArr[0] == -1)
               {
                  addone(arr,num);
               }
               else
               {
                  addTow(arr,num);
               }
            }
         }
      }
      
      private function addone(arr:Array, num:Number) : void
      {
         _bagArr[0] = arr[0];
         _pointArr[0] = arr[1];
         _whoBag[0] = num;
      }
      
      private function addTow(arr:Array, num:Number) : void
      {
         _bagArr[1] = arr[0];
         _pointArr[1] = arr[1];
         _whoBag[1] = num;
      }
      
      private function changeSlot(arr:Array, num:Number) : void
      {
         var id1:Number = Number((getObj(0)[0] as Equip).getId());
         var equip:Equip = arr[0] as Equip;
         if(ComData.towBo(equip.getId(),id1))
         {
            addTow(arr,num);
         }
         else
         {
            addone(arr,num);
         }
      }
      
      public function addFishSlot(ob:Object) : void
      {
         _bagArr[3] = ob;
         _pointArr[3] = -1;
         _whoBag[3] = -1;
      }
      
      public function addHcSlot(ob:Object) : void
      {
         _bagArr[2] = ob;
         _pointArr[2] = -1;
         _whoBag[2] = -1;
      }
      
      public function getObj(num:Number) : Array
      {
         var arr:Array = [];
         if(_bagArr[num] != -1)
         {
            return [_bagArr[num],_pointArr[num],_whoBag[num]];
         }
         return null;
      }
      
      public function clearOnly(num:Number) : void
      {
         if(_bagArr[num] != -1)
         {
            _bagArr[num] = -1;
            _pointArr[num] = -1;
            _whoBag[num] = -1;
         }
      }
      
      public function clearBag() : void
      {
         for(var i:uint = 0; i < 4; i++)
         {
            _bagArr[i] = -1;
            _pointArr[i] = -1;
            _whoBag[i] = -1;
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

