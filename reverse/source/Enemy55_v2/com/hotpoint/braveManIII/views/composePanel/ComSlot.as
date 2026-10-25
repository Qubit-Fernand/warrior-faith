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
            _bagArr[_loc1_] = -1;
            _pointArr[_loc1_] = -1;
            _whoBag[_loc1_] = -1;
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
               if(_whoBag[0] == -1)
               {
                  addone(param1,param2);
               }
               else if(_whoBag[0] == 0)
               {
                  if(param2 == 0)
                  {
                     addTow(param1,param2);
                  }
                  else if(param2 == 1)
                  {
                     changeSlot(param1,param2);
                  }
               }
               else if(_whoBag[0] == 1)
               {
                  if(param2 == 0)
                  {
                     addTow(param1,param2);
                  }
                  else if(param2 == 1)
                  {
                     if(_pointArr[0] == param1[1])
                     {
                        addone(param1,param2);
                     }
                     else
                     {
                        trace("已装备位置不同_____________");
                        changeSlot(param1,param2);
                     }
                  }
               }
            }
            else if(param1[0] is Gem)
            {
               _loc4_ = param1[0];
               if(_bagArr[0] == -1)
               {
                  addone(param1,param2);
               }
               else
               {
                  addTow(param1,param2);
               }
            }
         }
      }
      
      private function addone(param1:Array, param2:Number) : void
      {
         _bagArr[0] = param1[0];
         _pointArr[0] = param1[1];
         _whoBag[0] = param2;
      }
      
      private function addTow(param1:Array, param2:Number) : void
      {
         _bagArr[1] = param1[0];
         _pointArr[1] = param1[1];
         _whoBag[1] = param2;
      }
      
      private function changeSlot(param1:Array, param2:Number) : void
      {
         var _loc3_:Number = Number((getObj(0)[0] as Equip).getId());
         var _loc4_:Equip = param1[0] as Equip;
         if(ComData.towBo(_loc4_.getId(),_loc3_))
         {
            addTow(param1,param2);
         }
         else
         {
            addone(param1,param2);
         }
      }
      
      public function addFishSlot(param1:Object) : void
      {
         _bagArr[3] = param1;
         _pointArr[3] = -1;
         _whoBag[3] = -1;
      }
      
      public function addHcSlot(param1:Object) : void
      {
         _bagArr[2] = param1;
         _pointArr[2] = -1;
         _whoBag[2] = -1;
      }
      
      public function getObj(param1:Number) : Array
      {
         var _loc2_:Array = [];
         if(_bagArr[param1] != -1)
         {
            return [_bagArr[param1],_pointArr[param1],_whoBag[param1]];
         }
         return null;
      }
      
      public function clearOnly(param1:Number) : void
      {
         if(_bagArr[param1] != -1)
         {
            _bagArr[param1] = -1;
            _pointArr[param1] = -1;
            _whoBag[param1] = -1;
         }
      }
      
      public function clearBag() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            _bagArr[_loc1_] = -1;
            _pointArr[_loc1_] = -1;
            _whoBag[_loc1_] = -1;
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

