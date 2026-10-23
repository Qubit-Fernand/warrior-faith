package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import flash.utils.*;
   
   public class Bag
   {
      
      private var _equipBag:Array = new Array();
      
      private var _questBag:Array = new Array();
      
      private var _suppliesBag:Array = new Array();
      
      private var _gemBag:Array = new Array();
      
      private var _otherobjBag:Array = new Array();
      
      public function Bag()
      {
         super();
      }
      
      public static function createBag() : Bag
      {
         var bg:Bag = null;
         var i:int = 0;
         bg = new Bag();
         for(i = 0; i < 24; i++)
         {
            bg._equipBag[i] = null;
            bg._suppliesBag[i] = null;
            bg._gemBag[i] = null;
            bg._questBag[i] = null;
            bg._otherobjBag[i] = null;
         }
         return bg;
      }
      
      public function backQuestBagNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_questBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function fallQusetBag(fallLevel:Number) : Number
      {
         var num:Number = NaN;
         var i:uint = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_questBag[i] != null)
            {
               if((_questBag[i] as Quest).getFallLevel() == fallLevel)
               {
                  num++;
               }
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
               if(_gemBag[i] == null)
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
            if(_gemBag[i] == null)
            {
               return true;
            }
            if(_gemBag[i].compareGem(value) == true)
            {
               if(_gemBag[i].getTimes() + value.getTimes() < value.getPileLimit())
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
      
      public function getOtherobjNum(id:Number) : Number
      {
         var num:Number = NaN;
         var i:uint = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).compareById(id))
               {
                  if(_otherobjBag[i].isMany() == true)
                  {
                     num += _otherobjBag[i].getTimes();
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
      
      public function set questBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _questBag = value;
      }
      
      public function addQuestBag(value:Quest) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_questBag[i] == null)
            {
               _questBag[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function delOtherobj(num:Number, times:Number = 1) : Otherobj
      {
         var otherobj:Otherobj = null;
         otherobj = _otherobjBag[num];
         if(otherobj.isMany() == true)
         {
            otherobj.useOtherobj(times);
            if(otherobj.getTimes() == 0)
            {
               _otherobjBag[num] = null;
            }
         }
         else
         {
            _otherobjBag[num] = null;
         }
         return otherobj.cloneOtherobj(times);
      }
      
      public function addToOtherobjBag(otherobj:Otherobj, num:Number) : Boolean
      {
         if(_otherobjBag[num] == null)
         {
            _otherobjBag[num] = otherobj;
            return true;
         }
         return false;
      }
      
      public function canPutOtherNum(otherId:Number) : uint
      {
         var oo:Otherobj = null;
         var times:uint = 0;
         var alltimes:uint = 0;
         var num:uint = 0;
         var i:int = 0;
         var n:uint = 0;
         oo = OtherFactory.creatOther(otherId);
         times = oo.getTimes();
         alltimes = oo.getPileLimit();
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_otherobjBag[i] == null)
            {
               num += alltimes;
            }
            else if(oo.compareOtherobj(_otherobjBag[i]) == true)
            {
               n = alltimes - _otherobjBag[i].getTimes();
               num += n;
            }
         }
         return num;
      }
      
      public function otherobjBagMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Otherobj = null;
         if(begin != end)
         {
            if(_otherobjBag[end] == null)
            {
               _otherobjBag[end] = _otherobjBag[begin];
               _otherobjBag[begin] = null;
            }
            else if(_otherobjBag[end].isMany() == true && _otherobjBag[end].compareOtherobj(_otherobjBag[begin]) == true)
            {
               if(_otherobjBag[end].getTimes() < _otherobjBag[end].getPileLimit())
               {
                  tt = _otherobjBag[end].getTimes() + _otherobjBag[begin].getTimes();
                  if(tt > _otherobjBag[end].getPileLimit())
                  {
                     _otherobjBag[begin].useOtherobj(_otherobjBag[end].getPileLimit() - _otherobjBag[end].getTimes());
                     _otherobjBag[end].addOtherobj(_otherobjBag[end].getPileLimit() - _otherobjBag[end].getTimes());
                  }
                  else
                  {
                     _otherobjBag[end].addOtherobj(_otherobjBag[begin].getTimes());
                     _otherobjBag[begin] = null;
                  }
               }
            }
            else
            {
               temp = _otherobjBag[end];
               _otherobjBag[end] = _otherobjBag[begin];
               _otherobjBag[begin] = temp;
            }
         }
      }
      
      public function addSuppliesBag(value:Supplies) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_suppliesBag[i] == null)
            {
               _suppliesBag[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function clearQuest(fallLevel:Number) : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_questBag[i] != null)
            {
               if((_questBag[i] as Quest).getFallLevel() == fallLevel)
               {
                  _questBag[i] = null;
               }
            }
         }
      }
      
      public function isHaveEquip(id:Number) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_equipBag[i] != null)
            {
               if((_equipBag[i] as Equip).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isHaveSupplies(id:Number) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_suppliesBag[i] != null)
            {
               if((_suppliesBag[i] as Supplies).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get otherobjBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _otherobjBag;
      }
      
      public function getEquipFromBag(num:Number) : Equip
      {
         if(_equipBag[num] != null)
         {
            return _equipBag[num];
         }
         return null;
      }
      
      public function backOtherBagNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_otherobjBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function equipBagMove(begin:Number, end:Number) : *
      {
         var temp:Equip = null;
         if(_equipBag[end] == null)
         {
            _equipBag[end] = _equipBag[begin];
            _equipBag[begin] = null;
         }
         else
         {
            temp = _equipBag[end];
            _equipBag[end] = _equipBag[begin];
            _equipBag[begin] = temp;
         }
      }
      
      public function gemBagMove(begin:Number, end:Number) : *
      {
         var tt:uint = 0;
         var temp:Gem = null;
         if(begin != end)
         {
            if(_gemBag[end] == null)
            {
               _gemBag[end] = _gemBag[begin];
               _gemBag[begin] = null;
            }
            else if(_gemBag[end].getIsPile() == true && _gemBag[end].compareGem(_gemBag[begin]) == true)
            {
               if(_gemBag[end].getTimes() < _gemBag[end].getPileLimit())
               {
                  tt = _gemBag[end].getTimes() + _gemBag[begin].getTimes();
                  if(tt > _gemBag[end].getPileLimit())
                  {
                     _gemBag[begin].useGem(_gemBag[end].getPileLimit() - _gemBag[end].getTimes());
                     _gemBag[end].addGem(_gemBag[end].getPileLimit() - _gemBag[end].getTimes());
                  }
                  else
                  {
                     _gemBag[end].addGem(_gemBag[begin].getTimes());
                     _gemBag[begin] = null;
                  }
               }
            }
            else
            {
               temp = _gemBag[end];
               _gemBag[end] = _gemBag[begin];
               _gemBag[begin] = temp;
            }
         }
      }
      
      public function getGemFromBag(num:Number) : Gem
      {
         if(_gemBag[num] != null)
         {
            return _gemBag[num];
         }
         return null;
      }
      
      public function getGemNum(id:Number) : Number
      {
         var num:Number = NaN;
         var i:uint = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_gemBag[i] != null)
            {
               if((_gemBag[i] as Gem).compareById(id))
               {
                  if(_gemBag[i].getIsPile() == true)
                  {
                     num += _gemBag[i].getTimes();
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
      
      public function getGemBag() : Array
      {
         return _gemBag.slice();
      }
      
      public function getQuestFromBag(num:Number) : Quest
      {
         if(_questBag[num] != null)
         {
            return _questBag[num];
         }
         return null;
      }
      
      public function getAndUseOtherobj(id:Number, num:Number = 1) : void
      {
         var j:uint = 0;
         var i:uint = 0;
         for(j = 0; j < num; j++)
         {
            for(i = 0; i < 24; i++)
            {
               if(_otherobjBag[i] != null)
               {
                  if((_otherobjBag[i] as Otherobj).compareById(id))
                  {
                     if(_otherobjBag[i].isMany() == true)
                     {
                        _otherobjBag[i].useOtherobj(1);
                        if(_otherobjBag[i].getTimes() == 0)
                        {
                           _otherobjBag[i] = null;
                        }
                     }
                     else
                     {
                        _otherobjBag[i] = null;
                     }
                     break;
                  }
               }
            }
         }
      }
      
      public function getEquipBag() : Array
      {
         return _equipBag.slice();
      }
      
      public function canPutGemNum(gemId:Number) : uint
      {
         var gem:Gem = null;
         var times:uint = 0;
         var alltimes:uint = 0;
         var num:uint = 0;
         var i:int = 0;
         var n:uint = 0;
         gem = GemFactory.creatGemById(gemId);
         times = gem.getTimes();
         alltimes = gem.getPileLimit();
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_gemBag[i] == null)
            {
               num += alltimes;
            }
            else if(gem.compareGem(_gemBag[i]) == true)
            {
               n = alltimes - _gemBag[i].getTimes();
               num += n;
            }
         }
         return num;
      }
      
      public function questBagMove(begin:Number, end:Number) : *
      {
         var temp:Otherobj = null;
         if(_questBag[end] == null)
         {
            _questBag[end] = _questBag[begin];
            _questBag[begin] = null;
         }
         else
         {
            temp = _questBag[end];
            _questBag[end] = _questBag[begin];
            _questBag[begin] = temp;
         }
      }
      
      public function get equipBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _equipBag;
      }
      
      public function get gemBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemBag;
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
               if(_gemBag[i] == null)
               {
                  _gemBag[i] = value;
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
            if(_gemBag[i] != null)
            {
               if(_gemBag[i].compareGem(value) == true)
               {
                  while(_gemBag[i].getTimes() < value.getPileLimit())
                  {
                     _gemBag[i].addGem(1);
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
            _gemBag[temp] = value;
         }
         return false;
      }
      
      public function getSuppliesFromBag(num:Number) : Supplies
      {
         if(_suppliesBag[num] != null)
         {
            return _suppliesBag[num];
         }
         return null;
      }
      
      public function getQuestBag() : Array
      {
         return _questBag.slice();
      }
      
      public function isHaveGem(id:Number) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_gemBag[i] != null)
            {
               if((_gemBag[i] as Gem).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
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
               if(_otherobjBag[i] == null)
               {
                  _otherobjBag[i] = value;
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
            if(_otherobjBag[i] != null)
            {
               if(_otherobjBag[i].compareOtherobj(value) == true)
               {
                  while(_otherobjBag[i].getTimes() < value.getPileLimit())
                  {
                     _otherobjBag[i].addOtherobj(1);
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
            _otherobjBag[temp] = value;
         }
         return false;
      }
      
      public function set otherobjBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _otherobjBag = value;
      }
      
      public function getSuppliesBag() : Array
      {
         return _suppliesBag.slice();
      }
      
      public function get questBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _questBag;
      }
      
      public function isHaveOtherobj(id:Number) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function delGem(num:Number, times:Number) : Gem
      {
         var gem:Gem = null;
         gem = _gemBag[num];
         if(gem.getIsPile() == true)
         {
            gem.useGem(times);
            if(gem.getTimes() == 0)
            {
               _gemBag[num] = null;
            }
         }
         else
         {
            _gemBag[num] = null;
         }
         return gem.cloneGem(times);
      }
      
      public function backSuppliesBagNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_suppliesBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function addToEquipBag(value:Equip, num:Number) : Boolean
      {
         if(_equipBag[num] == null)
         {
            _equipBag[num] = value;
            return true;
         }
         return false;
      }
      
      public function addToGemBag(gem:Gem, num:Number) : Boolean
      {
         if(_gemBag[num] == null)
         {
            _gemBag[num] = gem;
            return true;
         }
         return false;
      }
      
      public function clearOther(id:Number) : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).getId() == id)
               {
                  _otherobjBag[i] = null;
               }
            }
         }
      }
      
      public function addToSuppliesBag(value:Supplies, num:Number) : Boolean
      {
         if(_suppliesBag[num] == null)
         {
            _suppliesBag[num] = value;
            return true;
         }
         return false;
      }
      
      public function getOtherobjFromBag(num:Number) : Otherobj
      {
         if(_otherobjBag[num] != null)
         {
            return _otherobjBag[num];
         }
         return null;
      }
      
      public function delEquip(num:Number) : Equip
      {
         var eq:Equip = null;
         if(_equipBag[num] != null)
         {
            eq = _equipBag[num];
            _equipBag[num] = null;
         }
         return eq;
      }
      
      public function backGemBagNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_gemBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function backequipBagNum() : uint
      {
         var num:uint = 0;
         var i:int = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_equipBag[i] == null)
            {
               num++;
            }
         }
         return num;
      }
      
      public function isHavesQuest(id:Number) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_questBag[i] != null)
            {
               if((_questBag[i] as Quest).compareById(id) == true)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function addToQuestBag(quest:Quest, num:Number) : Boolean
      {
         if(_questBag[num] == null)
         {
            _questBag[num] = quest;
            return true;
         }
         return false;
      }
      
      public function getOtherobjBag() : Array
      {
         return _otherobjBag.slice();
      }
      
      public function suppliesBagMove(begin:Number, end:Number) : *
      {
         var temp:Supplies = null;
         if(_suppliesBag[end] == null)
         {
            _suppliesBag[end] = _suppliesBag[begin];
            _suppliesBag[begin] = null;
         }
         else
         {
            temp = _suppliesBag[end];
            _suppliesBag[end] = _suppliesBag[begin];
            _suppliesBag[begin] = temp;
         }
      }
      
      public function set equipBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _equipBag = value;
      }
      
      public function set gemBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemBag = value;
      }
      
      public function delQuset(num:Number) : Quest
      {
         var quest:Quest = null;
         if(_questBag[num] != null)
         {
            quest = _questBag[num];
            _questBag[num] = null;
         }
         return quest;
      }
      
      public function set suppliesBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesBag = value;
      }
      
      public function addEquipBag(value:Equip) : Boolean
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            if(_equipBag[i] == null)
            {
               _equipBag[i] = value;
               return true;
            }
         }
         return false;
      }
      
      public function fallOtherBag(id:Number) : Number
      {
         var num:Number = NaN;
         var i:uint = 0;
         num = 0;
         for(i = 0; i < 24; i++)
         {
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).getId() == id)
               {
                  num++;
               }
            }
         }
         return num;
      }
      
      public function get suppliesBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesBag;
      }
      
      public function delSupplies(num:Number) : Supplies
      {
         var su:Supplies = null;
         if(_suppliesBag[num] != null)
         {
            su = _suppliesBag[num];
            _suppliesBag[num] = null;
         }
         return su;
      }
   }
}

