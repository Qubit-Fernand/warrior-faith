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
         bag = Main.player1.getBag();
         storage = StoragePanel.storage;
         if(Main.player2)
         {
            bag2P = Main.player2.getBag();
         }
      }
      
      public function equipHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         if(param1.name.substr(0,3) == "s1_")
         {
            bag.equipBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getEquipFromBag(param3) != null)
            {
               _loc4_ = bag.delEquip(param3);
               bag.addToEquipBag(storage.getEquipFromStorage(param2),param3);
               storage.delEquip(param2);
               storage.addToEquipStorage(_loc4_,param2);
            }
            else
            {
               bag.addToEquipBag(storage.getEquipFromStorage(param2),param3);
               storage.delEquip(param2);
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
            bag2P.equipBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getEquipFromBag(param3) != null)
            {
               _loc4_ = bag2P.delEquip(param3);
               bag2P.addToEquipBag(storage.getEquipFromStorage(param2),param3);
               storage.delEquip(param2);
               storage.addToEquipStorage(_loc4_,param2);
            }
            else
            {
               bag2P.addToEquipBag(storage.getEquipFromStorage(param2),param3);
               storage.delEquip(param2);
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
            storage.equipStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(storage.getEquipFromStorage(param3) != null)
            {
               _loc4_ = storage.delEquip(param3);
               storage.addToEquipStorage(bag.getEquipFromBag(param2),param3);
               bag.delEquip(param2);
               bag.addToEquipBag(_loc4_,param2);
            }
            else
            {
               storage.addToEquipStorage(bag.getEquipFromBag(param2),param3);
               bag.delEquip(param2);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getEquipFromStorage(param3) != null)
            {
               _loc4_ = storage.delEquip(param3);
               storage.addToEquipStorage(bag2P.getEquipFromBag(param2),param3);
               bag2P.delEquip(param2);
               bag2P.addToEquipBag(_loc4_,param2);
            }
            else
            {
               storage.addToEquipStorage(bag2P.getEquipFromBag(param2),param3);
               bag2P.delEquip(param2);
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
            bag.suppliesBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getSuppliesFromBag(param3) != null)
            {
               _loc4_ = bag.delSupplies(param3);
               bag.addToSuppliesBag(storage.getSuppliesFromStorage(param2),param3);
               storage.delSupplies(param2);
               storage.addToSuppliesStorage(_loc4_,param2);
            }
            else
            {
               bag.addToSuppliesBag(storage.getSuppliesFromStorage(param2),param3);
               storage.delSupplies(param2);
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
            bag2P.suppliesBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getSuppliesFromBag(param3) != null)
            {
               _loc4_ = bag2P.delSupplies(param3);
               bag2P.addToSuppliesBag(storage.getSuppliesFromStorage(param2),param3);
               storage.delSupplies(param2);
               storage.addToSuppliesStorage(_loc4_,param2);
            }
            else
            {
               bag2P.addToSuppliesBag(storage.getSuppliesFromStorage(param2),param3);
               storage.delSupplies(param2);
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
            storage.suppliesStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(storage.getSuppliesFromStorage(param3) != null)
            {
               _loc4_ = storage.delSupplies(param3);
               storage.addToSuppliesStorage(bag.getSuppliesFromBag(param2),param3);
               bag.delSupplies(param2);
               bag.addToSuppliesBag(_loc4_,param2);
            }
            else
            {
               storage.addToSuppliesStorage(bag.getSuppliesFromBag(param2),param3);
               bag.delSupplies(param2);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getSuppliesFromStorage(param3) != null)
            {
               _loc4_ = storage.delSupplies(param3);
               storage.addToSuppliesStorage(bag2P.getSuppliesFromBag(param2),param3);
               bag2P.delSupplies(param2);
               bag2P.addToSuppliesBag(_loc4_,param2);
            }
            else
            {
               storage.addToSuppliesStorage(bag2P.getSuppliesFromBag(param2),param3);
               bag2P.delSupplies(param2);
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
            bag.gemBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getGemFromBag(param3) != null)
            {
               _loc4_ = bag.delGem(param3,bag.getGemFromBag(param3).getTimes());
               bag.addToGemBag(storage.getGemFromStorage(param2),param3);
               storage.addToGemStorage(_loc4_,param2);
            }
            else
            {
               bag.addToGemBag(storage.delGem(param2,storage.getGemFromStorage(param2).getTimes()),param3);
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
            bag2P.gemBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getGemFromBag(param3) != null)
            {
               _loc4_ = bag2P.delGem(param3,bag2P.getGemFromBag(param3).getTimes());
               bag2P.addToGemBag(storage.getGemFromStorage(param2),param3);
               storage.addToGemStorage(_loc4_,param2);
            }
            else
            {
               bag2P.addToGemBag(storage.delGem(param2,storage.getGemFromStorage(param2).getTimes()),param3);
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
            storage.gemStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(storage.getGemFromStorage(param3) != null)
            {
               _loc4_ = storage.delGem(param3,storage.getGemFromStorage(param3).getTimes());
               storage.addToGemStorage(bag.delGem(param2,bag.getGemFromBag(param2).getTimes()),param3);
               bag.addToGemBag(_loc4_,param2);
            }
            else
            {
               storage.addToGemStorage(bag.delGem(param2,bag.getGemFromBag(param2).getTimes()),param3);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getGemFromStorage(param3) != null)
            {
               _loc4_ = storage.delGem(param3,storage.getGemFromStorage(param3).getTimes());
               storage.addToGemStorage(bag2P.delGem(param2,bag2P.getGemFromBag(param2).getTimes()),param3);
               bag2P.addToGemBag(_loc4_,param2);
            }
            else
            {
               storage.addToGemStorage(bag2P.delGem(param2,bag2P.getGemFromBag(param2).getTimes()),param3);
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
               if(storage.backEquipEmptyNum() > 0)
               {
                  storage.addEquipStorage(bag.getEquipFromBag(param2));
                  bag.delEquip(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(storage.backSuppliesEmptyNum() > 0)
               {
                  storage.addSuppliesStorage(bag.getSuppliesFromBag(param2));
                  bag.delSupplies(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(storage.backGemEmptyNum() > 0)
               {
                  storage.addGemStorage(bag.delGem(param2,bag.getGemFromBag(param2).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(storage.backOtherEmptyNum() > 0)
               {
                  storage.addOtherobjStorage(bag.delOtherobj(param2,bag.getOtherobjFromBag(param2).getTimes()));
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
               if(storage.backEquipEmptyNum() > 0)
               {
                  storage.addEquipStorage(bag2P.getEquipFromBag(param2));
                  bag2P.delEquip(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(storage.backSuppliesEmptyNum() > 0)
               {
                  storage.addSuppliesStorage(bag2P.getSuppliesFromBag(param2));
                  bag2P.delSupplies(param2);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(storage.backGemEmptyNum() > 0)
               {
                  storage.addGemStorage(bag2P.delGem(param2,bag2P.getGemFromBag(param2).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(storage.backOtherEmptyNum() > 0)
               {
                  storage.addOtherobjStorage(bag2P.delOtherobj(param2,bag2P.getOtherobjFromBag(param2).getTimes()));
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
            bag.otherobjBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getOtherobjFromBag(param3) != null)
            {
               _loc4_ = bag.delOtherobj(param3,bag.getOtherobjFromBag(param3).getTimes());
               bag.addToOtherobjBag(storage.getOtherobjFromStorage(param2),param3);
               storage.addToOtherobjStorage(_loc4_,param2);
            }
            else
            {
               bag.addToOtherobjBag(storage.delOtherobj(param2,storage.getOtherobjFromStorage(param2).getTimes()),param3);
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
            bag2P.otherobjBagMove(param2,param3);
         }
         else
         {
            if(param1.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getOtherobjFromBag(param3) != null)
            {
               _loc4_ = bag2P.delOtherobj(param3,bag2P.getOtherobjFromBag(param3).getTimes());
               bag2P.addToOtherobjBag(storage.getOtherobjFromStorage(param2),param3);
               storage.addToOtherobjStorage(_loc4_,param2);
            }
            else
            {
               bag2P.addToOtherobjBag(storage.delOtherobj(param2,storage.getOtherobjFromStorage(param2).getTimes()),param3);
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
            storage.otherobjStorageMove(param2,param3);
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            if(storage.getOtherobjFromStorage(param3) != null)
            {
               _loc4_ = storage.delOtherobj(param3,storage.getOtherobjFromStorage(param3).getTimes());
               storage.addToOtherobjStorage(bag.delOtherobj(param2,bag.getOtherobjFromBag(param2).getTimes()),param3);
               bag.addToOtherobjBag(_loc4_,param2);
            }
            else
            {
               storage.addToOtherobjStorage(bag.delOtherobj(param2,bag.getOtherobjFromBag(param2).getTimes()),param3);
            }
         }
         else
         {
            if(param1.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getOtherobjFromStorage(param3) != null)
            {
               _loc4_ = storage.delOtherobj(param3,storage.getOtherobjFromStorage(param3).getTimes());
               storage.addToOtherobjStorage(bag2P.delOtherobj(param2,bag2P.getOtherobjFromBag(param2).getTimes()),param3);
               bag2P.addToOtherobjBag(_loc4_,param2);
            }
            else
            {
               storage.addToOtherobjStorage(bag2P.delOtherobj(param2,bag2P.getOtherobjFromBag(param2).getTimes()),param3);
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

