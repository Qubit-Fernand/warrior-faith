package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.views.storagePanel.*;
   import src.*;
   import src.tool.*;
   
   public class Bag
   {
      
      private var _equipBag:Array = new Array();
      
      private var _suppliesBag:Array = new Array();
      
      private var _gemBag:Array = new Array();
      
      private var _questBag:Array = new Array();
      
      public var _otherobjBag:Array = new Array();
      
      public function Bag()
      {
         super();
      }
      
      public static function createBag() : Bag
      {
         var bg:Bag = new Bag();
         for(var i:int = 0; i < 24; i++)
         {
            bg._equipBag[i] = null;
            bg._suppliesBag[i] = null;
            bg._gemBag[i] = null;
            bg._questBag[i] = null;
            bg._otherobjBag[i] = null;
         }
         return bg;
      }
      
      public function get equipBag() : Array
      {
         return this._equipBag;
      }
      
      public function set equipBag(value:Array) : void
      {
         this._equipBag = value;
      }
      
      public function get suppliesBag() : Array
      {
         return this._suppliesBag;
      }
      
      public function set suppliesBag(value:Array) : void
      {
         this._suppliesBag = value;
      }
      
      public function get gemBag() : Array
      {
         return this._gemBag;
      }
      
      public function set gemBag(value:Array) : void
      {
         this._gemBag = value;
      }
      
      public function get questBag() : Array
      {
         return this._questBag;
      }
      
      public function set questBag(value:Array) : void
      {
         this._questBag = value;
      }
      
      public function get otherobjBag() : Array
      {
         return this._otherobjBag;
      }
      
      public function set otherobjBag(value:Array) : void
      {
         this._otherobjBag = value;
      }
      
      public function getEquipBag() : Array
      {
         return this._equipBag.slice();
      }
      
      public function getEquipFromBag(num:Number) : Equip
      {
         if(this._equipBag[num] != null && this._equipBag[num] is Equip)
         {
            return this._equipBag[num];
         }
         return null;
      }
      
      public function getSuppliesBag() : Array
      {
         return this._suppliesBag.slice();
      }
      
      public function getSuppliesFromBag(num:Number) : Supplies
      {
         if(this._suppliesBag[num] != null)
         {
            return this._suppliesBag[num];
         }
         return null;
      }
      
      public function getGemBag() : Array
      {
         return this._gemBag.slice();
      }
      
      public function getGemFromBag(num:Number) : Gem
      {
         if(this._gemBag[num] != null)
         {
            return this._gemBag[num];
         }
         return null;
      }
      
      public function getQuestBag() : Array
      {
         return this._questBag.slice();
      }
      
      public function getQuestFromBag(num:Number) : Quest
      {
         if(this._questBag[num] != null)
         {
            return this._questBag[num];
         }
         return null;
      }
      
      public function getOtherobjFromBag(num:Number) : Otherobj
      {
         if(this._otherobjBag[num] != null)
         {
            return this._otherobjBag[num];
         }
         return null;
      }
      
      public function getOtherobjBag() : Array
      {
         return this._otherobjBag.slice();
      }
      
      public function addEquipBag(value:Equip) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._equipBag[i] == null)
            {
               this._equipBag[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addToEquipBag(value:Equip, num:Number) : Boolean
      {
         if(this._equipBag[num] == null)
         {
            this._equipBag[num] = value;
            return true;
         }
         return false;
      }
      
      public function addSuppliesBag(value:Supplies) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._suppliesBag[i] == null)
            {
               this._suppliesBag[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function addToSuppliesBag(value:Supplies, num:Number) : Boolean
      {
         if(this._suppliesBag[num] == null)
         {
            this._suppliesBag[num] = value;
            return true;
         }
         return false;
      }
      
      public function backequipBagNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 24; i++)
         {
            if(this._equipBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backQuestBagNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 24; i++)
         {
            if(this._questBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backSuppliesBagNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 24; i++)
         {
            if(this._suppliesBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backGemBagNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 24; i++)
         {
            if(this._gemBag[i] == null)
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
         for(var i:int = 0; i < 24; i++)
         {
            if(this._gemBag[i] == null)
            {
               num += alltimes;
            }
            else if(gem.compareGem(this._gemBag[i]) == true)
            {
               n = alltimes - this._gemBag[i].getTimes();
               num += n;
            }
         }
         return num;
      }
      
      public function backOtherBagNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] == null)
            {
               num++;
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
         for(var i:int = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] == null)
            {
               num += alltimes;
            }
            else if(oo.compareOtherobj(this._otherobjBag[i]) == true)
            {
               n = alltimes - this._otherobjBag[i].getTimes();
               num += n;
            }
         }
         return num;
      }
      
      public function isGemBagEmpty(value:Gem) : Boolean
      {
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.getIsPile() != true)
         {
            i = 0;
            while(i < 24)
            {
               if(this._gemBag[i] == null)
               {
                  return true;
               }
               i++;
            }
            return false;
         }
         isSameIn = true;
         for(i = 0; i < 24; i++)
         {
            if(this._gemBag[i] == null)
            {
               return true;
            }
            if(this._gemBag[i].compareGem(value) == true)
            {
               if(this._gemBag[i].getTimes() + value.getTimes() < value.getPileLimit())
               {
                  return true;
               }
               if(i == 23)
               {
                  return false;
               }
            }
         }
         return false;
      }
      
      public function addGemBag(value:Gem) : Boolean
      {
         var temp:int = 0;
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.getIsPile() != true)
         {
            i = 0;
            while(i < 24)
            {
               if(this._gemBag[i] == null)
               {
                  this._gemBag[i] = value;
                  return true;
               }
               i++;
            }
            return false;
         }
         temp = -1;
         isSameIn = true;
         for(i = 0; i < 24; i++)
         {
            if(this._gemBag[i] != null)
            {
               if(this._gemBag[i].compareGem(value) == true)
               {
                  while(this._gemBag[i].getTimes() < value.getPileLimit())
                  {
                     this._gemBag[i].addGem(1);
                     if(value.useGem(1) == false)
                     {
                        break;
                     }
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
            this._gemBag[temp] = value;
         }
         return false;
      }
      
      public function addToGemBag(gem:Gem, num:Number) : Boolean
      {
         if(this._gemBag[num] == null)
         {
            this._gemBag[num] = gem;
            return true;
         }
         return false;
      }
      
      public function addToQuestBag(quest:Quest, num:Number) : Boolean
      {
         if(this._questBag[num] == null)
         {
            this._questBag[num] = quest;
            return true;
         }
         return false;
      }
      
      public function fallQusetBag(fallLevel:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._questBag[i] != null)
            {
               if((this._questBag[i] as Quest).compareById(fallLevel))
               {
                  if(this._questBag[i].isMany() == true)
                  {
                     num += this._questBag[i].getTimes();
                  }
                  else
                  {
                     num += 1;
                  }
               }
            }
         }
         return num;
      }
      
      public function clearQuest(fallLevel:Number) : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._questBag[i] != null)
            {
               if((this._questBag[i] as Quest).getFallLevel() == fallLevel)
               {
                  this._questBag[i] = null;
               }
            }
         }
      }
      
      public function addOtherobjBag(value:Otherobj) : Boolean
      {
         var temp:int = 0;
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.isMany() != true)
         {
            i = 0;
            while(i < 24)
            {
               if(this._otherobjBag[i] == null)
               {
                  this._otherobjBag[i] = value;
                  return true;
               }
               i++;
            }
            return false;
         }
         temp = -1;
         isSameIn = true;
         for(i = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] != null)
            {
               if(this._otherobjBag[i].compareOtherobj(value) == true)
               {
                  while(this._otherobjBag[i].getTimes() < value.getPileLimit())
                  {
                     this._otherobjBag[i].addOtherobj(1);
                     if(value.useOtherobj(1) == false)
                     {
                        break;
                     }
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
            this._otherobjBag[temp] = value;
         }
         return false;
      }
      
      public function addQuestBag(value:Quest) : Boolean
      {
         var temp:int = 0;
         var isSameIn:Boolean = false;
         var i:int = 0;
         if(value.isMany() != true)
         {
            i = 0;
            while(i < 24)
            {
               if(this._questBag[i] == null)
               {
                  this._questBag[i] = value;
                  return true;
               }
               i++;
            }
            return false;
         }
         temp = -1;
         isSameIn = true;
         for(i = 0; i < 24; i++)
         {
            if(this._questBag[i] != null)
            {
               if(this._questBag[i].compareQuest(value) == true)
               {
                  while(this._questBag[i].getTimes() < value.getPileLimit())
                  {
                     this._questBag[i].addQuest(1);
                     if(value.useQuest(1) == false)
                     {
                        break;
                     }
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
            this._questBag[temp] = value;
         }
         return false;
      }
      
      public function addToOtherobjBag(otherobj:Otherobj, num:Number) : Boolean
      {
         if(this._otherobjBag[num] == null)
         {
            this._otherobjBag[num] = otherobj;
            return true;
         }
         return false;
      }
      
      public function delEquip(num:Number) : Equip
      {
         var eq:Equip = null;
         if(this._equipBag[num] != null)
         {
            eq = this._equipBag[num];
            this._equipBag[num] = null;
         }
         return eq;
      }
      
      public function delSupplies(num:Number) : Supplies
      {
         var su:Supplies = null;
         if(this._suppliesBag[num] != null)
         {
            su = this._suppliesBag[num];
            this._suppliesBag[num] = null;
         }
         return su;
      }
      
      public function delGem(num:Number, times:Number) : Gem
      {
         var gem:Gem = null;
         gem = this._gemBag[num];
         if(gem.getIsPile() == true)
         {
            gem.useGem(times);
            if(gem.getTimes() == 0)
            {
               this._gemBag[num] = null;
            }
         }
         else
         {
            this._gemBag[num] = null;
         }
         return gem.cloneGem(times);
      }
      
      public function delQuset(num:Number) : Quest
      {
         var quest:Quest = null;
         if(this._questBag[num] != null)
         {
            quest = this._questBag[num];
            this._questBag[num] = null;
         }
         return quest;
      }
      
      public function delOtherobj(num:Number, times:Number = 1) : Otherobj
      {
         var otherobj:Otherobj = null;
         otherobj = this._otherobjBag[num];
         if(otherobj.isMany() == true)
         {
            otherobj.useOtherobj(times);
            if(otherobj.getTimes() == 0)
            {
               this._otherobjBag[num] = null;
            }
         }
         else
         {
            this._otherobjBag[num] = null;
         }
         return otherobj.cloneOtherobj(times);
      }
      
      public function equipBagMove(begin:Number, end:Number) : *
      {
         var temp:Equip = null;
         if(this._equipBag[end] == null)
         {
            this._equipBag[end] = this._equipBag[begin];
            this._equipBag[begin] = null;
         }
         else
         {
            temp = this._equipBag[end];
            this._equipBag[end] = this._equipBag[begin];
            this._equipBag[begin] = temp;
         }
      }
      
      public function suppliesBagMove(begin:Number, end:Number) : *
      {
         var temp:Supplies = null;
         if(this._suppliesBag[end] == null)
         {
            this._suppliesBag[end] = this._suppliesBag[begin];
            this._suppliesBag[begin] = null;
         }
         else
         {
            temp = this._suppliesBag[end];
            this._suppliesBag[end] = this._suppliesBag[begin];
            this._suppliesBag[begin] = temp;
         }
      }
      
      public function gemBagMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Gem = null;
         if(begin != end)
         {
            if(this._gemBag[end] == null)
            {
               this._gemBag[end] = this._gemBag[begin];
               this._gemBag[begin] = null;
            }
            else if(this._gemBag[end].getIsPile() == true && this._gemBag[end].compareGem(this._gemBag[begin]) == true)
            {
               if(this._gemBag[end].getTimes() < this._gemBag[end].getPileLimit())
               {
                  tt = this._gemBag[end].getTimes() + this._gemBag[begin].getTimes();
                  if(tt > this._gemBag[end].getPileLimit())
                  {
                     this._gemBag[begin].useGem(this._gemBag[end].getPileLimit() - this._gemBag[end].getTimes());
                     this._gemBag[end].addGem(this._gemBag[end].getPileLimit() - this._gemBag[end].getTimes());
                  }
                  else
                  {
                     this._gemBag[end].addGem(this._gemBag[begin].getTimes());
                     this._gemBag[begin] = null;
                  }
               }
            }
            else
            {
               temp = this._gemBag[end];
               this._gemBag[end] = this._gemBag[begin];
               this._gemBag[begin] = temp;
            }
         }
      }
      
      public function questBagMove(begin:Number, end:Number) : *
      {
         var temp:Otherobj = null;
         if(this._questBag[end] == null)
         {
            this._questBag[end] = this._questBag[begin];
            this._questBag[begin] = null;
         }
         else
         {
            temp = this._questBag[end];
            this._questBag[end] = this._questBag[begin];
            this._questBag[begin] = temp;
         }
      }
      
      public function otherobjBagMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Otherobj = null;
         if(begin != end)
         {
            if(this._otherobjBag[end] == null)
            {
               this._otherobjBag[end] = this._otherobjBag[begin];
               this._otherobjBag[begin] = null;
            }
            else if(this._otherobjBag[end].isMany() == true && this._otherobjBag[end].compareOtherobj(this._otherobjBag[begin]) == true)
            {
               if(this._otherobjBag[end].getTimes() < this._otherobjBag[end].getPileLimit())
               {
                  tt = this._otherobjBag[end].getTimes() + this._otherobjBag[begin].getTimes();
                  if(tt > this._otherobjBag[end].getPileLimit())
                  {
                     this._otherobjBag[begin].useOtherobj(this._otherobjBag[end].getPileLimit() - this._otherobjBag[end].getTimes());
                     this._otherobjBag[end].addOtherobj(this._otherobjBag[end].getPileLimit() - this._otherobjBag[end].getTimes());
                  }
                  else
                  {
                     this._otherobjBag[end].addOtherobj(this._otherobjBag[begin].getTimes());
                     this._otherobjBag[begin] = null;
                  }
               }
            }
            else
            {
               temp = this._otherobjBag[end];
               this._otherobjBag[end] = this._otherobjBag[begin];
               this._otherobjBag[begin] = temp;
            }
         }
      }
      
      public function isHaveOtherobj(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] != null)
            {
               if((this._otherobjBag[i] as Otherobj).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isHaveEquip(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._equipBag[i] != null)
            {
               if((this._equipBag[i] as Equip).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isHaveSupplies(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._suppliesBag[i] != null)
            {
               if((this._suppliesBag[i] as Supplies).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isHavesQuest(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._questBag[i] != null)
            {
               if((this._questBag[i] as Quest).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isHaveGem(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._gemBag[i] != null)
            {
               if((this._gemBag[i] as Gem).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getOtherobjNum(id:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] != null)
            {
               if((this._otherobjBag[i] as Otherobj).compareById(id))
               {
                  if(this._otherobjBag[i].isMany() == true)
                  {
                     num += this._otherobjBag[i].getTimes();
                  }
                  else
                  {
                     num += 1;
                  }
               }
            }
         }
         return num;
      }
      
      public function getGemNum(id:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._gemBag[i] != null)
            {
               if((this._gemBag[i] as Gem).compareById(id))
               {
                  if(this._gemBag[i].getIsPile() == true)
                  {
                     num += this._gemBag[i].getTimes();
                  }
                  else
                  {
                     num += 1;
                  }
               }
            }
         }
         return num;
      }
      
      public function getEquipObjNum(id:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._equipBag[i] != null)
            {
               if((this._equipBag[i] as Equip).compareById(id))
               {
                  num += 1;
               }
            }
         }
         return num;
      }
      
      public function getSupObjNum(id:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._suppliesBag[i] != null)
            {
               if((this._suppliesBag[i] as Supplies).compareById(id))
               {
                  num += 1;
               }
            }
         }
         return num;
      }
      
      public function getAndUseOtherobj(id:Number, num:Number = 1) : void
      {
         var i:uint = 0;
         for(var j:uint = 0; j < num; j++)
         {
            for(i = 0; i < 24; i++)
            {
               if(this._otherobjBag[i] != null)
               {
                  if((this._otherobjBag[i] as Otherobj).compareById(id))
                  {
                     if(this._otherobjBag[i].isMany() == true)
                     {
                        this._otherobjBag[i].useOtherobj(1);
                        if(this._otherobjBag[i].getTimes() == 0)
                        {
                           this._otherobjBag[i] = null;
                        }
                     }
                     else
                     {
                        this._otherobjBag[i] = null;
                     }
                     break;
                  }
               }
            }
         }
      }
      
      public function delGemById(id:Number, times:Number) : Array
      {
         var t:int = 0;
         var arr:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(!(times > 0))
            {
               break;
            }
            if(this._gemBag[i] != null)
            {
               if((this._gemBag[i] as Gem).compareById(id))
               {
                  if(this._gemBag[i].getIsPile() == true)
                  {
                     for(t = 1; t <= times; t++)
                     {
                        (this._gemBag[i] as Gem).useGem(1);
                        if((this._gemBag[i] as Gem).getTimes() == 0)
                        {
                           arr.push((this._gemBag[i] as Gem).cloneGem(t));
                           times -= t;
                           this._gemBag[i] = null;
                           break;
                        }
                        if(t == times)
                        {
                           arr.push((this._gemBag[i] as Gem).cloneGem(times));
                           times = 0;
                           break;
                        }
                     }
                  }
                  else
                  {
                     times--;
                     arr.push((this._gemBag[i] as Gem).cloneGem(1));
                     this._gemBag[i] = null;
                  }
               }
            }
         }
         return arr;
      }
      
      public function delOtherById(id:Number, times:Number = 1) : Array
      {
         var t:int = 0;
         var arr:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(!(times > 0))
            {
               break;
            }
            if(this._otherobjBag[i] != null)
            {
               if((this._otherobjBag[i] as Otherobj).compareById(id))
               {
                  if(this._otherobjBag[i].isMany() == true)
                  {
                     for(t = 1; t <= times; t++)
                     {
                        (this._otherobjBag[i] as Otherobj).useOtherobj(1);
                        if((this._otherobjBag[i] as Otherobj).getTimes() == 0)
                        {
                           arr.push((this._otherobjBag[i] as Otherobj).cloneOtherobj(t));
                           times -= t;
                           this._otherobjBag[i] = null;
                           break;
                        }
                        if(t == times)
                        {
                           arr.push((this._otherobjBag[i] as Otherobj).cloneOtherobj(times));
                           times = 0;
                           break;
                        }
                     }
                  }
                  else
                  {
                     times--;
                     arr.push((this._otherobjBag[i] as Otherobj).cloneOtherobj(1));
                     this._otherobjBag[i] = null;
                  }
               }
            }
         }
         return arr;
      }
      
      public function clearOther(id:Number) : void
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] != null)
            {
               if((this._otherobjBag[i] as Otherobj).getId() == id)
               {
                  this._otherobjBag[i] = null;
               }
            }
         }
      }
      
      public function getEquipById(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._equipBag[i] != null)
            {
               if((this._equipBag[i] as Equip).compareById(id))
               {
                  arr1.push(this._equipBag[i]);
                  arr2.push(i);
               }
            }
         }
         arr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getEquipByIdTOW(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._equipBag[i] != null)
            {
               if(Boolean((this._equipBag[i] as Equip).compareById(id)) && (this._equipBag[i] as Equip).getRemainingTime() > 0)
               {
                  arr1.push(this._equipBag[i]);
                  arr2.push(i);
               }
            }
         }
         arr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getOtherobjById(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] != null)
            {
               if((this._otherobjBag[i] as Otherobj).compareById(id))
               {
                  arr1.push(this._otherobjBag[i]);
                  arr2.push(i);
               }
            }
         }
         arr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getQuestById(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._questBag[i] != null)
            {
               if((this._questBag[i] as Quest).compareById(id))
               {
                  arr1.push(this._questBag[i]);
                  arr2.push(i);
               }
            }
         }
         arr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getGemById(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._gemBag[i] != null)
            {
               if((this._gemBag[i] as Gem).compareById(id))
               {
                  arr1.push(this._gemBag[i]);
                  arr2.push(i);
               }
            }
         }
         arr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getSupById(id:Number) : Array
      {
         var arr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._suppliesBag[i] != null)
            {
               if((this._suppliesBag[i] as Supplies).compareById(id))
               {
                  arr1.push(this._suppliesBag[i]);
                  arr2.push(i);
               }
            }
         }
         arr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return arr;
      }
      
      public function getGemByType(type:Number) : Array
      {
         var gemArr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._gemBag[i] != null)
            {
               if((this._gemBag[i] as Gem).getType() == type)
               {
                  arr1.push(this._gemBag[i]);
                  arr2.push(i);
               }
            }
         }
         gemArr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return gemArr;
      }
      
      public function getOtherByType(type:Number) : Array
      {
         var gemArr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._otherobjBag[i] != null)
            {
               if((this._otherobjBag[i] as Otherobj).getType() == type)
               {
                  arr1.push(this._otherobjBag[i]);
                  arr2.push(i);
               }
            }
         }
         gemArr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return gemArr;
      }
      
      public function getEquipAndPoint() : Array
      {
         var EArr:Array = [];
         var arr1:Array = [];
         var arr2:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._equipBag[i] != null)
            {
               arr1.push(this._equipBag[i]);
               arr2.push(i);
            }
         }
         EArr.push(arr1,arr2);
         if(arr1.length < 1)
         {
            return null;
         }
         return EArr;
      }
      
      public function delEquipById(id:Number, times:Number) : Array
      {
         var i:uint = 0;
         var eArr:Array = [];
         var num:Number = 0;
         if(times > 0)
         {
            for(i = 0; i < 24; i++)
            {
               if(this._equipBag[i] != null)
               {
                  if((this._equipBag[i] as Equip).compareById(id))
                  {
                     eArr.push((this._equipBag[i] as Equip).getClone());
                     this._equipBag[i] = null;
                     num++;
                     if(num >= times)
                     {
                        break;
                     }
                  }
               }
            }
         }
         return eArr;
      }
      
      public function delSuppliesById(id:Number, times:Number) : Array
      {
         var i:uint = 0;
         var SArr:Array = [];
         var num:Number = 0;
         if(times > 0)
         {
            for(i = 0; i < 24; i++)
            {
               if(this._suppliesBag[i] != null)
               {
                  if((this._suppliesBag[i] as Supplies).compareById(id))
                  {
                     SArr.push((this._suppliesBag[i] as Supplies).getClone());
                     this._suppliesBag[i] = null;
                     num++;
                     if(num >= times)
                     {
                        break;
                     }
                  }
               }
            }
         }
         return SArr;
      }
      
      public function cheatTesting() : *
      {
         if(Main.NoLogInfo[4])
         {
            return;
         }
         for(var i:uint = 0; i < 24; i++)
         {
            if(this._gemBag[i] != null)
            {
               if((this._gemBag[i] as Gem).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._gemBag[i] as Gem).getTimes());
                  break;
               }
            }
            if(this._otherobjBag[i] != null)
            {
               if((this._otherobjBag[i] as Otherobj).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._otherobjBag[i] as Otherobj).getTimes());
                  break;
               }
            }
         }
      }
      
      public function cheatEquip() : *
      {
         var j:uint = 0;
         var k:uint = 0;
         for(var i:uint = 0; i < 23; i++)
         {
            for(j = i + 1; j < 24; j++)
            {
               if(this._equipBag[i])
               {
                  if((this._equipBag[i] as Equip).testEquip(this._equipBag[j]))
                  {
                     this._equipBag[i] = null;
                  }
               }
            }
            for(k = 0; k < 35; k++)
            {
               if(Boolean(this._equipBag[i]) && Boolean(StoragePanel.storage.getEquipFromStorage(k)))
               {
                  if((this._equipBag[i] as Equip).testEquip(StoragePanel.storage.getEquipFromStorage(k)))
                  {
                     this._equipBag[i] = null;
                  }
               }
            }
         }
      }
      
      public function cheatGem() : *
      {
         var j:uint = 0;
         var k:uint = 0;
         for(var i:uint = 0; i < 23; i++)
         {
            for(j = i + 1; j < 24; j++)
            {
               if(this._gemBag[i])
               {
                  (this._gemBag[i] as Gem).testGem(this._gemBag[j]);
               }
            }
            for(k = 0; k < 35; k++)
            {
               if(Boolean(this._gemBag[i]) && Boolean(StoragePanel.storage.getGemFromStorage(k)))
               {
                  (this._gemBag[i] as Gem).testGem(StoragePanel.storage.getGemFromStorage(k));
               }
            }
         }
      }
      
      public function cheatOther() : *
      {
         var j:uint = 0;
         var k:uint = 0;
         for(var i:uint = 0; i < 23; i++)
         {
            for(j = i + 1; j < 24; j++)
            {
               if(this._otherobjBag[i])
               {
                  (this._otherobjBag[i] as Otherobj).testOtherobj(this._otherobjBag[j]);
               }
            }
            for(k = 0; k < 35; k++)
            {
               if(Boolean(this._otherobjBag[i]) && Boolean(StoragePanel.storage.getOtherobjFromStorage(k)))
               {
                  (this._otherobjBag[i] as Otherobj).testOtherobj(StoragePanel.storage.getOtherobjFromStorage(k));
               }
            }
         }
      }
   }
}

