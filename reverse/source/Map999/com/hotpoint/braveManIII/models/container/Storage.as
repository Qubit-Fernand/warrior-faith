package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import src.*;
   import src.tool.*;
   
   public class Storage
   {
      
      private var _equipStorage:Array = new Array();
      
      private var _suppliesStorage:Array = new Array();
      
      private var _gemStorage:Array = new Array();
      
      private var _otherobjStorage:Array = new Array();
      
      public function Storage()
      {
         super();
      }
      
      public static function createStorage() : Storage
      {
         var st:Storage = new Storage();
         for(var i:int = 0; i < 35; i++)
         {
            st._equipStorage[i] = null;
            st._suppliesStorage[i] = null;
            st._gemStorage[i] = null;
            st._otherobjStorage[i] = null;
         }
         return st;
      }
      
      public function get equipStorage() : Array
      {
         return _equipStorage;
      }
      
      public function set equipStorage(value:Array) : void
      {
         _equipStorage = value;
      }
      
      public function get suppliesStorage() : Array
      {
         return _suppliesStorage;
      }
      
      public function set suppliesStorage(value:Array) : void
      {
         _suppliesStorage = value;
      }
      
      public function get gemStorage() : Array
      {
         return _gemStorage;
      }
      
      public function set gemStorage(value:Array) : void
      {
         _gemStorage = value;
      }
      
      public function get otherobjStorage() : Array
      {
         return _otherobjStorage;
      }
      
      public function set otherobjStorage(value:Array) : void
      {
         _otherobjStorage = value;
      }
      
      public function getEquipFromStorage(num:Number) : Equip
      {
         if(_equipStorage[num] != null)
         {
            return _equipStorage[num];
         }
         return null;
      }
      
      public function getSuppliesFromStorage(num:Number) : Supplies
      {
         if(_suppliesStorage[num] != null)
         {
            return _suppliesStorage[num];
         }
         return null;
      }
      
      public function getGemFromStorage(num:Number) : Gem
      {
         if(_gemStorage[num] != null)
         {
            return _gemStorage[num];
         }
         return null;
      }
      
      public function getOtherobjFromStorage(num:Number) : Otherobj
      {
         if(_otherobjStorage[num] != null)
         {
            return _otherobjStorage[num];
         }
         return null;
      }
      
      public function backEquipEmptyNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 35; i++)
         {
            if(_equipStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backSuppliesEmptyNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 35; i++)
         {
            if(_suppliesStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backGemEmptyNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 35; i++)
         {
            if(_gemStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backOtherEmptyNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 35; i++)
         {
            if(_otherobjStorage[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function canPutGemNum(gemId:Number) : uint
      {
         var n:uint = 0;
         var gem:Gem = GemFactory.creatGemById(gemId);
         var times:uint = gem.getTimes();
         var alltimes:uint = gem.getPileLimit();
         var num:uint = 0;
         for(var i:int = 0; i < 35; i++)
         {
            if(_gemStorage[i] == null)
            {
               num += alltimes;
            }
            else if(gem.compareGem(_gemStorage[i]) == true)
            {
               n = alltimes - _gemStorage[i].getTimes();
               num += n;
            }
         }
         return num;
      }
      
      public function canPutOtherNum(otherId:Number) : uint
      {
         var n:uint = 0;
         var oo:Otherobj = OtherFactory.creatOther(otherId);
         var times:uint = oo.getTimes();
         var alltimes:uint = oo.getPileLimit();
         var num:uint = 0;
         for(var i:int = 0; i < 35; i++)
         {
            if(_otherobjStorage[i] == null)
            {
               num += alltimes;
            }
            else if(oo.compareOtherobj(_otherobjStorage[i]) == true)
            {
               n = alltimes - _otherobjStorage[i].getTimes();
               num += n;
            }
         }
         return num;
      }
      
      public function addEquipStorage(value:Equip) : Boolean
      {
         for(var i:uint = 0; i < 35; i++)
         {
            if(_equipStorage[i] == null)
            {
               _equipStorage[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addToEquipStorage(value:Equip, num:Number) : *
      {
         _equipStorage[num] = value;
      }
      
      public function addSuppliesStorage(value:Supplies) : Boolean
      {
         for(var i:uint = 0; i < 35; i++)
         {
            if(_suppliesStorage[i] == null)
            {
               _suppliesStorage[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addToSuppliesStorage(value:Supplies, num:Number) : *
      {
         _suppliesStorage[num] = value;
      }
      
      public function addGemStorage(value:Gem) : Boolean
      {
         var temp:int = 0;
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.getIsPile() != true)
         {
            i = 0;
            while(true)
            {
               if(i < 35)
               {
                  if(_gemStorage[i] == null)
                  {
                     break;
                  }
                  i++;
                  continue;
               }
            }
            _gemStorage[i] = value;
            return true;
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
      
      public function addToGemStorage(value:Gem, num:Number) : *
      {
         _gemStorage[num] = value;
      }
      
      public function addOtherobjStorage(value:Otherobj) : Boolean
      {
         var temp:int = 0;
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.isMany() != true)
         {
            i = 0;
            while(true)
            {
               if(i < 35)
               {
                  if(_otherobjStorage[i] == null)
                  {
                     break;
                  }
                  i++;
                  continue;
               }
            }
            _otherobjStorage[i] = value;
            return true;
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
      
      public function addToOtherobjStorage(value:Otherobj, num:Number) : *
      {
         _otherobjStorage[num] = value;
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
            else if(_gemStorage[end].getIsPile() == true && Boolean(_gemStorage[end].compareGem(_gemStorage[begin])))
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
            else if(_otherobjStorage[end].isMany() == true && Boolean(_otherobjStorage[end].compareOtherobj(_otherobjStorage[begin])))
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
      
      public function cheatTesting() : *
      {
         if(Main.NoLogInfo[4])
         {
            return;
         }
         for(var i:uint = 0; i < 35; i++)
         {
            if(_gemStorage[i] != null)
            {
               if((_gemStorage[i] as Gem).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(_gemStorage[i] as Gem).getTimes());
                  break;
               }
               if((_gemStorage[i] as Gem).getId() == 33213)
               {
                  if((_gemStorage[i] as Gem).getTimes() > 110)
                  {
                     SaveXX.Save(4,(_gemStorage[i] as Gem).getTimes());
                     break;
                  }
               }
            }
            if(_otherobjStorage[i] != null)
            {
               if((_otherobjStorage[i] as Otherobj).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(_otherobjStorage[i] as Otherobj).getTimes());
                  break;
               }
            }
         }
      }
      
      public function cheatGem() : *
      {
         var j:uint = 0;
         for(var i:uint = 0; i < 34; i++)
         {
            for(j = i + 1; j < 35; j++)
            {
               if(_gemStorage[i])
               {
                  (_gemStorage[i] as Gem)._gemStorage(_gemBag[j]);
               }
            }
         }
      }
   }
}

