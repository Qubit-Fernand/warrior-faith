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
         trace("禁止get:",getQualifiedClassName(this));
         return _equipBag;
      }
      
      public function set equipBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _equipBag = value;
      }
      
      public function get suppliesBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesBag;
      }
      
      public function set suppliesBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesBag = value;
      }
      
      public function get gemBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemBag;
      }
      
      public function set gemBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemBag = value;
      }
      
      public function get questBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _questBag;
      }
      
      public function set questBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _questBag = value;
      }
      
      public function get otherobjBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _otherobjBag;
      }
      
      public function set otherobjBag(value:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _otherobjBag = value;
      }
      
      public function getEquipBag() : Array
      {
         return _equipBag.slice();
      }
      
      public function getEquipFromBag(num:Number) : Equip
      {
         if(_equipBag[num] != null)
         {
            return _equipBag[num];
         }
         return null;
      }
      
      public function getSuppliesBag() : Array
      {
         return _suppliesBag.slice();
      }
      
      public function getSuppliesFromBag(num:Number) : Supplies
      {
         if(_suppliesBag[num] != null)
         {
            return _suppliesBag[num];
         }
         return null;
      }
      
      public function getGemBag() : Array
      {
         return _gemBag.slice();
      }
      
      public function getGemFromBag(num:Number) : Gem
      {
         if(_gemBag[num] != null)
         {
            return _gemBag[num];
         }
         return null;
      }
      
      public function getQuestBag() : Array
      {
         return _questBag.slice();
      }
      
      public function getQuestFromBag(num:Number) : Quest
      {
         if(_questBag[num] != null)
         {
            return _questBag[num];
         }
         return null;
      }
      
      public function getOtherobjFromBag(num:Number) : Otherobj
      {
         if(_otherobjBag[num] != null)
         {
            return _otherobjBag[num];
         }
         return null;
      }
      
      public function getOtherobjBag() : Array
      {
         return _otherobjBag.slice();
      }
      
      public function addEquipBag(value:Equip) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(_equipBag[i] == null)
            {
               _equipBag[i] = value;
               return true;
            }
         }
         return false;
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
      
      public function addSuppliesBag(value:Supplies) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
         {
            if(_suppliesBag[i] == null)
            {
               _suppliesBag[i] = value;
               return true;
            }
         }
         return false;
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
      
      public function backequipBagNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 24; i++)
         {
            if(_equipBag[i] == null)
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
            if(_questBag[i] == null)
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
            if(_suppliesBag[i] == null)
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
            if(_gemBag[i] == null)
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
      
      public function backOtherBagNum() : uint
      {
         var num:uint = 0;
         for(var i:int = 0; i < 24; i++)
         {
            if(_otherobjBag[i] == null)
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
      
      public function addToGemBag(gem:Gem, num:Number) : Boolean
      {
         if(_gemBag[num] == null)
         {
            _gemBag[num] = gem;
            return true;
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
      
      public function fallQusetBag(fallLevel:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
         {
            if(_questBag[i] != null)
            {
               if((_questBag[i] as Quest).compareById(fallLevel))
               {
                  if(_questBag[i].isMany() == true)
                  {
                     num += _questBag[i].getTimes();
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
            if(_questBag[i] != null)
            {
               if((_questBag[i] as Quest).getFallLevel() == fallLevel)
               {
                  _questBag[i] = null;
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
               if(_questBag[i] == null)
               {
                  _questBag[i] = value;
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
            if(_questBag[i] != null)
            {
               if(_questBag[i].compareQuest(value) == true)
               {
                  while(_questBag[i].getTimes() < value.getPileLimit())
                  {
                     _questBag[i].addQuest(1);
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
            _questBag[temp] = value;
         }
         return false;
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
      
      public function isHaveOtherobj(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
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
      
      public function isHaveEquip(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
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
         for(var i:uint = 0; i < 24; i++)
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
      
      public function isHavesQuest(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
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
      
      public function isHaveGem(id:Number) : Boolean
      {
         for(var i:uint = 0; i < 24; i++)
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
      
      public function getOtherobjNum(id:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
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
      
      public function getGemNum(id:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
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
      
      public function getEquipObjNum(id:Number) : Number
      {
         var num:Number = 0;
         for(var i:uint = 0; i < 24; i++)
         {
            if(_equipBag[i] != null)
            {
               if((_equipBag[i] as Equip).compareById(id))
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
            if(_suppliesBag[i] != null)
            {
               if((_suppliesBag[i] as Supplies).compareById(id))
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
            if(_gemBag[i] != null)
            {
               if((_gemBag[i] as Gem).compareById(id))
               {
                  if(_gemBag[i].getIsPile() == true)
                  {
                     for(t = 1; t <= times; t++)
                     {
                        (_gemBag[i] as Gem).useGem(1);
                        if((_gemBag[i] as Gem).getTimes() == 0)
                        {
                           arr.push((_gemBag[i] as Gem).cloneGem(t));
                           times -= t;
                           _gemBag[i] = null;
                           break;
                        }
                        if(t == times)
                        {
                           arr.push((_gemBag[i] as Gem).cloneGem(times));
                           times = 0;
                           break;
                        }
                     }
                  }
                  else
                  {
                     times--;
                     arr.push((_gemBag[i] as Gem).cloneGem(1));
                     _gemBag[i] = null;
                  }
               }
            }
         }
         return arr;
      }
      
      public function delOtherById(id:Number, times:Number) : Array
      {
         var t:int = 0;
         var arr:Array = [];
         for(var i:uint = 0; i < 24; i++)
         {
            if(!(times > 0))
            {
               break;
            }
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).compareById(id))
               {
                  if(_otherobjBag[i].isMany() == true)
                  {
                     for(t = 1; t <= times; t++)
                     {
                        (_otherobjBag[i] as Otherobj).useOtherobj(1);
                        if((_otherobjBag[i] as Otherobj).getTimes() == 0)
                        {
                           arr.push((_otherobjBag[i] as Otherobj).cloneOtherobj(t));
                           times -= t;
                           _otherobjBag[i] = null;
                           break;
                        }
                        if(t == times)
                        {
                           arr.push((_otherobjBag[i] as Otherobj).cloneOtherobj(times));
                           times = 0;
                           break;
                        }
                     }
                  }
                  else
                  {
                     times--;
                     arr.push((_otherobjBag[i] as Otherobj).cloneOtherobj(1));
                     _otherobjBag[i] = null;
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
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).getId() == id)
               {
                  _otherobjBag[i] = null;
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
            if(_equipBag[i] != null)
            {
               if((_equipBag[i] as Equip).compareById(id))
               {
                  arr1.push(_equipBag[i]);
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
            if(_equipBag[i] != null)
            {
               if(Boolean((_equipBag[i] as Equip).compareById(id)) && (_equipBag[i] as Equip).getRemainingTime() > 0)
               {
                  arr1.push(_equipBag[i]);
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
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).compareById(id))
               {
                  arr1.push(_otherobjBag[i]);
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
            if(_questBag[i] != null)
            {
               if((_questBag[i] as Quest).compareById(id))
               {
                  arr1.push(_questBag[i]);
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
            if(_gemBag[i] != null)
            {
               if((_gemBag[i] as Gem).compareById(id))
               {
                  arr1.push(_gemBag[i]);
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
            if(_suppliesBag[i] != null)
            {
               if((_suppliesBag[i] as Supplies).compareById(id))
               {
                  arr1.push(_suppliesBag[i]);
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
            if(_gemBag[i] != null)
            {
               if((_gemBag[i] as Gem).getType() == type)
               {
                  arr1.push(_gemBag[i]);
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
            if(_otherobjBag[i] != null)
            {
               if((_otherobjBag[i] as Otherobj).getType() == type)
               {
                  arr1.push(_otherobjBag[i]);
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
            if(_equipBag[i] != null)
            {
               arr1.push(_equipBag[i]);
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
               if(_equipBag[i] != null)
               {
                  if((_equipBag[i] as Equip).compareById(id))
                  {
                     eArr.push((_equipBag[i] as Equip).getClone());
                     _equipBag[i] = null;
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
               if(_suppliesBag[i] != null)
               {
                  if((_suppliesBag[i] as Supplies).compareById(id))
                  {
                     SArr.push((_suppliesBag[i] as Supplies).getClone());
                     _suppliesBag[i] = null;
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
   }
}

