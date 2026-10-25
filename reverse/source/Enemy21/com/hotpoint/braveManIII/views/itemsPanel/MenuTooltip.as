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
         this.bag = Main.player1.getBag();
         this.equipSlot = Main.player1.getEquipSlot();
         this.skillSlot = Main.player1.getEquipSkillSlot();
         if(Main.P1P2)
         {
            this.bag2P = Main.player2.getBag();
            this.equipSlot2P = Main.player2.getEquipSlot();
            this.skillSlot2P = Main.player2.getEquipSkillSlot();
         }
         this.addChild(menuTooltip);
         this.visible = false;
      }
      
      public static function lijifuhua() : *
      {
         var id:int = 0;
         if(moneyOK)
         {
            if(whichDo == 1)
            {
               id = int(Main.player1.getBag().delOtherobj(oldNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(PetFactory.creatPet(id).getLink()));
               BagItemsShow.otherobjShow();
            }
            else
            {
               id = int(Main.player2.getBag().delOtherobj(oldNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(PetFactory.creatPet(id).getLink()));
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
         ItemsPanel.itemsPanel["xfRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,this.yesXF);
         ItemsPanel.itemsPanel["xfRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,this.noXF);
         ItemsPanel.itemsPanel["fhRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,this.yesFH);
         ItemsPanel.itemsPanel["fhRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,this.noFH);
         ItemsPanel.itemsPanel["txtTop"]["close"].addEventListener(MouseEvent.CLICK,this.closeTXT);
         ItemsPanel.itemsPanel["txtTop2"]["close"].addEventListener(MouseEvent.CLICK,this.closeTXT2);
         ItemsPanel.itemsPanel["isFenJie"]["yesFJ"].addEventListener(MouseEvent.CLICK,this.yesFJ);
         ItemsPanel.itemsPanel["isFenJie"]["noFJ"].addEventListener(MouseEvent.CLICK,this.noFJ);
         ItemsPanel.itemsPanel["getFJ"]["close"].addEventListener(MouseEvent.CLICK,this.closeFJ);
         ItemsPanel.itemsPanel.addEventListener(BtnEvent.DO_CLICK,this.btnListen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].addEventListener(MouseEvent.MOUSE_OVER,this.tipOpen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].addEventListener(MouseEvent.MOUSE_OUT,this.tipClose);
         menuTooltip["menu_1"]["off_btn"].addEventListener(MouseEvent.CLICK,this.takeOff);
         menuTooltip["menu_2"]["wear_btn"].addEventListener(MouseEvent.CLICK,this.wear);
         menuTooltip["menu_2"]["sell_btn"].addEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_2"]["all_Sell"].addEventListener(MouseEvent.CLICK,this.allSell);
         menuTooltip["menu_2"]["fenJie"].addEventListener(MouseEvent.CLICK,this.isFJ);
         menuTooltip["menu_3"]["sell_btn"].addEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_3"]["key_btn1"].addEventListener(MouseEvent.CLICK,this.setKey_1);
         menuTooltip["menu_3"]["key_btn2"].addEventListener(MouseEvent.CLICK,this.setKey_2);
         menuTooltip["menu_3"]["key_btn3"].addEventListener(MouseEvent.CLICK,this.setKey_3);
         menuTooltip["menu_4"]["sell_btn"].addEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_5"]["left_btn"].addEventListener(MouseEvent.CLICK,this.leftInto);
         menuTooltip["menu_5"]["right_btn"].addEventListener(MouseEvent.CLICK,this.rightInto);
         menuTooltip["menu_5"]["sell_btn"].addEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_6"]["free_btn"].addEventListener(MouseEvent.CLICK,this.setFree);
         menuTooltip["menu_7"]["use_btn"].addEventListener(MouseEvent.CLICK,this.useOther);
         menuTooltip["menu_7"]["sell_btn"].addEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_8"]["use_btn"].addEventListener(MouseEvent.CLICK,this.useOther);
         menuTooltip["menu_8"]["alluse_btn"].addEventListener(MouseEvent.CLICK,this.alluseOther);
         menuTooltip["menu_8"]["sell_btn"].addEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_9"]["fuhua"].addEventListener(MouseEvent.CLICK,this.fuhua);
         menuTooltip["menu_9"]["fuhuaNow"].addEventListener(MouseEvent.CLICK,this.fuhuaNow);
         menuTooltip["menu_10"]["xf_btn"].addEventListener(MouseEvent.CLICK,this.xufei);
         menuTooltip["menu_10"]["yc_btn"].addEventListener(MouseEvent.CLICK,this.yincang);
         menuTooltip["menu_10"]["xs_btn"].addEventListener(MouseEvent.CLICK,this.xianshi);
         menuTooltip["menu_10"]["off_btn"].addEventListener(MouseEvent.CLICK,this.takeOff);
      }
      
      public function removeListener() : *
      {
         ItemsPanel.itemsPanel["xfRMB"]["yes_btn"].addEventListener(MouseEvent.CLICK,this.yesXF);
         ItemsPanel.itemsPanel["xfRMB"]["no_btn"].addEventListener(MouseEvent.CLICK,this.noXF);
         ItemsPanel.itemsPanel["fhRMB"]["yes_btn"].removeEventListener(MouseEvent.CLICK,this.yesFH);
         ItemsPanel.itemsPanel["fhRMB"]["no_btn"].removeEventListener(MouseEvent.CLICK,this.noFH);
         ItemsPanel.itemsPanel["txtTop"]["close"].removeEventListener(MouseEvent.CLICK,this.closeTXT);
         ItemsPanel.itemsPanel["txtTop2"]["close"].removeEventListener(MouseEvent.CLICK,this.closeTXT2);
         ItemsPanel.itemsPanel["isFenJie"]["yesFJ"].removeEventListener(MouseEvent.CLICK,this.yesFJ);
         ItemsPanel.itemsPanel["isFenJie"]["noFJ"].removeEventListener(MouseEvent.CLICK,this.noFJ);
         ItemsPanel.itemsPanel["getFJ"]["close"].removeEventListener(MouseEvent.CLICK,this.closeFJ);
         ItemsPanel.itemsPanel.removeEventListener(BtnEvent.DO_CLICK,this.btnListen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].removeEventListener(MouseEvent.MOUSE_OVER,this.tipOpen);
         ItemsPanel.itemsPanel["sellMenu"]["showPic"].removeEventListener(MouseEvent.MOUSE_OUT,this.tipClose);
         menuTooltip["menu_1"]["off_btn"].removeEventListener(MouseEvent.CLICK,this.takeOff);
         menuTooltip["menu_2"]["wear_btn"].removeEventListener(MouseEvent.CLICK,this.wear);
         menuTooltip["menu_2"]["sell_btn"].removeEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_2"]["fenJie"].removeEventListener(MouseEvent.CLICK,this.isFJ);
         menuTooltip["menu_2"]["wear_btn"].removeEventListener(MouseEvent.CLICK,this.wear);
         menuTooltip["menu_3"]["sell_btn"].removeEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_3"]["key_btn1"].removeEventListener(MouseEvent.CLICK,this.setKey_1);
         menuTooltip["menu_3"]["key_btn2"].removeEventListener(MouseEvent.CLICK,this.setKey_2);
         menuTooltip["menu_3"]["key_btn3"].removeEventListener(MouseEvent.CLICK,this.setKey_3);
         menuTooltip["menu_4"]["sell_btn"].removeEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_5"]["left_btn"].removeEventListener(MouseEvent.CLICK,this.leftInto);
         menuTooltip["menu_5"]["right_btn"].removeEventListener(MouseEvent.CLICK,this.rightInto);
         menuTooltip["menu_5"]["sell_btn"].removeEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_6"]["free_btn"].removeEventListener(MouseEvent.CLICK,this.setFree);
         menuTooltip["menu_7"]["use_btn"].removeEventListener(MouseEvent.CLICK,this.useOther);
         menuTooltip["menu_7"]["sell_btn"].removeEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_8"]["use_btn"].removeEventListener(MouseEvent.CLICK,this.useOther);
         menuTooltip["menu_8"]["alluse_btn"].removeEventListener(MouseEvent.CLICK,this.alluseOther);
         menuTooltip["menu_8"]["sell_btn"].removeEventListener(MouseEvent.CLICK,this.sell);
         menuTooltip["menu_9"]["fuhua"].removeEventListener(MouseEvent.CLICK,this.fuhua);
         menuTooltip["menu_9"]["fuhuaNow"].removeEventListener(MouseEvent.CLICK,this.fuhuaNow);
         menuTooltip["menu_10"]["xf_btn"].removeEventListener(MouseEvent.CLICK,this.xufei);
         menuTooltip["menu_10"]["yc_btn"].removeEventListener(MouseEvent.CLICK,this.yincang);
         menuTooltip["menu_10"]["xs_btn"].removeEventListener(MouseEvent.CLICK,this.xianshi);
         menuTooltip["menu_10"]["off_btn"].removeEventListener(MouseEvent.CLICK,this.takeOff);
      }
      
      public function setItemsMenu(type:uint, num:uint, whichPlayerData:uint) : *
      {
         whichDo = whichPlayerData;
         this.selectType = type;
         oldNum = num;
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
         switch(this.selectType)
         {
            case 1:
               if(whichDo == 1)
               {
                  if(this.bag.getEquipFromBag(oldNum).getDressLevel() < 50)
                  {
                     menuTooltip["menu_2"]["fenJie"].visible = false;
                  }
                  else
                  {
                     menuTooltip["menu_2"]["fenJie"].visible = true;
                  }
               }
               else if(this.bag2P.getEquipFromBag(oldNum).getDressLevel() < 50)
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
                  if(this.bag.getGemFromBag(oldNum).getType() == 4)
                  {
                     menuTooltip["menu_5"].visible = true;
                  }
                  else if(this.bag.getGemFromBag(oldNum).getType() == 5 || this.bag.getGemFromBag(oldNum).getType() == 6)
                  {
                     menuTooltip["menu_7"].visible = true;
                  }
                  else
                  {
                     menuTooltip["menu_4"].visible = true;
                  }
               }
               else if(this.bag2P.getGemFromBag(oldNum).getType() == 4)
               {
                  menuTooltip["menu_5"].visible = true;
               }
               else if(this.bag2P.getGemFromBag(oldNum).getType() == 5 || this.bag2P.getGemFromBag(oldNum).getType() == 6)
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
                  if(this.bag.getOtherobjFromBag(oldNum).getIsUse() == 1)
                  {
                     menuTooltip["menu_7"].visible = true;
                  }
                  else if(this.bag.getOtherobjFromBag(oldNum).getIsUse() == 0)
                  {
                     menuTooltip["menu_4"].visible = true;
                  }
                  else if(this.bag.getOtherobjFromBag(oldNum).getIsUse() == 3)
                  {
                     menuTooltip["menu_8"].visible = true;
                  }
                  else if(this.bag.getOtherobjFromBag(oldNum).getIsUse() == 4)
                  {
                     menuTooltip["menu_9"].visible = true;
                  }
               }
               else if(this.bag2P.getOtherobjFromBag(oldNum).getIsUse() == 1)
               {
                  menuTooltip["menu_7"].visible = true;
               }
               else if(this.bag2P.getOtherobjFromBag(oldNum).getIsUse() == 0)
               {
                  menuTooltip["menu_4"].visible = true;
               }
               else if(this.bag2P.getOtherobjFromBag(oldNum).getIsUse() == 3)
               {
                  menuTooltip["menu_8"].visible = true;
               }
               else if(this.bag2P.getOtherobjFromBag(oldNum).getIsUse() == 4)
               {
                  menuTooltip["menu_9"].visible = true;
               }
               break;
            case 5:
               menuTooltip["menu_4"].visible = true;
         }
      }
      
      private function tipOpen(e:MouseEvent) : void
      {
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsTooltip);
         ItemsPanel.itemsTooltip.x = ItemsPanel.itemsPanel.mouseX;
         ItemsPanel.itemsTooltip.y = ItemsPanel.itemsPanel.mouseY;
         if(whichDo == 1)
         {
            ItemsPanel.itemsTooltip.gemTooltip(this.bag.getGemFromBag(oldNum));
         }
         else
         {
            ItemsPanel.itemsTooltip.gemTooltip(this.bag2P.getGemFromBag(oldNum));
         }
         ItemsPanel.itemsTooltip.visible = true;
      }
      
      private function tipClose(e:MouseEvent) : void
      {
         ItemsPanel.itemsTooltip.visible = false;
      }
      
      private function getPart(num:Number) : uint
      {
         switch(num)
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
      
      public function setSlotMenu(num:uint, whichPlayerData:uint) : *
      {
         oldNum = num;
         whichDo = whichPlayerData;
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
      
      public function setSkillSlotMenu(num:uint, whichPlayerData:uint) : *
      {
         oldNum = num;
         whichDo = whichPlayerData;
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
      
      public function fuhua(e:*) : *
      {
         var id:int = 0;
         if(whichDo == 1)
         {
            if(Main.player1.getPetSlot().backPetSlotNum() > 0)
            {
               id = int(Main.player1.getBag().delOtherobj(oldNum).getValue_1());
               Main.player1.getPetSlot().addPetSlot(PetFactory.creatPet(id));
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
               id = int(Main.player2.getBag().delOtherobj(oldNum).getValue_1());
               Main.player2.getPetSlot().addPetSlot(PetFactory.creatPet(id));
            }
            else
            {
               ShortTip.open(37);
            }
            BagItemsShow.otherobjShow2P();
         }
      }
      
      public function fuhuaNow(e:*) : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["fhRMB"]);
      }
      
      public function yesFH(e:*) : *
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
      
      public function noFH(e:*) : *
      {
         ItemsPanel.itemsPanel["fhRMB"].visible = false;
      }
      
      public function wear(e:MouseEvent) : *
      {
         var equip:Equip = null;
         var part:uint = 0;
         if(whichDo == 1)
         {
            if(this.selectType == 1)
            {
               part = uint(this.getPart(this.bag.getEquipFromBag(oldNum).getPosition()));
               if(this.bag.getEquipFromBag(oldNum).getDressLevel() <= Main.player1.getLevel() || this.bag.getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(this.equipSlot.getEquipFromSlot(part) == null)
                  {
                     this.equipSlot.addToSlot(this.bag.getEquipFromBag(oldNum),part);
                     this.bag.delEquip(oldNum);
                  }
                  else
                  {
                     equip = this.equipSlot.delSlot(part);
                     this.equipSlot.addToSlot(this.bag.getEquipFromBag(oldNum),part);
                     this.bag.delEquip(oldNum);
                     this.bag.addToEquipBag(equip,oldNum);
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
            if(this.selectType == 1)
            {
               part = uint(this.getPart(this.bag2P.getEquipFromBag(oldNum).getPosition()));
               if(this.bag2P.getEquipFromBag(oldNum).getDressLevel() <= Main.player2.getLevel() || this.bag2P.getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(this.equipSlot2P.getEquipFromSlot(part) == null)
                  {
                     this.equipSlot2P.addToSlot(this.bag2P.getEquipFromBag(oldNum),part);
                     this.bag2P.delEquip(oldNum);
                  }
                  else
                  {
                     equip = this.equipSlot2P.delSlot(part);
                     this.equipSlot2P.addToSlot(this.bag2P.getEquipFromBag(oldNum),part);
                     this.bag2P.delEquip(oldNum);
                     this.bag2P.addToEquipBag(equip,oldNum);
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
      
      public function takeOff(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(this.bag.backequipBagNum() > 0)
            {
               this.bag.addEquipBag(this.equipSlot.getEquipFromSlot(oldNum));
               this.equipSlot.delSlot(oldNum);
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
            if(this.bag2P.backequipBagNum() > 0)
            {
               this.bag2P.addEquipBag(this.equipSlot2P.getEquipFromSlot(oldNum));
               this.equipSlot2P.delSlot(oldNum);
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
      
      public function leftInto(e:MouseEvent) : *
      {
         var gem:Gem = null;
         if(whichDo == 1)
         {
            if(this.bag.getGemFromBag(oldNum).getUseLevel() <= Main.player1.getLevel())
            {
               if(this.skillSlot.getGemFromSkillSlot(0) == null)
               {
                  this.skillSlot.addToSkillSlot(this.bag.getGemFromBag(oldNum),0);
                  this.bag.delGem(oldNum,1);
               }
               else
               {
                  gem = this.skillSlot.delSkillSlot(0);
                  this.skillSlot.addToSkillSlot(this.bag.getGemFromBag(oldNum),0);
                  this.bag.delGem(oldNum,1);
                  this.bag.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyLeftNum.setValue(0);
            Main.player_1.energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(this.skillSlot.getGemFromSkillSlot(0).getGemSkill()).getEp());
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
         }
         else
         {
            if(this.bag2P.getGemFromBag(oldNum).getUseLevel() <= Main.player2.getLevel())
            {
               if(this.skillSlot2P.getGemFromSkillSlot(0) == null)
               {
                  this.skillSlot2P.addToSkillSlot(this.bag2P.getGemFromBag(oldNum),0);
                  this.bag2P.delGem(oldNum,1);
               }
               else
               {
                  gem = this.skillSlot2P.delSkillSlot(0);
                  this.skillSlot2P.addToSkillSlot(this.bag2P.getGemFromBag(oldNum),0);
                  this.bag2P.delGem(oldNum,1);
                  this.bag2P.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyLeftNum.setValue(0);
            Main.player_2.energySlot.energyLeftMax.setValue(SkillFactory.getSkillById(this.skillSlot2P.getGemFromSkillSlot(0).getGemSkill()).getEp());
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
      }
      
      public function rightInto(e:MouseEvent) : *
      {
         var gem:Gem = null;
         if(whichDo == 1)
         {
            if(this.bag.getGemFromBag(oldNum).getUseLevel() <= Main.player1.getLevel())
            {
               if(this.skillSlot.getGemFromSkillSlot(1) == null)
               {
                  this.skillSlot.addToSkillSlot(this.bag.getGemFromBag(oldNum),1);
                  this.bag.delGem(oldNum,1);
               }
               else
               {
                  gem = this.skillSlot.delSkillSlot(1);
                  this.skillSlot.addToSkillSlot(this.bag.getGemFromBag(oldNum),1);
                  this.bag.delGem(oldNum,1);
                  this.bag.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyRightMax.setValue(SkillFactory.getSkillById(this.skillSlot.getGemFromSkillSlot(1).getGemSkill()).getEp());
            Main.player_1.energySlot.energyRightNum.setValue(0);
            BagItemsShow.skillSlotShow();
            BagItemsShow.gemShow();
         }
         else
         {
            if(this.bag2P.getGemFromBag(oldNum).getUseLevel() <= Main.player2.getLevel())
            {
               if(this.skillSlot2P.getGemFromSkillSlot(1) == null)
               {
                  this.skillSlot2P.addToSkillSlot(this.bag2P.getGemFromBag(oldNum),1);
                  this.bag2P.delGem(oldNum,1);
               }
               else
               {
                  gem = this.skillSlot2P.delSkillSlot(1);
                  this.skillSlot2P.addToSkillSlot(this.bag2P.getGemFromBag(oldNum),1);
                  this.bag2P.delGem(oldNum,1);
                  this.bag2P.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyRightMax.setValue(SkillFactory.getSkillById(this.skillSlot2P.getGemFromSkillSlot(1).getGemSkill()).getEp());
            Main.player_2.energySlot.energyRightNum.setValue(0);
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
      }
      
      public function setFree(e:MouseEvent) : *
      {
         var gem:Gem = null;
         if(whichDo == 1)
         {
            if(this.bag.backGemBagNum() > 0)
            {
               this.bag.addGemBag(this.skillSlot.delSkillSlot(oldNum));
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
            if(this.bag2P.backGemBagNum() > 0)
            {
               this.bag2P.addGemBag(this.skillSlot2P.delSkillSlot(oldNum));
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
      
      public function allSell(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["isAllSell"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isAllSell"]);
      }
      
      public function sell(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(this.selectType == 1)
            {
               if(this.bag.getEquipFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(this.bag.getEquipFromBag(oldNum).getPrice());
                  this.bag.delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.equipShow();
               BagItemsShow.informationShow();
            }
            if(this.selectType == 2)
            {
               if(this.bag.getSuppliesFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(this.bag.getSuppliesFromBag(oldNum).getPrice());
                  this.bag.delSupplies(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.suppliesShow();
               BagItemsShow.informationShow();
            }
            if(this.selectType == 3)
            {
               if(this.bag.getGemFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  this.amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(this.bag.getGemFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else if(this.bag.getGemFromBag(oldNum).getColor() <= 2)
               {
                  Main.player1.addGold(this.bag.getGemFromBag(oldNum).getPrice());
                  this.bag.delGem(oldNum,1);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            if(this.selectType == 4)
            {
               if(this.bag.getOtherobjFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  this.amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(this.bag.getOtherobjFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
            }
            if(this.selectType == 5)
            {
               ItemsPanel.itemsPanel["isSell"].visible = true;
               ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
            }
         }
         else
         {
            if(this.selectType == 1)
            {
               if(this.bag2P.getEquipFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(this.bag2P.getEquipFromBag(oldNum).getPrice());
                  this.bag2P.delEquip(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.equipShow2P();
               BagItemsShow.informationShow2P();
            }
            if(this.selectType == 2)
            {
               if(this.bag2P.getSuppliesFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(this.bag2P.getSuppliesFromBag(oldNum).getPrice());
                  this.bag2P.delSupplies(oldNum);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.suppliesShow2P();
               BagItemsShow.informationShow2P();
            }
            if(this.selectType == 3)
            {
               if(this.bag2P.getGemFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  this.amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(this.bag2P.getGemFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else if(this.bag2P.getGemFromBag(oldNum).getColor() <= 2)
               {
                  Main.player2.addGold(this.bag2P.getGemFromBag(oldNum).getPrice());
                  this.bag2P.delGem(oldNum,1);
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
               BagItemsShow.gemShow2P();
               BagItemsShow.informationShow2P();
            }
            if(this.selectType == 4)
            {
               if(this.bag2P.getOtherobjFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  this.amount.setValue(1);
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"].gotoAndStop(this.bag2P.getOtherobjFromBag(oldNum).getFrame());
                  ItemsPanel.itemsPanel["sellMenu"]["showPic"]["t_txt"].visible = false;
               }
               else
               {
                  ItemsPanel.itemsPanel["isSell"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
               }
            }
            if(this.selectType == 5)
            {
               ItemsPanel.itemsPanel["isSell"].visible = true;
               ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isSell"]);
            }
         }
      }
      
      private function noAllSell() : *
      {
         this.bagNoBug();
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      private function yesAllSell() : *
      {
         var i:* = undefined;
         this.bagNoBug();
         if(whichDo == 1)
         {
            for(i = 0; i < 24; i++)
            {
               if(this.bag.getEquipFromBag(i) != null)
               {
                  if(this.bag.getEquipFromBag(i).getColor() <= 2 && this.bag.getEquipFromBag(i).getPosition() <= 7)
                  {
                     Main.player1.addGold(this.bag.getEquipFromBag(i).getPrice());
                     this.bag.delEquip(i);
                  }
               }
            }
            BagItemsShow.equipShow();
            BagItemsShow.informationShow();
         }
         else
         {
            for(i = 0; i < 24; i++)
            {
               if(this.bag2P.getEquipFromBag(i) != null)
               {
                  if(this.bag2P.getEquipFromBag(i).getColor() <= 2 && this.bag2P.getEquipFromBag(i).getPosition() <= 7)
                  {
                     Main.player2.addGold(this.bag2P.getEquipFromBag(i).getPrice());
                     this.bag2P.delEquip(i);
                  }
               }
            }
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      private function yesHandle() : *
      {
         this.bagNoBug();
         if(whichDo == 1)
         {
            if(this.selectType == 1)
            {
               Main.player1.addGold(this.bag.getEquipFromBag(oldNum).getPrice());
               this.bag.delEquip(oldNum);
               BagItemsShow.equipShow();
               BagItemsShow.informationShow();
            }
            if(this.selectType == 2)
            {
               Main.player1.addGold(this.bag.getSuppliesFromBag(oldNum).getPrice());
               this.bag.delSupplies(oldNum);
               BagItemsShow.suppliesShow();
               BagItemsShow.informationShow();
            }
            if(this.selectType == 3)
            {
               Main.player1.addGold(this.bag.getGemFromBag(oldNum).getPrice());
               this.bag.delGem(oldNum,1);
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            if(this.selectType == 4)
            {
               Main.player1.addGold(this.bag.getOtherobjFromBag(oldNum).getGold());
               this.bag.delOtherobj(oldNum,1);
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
            if(this.selectType == 5)
            {
               Main.player1.addGold(this.bag.getQuestFromBag(oldNum).getGold());
               this.bag.delQuset(oldNum);
               BagItemsShow.questShow();
               BagItemsShow.informationShow();
            }
         }
         else
         {
            if(this.selectType == 1)
            {
               Main.player2.addGold(this.bag2P.getEquipFromBag(oldNum).getPrice());
               this.bag2P.delEquip(oldNum);
               BagItemsShow.equipShow2P();
               BagItemsShow.informationShow2P();
            }
            if(this.selectType == 2)
            {
               Main.player2.addGold(this.bag2P.getSuppliesFromBag(oldNum).getPrice());
               this.bag2P.delSupplies(oldNum);
               BagItemsShow.suppliesShow2P();
               BagItemsShow.informationShow2P();
            }
            if(this.selectType == 3)
            {
               Main.player2.addGold(this.bag2P.getGemFromBag(oldNum).getPrice());
               this.bag2P.delGem(oldNum,1);
               BagItemsShow.gemShow2P();
               BagItemsShow.informationShow2P();
            }
            if(this.selectType == 4)
            {
               Main.player2.addGold(this.bag2P.getOtherobjFromBag(oldNum).getGold());
               this.bag2P.delOtherobj(oldNum,1);
               BagItemsShow.otherobjShow2P();
               BagItemsShow.informationShow2P();
            }
            if(this.selectType == 5)
            {
               Main.player2.addGold(this.bag2P.getQuestFromBag(oldNum).getGold());
               this.bag2P.delQuset(oldNum);
               BagItemsShow.questShow2P();
               BagItemsShow.informationShow2P();
            }
         }
         ItemsPanel.itemsPanel["isSell"].visible = false;
      }
      
      public function btnListen(e:BtnEvent) : *
      {
         var btn:MovieClip = e.target as MovieClip;
         switch(btn.name)
         {
            case "yesBtn_All":
               this.yesAllSell();
               break;
            case "noBtn_All":
               this.noAllSell();
               break;
            case "yesBtn":
               this.yesHandle();
               break;
            case "noBtn":
               this.bagNoBug();
               ItemsPanel.itemsPanel["isSell"].visible = false;
               break;
            case "sellUp":
               this.setUp();
               break;
            case "sellDown":
               this.setDown();
               break;
            case "sellBtn":
               this.sellBatch();
               this.bagNoBug();
               break;
            case "closeSellMenu":
               this.bagNoBug();
               ItemsPanel.itemsPanel["sellMenu"].visible = false;
         }
      }
      
      private function sellBatch() : void
      {
         if(whichDo == 1)
         {
            if(this.selectType == 3)
            {
               Main.player1.addGold(this.bag.getGemFromBag(oldNum).getPrice() * this.amount.getValue());
               this.bag.delGem(oldNum,this.amount.getValue());
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            else if(this.selectType == 4)
            {
               Main.player1.addGold(this.bag.getOtherobjFromBag(oldNum).getGold() * this.amount.getValue());
               this.bag.delOtherobj(oldNum,this.amount.getValue());
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
         }
         else if(this.selectType == 3)
         {
            Main.player2.addGold(this.bag2P.getGemFromBag(oldNum).getPrice() * this.amount.getValue());
            this.bag2P.delGem(oldNum,this.amount.getValue());
            BagItemsShow.gemShow2P();
            BagItemsShow.informationShow2P();
         }
         else if(this.selectType == 4)
         {
            Main.player2.addGold(this.bag2P.getOtherobjFromBag(oldNum).getGold() * this.amount.getValue());
            this.bag2P.delOtherobj(oldNum,this.amount.getValue());
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["sellMenu"].visible = false;
      }
      
      private function setUp() : void
      {
         if(whichDo == 1)
         {
            if(this.selectType == 3)
            {
               if(this.amount.getValue() == this.bag.getGemFromBag(oldNum).getTimes())
               {
                  this.amount.setValue(1);
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() + 1);
               }
            }
            else if(this.selectType == 4)
            {
               if(this.amount.getValue() == this.bag.getOtherobjFromBag(oldNum).getTimes())
               {
                  this.amount.setValue(1);
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() + 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
         }
         else
         {
            if(this.selectType == 3)
            {
               if(this.amount.getValue() == this.bag2P.getGemFromBag(oldNum).getTimes())
               {
                  this.amount.setValue(1);
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() + 1);
               }
            }
            else if(this.selectType == 4)
            {
               if(this.amount.getValue() == this.bag2P.getOtherobjFromBag(oldNum).getTimes())
               {
                  this.amount.setValue(1);
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() + 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
         }
      }
      
      private function setDown() : void
      {
         if(whichDo == 1)
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
            if(this.selectType == 3)
            {
               if(this.amount.getValue() == 1)
               {
                  this.amount.setValue(this.bag.getGemFromBag(oldNum).getTimes());
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() - 1);
               }
            }
            else if(this.selectType == 4)
            {
               if(this.amount.getValue() == 1)
               {
                  this.amount.setValue(this.bag.getOtherobjFromBag(oldNum).getTimes());
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() - 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
         }
         else
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
            if(this.selectType == 3)
            {
               if(this.amount.getValue() == 1)
               {
                  this.amount.setValue(this.bag2P.getGemFromBag(oldNum).getTimes());
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() - 1);
               }
            }
            else if(this.selectType == 4)
            {
               if(this.amount.getValue() == 1)
               {
                  this.amount.setValue(this.bag2P.getOtherobjFromBag(oldNum).getTimes());
               }
               else
               {
                  this.amount.setValue(this.amount.getValue() - 1);
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = this.amount.getValue();
         }
      }
      
      public function alluseOther(e:*) : *
      {
         if(whichDo == 1)
         {
            if(this.bag.getOtherobjFromBag(oldNum).getType() == 11)
            {
               while(Boolean(this.bag.getOtherobjFromBag(oldNum)) && this.bag.getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(!(Main.player1.getLevel() < 50 || Main.player1.getLevel() < Player.maxLevel && Boolean(Main.player1.isRebirth())))
                  {
                     break;
                  }
                  Main.player_1.ExpUP(InitData.EXP_num.getValue(),2);
                  this.bag.delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            BagItemsShow.otherobjShow();
            BagItemsShow.informationShow();
         }
         else
         {
            if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 11)
            {
               while(Boolean(this.bag2P.getOtherobjFromBag(oldNum)) && this.bag2P.getOtherobjFromBag(oldNum).getTimes() > 0)
               {
                  if(!(Main.player2.getLevel() < 50 || Main.player2.getLevel() < Player.maxLevel && Boolean(Main.player2.isRebirth())))
                  {
                     break;
                  }
                  Main.player_2.ExpUP(InitData.EXP_num.getValue(),2);
                  this.bag2P.delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
      }
      
      public function useOther(e:MouseEvent) : *
      {
         var i:int = 0;
         var skn:uint = 0;
         var skstr:String = null;
         var star:int = 0;
         var usstr:String = null;
         if(whichDo == 1)
         {
            if(this.selectType == 4)
            {
               if(this.bag.getOtherobjFromBag(oldNum).getType() == 4)
               {
                  InitData.EXPxTimeUp(this.bag.getOtherobjFromBag(oldNum).getRemaining());
                  this.bag.delOtherobj(oldNum,1);
                  Main.Save();
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 5)
               {
                  InitData.DOWNxTimeUp(this.bag.getOtherobjFromBag(oldNum).getRemaining());
                  this.bag.delOtherobj(oldNum,1);
                  Main.Save();
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 7)
               {
                  MakeData.open(this.bag.getOtherobjFromBag(oldNum).getId());
                  this.bag.delOtherobj(oldNum,1);
                  ShortTip.open(31);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 9)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + InitData.BuyNum_300.getValue());
                  Main.player1.addGold(InitData.BuyNum_80000.getValue());
                  this.bag.delOtherobj(oldNum,1);
                  Main.Save();
                  ItemsPanel.itemsPanel["txtTop"].visible = true;
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 10)
               {
                  TaskData.otherUpdataTask();
                  this.bag.delOtherobj(oldNum,1);
                  ShortTip.open(34);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 11)
               {
                  if(Main.player1.getLevel() < 50 || Main.player1.getLevel() < Player.maxLevel && Boolean(Main.player1.isRebirth()))
                  {
                     Main.player_1.ExpUP(InitData.EXP_num.getValue(),2);
                     this.bag.delOtherobj(oldNum,1);
                     ShortTip.open(35);
                  }
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 17)
               {
                  QiangHuaPanel.open(true,oldNum);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 18)
               {
                  Main.player1.getBadgeSlot().addToSlot(this.bag.getOtherobjFromBag(oldNum),0);
                  this.bag.delOtherobj(oldNum,1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 19)
               {
                  Main.player1.getBadgeSlot().addToSlot(this.bag.getOtherobjFromBag(oldNum),1);
                  this.bag.delOtherobj(oldNum,1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 20)
               {
                  Main.player1.getBadgeSlot().addToSlot(this.bag.getOtherobjFromBag(oldNum),2);
                  this.bag.delOtherobj(oldNum,1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 21)
               {
                  Main.player1.getBadgeSlot().addToSlot(this.bag.getOtherobjFromBag(oldNum),3);
                  this.bag.delOtherobj(oldNum,1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 22)
               {
                  Main.player1.getBadgeSlot().addToSlot(this.bag.getOtherobjFromBag(oldNum),4);
                  this.bag.delOtherobj(oldNum,1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 23)
               {
                  Main.player1.getBadgeSlot().addToSlot(this.bag.getOtherobjFromBag(oldNum),5);
                  this.bag.delOtherobj(oldNum,1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 24)
               {
                  Main.player1.getTitleSlot().addToSlot(TitleFactory.creatTitle(this.bag.getOtherobjFromBag(oldNum).getValue_1()));
                  this.bag.delOtherobj(oldNum,1);
                  Main.player_1.cengHao_mc.Show(1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 25)
               {
                  Main.player1.killPoint.setValue(Main.player1.killPoint.getValue() + InitData.BuyNum_50.getValue());
                  Main.player1.addGold(InitData.BuyNum_18000.getValue());
                  this.bag.delOtherobj(oldNum,1);
                  ItemsPanel.itemsPanel["txtTop2"].visible = true;
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 27)
               {
                  Main.player1.getElvesSlot().addElvesSlot(ElvesFactory.creatElves(this.bag.getOtherobjFromBag(oldNum).getValue_1()));
                  this.bag.delOtherobj(oldNum,1);
               }
               else if(this.bag.getOtherobjFromBag(oldNum).getType() == 26)
               {
                  if(this.bag.backOtherBagNum() >= 4)
                  {
                     for(i = 0; i < 5; i++)
                     {
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                        Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63155));
                     }
                     Main.player1.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                     this.bag.delOtherobj(oldNum,1);
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
            else if(this.selectType == 3)
            {
               if(this.bag.getGemFromBag(oldNum).getType() == 5)
               {
                  skn = uint(Main.player1.getBag().getGemFromBag(oldNum).getGemSkill());
                  skstr = Main.player1.getBag().getGemFromBag(oldNum).getDescript();
                  zengfuPanel.open(true,skstr,skn,oldNum);
               }
               else if(this.bag.getGemFromBag(oldNum).getType() == 6)
               {
                  star = int(this.bag.getGemFromBag(oldNum).getStrengthenLevel());
                  usstr = this.bag.getGemFromBag(oldNum).getDescript();
                  upstarPanel.open(true,usstr,star,oldNum);
               }
            }
         }
         else if(this.selectType == 4)
         {
            if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 4)
            {
               InitData.EXPxTimeUp(this.bag2P.getOtherobjFromBag(oldNum).getMultiple());
               this.bag2P.delOtherobj(oldNum,1);
               Main.Save();
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 5)
            {
               InitData.DOWNxTimeUp(this.bag2P.getOtherobjFromBag(oldNum).getRemaining());
               this.bag2P.delOtherobj(oldNum,1);
               Main.Save();
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 7)
            {
               MakeData.open(this.bag2P.getOtherobjFromBag(oldNum).getId());
               this.bag2P.delOtherobj(oldNum,1);
               ShortTip.open(31);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 9)
            {
               Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + InitData.BuyNum_300.getValue());
               Main.player2.addGold(InitData.BuyNum_80000.getValue());
               this.bag2P.delOtherobj(oldNum,1);
               Main.Save();
               ItemsPanel.itemsPanel["txtTop"].visible = true;
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 10)
            {
               TaskData.otherUpdataTask();
               this.bag2P.delOtherobj(oldNum,1);
               ShortTip.open(34);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 11)
            {
               if(Main.player2.getLevel() < 50 || Main.player2.getLevel() < Player.maxLevel && Boolean(Main.player2.isRebirth()))
               {
                  Main.player_2.ExpUP(InitData.EXP_num.getValue(),2);
                  this.bag2P.delOtherobj(oldNum,1);
                  ShortTip.open(35);
               }
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 17)
            {
               QiangHuaPanel.open(false,oldNum);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 18)
            {
               Main.player2.getBadgeSlot().addToSlot(this.bag2P.getOtherobjFromBag(oldNum),0);
               this.bag2P.delOtherobj(oldNum,1);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 19)
            {
               Main.player2.getBadgeSlot().addToSlot(this.bag2P.getOtherobjFromBag(oldNum),1);
               this.bag2P.delOtherobj(oldNum,1);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 20)
            {
               Main.player2.getBadgeSlot().addToSlot(this.bag2P.getOtherobjFromBag(oldNum),2);
               this.bag2P.delOtherobj(oldNum,1);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 21)
            {
               Main.player2.getBadgeSlot().addToSlot(this.bag2P.getOtherobjFromBag(oldNum),3);
               this.bag2P.delOtherobj(oldNum,1);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 22)
            {
               Main.player2.getBadgeSlot().addToSlot(this.bag2P.getOtherobjFromBag(oldNum),4);
               this.bag2P.delOtherobj(oldNum,1);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 23)
            {
               Main.player2.getBadgeSlot().addToSlot(this.bag2P.getOtherobjFromBag(oldNum),5);
               this.bag2P.delOtherobj(oldNum,1);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 24)
            {
               Main.player2.getTitleSlot().addToSlot(TitleFactory.creatTitle(this.bag2P.getOtherobjFromBag(oldNum).getValue_1()));
               this.bag2P.delOtherobj(oldNum,1);
               Main.player_2.cengHao_mc.Show(2);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 27)
            {
               Main.player2.getElvesSlot().addElvesSlot(ElvesFactory.creatElves(this.bag2P.getOtherobjFromBag(oldNum).getValue_1()));
               this.bag2P.delOtherobj(oldNum,1);
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 25)
            {
               Main.player2.killPoint.setValue(Main.player2.killPoint.getValue() + InitData.BuyNum_50.getValue());
               Main.player2.addGold(InitData.BuyNum_18000.getValue());
               this.bag2P.delOtherobj(oldNum,1);
               ItemsPanel.itemsPanel["txtTop2"].visible = true;
            }
            else if(this.bag2P.getOtherobjFromBag(oldNum).getType() == 26)
            {
               if(this.bag2P.backOtherBagNum() >= 4)
               {
                  for(i = 0; i < 5; i++)
                  {
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63100));
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63138));
                     Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63155));
                  }
                  Main.player2.getBag().addOtherobjBag(OtherFactory.creatOther(63140));
                  this.bag2P.delOtherobj(oldNum,1);
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
         else if(this.selectType == 3)
         {
            if(this.bag2P.getGemFromBag(oldNum).getType() == 5)
            {
               skn = uint(Main.player2.getBag().getGemFromBag(oldNum).getGemSkill());
               skstr = Main.player2.getBag().getGemFromBag(oldNum).getDescript();
               zengfuPanel.open(false,skstr,skn,oldNum);
            }
            else if(this.bag2P.getGemFromBag(oldNum).getType() == 6)
            {
               star = int(this.bag2P.getGemFromBag(oldNum).getStrengthenLevel());
               usstr = this.bag2P.getGemFromBag(oldNum).getDescript();
               upstarPanel.open(false,usstr,star,oldNum);
            }
         }
      }
      
      public function yesFJ(e:*) : *
      {
         ItemsPanel.itemsPanel["isFenJie"].visible = false;
         if(whichDo == 1)
         {
            this.doFenJie();
            this.bag.delEquip(oldNum);
            BagItemsShow.equipShow();
            BagItemsShow.informationShow();
         }
         else
         {
            this.doFenJie();
            this.bag2P.delEquip(oldNum);
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
      }
      
      public function noFJ(e:*) : *
      {
         ItemsPanel.itemsPanel["isFenJie"].visible = false;
      }
      
      public function isFJ(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            if(this.selectType == 1)
            {
               if(this.bag.getEquipFromBag(oldNum).getColor() <= 2)
               {
                  this.doFenJie();
                  this.bag.delEquip(oldNum);
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
         else if(this.selectType == 1)
         {
            if(this.bag2P.getEquipFromBag(oldNum).getColor() <= 2)
            {
               this.doFenJie();
               this.bag2P.delEquip(oldNum);
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
      
      private function setOtherColor(color:int) : void
      {
         if(color == 1)
         {
            this.ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xffffff");
         }
         if(color == 2)
         {
            this.ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0x0066ff");
         }
         if(color == 3)
         {
            this.ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xFF33FF");
         }
         if(color == 4)
         {
            this.ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xFF9900");
         }
      }
      
      private function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      private function showPicAndNum(other:Otherobj, num:int) : *
      {
         ItemsPanel.itemsPanel["getFJ"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["getFJ"]);
         ItemsPanel.itemsPanel["getFJ"]["showPic"].gotoAndStop(other.getFrame());
         ItemsPanel.itemsPanel["getFJ"]["showPic"]["t_txt"].text = num;
         ItemsPanel.itemsPanel["getFJ"]["mingzhi"].text = other.getName();
         ItemsPanel.itemsPanel["getFJ"]["miaoshu"].text = other.getIntroduction();
         this.setOtherColor(other.getColor());
      }
      
      private function getColor1() : *
      {
         var i:int = 0;
         var rdm:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 3; i++)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63132),3);
                  break;
               case 1:
                  this.bag.addOtherobjBag(OtherFactory.creatOther(63133));
                  this.showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 2:
                  this.bag.addOtherobjBag(OtherFactory.creatOther(63134));
                  this.showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 3:
                  for(i = 0; i < 3; i++)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 3; i++)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63132),3);
                  break;
               case 1:
                  this.bag2P.addOtherobjBag(OtherFactory.creatOther(63133));
                  this.showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 2:
                  this.bag2P.addOtherobjBag(OtherFactory.creatOther(63134));
                  this.showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 3:
                  for(i = 0; i < 3; i++)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
      }
      
      private function getColor2() : *
      {
         var i:int = 0;
         var rdm:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 6; i++)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  for(i = 0; i < 2; i++)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63133));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  for(i = 0; i < 2; i++)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63134));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  for(i = 0; i < 6; i++)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 6; i++)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  for(i = 0; i < 2; i++)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63133));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  for(i = 0; i < 2; i++)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63134));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  for(i = 0; i < 6; i++)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
      }
      
      private function getColor3() : *
      {
         var rdm:int = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  this.bag.addOtherobjBag(OtherFactory.creatOther(63133));
                  this.showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 1:
                  this.bag.addOtherobjBag(OtherFactory.creatOther(63134));
                  this.showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 2:
                  this.bag.addOtherobjBag(OtherFactory.creatOther(63136));
                  this.showPicAndNum(OtherFactory.creatOther(63136),1);
                  break;
               case 3:
                  this.bag.addOtherobjBag(OtherFactory.creatOther(63137));
                  this.showPicAndNum(OtherFactory.creatOther(63137),1);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  this.bag2P.addOtherobjBag(OtherFactory.creatOther(63133));
                  this.showPicAndNum(OtherFactory.creatOther(63133),1);
                  break;
               case 1:
                  this.bag2P.addOtherobjBag(OtherFactory.creatOther(63134));
                  this.showPicAndNum(OtherFactory.creatOther(63134),1);
                  break;
               case 2:
                  this.bag2P.addOtherobjBag(OtherFactory.creatOther(63136));
                  this.showPicAndNum(OtherFactory.creatOther(63136),1);
                  break;
               case 3:
                  this.bag2P.addOtherobjBag(OtherFactory.creatOther(63137));
                  this.showPicAndNum(OtherFactory.creatOther(63137),1);
            }
         }
      }
      
      private function getColor4() : *
      {
         var rdm:int = Math.random() * 3;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 15; ++i)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63136));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  for(i = 0; i < 15; ++i)
                  {
                     this.bag.addOtherobjBag(OtherFactory.creatOther(63137));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63137),15);
                  break;
               case 2:
                  this.bag.addOtherobjBag(OtherFactory.creatOther(63138));
                  this.showPicAndNum(OtherFactory.creatOther(63138),1);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 15; ++i)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63136));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  for(i = 0; i < 15; ++i)
                  {
                     this.bag2P.addOtherobjBag(OtherFactory.creatOther(63137));
                  }
                  this.showPicAndNum(OtherFactory.creatOther(63137),15);
                  break;
               case 2:
                  this.bag2P.addOtherobjBag(OtherFactory.creatOther(63138));
                  this.showPicAndNum(OtherFactory.creatOther(63138),1);
            }
         }
      }
      
      private function doFenJie() : *
      {
         if(whichDo == 1)
         {
            switch(this.bag.getEquipFromBag(oldNum).getColor())
            {
               case 1:
                  this.getColor1();
                  break;
               case 2:
                  this.getColor2();
                  break;
               case 3:
                  this.getColor3();
                  break;
               case 4:
                  this.getColor4();
                  break;
               case 5:
                  this.getColor4();
            }
         }
         else
         {
            switch(this.bag2P.getEquipFromBag(oldNum).getColor())
            {
               case 1:
                  this.getColor1();
                  break;
               case 2:
                  this.getColor2();
                  break;
               case 3:
                  this.getColor3();
                  break;
               case 4:
                  this.getColor4();
                  break;
               case 5:
                  this.getColor4();
            }
         }
      }
      
      private function closeFJ(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["getFJ"].visible = false;
      }
      
      private function closeTXT(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["txtTop"].visible = false;
      }
      
      private function closeTXT2(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["txtTop2"].visible = false;
      }
      
      public function setKey_1(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            this.su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(this.su,0);
         }
         else
         {
            this.su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(this.su,0);
         }
      }
      
      public function setKey_2(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            this.su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(this.su,1);
         }
         else
         {
            this.su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(this.su,1);
         }
      }
      
      public function setKey_3(e:MouseEvent) : *
      {
         if(whichDo == 1)
         {
            this.su = Main.player1.getBag().getSuppliesFromBag(oldNum);
            Main.player1.getSuppliesSlot().setToSuppliesSlot(this.su,2);
         }
         else
         {
            this.su = Main.player2.getBag().getSuppliesFromBag(oldNum);
            Main.player2.getSuppliesSlot().setToSuppliesSlot(this.su,2);
         }
      }
      
      public function yesXF(e:*) : *
      {
         Api_4399_All.Money_down(InitData.fuHua.getValue());
         moneyOK2 = true;
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
      }
      
      public function noXF(e:*) : *
      {
         ItemsPanel.itemsPanel["xfRMB"].visible = false;
      }
      
      public function xufei(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["xfRMB"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["xfRMB"]);
      }
      
      public function xianshi(e:MouseEvent) : *
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
      
      public function yincang(e:MouseEvent) : *
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

