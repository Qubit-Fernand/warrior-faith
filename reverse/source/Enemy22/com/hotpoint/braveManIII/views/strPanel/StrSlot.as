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
         var data:StrSlot = new StrSlot();
         data.initBag();
         return data;
      }
      
      private function initBag() : void
      {
         for(var i:uint = 0; i < 3; i++)
         {
            this._bagArr[i] = -1;
            this._pointArr[i] = -1;
            this._whoBag[i] = -1;
         }
      }
      
      public function addBag(arr:Array, num:Number) : void
      {
         if(arr != null)
         {
            if(arr[0] is Equip)
            {
               this._bagArr[0] = arr[0];
               this._pointArr[0] = arr[1];
               this._whoBag[0] = num;
            }
            else if(arr[0] is Gem)
            {
               if((arr[0] as Gem).getType() == 4)
               {
                  this._bagArr[0] = arr[0];
                  this._pointArr[0] = arr[1];
                  this._whoBag[0] = num;
               }
               else if((arr[0] as Gem).getType() == 1 || (arr[0] as Gem).getType() == 0)
               {
                  this._bagArr[1] = arr[0];
                  this._pointArr[1] = arr[1];
                  this._whoBag[1] = num;
               }
               else if((arr[0] as Gem).getType() == 2)
               {
                  this._bagArr[2] = arr[0];
                  this._pointArr[2] = arr[1];
                  this._whoBag[2] = num;
               }
            }
         }
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
         for(var i:uint = 0; i < 3; i++)
         {
            this._bagArr[i] = -1;
            this._pointArr[i] = -1;
            this._whoBag[i] = -1;
         }
      }
      
      public function addTj(ob:Object) : Boolean
      {
         if(StrPanel.state == 0)
         {
            if(StrPanel.stateTow == 0)
            {
               if(ob is Equip)
               {
                  return this.equipTj(ob as Equip);
               }
            }
            else if(StrPanel.stateTow == 1)
            {
               if(ob is Gem)
               {
                  return this.strGemTj(ob as Gem);
               }
               if(ob is Equip)
               {
                  return this.equipTj(ob as Equip);
               }
            }
         }
         else if(StrPanel.state == 1)
         {
            if(StrPanel.stateTow == 0)
            {
               if(ob is Gem)
               {
                  return this.gemTj(ob as Gem);
               }
            }
            else if(StrPanel.stateTow == 1)
            {
               if(ob is Gem)
               {
                  if((ob as Gem).getType() == 4)
                  {
                     return this.gemTj(ob as Gem);
                  }
                  return true;
               }
            }
         }
         return false;
      }
      
      private function strGemTj(gem:Gem) : Boolean
      {
         var equip:Equip = (this.getObj(0) as Array)[0];
         if(gem.getType() == 1)
         {
            if(equip.getReinforceLevel() < gem.getUseLevel())
            {
               return true;
            }
         }
         else if(gem.getType() == 2)
         {
            return true;
         }
         ShortTip.open(24);
         return false;
      }
      
      private function equipTj(equip:Equip) : Boolean
      {
         if(equip.getDressLevel() < 50)
         {
            if(equip.getReinforceLevel() < 6)
            {
               return true;
            }
         }
         else if(equip.getColor() == 1 || equip.getColor() == 2)
         {
            if(equip.getReinforceLevel() < 6)
            {
               return true;
            }
         }
         else if(equip.getReinforceLevel() < 10)
         {
            return true;
         }
         ShortTip.open(5);
         return false;
      }
      
      private function gemTj(gem:Gem, bo:Boolean = true) : Boolean
      {
         trace("技能石强化等级:" + gem.getStrengthenLevel(),4);
         if(gem.getStrengthenLevel() < 4)
         {
            return true;
         }
         ShortTip.open(5);
         return false;
      }
   }
}

