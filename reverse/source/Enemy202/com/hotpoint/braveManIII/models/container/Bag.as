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
         return this._equipBag;
      }
      
      public function set equipBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._equipBag = param1;
      }
      
      public function get suppliesBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._suppliesBag;
      }
      
      public function set suppliesBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._suppliesBag = param1;
      }
      
      public function get gemBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._gemBag;
      }
      
      public function set gemBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gemBag = param1;
      }
      
      public function get questBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._questBag;
      }
      
      public function set questBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._questBag = param1;
      }
      
      public function get otherobjBag() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._otherobjBag;
      }
      
      public function set otherobjBag(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._otherobjBag = param1;
      }
      
      public function getEquipBag() : Array
      {
         return this._equipBag.slice();
      }
      
      public function getEquipFromBag(param1:Number) : Equip
      {
         if(this._equipBag[param1] != null && this._equipBag[param1] is Equip)
         {
            return this._equipBag[param1];
         }
         return null;
      }
      
      public function getSuppliesBag() : Array
      {
         return this._suppliesBag.slice();
      }
      
      public function getSuppliesFromBag(param1:Number) : Supplies
      {
         if(this._suppliesBag[param1] != null)
         {
            return this._suppliesBag[param1];
         }
         return null;
      }
      
      public function getGemBag() : Array
      {
         return this._gemBag.slice();
      }
      
      public function getGemFromBag(param1:Number) : Gem
      {
         if(this._gemBag[param1] != null)
         {
            return this._gemBag[param1];
         }
         return null;
      }
      
      public function getQuestBag() : Array
      {
         return this._questBag.slice();
      }
      
      public function getQuestFromBag(param1:Number) : Quest
      {
         if(this._questBag[param1] != null)
         {
            return this._questBag[param1];
         }
         return null;
      }
      
      public function getOtherobjFromBag(param1:Number) : Otherobj
      {
         if(this._otherobjBag[param1] != null)
         {
            return this._otherobjBag[param1];
         }
         return null;
      }
      
      public function getOtherobjBag() : Array
      {
         return this._otherobjBag.slice();
      }
      
      public function addEquipBag(param1:Equip) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(this._equipBag[_loc2_] == null)
            {
               this._equipBag[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function addToEquipBag(param1:Equip, param2:Number) : Boolean
      {
         if(this._equipBag[param2] == null)
         {
            this._equipBag[param2] = param1;
            return true;
         }
         return false;
      }
      
      public function addSuppliesBag(param1:Supplies) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(this._suppliesBag[_loc2_] == null)
            {
               this._suppliesBag[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function addToSuppliesBag(param1:Supplies, param2:Number) : Boolean
      {
         if(this._suppliesBag[param2] == null)
         {
            this._suppliesBag[param2] = param1;
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
            if(this._equipBag[_loc2_] == null)
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
            if(this._questBag[_loc2_] == null)
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
            if(this._suppliesBag[_loc2_] == null)
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
            if(this._gemBag[_loc2_] == null)
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
            if(this._gemBag[_loc6_] == null)
            {
               _loc5_ += _loc4_;
            }
            else if(_loc2_.compareGem(this._gemBag[_loc6_]) == true)
            {
               _loc7_ = _loc4_ - this._gemBag[_loc6_].getTimes();
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
            if(this._otherobjBag[_loc2_] == null)
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
            if(this._otherobjBag[_loc6_] == null)
            {
               _loc5_ += _loc4_;
            }
            else if(_loc2_.compareOtherobj(this._otherobjBag[_loc6_]) == true)
            {
               _loc7_ = _loc4_ - this._otherobjBag[_loc6_].getTimes();
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
            while(true)
            {
               if(_loc3_ < 24)
               {
                  if(this._gemBag[_loc3_] == null)
                  {
                     break;
                  }
                  _loc3_++;
                  continue;
               }
            }
            return true;
         }
         _loc2_ = true;
         _loc3_ = 0;
         while(_loc3_ < 24)
         {
            if(this._gemBag[_loc3_] == null)
            {
               return true;
            }
            if(this._gemBag[_loc3_].compareGem(param1) == true)
            {
               if(this._gemBag[_loc3_].getTimes() + param1.getTimes() < param1.getPileLimit())
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
         CheckTest.Testing();
         if(param1.getIsPile() != true)
         {
            _loc4_ = 0;
            while(true)
            {
               if(_loc4_ < 24)
               {
                  if(this._gemBag[_loc4_] == null)
                  {
                     break;
                  }
                  _loc4_++;
                  continue;
               }
            }
            this._gemBag[_loc4_] = param1;
            CheckTest.setMD5();
            return true;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(this._gemBag[_loc4_] != null)
            {
               if(this._gemBag[_loc4_].compareGem(param1) == true)
               {
                  while(this._gemBag[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     this._gemBag[_loc4_].addGem(1);
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
            this._gemBag[_loc2_] = param1;
         }
         CheckTest.setMD5();
         CheckTest.setMD5();
         return false;
      }
      
      public function addToGemBag(param1:Gem, param2:Number) : Boolean
      {
         CheckTest.Testing();
         if(this._gemBag[param2] == null)
         {
            this._gemBag[param2] = param1;
            CheckTest.setMD5();
            return true;
         }
         return false;
      }
      
      public function addToQuestBag(param1:Quest, param2:Number) : Boolean
      {
         if(this._questBag[param2] == null)
         {
            this._questBag[param2] = param1;
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
            if(this._questBag[_loc3_] != null)
            {
               if((this._questBag[_loc3_] as Quest).compareById(param1))
               {
                  if(this._questBag[_loc3_].isMany() == true)
                  {
                     _loc2_ += this._questBag[_loc3_].getTimes();
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
            if(this._questBag[_loc2_] != null)
            {
               if((this._questBag[_loc2_] as Quest).getFallLevel() == param1)
               {
                  this._questBag[_loc2_] = null;
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
         CheckTest.TestingOther();
         if(param1.isMany() != true)
         {
            _loc4_ = 0;
            while(true)
            {
               if(_loc4_ < 24)
               {
                  if(this._otherobjBag[_loc4_] == null)
                  {
                     break;
                  }
                  _loc4_++;
                  continue;
               }
            }
            this._otherobjBag[_loc4_] = param1;
            CheckTest.setMD5Other();
            return true;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(this._otherobjBag[_loc4_] != null)
            {
               if(this._otherobjBag[_loc4_].compareOtherobj(param1) == true)
               {
                  while(this._otherobjBag[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     this._otherobjBag[_loc4_].addOtherobj(1);
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
            this._otherobjBag[_loc2_] = param1;
         }
         CheckTest.setMD5Other();
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
            while(true)
            {
               if(_loc4_ < 24)
               {
                  if(this._questBag[_loc4_] == null)
                  {
                     break;
                  }
                  _loc4_++;
                  continue;
               }
            }
            this._questBag[_loc4_] = param1;
            return true;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 24)
         {
            if(this._questBag[_loc4_] != null)
            {
               if(this._questBag[_loc4_].compareQuest(param1) == true)
               {
                  while(this._questBag[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     this._questBag[_loc4_].addQuest(1);
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
            this._questBag[_loc2_] = param1;
         }
         return false;
      }
      
      public function addToOtherobjBag(param1:Otherobj, param2:Number) : Boolean
      {
         CheckTest.TestingOther();
         if(this._otherobjBag[param2] == null)
         {
            this._otherobjBag[param2] = param1;
            CheckTest.setMD5Other();
            return true;
         }
         return false;
      }
      
      public function delEquip(param1:Number) : Equip
      {
         var _loc2_:Equip = null;
         if(this._equipBag[param1] != null)
         {
            _loc2_ = this._equipBag[param1];
            this._equipBag[param1] = null;
         }
         return _loc2_;
      }
      
      public function delSupplies(param1:Number) : Supplies
      {
         var _loc2_:Supplies = null;
         if(this._suppliesBag[param1] != null)
         {
            _loc2_ = this._suppliesBag[param1];
            this._suppliesBag[param1] = null;
         }
         return _loc2_;
      }
      
      public function delGem(param1:Number, param2:Number) : Gem
      {
         var _loc3_:Gem = null;
         CheckTest.Testing();
         _loc3_ = this._gemBag[param1];
         if(_loc3_.getIsPile() == true)
         {
            _loc3_.useGem(param2);
            if(_loc3_.getTimes() == 0)
            {
               this._gemBag[param1] = null;
            }
         }
         else
         {
            this._gemBag[param1] = null;
         }
         CheckTest.setMD5();
         return _loc3_.cloneGem(param2);
      }
      
      public function delQuset(param1:Number) : Quest
      {
         var _loc2_:Quest = null;
         if(this._questBag[param1] != null)
         {
            _loc2_ = this._questBag[param1];
            this._questBag[param1] = null;
         }
         return _loc2_;
      }
      
      public function delOtherobj(param1:Number, param2:Number = 1) : Otherobj
      {
         var _loc3_:Otherobj = null;
         CheckTest.TestingOther();
         _loc3_ = this._otherobjBag[param1];
         if(_loc3_.isMany() == true)
         {
            _loc3_.useOtherobj(param2);
            if(_loc3_.getTimes() == 0)
            {
               this._otherobjBag[param1] = null;
            }
         }
         else
         {
            this._otherobjBag[param1] = null;
         }
         CheckTest.setMD5Other();
         return _loc3_.cloneOtherobj(param2);
      }
      
      public function equipBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Equip = null;
         if(this._equipBag[param2] == null)
         {
            this._equipBag[param2] = this._equipBag[param1];
            this._equipBag[param1] = null;
         }
         else
         {
            _loc3_ = this._equipBag[param2];
            this._equipBag[param2] = this._equipBag[param1];
            this._equipBag[param1] = _loc3_;
         }
      }
      
      public function suppliesBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Supplies = null;
         if(this._suppliesBag[param2] == null)
         {
            this._suppliesBag[param2] = this._suppliesBag[param1];
            this._suppliesBag[param1] = null;
         }
         else
         {
            _loc3_ = this._suppliesBag[param2];
            this._suppliesBag[param2] = this._suppliesBag[param1];
            this._suppliesBag[param1] = _loc3_;
         }
      }
      
      public function gemBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:uint = 0;
         var _loc4_:Gem = null;
         CheckTest.Testing();
         if(param1 != param2)
         {
            if(this._gemBag[param2] == null)
            {
               this._gemBag[param2] = this._gemBag[param1];
               this._gemBag[param1] = null;
            }
            else if(this._gemBag[param2].getIsPile() == true && this._gemBag[param2].compareGem(this._gemBag[param1]) == true)
            {
               if(this._gemBag[param2].getTimes() < this._gemBag[param2].getPileLimit())
               {
                  _loc3_ = this._gemBag[param2].getTimes() + this._gemBag[param1].getTimes();
                  if(_loc3_ > this._gemBag[param2].getPileLimit())
                  {
                     this._gemBag[param1].useGem(this._gemBag[param2].getPileLimit() - this._gemBag[param2].getTimes());
                     this._gemBag[param2].addGem(this._gemBag[param2].getPileLimit() - this._gemBag[param2].getTimes());
                  }
                  else
                  {
                     this._gemBag[param2].addGem(this._gemBag[param1].getTimes());
                     this._gemBag[param1] = null;
                  }
               }
            }
            else
            {
               _loc4_ = this._gemBag[param2];
               this._gemBag[param2] = this._gemBag[param1];
               this._gemBag[param1] = _loc4_;
            }
         }
         CheckTest.setMD5();
      }
      
      public function questBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Otherobj = null;
         if(this._questBag[param2] == null)
         {
            this._questBag[param2] = this._questBag[param1];
            this._questBag[param1] = null;
         }
         else
         {
            _loc3_ = this._questBag[param2];
            this._questBag[param2] = this._questBag[param1];
            this._questBag[param1] = _loc3_;
         }
      }
      
      public function otherobjBagMove(param1:Number, param2:Number) : *
      {
         var _loc3_:uint = 0;
         var _loc4_:Otherobj = null;
         CheckTest.TestingOther();
         if(param1 != param2)
         {
            if(this._otherobjBag[param2] == null)
            {
               this._otherobjBag[param2] = this._otherobjBag[param1];
               this._otherobjBag[param1] = null;
            }
            else if(this._otherobjBag[param2].isMany() == true && this._otherobjBag[param2].compareOtherobj(this._otherobjBag[param1]) == true)
            {
               if(this._otherobjBag[param2].getTimes() < this._otherobjBag[param2].getPileLimit())
               {
                  _loc3_ = this._otherobjBag[param2].getTimes() + this._otherobjBag[param1].getTimes();
                  if(_loc3_ > this._otherobjBag[param2].getPileLimit())
                  {
                     this._otherobjBag[param1].useOtherobj(this._otherobjBag[param2].getPileLimit() - this._otherobjBag[param2].getTimes());
                     this._otherobjBag[param2].addOtherobj(this._otherobjBag[param2].getPileLimit() - this._otherobjBag[param2].getTimes());
                  }
                  else
                  {
                     this._otherobjBag[param2].addOtherobj(this._otherobjBag[param1].getTimes());
                     this._otherobjBag[param1] = null;
                  }
               }
            }
            else
            {
               _loc4_ = this._otherobjBag[param2];
               this._otherobjBag[param2] = this._otherobjBag[param1];
               this._otherobjBag[param1] = _loc4_;
            }
         }
         CheckTest.setMD5Other();
      }
      
      public function isHaveOtherobj(param1:Number) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(this._otherobjBag[_loc2_] != null)
            {
               if((this._otherobjBag[_loc2_] as Otherobj).compareById(param1) == true)
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
            if(this._equipBag[_loc2_] != null)
            {
               if((this._equipBag[_loc2_] as Equip).compareById(param1) == true)
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
            if(this._suppliesBag[_loc2_] != null)
            {
               if((this._suppliesBag[_loc2_] as Supplies).compareById(param1) == true)
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
            if(this._questBag[_loc2_] != null)
            {
               if((this._questBag[_loc2_] as Quest).compareById(param1) == true)
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
            if(this._gemBag[_loc2_] != null)
            {
               if((this._gemBag[_loc2_] as Gem).compareById(param1) == true)
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
            if(this._otherobjBag[_loc3_] != null)
            {
               if((this._otherobjBag[_loc3_] as Otherobj).compareById(param1))
               {
                  if(this._otherobjBag[_loc3_].isMany() == true)
                  {
                     _loc2_ += this._otherobjBag[_loc3_].getTimes();
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
            if(this._gemBag[_loc3_] != null)
            {
               if((this._gemBag[_loc3_] as Gem).compareById(param1))
               {
                  if(this._gemBag[_loc3_].getIsPile() == true)
                  {
                     _loc2_ += this._gemBag[_loc3_].getTimes();
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
            if(this._equipBag[_loc3_] != null)
            {
               if((this._equipBag[_loc3_] as Equip).compareById(param1))
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
            if(this._suppliesBag[_loc3_] != null)
            {
               if((this._suppliesBag[_loc3_] as Supplies).compareById(param1))
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
               if(this._otherobjBag[_loc4_] != null)
               {
                  if((this._otherobjBag[_loc4_] as Otherobj).compareById(param1))
                  {
                     if(this._otherobjBag[_loc4_].isMany() == true)
                     {
                        this._otherobjBag[_loc4_].useOtherobj(1);
                        if(this._otherobjBag[_loc4_].getTimes() == 0)
                        {
                           this._otherobjBag[_loc4_] = null;
                        }
                     }
                     else
                     {
                        this._otherobjBag[_loc4_] = null;
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
         CheckTest.Testing();
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < 24)
         {
            if(param2 <= 0)
            {
               break;
            }
            if(this._gemBag[_loc4_] != null)
            {
               if((this._gemBag[_loc4_] as Gem).compareById(param1))
               {
                  if(this._gemBag[_loc4_].getIsPile() == true)
                  {
                     _loc5_ = 1;
                     while(_loc5_ <= param2)
                     {
                        (this._gemBag[_loc4_] as Gem).useGem(1);
                        if((this._gemBag[_loc4_] as Gem).getTimes() == 0)
                        {
                           _loc3_.push((this._gemBag[_loc4_] as Gem).cloneGem(_loc5_));
                           param2 -= _loc5_;
                           this._gemBag[_loc4_] = null;
                           break;
                        }
                        if(_loc5_ == param2)
                        {
                           _loc3_.push((this._gemBag[_loc4_] as Gem).cloneGem(param2));
                           param2 = 0;
                           break;
                        }
                        _loc5_++;
                     }
                  }
                  else
                  {
                     param2--;
                     _loc3_.push((this._gemBag[_loc4_] as Gem).cloneGem(1));
                     this._gemBag[_loc4_] = null;
                  }
               }
            }
            _loc4_++;
         }
         CheckTest.setMD5();
         return _loc3_;
      }
      
      public function delOtherById(param1:Number, param2:Number) : Array
      {
         var _loc5_:int = 0;
         CheckTest.TestingOther();
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < 24)
         {
            if(param2 <= 0)
            {
               break;
            }
            if(this._otherobjBag[_loc4_] != null)
            {
               if((this._otherobjBag[_loc4_] as Otherobj).compareById(param1))
               {
                  if(this._otherobjBag[_loc4_].isMany() == true)
                  {
                     _loc5_ = 1;
                     while(_loc5_ <= param2)
                     {
                        (this._otherobjBag[_loc4_] as Otherobj).useOtherobj(1);
                        if((this._otherobjBag[_loc4_] as Otherobj).getTimes() == 0)
                        {
                           _loc3_.push((this._otherobjBag[_loc4_] as Otherobj).cloneOtherobj(_loc5_));
                           param2 -= _loc5_;
                           this._otherobjBag[_loc4_] = null;
                           break;
                        }
                        if(_loc5_ == param2)
                        {
                           _loc3_.push((this._otherobjBag[_loc4_] as Otherobj).cloneOtherobj(param2));
                           param2 = 0;
                           break;
                        }
                        _loc5_++;
                     }
                  }
                  else
                  {
                     param2--;
                     _loc3_.push((this._otherobjBag[_loc4_] as Otherobj).cloneOtherobj(1));
                     this._otherobjBag[_loc4_] = null;
                  }
               }
            }
            _loc4_++;
         }
         CheckTest.setMD5Other();
         return _loc3_;
      }
      
      public function clearOther(param1:Number) : void
      {
         CheckTest.TestingOther();
         var _loc2_:uint = 0;
         while(_loc2_ < 24)
         {
            if(this._otherobjBag[_loc2_] != null)
            {
               if((this._otherobjBag[_loc2_] as Otherobj).getId() == param1)
               {
                  this._otherobjBag[_loc2_] = null;
               }
            }
            _loc2_++;
         }
         CheckTest.setMD5Other();
      }
      
      public function getEquipById(param1:Number) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc5_:uint = 0;
         while(_loc5_ < 24)
         {
            if(this._equipBag[_loc5_] != null)
            {
               if((this._equipBag[_loc5_] as Equip).compareById(param1))
               {
                  _loc3_.push(this._equipBag[_loc5_]);
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
            if(this._equipBag[_loc5_] != null)
            {
               if(Boolean((this._equipBag[_loc5_] as Equip).compareById(param1)) && (this._equipBag[_loc5_] as Equip).getRemainingTime() > 0)
               {
                  _loc3_.push(this._equipBag[_loc5_]);
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
            if(this._otherobjBag[_loc5_] != null)
            {
               if((this._otherobjBag[_loc5_] as Otherobj).compareById(param1))
               {
                  _loc3_.push(this._otherobjBag[_loc5_]);
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
            if(this._questBag[_loc5_] != null)
            {
               if((this._questBag[_loc5_] as Quest).compareById(param1))
               {
                  _loc3_.push(this._questBag[_loc5_]);
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
            if(this._gemBag[_loc5_] != null)
            {
               if((this._gemBag[_loc5_] as Gem).compareById(param1))
               {
                  _loc3_.push(this._gemBag[_loc5_]);
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
            if(this._suppliesBag[_loc5_] != null)
            {
               if((this._suppliesBag[_loc5_] as Supplies).compareById(param1))
               {
                  _loc3_.push(this._suppliesBag[_loc5_]);
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
            if(this._gemBag[_loc5_] != null)
            {
               if((this._gemBag[_loc5_] as Gem).getType() == param1)
               {
                  _loc3_.push(this._gemBag[_loc5_]);
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
            if(this._otherobjBag[_loc5_] != null)
            {
               if((this._otherobjBag[_loc5_] as Otherobj).getType() == param1)
               {
                  _loc3_.push(this._otherobjBag[_loc5_]);
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
            if(this._equipBag[_loc4_] != null)
            {
               _loc2_.push(this._equipBag[_loc4_]);
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
               if(this._equipBag[_loc5_] != null)
               {
                  if((this._equipBag[_loc5_] as Equip).compareById(param1))
                  {
                     _loc3_.push((this._equipBag[_loc5_] as Equip).getClone());
                     this._equipBag[_loc5_] = null;
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
               if(this._suppliesBag[_loc5_] != null)
               {
                  if((this._suppliesBag[_loc5_] as Supplies).compareById(param1))
                  {
                     _loc3_.push((this._suppliesBag[_loc5_] as Supplies).getClone());
                     this._suppliesBag[_loc5_] = null;
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
            if(this._gemBag[_loc1_] != null)
            {
               if((this._gemBag[_loc1_] as Gem).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._gemBag[_loc1_] as Gem).getTimes());
                  break;
               }
               if((this._gemBag[_loc1_] as Gem).getId() == 33213)
               {
                  if((this._gemBag[_loc1_] as Gem).getTimes() > 90)
                  {
                     SaveXX.Save(4,(this._gemBag[_loc1_] as Gem).getTimes());
                     break;
                  }
               }
            }
            if(this._otherobjBag[_loc1_] != null)
            {
               if((this._otherobjBag[_loc1_] as Otherobj).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._otherobjBag[_loc1_] as Otherobj).getTimes());
                  break;
               }
            }
            _loc1_++;
         }
      }
   }
}

