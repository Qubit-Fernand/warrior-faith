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
      
      private var bag:Bag = new Bag();
      
      private var equipSlot:EquipSlot = new EquipSlot();
      
      private var bag2P:Bag = new Bag();
      
      private var equipSlot2P:EquipSlot = new EquipSlot();
      
      public function AllBagHandle()
      {
         super();
         this.bag = Main.player1.getBag();
         this.equipSlot = Main.player1.getEquipSlot();
         if(Main.player2)
         {
            this.bag2P = Main.player2.getBag();
            this.equipSlot2P = Main.player2.getEquipSlot();
         }
      }
      
      public function equipHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         if(this.bag.getEquipFromBag(end) != null)
         {
            if(dragObj.name.substr(0,3) == "s1_")
            {
               this.bag.equipBagMove(begin,end);
            }
            else if(this.bag.getEquipFromBag(end).getDressLevel() <= Main.player1.getLevel() || this.bag.getEquipFromBag(end).getDressLevel() == 100)
            {
               if(this.equipSlot.getEquipFromSlot(begin).getPosition() != this.bag.getEquipFromBag(end).getPosition())
               {
                  return false;
               }
               equip = this.bag.delEquip(end);
               this.bag.addToEquipBag(this.equipSlot.getEquipFromSlot(begin),end);
               this.equipSlot.delSlot(begin);
               this.equipSlot.addToSlot(equip,begin);
            }
            else
            {
               ShortTip.open(25);
            }
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag.equipBagMove(begin,end);
         }
         else if(dragObj.name == "z1_2" || dragObj.name == "z1_5")
         {
            ShortTip.open(21);
         }
         else
         {
            this.bag.addToEquipBag(this.equipSlot.getEquipFromSlot(begin),end);
            this.equipSlot.delSlot(begin);
         }
         Main.player_1.LoadPlayerLvData();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.informationShow();
         ItemsPanel.changeModel(Main.player1);
         return true;
      }
      
      public function equipHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         var temp:uint = uint(dragObj.currentFrame);
         if(this.bag2P.getEquipFromBag(end) != null)
         {
            if(dragObj.name.substr(0,3) == "s1_")
            {
               this.bag2P.equipBagMove(begin,end);
            }
            else if(this.bag2P.getEquipFromBag(end).getDressLevel() <= Main.player2.getLevel() || this.bag2P.getEquipFromBag(end).getDressLevel() == 100)
            {
               if(this.equipSlot2P.getEquipFromSlot(begin).getPosition() != this.bag2P.getEquipFromBag(end).getPosition())
               {
                  return false;
               }
               equip = this.bag2P.delEquip(end);
               this.bag2P.addToEquipBag(this.equipSlot2P.getEquipFromSlot(begin),end);
               this.equipSlot2P.delSlot(begin);
               this.equipSlot2P.addToSlot(equip,begin);
            }
            else
            {
               ShortTip.open(25);
            }
         }
         else if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag2P.equipBagMove(begin,end);
         }
         else if(dragObj.name == "z1_2" || dragObj.name == "z1_5")
         {
            ShortTip.open(21);
         }
         else
         {
            this.bag2P.addToEquipBag(this.equipSlot2P.getEquipFromSlot(begin),end);
            this.equipSlot2P.delSlot(begin);
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
            this.bag.gemBagMove(begin,end);
            BagItemsShow.gemShow();
            return true;
         }
         return false;
      }
      
      public function gemHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var gem:Gem = null;
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag2P.gemBagMove(begin,end);
            BagItemsShow.gemShow2P();
            return true;
         }
         return false;
      }
      
      public function suppliesHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var supplies:Supplies = null;
         var temp:uint = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag.suppliesBagMove(begin,end);
            BagItemsShow.suppliesShow();
            return true;
         }
         return false;
      }
      
      public function suppliesHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var supplies:Supplies = null;
         var temp:uint = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag2P.suppliesBagMove(begin,end);
            BagItemsShow.suppliesShow2P();
            return true;
         }
         return false;
      }
      
      public function otherobjHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var otherobj:Otherobj = null;
         var temp:uint = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag.otherobjBagMove(begin,end);
            BagItemsShow.otherobjShow();
            return true;
         }
         return false;
      }
      
      public function otherobjHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var otherobj:Otherobj = null;
         var temp:uint = uint(dragObj.currentFrame);
         if(dragObj.name.substr(0,3) == "s1_")
         {
            this.bag2P.otherobjBagMove(begin,end);
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
            case 6:
               return 8;
            case 7:
               return 9;
            default:
               return null;
         }
      }
      
      public function slotHandle(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         var num:uint = uint(this.equipKinds(end));
         if(this.bag.getEquipFromBag(begin).getDressLevel() <= Main.player1.getLevel() || this.bag.getEquipFromBag(begin).getDressLevel() == 100)
         {
            if(this.equipSlot.getEquipFromSlot(end) != null)
            {
               if(this.bag.getEquipFromBag(begin).getPosition() == num)
               {
                  equip = this.equipSlot.delSlot(end);
                  this.equipSlot.addToSlot(this.bag.getEquipFromBag(begin),end);
                  this.bag.delEquip(begin);
                  this.bag.addToEquipBag(equip,begin);
               }
               else
               {
                  if(num != 5)
                  {
                     return false;
                  }
                  if(this.bag.getEquipFromBag(begin).getPosition() > 5 && this.bag.getEquipFromBag(begin).getPosition() <= 7)
                  {
                     equip = this.equipSlot.delSlot(end);
                     this.equipSlot.addToSlot(this.bag.getEquipFromBag(begin),end);
                     this.bag.delEquip(begin);
                     this.bag.addToEquipBag(equip,begin);
                  }
               }
            }
            else
            {
               if(this.bag.getEquipFromBag(begin).getPosition() != num)
               {
                  return false;
               }
               dragObj.visible = false;
               this.equipSlot.addToSlot(this.bag.getEquipFromBag(begin),end);
               this.bag.delEquip(begin);
            }
         }
         else
         {
            ShortTip.open(25);
         }
         Main.player_1.LoadPlayerLvData();
         Player.getEquipDataXX();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.informationShow();
         ItemsPanel.changeModel(Main.player1);
         return true;
      }
      
      public function slotHandle2P(dragObj:MovieClip, begin:Number, end:Number) : Boolean
      {
         var equip:Equip = null;
         var num:uint = uint(this.equipKinds(end));
         if(this.bag2P.getEquipFromBag(begin).getDressLevel() <= Main.player2.getLevel() || this.bag2P.getEquipFromBag(begin).getDressLevel() == 100)
         {
            if(this.equipSlot2P.getEquipFromSlot(end) != null)
            {
               if(this.bag2P.getEquipFromBag(begin).getPosition() == num)
               {
                  equip = this.equipSlot2P.delSlot(end);
                  this.equipSlot2P.addToSlot(this.bag2P.getEquipFromBag(begin),end);
                  this.bag2P.delEquip(begin);
                  this.bag2P.addToEquipBag(equip,begin);
               }
               else
               {
                  if(num != 5)
                  {
                     return false;
                  }
                  if(this.bag2P.getEquipFromBag(begin).getPosition() > 5 && this.bag2P.getEquipFromBag(begin).getPosition() <= 7)
                  {
                     equip = this.equipSlot2P.delSlot(end);
                     this.equipSlot2P.addToSlot(this.bag2P.getEquipFromBag(begin),end);
                     this.bag2P.delEquip(begin);
                     this.bag2P.addToEquipBag(equip,begin);
                  }
               }
            }
            else
            {
               if(this.bag2P.getEquipFromBag(begin).getPosition() != num)
               {
                  return false;
               }
               dragObj.visible = false;
               this.equipSlot2P.addToSlot(this.bag2P.getEquipFromBag(begin),end);
               this.bag2P.delEquip(begin);
            }
         }
         else
         {
            ShortTip.open(25);
         }
         Main.player_2.LoadPlayerLvData();
         Player.getEquipDataXX();
         BagItemsShow.equipShow2P();
         BagItemsShow.slotShow2P();
         BagItemsShow.informationShow2P();
         ItemsPanel.changeModel(Main.player2);
         return true;
      }
   }
}

