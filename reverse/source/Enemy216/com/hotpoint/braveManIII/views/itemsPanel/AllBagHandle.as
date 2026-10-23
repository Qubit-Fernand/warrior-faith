package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
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
         bag = Main.player1.getBag();
         equipSlot = Main.player1.getEquipSlot();
         if(Main.player2)
         {
            bag2P = Main.player2.getBag();
            equipSlot2P = Main.player2.getEquipSlot();
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
            else
            {
               if(Main.water.getValue() != 1 && (param2 == 0 || param2 == 1 || param2 == 3 || param2 == 4))
               {
                  param2 += 8;
               }
               if(bag.getEquipFromBag(param3).getDressLevel() <= Main.player1.getLevel() || bag.getEquipFromBag(param3).getDressLevel() == 100)
               {
                  if(equipSlot.getEquipFromSlot(param2).getPosition() != bag.getEquipFromBag(param3).getPosition())
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
                  NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"等级不足");
               }
            }
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            bag.equipBagMove(param2,param3);
         }
         else
         {
            if(Main.water.getValue() != 1 && (param2 == 0 || param2 == 1 || param2 == 3 || param2 == 4))
            {
               param2 += 8;
            }
            if(param1.name == "z1_2" || param1.name == "z1_5")
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"武器无法卸下");
            }
            else
            {
               bag.addToEquipBag(equipSlot.getEquipFromSlot(param2),param3);
               equipSlot.delSlot(param2);
            }
         }
         Main.player_1.LoadPlayerLvData();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.informationShow();
         ItemsPanel.changeModel(Main.player1);
         return true;
      }
      
      public function equipHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:Equip = null;
         var _loc4_:uint = uint(param1.currentFrame);
         if(bag2P.getEquipFromBag(param3) != null)
         {
            if(param1.name.substr(0,3) == "s1_")
            {
               bag2P.equipBagMove(param2,param3);
            }
            else
            {
               if(Main.water.getValue() != 1 && (param2 == 0 || param2 == 1 || param2 == 3 || param2 == 4))
               {
                  param2 += 8;
               }
               if(bag2P.getEquipFromBag(param3).getDressLevel() <= Main.player2.getLevel() || bag2P.getEquipFromBag(param3).getDressLevel() == 100)
               {
                  if(equipSlot2P.getEquipFromSlot(param2).getPosition() != bag2P.getEquipFromBag(param3).getPosition())
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
                  NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"等级不足");
               }
            }
         }
         else if(param1.name.substr(0,3) == "s1_")
         {
            bag2P.equipBagMove(param2,param3);
         }
         else
         {
            if(Main.water.getValue() != 1 && (param2 == 0 || param2 == 1 || param2 == 3 || param2 == 4))
            {
               param2 += 8;
            }
            if(param1.name == "z1_2" || param1.name == "z1_5")
            {
               NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"武器无法卸下");
            }
            else
            {
               bag2P.addToEquipBag(equipSlot2P.getEquipFromSlot(param2),param3);
               equipSlot2P.delSlot(param2);
            }
         }
         Main.player_2.LoadPlayerLvData();
         BagItemsShow.equipShow2P();
         BagItemsShow.slotShow2P();
         BagItemsShow.informationShow2P();
         ItemsPanel.changeModel(Main.player2);
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
      
      public function gemHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Gem = null;
         if(param1.name.substr(0,3) == "s1_")
         {
            bag2P.gemBagMove(param2,param3);
            BagItemsShow.gemShow2P();
            return true;
         }
         return false;
      }
      
      public function suppliesHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:Supplies = null;
         var _loc4_:uint = uint(param1.currentFrame);
         if(param1.name.substr(0,3) == "s1_")
         {
            bag.suppliesBagMove(param2,param3);
            BagItemsShow.suppliesShow();
            return true;
         }
         return false;
      }
      
      public function suppliesHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:Supplies = null;
         var _loc4_:uint = uint(param1.currentFrame);
         if(param1.name.substr(0,3) == "s1_")
         {
            bag2P.suppliesBagMove(param2,param3);
            BagItemsShow.suppliesShow2P();
            return true;
         }
         return false;
      }
      
      public function otherobjHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:Otherobj = null;
         var _loc4_:uint = uint(param1.currentFrame);
         if(param1.name.substr(0,3) == "s1_")
         {
            bag.otherobjBagMove(param2,param3);
            BagItemsShow.otherobjShow();
            return true;
         }
         return false;
      }
      
      public function otherobjHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:Otherobj = null;
         var _loc4_:uint = uint(param1.currentFrame);
         if(param1.name.substr(0,3) == "s1_")
         {
            bag2P.otherobjBagMove(param2,param3);
            BagItemsShow.otherobjShow2P();
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
            case 6:
               return 8;
            case 7:
               return 9;
            case 8:
               return 10;
            case 9:
               return 11;
            case 11:
               return 12;
            case 12:
               return 13;
            default:
               return null;
         }
      }
      
      public function slotHandle(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         if(Main.water.getValue() != 1 && (param3 == 0 || param3 == 1 || param3 == 3 || param3 == 4))
         {
            param3 += 8;
         }
         var _loc5_:uint = uint(equipKinds(param3));
         if(bag.getEquipFromBag(param2).getDressLevel() <= Main.player1.getLevel() || bag.getEquipFromBag(param2).getDressLevel() == 100)
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
                  if(bag.getEquipFromBag(param2).getPosition() > 5 && bag.getEquipFromBag(param2).getPosition() <= 7)
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
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"等级不足");
         }
         Main.player_1.LoadPlayerLvData();
         Player.getEquipDataXX();
         BagItemsShow.equipShow();
         BagItemsShow.slotShow();
         BagItemsShow.informationShow();
         ItemsPanel.changeModel(Main.player1);
         return true;
      }
      
      public function slotHandle2P(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Equip = null;
         if(Main.water.getValue() != 1 && (param3 == 0 || param3 == 1 || param3 == 3 || param3 == 4))
         {
            param3 += 8;
         }
         var _loc5_:uint = uint(equipKinds(param3));
         if(bag2P.getEquipFromBag(param2).getDressLevel() <= Main.player2.getLevel() || bag2P.getEquipFromBag(param2).getDressLevel() == 100)
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
                  if(bag2P.getEquipFromBag(param2).getPosition() > 5 && bag2P.getEquipFromBag(param2).getPosition() <= 7)
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
            NewMC.Open("文字提示",Main._stage,480,400,30,0,true,2,"等级不足");
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

