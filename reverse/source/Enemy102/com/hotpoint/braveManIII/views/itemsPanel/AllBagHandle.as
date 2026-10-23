package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.MovieClip;
   import src.*;
   
   public class AllBagHandle
   {
      
      private var bag2P:Bag = new Bag();
      
      private var bag:Bag = new Bag();
      
      private var equipSlot:EquipSlot = new EquipSlot();
      
      private var equipSlot2P:EquipSlot = new EquipSlot();
      
      public function AllBagHandle()
      {
         super();
         bag = ItemsPanel.player1.getBag();
         equipSlot = ItemsPanel.player1.getEquipSlot();
         if(ItemsPanel.player2)
         {
            bag2P = ItemsPanel.player2.getBag();
            equipSlot2P = ItemsPanel.player2.getEquipSlot();
         }
      }
      
      public function suppliesHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:Supplies = null;
         _loc4_ = uint(param1.currentFrame);
         if(param1.name.substr(0,3) == "s1_")
         {
            bag.suppliesBagMove(param2,param3);
            BagItemsShow.suppliesShow();
            return true;
         }
         return false;
      }
      
      public function changeWeapon2P(param1:MovieClip) : Boolean
      {
         if(param1.name.substr(0,4) == "z2_2")
         {
            if(ItemsPanel.itemsPanel.mouseX > ItemsPanel.itemsPanel.x + 220 && ItemsPanel.itemsPanel.mouseY > ItemsPanel.itemsPanel.y + 410 && ItemsPanel.itemsPanel.mouseX < ItemsPanel.itemsPanel.x + 270 && ItemsPanel.itemsPanel.mouseY < ItemsPanel.itemsPanel.y + 460)
            {
               equipSlot2P.slotToSlot();
            }
         }
         else
         {
            if(param1.name.substr(0,4) != "z2_5")
            {
               return false;
            }
            if(ItemsPanel.itemsPanel.mouseX > ItemsPanel.itemsPanel.x + 36 && ItemsPanel.itemsPanel.mouseY > ItemsPanel.itemsPanel.y + 410 && ItemsPanel.itemsPanel.mouseX < ItemsPanel.itemsPanel.x + 88 && ItemsPanel.itemsPanel.mouseY < ItemsPanel.itemsPanel.y + 460)
            {
               equipSlot2P.slotToSlot();
            }
         }
         Main.player_2.newSkin();
         BagItemsShow.slotShow2P();
         return true;
      }
      
      public function slotHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         var _loc5_:uint = 0;
         _loc5_ = uint(equipKinds(param3));
         if(bag2P.getEquipFromBag(param2).getDressLevel() <= ItemsPanel.player2.getLevel())
         {
            if(equipSlot2P.getEquipFromSlot(param3) != null)
            {
               if(bag2P.getEquipFromBag(param2).getPosition() == _loc5_)
               {
                  _loc4_ = equipSlot2P.delSlot(param3);
                  equipSlot2P.addToSlot(bag2P.getEquipFromBag(param2),param3);
                  bag2P.delEquip(param2);
                  bag2P.addToEquipBag(_loc4_,param2);
               }
               else
               {
                  if(_loc5_ != 5)
                  {
                     return false;
                  }
                  if(bag2P.getEquipFromBag(param2).getPosition() > 5)
                  {
                     _loc4_ = equipSlot2P.delSlot(param3);
                     equipSlot2P.addToSlot(bag2P.getEquipFromBag(param2),param3);
                     bag2P.delEquip(param2);
                     bag2P.addToEquipBag(_loc4_,param2);
                  }
               }
            }
            else
            {
               if(bag2P.getEquipFromBag(param2).getPosition() != _loc5_)
               {
                  return false;
               }
               param1.visible = false;
               equipSlot2P.addToSlot(bag2P.getEquipFromBag(param2),param3);
               bag2P.delEquip(param2);
            }
         }
         else
         {
            ShortTip.open(25);
         }
         Main.player_2.LoadPlayerLvData();
         BagItemsShow.equipShow2P();
         BagItemsShow.slotShow2P();
         BagItemsShow.informationShow2P();
         ItemsPanel.changeModel(ItemsPanel.player2);
         return true;
      }
      
      public function slotHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         var _loc5_:uint = 0;
         _loc5_ = uint(equipKinds(param3));
         if(bag.getEquipFromBag(param2).getDressLevel() <= ItemsPanel.player1.getLevel())
         {
            if(equipSlot.getEquipFromSlot(param3) != null)
            {
               if(bag.getEquipFromBag(param2).getPosition() == _loc5_)
               {
                  _loc4_ = equipSlot.delSlot(param3);
                  equipSlot.addToSlot(bag.getEquipFromBag(param2),param3);
                  bag.delEquip(param2);
                  bag.addToEquipBag(_loc4_,param2);
               }
               else
               {
                  if(_loc5_ != 5)
                  {
                     return false;
                  }
                  if(bag.getEquipFromBag(param2).getPosition() > 5)
                  {
                     _loc4_ = equipSlot.delSlot(param3);
                     equipSlot.addToSlot(bag.getEquipFromBag(param2),param3);
                     bag.delEquip(param2);
                     bag.addToEquipBag(_loc4_,param2);
                  }
               }
            }
            else
            {
               if(bag.getEquipFromBag(param2).getPosition() != _loc5_)
               {
                  return false;
               }
               param1.visible = false;
               equipSlot.addToSlot(bag.getEquipFromBag(param2),param3);
               bag.delEquip(param2);
            }
         }
         else
         {
            ShortTip.open(25);
         }
         Main.player_1.LoadPlayerLvData();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.informationShow();
         ItemsPanel.changeModel(ItemsPanel.player1);
         return true;
      }
      
      public function gemHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Gem = null;
         if(param1.name.substr(0,3) == "s2_")
         {
            bag2P.gemBagMove(param2,param3);
            BagItemsShow.gemShow2P();
            return true;
         }
         return false;
      }
      
      public function equipHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:Equip = null;
         _loc4_ = uint(param1.currentFrame);
         if(bag2P.getEquipFromBag(param3) != null)
         {
            if(param1.name.substr(0,3) == "s2_")
            {
               bag2P.equipBagMove(param2,param3);
            }
            else if(bag2P.getEquipFromBag(param3).getDressLevel() <= ItemsPanel.player2.getLevel())
            {
               if(!(equipSlot2P.getEquipFromSlot(param2).getPosition() == bag2P.getEquipFromBag(param3).getPosition() || equipSlot2P.getEquipFromSlot(param2).getPosition() > 4 && bag2P.getEquipFromBag(param3).getPosition() > 4))
               {
                  return false;
               }
               _loc5_ = bag2P.delEquip(param3);
               bag2P.addToEquipBag(equipSlot2P.getEquipFromSlot(param2),param3);
               equipSlot2P.delSlot(param2);
               equipSlot2P.addToSlot(_loc5_,param2);
            }
            else
            {
               ShortTip.open(25);
            }
         }
         else if(param1.name.substr(0,3) == "s2_")
         {
            bag2P.equipBagMove(param2,param3);
         }
         else if(param1.name == "z2_2" || param1.name == "z2_5")
         {
            ShortTip.open(21);
         }
         else
         {
            bag2P.addToEquipBag(equipSlot2P.getEquipFromSlot(param2),param3);
            equipSlot2P.delSlot(param2);
         }
         Main.player_2.LoadPlayerLvData();
         BagItemsShow.equipShow2P();
         BagItemsShow.slotShow2P();
         BagItemsShow.informationShow2P();
         ItemsPanel.changeModel(ItemsPanel.player2);
         return true;
      }
      
      public function gemHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Gem = null;
         if(param1.name.substr(0,3) == "s1_")
         {
            bag.gemBagMove(param2,param3);
            BagItemsShow.gemShow();
            return true;
         }
         return false;
      }
      
      public function changeWeapon(param1:MovieClip) : Boolean
      {
         if(param1.name.substr(0,4) == "z1_2")
         {
            if(ItemsPanel.itemsPanel.mouseX > ItemsPanel.itemsPanel.x + 220 && ItemsPanel.itemsPanel.mouseY > ItemsPanel.itemsPanel.y + 175 && ItemsPanel.itemsPanel.mouseX < ItemsPanel.itemsPanel.x + 270 && ItemsPanel.itemsPanel.mouseY < ItemsPanel.itemsPanel.y + 225)
            {
               equipSlot.slotToSlot();
            }
         }
         else
         {
            if(param1.name.substr(0,4) != "z1_5")
            {
               return false;
            }
            if(ItemsPanel.itemsPanel.mouseX > ItemsPanel.itemsPanel.x + 36 && ItemsPanel.itemsPanel.mouseY > ItemsPanel.itemsPanel.y + 175 && ItemsPanel.itemsPanel.mouseX < ItemsPanel.itemsPanel.x + 88 && ItemsPanel.itemsPanel.mouseY < ItemsPanel.itemsPanel.y + 225)
            {
               equipSlot.slotToSlot();
            }
         }
         Main.player_1.newSkin();
         BagItemsShow.slotShow();
         return true;
      }
      
      public function suppliesHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc5_:Supplies = null;
         _loc4_ = uint(param1.currentFrame);
         if(param1.name.substr(0,3) == "s2_")
         {
            bag2P.suppliesBagMove(param2,param3);
            BagItemsShow.suppliesShow2P();
            return true;
         }
         return false;
      }
      
      private function equipKinds(param1:uint) : uint
      {
         switch(param1)
         {
            case 0:
               return 1;
            case 1:
               return 2;
            case 2:
               return 5;
            case 3:
               return 3;
            case 4:
               return 4;
            case 5:
               return 5;
            default:
               return null;
         }
      }
      
      public function equipHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         if(bag.getEquipFromBag(param3) != null)
         {
            if(param1.name.substr(0,3) == "s1_")
            {
               bag.equipBagMove(param2,param3);
            }
            else if(bag.getEquipFromBag(param3).getDressLevel() <= ItemsPanel.player1.getLevel())
            {
               if(!(equipSlot.getEquipFromSlot(param2).getPosition() == bag.getEquipFromBag(param3).getPosition() || equipSlot.getEquipFromSlot(param2).getPosition() > 4 && bag.getEquipFromBag(param3).getPosition() > 4))
               {
                  return false;
               }
               _loc4_ = bag.delEquip(param3);
               bag.addToEquipBag(equipSlot.getEquipFromSlot(param2),param3);
               equipSlot.delSlot(param2);
               equipSlot.addToSlot(_loc4_,param2);
            }
            else
            {
               ShortTip.open(25);
            }
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            bag.equipBagMove(param2,param3);
         }
         else if(param1.name == "z1_2" || param1.name == "z1_5")
         {
            ShortTip.open(21);
         }
         else
         {
            bag.addToEquipBag(equipSlot.getEquipFromSlot(param2),param3);
            equipSlot.delSlot(param2);
         }
         Main.player_1.LoadPlayerLvData();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.informationShow();
         ItemsPanel.changeModel(ItemsPanel.player1);
         return true;
      }
   }
}

