package com.hotpoint.braveManIII.views.itemsPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.supplies.Supplies;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.repository.other.*;
   import com.hotpoint.braveManIII.repository.skill.*;
   import com.hotpoint.braveManIII.views.makePanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import src.*;
   
   public class MenuTooltip extends MovieClip
   {
      
      private var bag:Bag = new Bag();
      
      private var equipSlot2P:EquipSlot = new EquipSlot();
      
      private var selectType:uint;
      
      private var amount:int;
      
      private var equipSlot:EquipSlot = new EquipSlot();
      
      private var su:Supplies;
      
      private var bag2P:Bag = new Bag();
      
      private var whichDo:uint;
      
      private var skillSlot2P:EquipSkillSlot = new EquipSkillSlot();
      
      private var menuTooltip:MovieClip = new MenuShow();
      
      private var oldNum:uint;
      
      private var skillSlot:EquipSkillSlot = new EquipSkillSlot();
      
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
      
      private function closeTXT(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["txtTop"].visible = false;
      }
      
      private function showPicAndNum(other:Otherobj, num:int) : *
      {
         ItemsPanel.itemsPanel["getFJ"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["getFJ"]);
         ItemsPanel.itemsPanel["getFJ"]["showPic"].gotoAndStop(other.getFrame());
         ItemsPanel.itemsPanel["getFJ"]["showPic"]["t_txt"].text = num;
         ItemsPanel.itemsPanel["getFJ"]["mingzhi"].text = other.getName();
         ItemsPanel.itemsPanel["getFJ"]["miaoshu"].text = other.getIntroduction();
         setOtherColor(other.getColor());
      }
      
      public function yesFJ(e:*) : *
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
      
      public function leftInto(e:MouseEvent) : *
      {
         var gem:Gem = null;
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
                  gem = skillSlot.delSkillSlot(0);
                  skillSlot.addToSkillSlot(bag.getGemFromBag(oldNum),0);
                  bag.delGem(oldNum,1);
                  bag.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyLeftNum = 0;
            Main.player_1.energySlot.energyLeftMax = SkillFactory.getSkillById(skillSlot.getGemFromSkillSlot(0).getGemSkill()).getEp();
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
                  gem = skillSlot2P.delSkillSlot(0);
                  skillSlot2P.addToSkillSlot(bag2P.getGemFromBag(oldNum),0);
                  bag2P.delGem(oldNum,1);
                  bag2P.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyLeftNum = 0;
            Main.player_2.energySlot.energyLeftMax = SkillFactory.getSkillById(skillSlot2P.getGemFromSkillSlot(0).getGemSkill()).getEp();
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
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
      
      public function setKey_1(e:MouseEvent) : *
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
      
      private function getColor2() : *
      {
         var i:int = 0;
         var rdm:int = 0;
         i = 0;
         rdm = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 6; i++)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  for(i = 0; i < 2; i++)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63133));
                  }
                  showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  for(i = 0; i < 2; i++)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63134));
                  }
                  showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  for(i = 0; i < 6; i++)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 6; i++)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63132));
                  }
                  showPicAndNum(OtherFactory.creatOther(63132),6);
                  break;
               case 1:
                  for(i = 0; i < 2; i++)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63133));
                  }
                  showPicAndNum(OtherFactory.creatOther(63133),2);
                  break;
               case 2:
                  for(i = 0; i < 2; i++)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63134));
                  }
                  showPicAndNum(OtherFactory.creatOther(63134),2);
                  break;
               case 3:
                  for(i = 0; i < 6; i++)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),6);
            }
         }
      }
      
      public function setKey_3(e:MouseEvent) : *
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
      
      private function setDown() : void
      {
         if(whichDo == 1)
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
            if(selectType == 3)
            {
               if(amount == 1)
               {
                  amount = bag.getGemFromBag(oldNum).getTimes();
               }
               else
               {
                  --amount;
               }
            }
            else if(selectType == 4)
            {
               if(amount == 1)
               {
                  amount = bag.getOtherobjFromBag(oldNum).getTimes();
               }
               else
               {
                  --amount;
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
         }
         else
         {
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
            if(selectType == 3)
            {
               if(amount == 1)
               {
                  amount = bag2P.getGemFromBag(oldNum).getTimes();
               }
               else
               {
                  --amount;
               }
            }
            else if(selectType == 4)
            {
               if(amount == 1)
               {
                  amount = bag2P.getOtherobjFromBag(oldNum).getTimes();
               }
               else
               {
                  --amount;
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
         }
      }
      
      private function getColor3() : *
      {
         var rdm:int = 0;
         rdm = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
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
            switch(rdm)
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
         var rdm:int = 0;
         rdm = Math.random() * 3;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 15; ++i)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63136));
                  }
                  showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  for(i = 0; i < 15; ++i)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63137));
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
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 15; ++i)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63136));
                  }
                  showPicAndNum(OtherFactory.creatOther(63136),15);
                  break;
               case 1:
                  for(i = 0; i < 15; ++i)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63137));
                  }
                  showPicAndNum(OtherFactory.creatOther(63137),15);
                  break;
               case 2:
                  bag2P.addOtherobjBag(OtherFactory.creatOther(63138));
                  showPicAndNum(OtherFactory.creatOther(63138),1);
            }
         }
      }
      
      public function setKey_2(e:MouseEvent) : *
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
      
      private function tipClose(e:MouseEvent) : void
      {
         ItemsPanel.itemsTooltip.visible = false;
      }
      
      private function setOtherColor(color:int) : void
      {
         if(color == 1)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xffffff");
         }
         if(color == 2)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0x0066ff");
         }
         if(color == 3)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xFF33FF");
         }
         if(color == 4)
         {
            ColorX(ItemsPanel.itemsPanel["getFJ"]["mingzhi"],"0xFF9900");
         }
      }
      
      public function btnListen(e:BtnEvent) : *
      {
         var btn:MovieClip = null;
         btn = e.target as MovieClip;
         switch(btn.name)
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
      
      public function noFJ(e:*) : *
      {
         ItemsPanel.itemsPanel["isFenJie"].visible = false;
      }
      
      public function sell(e:MouseEvent) : *
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
                  amount = 1;
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
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
                  amount = 1;
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
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
                  amount = 1;
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
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
               if(bag.getOtherobjFromBag(oldNum).getTimes() > 1)
               {
                  ItemsPanel.itemsPanel["sellMenu"].visible = true;
                  ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["sellMenu"]);
                  amount = 1;
                  ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
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
      
      private function sellBatch() : void
      {
         if(whichDo == 1)
         {
            if(selectType == 3)
            {
               Main.player1.addGold(bag.getGemFromBag(oldNum).getPrice() * amount);
               bag.delGem(oldNum,amount);
               BagItemsShow.gemShow();
               BagItemsShow.informationShow();
            }
            else if(selectType == 4)
            {
               Main.player1.addGold(bag.getOtherobjFromBag(oldNum).getGold() * amount);
               bag.delOtherobj(oldNum,amount);
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
         }
         else if(selectType == 3)
         {
            Main.player2.addGold(bag2P.getGemFromBag(oldNum).getPrice() * amount);
            bag2P.delGem(oldNum,amount);
            BagItemsShow.gemShow2P();
            BagItemsShow.informationShow2P();
         }
         else if(selectType == 4)
         {
            Main.player2.addGold(bag2P.getOtherobjFromBag(oldNum).getGold() * amount);
            bag2P.delOtherobj(oldNum,amount);
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["sellMenu"].visible = false;
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
      
      public function addListener() : *
      {
         ItemsPanel.itemsPanel["txtTop"]["close"].addEventListener(MouseEvent.CLICK,closeTXT);
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
      }
      
      public function takeOff(e:MouseEvent) : *
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
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_1"].isClick = true;
            ItemsPanel.itemsType2P = 1;
            BagItemsShow.equipShow2P();
            BagItemsShow.slotShow2P();
            BagItemsShow.informationShow2P();
            ItemsPanel.changeModel(Main.player2);
         }
      }
      
      private function ColorX(t:*, col:String) : *
      {
         var myTextFormat:* = undefined;
         myTextFormat = new TextFormat();
         myTextFormat.color = col;
         t.setTextFormat(myTextFormat);
      }
      
      public function wear(e:MouseEvent) : *
      {
         var equip:Equip = null;
         var part:uint = 0;
         if(whichDo == 1)
         {
            if(selectType == 1)
            {
               part = uint(getPart(bag.getEquipFromBag(oldNum).getPosition()));
               if(bag.getEquipFromBag(oldNum).getDressLevel() <= Main.player1.getLevel() || bag.getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(equipSlot.getEquipFromSlot(part) == null)
                  {
                     equipSlot.addToSlot(bag.getEquipFromBag(oldNum),part);
                     bag.delEquip(oldNum);
                  }
                  else
                  {
                     equip = equipSlot.delSlot(part);
                     equipSlot.addToSlot(bag.getEquipFromBag(oldNum),part);
                     bag.delEquip(oldNum);
                     bag.addToEquipBag(equip,oldNum);
                  }
               }
               else
               {
                  ShortTip.open(25);
               }
            }
            Main.player_1.LoadPlayerLvData();
            BagItemsShow.informationShow();
            BagItemsShow.equipShow();
            BagItemsShow.slotShow();
            ItemsPanel.changeModel(Main.player1);
         }
         else
         {
            if(selectType == 1)
            {
               part = uint(getPart(bag2P.getEquipFromBag(oldNum).getPosition()));
               if(bag2P.getEquipFromBag(oldNum).getDressLevel() <= Main.player2.getLevel() || bag2P.getEquipFromBag(oldNum).getDressLevel() == 100)
               {
                  if(equipSlot2P.getEquipFromSlot(part) == null)
                  {
                     equipSlot2P.addToSlot(bag2P.getEquipFromBag(oldNum),part);
                     bag2P.delEquip(oldNum);
                  }
                  else
                  {
                     equip = equipSlot2P.delSlot(part);
                     equipSlot2P.addToSlot(bag2P.getEquipFromBag(oldNum),part);
                     bag2P.delEquip(oldNum);
                     bag2P.addToEquipBag(equip,oldNum);
                  }
               }
               else
               {
                  ShortTip.open(25);
               }
            }
            Main.player_2.LoadPlayerLvData();
            BagItemsShow.informationShow();
            BagItemsShow.equipShow2P();
            BagItemsShow.slotShow2P();
            ItemsPanel.changeModel(Main.player2);
         }
      }
      
      private function getColor1() : *
      {
         var i:int = 0;
         var rdm:int = 0;
         i = 0;
         rdm = Math.random() * 4;
         if(whichDo == 1)
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 3; i++)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63132));
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
                  for(i = 0; i < 3; i++)
                  {
                     bag.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
         else
         {
            switch(rdm)
            {
               case 0:
                  for(i = 0; i < 3; i++)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63132));
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
                  for(i = 0; i < 3; i++)
                  {
                     bag2P.addOtherobjBag(OtherFactory.creatOther(63135));
                  }
                  showPicAndNum(OtherFactory.creatOther(63135),3);
            }
         }
      }
      
      public function isFJ(e:MouseEvent) : *
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
      
      public function removeListener() : *
      {
         ItemsPanel.itemsPanel["txtTop"]["close"].addEventListener(MouseEvent.CLICK,closeTXT);
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
      }
      
      private function noAllSell() : *
      {
         bagNoBug();
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      public function allSell(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["isAllSell"].visible = true;
         ItemsPanel.itemsPanel.addChild(ItemsPanel.itemsPanel["isAllSell"]);
      }
      
      private function tipOpen(e:MouseEvent) : void
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
      
      private function setUp() : void
      {
         if(whichDo == 1)
         {
            if(selectType == 3)
            {
               if(amount == bag.getGemFromBag(oldNum).getTimes())
               {
                  amount = 1;
               }
               else
               {
                  ++amount;
               }
            }
            else if(selectType == 4)
            {
               if(amount == bag.getOtherobjFromBag(oldNum).getTimes())
               {
                  amount = 1;
               }
               else
               {
                  ++amount;
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
         }
         else
         {
            if(selectType == 3)
            {
               if(amount == bag2P.getGemFromBag(oldNum).getTimes())
               {
                  amount = 1;
               }
               else
               {
                  ++amount;
               }
            }
            else if(selectType == 4)
            {
               if(amount == bag2P.getOtherobjFromBag(oldNum).getTimes())
               {
                  amount = 1;
               }
               else
               {
                  ++amount;
               }
            }
            ItemsPanel.itemsPanel["sellMenu"]["amount"].text = amount;
         }
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
            default:
               return null;
         }
      }
      
      private function closeFJ(e:MouseEvent) : *
      {
         ItemsPanel.itemsPanel["getFJ"].visible = false;
      }
      
      private function yesAllSell() : *
      {
         var i:* = undefined;
         bagNoBug();
         if(whichDo == 1)
         {
            for(i = 0; i < 24; i++)
            {
               if(bag.getEquipFromBag(i) != null)
               {
                  if(bag.getEquipFromBag(i).getColor() <= 2)
                  {
                     Main.player1.addGold(bag.getEquipFromBag(i).getPrice());
                     bag.delEquip(i);
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
               if(bag2P.getEquipFromBag(i) != null)
               {
                  if(bag2P.getEquipFromBag(i).getColor() <= 2)
                  {
                     Main.player2.addGold(bag2P.getEquipFromBag(i).getPrice());
                     bag2P.delEquip(i);
                  }
               }
            }
            BagItemsShow.equipShow2P();
            BagItemsShow.informationShow2P();
         }
         ItemsPanel.itemsPanel["isAllSell"].visible = false;
      }
      
      public function useOther(e:MouseEvent) : *
      {
         var skn:uint = 0;
         var skstr:String = null;
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
                  NpcListData.otherUpdataTask();
                  bag.delOtherobj(oldNum,1);
                  ShortTip.open(34);
               }
               BagItemsShow.otherobjShow();
               BagItemsShow.informationShow();
            }
            else if(selectType == 3)
            {
               skn = uint(Main.player1.getBag().getGemFromBag(oldNum).getGemSkill());
               skstr = Main.player1.getBag().getGemFromBag(oldNum).getDescript();
               zengfuPanel.open(true,skstr,skn,oldNum);
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
               NpcListData.otherUpdataTask();
               bag2P.delOtherobj(oldNum,1);
               ShortTip.open(34);
            }
            BagItemsShow.otherobjShow2P();
            BagItemsShow.informationShow2P();
         }
         else if(selectType == 3)
         {
            skn = uint(Main.player2.getBag().getGemFromBag(oldNum).getGemSkill());
            skstr = Main.player2.getBag().getGemFromBag(oldNum).getDescript();
            zengfuPanel.open(false,skstr,skn,oldNum);
         }
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
      
      public function rightInto(e:MouseEvent) : *
      {
         var gem:Gem = null;
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
                  gem = skillSlot.delSkillSlot(1);
                  skillSlot.addToSkillSlot(bag.getGemFromBag(oldNum),1);
                  bag.delGem(oldNum,1);
                  bag.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_1.energySlot.energyRightMax = SkillFactory.getSkillById(skillSlot.getGemFromSkillSlot(1).getGemSkill()).getEp();
            Main.player_1.energySlot.energyRightNum = 0;
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
                  gem = skillSlot2P.delSkillSlot(1);
                  skillSlot2P.addToSkillSlot(bag2P.getGemFromBag(oldNum),1);
                  bag2P.delGem(oldNum,1);
                  bag2P.addToGemBag(gem,oldNum);
               }
            }
            else
            {
               ShortTip.open(25);
            }
            Main.player_2.energySlot.energyRightMax = SkillFactory.getSkillById(skillSlot2P.getGemFromSkillSlot(1).getGemSkill()).getEp();
            Main.player_2.energySlot.energyRightNum = 0;
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
         }
      }
      
      public function setFree(e:MouseEvent) : *
      {
         var gem:Gem = null;
         if(whichDo == 1)
         {
            if(bag.backGemBagNum() > 0)
            {
               bag.addGemBag(skillSlot.delSkillSlot(oldNum));
            }
            else
            {
               ShortTip.open(3);
            }
            if(oldNum == 0)
            {
               Main.player_1.energySlot.energyLeftMax = 0;
               Main.player_1.energySlot.energyLeftNum = 0;
            }
            else
            {
               Main.player_1.energySlot.energyRightMax = 0;
               Main.player_1.energySlot.energyRightNum = 0;
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
            }
            else
            {
               ShortTip.open(3);
            }
            if(oldNum == 0)
            {
               Main.player_2.energySlot.energyLeftMax = 0;
               Main.player_2.energySlot.energyLeftNum = 0;
            }
            else
            {
               Main.player_2.energySlot.energyRightMax = 0;
               Main.player_2.energySlot.energyRightNum = 0;
            }
            BagItemsShow.skillSlotShow2P();
            BagItemsShow.gemShow2P();
            ItemsPanel.allFalse();
            ItemsPanel.itemsPanel["bg1_3"].isClick = true;
            ItemsPanel.itemsType2P = 3;
         }
      }
      
      public function setItemsMenu(type:uint, num:uint, whichPlayerData:uint) : *
      {
         whichDo = whichPlayerData;
         selectType = type;
         oldNum = num;
         menuTooltip["menu_1"].visible = false;
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = false;
         menuTooltip["menu_7"].visible = false;
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
                  else if(bag.getGemFromBag(oldNum).getType() == 5)
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
               else if(bag2P.getGemFromBag(oldNum).getType() == 5)
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
               }
               else if(bag2P.getOtherobjFromBag(oldNum).getIsUse() == 1)
               {
                  menuTooltip["menu_7"].visible = true;
               }
               else if(bag2P.getOtherobjFromBag(oldNum).getIsUse() == 0)
               {
                  menuTooltip["menu_4"].visible = true;
               }
               break;
            case 5:
               menuTooltip["menu_4"].visible = true;
         }
      }
      
      public function setSlotMenu(num:uint, whichPlayerData:uint) : *
      {
         oldNum = num;
         whichDo = whichPlayerData;
         menuTooltip["menu_1"].visible = true;
         menuTooltip["menu_2"].visible = false;
         menuTooltip["menu_3"].visible = false;
         menuTooltip["menu_4"].visible = false;
         menuTooltip["menu_5"].visible = false;
         menuTooltip["menu_6"].visible = false;
         menuTooltip["menu_7"].visible = false;
      }
   }
}

