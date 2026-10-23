package com.hotpoint.braveManIII.views.strPanel
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   
   public class StrSlot
   {
      
      private var _bagArr:Array = [];
      
      private var _pointArr:Array = [];
      
      private var _whoBag:Array = [];
      
      public function StrSlot()
      {
         super();
      }
      
      public static function creatSlot() : StrSlot
      {
         var _loc1_:StrSlot = new StrSlot();
         _loc1_.initBag();
         return _loc1_;
      }
      
      private function initBag() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            this._bagArr[_loc1_] = -1;
            this._pointArr[_loc1_] = -1;
            this._whoBag[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function addBag(param1:Array, param2:Number) : void
      {
         if(param1 != null)
         {
            if(param1[0] is Equip)
            {
               this._bagArr[0] = param1[0];
               this._pointArr[0] = param1[1];
               this._whoBag[0] = param2;
            }
            else if(param1[0] is Gem)
            {
               if((param1[0] as Gem).getType() == 4)
               {
                  this._bagArr[0] = param1[0];
                  this._pointArr[0] = param1[1];
                  this._whoBag[0] = param2;
               }
               else if((param1[0] as Gem).getType() == 1 || (param1[0] as Gem).getType() == 0)
               {
                  this._bagArr[1] = param1[0];
                  this._pointArr[1] = param1[1];
                  this._whoBag[1] = param2;
               }
               else if((param1[0] as Gem).getType() == 2)
               {
                  this._bagArr[2] = param1[0];
                  this._pointArr[2] = param1[1];
                  this._whoBag[2] = param2;
               }
            }
         }
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
         while(_loc1_ < 3)
         {
            this._bagArr[_loc1_] = -1;
            this._pointArr[_loc1_] = -1;
            this._whoBag[_loc1_] = -1;
            _loc1_++;
         }
      }
      
      public function addTj(param1:Object) : Boolean
      {
         if(StrPanel.state == 0)
         {
            if(StrPanel.stateTow == 0)
            {
               if(param1 is Equip)
               {
                  return this.equipTj(param1 as Equip);
               }
            }
            else if(StrPanel.stateTow == 1)
            {
               if(param1 is Gem)
               {
                  return this.strGemTj(param1 as Gem);
               }
               if(param1 is Equip)
               {
                  return this.equipTj(param1 as Equip);
               }
            }
         }
         else if(StrPanel.state == 1)
         {
            if(StrPanel.stateTow == 0)
            {
               if(param1 is Gem)
               {
                  return this.gemTj(param1 as Gem);
               }
            }
            else if(StrPanel.stateTow == 1)
            {
               if(param1 is Gem)
               {
                  if((param1 as Gem).getType() == 4)
                  {
                     return this.gemTj(param1 as Gem);
                  }
                  return true;
               }
            }
         }
         return false;
      }
      
      private function strGemTj(param1:Gem) : Boolean
      {
         var _loc2_:Equip = (this.getObj(0) as Array)[0];
         if(param1.getType() == 1)
         {
            if(_loc2_.getReinforceLevel() < param1.getUseLevel())
            {
               return true;
            }
         }
         else if(param1.getType() == 2)
         {
            return true;
         }
         ShortTip.open(24);
         return false;
      }
      
      private function equipTj(param1:Equip) : Boolean
      {
         if(param1.getDressLevel() < 50)
         {
            if(param1.getReinforceLevel() < 6)
            {
               return true;
            }
         }
         else if(param1.getColor() == 1 || param1.getColor() == 2)
         {
            if(param1.getReinforceLevel() < 6)
            {
               return true;
            }
         }
         else if(param1.getReinforceLevel() < 10)
         {
            return true;
         }
         ShortTip.open(5);
         return false;
      }
      
      private function gemTj(param1:Gem, param2:Boolean = true) : Boolean
      {
         trace("技能石强化等级:" + param1.getStrengthenLevel(),4);
         if(param1.getStrengthenLevel() < 4)
         {
            return true;
         }
         ShortTip.open(5);
         return false;
      }
   }
}

