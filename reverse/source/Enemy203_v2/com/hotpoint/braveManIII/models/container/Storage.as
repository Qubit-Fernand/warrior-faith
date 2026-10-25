package com.hotpoint.braveManIII.models.container
{
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import flash.utils.*;
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
         var _loc1_:Storage = new Storage();
         var _loc2_:int = 0;
         while(_loc2_ < 35)
         {
            _loc1_._equipStorage[_loc2_] = null;
            _loc1_._suppliesStorage[_loc2_] = null;
            _loc1_._gemStorage[_loc2_] = null;
            _loc1_._otherobjStorage[_loc2_] = null;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get equipStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._equipStorage;
      }
      
      public function set equipStorage(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._equipStorage = param1;
      }
      
      public function get suppliesStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._suppliesStorage;
      }
      
      public function set suppliesStorage(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._suppliesStorage = param1;
      }
      
      public function get gemStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._gemStorage;
      }
      
      public function set gemStorage(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._gemStorage = param1;
      }
      
      public function get otherobjStorage() : Array
      {
         trace("禁止get:",getQualifiedClassName(this));
         return this._otherobjStorage;
      }
      
      public function set otherobjStorage(param1:Array) : void
      {
         trace("禁止get:",getQualifiedClassName(this));
         this._otherobjStorage = param1;
      }
      
      public function getEquipFromStorage(param1:Number) : Equip
      {
         if(this._equipStorage[param1] != null)
         {
            return this._equipStorage[param1];
         }
         return null;
      }
      
      public function getSuppliesFromStorage(param1:Number) : Supplies
      {
         if(this._suppliesStorage[param1] != null)
         {
            return this._suppliesStorage[param1];
         }
         return null;
      }
      
      public function getGemFromStorage(param1:Number) : Gem
      {
         if(this._gemStorage[param1] != null)
         {
            return this._gemStorage[param1];
         }
         return null;
      }
      
      public function getOtherobjFromStorage(param1:Number) : Otherobj
      {
         if(this._otherobjStorage[param1] != null)
         {
            return this._otherobjStorage[param1];
         }
         return null;
      }
      
      public function backEquipEmptyNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 35)
         {
            if(this._equipStorage[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backSuppliesEmptyNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 35)
         {
            if(this._suppliesStorage[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backGemEmptyNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 35)
         {
            if(this._gemStorage[_loc2_] == null)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function backOtherEmptyNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 35)
         {
            if(this._otherobjStorage[_loc2_] == null)
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
         while(_loc6_ < 35)
         {
            if(this._gemStorage[_loc6_] == null)
            {
               _loc5_ += _loc4_;
            }
            else if(_loc2_.compareGem(this._gemStorage[_loc6_]) == true)
            {
               _loc7_ = _loc4_ - this._gemStorage[_loc6_].getTimes();
               _loc5_ += _loc7_;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function canPutOtherNum(param1:Number) : uint
      {
         var _loc7_:uint = 0;
         var _loc2_:Otherobj = OtherFactory.creatOther(param1);
         var _loc3_:uint = _loc2_.getTimes();
         var _loc4_:uint = _loc2_.getPileLimit();
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         while(_loc6_ < 35)
         {
            if(this._otherobjStorage[_loc6_] == null)
            {
               _loc5_ += _loc4_;
            }
            else if(_loc2_.compareOtherobj(this._otherobjStorage[_loc6_]) == true)
            {
               _loc7_ = _loc4_ - this._otherobjStorage[_loc6_].getTimes();
               _loc5_ += _loc7_;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function addEquipStorage(param1:Equip) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 35)
         {
            if(this._equipStorage[_loc2_] == null)
            {
               this._equipStorage[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function addToEquipStorage(param1:Equip, param2:Number) : *
      {
         this._equipStorage[param2] = param1;
      }
      
      public function addSuppliesStorage(param1:Supplies) : Boolean
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 35)
         {
            if(this._suppliesStorage[_loc2_] == null)
            {
               this._suppliesStorage[_loc2_] = param1;
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function addToSuppliesStorage(param1:Supplies, param2:Number) : *
      {
         this._suppliesStorage[param2] = param1;
      }
      
      public function addGemStorage(param1:Gem) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(param1.getIsPile() != true)
         {
            _loc4_ = 0;
            while(_loc4_ < 35)
            {
               if(this._gemStorage[_loc4_] == null)
               {
                  this._gemStorage[_loc4_] = param1;
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 35)
         {
            if(this._gemStorage[_loc4_] != null)
            {
               if(this._gemStorage[_loc4_].compareGem(param1) == true)
               {
                  while(param1.getTimes() > 0 && this._gemStorage[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     this._gemStorage[_loc4_].addGem(1);
                     param1.useGem(1);
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
            this._gemStorage[_loc2_] = param1;
         }
         return false;
      }
      
      public function addToGemStorage(param1:Gem, param2:Number) : *
      {
         this._gemStorage[param2] = param1;
      }
      
      public function addOtherobjStorage(param1:Otherobj) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(param1.isMany() != true)
         {
            _loc4_ = 0;
            while(_loc4_ < 35)
            {
               if(this._otherobjStorage[_loc4_] == null)
               {
                  this._otherobjStorage[_loc4_] = param1;
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         _loc2_ = -1;
         _loc3_ = true;
         _loc4_ = 0;
         while(_loc4_ < 35)
         {
            if(this._otherobjStorage[_loc4_] != null)
            {
               if(this._otherobjStorage[_loc4_].compareOtherobj(param1) == true)
               {
                  while(param1.getTimes() > 0 && this._otherobjStorage[_loc4_].getTimes() < param1.getPileLimit())
                  {
                     this._otherobjStorage[_loc4_].addOtherobj(1);
                     param1.useOtherobj(1);
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
            this._otherobjStorage[_loc2_] = param1;
         }
         return false;
      }
      
      public function addToOtherobjStorage(param1:Otherobj, param2:Number) : *
      {
         this._otherobjStorage[param2] = param1;
      }
      
      public function delEquip(param1:Number) : Equip
      {
         var _loc2_:Equip = null;
         if(this._equipStorage[param1] != null)
         {
            _loc2_ = this._equipStorage[param1];
            this._equipStorage[param1] = null;
         }
         return _loc2_;
      }
      
      public function delSupplies(param1:Number) : Supplies
      {
         var _loc2_:Supplies = null;
         if(this._suppliesStorage[param1] != null)
         {
            _loc2_ = this._suppliesStorage[param1];
            this._suppliesStorage[param1] = null;
         }
         return _loc2_;
      }
      
      public function delGem(param1:Number, param2:Number) : Gem
      {
         var _loc3_:Gem = null;
         _loc3_ = this._gemStorage[param1];
         if(_loc3_.getIsPile() == true)
         {
            _loc3_.useGem(param2);
            if(_loc3_.getTimes() == 0)
            {
               this._gemStorage[param1] = null;
            }
         }
         else
         {
            this._gemStorage[param1] = null;
         }
         return _loc3_.cloneGem(param2);
      }
      
      public function delOtherobj(param1:Number, param2:Number) : Otherobj
      {
         var _loc3_:Otherobj = null;
         _loc3_ = this._otherobjStorage[param1];
         if(_loc3_.isMany() == true)
         {
            _loc3_.useOtherobj(param2);
            if(_loc3_.getTimes() == 0)
            {
               this._otherobjStorage[param1] = null;
            }
         }
         else
         {
            this._otherobjStorage[param1] = null;
         }
         return _loc3_.cloneOtherobj(param2);
      }
      
      public function equipStorageMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Equip = null;
         if(this._equipStorage[param2] == null)
         {
            this._equipStorage[param2] = this._equipStorage[param1];
            this._equipStorage[param1] = null;
         }
         else
         {
            _loc3_ = this._equipStorage[param2];
            this._equipStorage[param2] = this._equipStorage[param1];
            this._equipStorage[param1] = _loc3_;
         }
      }
      
      public function suppliesStorageMove(param1:Number, param2:Number) : *
      {
         var _loc3_:Supplies = null;
         if(this._suppliesStorage[param2] == null)
         {
            this._suppliesStorage[param2] = this._suppliesStorage[param1];
            this._suppliesStorage[param1] = null;
         }
         else
         {
            _loc3_ = this._suppliesStorage[param2];
            this._suppliesStorage[param2] = this._suppliesStorage[param1];
            this._suppliesStorage[param1] = _loc3_;
         }
      }
      
      public function gemStorageMove(param1:Number, param2:Number) : *
      {
         var _loc3_:uint = 0;
         var _loc4_:Gem = null;
         if(param1 != param2)
         {
            if(this._gemStorage[param2] == null)
            {
               this._gemStorage[param2] = this._gemStorage[param1];
               this._gemStorage[param1] = null;
            }
            else if(this._gemStorage[param2].getIsPile() == true && Boolean(this._gemStorage[param2].compareGem(this._gemStorage[param1])))
            {
               if(this._gemStorage[param2].getTimes() < this._gemStorage[param2].getPileLimit())
               {
                  _loc3_ = this._gemStorage[param2].getTimes() + this._gemStorage[param1].getTimes();
                  if(_loc3_ > this._gemStorage[param2].getPileLimit())
                  {
                     this._gemStorage[param1].useGem(this._gemStorage[param2].getPileLimit() - this._gemStorage[param2].getTimes());
                     this._gemStorage[param2].addGem(this._gemStorage[param2].getPileLimit() - this._gemStorage[param2].getTimes());
                  }
                  else
                  {
                     this._gemStorage[param2].addGem(this._gemStorage[param1].getTimes());
                     this._gemStorage[param1] = null;
                  }
               }
            }
            else
            {
               _loc4_ = this._gemStorage[param2];
               this._gemStorage[param2] = this._gemStorage[param1];
               this._gemStorage[param1] = _loc4_;
            }
         }
      }
      
      public function otherobjStorageMove(param1:Number, param2:Number) : *
      {
         var _loc3_:uint = 0;
         var _loc4_:Otherobj = null;
         if(param1 != param2)
         {
            if(this._otherobjStorage[param2] == null)
            {
               this._otherobjStorage[param2] = this._otherobjStorage[param1];
               this._otherobjStorage[param1] = null;
            }
            else if(this._otherobjStorage[param2].isMany() == true && Boolean(this._otherobjStorage[param2].compareOtherobj(this._otherobjStorage[param1])))
            {
               if(this._otherobjStorage[param2].getTimes() < this._otherobjStorage[param2].getPileLimit())
               {
                  _loc3_ = this._otherobjStorage[param2].getTimes() + this._otherobjStorage[param1].getTimes();
                  if(_loc3_ > this._otherobjStorage[param2].getPileLimit())
                  {
                     this._otherobjStorage[param1].useOtherobj(this._otherobjStorage[param2].getPileLimit() - this._otherobjStorage[param2].getTimes());
                     this._otherobjStorage[param2].addOtherobj(this._otherobjStorage[param2].getPileLimit() - this._otherobjStorage[param2].getTimes());
                  }
                  else
                  {
                     this._otherobjStorage[param2].addOtherobj(this._otherobjStorage[param1].getTimes());
                     this._otherobjStorage[param1] = null;
                  }
               }
            }
            else
            {
               _loc4_ = this._otherobjStorage[param2];
               this._otherobjStorage[param2] = this._otherobjStorage[param1];
               this._otherobjStorage[param1] = _loc4_;
            }
         }
      }
      
      public function cheatTesting() : *
      {
         if(Main.NoLogInfo[4])
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < 35)
         {
            if(this._gemStorage[_loc1_] != null)
            {
               if((this._gemStorage[_loc1_] as Gem).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._gemStorage[_loc1_] as Gem).getTimes());
                  break;
               }
            }
            if(this._otherobjStorage[_loc1_] != null)
            {
               if((this._otherobjStorage[_loc1_] as Otherobj).getTimes() >= 1000)
               {
                  SaveXX.Save(4,(this._otherobjStorage[_loc1_] as Otherobj).getTimes());
                  break;
               }
            }
            _loc1_++;
         }
      }
      
      public function cheatGem() : *
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 34)
         {
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < 35)
            {
               if(this._gemStorage[_loc1_])
               {
                  (this._gemStorage[_loc1_] as Gem).testGem(this._gemStorage[_loc2_]);
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function cheatOther() : *
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 34)
         {
            _loc2_ = _loc1_ + 1;
            while(_loc2_ < 35)
            {
               if(this._otherobjStorage[_loc1_])
               {
                  (this._otherobjStorage[_loc1_] as Otherobj).testOtherobj(this._otherobjStorage[_loc2_]);
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
   }
}

