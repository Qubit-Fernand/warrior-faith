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
      
      private var bag2P:Bag = new Bag();
      
      private var bag:Bag = new Bag();
      
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
      
      public function suppliesHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var supplies:Supplies = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.suppliesBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getSuppliesFromBag(end) != null)
            {
               supplies = bag2P.delSupplies(end);
               bag2P.addToSuppliesBag(storage.getSuppliesFromStorage(begin),end);
               storage.delSupplies(begin);
               storage.addToSuppliesStorage(supplies,begin);
            }
            else
            {
               bag2P.addToSuppliesBag(storage.getSuppliesFromStorage(begin),end);
               storage.delSupplies(begin);
            }
         }
         StorageItemsShow.suppliesShow2P();
         StorageItemsShow.suppliesStorageShow();
         return true;
      }
      
      public function suppliesStorageHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var supplies:Supplies = null;
         if(dragObj.name.substr(0,3) == "kc_")
         {
            storage.suppliesStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(storage.getSuppliesFromStorage(end) != null)
            {
               supplies = storage.delSupplies(end);
               storage.addToSuppliesStorage(bag.getSuppliesFromBag(begin),end);
               bag.delSupplies(begin);
               bag.addToSuppliesBag(supplies,begin);
            }
            else
            {
               storage.addToSuppliesStorage(bag.getSuppliesFromBag(begin),end);
               bag.delSupplies(begin);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getSuppliesFromStorage(end) != null)
            {
               supplies = storage.delSupplies(end);
               storage.addToSuppliesStorage(bag2P.getSuppliesFromBag(begin),end);
               bag2P.delSupplies(begin);
               bag2P.addToSuppliesBag(supplies,begin);
            }
            else
            {
               storage.addToSuppliesStorage(bag2P.getSuppliesFromBag(begin),end);
               bag2P.delSupplies(begin);
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
      
      public function otherStorageHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var oo:Otherobj = null;
         if(dragObj.name.substr(0,3) == "kc_")
         {
            storage.otherobjStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(storage.getOtherobjFromStorage(end) != null)
            {
               oo = storage.delOtherobj(end,storage.getOtherobjFromStorage(end).getTimes());
               storage.addToOtherobjStorage(bag.delOtherobj(begin,bag.getOtherobjFromBag(begin).getTimes()),end);
               bag.addToOtherobjBag(oo,begin);
            }
            else
            {
               storage.addToOtherobjStorage(bag.delOtherobj(begin,bag.getOtherobjFromBag(begin).getTimes()),end);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getOtherobjFromStorage(end) != null)
            {
               oo = storage.delOtherobj(end,storage.getOtherobjFromStorage(end).getTimes());
               storage.addToOtherobjStorage(bag2P.delOtherobj(begin,bag2P.getOtherobjFromBag(begin).getTimes()),end);
               bag2P.addToOtherobjBag(oo,begin);
            }
            else
            {
               storage.addToOtherobjStorage(bag2P.delOtherobj(begin,bag2P.getOtherobjFromBag(begin).getTimes()),end);
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
      
      public function putInStorageHandle2P(itemsType:Number, begin:Number) : *
      {
         switch(itemsType)
         {
            case 1:
               if(storage.backEquipEmptyNum() > 0)
               {
                  storage.addEquipStorage(bag2P.getEquipFromBag(begin));
                  bag2P.delEquip(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(storage.backSuppliesEmptyNum() > 0)
               {
                  storage.addSuppliesStorage(bag2P.getSuppliesFromBag(begin));
                  bag2P.delSupplies(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(storage.backGemEmptyNum() > 0)
               {
                  storage.addGemStorage(bag2P.delGem(begin,bag2P.getGemFromBag(begin).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(storage.backOtherEmptyNum() > 0)
               {
                  storage.addOtherobjStorage(bag2P.delOtherobj(begin,bag2P.getOtherobjFromBag(begin).getTimes()));
                  break;
               }
               ShortTip.open(3);
         }
      }
      
      public function otherHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var oo:Otherobj = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.otherobjBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getOtherobjFromBag(end) != null)
            {
               oo = bag2P.delOtherobj(end,bag2P.getOtherobjFromBag(end).getTimes());
               bag2P.addToOtherobjBag(storage.getOtherobjFromStorage(begin),end);
               storage.addToOtherobjStorage(oo,begin);
            }
            else
            {
               bag2P.addToOtherobjBag(storage.delOtherobj(begin,storage.getOtherobjFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.otherobjShow2P();
         StorageItemsShow.otherobjStorageShow();
         return true;
      }
      
      public function gemStorageHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "kc_")
         {
            storage.gemStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(storage.getGemFromStorage(end) != null)
            {
               gem = storage.delGem(end,storage.getGemFromStorage(end).getTimes());
               storage.addToGemStorage(bag.delGem(begin,bag.getGemFromBag(begin).getTimes()),end);
               bag.addToGemBag(gem,begin);
            }
            else
            {
               storage.addToGemStorage(bag.delGem(begin,bag.getGemFromBag(begin).getTimes()),end);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getGemFromStorage(end) != null)
            {
               gem = storage.delGem(end,storage.getGemFromStorage(end).getTimes());
               storage.addToGemStorage(bag2P.delGem(begin,bag2P.getGemFromBag(begin).getTimes()),end);
               bag2P.addToGemBag(gem,begin);
            }
            else
            {
               storage.addToGemStorage(bag2P.delGem(begin,bag2P.getGemFromBag(begin).getTimes()),end);
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
      
      public function suppliesHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var supplies:Supplies = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.suppliesBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getSuppliesFromBag(end) != null)
            {
               supplies = bag.delSupplies(end);
               bag.addToSuppliesBag(storage.getSuppliesFromStorage(begin),end);
               storage.delSupplies(begin);
               storage.addToSuppliesStorage(supplies,begin);
            }
            else
            {
               bag.addToSuppliesBag(storage.getSuppliesFromStorage(begin),end);
               storage.delSupplies(begin);
            }
         }
         StorageItemsShow.suppliesShow();
         StorageItemsShow.suppliesStorageShow();
         return true;
      }
      
      public function equipHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.equipBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getEquipFromBag(end) != null)
            {
               equip = bag2P.delEquip(end);
               bag2P.addToEquipBag(storage.getEquipFromStorage(begin),end);
               storage.delEquip(begin);
               storage.addToEquipStorage(equip,begin);
            }
            else
            {
               bag2P.addToEquipBag(storage.getEquipFromStorage(begin),end);
               storage.delEquip(begin);
            }
         }
         StorageItemsShow.equipShow2P();
         StorageItemsShow.equipStorageShow();
         return true;
      }
      
      public function gemHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.gemBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getGemFromBag(end) != null)
            {
               gem = bag.delGem(end,bag.getGemFromBag(end).getTimes());
               bag.addToGemBag(storage.getGemFromStorage(begin),end);
               storage.addToGemStorage(gem,begin);
            }
            else
            {
               bag.addToGemBag(storage.delGem(begin,storage.getGemFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.gemShow();
         StorageItemsShow.gemStorageShow();
         return true;
      }
      
      public function equipHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.equipBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getEquipFromBag(end) != null)
            {
               equip = bag.delEquip(end);
               bag.addToEquipBag(storage.getEquipFromStorage(begin),end);
               storage.delEquip(begin);
               storage.addToEquipStorage(equip,begin);
            }
            else
            {
               bag.addToEquipBag(storage.getEquipFromStorage(begin),end);
               storage.delEquip(begin);
            }
         }
         StorageItemsShow.equipShow();
         StorageItemsShow.equipStorageShow();
         return true;
      }
      
      public function equipStorageHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(dragObj.name.substr(0,3) == "kc_")
         {
            storage.equipStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(storage.getEquipFromStorage(end) != null)
            {
               equip = storage.delEquip(end);
               storage.addToEquipStorage(bag.getEquipFromBag(begin),end);
               bag.delEquip(begin);
               bag.addToEquipBag(equip,begin);
            }
            else
            {
               storage.addToEquipStorage(bag.getEquipFromBag(begin),end);
               bag.delEquip(begin);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(storage.getEquipFromStorage(end) != null)
            {
               equip = storage.delEquip(end);
               storage.addToEquipStorage(bag2P.getEquipFromBag(begin),end);
               bag2P.delEquip(begin);
               bag2P.addToEquipBag(equip,begin);
            }
            else
            {
               storage.addToEquipStorage(bag2P.getEquipFromBag(begin),end);
               bag2P.delEquip(begin);
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
      
      public function gemHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.gemBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag2P.getGemFromBag(end) != null)
            {
               gem = bag2P.delGem(end,bag2P.getGemFromBag(end).getTimes());
               bag2P.addToGemBag(storage.getGemFromStorage(begin),end);
               storage.addToGemStorage(gem,begin);
            }
            else
            {
               bag2P.addToGemBag(storage.delGem(begin,storage.getGemFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.gemShow2P();
         StorageItemsShow.gemStorageShow();
         return true;
      }
      
      public function putInStorageHandle(itemsType:Number, begin:Number) : *
      {
         switch(itemsType)
         {
            case 1:
               if(storage.backEquipEmptyNum() > 0)
               {
                  storage.addEquipStorage(bag.getEquipFromBag(begin));
                  bag.delEquip(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(storage.backSuppliesEmptyNum() > 0)
               {
                  storage.addSuppliesStorage(bag.getSuppliesFromBag(begin));
                  bag.delSupplies(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(storage.backGemEmptyNum() > 0)
               {
                  storage.addGemStorage(bag.delGem(begin,bag.getGemFromBag(begin).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(storage.backOtherEmptyNum() > 0)
               {
                  storage.addOtherobjStorage(bag.delOtherobj(begin,bag.getOtherobjFromBag(begin).getTimes()));
                  break;
               }
               ShortTip.open(3);
         }
      }
      
      public function otherHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var oo:Otherobj = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.otherobjBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(bag.getOtherobjFromBag(end) != null)
            {
               oo = bag.delOtherobj(end,bag.getOtherobjFromBag(end).getTimes());
               bag.addToOtherobjBag(storage.getOtherobjFromStorage(begin),end);
               storage.addToOtherobjStorage(oo,begin);
            }
            else
            {
               bag.addToOtherobjBag(storage.delOtherobj(begin,storage.getOtherobjFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.otherobjShow();
         StorageItemsShow.otherobjStorageShow();
         return true;
      }
   }
}

