package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.repository.elves.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.pet.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.repository.title.*;
   import com.hotpoint.braveManIII.views.makePanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import com.hotpoint.braveManIII.views.taskPanel.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class MenuTooltip extends MovieClip
   {
      
      private static var oldNum:uint;
      
      private static var whichDo:uint;
      
      public static var moneyOK:Boolean = false;
      
      public static var moneyOK2:Boolean = false;
      
      private static var menuTooltip:MovieClip = new MenuShow();
      
      private var su:Supplies;
      
      private var selectType:uint;
      
      private var amount:VT = VT.createVT(1);
      
      private var bag:Bag = new Bag();
      
      private var equipSlot:EquipSlot = new EquipSlot();
      
      private var bag2P:Bag = new Bag();
      
      private var equipSlot2P:EquipSlot = new EquipSlot();
      
      private var skillSlot:EquipSkillSlot = new EquipSkillSlot();
      
      private var skillSlot2P:EquipSkillSlot = new EquipSkillSlot();
      
      public function MenuTooltip()
      {
         super();
         bag = Main.player1.getBag();
         equipSlot = Main.player1.getEquipSlot();
         skillSlot = Main.player1.getEquipSkillSlot();
         if(Main.P1P2)
         {
            bag2P = Main.player2.getBag();
            equipSlot2P = Main.player2.getEquipSlot();
            skillSlot2P = Main.player2.getEquipSkillSlot();
         }
         this.addChild(menuTooltip);
         this.visible = false;
      }
      
      public static function lijifuhua() : *
      {
         var _loc1_:int = 0;
         if(moneyOK)
         {
            if(whichDo == 1)
            {
               _loc1_ = int(Main.player1.getBag().delOtherobj(oldNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(PetFactory.creatPet(_loc1_).getLink()));
               BagItemsShow.otherobjShow();
            }
            else
            {
               _loc1_ = int(Main.player2.getBag().delOtherobj(oldNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(PetFactory.creatPet(_loc1_).getLink()));
               BagItemsShow.otherobjShow2P();
            }
            Main.Save();
            menuTooltip["menu_9"]["fuhuaNow"].visible = true;
            moneyOK = false;
         }
      }
      
      public static function xufeiRMB() : *
      {
         if(moneyOK2)
         {
            if(whichDo == 1)
            {
               Main.player1.getEquipSlot().getEquipFromSlot(oldNum).setRemainingTimeNow();
               Main.player1.getEquipSlot().getEquipFromSlot(oldNum).setSysTime(Main.serverTime);
            }
            else
            {
               Main.player2.getEquipSlot().getEquipFromSlot(oldNum).setRemainingTimeNow();
               Main.player2.getEquipSlot().getEquipFromSlot(oldNum).setSysTime(Main.serverTime);
            }
            moneyOK2 = false;
            Main.Save();
         }
      }
      
      public function addListener() : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = false;
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
         ItemsPanel.itemsPanel["xfRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesXF);
         ItemsPanel.itemsPanel["xfRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,noXF);
         ItemsPanel.itemsPanel["fhRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesFH);
         ItemsPanel.itemsPanel["fhRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,noFH);
         ItemsPanel.itemsPanel["txtTop"]["close"].addEventListener(MouseEvent.CLICK,closeTXT);
         ItemsPanel.itemsPanel["txtTop2"]["close"].addEventListener(MouseEvent.CLICK,closeTXT2);
         ItemsPanel.itemsPanel["isFenJie"]["yesFJ"].addEventListener(MouseEvent.CLICK,yesFJ);
         ItemsPanel.itemsPanel["isFenJie"]["noFJ"].addEventListener(MouseEvent.CLICK,noFJ);
         ItemsPanel.itemsPanel["getFJ"]["close"].addEventListener(MouseEvent.CLICK,closeFJ);
         ItemsPanel.itemsPanel.addEventListener(BtnEvent.DO_CLICK,btnListen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].addEventListener(MouseEvent.MOUSE_OVER,tipOpen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].addEventListener(MouseEvent.MOUSE_OUT,tipClose);
         menuTooltip["menu_1"]["off_btn"].addEventListener(MouseEvent.CLICK,takeOff);
         menuTooltip["menu_2"]["wear_btn"].addEventListener(MouseEvent.CLICK,wear);
         menuTooltip["menu_2"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_2"]["all_Sell"].addEventListener(MouseEvent.CLICK,allSell);
         menuTooltip["menu_2"]["fenJie"].addEventListener(MouseEvent.CLICK,isFJ);
         menuTooltip["menu_3"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_3"]["key_btn1"].addEventListener(MouseEvent.CLICK,setKey_1);
         menuTooltip["menu_3"]["key_btn2"].addEventListener(MouseEvent.CLICK,setKey_2);
         menuTooltip["menu_3"]["key_btn3"].addEventListener(MouseEvent.CLICK,setKey_3);
         menuTooltip["menu_4"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_5"]["left_btn"].addEventListener(MouseEvent.CLICK,leftInto);
         menuTooltip["menu_5"]["right_btn"].addEventListener(MouseEvent.CLICK,rightInto);
         menuTooltip["menu_5"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_6"]["free_btn"].addEventListener(MouseEvent.CLICK,setFree);
         menuTooltip["menu_7"]["use_btn"].addEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_7"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_8"]["use_btn"].addEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_8"]["alluse_btn"].addEventListener(MouseEvent.CLICK,alluseOther);
         menuTooltip["menu_8"]["sell_btn"].addEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_9"]["fuhua"].addEventListener(MouseEvent.CLICK,fuhua);
         menuTooltip["menu_9"]["fuhuaNow"].addEventListener(MouseEvent.CLICK,fuhuaNow);
         menuTooltip["menu_10"]["xf_btn"].addEventListener(MouseEvent.CLICK,xufei);
         menuTooltip["menu_10"]["yc_btn"].addEventListener(MouseEvent.CLICK,yincang);
         menuTooltip["menu_10"]["xs_btn"].addEventListener(MouseEvent.CLICK,xianshi);
         menuTooltip["menu_10"]["off_btn"].addEventListener(MouseEvent.CLICK,takeOff);
      }
      
      public function removeListener() : *
      {
         ItemsPanel.itemsPanel["xfRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,yesXF);
         ItemsPanel.itemsPanel["xfRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,noXF);
         ItemsPanel.itemsPanel["fhRMB"]["yes_btn"].removeEventListener(MouseEvent.CLICK,yesFH);
         ItemsPanel.itemsPanel["fhRMB"]["no_btn"].removeEventListener(MouseEvent.CLICK,noFH);
         ItemsPanel.itemsPanel["txtTop"]["close"].removeEventListener(MouseEvent.CLICK,closeTXT);
         ItemsPanel.itemsPanel["txtTop2"]["close"].removeEventListener(MouseEvent.CLICK,closeTXT2);
         ItemsPanel.itemsPanel["isFenJie"]["yesFJ"].removeEventListener(MouseEvent.CLICK,yesFJ);
         ItemsPanel.itemsPanel["isFenJie"]["noFJ"].removeEventListener(MouseEvent.CLICK,noFJ);
         ItemsPanel.itemsPanel["getFJ"]["close"].removeEventListener(MouseEvent.CLICK,closeFJ);
         ItemsPanel.itemsPanel.removeEventListener(BtnEvent.DO_CLICK,btnListen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].removeEventListener(MouseEvent.MOUSE_OVER,tipOpen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].removeEventListener(MouseEvent.MOUSE_OUT,tipClose);
         menuTooltip["menu_1"]["off_btn"].removeEventListener(MouseEvent.CLICK,takeOff);
         menuTooltip["menu_2"]["wear_btn"].removeEventListener(MouseEvent.CLICK,wear);
         menuTooltip["menu_2"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_2"]["fenJie"].removeEventListener(MouseEvent.CLICK,isFJ);
         menuTooltip["menu_2"]["wear_btn"].removeEventListener(MouseEvent.CLICK,wear);
         menuTooltip["menu_3"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_3"]["key_btn1"].removeEventListener(MouseEvent.CLICK,setKey_1);
         menuTooltip["menu_3"]["key_btn2"].removeEventListener(MouseEvent.CLICK,setKey_2);
         menuTooltip["menu_3"]["key_btn3"].removeEventListener(MouseEvent.CLICK,setKey_3);
         menuTooltip["menu_4"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_5"]["left_btn"].removeEventListener(MouseEvent.CLICK,leftInto);
         menuTooltip["menu_5"]["right_btn"].removeEventListener(MouseEvent.CLICK,rightInto);
         menuTooltip["menu_5"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_6"]["free_btn"].removeEventListener(MouseEvent.CLICK,setFree);
         menuTooltip["menu_7"]["use_btn"].removeEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_7"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_8"]["use_btn"].removeEventListener(MouseEvent.CLICK,useOther);
         menuTooltip["menu_8"]["alluse_btn"].removeEventListener(MouseEvent.CLICK,alluseOther);
         menuTooltip["menu_8"]["sell_btn"].removeEventListener(MouseEvent.CLICK,sell);
         menuTooltip["menu_9"]["fuhua"].removeEventListener(MouseEvent.CLICK,fuhua);
         menuTooltip["menu_9"]["fuhuaNow"].removeEventListener(MouseEvent.CLICK,fuhuaNow);
         menuTooltip["menu_10"]["xf_btn"].removeEventListener(MouseEvent.CLICK,xufei);
         menuTooltip["menu_10"]["yc_btn"].removeEventListener(MouseEvent.CLICK,yincang);
         menuTooltip["menu_10"]["xs_btn"].removeEventListener(MouseEvent.CLICK,xianshi);
         menuTooltip["menu_10"]["off_btn"].removeEventListener(MouseEvent.CLICK,takeOff);
      }
      
      public function setItemsMenu(param1:uint, param2:uint, param3:uint) : *
      {
         whichDo = param3;
         selectType = param1;
         oldNum = param2;
         menuTooltip["menu_1"].visible = false;
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = false;
         menuTooltip["menu_7"].visible = false;
         menuTooltip["menu_8"].visible = false;
         menuTooltip["menu_9"].visible = false;
         menuTooltip["menu_10"].visible = false;
         switch(selectType)
         {
            case 1:
               if(whichDo == 1)
               {
                  if(bag.getEquipFromBag(oldNum).getDressLevel() < 50)
                  {
                     menuTooltip["menu_2"]["fenJie"].visible = false;
                  }
                  else
                  {
                     menuTooltip["menu_2"]["fenJie"].visible = true;
                  }
               }
               else if(bag2P.getEquipFromBag(oldNum).getDressLevel() < 50)
               {
                  menuTooltip["menu_2"]["fenJie"].visible = false;
               }
               else
               {
                  menuTooltip["menu_2"]["fenJie"].visible = true;
               }
               menuTooltip["menu_2"].visible = true;
               break;
            case 2:
               menuTooltip["menu_3"].visible = true;
               break;
            case 3:
               if(whichDo == 1)
               {
                  if(bag.getGemFromBag(oldNum).getType() == 4)
                  {
                     menuTooltip["menu_5"].visible = true;
                  }
                  else if(bag.getGemFromBag(oldNum).getType() == 5 || bag.getGemFromBag(oldNum).getType() == 6)
                  {
                     menuTooltip["menu_7"].visible = true;
                  }
                  else
                  {
                     menuTooltip["menu_4"].visible = true;
                  }
               }
               else if(bag2P.getGemFromBag(oldNum).getType() == 4)
               {
                  menuTooltip["menu_5"].visible = true;
               }
               else if(bag2P.getGemFromBag(oldNum).getType() == 5 || bag2P.getGemFromBag(oldNum).getType() == 6)
               {
                  menuTooltip["menu_7"].visible = true;
               }
               else
               {
                  menuTooltip["menu_4"].visible = true;
               }
               break;
            case 4:
               if(whichDo == 1)
               {
                  if(bag.getOtherobjFromBag(oldNum).getIsUse() == 1)
                  {
                     menuTooltip["menu_7"].visible = true;
                  }
                  else if(bag.getOtherobjFromBag(oldNum).getIsUse() == 0)
                  {
                     menuTooltip["menu_4"].visible = true;
                  }
                  else if(bag.getOtherobjFromBag(oldNum).getIsUse() == 3)
                  {
                     menuTooltip["menu_8"].visible = true;
                  }
                  else if(bag.getOtherobjFromBag(oldNum).getIsUse() == 4)
                  {
                     menuTooltip["menu_9"].visible = true;
                  }
               }
               else if(bag2P.getOtherobjFromBag(oldNum).getIsUse() == 1)
               {
                  menuTooltip["menu_7"].visible = true;
               }
               else if(bag2P.getOtherobjFromBag(oldNum).getIsUse() == 0)
               {
                  menuTooltip["menu_4"].visible = true;
               }
               else if(bag2P.getOtherobjFromBag(oldNum).getIsUse() == 3)
               {
                  menuTooltip["menu_8"].visible = true;
               }
               else if(bag2P.getOtherobjFromBag(oldNum).getIsUse() == 4)
               {
                  menuTooltip["menu_9"].visible = true;
               }
               break;
            case 5:
               menuTooltip["menu_4"].visible = true;
         }
      }
      
      private function tipOpen(param1:MouseEvent) : void
      {
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsTooltip);
         ItemsPanel.itemsTooltip.x = ItemsPanel.itemsPanel.mouseX;
         ItemsPanel.itemsTooltip.y = ItemsPanel.itemsPanel.mouseY;
         if(whichDo == 1)
         {
            ItemsPanel.itemsTooltip.gemTooltip(bag.getGemFromBag(oldNum));
         }
         else
         {
            ItemsPanel.itemsTooltip.gemTooltip(bag2P.getGemFromBag(oldNum));
         }
         ItemsPanel.itemsTooltip.visible = true;
      }
      
      private function tipClose(param1:MouseEvent) : void
      {
         ItemsPanel.itemsTooltip.visible = false;
      }
      
      private function getPart(param1:Number) : uint
      {
         switch(param1)
         {
            case 1:
               return 0;
            case 2:
               return 1;
            case 3:
               return 3;
            case 4:
               return 4;
            case 5:
               return 2;
            case 6:
               return 2;
            case 7:
               return 2;
            case 8:
               return 6;
            case 9:
               return 7;
            default:
               return null;
         }
      }
      
      public function setSlotMenu(param1:uint, param2:uint) : *
      {
         oldNum = param1;
         whichDo = param2;
         if(oldNum < 6)
         {
            menuTooltip["menu_1"].visible = true;
            menuTooltip["menu_10"].visible = false;
         }
         else
         {
            menuTooltip["menu_1"].visible = false;
            menuTooltip["menu_10"].visible = true;
            if(oldNum == 6)
            {
               if(Main["player_" + whichDo].skin_Z2_V)
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = true;
               }
               else
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = false;
               }
            }
            else if(oldNum == 7)
            {
               if(Main["player_" + whichDo].skin_Z3_V)
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = true;
               }
               else
               {
                  menuTooltip["menu_10"]["yc_btn"].visible = false;
               }
            }
            if(Main["player" + whichDo].getEquipSlot().getEquipFromSlot(oldNum).getColor() >= 4)
            {
               menuTooltip["menu_10"]["xf_btn"].visible = false;
            }
            else
            {
               menuTooltip["menu_10"]["xf_btn"].visible = true;
            }
         }
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = false;
         menuTooltip["menu_7"].visible = false;
         menuTooltip["menu_8"].visible = false;
         menuTooltip["menu_9"].visible = false;
      }
      
      public function setSkillSlotMenu(param1:uint, param2:uint) : *
      {
         oldNum = param1;
         whichDo = param2;
         menuTooltip["menu_1"].visible = false;
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = true;
         menuTooltip["menu_7"].visible = false;
         menuTooltip["menu_8"].visible = false;
         menuTooltip["menu_9"].visible = false;
         menuTooltip["menu_10"].visible = false;
      }
      
      private function bagNoBug() : *
      {
         if(whichDo == 1)
         {
            ItemsPanel.isPOne = true;
            ItemsPanel.itemsPanel["bagOne"].isClick = true;
         }
         else
         {
            ItemsPanel.isPOne = false;
            ItemsPanel.itemsPanel["bagTwo"].isClick = true;
         }
      }
      
      public function fuhua(param1:*) : *
      {
         var _loc2_:int = 0;
         if(whichDo == 1)
         {
            if(Main.player1.getPetSlot().backPetSlotNum() > 0)
            {
               _loc2_ = int(Main.player1.getBag().delOtherobj(oldNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(_loc2_));
            }
            else
            {
               ShortTip.open(37);
            }
            BagItemsShow.otherobjShow();
         }
         else
         {
            if(Main.player2.getPetSlot().backPetSlotNum() > 0)
            {
               _loc2_ = int(Main.player2.getBag().delOtherobj(oldNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(_loc2_));
            }
            else
            {
               ShortTip.open(37);
            }
            BagItemsShow.otherobjShow2P();
         }
      }
      
      public function fuhuaNow(param1:*) : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["fhRMB"]);
      }
      
      public function yesFH(param1:*) : *
      {
         if(whichDo == 1)
         {
            if(Main.player1.getPetSlot().backPetSlotNum() <= 0)
            {
               ShortTip.open(37);
               return;
            }
         }
         else if(Main.player2.getPetSlot().backPetSlotNum() <= 0)
         {
            ShortTip.open(37);
            return;
         }
         Api_4399_All.Money_down(InitData.fuHua.getValue());
         menuTooltip["menu_9"]["fuhuaNow"].visible = false;
         moneyOK = true;
         ItemsPanel.itemsPanel["fhRMB"].visible = false;
      }
      
      public function noFH(param1:*) : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = false;
      }
      
      public function wear(param1:MouseEvent) : *
      {
         var _loc2_:Equip = null;
         var _loc3_:uint = 0;
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               _loc3_ = uint(getPart(bag.getEquipFromBag(oldNum).getPosition()));
               if(bag.getEquipFromBag(oldNum).getDressLevel() <= Main.player1.getLevel() || bag.getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(equipSlot.getEquipFromSlot(_loc3_) == null)
                  {
                     equipSlot.addToSlot(bag.getEquipFromBag(oldNum),_loc3_);
                     bag.delEquip(oldNum);
                  }
                  else
                  {
                     _loc2_ = equipSlot.delSlot(_loc3_);
                     equipSlot.addToSlot(bag.getEquipFromBag(oldNum),_loc3_);
                     bag.delEquip(oldNum);
                     bag.addToEquipBag(_loc2_,oldNum);
                  }
               }
               else
               {
                  ShortTip.open(25);
               }
            }
            Main.player_1.LoadPlayerLvData();
            Player.getEquipDataXX();
            BagItemsShow.informationShow();
            BagItemsShow.equipShow();
            BagItemsShow.slotShow();
            ItemsPanel.changeModel(Main.player1);
         }
         else
         {
            if(selectType == 1)
            {
               _loc3_ = uint(getPart(bag2P.getEquipFromBag(oldNum).getPosition()));
               if(bag2P.getEquipFromBag(oldNum).getDressLevel() <= Main.player2.getLevel() || bag2P.getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(equipSlot2P.getEquipFromSlot(_loc3_) == null)
                  {
                     equipSlot2P.addToSlot(bag2P.getEquipFromBag(oldNum),_loc3_);
                     bag2P.delEquip(oldNum);
                  }
                  else
                  {
                     _loc2_ = equipSlot2P.delSlot(_loc3_);
                     equipSlot2P.addToSlot(bag2P.getEquipFromBag(oldNum),_loc3_);
                     bag2P.delEquip(oldNum);
                     bag2P.addToEquipBag(_loc2_,oldNum);
                  }
               }
               else
               {
                  ShortTip.open(25);
               }
            }
            Main.player_2.LoadPlayerLvData();
            Player.getEquipDataXX();
            BagItemsShow.informationShow2P();
            BagItemsShow.equipShow2P();
            BagItemsShow.slotShow2P();
            ItemsPanel.changeModel(Main.player2);
         }
      }
      
      public function takeOff(param1:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(bag.backequipBagNum() > 0)
            {
               bag.addEquipBag(equipSlot.getEquipFromSlot(oldNum));
               equipSlot.delSlot(oldNum);
            }
            else
            {
               ShortTip.open(3);
            }
            Player.getEquipDataXX();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_1"].isClick = true;
            ItemsPanel.itemsType = 1;
            BagItemsShow.equipShow();
            BagItemsShow.slotShow();
            BagItemsShow.informationShow();
            ItemsPanel.changeModel(Main.player1);
         }
         else
         {
            if(bag2P.backequipBagNum() > 0)
            {
               bag2P.addEquipBag(equipSlot2P.getEquipFromSlot(oldNum));
               equipSlot2P.delSlot(oldNum);
            }
            else
            {
               ShortTip.open(3);
            }
            Player.getEquipDataXX();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_1"].isClick = true;
            ItemsPanel.itemsType2P = 1;
            BagItemsShow.equipShow2P();
            BagItemsShow.slotShow2P();
            BagItemsShow.informationShow2P();
            ItemsPanel.changeModel(Main.player2);
         }
      }
      
      public function leftInto(param1:MouseEvent) : *
      {
         var _loc2_:Gem = null;
         if(whichDo == 1)
         {
            if(bag.getGemFromBag(oldNum).getUseLevel() <= Main.player1.getLevel())
            {
               if(skillSlot.getGemFromSkillSlot(0) == null)
               {
                  skillSlot.addToSkillSlot(bag.getGemFromBag(oldNum),0);
                  bag.delGem(oldNum,1);
               }
               else
               {
                  _loc2_ = skillSlot.delSkillSlot(0);
                  skillSlot.addToSkillSlot(bag.getGemFromBag(oldNum),0);
                  bag.delGem(oldNum,1);
                  bag.addToGemBag(_loc2_,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyLeftNum.setValue(0);
            Main.player_1.energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(skillSlot.getGemFromSkillSlot(0).getGemSkill()).getEp());
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
         }
         else
         {
            if(bag2P.getGemFromBag(oldNum).getUseLevel() <= Main.player2.getLevel())
            {
               if(skillSlot2P.getGemFromSkillSlot(0) == null)
               {
                  skillSlot2P.addToSkillSlot(bag2P.getGemFromBag(oldNum),0);
                  bag2P.delGem(oldNum,1);
               }
               else
               {
                  _loc2_ = skillSlot2P.delSkillSlot(0);
                  skillSlot2P.addToSkillSlot(bag2P.getGemFromBag(oldNum),0);
                  bag2P.delGem(oldNum,1);
                  bag2P.addToGemBag(_loc2_,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyLeftNum.setValue(0);
            Main.player_2.energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(skillSlot2P.getGemFromSkillSlot(0).getGemSkill()).getEp());
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
      }
      
      public function rightInto(param1:MouseEvent) : *
      {
         var _loc2_:Gem = null;
         if(whichDo == 1)
         {
            if(bag.getGemFromBag(oldNum).getUseLevel() <= Main.player1.getLevel())
            {
               if(skillSlot.getGemFromSkillSlot(1) == null)
               {
                  skillSlot.addToSkillSlot(bag.getGemFromBag(oldNum),1);
                  bag.delGem(oldNum,1);
               }
               else
               {
                  _loc2_ = skillSlot.delSkillSlot(1);
                  skillSlot.addToSkillSlot(bag.getGemFromBag(oldNum),1);
                  bag.delGem(oldNum,1);
                  bag.addToGemBag(_loc2_,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyRightMax.setValue(SkillFactory.getSkillById(skillSlot.getGemFromSkillSlot(1).getGemSkill()).getEp());
            Main.player_1.energySlot.energyRightNum.setValue(0);
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
         }
         else
         {
            if(bag2P.getGemFromBag(oldNum).getUseLevel() <= Main.player2.getLevel())
            {
               if(skillSlot2P.getGemFromSkillSlot(1) == null)
               {
                  skillSlot2P.addToSkillSlot(bag2P.getGemFromBag(oldNum),1);
                  bag2P.delGem(oldNum,1);
               }
               else
               {
                  _loc2_ = skillSlot2P.delSkillSlot(1);
                  skillSlot2P.addToSkillSlot(bag2P.getGemFromBag(oldNum),1);
                  bag2P.delGem(oldNum,1);
                  bag2P.addToGemBag(_loc2_,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyRightMax.setValue(SkillFactory.getSkillById(skillSlot2P.getGemFromSkillSlot(1).getGemSkill()).getEp());
            Main.player_2.energySlot.energyRightNum.setValue(0);
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
      }
      
      public function setFree(param1:MouseEvent) : *
      {
         var _loc2_:Gem = null;
         if(whichDo == 1)
         {
            if(bag.backGemBagNum() > 0)
            {
               bag.addGemBag(skillSlot.delSkillSlot(oldNum));
               if(oldNum == 0)
               {
                  Main.player_1.energySlot.energyLeftMax.setValue(0);
                  Main.player_1.energySlot.energyLeftNum.setValue(0);
               }
               else
               {
                  Main.player_1.energySlot.energyRightMax.setValue(0);
                  Main.player_1.energySlot.energyRightNum.setValue(0);
               }
            }
            else
            {
               ShortTip.open(3);
            }
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_3"].isClick = true;
            ItemsPanel.itemsType = 3;
         }
         else
         {
            if(bag2P.backGemBagNum() > 0)
            {
               bag2P.addGemBag(skillSlot2P.delSkillSlot(oldNum));
               if(oldNum == 0)
               {
                  Main.player_2.energySlot.energyLeftMax.setValue(0);
                  Main.player_2.energySlot.energyLeftNum.setValue(0);
               }
               else
               {
                  Main.player_2.energySlot.energyRightMax.setValue(0);
                  Main.player_2.energySlot.energyRightNum.setValue(0);
               }
            }
            else
            {
               ShortTip.open(3);
            }
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_3"].isClick = true;
            ItemsPanel.itemsType2P = 3;
         }
      }
      
      public function allSell(param1:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["isAllSell"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isAllSell"]);
      }
      
      public function sell(param1:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               if(bag.getEquipFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(bag.getEquipFromBag(oldNum).getPrice());
                  bag.delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.equipShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 2)
            {
               if(bag.getSuppliesFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(bag.getSuppliesFromBag(oldNum).getPrice());
                  bag.delSupplies(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.suppliesShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 3)
            {
               if(bag.getGemFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(bag.getGemFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else if(bag.getGemFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(bag.getGemFromBag(oldNum).getPrice());
                  bag.delGem(oldNum,1);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 4)
            {
               if(bag.getOtherobjFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(bag.getOtherobjFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
            }
            if(selectType == 5)
            {
               ItemsPanel.itemsPanel["isSell"].visible = true;
               ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
            }
         }
         else
         {
            if(selectType == 1)
            {
               if(bag2P.getEquipFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(bag2P.getEquipFromBag(oldNum).getPrice());
                  bag2P.delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.equipShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 2)
            {
               if(bag2P.getSuppliesFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(bag2P.getSuppliesFromBag(oldNum).getPrice());
                  bag2P.delSupplies(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.suppliesShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 3)
            {
               if(bag2P.getGemFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(bag2P.getGemFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else if(bag2P.getGemFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(bag2P.getGemFromBag(oldNum).getPrice());
                  bag2P.delGem(oldNum,1);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.gemShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 4)
            {
               if(bag2P.getOtherobjFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(bag2P.getOtherobjFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
            }
            if(selectType == 5)
            {
               ItemsPanel.itemsPanel["isSell"].visible = true;
               ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
            }
         }
      }
      
      private function noAllSell() : *
      {
         bagNoBug();
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      private function yesAllSell() : *
      {
         var _loc1_:* = undefined;
         bagNoBug();
         if(whichDo == 1)
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(bag.getEquipFromBag(_loc1_) != null)
               {
                  if(bag.getEquipFromBag(_loc1_).getColor() <= 2 && bag.getEquipFromBag(_loc1_).getPosition() <= 7)
                  {
                     Main.player1.addGold(bag.getEquipFromBag(_loc1_).getPrice());
                     bag.delEquip(_loc1_);
                  }
               }
               _loc1_++;
            }
            BagItemsShow.equipShow();
            BagItemsShow.informationShow();
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(bag2P.getEquipFromBag(_loc1_) != null)
               {
                  if(bag2P.getEquipFromBag(_loc1_).getColor() <= 2 && bag2P.getEquipFromBag(_loc1_).getPosition() <= 7)
                  {
                     Main.player2.addGold(bag2P.getEquipFromBag(_loc1_).getPrice());
                     bag2P.delEquip(_loc1_);
                  }
               }
               _loc1_++;
            }
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      private function yesHandle() : *
      {
         bagNoBug();
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               Main.player1.addGold(bag.getEquipFromBag(oldNum).getPrice());
               bag.delEquip(oldNum);
               BagItemsShow.equipShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 2)
            {
               Main.player1.addGold(bag.getSuppliesFromBag(oldNum).getPrice());
               bag.delSupplies(oldNum);
               BagItemsShow.suppliesShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 3)
            {
               Main.player1.addGold(bag.getGemFromBag(oldNum).getPrice());
               bag.delGem(oldNum,1);
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 4)
            {
               Main.player1.addGold(bag.getOtherobjFromBag(oldNum).getGold());
               bag.delOtherobj(oldNum,1);
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
            if(selectType == 5)
            {
               Main.player1.addGold(bag.getQuestFromBag(oldNum).getGold());
               bag.delQuset(oldNum);
               BagItemsShow.questShow();
               BagItemsShow.informationShow();
            }
         }
         else
         {
            if(selectType == 1)
            {
               Main.player2.addGold(bag2P.getEquipFromBag(oldNum).getPrice());
               bag2P.delEquip(oldNum);
               BagItemsShow.equipShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 2)
            {
               Main.player2.addGold(bag2P.getSuppliesFromBag(oldNum).getPrice());
               bag2P.delSupplies(oldNum);
               BagItemsShow.suppliesShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 3)
            {
               Main.player2.addGold(bag2P.getGemFromBag(oldNum).getPrice());
               bag2P.delGem(oldNum,1);
               BagItemsShow.gemShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 4)
            {
               Main.player2.addGold(bag2P.getOtherobjFromBag(oldNum).getGold());
               bag2P.delOtherobj(oldNum,1);
               BagItemsShow.otherobjShow2P();
               BagItemsShow.informationShow2P();
            }
            if(selectType == 5)
            {
               Main.player2.addGold(bag2P.getQuestFromBag(oldNum).getGold());
               bag2P.delQuset(oldNum);
               BagItemsShow.questShow2P();
               BagItemsShow.informationShow2P();
            }
         }
         ItemsPanel.itemsPanel["isSell"].visible = false;
      }
      
      public function btnListen(param1:BtnEvent) : *
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         switch(_loc2_.name)
         {
            case "yesBtn_All":
               yesAllSell();
               break;
            case "noBtn_All":
               noAllSell();
               break;
            case "yesBtn":
               yesHandle();
               break;
            case "noBtn":
               bagNoBug();
               ItemsPanel.itemsPanel["isSell"].visible = false;
               break;
            case "sellUp":
               setUp();
               break;
            case "sellDown":
               setDown();
               break;
            case "sellBtn":
               sellBatch();
               bagNoBug();
               break;
            case "closeSellMenu":
               bagNoBug();
               ItemsPanel.itemsPanel["sellMenu"].visible = false;
         }
      }
      
      private function sellBatch() : void
      {
         if(whichDo == 1)
         {
            if(selectType == 3)
            {
               Main.player1.addGold(bag.getGemFromBag(oldNum).getPrice() * amount.getValue());
               bag.delGem(oldNum,amount.getValue());
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            else if(selectType == 4)
            {
               Main.player1.addGold(bag.getOtherobjFromBag(oldNum).getGold() * amount.getValue());
               bag.delOtherobj(oldNum,amount.getValue());
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
         }
         else if(selectType == 3)
         {
            Main.player2.addGold(bag2P.getGemFromBag(oldNum).getPrice() * amount.getValue());
            bag2P.delGem(oldNum,amount.getValue());
            BagItemsShow.gemShow2P();
            BagItemsShow.informationShow2P();
         }
         else if(selectType == 4)
         {
            Main.player2.addGold(bag2P.getOtherobjFromBag(oldNum).getGold() * amount.getValue());
            bag2P.delOtherobj(oldNum,amount.getValue());
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["sellMenu"].visible = false;
      }
      
      private function setUp() : void
      {
         if(whichDo == 1)
         {
            if(selectType == 3)
            {
               if(amount.getValue() == bag.getGemFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == bag.getOtherobjFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
         else
         {
            if(selectType == 3)
            {
               if(amount.getValue() == bag2P.getGemFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == bag2P.getOtherobjFromBag(oldNum).getTimes())
               {
                  amount.setValue(1);
               }
               else
               {
                  amount.setValue(amount.getValue() + 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
      }
      
      private function setDown() : void
      {
         if(whichDo == 1)
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
            if(selectType == 3)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(bag.getGemFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(bag.getOtherobjFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
         else
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
            if(selectType == 3)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(bag2P.getGemFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            else if(selectType == 4)
            {
               if(amount.getValue() == 1)
               {
                  amount.setValue(bag2P.getOtherobjFromBag(oldNum).getTimes());
               }
               else
               {
                  amount.setValue(amount.getValue() - 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount.getValue();
         }
      }
      
      public function alluseOther(param1:*) : *
      {
         if(whichDo == 1)
         {
            if(bag.getOtherobjFromBag(oldNum).getType() == 11)
            {
               while(Boolean(bag.getOtherobjFromBag(oldNum)) && bag.getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(!(Main.player1.getLevel() < 50 || Main.player1.getLevel() < Player.maxLevel && Boolean(Main.player1.isRebirth())))
                  {
                     break;
                  }
                  Main.player_1.ExpUP(InitData.EXP_num.getValue(),2);
                  bag.delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            BagItemsShow.otherobjShow();
            BagItemsShow.informationShow();
         }
         else
         {
            if(bag2P.getOtherobjFromBag(oldNum).getType() == 11)
            {
               while(Boolean(bag2P.getOtherobjFromBag(oldNum)) && bag2P.getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(!(Main.player2.getLevel() < 50 || Main.player2.getLevel() < Player.maxLevel && Boolean(Main.player2.isRebirth())))
                  {
                     break;
                  }
                  Main.player_2.ExpUP(InitData.EXP_num.getValue(),2);
                  bag2P.delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
      }
      
      public function useOther(param1:MouseEvent) : *
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         if(whichDo == 1)
         {
            if(selectType == 4)
            {
               if(bag.getOtherobjFromBag(oldNum).getType() == 4)
               {
                  InitData.EXPxTimeUp(bag.getOtherobjFromBag(oldNum).getRemaining());
                  bag.delOtherobj(oldNum,1);
                  Main.Save();
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 5)
               {
                  InitData.DOWNxTimeUp(bag.getOtherobjFromBag(oldNum).getRemaining());
                  bag.delOtherobj(oldNum,1);
                  Main.Save();
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 7)
               {
                  MakeData.open(bag.getOtherobjFromBag(oldNum).getId());
                  bag.delOtherobj(oldNum,1);
                  ShortTip.open(31);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 9)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + InitData.BuyNum_300.getValue());
                  Main.player1.addGold(InitData.BuyNum_80000.getValue());
                  bag.delOtherobj(oldNum,1);
                  Main.Save();
                  ItemsPanel.itemsPanel["txtTop"].visible = true;
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 10)
               {
                  TaskData.otherUpdataTask();
                  bag.delOtherobj(oldNum,1);
                  ShortTip.open(34);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 11)
               {
                  if(Main.player1.getLevel() < 50 || Main.player1.getLevel() < Player.maxLevel && Boolean(Main.player1.isRebirth()))
                  {
                     Main.player_1.ExpUP(InitData.EXP_num.getValue(),2);
                     bag.delOtherobj(oldNum,1);
                     ShortTip.open(35);
                  }
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 17)
               {
                  QiangHuaPanel.open(true,oldNum);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 18)
               {
                  Main.player1.getBadgeSlot().addToSlot(bag.getOtherobjFromBag(oldNum),0);
                  bag.delOtherobj(oldNum,1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 19)
               {
                  Main.player1.getBadgeSlot().addToSlot(bag.getOtherobjFromBag(oldNum),1);
                  bag.delOtherobj(oldNum,1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 20)
               {
                  Main.player1.getBadgeSlot().addToSlot(bag.getOtherobjFromBag(oldNum),2);
                  bag.delOtherobj(oldNum,1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 21)
               {
                  Main.player1.getBadgeSlot().addToSlot(bag.getOtherobjFromBag(oldNum),3);
                  bag.delOtherobj(oldNum,1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 22)
               {
                  Main.player1.getBadgeSlot().addToSlot(bag.getOtherobjFromBag(oldNum),4);
                  bag.delOtherobj(oldNum,1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 23)
               {
                  Main.player1.getBadgeSlot().addToSlot(bag.getOtherobjFromBag(oldNum),5);
                  bag.delOtherobj(oldNum,1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 24)
               {
                  Main.player1.getTitleSlot().addToSlot(TitleFactory.creatTitle(bag.getOtherobjFromBag(oldNum).getValue_1()));
                  bag.delOtherobj(oldNum,1);
                  Main.player_1.cengHao_mc.Show(1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 25)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + InitData.BuyNum_50.getValue());
                  Main.player1.addGold(InitData.BuyNum_18000.getValue());
                  bag.delOtherobj(oldNum,1);
                  ItemsPanel.itemsPanel["txtTop2"].visible = true;
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 27)
               {
                  Main.player1.getElvesSlot().addElvesSlot(ElvesFactory.creatElves(bag.getOtherobjFromBag(oldNum).getValue_1()));
                  bag.delOtherobj(oldNum,1);
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 26)
               {
                  if(bag.backOtherBagNum() >= 4)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < 5)
                     {
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63155));
                        _loc2_++;
                     }
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                     bag.delOtherobj(oldNum,1);
                  }
                  else
                  {
                     ShortTip.open(3);
                  }
               }
               else if(bag.getOtherobjFromBag(oldNum).getType() == 28)
               {
                  if(bag.backOtherBagNum() >= 3)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < 5)
                     {
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                        _loc2_++;
                     }
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63195));
                     bag.delOtherobj(oldNum,1);
                  }
                  else
                  {
                     ShortTip.open(3);
                  }
               }
               BagItemsShow.badgeSlotShow();
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
            else if(selectType == 3)
            {
               if(bag.getGemFromBag(oldNum).getType() == 5)
               {
                  _loc3_ = uint(Main.player1.getBag().getGemFromBag(oldNum).getGemSkill());
                  _loc4_ = Main.player1.getBag().getGemFromBag(oldNum).getDescript();
                  zengfuPanel.open(true,_loc4_,_loc3_,oldNum);
               }
               else if(bag.getGemFromBag(oldNum).getType() == 6)
               {
                  _loc5_ = int(bag.getGemFromBag(oldNum).getStrengthenLevel());
                  _loc6_ = bag.getGemFromBag(oldNum).getDescript();
                  upstarPanel.open(true,_loc6_,_loc5_,oldNum);
               }
            }
         }
         else if(selectType == 4)
         {
            if(bag2P.getOtherobjFromBag(oldNum).getType() == 4)
            {
               InitData.EXPxTimeUp(bag2P.getOtherobjFromBag(oldNum).getMultiple());
               bag2P.delOtherobj(oldNum,1);
               Main.Save();
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 5)
            {
               InitData.DOWNxTimeUp(bag2P.getOtherobjFromBag(oldNum).getRemaining());
               bag2P.delOtherobj(oldNum,1);
               Main.Save();
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 7)
            {
               MakeData.open(bag2P.getOtherobjFromBag(oldNum).getId());
               bag2P.delOtherobj(oldNum,1);
               ShortTip.open(31);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 9)
            {
               Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + InitData.BuyNum_300.getValue());
               Main.player2.addGold(InitData.BuyNum_80000.getValue());
               bag2P.delOtherobj(oldNum,1);
               Main.Save();
               ItemsPanel.itemsPanel["txtTop"].visible = true;
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 10)
            {
               TaskData.otherUpdataTask();
               bag2P.delOtherobj(oldNum,1);
               ShortTip.open(34);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 11)
            {
               if(Main.player2.getLevel() < 50 || Main.player2.getLevel() < Player.maxLevel && Boolean(Main.player2.isRebirth()))
               {
                  Main.player_2.ExpUP(InitData.EXP_num.getValue(),2);
                  bag2P.delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 17)
            {
               QiangHuaPanel.open(false,oldNum);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 18)
            {
               Main.player2.getBadgeSlot().addToSlot(bag2P.getOtherobjFromBag(oldNum),0);
               bag2P.delOtherobj(oldNum,1);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 19)
            {
               Main.player2.getBadgeSlot().addToSlot(bag2P.getOtherobjFromBag(oldNum),1);
               bag2P.delOtherobj(oldNum,1);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 20)
            {
               Main.player2.getBadgeSlot().addToSlot(bag2P.getOtherobjFromBag(oldNum),2);
               bag2P.delOtherobj(oldNum,1);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 21)
            {
               Main.player2.getBadgeSlot().addToSlot(bag2P.getOtherobjFromBag(oldNum),3);
               bag2P.delOtherobj(oldNum,1);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 22)
            {
               Main.player2.getBadgeSlot().addToSlot(bag2P.getOtherobjFromBag(oldNum),4);
               bag2P.delOtherobj(oldNum,1);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 23)
            {
               Main.player2.getBadgeSlot().addToSlot(bag2P.getOtherobjFromBag(oldNum),5);
               bag2P.delOtherobj(oldNum,1);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 24)
            {
               Main.player2.getTitleSlot().addToSlot(TitleFactory.creatTitle(bag2P.getOtherobjFromBag(oldNum).getValue_1()));
               bag2P.delOtherobj(oldNum,1);
               Main.player_2.cengHao_mc.Show(2);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 27)
            {
               Main.player2.getElvesSlot().addElvesSlot(ElvesFactory.creatElves(bag2P.getOtherobjFromBag(oldNum).getValue_1()));
               bag2P.delOtherobj(oldNum,1);
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 25)
            {
               Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + InitData.BuyNum_50.getValue());
               Main.player2.addGold(InitData.BuyNum_18000.getValue());
               bag2P.delOtherobj(oldNum,1);
               ItemsPanel.itemsPanel["txtTop2"].visible = true;
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 26)
            {
               if(bag2P.backOtherBagNum() >= 4)
               {
                  _loc2_ = 0;
                  while(_loc2_ < 5)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63155));
                     _loc2_++;
                  }
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                  bag2P.delOtherobj(oldNum,1);
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            else if(bag2P.getOtherobjFromBag(oldNum).getType() == 28)
            {
               if(bag2P.backOtherBagNum() >= 3)
               {
                  _loc2_ = 0;
                  while(_loc2_ < 5)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                     _loc2_++;
                  }
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63195));
                  bag2P.delOtherobj(oldNum,1);
               }
               else
               {
                  ShortTip.open(3);
               }
            }
            BagItemsShow.badgeSlotShow2P();
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
         else if(selectType == 3)
         {
            if(bag2P.getGemFromBag(oldNum).getType() == 5)
            {
               _loc3_ = uint(Main.player2.getBag().getGemFromBag(oldNum).getGemSkill());
               _loc4_ = Main.player2.getBag().getGemFromBag(oldNum).getDescript();
               zengfuPanel.open(false,_loc4_,_loc3_,oldNum);
            }
            else if(bag2P.getGemFromBag(oldNum).getType() == 6)
            {
               _loc5_ = int(bag2P.getGemFromBag(oldNum).getStrengthenLevel());
               _loc6_ = bag2P.getGemFromBag(oldNum).getDescript();
               upstarPanel.open(false,_loc6_,_loc5_,oldNum);
            }
         }
      }
      
      public function yesFJ(param1:*) : *
      {
         ItemsPanel.itemsPanel["isFenJie"].visible = false;
         if(whichDo == 1)
         {
            doFenJie();
            bag.delEquip(oldNum);
            BagItemsShow.equipShow();
            BagItemsShow.informationShow();
         }
         else
         {
            doFenJie();
            bag2P.delEquip(oldNum);
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
      }
      
      public function noFJ(param1:*) : *
      {
         ItemsPanel.itemsPanel["isFenJie"].visible = false;
      }
      
      public function isFJ(param1:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               if(bag.getEquipFromBag(oldNum).getColor() <= 2)
               {
                  doFenJie();
                  bag.delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isFenJie"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isFenJie"]);
               }
               BagItemsShow.equipShow();
               BagItemsShow.informationShow();
            }
         }
         else if(selectType == 1)
         {
            if(bag2P.getEquipFromBag(oldNum).getColor() <= 2)
            {
               doFenJie();
               bag2P.delEquip(oldNum);
            }
            else
            {
               ItemsPanel.itemsPanel["isFenJie"].visible = true;
               ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isFenJie"]);
            }
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
      }
      
      private function setOtherColor(param1:int) : void
      {
         if(param1 == 1)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xffffff");
         }
         if(param1 == 2)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0x0066ff");
         }
         if(param1 == 3)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xFF33FF");
         }
         if(param1 == 4)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xFF9900");
         }
      }
      
      private function ColorX(param1:*, param2:String) : *
      {
         var _loc3_:* = new TextFormat();
         _loc3_.color = param2;
         param1.setTextFormat(_loc3_);
      }
      
      private function showPicAndNum(param1:Otherobj, param2:int) : *
      {
         ItemsPanel.itemsPanel["getFJ"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["getFJ"]);
         ItemsPanel.itemsPanel["getFJ"]["showPic"].gotoAndStop(param1.getFrame());
         ItemsPanel.itemsPanel["getFJ"]["showPic"]["t_txt"].text = param2;
         ItemsPanel.itemsPanel["getFJ"]["mingzhi"].text = param1.getName();
         ItemsPanel.itemsPanel["getFJ"]["miaoshu"].text = param1.getIntroduction();
         setOtherColor(param1.getColor());
      }
      
      private function getColor1() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(_loc2_)
            {
               case 0:
                  _loc1_ = 0;
                  while(_loc1_ < 3)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63132));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),3);
                  break;
               case 1:
                  bag.addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 2:
                  bag.addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 3:
                  _loc1_ = 0;
                  while(_loc1_ < 3)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63135));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
         else
         {
            switch(_loc2_)
            {
               case 0:
                  _loc1_ = 0;
                  while(_loc1_ < 3)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63132));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),3);
                  break;
               case 1:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 2:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 3:
                  _loc1_ = 0;
                  while(_loc1_ < 3)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63135));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
      }
      
      private function getColor2() : *
      {
         var _loc1_:int = 0;
         var _loc2_:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(_loc2_)
            {
               case 0:
                  _loc1_ = 0;
                  while(_loc1_ < 6)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63132));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  _loc1_ = 0;
                  while(_loc1_ < 2)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63133));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  _loc1_ = 0;
                  while(_loc1_ < 2)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63134));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  _loc1_ = 0;
                  while(_loc1_ < 6)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63135));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
         else
         {
            switch(_loc2_)
            {
               case 0:
                  _loc1_ = 0;
                  while(_loc1_ < 6)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63132));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  _loc1_ = 0;
                  while(_loc1_ < 2)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63133));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  _loc1_ = 0;
                  while(_loc1_ < 2)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63134));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  _loc1_ = 0;
                  while(_loc1_ < 6)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63135));
                     _loc1_++;
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
      }
      
      private function getColor3() : *
      {
         var _loc1_:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(_loc1_)
            {
               case 0:
                  bag.addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 1:
                  bag.addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 2:
                  bag.addOtherobjBag(OtherFactory.creatOther(63136));
                  showPicAndNum(OtherFactory.creatOther(63136),1);
                  break;
               case 3:
                  bag.addOtherobjBag(OtherFactory.creatOther(63137));
                  showPicAndNum(OtherFactory.creatOther(63137),1);
            }
         }
         else
         {
            switch(_loc1_)
            {
               case 0:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63133));
                  showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 1:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63134));
                  showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 2:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63136));
                  showPicAndNum(OtherFactory.creatOther(63136),1);
                  break;
               case 3:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63137));
                  showPicAndNum(OtherFactory.creatOther(63137),1);
            }
         }
      }
      
      private function getColor4() : *
      {
         var _loc1_:int = Math.random() * 3;
         if(whichDo == 1)
         {
            switch(_loc1_)
            {
               case 0:
                  i = 0;
                  while(i < 15)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63136));
                     ++i;
                  }
                  showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  i = 0;
                  while(i < 15)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63137));
                     ++i;
                  }
                  showPicAndNum(OtherFactory.creatOther(63137),15);
                  break;
               case 2:
                  bag.addOtherobjBag(OtherFactory.creatOther(63138));
                  showPicAndNum(OtherFactory.creatOther(63138),1);
            }
         }
         else
         {
            switch(_loc1_)
            {
               case 0:
                  i = 0;
                  while(i < 15)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63136));
                     ++i;
                  }
                  showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  i = 0;
                  while(i < 15)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63137));
                     ++i;
                  }
                  showPicAndNum(OtherFactory.creatOther(63137),15);
                  break;
               case 2:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63138));
                  showPicAndNum(OtherFactory.creatOther(63138),1);
            }
         }
      }
      
      private function doFenJie() : *
      {
         if(whichDo == 1)
         {
            switch(bag.getEquipFromBag(oldNum).getColor())
            {
               case 1:
                  getColor1();
                  break;
               case 2:
                  getColor2();
                  break;
               case 3:
                  getColor3();
                  break;
               case 4:
                  getColor4();
                  break;
               case 5:
                  getColor4();
            }
         }
         else
         {
            switch(bag2P.getEquipFromBag(oldNum).getColor())
            {
               case 1:
                  getColor1();
                  break;
               case 2:
                  getColor2();
                  break;
               case 3:
                  getColor3();
                  break;
               case 4:
                  getColor4();
                  break;
               case 5:
                  getColor4();
            }
         }
      }
      
      private function closeFJ(param1:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["getFJ"].visible = false;
      }
      
      private function closeTXT(param1:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["txtTop"].visible = false;
      }
      
      private function closeTXT2(param1:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["txtTop2"].visible = false;
      }
      
      public function setKey_1(param1:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(su,0);
         }
         else
         {
            su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(su,0);
         }
      }
      
      public function setKey_2(param1:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(su,1);
         }
         else
         {
            su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(su,1);
         }
      }
      
      public function setKey_3(param1:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(su,2);
         }
         else
         {
            su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(su,2);
         }
      }
      
      public function yesXF(param1:*) : *
      {
         Api_4399_All.Money_down(InitData.fuHua.getValue());
         moneyOK2 = true;
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
      }
      
      public function noXF(param1:*) : *
      {
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
      }
      
      public function xufei(param1:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["xfRMB"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["xfRMB"]);
      }
      
      public function xianshi(param1:MouseEvent) : *
      {
         if(oldNum == 6 && Main["player_" + whichDo].skin_Z2_V == false)
         {
            Main["player_" + whichDo].skin_Z2_V = true;
         }
         else if(oldNum == 7 && Main["player_" + whichDo].skin_Z3_V == false)
         {
            Main["player_" + whichDo].skin_Z3_V = true;
         }
         Main["player_" + whichDo].newSkin();
      }
      
      public function yincang(param1:MouseEvent) : *
      {
         if(oldNum == 6 && Main["player_" + whichDo].skin_Z2_V == true)
         {
            Main["player_" + whichDo].skin_Z2_V = false;
         }
         else if(oldNum == 7 && Main["player_" + whichDo].skin_Z3_V == true)
         {
            Main["player_" + whichDo].skin_Z3_V = false;
         }
         Main["player_" + whichDo].newSkin();
      }
   }
}

