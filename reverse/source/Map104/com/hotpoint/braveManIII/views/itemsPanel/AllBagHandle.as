package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
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
         bag = Main.player1.getBag();
         equipSlot = Main.player1.getEquipSlot();
         if(Main.player2)
         {
            bag2P = Main.player2.getBag();
            equipSlot2P = Main.player2.getEquipSlot();
         }
      }
      
      public function suppliesHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var temp:uint = 0;
         var supplies:Supplies = null;
         temp = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.suppliesBagMove(begin,end);
            BagItemsShow.suppliesShow();
            return true;
         }
         return false;
      }
      
      public function slotHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         var num:uint = 0;
         num = uint(equipKinds(end));
         if(bag.getEquipFromBag(begin).getDressLevel() <= Main.player1.getLevel())
         {
            if(equipSlot.getEquipFromSlot(end) != null)
            {
               if(bag.getEquipFromBag(begin).getPosition() == num)
               {
                  equip = equipSlot.delSlot(end);
                  equipSlot.addToSlot(bag.getEquipFromBag(begin),end);
                  bag.delEquip(begin);
                  bag.addToEquipBag(equip,begin);
               }
               else
               {
                  if(num != 5)
                  {
                     return false;
                  }
                  if(bag.getEquipFromBag(begin).getPosition() > 5)
                  {
                     equip = equipSlot.delSlot(end);
                     equipSlot.addToSlot(bag.getEquipFromBag(begin),end);
                     bag.delEquip(begin);
                     bag.addToEquipBag(equip,begin);
                  }
               }
            }
            else
            {
               if(bag.getEquipFromBag(begin).getPosition() != num)
               {
                  return false;
               }
               dragObj.visible = false;
               equipSlot.addToSlot(bag.getEquipFromBag(begin),end);
               bag.delEquip(begin);
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
         ItemsPanel.changeModel(Main.player1);
         return true;
      }
      
      public function changeWeapon2P(dragObj:MovieClip) : Boolean
      {
         if(dragObj.name.substr(0,4) == "z2_2")
         {
            if(ItemsPanel.itemsPanel.mouseX > ItemsPanel.itemsPanel.x + 220 && ItemsPanel.itemsPanel.mouseY > ItemsPanel.itemsPanel.y + 410 && ItemsPanel.itemsPanel.mouseX < ItemsPanel.itemsPanel.x + 270 && ItemsPanel.itemsPanel.mouseY < ItemsPanel.itemsPanel.y + 460)
            {
               equipSlot2P.slotToSlot();
            }
         }
         else
         {
            if(dragObj.name.substr(0,4) != "z2_5")
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
      
      public function slotHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         var num:uint = 0;
         num = uint(equipKinds(end));
         if(bag2P.getEquipFromBag(begin).getDressLevel() <= Main.player2.getLevel())
         {
            if(equipSlot2P.getEquipFromSlot(end) != null)
            {
               if(bag2P.getEquipFromBag(begin).getPosition() == num)
               {
                  equip = equipSlot2P.delSlot(end);
                  equipSlot2P.addToSlot(bag2P.getEquipFromBag(begin),end);
                  bag2P.delEquip(begin);
                  bag2P.addToEquipBag(equip,begin);
               }
               else
               {
                  if(num != 5)
                  {
                     return false;
                  }
                  if(bag2P.getEquipFromBag(begin).getPosition() > 5)
                  {
                     equip = equipSlot2P.delSlot(end);
                     equipSlot2P.addToSlot(bag2P.getEquipFromBag(begin),end);
                     bag2P.delEquip(begin);
                     bag2P.addToEquipBag(equip,begin);
                  }
               }
            }
            else
            {
               if(bag2P.getEquipFromBag(begin).getPosition() != num)
               {
                  return false;
               }
               dragObj.visible = false;
               equipSlot2P.addToSlot(bag2P.getEquipFromBag(begin),end);
               bag2P.delEquip(begin);
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
         ItemsPanel.changeModel(Main.player2);
         return true;
      }
      
      public function otherobjHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var temp:uint = 0;
         var otherobj:Otherobj = null;
         temp = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.otherobjBagMove(begin,end);
            BagItemsShow.otherobjShow2P();
            return true;
         }
         return false;
      }
      
      private function equipKinds(id:uint) : uint
      {
         switch(id)
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
      
      public function gemHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.gemBagMove(begin,end);
            BagItemsShow.gemShow2P();
            return true;
         }
         return false;
      }
      
      public function equipHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var temp:uint = 0;
         var equip:Equip = null;
         temp = uint(dragObj.currentFrame);
         if(bag2P.getEquipFromBag(end) != null)
         {
            if(dragObj.name.substr(0,3) == "s2_")
            {
               bag2P.equipBagMove(begin,end);
            }
            else if(bag2P.getEquipFromBag(end).getDressLevel() <= Main.player2.getLevel())
            {
               if(!(equipSlot2P.getEquipFromSlot(begin).getPosition() == bag2P.getEquipFromBag(end).getPosition() || equipSlot2P.getEquipFromSlot(begin).getPosition() > 4 && bag2P.getEquipFromBag(end).getPosition() > 4))
               {
                  return false;
               }
               equip = bag2P.delEquip(end);
               bag2P.addToEquipBag(equipSlot2P.getEquipFromSlot(begin),end);
               equipSlot2P.delSlot(begin);
               equipSlot2P.addToSlot(equip,begin);
            }
            else
            {
               ShortTip.open(25);
            }
         }
         else if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.equipBagMove(begin,end);
         }
         else if(dragObj.name == "z2_2" || dragObj.name == "z2_5")
         {
            ShortTip.open(21);
         }
         else
         {
            bag2P.addToEquipBag(equipSlot2P.getEquipFromSlot(begin),end);
            equipSlot2P.delSlot(begin);
         }
         Main.player_2.LoadPlayerLvData();
         BagItemsShow.equipShow2P();
         BagItemsShow.slotShow2P();
         BagItemsShow.informationShow2P();
         ItemsPanel.changeModel(Main.player2);
         return true;
      }
      
      public function gemHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.gemBagMove(begin,end);
            BagItemsShow.gemShow();
            return true;
         }
         return false;
      }
      
      public function changeWeapon(dragObj:MovieClip) : Boolean
      {
         if(dragObj.name.substr(0,4) == "z1_2")
         {
            if(ItemsPanel.itemsPanel.mouseX > ItemsPanel.itemsPanel.x + 220 && ItemsPanel.itemsPanel.mouseY > ItemsPanel.itemsPanel.y + 175 && ItemsPanel.itemsPanel.mouseX < ItemsPanel.itemsPanel.x + 270 && ItemsPanel.itemsPanel.mouseY < ItemsPanel.itemsPanel.y + 225)
            {
               equipSlot.slotToSlot();
            }
         }
         else
         {
            if(dragObj.name.substr(0,4) != "z1_5")
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
      
      public function suppliesHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var temp:uint = 0;
         var supplies:Supplies = null;
         temp = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s2_")
         {
            bag2P.suppliesBagMove(begin,end);
            BagItemsShow.suppliesShow2P();
            return true;
         }
         return false;
      }
      
      public function otherobjHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var temp:uint = 0;
         var otherobj:Otherobj = null;
         temp = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.otherobjBagMove(begin,end);
            BagItemsShow.otherobjShow();
            return true;
         }
         return false;
      }
      
      public function equipHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(bag.getEquipFromBag(end) != null)
         {
            if(dragObj.name.substr(0,3) == "s1_")
            {
               bag.equipBagMove(begin,end);
            }
            else if(bag.getEquipFromBag(end).getDressLevel() <= Main.player1.getLevel())
            {
               if(!(equipSlot.getEquipFromSlot(begin).getPosition() == bag.getEquipFromBag(end).getPosition() || equipSlot.getEquipFromSlot(begin).getPosition() > 4 && bag.getEquipFromBag(end).getPosition() > 4))
               {
                  return false;
               }
               equip = bag.delEquip(end);
               bag.addToEquipBag(equipSlot.getEquipFromSlot(begin),end);
               equipSlot.delSlot(begin);
               equipSlot.addToSlot(equip,begin);
            }
            else
            {
               ShortTip.open(25);
            }
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            bag.equipBagMove(begin,end);
         }
         else if(dragObj.name == "z1_2" || dragObj.name == "z1_5")
         {
            ShortTip.open(21);
         }
         else
         {
            bag.addToEquipBag(equipSlot.getEquipFromSlot(begin),end);
            equipSlot.delSlot(begin);
         }
         Main.player_1.LoadPlayerLvData();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.informationShow();
         ItemsPanel.changeModel(Main.player1);
         return true;
      }
   }
}

