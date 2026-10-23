package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import flash.utils.*;
   
   public class Storage
   {
      
      private var _equipStorage:Array = new Array();
      
      private var _gemStorage:Array = new Array();
      
      private var _otherobjStorage:Array = new Array();
      
      private var _suppliesStorage:Array = new Array();
      
      public function Storage()
      {
         super();
      }
      
      public static function createStorage() : Storage
      {
         var st:Storage = null;
         var i:int = 0;
         st = new Storage();
         for(i = 0; i < 35; i++)
         {
            st._equipStorage[i] = null;
            st._suppliesStorage[i] = null;
            st._gemStorage[i] = null;
            st._otherobjStorage[i] = null;
         }
         return st;
      }
      
      public function backOtherEmptyNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 35; i++)
         {
            if(_otherobjStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function delGem(num:Number, times:Number) : Gem
      {
         var gem:Gem = null;
         gem = _gemStorage[num];
         if(gem.getIsPile() == true)
         {
            gem.useGem(times);
            if(gem.getTimes() == 0)
            {
               _gemStorage[num] = null;
            }
         }
         else
         {
            _gemStorage[num] = null;
         }
         return gem.cloneGem(times);
      }
      
      public function otherobjStorageMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Otherobj = null;
         if(begin != end)
         {
            if(_otherobjStorage[end] == null)
            {
               _otherobjStorage[end] = _otherobjStorage[begin];
               _otherobjStorage[begin] = null;
            }
            else if(_otherobjStorage[end].isMany() == true && _otherobjStorage[end].getName() == _otherobjStorage[begin].getName())
            {
               if(_otherobjStorage[end].getTimes() < _otherobjStorage[end].getPileLimit())
               {
                  tt = _otherobjStorage[end].getTimes() + _otherobjStorage[begin].getTimes();
                  if(tt > _otherobjStorage[end].getPileLimit())
                  {
                     _otherobjStorage[begin].useOtherobj(_otherobjStorage[end].getPileLimit() - _otherobjStorage[end].getTimes());
                     _otherobjStorage[end].addOtherobj(_otherobjStorage[end].getPileLimit() - _otherobjStorage[end].getTimes());
                  }
                  else
                  {
                     _otherobjStorage[end].addOtherobj(_otherobjStorage[begin].getTimes());
                     _otherobjStorage[begin] = null;
                  }
               }
            }
            else
            {
               temp = _otherobjStorage[end];
               _otherobjStorage[end] = _otherobjStorage[begin];
               _otherobjStorage[begin] = temp;
            }
         }
      }
      
      public function backGemEmptyNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 35; i++)
         {
            if(_gemStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function addSuppliesStorage(value:Supplies) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 35; i++)
         {
            if(_suppliesStorage[i] == null)
            {
               _suppliesStorage[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addToEquipStorage(value:Equip, num:Number) : *
      {
         _equipStorage[num] = value;
      }
      
      public function addToSuppliesStorage(value:Supplies, num:Number) : *
      {
         _suppliesStorage[num] = value;
      }
      
      public function getOtherobjFromStorage(num:Number) : Otherobj
      {
         if(_otherobjStorage[num] != null)
         {
            return _otherobjStorage[num];
         }
         return null;
      }
      
      public function getEquipFromStorage(num:Number) : Equip
      {
         if(_equipStorage[num] != null)
         {
            return _equipStorage[num];
         }
         return null;
      }
      
      public function set gemStorage(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemStorage = value;
      }
      
      public function delOtherobj(num:Number, times:Number) : Otherobj
      {
         var oo:Otherobj = null;
         oo = _otherobjStorage[num];
         if(oo.isMany() == true)
         {
            oo.useOtherobj(times);
            if(oo.getTimes() == 0)
            {
               _otherobjStorage[num] = null;
            }
         }
         else
         {
            _otherobjStorage[num] = null;
         }
         return oo.cloneOtherobj(times);
      }
      
      public function set suppliesStorage(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesStorage = value;
      }
      
      public function set equipStorage(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _equipStorage = value;
      }
      
      public function getGemFromStorage(num:Number) : Gem
      {
         if(_gemStorage[num] != null)
         {
            return _gemStorage[num];
         }
         return null;
      }
      
      public function addToGemStorage(value:Gem, num:Number) : *
      {
         _gemStorage[num] = value;
      }
      
      public function backEquipEmptyNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 35; i++)
         {
            if(_equipStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function get otherobjStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _otherobjStorage;
      }
      
      public function gemStorageMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Gem = null;
         if(begin != end)
         {
            if(_gemStorage[end] == null)
            {
               _gemStorage[end] = _gemStorage[begin];
               _gemStorage[begin] = null;
            }
            else if(_gemStorage[end].getIsPile() == true && _gemStorage[end].getName() == _gemStorage[begin].getName())
            {
               if(_gemStorage[end].getTimes() < _gemStorage[end].getPileLimit())
               {
                  tt = _gemStorage[end].getTimes() + _gemStorage[begin].getTimes();
                  if(tt > _gemStorage[end].getPileLimit())
                  {
                     _gemStorage[begin].useGem(_gemStorage[end].getPileLimit() - _gemStorage[end].getTimes());
                     _gemStorage[end].addGem(_gemStorage[end].getPileLimit() - _gemStorage[end].getTimes());
                  }
                  else
                  {
                     _gemStorage[end].addGem(_gemStorage[begin].getTimes());
                     _gemStorage[begin] = null;
                  }
               }
            }
            else
            {
               temp = _gemStorage[end];
               _gemStorage[end] = _gemStorage[begin];
               _gemStorage[begin] = temp;
            }
         }
      }
      
      public function delEquip(num:Number) : Equip
      {
         var eq:Equip = null;
         if(_equipStorage[num] != null)
         {
            eq = _equipStorage[num];
            _equipStorage[num] = null;
         }
         return eq;
      }
      
      public function suppliesStorageMove(begin:Number, end:Number) : *
      {
         var temp:Supplies = null;
         if(_suppliesStorage[end] == null)
         {
            _suppliesStorage[end] = _suppliesStorage[begin];
            _suppliesStorage[begin] = null;
         }
         else
         {
            temp = _suppliesStorage[end];
            _suppliesStorage[end] = _suppliesStorage[begin];
            _suppliesStorage[begin] = temp;
         }
      }
      
      public function set otherobjStorage(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _otherobjStorage = value;
      }
      
      public function get equipStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _equipStorage;
      }
      
      public function get gemStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemStorage;
      }
      
      public function backSuppliesEmptyNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 35; i++)
         {
            if(_suppliesStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function getSuppliesFromStorage(num:Number) : Supplies
      {
         if(_suppliesStorage[num] != null)
         {
            return _suppliesStorage[num];
         }
         return null;
      }
      
      public function addEquipStorage(value:Equip) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 35; i++)
         {
            if(_equipStorage[i] == null)
            {
               _equipStorage[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addGemStorage(value:Gem) : Boolean
      {
         var temp:int = 0;
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.getIsPile() != true)
         {
            i = 0;
            while(i < 35)
            {
               if(_gemStorage[i] == null)
               {
                  _gemStorage[i] = value;
                  return true;
               }
               i++;
            }
            return false;
         }
         temp = -1;
         isSameIn = true;
         for(i = 0; i < 35; i++)
         {
            if(_gemStorage[i] != null)
            {
               if(_gemStorage[i].compareGem(value) == true)
               {
                  while(value.getTimes() > 0 && _gemStorage[i].getTimes() < value.getPileLimit())
                  {
                     _gemStorage[i].addGem(1);
                     value.useGem(1);
                  }
                  if(value.getTimes() == 0)
                  {
                     break;
                  }
               }
            }
            else if(temp == -1)
            {
               temp = i;
            }
         }
         if(value.getTimes() > 0)
         {
            _gemStorage[temp] = value;
         }
         return false;
      }
      
      public function get suppliesStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesStorage;
      }
      
      public function addToOtherobjStorage(value:Otherobj, num:Number) : *
      {
         _otherobjStorage[num] = value;
      }
      
      public function addOtherobjStorage(value:Otherobj) : Boolean
      {
         var temp:int = 0;
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.isMany() != true)
         {
            i = 0;
            while(i < 35)
            {
               if(_otherobjStorage[i] == null)
               {
                  _otherobjStorage[i] = value;
                  return true;
               }
               i++;
            }
            return false;
         }
         temp = -1;
         isSameIn = true;
         for(i = 0; i < 35; i++)
         {
            if(_otherobjStorage[i] != null)
            {
               if(_otherobjStorage[i].compareOtherobj(value) == true)
               {
                  while(value.getTimes() > 0 && _otherobjStorage[i].getTimes() < value.getPileLimit())
                  {
                     _otherobjStorage[i].addOtherobj(1);
                     value.useOtherobj(1);
                  }
                  if(value.getTimes() == 0)
                  {
                     break;
                  }
               }
            }
            else if(temp == -1)
            {
               temp = i;
            }
         }
         if(value.getTimes() > 0)
         {
            _otherobjStorage[temp] = value;
         }
         return false;
      }
      
      public function equipStorageMove(begin:Number, end:Number) : *
      {
         var temp:Equip = null;
         if(_equipStorage[end] == null)
         {
            _equipStorage[end] = _equipStorage[begin];
            _equipStorage[begin] = null;
         }
         else
         {
            temp = _equipStorage[end];
            _equipStorage[end] = _equipStorage[begin];
            _equipStorage[begin] = temp;
         }
      }
      
      public function delSupplies(num:Number) : Supplies
      {
         var su:Supplies = null;
         if(_suppliesStorage[num] != null)
         {
            su = _suppliesStorage[num];
            _suppliesStorage[num] = null;
         }
         return su;
      }
   }
}

