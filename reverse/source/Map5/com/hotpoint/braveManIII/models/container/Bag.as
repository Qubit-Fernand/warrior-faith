package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.quest.*;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
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
         var _loc1_:Bag = null;
         var _loc2_:int = 0;
         _loc1_ = new Bag();
         _loc2_ = 0;
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
      
      public function backQuestBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         _loc2_ = 0;
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
      
      public function fallQusetBag(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < 24)
         {
            if(_questBag[_loc3_] != null)
            {
               if((_questBag[_loc3_] as Quest).getFallLevel() == param1)
               {
                  _loc2_++;
               }
            }
            _loc3_++;
         }
         return _loc2_;
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
      
      public function set questBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _questBag = param1;
      }
      
      public function addQuestBag(param1:Quest) : Boolean
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < 24)
         {
            if(_questBag[_loc2_] == null)
            {
               _questBag[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function delOtherobj(param1:Number) : Otherobj
      {
         var _loc2_:Otherobj = null;
         if(_otherobjBag[param1] != null)
         {
            _loc2_ = _otherobjBag[param1];
            _otherobjBag[param1] = null;
         }
         return _loc2_;
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
      
      public function clearQuest(param1:Number) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
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
      
      public function otherobjBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Otherobj = null;
         if(_otherobjBag[param2] == null)
         {
            _otherobjBag[param2] = _otherobjBag[param1];
            _otherobjBag[param1] = null;
         }
         else
         {
            _loc3_ = _otherobjBag[param2];
            _otherobjBag[param2] = _otherobjBag[param1];
            _otherobjBag[param1] = _loc3_;
         }
      }
      
      public function addSuppliesBag(param1:Supplies) : Boolean
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
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
      
      public function get otherobjBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _otherobjBag;
      }
      
      public function getEquipFromBag(param1:Number) : Equip
      {
         if(_equipBag[param1] != null)
         {
            return _equipBag[param1];
         }
         return null;
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
      
      public function getGemFromBag(param1:Number) : Gem
      {
         if(_gemBag[param1] != null)
         {
            return _gemBag[param1];
         }
         return null;
      }
      
      public function getGemBag() : Array
      {
         return _gemBag.slice();
      }
      
      public function getQuestFromBag(param1:Number) : Quest
      {
         if(_questBag[param1] != null)
         {
            return _questBag[param1];
         }
         return null;
      }
      
      public function getEquipBag() : Array
      {
         return _equipBag.slice();
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
      
      public function getSuppliesFromBag(param1:Number) : Supplies
      {
         if(_suppliesBag[param1] != null)
         {
            return _suppliesBag[param1];
         }
         return null;
      }
      
      public function getQuestBag() : Array
      {
         return _questBag.slice();
      }
      
      public function addOtherobjBag(param1:Otherobj) : Boolean
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < 24)
         {
            if(_otherobjBag[_loc2_] == null)
            {
               _otherobjBag[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function set otherobjBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _otherobjBag = param1;
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
      
      public function backSuppliesBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         _loc2_ = 0;
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
      
      public function addToEquipBag(param1:Equip, param2:Number) : Boolean
      {
         if(_equipBag[param2] == null)
         {
            _equipBag[param2] = param1;
            return true;
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
      
      public function addToSuppliesBag(param1:Supplies, param2:Number) : Boolean
      {
         if(_suppliesBag[param2] == null)
         {
            _suppliesBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function getOtherobjFromBag(param1:Number) : Otherobj
      {
         if(_otherobjBag[param1] != null)
         {
            return _otherobjBag[param1];
         }
         return null;
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
      
      public function backGemBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         _loc2_ = 0;
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
      
      public function backequipBagNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         _loc2_ = 0;
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
      
      public function addToQuestBag(param1:Quest, param2:Number) : Boolean
      {
         if(_questBag[param2] == null)
         {
            _questBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function getOtherobjBag() : Array
      {
         return _otherobjBag.slice();
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
      
      public function set equipBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _equipBag = param1;
      }
      
      public function set gemBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _gemBag = param1;
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
      
      public function set suppliesBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         _suppliesBag = param1;
      }
      
      public function addEquipBag(param1:Equip) : Boolean
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
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
      
      public function get suppliesBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return _suppliesBag;
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
   }
}

