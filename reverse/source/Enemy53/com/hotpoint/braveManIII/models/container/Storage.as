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
         return this._equipStorage;
      }
      
      public function set equipStorage(value:Array) : void
      {
         this._equipStorage = value;
      }
      
      public function get suppliesStorage() : Array
      {
         return this._suppliesStorage;
      }
      
      public function set suppliesStorage(value:Array) : void
      {
         this._suppliesStorage = value;
      }
      
      public function get gemStorage() : Array
      {
         return this._gemStorage;
      }
      
      public function set gemStorage(value:Array) : void
      {
         this._gemStorage = value;
      }
      
      public function get otherobjStorage() : Array
      {
         return this._otherobjStorage;
      }
      
      public function set otherobjStorage(value:Array) : void
      {
         this._otherobjStorage = value;
      }
      
      public function getEquipFromStorage(num:Number) : Equip
      {
         if(this._equipStorage[num] != null)
         {
            return this._equipStorage[num];
         }
         return null;
      }
      
      public function getSuppliesFromStorage(num:Number) : Supplies
      {
         if(this._suppliesStorage[num] != null)
         {
            return this._suppliesStorage[num];
         }
         return null;
      }
      
      public function getGemFromStorage(num:Number) : Gem
      {
         if(this._gemStorage[num] != null)
         {
            return this._gemStorage[num];
         }
         return null;
      }
      
      public function getOtherobjFromStorage(num:Number) : Otherobj
      {
         if(this._otherobjStorage[num] != null)
         {
            return this._otherobjStorage[num];
         }
         return null;
      }
      
      public function backEquipEmptyNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 35; i++)
         {
            if(this._equipStorage[i] == null)
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
            if(this._suppliesStorage[i] == null)
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
            if(this._gemStorage[i] == null)
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
            if(this._otherobjStorage[i] == null)
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
            if(this._gemStorage[i] == null)
            {
               num += alltimes;
            }
            else if(gem.compareGem(this._gemStorage[i]) == true)
            {
               n = alltimes - this._gemStorage[i].getTimes();
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
            if(this._otherobjStorage[i] == null)
            {
               num += alltimes;
            }
            else if(oo.compareOtherobj(this._otherobjStorage[i]) == true)
            {
               n = alltimes - this._otherobjStorage[i].getTimes();
               num += n;
            }
         }
         return num;
      }
      
      public function addEquipStorage(value:Equip) : Boolean
      {
         for(var i:uint = 0; i < 35; i++)
         {
            if(this._equipStorage[i] == null)
            {
               this._equipStorage[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addToEquipStorage(value:Equip, num:Number) : *
      {
         this._equipStorage[num] = value;
      }
      
      public function addSuppliesStorage(value:Supplies) : Boolean
      {
         for(var i:uint = 0; i < 35; i++)
         {
            if(this._suppliesStorage[i] == null)
            {
               this._suppliesStorage[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addToSuppliesStorage(value:Supplies, num:Number) : *
      {
         this._suppliesStorage[num] = value;
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
                  if(this._gemStorage[i] == null)
                  {
                     break;
                  }
                  i++;
                  continue;
               }
            }
            this._gemStorage[i] = value;
            return true;
         }
         temp = -1;
         isSameIn = true;
         for(i = 0; i < 35; i++)
         {
            if(this._gemStorage[i] != null)
            {
               if(this._gemStorage[i].compareGem(value) == true)
               {
                  while(value.getTimes() > 0 && this._gemStorage[i].getTimes() < value.getPileLimit())
                  {
                     this._gemStorage[i].addGem(1);
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
            this._gemStorage[temp] = value;
         }
         return false;
      }
      
      public function addToGemStorage(value:Gem, num:Number) : *
      {
         this._gemStorage[num] = value;
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
                  if(this._otherobjStorage[i] == null)
                  {
                     break;
                  }
                  i++;
                  continue;
               }
            }
            this._otherobjStorage[i] = value;
            return true;
         }
         temp = -1;
         isSameIn = true;
         for(i = 0; i < 35; i++)
         {
            if(this._otherobjStorage[i] != null)
            {
               if(this._otherobjStorage[i].compareOtherobj(value) == true)
               {
                  while(value.getTimes() > 0 && this._otherobjStorage[i].getTimes() < value.getPileLimit())
                  {
                     this._otherobjStorage[i].addOtherobj(1);
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
            this._otherobjStorage[temp] = value;
         }
         return false;
      }
      
      public function addToOtherobjStorage(value:Otherobj, num:Number) : *
      {
         this._otherobjStorage[num] = value;
      }
      
      public function delEquip(num:Number) : Equip
      {
         var eq:Equip = null;
         if(this._equipStorage[num] != null)
         {
            eq = this._equipStorage[num];
            this._equipStorage[num] = null;
         }
         return eq;
      }
      
      public function delSupplies(num:Number) : Supplies
      {
         var su:Supplies = null;
         if(this._suppliesStorage[num] != null)
         {
            su = this._suppliesStorage[num];
            this._suppliesStorage[num] = null;
         }
         return su;
      }
      
      public function delGem(num:Number, times:Number) : Gem
      {
         var gem:Gem = null;
         gem = this._gemStorage[num];
         if(gem.getIsPile() == true)
         {
            gem.useGem(times);
            if(gem.getTimes() == 0)
            {
               this._gemStorage[num] = null;
            }
         }
         else
         {
            this._gemStorage[num] = null;
         }
         return gem.cloneGem(times);
      }
      
      public function delOtherobj(num:Number, times:Number) : Otherobj
      {
         var oo:Otherobj = null;
         oo = this._otherobjStorage[num];
         if(oo.isMany() == true)
         {
            oo.useOtherobj(times);
            if(oo.getTimes() == 0)
            {
               this._otherobjStorage[num] = null;
            }
         }
         else
         {
            this._otherobjStorage[num] = null;
         }
         return oo.cloneOtherobj(times);
      }
      
      public function equipStorageMove(begin:Number, end:Number) : *
      {
         var temp:Equip = null;
         if(this._equipStorage[end] == null)
         {
            this._equipStorage[end] = this._equipStorage[begin];
            this._equipStorage[begin] = null;
         }
         else
         {
            temp = this._equipStorage[end];
            this._equipStorage[end] = this._equipStorage[begin];
            this._equipStorage[begin] = temp;
         }
      }
      
      public function suppliesStorageMove(begin:Number, end:Number) : *
      {
         var temp:Supplies = null;
         if(this._suppliesStorage[end] == null)
         {
            this._suppliesStorage[end] = this._suppliesStorage[begin];
            this._suppliesStorage[begin] = null;
         }
         else
         {
            temp = this._suppliesStorage[end];
            this._suppliesStorage[end] = this._suppliesStorage[begin];
            this._suppliesStorage[begin] = temp;
         }
      }
      
      public function gemStorageMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Gem = null;
         if(begin != end)
         {
            if(this._gemStorage[end] == null)
            {
               this._gemStorage[end] = this._gemStorage[begin];
               this._gemStorage[begin] = null;
            }
            else if(this._gemStorage[end].getIsPile() == true && Boolean(this._gemStorage[end].compareGem(this._gemStorage[begin])))
            {
               if(this._gemStorage[end].getTimes() < this._gemStorage[end].getPileLimit())
               {
                  tt = this._gemStorage[end].getTimes() + this._gemStorage[begin].getTimes();
                  if(tt > this._gemStorage[end].getPileLimit())
                  {
                     this._gemStorage[begin].useGem(this._gemStorage[end].getPileLimit() - this._gemStorage[end].getTimes());
                     this._gemStorage[end].addGem(this._gemStorage[end].getPileLimit() - this._gemStorage[end].getTimes());
                  }
                  else
                  {
                     this._gemStorage[end].addGem(this._gemStorage[begin].getTimes());
                     this._gemStorage[begin] = null;
                  }
               }
            }
            else
            {
               temp = this._gemStorage[end];
               this._gemStorage[end] = this._gemStorage[begin];
               this._gemStorage[begin] = temp;
            }
         }
      }
      
      public function otherobjStorageMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Otherobj = null;
         if(begin != end)
         {
            if(this._otherobjStorage[end] == null)
            {
               this._otherobjStorage[end] = this._otherobjStorage[begin];
               this._otherobjStorage[begin] = null;
            }
            else if(this._otherobjStorage[end].isMany() == true && Boolean(this._otherobjStorage[end].compareOtherobj(this._otherobjStorage[begin])))
            {
               if(this._otherobjStorage[end].getTimes() < this._otherobjStorage[end].getPileLimit())
               {
                  tt = this._otherobjStorage[end].getTimes() + this._otherobjStorage[begin].getTimes();
                  if(tt > this._otherobjStorage[end].getPileLimit())
                  {
                     this._otherobjStorage[begin].useOtherobj(this._otherobjStorage[end].getPileLimit() - this._otherobjStorage[end].getTimes());
                     this._otherobjStorage[end].addOtherobj(this._otherobjStorage[end].getPileLimit() - this._otherobjStorage[end].getTimes());
                  }
                  else
                  {
                     this._otherobjStorage[end].addOtherobj(this._otherobjStorage[begin].getTimes());
                     this._otherobjStorage[begin] = null;
                  }
               }
            }
            else
            {
               temp = this._otherobjStorage[end];
               this._otherobjStorage[end] = this._otherobjStorage[begin];
               this._otherobjStorage[begin] = temp;
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
            if(this._gemStorage[i] != null)
            {
               if((this._gemStorage[i] as Gem).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._gemStorage[i] as Gem).getTimes());
                  break;
               }
            }
            if(this._otherobjStorage[i] != null)
            {
               if((this._otherobjStorage[i] as Otherobj).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._otherobjStorage[i] as Otherobj).getTimes());
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
               if(this._gemStorage[i])
               {
                  (this._gemStorage[i] as Gem).testGem(this._gemStorage[j]);
               }
            }
         }
      }
      
      public function cheatOther() : *
      {
         var j:uint = 0;
         for(var i:uint = 0; i < 34; i++)
         {
            for(j = i + 1; j < 35; j++)
            {
               if(this._otherobjStorage[i])
               {
                  (this._otherobjStorage[i] as Otherobj).testOtherobj(this._otherobjStorage[j]);
               }
            }
         }
      }
   }
}

