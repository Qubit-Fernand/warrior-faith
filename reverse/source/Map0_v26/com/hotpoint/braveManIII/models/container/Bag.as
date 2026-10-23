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
   import flash.utils.*;
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
         var _loc1_:Bag = new Bag();
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            _loc1_._equipBag[_loc2_] = null;
            _loc1_._suppliesBag[_loc2_] = null;
            _loc1_._gemBag[_loc2_] = null;
            _loc1_._questBag[_loc2_] = null;
            _loc1_._otherobjBag[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get equipBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _equipBag;
      }
      
      public function set equipBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _equipBag = param1;
      }
      
      public function get suppliesBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesBag;
      }
      
      public function set suppliesBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesBag = param1;
      }
      
      public function get gemBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _gemBag;
      }
      
      public function set gemBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemBag = param1;
      }
      
      public function get questBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _questBag;
      }
      
      public function set questBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _questBag = param1;
      }
      
      public function get otherobjBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _otherobjBag;
      }
      
      public function set otherobjBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _otherobjBag = param1;
      }
      
      public function getEquipBag() : Array
      {
         return _equipBag.slice();
      }
      
      public function getEquipFromBag(param1:Number) : Equip
      {
         if(_equipBag[param1] != null && _equipBag[param1] is Equip)
         {
            return _equipBag[param1];
         }
         return null;
      }
      
      public function getSuppliesBag() : Array
      {
         return _suppliesBag.slice();
      }
      
      public function getSuppliesFromBag(param1:Number) : Supplies
      {
         if(_suppliesBag[param1] != null)
         {
            return _suppliesBag[param1];
         }
         return null;
      }
      
      public function getGemBag() : Array
      {
         return _gemBag.slice();
      }
      
      public function getGemFromBag(param1:Number) : Gem
      {
         if(_gemBag[param1] != null)
         {
            return _gemBag[param1];
         }
         return null;
      }
      
      public function getQuestBag() : Array
      {
         return _questBag.slice();
      }
      
      public function getQuestFromBag(param1:Number) : Quest
      {
         if(_questBag[param1] != null)
         {
            return _questBag[param1];
         }
         return null;
      }
      
      public function getOtherobjFromBag(param1:Number) : Otherobj
      {
         if(_otherobjBag[param1] != null)
         {
            return _otherobjBag[param1];
         }
         return null;
      }
      
      public function getOtherobjBag() : Array
      {
         return _otherobjBag.slice();
      }
      
      public function addEquipBag(param1:Equip) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] == null)
            {
               _equipBag[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function addToEquipBag(param1:Equip, param2:Number) : Boolean
      {
         if(_equipBag[param2] == null)
         {
            _equipBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function addSuppliesBag(param1:Supplies) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_suppliesBag[_loc2_] == null)
            {
               _suppliesBag[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function addToSuppliesBag(param1:Supplies, param2:Number) : Boolean
      {
         if(_suppliesBag[param2] == null)
         {
            _suppliesBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function backequipBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backQuestBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_questBag[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backSuppliesBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_suppliesBag[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backGemBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_gemBag[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function canPutGemNum(param1:Number) : uint
      {
         var _loc7_:uint = 0;
         var _loc2_:Gem = GemFactory.creatGemById(param1);
         var _loc3_:uint = _loc2_.getTimes();
         var _loc4_:uint = _loc2_.getPileLimit();
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         while(_loc6_ < 24)
         {
            if(_gemBag[_loc6_] == null)
            {
               _loc5_ += _loc4_;
            }
            else if(_loc2_.compareGem(_gemBag[_loc6_]) == true)
            {
               _loc7_ = _loc4_ - _gemBag[_loc6_].getTimes();
               _loc5_ += _loc7_;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function backOtherBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_otherobjBag[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function canPutOtherNum(param1:Number) : uint
      {
         var _loc7_:uint = 0;
         var _loc2_:Otherobj = OtherFactory.creatOther(param1);
         var _loc3_:uint = _loc2_.getTimes();
         var _loc4_:uint = _loc2_.getPileLimit();
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         while(_loc6_ < 24)
         {
            if(_otherobjBag[_loc6_] == null)
            {
               _loc5_ += _loc4_;
            }
            else if(_loc2_.compareOtherobj(_otherobjBag[_loc6_]) == true)
            {
               _loc7_ = _loc4_ - _otherobjBag[_loc6_].getTimes();
               _loc5_ += _loc7_;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function isGemBagEmpty(param1:Gem) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(param1.getIsPile() != true)
         {
            _loc3_ = 0;
            while(_loc3_ < 24)
            {
               if(_gemBag[_loc3_] == null)
               {
                  return true;
               }
               _loc3_++;
            }
            return false;
         }
         _loc2_ = true;
         _loc3_ = 0;
         while(_loc3_ < 24)
         {
            if(_gemBag[_loc3_] == null)
            {
               return true;
            }
            if(_gemBag[_loc3_].compareGem(param1) == true)
            {
               if(_gemBag[_loc3_].getTimes() + param1.getTimes() < param1.getPileLimit())
               {
                  return true;
               }
               if(_loc3_ == 23)
               {
                  return false;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public function addGemBag(param1:Gem) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(param1.getIsPile() != true)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(_gemBag[_loc4_] == null)
               {
                  _gemBag[_loc4_] = param1;
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(_gemBag[_loc4_] != null)
            {
               if(_gemBag[_loc4_].compareGem(param1) == true)
               {
                  while(_gemBag[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     _gemBag[_loc4_].addGem(1);
                     if(param1.useGem(1) == false)
                     {
                        break;
                     }
                  }
                  if(param1.getTimes() == 0)
                  {
                     break;
                  }
               }
            }
            else if(_loc2_ == -1)
            {
               _loc2_ = _loc4_;
            }
            _loc4_++;
         }
         if(param1.getTimes() > 0)
         {
            _gemBag[_loc2_] = param1;
         }
         return false;
      }
      
      public function addToGemBag(param1:Gem, param2:Number) : Boolean
      {
         if(_gemBag[param2] == null)
         {
            _gemBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function addToQuestBag(param1:Quest, param2:Number) : Boolean
      {
         if(_questBag[param2] == null)
         {
            _questBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function fallQusetBag(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 24)
         {
            if(_questBag[_loc3_] != null)
            {
               if((_questBag[_loc3_] as Quest).compareById(param1))
               {
                  if(_questBag[_loc3_].isMany() == true)
                  {
                     _loc2_ += _questBag[_loc3_].getTimes();
                  }
                  else
                  {
                     _loc2_ += 1;
                  }
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function clearQuest(param1:Number) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_questBag[_loc2_] != null)
            {
               if((_questBag[_loc2_] as Quest).getFallLevel() == param1)
               {
                  _questBag[_loc2_] = null;
               }
            }
            _loc2_++;
         }
      }
      
      public function addOtherobjBag(param1:Otherobj) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(param1.isMany() != true)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(_otherobjBag[_loc4_] == null)
               {
                  _otherobjBag[_loc4_] = param1;
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(_otherobjBag[_loc4_] != null)
            {
               if(_otherobjBag[_loc4_].compareOtherobj(param1) == true)
               {
                  while(_otherobjBag[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     _otherobjBag[_loc4_].addOtherobj(1);
                     if(param1.useOtherobj(1) == false)
                     {
                        break;
                     }
                  }
                  if(param1.getTimes() == 0)
                  {
                     break;
                  }
               }
            }
            else if(_loc2_ == -1)
            {
               _loc2_ = _loc4_;
            }
            _loc4_++;
         }
         if(param1.getTimes() > 0)
         {
            _otherobjBag[_loc2_] = param1;
         }
         return false;
      }
      
      public function addQuestBag(param1:Quest) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(param1.isMany() != true)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(_questBag[_loc4_] == null)
               {
                  _questBag[_loc4_] = param1;
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(_questBag[_loc4_] != null)
            {
               if(_questBag[_loc4_].compareQuest(param1) == true)
               {
                  while(_questBag[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     _questBag[_loc4_].addQuest(1);
                     if(param1.useQuest(1) == false)
                     {
                        break;
                     }
                  }
                  if(param1.getTimes() == 0)
                  {
                     break;
                  }
               }
            }
            else if(_loc2_ == -1)
            {
               _loc2_ = _loc4_;
            }
            _loc4_++;
         }
         if(param1.getTimes() > 0)
         {
            _questBag[_loc2_] = param1;
         }
         return false;
      }
      
      public function addToOtherobjBag(param1:Otherobj, param2:Number) : Boolean
      {
         if(_otherobjBag[param2] == null)
         {
            _otherobjBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function delEquip(param1:Number) : Equip
      {
         var _loc2_:Equip = null;
         if(_equipBag[param1] != null)
         {
            _loc2_ = _equipBag[param1];
            _equipBag[param1] = null;
         }
         return _loc2_;
      }
      
      public function delSupplies(param1:Number) : Supplies
      {
         var _loc2_:Supplies = null;
         if(_suppliesBag[param1] != null)
         {
            _loc2_ = _suppliesBag[param1];
            _suppliesBag[param1] = null;
         }
         return _loc2_;
      }
      
      public function delGem(param1:Number, param2:Number) : Gem
      {
         var _loc3_:Gem = null;
         _loc3_ = _gemBag[param1];
         if(_loc3_.getIsPile() == true)
         {
            _loc3_.useGem(param2);
            if(_loc3_.getTimes() == 0)
            {
               _gemBag[param1] = null;
            }
         }
         else
         {
            _gemBag[param1] = null;
         }
         return _loc3_.cloneGem(param2);
      }
      
      public function delQuset(param1:Number) : Quest
      {
         var _loc2_:Quest = null;
         if(_questBag[param1] != null)
         {
            _loc2_ = _questBag[param1];
            _questBag[param1] = null;
         }
         return _loc2_;
      }
      
      public function delOtherobj(param1:Number, param2:Number = 1) : Otherobj
      {
         var _loc3_:Otherobj = null;
         _loc3_ = _otherobjBag[param1];
         if(_loc3_.isMany() == true)
         {
            _loc3_.useOtherobj(param2);
            if(_loc3_.getTimes() == 0)
            {
               _otherobjBag[param1] = null;
            }
         }
         else
         {
            _otherobjBag[param1] = null;
         }
         return _loc3_.cloneOtherobj(param2);
      }
      
      public function equipBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Equip = null;
         if(_equipBag[param2] == null)
         {
            _equipBag[param2] = _equipBag[param1];
            _equipBag[param1] = null;
         }
         else
         {
            _loc3_ = _equipBag[param2];
            _equipBag[param2] = _equipBag[param1];
            _equipBag[param1] = _loc3_;
         }
      }
      
      public function suppliesBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Supplies = null;
         if(_suppliesBag[param2] == null)
         {
            _suppliesBag[param2] = _suppliesBag[param1];
            _suppliesBag[param1] = null;
         }
         else
         {
            _loc3_ = _suppliesBag[param2];
            _suppliesBag[param2] = _suppliesBag[param1];
            _suppliesBag[param1] = _loc3_;
         }
      }
      
      public function gemBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:uint = 0;
         var _loc4_:Gem = null;
         if(param1 != param2)
         {
            if(_gemBag[param2] == null)
            {
               _gemBag[param2] = _gemBag[param1];
               _gemBag[param1] = null;
            }
            else if(_gemBag[param2].getIsPile() == true && _gemBag[param2].compareGem(_gemBag[param1]) == true)
            {
               if(_gemBag[param2].getTimes() < _gemBag[param2].getPileLimit())
               {
                  _loc3_ = _gemBag[param2].getTimes() + _gemBag[param1].getTimes();
                  if(_loc3_ > _gemBag[param2].getPileLimit())
                  {
                     _gemBag[param1].useGem(_gemBag[param2].getPileLimit() - _gemBag[param2].getTimes());
                     _gemBag[param2].addGem(_gemBag[param2].getPileLimit() - _gemBag[param2].getTimes());
                  }
                  else
                  {
                     _gemBag[param2].addGem(_gemBag[param1].getTimes());
                     _gemBag[param1] = null;
                  }
               }
            }
            else
            {
               _loc4_ = _gemBag[param2];
               _gemBag[param2] = _gemBag[param1];
               _gemBag[param1] = _loc4_;
            }
         }
      }
      
      public function questBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Otherobj = null;
         if(_questBag[param2] == null)
         {
            _questBag[param2] = _questBag[param1];
            _questBag[param1] = null;
         }
         else
         {
            _loc3_ = _questBag[param2];
            _questBag[param2] = _questBag[param1];
            _questBag[param1] = _loc3_;
         }
      }
      
      public function otherobjBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:uint = 0;
         var _loc4_:Otherobj = null;
         if(param1 != param2)
         {
            if(_otherobjBag[param2] == null)
            {
               _otherobjBag[param2] = _otherobjBag[param1];
               _otherobjBag[param1] = null;
            }
            else if(_otherobjBag[param2].isMany() == true && _otherobjBag[param2].compareOtherobj(_otherobjBag[param1]) == true)
            {
               if(_otherobjBag[param2].getTimes() < _otherobjBag[param2].getPileLimit())
               {
                  _loc3_ = _otherobjBag[param2].getTimes() + _otherobjBag[param1].getTimes();
                  if(_loc3_ > _otherobjBag[param2].getPileLimit())
                  {
                     _otherobjBag[param1].useOtherobj(_otherobjBag[param2].getPileLimit() - _otherobjBag[param2].getTimes());
                     _otherobjBag[param2].addOtherobj(_otherobjBag[param2].getPileLimit() - _otherobjBag[param2].getTimes());
                  }
                  else
                  {
                     _otherobjBag[param2].addOtherobj(_otherobjBag[param1].getTimes());
                     _otherobjBag[param1] = null;
                  }
               }
            }
            else
            {
               _loc4_ = _otherobjBag[param2];
               _otherobjBag[param2] = _otherobjBag[param1];
               _otherobjBag[param1] = _loc4_;
            }
         }
      }
      
      public function isHaveOtherobj(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_otherobjBag[_loc2_] != null)
            {
               if((_otherobjBag[_loc2_] as Otherobj).compareById(param1) == true)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isHaveEquip(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] != null)
            {
               if((_equipBag[_loc2_] as Equip).compareById(param1) == true)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isHaveSupplies(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_suppliesBag[_loc2_] != null)
            {
               if((_suppliesBag[_loc2_] as Supplies).compareById(param1) == true)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isHavesQuest(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_questBag[_loc2_] != null)
            {
               if((_questBag[_loc2_] as Quest).compareById(param1) == true)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function isHaveGem(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_gemBag[_loc2_] != null)
            {
               if((_gemBag[_loc2_] as Gem).compareById(param1) == true)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getOtherobjNum(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 24)
         {
            if(_otherobjBag[_loc3_] != null)
            {
               if((_otherobjBag[_loc3_] as Otherobj).compareById(param1))
               {
                  if(_otherobjBag[_loc3_].isMany() == true)
                  {
                     _loc2_ += _otherobjBag[_loc3_].getTimes();
                  }
                  else
                  {
                     _loc2_ += 1;
                  }
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getGemNum(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 24)
         {
            if(_gemBag[_loc3_] != null)
            {
               if((_gemBag[_loc3_] as Gem).compareById(param1))
               {
                  if(_gemBag[_loc3_].getIsPile() == true)
                  {
                     _loc2_ += _gemBag[_loc3_].getTimes();
                  }
                  else
                  {
                     _loc2_ += 1;
                  }
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getEquipObjNum(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 24)
         {
            if(_equipBag[_loc3_] != null)
            {
               if((_equipBag[_loc3_] as Equip).compareById(param1))
               {
                  _loc2_ += 1;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getSupObjNum(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < 24)
         {
            if(_suppliesBag[_loc3_] != null)
            {
               if((_suppliesBag[_loc3_] as Supplies).compareById(param1))
               {
                  _loc2_ += 1;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getAndUseOtherobj(param1:Number, param2:Number = 1) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = 0;
            while(_loc4_ < 24)
            {
               if(_otherobjBag[_loc4_] != null)
               {
                  if((_otherobjBag[_loc4_] as Otherobj).compareById(param1))
                  {
                     if(_otherobjBag[_loc4_].isMany() == true)
                     {
                        _otherobjBag[_loc4_].useOtherobj(1);
                        if(_otherobjBag[_loc4_].getTimes() == 0)
                        {
                           _otherobjBag[_loc4_] = null;
                        }
                     }
                     else
                     {
                        _otherobjBag[_loc4_] = null;
                     }
                     break;
                  }
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function delGemById(param1:Number, param2:Number) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < 24)
         {
            if(!(param2 > 0))
            {
               break;
            }
            if(_gemBag[_loc4_] != null)
            {
               if((_gemBag[_loc4_] as Gem).compareById(param1))
               {
                  if(_gemBag[_loc4_].getIsPile() == true)
                  {
                     _loc5_ = 1;
                     while(_loc5_ <= param2)
                     {
                        (_gemBag[_loc4_] as Gem).useGem(1);
                        if((_gemBag[_loc4_] as Gem).getTimes() == 0)
                        {
                           _loc3_.push((_gemBag[_loc4_] as Gem).cloneGem(_loc5_));
                           param2 -= _loc5_;
                           _gemBag[_loc4_] = null;
                           break;
                        }
                        if(_loc5_ == param2)
                        {
                           _loc3_.push((_gemBag[_loc4_] as Gem).cloneGem(param2));
                           param2 = 0;
                           break;
                        }
                        _loc5_++;
                     }
                  }
                  else
                  {
                     param2--;
                     _loc3_.push((_gemBag[_loc4_] as Gem).cloneGem(1));
                     _gemBag[_loc4_] = null;
                  }
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function delOtherById(param1:Number, param2:Number = 1) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < 24)
         {
            if(!(param2 > 0))
            {
               break;
            }
            if(_otherobjBag[_loc4_] != null)
            {
               if((_otherobjBag[_loc4_] as Otherobj).compareById(param1))
               {
                  if(_otherobjBag[_loc4_].isMany() == true)
                  {
                     _loc5_ = 1;
                     while(_loc5_ <= param2)
                     {
                        (_otherobjBag[_loc4_] as Otherobj).useOtherobj(1);
                        if((_otherobjBag[_loc4_] as Otherobj).getTimes() == 0)
                        {
                           _loc3_.push((_otherobjBag[_loc4_] as Otherobj).cloneOtherobj(_loc5_));
                           param2 -= _loc5_;
                           _otherobjBag[_loc4_] = null;
                           break;
                        }
                        if(_loc5_ == param2)
                        {
                           _loc3_.push((_otherobjBag[_loc4_] as Otherobj).cloneOtherobj(param2));
                           param2 = 0;
                           break;
                        }
                        _loc5_++;
                     }
                  }
                  else
                  {
                     param2--;
                     _loc3_.push((_otherobjBag[_loc4_] as Otherobj).cloneOtherobj(1));
                     _otherobjBag[_loc4_] = null;
                  }
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function clearOther(param1:Number) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(_otherobjBag[_loc2_] != null)
            {
               if((_otherobjBag[_loc2_] as Otherobj).getId() == param1)
               {
                  _otherobjBag[_loc2_] = null;
               }
            }
            _loc2_++;
         }
      }
      
      public function getEquipById(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_equipBag[_loc5_] != null)
            {
               if((_equipBag[_loc5_] as Equip).compareById(param1))
               {
                  _loc3_.push(_equipBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getEquipByIdTOW(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_equipBag[_loc5_] != null)
            {
               if(Boolean((_equipBag[_loc5_] as Equip).compareById(param1)) && (_equipBag[_loc5_] as Equip).getRemainingTime() > 0)
               {
                  _loc3_.push(_equipBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getOtherobjById(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_otherobjBag[_loc5_] != null)
            {
               if((_otherobjBag[_loc5_] as Otherobj).compareById(param1))
               {
                  _loc3_.push(_otherobjBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getQuestById(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_questBag[_loc5_] != null)
            {
               if((_questBag[_loc5_] as Quest).compareById(param1))
               {
                  _loc3_.push(_questBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getGemById(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_gemBag[_loc5_] != null)
            {
               if((_gemBag[_loc5_] as Gem).compareById(param1))
               {
                  _loc3_.push(_gemBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getSupById(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_suppliesBag[_loc5_] != null)
            {
               if((_suppliesBag[_loc5_] as Supplies).compareById(param1))
               {
                  _loc3_.push(_suppliesBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getGemByType(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_gemBag[_loc5_] != null)
            {
               if((_gemBag[_loc5_] as Gem).getType() == param1)
               {
                  _loc3_.push(_gemBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getOtherByType(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(_otherobjBag[_loc5_] != null)
            {
               if((_otherobjBag[_loc5_] as Otherobj).getType() == param1)
               {
                  _loc3_.push(_otherobjBag[_loc5_]);
                  _loc4_.push(_loc5_);
               }
            }
            _loc5_++;
         }
         _loc2_.push(_loc3_,_loc4_);
         if(_loc3_.length < 1)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getEquipAndPoint() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < 24)
         {
            if(_equipBag[_loc4_] != null)
            {
               _loc2_.push(_equipBag[_loc4_]);
               _loc3_.push(_loc4_);
            }
            _loc4_++;
         }
         _loc1_.push(_loc2_,_loc3_);
         if(_loc2_.length < 1)
         {
            return null;
         }
         return _loc1_;
      }
      
      public function delEquipById(param1:Number, param2:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:Number = 0;
         if(param2 > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < 24)
            {
               if(_equipBag[_loc5_] != null)
               {
                  if((_equipBag[_loc5_] as Equip).compareById(param1))
                  {
                     _loc3_.push((_equipBag[_loc5_] as Equip).getClone());
                     _equipBag[_loc5_] = null;
                     if(++_loc4_ >= param2)
                     {
                        break;
                     }
                  }
               }
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public function delSuppliesById(param1:Number, param2:Number) : Array
      {
         var _loc5_:uint = 0;
         var _loc3_:Array = [];
         var _loc4_:Number = 0;
         if(param2 > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < 24)
            {
               if(_suppliesBag[_loc5_] != null)
               {
                  if((_suppliesBag[_loc5_] as Supplies).compareById(param1))
                  {
                     _loc3_.push((_suppliesBag[_loc5_] as Supplies).getClone());
                     _suppliesBag[_loc5_] = null;
                     if(++_loc4_ >= param2)
                     {
                        break;
                     }
                  }
               }
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public function cheatTesting() : *
      {
         if(Main.NoLogInfo[4])
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < 24)
         {
            if(_gemBag[_loc1_] != null)
            {
               if((_gemBag[_loc1_] as Gem).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(_gemBag[_loc1_] as Gem).getTimes());
                  break;
               }
            }
            if(_otherobjBag[_loc1_] != null)
            {
               if((_otherobjBag[_loc1_] as Otherobj).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(_otherobjBag[_loc1_] as Otherobj).getTimes());
                  break;
               }
            }
            _loc1_++;
         }
      }
      
      public function cheatEquip() : *
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 23)
         {
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < 24)
            {
               if(_equipBag[_loc1_])
               {
                  if((_equipBag[_loc1_] as Equip).testEquip(_equipBag[_loc2_]))
                  {
                     _equipBag[_loc1_] = null;
                  }
               }
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < 35)
            {
               if(Boolean(_equipBag[_loc1_]) && Boolean(StoragePanel.storage.getEquipFromStorage(_loc3_)))
               {
                  if((_equipBag[_loc1_] as Equip).testEquip(StoragePanel.storage.getEquipFromStorage(_loc3_)))
                  {
                     _equipBag[_loc1_] = null;
                  }
               }
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function cheatGem() : *
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 23)
         {
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < 24)
            {
               if(_gemBag[_loc1_])
               {
                  (_gemBag[_loc1_] as Gem).testGem(_gemBag[_loc2_]);
               }
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < 35)
            {
               if(Boolean(_gemBag[_loc1_]) && Boolean(StoragePanel.storage.getGemFromStorage(_loc3_)))
               {
                  (_gemBag[_loc1_] as Gem).testGem(StoragePanel.storage.getGemFromStorage(_loc3_));
               }
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function cheatOther() : *
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 23)
         {
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < 24)
            {
               if(_otherobjBag[_loc1_])
               {
                  (_otherobjBag[_loc1_] as Otherobj).testOtherobj(_otherobjBag[_loc2_]);
               }
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < 35)
            {
               if(Boolean(_otherobjBag[_loc1_]) && Boolean(StoragePanel.storage.getOtherobjFromStorage(_loc3_)))
               {
                  (_otherobjBag[_loc1_] as Otherobj).testOtherobj(StoragePanel.storage.getOtherobjFromStorage(_loc3_));
               }
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function plan1_5() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getGrid() == 0)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan4_15() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getGrid() == 0)
               {
                  if((_equipBag[_loc1_] as Equip).getGemSlot().getColor() == 3)
                  {
                     return true;
                  }
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function getEquipGold(param1:Number) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] != null)
            {
               if((_equipBag[_loc2_] as Equip).getDressLevel() >= param1)
               {
                  if((_equipBag[_loc2_] as Equip).getColor() >= 4)
                  {
                     return true;
                  }
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getWuQiGold(param1:Number) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] != null)
            {
               if((_equipBag[_loc2_] as Equip).getDressLevel() >= param1)
               {
                  if((_equipBag[_loc2_] as Equip).getColor() >= 4)
                  {
                     if((_equipBag[_loc2_] as Equip).getPosition() >= 5 && (_equipBag[_loc2_] as Equip).getPosition() <= 7)
                     {
                        return true;
                     }
                  }
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function plan2_5(param1:Number) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] != null)
            {
               if((_equipBag[_loc2_] as Equip).getReinforceLevel() >= param1)
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      public function plan4_16() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getNewSkill() > 0)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan5_7() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getStar() > 0)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan5_8() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getBlessAttrib())
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan5_12() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getPosition() == 8)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan5_13() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getPosition() == 9)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan5_14() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getColor() >= 4)
               {
                  if((_equipBag[_loc1_] as Equip).getPosition() == 8)
                  {
                     return true;
                  }
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan5_15() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getColor() >= 4)
               {
                  if((_equipBag[_loc1_] as Equip).getPosition() == 9)
                  {
                     return true;
                  }
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan6_10() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getId() >= 20001 && (_equipBag[_loc1_] as Equip).getId() <= 20024)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan6_14() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_otherobjBag[_loc1_] != null)
            {
               if((_otherobjBag[_loc1_] as Otherobj).getId() >= 63163 && (_otherobjBag[_loc1_] as Otherobj).getId() <= 63168)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan6_15() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] != null)
            {
               if((_equipBag[_loc2_] as Equip).getStar() >= 3)
               {
                  _loc1_++;
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function plan6_7() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getSuitId() >= 26 && (_equipBag[_loc1_] as Equip).getSuitId() <= 30)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan7_3() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            if(_equipBag[_loc1_] != null)
            {
               if((_equipBag[_loc1_] as Equip).getId() >= 20079 && (_equipBag[_loc1_] as Equip).getId() <= 20084)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function plan7_4() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 24)
         {
            if(_equipBag[_loc2_] != null)
            {
               if((_equipBag[_loc2_] as Equip).getStar() >= 4)
               {
                  _loc1_++;
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}

