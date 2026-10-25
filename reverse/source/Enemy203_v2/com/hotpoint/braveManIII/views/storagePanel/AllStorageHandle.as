package com.hotpoint.braveManIII.views.storagePanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import src.*;
   
   public class AllStorageHandle
   {
      
      private var bag:Bag = new Bag();
      
      private var bag2P:Bag = new Bag();
      
      private var storage:Storage = new Storage();
      
      public function AllStorageHandle()
      {
         super();
         this.bag = Main.player1.getBag();
         this.storage = StoragePanel.storage;
         if(Main.player2)
         {
            this.bag2P = Main.player2.getBag();
         }
      }
      
      public function equipHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         if(param1.name.substr(0,3) == "s1_")
         {
            this.bag.equipBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getEquipFromBag(param3) != null)
            {
               _loc4_ = this.bag.delEquip(param3);
               this.bag.addToEquipBag(this.storage.getEquipFromStorage(param2),param3);
               this.storage.delEquip(param2);
               this.storage.addToEquipStorage(_loc4_,param2);
            }
            else
            {
               this.bag.addToEquipBag(this.storage.getEquipFromStorage(param2),param3);
               this.storage.delEquip(param2);
            }
         }
         StorageItemsShow.equipShow();
         StorageItemsShow.equipStorageShow();
         return true;
      }
      
      public function equipHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         if(param1.name.substr(0,3) == "s2_")
         {
            this.bag2P.equipBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getEquipFromBag(param3) != null)
            {
               _loc4_ = this.bag2P.delEquip(param3);
               this.bag2P.addToEquipBag(this.storage.getEquipFromStorage(param2),param3);
               this.storage.delEquip(param2);
               this.storage.addToEquipStorage(_loc4_,param2);
            }
            else
            {
               this.bag2P.addToEquipBag(this.storage.getEquipFromStorage(param2),param3);
               this.storage.delEquip(param2);
            }
         }
         StorageItemsShow.equipShow2P();
         StorageItemsShow.equipStorageShow();
         return true;
      }
      
      public function equipStorageHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         if(param1.name.substr(0,3) == "kc_")
         {
            this.storage.equipStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(this.storage.getEquipFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delEquip(param3);
               this.storage.addToEquipStorage(this.bag.getEquipFromBag(param2),param3);
               this.bag.delEquip(param2);
               this.bag.addToEquipBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToEquipStorage(this.bag.getEquipFromBag(param2),param3);
               this.bag.delEquip(param2);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getEquipFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delEquip(param3);
               this.storage.addToEquipStorage(this.bag2P.getEquipFromBag(param2),param3);
               this.bag2P.delEquip(param2);
               this.bag2P.addToEquipBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToEquipStorage(this.bag2P.getEquipFromBag(param2),param3);
               this.bag2P.delEquip(param2);
            }
         }
         StorageItemsShow.equipShow();
         StorageItemsShow.equipStorageShow();
         if(Main.player2)
         {
            StorageItemsShow.equipShow2P();
         }
         return true;
      }
      
      public function suppliesHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Supplies = null;
         if(param1.name.substr(0,3) == "s1_")
         {
            this.bag.suppliesBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getSuppliesFromBag(param3) != null)
            {
               _loc4_ = this.bag.delSupplies(param3);
               this.bag.addToSuppliesBag(this.storage.getSuppliesFromStorage(param2),param3);
               this.storage.delSupplies(param2);
               this.storage.addToSuppliesStorage(_loc4_,param2);
            }
            else
            {
               this.bag.addToSuppliesBag(this.storage.getSuppliesFromStorage(param2),param3);
               this.storage.delSupplies(param2);
            }
         }
         StorageItemsShow.suppliesShow();
         StorageItemsShow.suppliesStorageShow();
         return true;
      }
      
      public function suppliesHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Supplies = null;
         if(param1.name.substr(0,3) == "s2_")
         {
            this.bag2P.suppliesBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getSuppliesFromBag(param3) != null)
            {
               _loc4_ = this.bag2P.delSupplies(param3);
               this.bag2P.addToSuppliesBag(this.storage.getSuppliesFromStorage(param2),param3);
               this.storage.delSupplies(param2);
               this.storage.addToSuppliesStorage(_loc4_,param2);
            }
            else
            {
               this.bag2P.addToSuppliesBag(this.storage.getSuppliesFromStorage(param2),param3);
               this.storage.delSupplies(param2);
            }
         }
         StorageItemsShow.suppliesShow2P();
         StorageItemsShow.suppliesStorageShow();
         return true;
      }
      
      public function suppliesStorageHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Supplies = null;
         if(param1.name.substr(0,3) == "kc_")
         {
            this.storage.suppliesStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(this.storage.getSuppliesFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delSupplies(param3);
               this.storage.addToSuppliesStorage(this.bag.getSuppliesFromBag(param2),param3);
               this.bag.delSupplies(param2);
               this.bag.addToSuppliesBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToSuppliesStorage(this.bag.getSuppliesFromBag(param2),param3);
               this.bag.delSupplies(param2);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getSuppliesFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delSupplies(param3);
               this.storage.addToSuppliesStorage(this.bag2P.getSuppliesFromBag(param2),param3);
               this.bag2P.delSupplies(param2);
               this.bag2P.addToSuppliesBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToSuppliesStorage(this.bag2P.getSuppliesFromBag(param2),param3);
               this.bag2P.delSupplies(param2);
            }
         }
         StorageItemsShow.suppliesShow();
         if(Main.player2)
         {
            StorageItemsShow.suppliesShow2P();
         }
         StorageItemsShow.suppliesStorageShow();
         return true;
      }
      
      public function gemHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Gem = null;
         if(param1.name.substr(0,3) == "s1_")
         {
            this.bag.gemBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getGemFromBag(param3) != null)
            {
               _loc4_ = this.bag.delGem(param3,this.bag.getGemFromBag(param3).getTimes());
               this.bag.addToGemBag(this.storage.getGemFromStorage(param2),param3);
               this.storage.addToGemStorage(_loc4_,param2);
            }
            else
            {
               this.bag.addToGemBag(this.storage.delGem(param2,this.storage.getGemFromStorage(param2).getTimes()),param3);
            }
         }
         StorageItemsShow.gemShow();
         StorageItemsShow.gemStorageShow();
         return true;
      }
      
      public function gemHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Gem = null;
         if(param1.name.substr(0,3) == "s2_")
         {
            this.bag2P.gemBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getGemFromBag(param3) != null)
            {
               _loc4_ = this.bag2P.delGem(param3,this.bag2P.getGemFromBag(param3).getTimes());
               this.bag2P.addToGemBag(this.storage.getGemFromStorage(param2),param3);
               this.storage.addToGemStorage(_loc4_,param2);
            }
            else
            {
               this.bag2P.addToGemBag(this.storage.delGem(param2,this.storage.getGemFromStorage(param2).getTimes()),param3);
            }
         }
         StorageItemsShow.gemShow2P();
         StorageItemsShow.gemStorageShow();
         return true;
      }
      
      public function gemStorageHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Gem = null;
         if(param1.name.substr(0,3) == "kc_")
         {
            this.storage.gemStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(this.storage.getGemFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delGem(param3,this.storage.getGemFromStorage(param3).getTimes());
               this.storage.addToGemStorage(this.bag.delGem(param2,this.bag.getGemFromBag(param2).getTimes()),param3);
               this.bag.addToGemBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToGemStorage(this.bag.delGem(param2,this.bag.getGemFromBag(param2).getTimes()),param3);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getGemFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delGem(param3,this.storage.getGemFromStorage(param3).getTimes());
               this.storage.addToGemStorage(this.bag2P.delGem(param2,this.bag2P.getGemFromBag(param2).getTimes()),param3);
               this.bag2P.addToGemBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToGemStorage(this.bag2P.delGem(param2,this.bag2P.getGemFromBag(param2).getTimes()),param3);
            }
         }
         StorageItemsShow.gemShow();
         if(Main.player2)
         {
            StorageItemsShow.gemShow2P();
         }
         StorageItemsShow.gemStorageShow();
         return true;
      }
      
      public function putInStorageHandle(param1:Number, param2:Number) : *
      {
         switch(param1)
         {
            case 1:
               if(this.storage.backEquipEmptyNum() > 0)
               {
                  this.storage.addEquipStorage(this.bag.getEquipFromBag(param2));
                  this.bag.delEquip(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(this.storage.backSuppliesEmptyNum() > 0)
               {
                  this.storage.addSuppliesStorage(this.bag.getSuppliesFromBag(param2));
                  this.bag.delSupplies(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(this.storage.backGemEmptyNum() > 0)
               {
                  this.storage.addGemStorage(this.bag.delGem(param2,this.bag.getGemFromBag(param2).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(this.storage.backOtherEmptyNum() > 0)
               {
                  this.storage.addOtherobjStorage(this.bag.delOtherobj(param2,this.bag.getOtherobjFromBag(param2).getTimes()));
                  break;
               }
               ShortTip.open(3);
         }
      }
      
      public function putInStorageHandle2P(param1:Number, param2:Number) : *
      {
         switch(param1)
         {
            case 1:
               if(this.storage.backEquipEmptyNum() > 0)
               {
                  this.storage.addEquipStorage(this.bag2P.getEquipFromBag(param2));
                  this.bag2P.delEquip(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(this.storage.backSuppliesEmptyNum() > 0)
               {
                  this.storage.addSuppliesStorage(this.bag2P.getSuppliesFromBag(param2));
                  this.bag2P.delSupplies(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(this.storage.backGemEmptyNum() > 0)
               {
                  this.storage.addGemStorage(this.bag2P.delGem(param2,this.bag2P.getGemFromBag(param2).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(this.storage.backOtherEmptyNum() > 0)
               {
                  this.storage.addOtherobjStorage(this.bag2P.delOtherobj(param2,this.bag2P.getOtherobjFromBag(param2).getTimes()));
                  break;
               }
               ShortTip.open(3);
         }
      }
      
      public function otherHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Otherobj = null;
         if(param1.name.substr(0,3) == "s1_")
         {
            this.bag.otherobjBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getOtherobjFromBag(param3) != null)
            {
               _loc4_ = this.bag.delOtherobj(param3,this.bag.getOtherobjFromBag(param3).getTimes());
               this.bag.addToOtherobjBag(this.storage.getOtherobjFromStorage(param2),param3);
               this.storage.addToOtherobjStorage(_loc4_,param2);
            }
            else
            {
               this.bag.addToOtherobjBag(this.storage.delOtherobj(param2,this.storage.getOtherobjFromStorage(param2).getTimes()),param3);
            }
         }
         StorageItemsShow.otherobjShow();
         StorageItemsShow.otherobjStorageShow();
         return true;
      }
      
      public function otherHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Otherobj = null;
         if(param1.name.substr(0,3) == "s2_")
         {
            this.bag2P.otherobjBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getOtherobjFromBag(param3) != null)
            {
               _loc4_ = this.bag2P.delOtherobj(param3,this.bag2P.getOtherobjFromBag(param3).getTimes());
               this.bag2P.addToOtherobjBag(this.storage.getOtherobjFromStorage(param2),param3);
               this.storage.addToOtherobjStorage(_loc4_,param2);
            }
            else
            {
               this.bag2P.addToOtherobjBag(this.storage.delOtherobj(param2,this.storage.getOtherobjFromStorage(param2).getTimes()),param3);
            }
         }
         StorageItemsShow.otherobjShow2P();
         StorageItemsShow.otherobjStorageShow();
         return true;
      }
      
      public function otherStorageHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Otherobj = null;
         if(param1.name.substr(0,3) == "kc_")
         {
            this.storage.otherobjStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(this.storage.getOtherobjFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delOtherobj(param3,this.storage.getOtherobjFromStorage(param3).getTimes());
               this.storage.addToOtherobjStorage(this.bag.delOtherobj(param2,this.bag.getOtherobjFromBag(param2).getTimes()),param3);
               this.bag.addToOtherobjBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToOtherobjStorage(this.bag.delOtherobj(param2,this.bag.getOtherobjFromBag(param2).getTimes()),param3);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getOtherobjFromStorage(param3) != null)
            {
               _loc4_ = this.storage.delOtherobj(param3,this.storage.getOtherobjFromStorage(param3).getTimes());
               this.storage.addToOtherobjStorage(this.bag2P.delOtherobj(param2,this.bag2P.getOtherobjFromBag(param2).getTimes()),param3);
               this.bag2P.addToOtherobjBag(_loc4_,param2);
            }
            else
            {
               this.storage.addToOtherobjStorage(this.bag2P.delOtherobj(param2,this.bag2P.getOtherobjFromBag(param2).getTimes()),param3);
            }
         }
         StorageItemsShow.otherobjShow();
         if(Main.player2)
         {
            StorageItemsShow.otherobjShow2P();
         }
         StorageItemsShow.otherobjStorageShow();
         return true;
      }
   }
}

