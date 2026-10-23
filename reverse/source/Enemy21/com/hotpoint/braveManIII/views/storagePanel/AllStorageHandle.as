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
      
      public function equipHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag.equipBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getEquipFromBag(end) != null)
            {
               equip = this.bag.delEquip(end);
               this.bag.addToEquipBag(this.storage.getEquipFromStorage(begin),end);
               this.storage.delEquip(begin);
               this.storage.addToEquipStorage(equip,begin);
            }
            else
            {
               this.bag.addToEquipBag(this.storage.getEquipFromStorage(begin),end);
               this.storage.delEquip(begin);
            }
         }
         StorageItemsShow.equipShow();
         StorageItemsShow.equipStorageShow();
         return true;
      }
      
      public function equipHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            this.bag2P.equipBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getEquipFromBag(end) != null)
            {
               equip = this.bag2P.delEquip(end);
               this.bag2P.addToEquipBag(this.storage.getEquipFromStorage(begin),end);
               this.storage.delEquip(begin);
               this.storage.addToEquipStorage(equip,begin);
            }
            else
            {
               this.bag2P.addToEquipBag(this.storage.getEquipFromStorage(begin),end);
               this.storage.delEquip(begin);
            }
         }
         StorageItemsShow.equipShow2P();
         StorageItemsShow.equipStorageShow();
         return true;
      }
      
      public function equipStorageHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(dragObj.name.substr(0,3) == "kc_")
         {
            this.storage.equipStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(this.storage.getEquipFromStorage(end) != null)
            {
               equip = this.storage.delEquip(end);
               this.storage.addToEquipStorage(this.bag.getEquipFromBag(begin),end);
               this.bag.delEquip(begin);
               this.bag.addToEquipBag(equip,begin);
            }
            else
            {
               this.storage.addToEquipStorage(this.bag.getEquipFromBag(begin),end);
               this.bag.delEquip(begin);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getEquipFromStorage(end) != null)
            {
               equip = this.storage.delEquip(end);
               this.storage.addToEquipStorage(this.bag2P.getEquipFromBag(begin),end);
               this.bag2P.delEquip(begin);
               this.bag2P.addToEquipBag(equip,begin);
            }
            else
            {
               this.storage.addToEquipStorage(this.bag2P.getEquipFromBag(begin),end);
               this.bag2P.delEquip(begin);
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
      
      public function suppliesHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var supplies:Supplies = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag.suppliesBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getSuppliesFromBag(end) != null)
            {
               supplies = this.bag.delSupplies(end);
               this.bag.addToSuppliesBag(this.storage.getSuppliesFromStorage(begin),end);
               this.storage.delSupplies(begin);
               this.storage.addToSuppliesStorage(supplies,begin);
            }
            else
            {
               this.bag.addToSuppliesBag(this.storage.getSuppliesFromStorage(begin),end);
               this.storage.delSupplies(begin);
            }
         }
         StorageItemsShow.suppliesShow();
         StorageItemsShow.suppliesStorageShow();
         return true;
      }
      
      public function suppliesHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var supplies:Supplies = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            this.bag2P.suppliesBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getSuppliesFromBag(end) != null)
            {
               supplies = this.bag2P.delSupplies(end);
               this.bag2P.addToSuppliesBag(this.storage.getSuppliesFromStorage(begin),end);
               this.storage.delSupplies(begin);
               this.storage.addToSuppliesStorage(supplies,begin);
            }
            else
            {
               this.bag2P.addToSuppliesBag(this.storage.getSuppliesFromStorage(begin),end);
               this.storage.delSupplies(begin);
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
            this.storage.suppliesStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(this.storage.getSuppliesFromStorage(end) != null)
            {
               supplies = this.storage.delSupplies(end);
               this.storage.addToSuppliesStorage(this.bag.getSuppliesFromBag(begin),end);
               this.bag.delSupplies(begin);
               this.bag.addToSuppliesBag(supplies,begin);
            }
            else
            {
               this.storage.addToSuppliesStorage(this.bag.getSuppliesFromBag(begin),end);
               this.bag.delSupplies(begin);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getSuppliesFromStorage(end) != null)
            {
               supplies = this.storage.delSupplies(end);
               this.storage.addToSuppliesStorage(this.bag2P.getSuppliesFromBag(begin),end);
               this.bag2P.delSupplies(begin);
               this.bag2P.addToSuppliesBag(supplies,begin);
            }
            else
            {
               this.storage.addToSuppliesStorage(this.bag2P.getSuppliesFromBag(begin),end);
               this.bag2P.delSupplies(begin);
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
      
      public function gemHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag.gemBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getGemFromBag(end) != null)
            {
               gem = this.bag.delGem(end,this.bag.getGemFromBag(end).getTimes());
               this.bag.addToGemBag(this.storage.getGemFromStorage(begin),end);
               this.storage.addToGemStorage(gem,begin);
            }
            else
            {
               this.bag.addToGemBag(this.storage.delGem(begin,this.storage.getGemFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.gemShow();
         StorageItemsShow.gemStorageShow();
         return true;
      }
      
      public function gemHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            this.bag2P.gemBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getGemFromBag(end) != null)
            {
               gem = this.bag2P.delGem(end,this.bag2P.getGemFromBag(end).getTimes());
               this.bag2P.addToGemBag(this.storage.getGemFromStorage(begin),end);
               this.storage.addToGemStorage(gem,begin);
            }
            else
            {
               this.bag2P.addToGemBag(this.storage.delGem(begin,this.storage.getGemFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.gemShow2P();
         StorageItemsShow.gemStorageShow();
         return true;
      }
      
      public function gemStorageHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "kc_")
         {
            this.storage.gemStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(this.storage.getGemFromStorage(end) != null)
            {
               gem = this.storage.delGem(end,this.storage.getGemFromStorage(end).getTimes());
               this.storage.addToGemStorage(this.bag.delGem(begin,this.bag.getGemFromBag(begin).getTimes()),end);
               this.bag.addToGemBag(gem,begin);
            }
            else
            {
               this.storage.addToGemStorage(this.bag.delGem(begin,this.bag.getGemFromBag(begin).getTimes()),end);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getGemFromStorage(end) != null)
            {
               gem = this.storage.delGem(end,this.storage.getGemFromStorage(end).getTimes());
               this.storage.addToGemStorage(this.bag2P.delGem(begin,this.bag2P.getGemFromBag(begin).getTimes()),end);
               this.bag2P.addToGemBag(gem,begin);
            }
            else
            {
               this.storage.addToGemStorage(this.bag2P.delGem(begin,this.bag2P.getGemFromBag(begin).getTimes()),end);
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
      
      public function putInStorageHandle(itemsType:Number, begin:Number) : *
      {
         switch(itemsType)
         {
            case 1:
               if(this.storage.backEquipEmptyNum() > 0)
               {
                  this.storage.addEquipStorage(this.bag.getEquipFromBag(begin));
                  this.bag.delEquip(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(this.storage.backSuppliesEmptyNum() > 0)
               {
                  this.storage.addSuppliesStorage(this.bag.getSuppliesFromBag(begin));
                  this.bag.delSupplies(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(this.storage.backGemEmptyNum() > 0)
               {
                  this.storage.addGemStorage(this.bag.delGem(begin,this.bag.getGemFromBag(begin).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(this.storage.backOtherEmptyNum() > 0)
               {
                  this.storage.addOtherobjStorage(this.bag.delOtherobj(begin,this.bag.getOtherobjFromBag(begin).getTimes()));
                  break;
               }
               ShortTip.open(3);
         }
      }
      
      public function putInStorageHandle2P(itemsType:Number, begin:Number) : *
      {
         switch(itemsType)
         {
            case 1:
               if(this.storage.backEquipEmptyNum() > 0)
               {
                  this.storage.addEquipStorage(this.bag2P.getEquipFromBag(begin));
                  this.bag2P.delEquip(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 2:
               if(this.storage.backSuppliesEmptyNum() > 0)
               {
                  this.storage.addSuppliesStorage(this.bag2P.getSuppliesFromBag(begin));
                  this.bag2P.delSupplies(begin);
                  break;
               }
               ShortTip.open(3);
               break;
            case 3:
               if(this.storage.backGemEmptyNum() > 0)
               {
                  this.storage.addGemStorage(this.bag2P.delGem(begin,this.bag2P.getGemFromBag(begin).getTimes()));
                  break;
               }
               ShortTip.open(3);
               break;
            case 4:
               if(this.storage.backOtherEmptyNum() > 0)
               {
                  this.storage.addOtherobjStorage(this.bag2P.delOtherobj(begin,this.bag2P.getOtherobjFromBag(begin).getTimes()));
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
            this.bag.otherobjBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag.getOtherobjFromBag(end) != null)
            {
               oo = this.bag.delOtherobj(end,this.bag.getOtherobjFromBag(end).getTimes());
               this.bag.addToOtherobjBag(this.storage.getOtherobjFromStorage(begin),end);
               this.storage.addToOtherobjStorage(oo,begin);
            }
            else
            {
               this.bag.addToOtherobjBag(this.storage.delOtherobj(begin,this.storage.getOtherobjFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.otherobjShow();
         StorageItemsShow.otherobjStorageShow();
         return true;
      }
      
      public function otherHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var oo:Otherobj = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            this.bag2P.otherobjBagMove(begin,end);
         }
         else
         {
            if(dragObj.name.substr(0,3) != "kc_")
            {
               return false;
            }
            if(this.bag2P.getOtherobjFromBag(end) != null)
            {
               oo = this.bag2P.delOtherobj(end,this.bag2P.getOtherobjFromBag(end).getTimes());
               this.bag2P.addToOtherobjBag(this.storage.getOtherobjFromStorage(begin),end);
               this.storage.addToOtherobjStorage(oo,begin);
            }
            else
            {
               this.bag2P.addToOtherobjBag(this.storage.delOtherobj(begin,this.storage.getOtherobjFromStorage(begin).getTimes()),end);
            }
         }
         StorageItemsShow.otherobjShow2P();
         StorageItemsShow.otherobjStorageShow();
         return true;
      }
      
      public function otherStorageHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var oo:Otherobj = null;
         if(dragObj.name.substr(0,3) == "kc_")
         {
            this.storage.otherobjStorageMove(begin,end);
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            if(this.storage.getOtherobjFromStorage(end) != null)
            {
               oo = this.storage.delOtherobj(end,this.storage.getOtherobjFromStorage(end).getTimes());
               this.storage.addToOtherobjStorage(this.bag.delOtherobj(begin,this.bag.getOtherobjFromBag(begin).getTimes()),end);
               this.bag.addToOtherobjBag(oo,begin);
            }
            else
            {
               this.storage.addToOtherobjStorage(this.bag.delOtherobj(begin,this.bag.getOtherobjFromBag(begin).getTimes()),end);
            }
         }
         else
         {
            if(dragObj.name.substr(0,3) != "s2_")
            {
               return false;
            }
            if(this.storage.getOtherobjFromStorage(end) != null)
            {
               oo = this.storage.delOtherobj(end,this.storage.getOtherobjFromStorage(end).getTimes());
               this.storage.addToOtherobjStorage(this.bag2P.delOtherobj(begin,this.bag2P.getOtherobjFromBag(begin).getTimes()),end);
               this.bag2P.addToOtherobjBag(oo,begin);
            }
            else
            {
               this.storage.addToOtherobjStorage(this.bag2P.delOtherobj(begin,this.bag2P.getOtherobjFromBag(begin).getTimes()),end);
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

