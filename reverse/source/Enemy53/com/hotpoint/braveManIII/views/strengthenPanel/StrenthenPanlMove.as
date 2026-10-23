package com.hotpoint.braveManIII.views.strengthenPanel
{
   import com.hotpoint.braveManIII.models.common.*;
   import com.hotpoint.braveManIII.models.container.Bag;
   import com.hotpoint.braveManIII.models.container.promptSlot;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.repository.gem.*;
   import com.hotpoint.braveManIII.repository.probability.*;
   import flash.display.MovieClip;
   import src.*;
   
   public class StrenthenPanlMove
   {
      
      public var pNum:VT;
      
      public function StrenthenPanlMove()
      {
         super();
         this.pNum = VT.createVT(100.153);
      }
      
      public static function creatMove() : StrenthenPanlMove
      {
         return new StrenthenPanlMove();
      }
      
      public function bagGemMoveToStr(weizhi:uint, _targetMc:MovieClip, type:Array, slot:*, bag:Bag) : void
      {
         var oldGem:Gem = null;
         var id:uint = uint(_targetMc.id);
         var gem:Gem = bag.getGemFromBag(id);
         for(var i:uint = 0; i < type.length; i++)
         {
            if(gem.getType() == type[i])
            {
               if(slot.getProp(weizhi) == -1)
               {
                  slot.addToSlot(bag.delGem(id,1),weizhi);
               }
               else
               {
                  oldGem = slot.getProp(weizhi);
                  if(gem.getType() == oldGem.getType())
                  {
                     if(gem.getColor() == oldGem.getColor())
                     {
                        slot.addToSlot(bag.delGem(id,1),weizhi);
                        if(bag.backGemBagNum() > 0)
                        {
                           bag.addGemBag(oldGem);
                        }
                     }
                     else
                     {
                        slot.addToSlot(bag.delGem(id,1),weizhi);
                        if(bag.backGemBagNum() > 0)
                        {
                           bag.addGemBag(oldGem);
                        }
                     }
                  }
                  else
                  {
                     slot.addToSlot(bag.delGem(id,1),weizhi);
                     if(bag.backGemBagNum() > 0)
                     {
                        bag.addGemBag(oldGem);
                     }
                  }
               }
            }
         }
      }
      
      public function gemBackToBag(gem:Gem, bag:Bag, slot:*, id:int, point:int = -1) : void
      {
         var bagGemArr:* = bag.getGemBag();
         if(bag.isGemBagEmpty(gem))
         {
            slot.delSlot(id);
            if(point == -1)
            {
               bag.addGemBag(gem);
            }
            else if(bagGemArr[point] == null)
            {
               bag.addToGemBag(gem,point);
            }
            else
            {
               bag.addGemBag(gem);
            }
         }
      }
      
      public function equipMoveTostrenthen(equipState:uint, id:int, slot:Object, bag:Bag) : void
      {
         var oldEquip:Equip = null;
         if(equipState == 0)
         {
            if(slot.getProp(0) == -1)
            {
               slot.addToSlot(bag.delEquip(id),0);
            }
            else if(slot.getPropEquip(0))
            {
               oldEquip = slot.getProp(0);
               slot.addToSlot(bag.delEquip(id),0);
               bag.addToEquipBag(oldEquip,id);
            }
         }
      }
      
      public function equipMoveToBag(equip1:Equip, slot:*, bag:Bag, id:int = 0, pcPointArr:int = -1) : void
      {
         if(pcPointArr != -1)
         {
            if(bag.getEquipFromBag(pcPointArr) == null)
            {
               slot.delSlot(id);
               bag.addToEquipBag(equip1,pcPointArr);
            }
            else
            {
               slot.delSlot(id);
               bag.addEquipBag(equip1);
            }
         }
         else
         {
            slot.delSlot(id);
            bag.addEquipBag(equip1);
         }
      }
      
      public function getEquipUpLevel(equip:Equip, gem:Gem) : Number
      {
         var allPro:Number = NaN;
         var pro:Number = Number(EquipProbabilityFactory.getPorbabillty(equip.getDropLevel(),equip.getReinforceLevel()));
         var num:Number = gem.getUseLevel() - equip.getReinforceLevel();
         if(gem.getUseLevel() < 10)
         {
            allPro = pro + num;
         }
         else
         {
            allPro = pro + num + 2;
         }
         return allPro;
      }
      
      public function getStrenthenGold(type:Equip) : Number
      {
         return EquipProbabilityFactory.getGold(type.getDropLevel(),type.getReinforceLevel());
      }
      
      public function getMosicGold(equip:Equip, gem:Gem) : Number
      {
         var baseGold:Number = NaN;
         var gold:Number = 0;
         baseGold = int(GoldFactory.getMosaicGold(equip.getDropLevel()));
         if(gem.getColor() == 1)
         {
            gold = int(baseGold * 1);
         }
         if(gem.getColor() == 2)
         {
            gold = int(baseGold * 1);
         }
         if(gem.getColor() == 3)
         {
            gold = int(baseGold * 1);
         }
         return gold;
      }
      
      public function getDeleteGold(equip:Equip) : Number
      {
         return int(GoldFactory.getDeleteGold(equip.getDropLevel()));
      }
      
      public function getEquipOuitGem(type:Gem) : Number
      {
         return type.getProbability();
      }
      
      public function getGemUpLevel(type:Gem) : Number
      {
         return type.getProbability();
      }
      
      public function getGemUpGold(type:Gem) : Number
      {
         return GemProbabilityFactory.getGold(type.getDropLevel(),type.getStrengthenLevel());
      }
      
      public function getLuckGemPosition(gem:Gem) : Number
      {
         if(gem.getType() == 2)
         {
            if(gem.getDropLevel() == 92315)
            {
               return 10;
            }
            if(gem.getDropLevel() == 92316)
            {
               return 50;
            }
            if(gem.getDropLevel() == 92317)
            {
               return 100;
            }
         }
         return 0;
      }
      
      public function setEquipPosition(gem:Gem, eq:Equip) : Number
      {
         return EquipPropertyFactory.getProperty(eq.getDropLevel(),eq.getPosition(),gem.getColor(),eq.getReinforceLevel());
      }
      
      private function setAddAttribType(position:Number) : Number
      {
         switch(position)
         {
            case 1:
               return 2;
            case 2:
               return 1;
            case 3:
               return 6;
            case 4:
               return 5;
            case 5:
               return 3;
            case 6:
               return 3;
            case 7:
               return 3;
            default:
               return 0;
         }
      }
      
      public function strengthenOver(type:Number, eq:Equip, gem:Gem, slot:*, pro:MovieClip, ptSlot:promptSlot, mc:MovieClip) : void
      {
         var my_num:Number = NaN;
         var ps:Number = NaN;
         var ranNum:Number = 0;
         mc.visible = false;
         ranNum = Math.random() * this.pNum.getValue();
         if(ranNum < type)
         {
            my_num = this.setEquipPosition(slot.getProp(1),slot.getProp(0));
            ps = eq.getPosition();
            ps = Number(this.setAddAttribType(ps));
            switch(ps)
            {
               case EquipBaseAttribTypeConst.ATTACK:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACK,my_num);
                  break;
               case EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.ATTACKIGNOREDEFENSE,my_num);
                  break;
               case EquipBaseAttribTypeConst.CRIT:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.CRIT,my_num);
                  break;
               case EquipBaseAttribTypeConst.DEFENSE:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DEFENSE,my_num);
                  break;
               case EquipBaseAttribTypeConst.DUCK:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.DUCK,my_num);
                  break;
               case EquipBaseAttribTypeConst.EXPERIENCE:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.EXPERIENCE,my_num);
                  break;
               case EquipBaseAttribTypeConst.HP:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HP,my_num);
                  break;
               case EquipBaseAttribTypeConst.HPREGEN:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.HPREGEN,my_num);
                  break;
               case EquipBaseAttribTypeConst.MOVESPEED:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MOVESPEED,my_num);
                  break;
               case EquipBaseAttribTypeConst.MP:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MP,my_num);
                  break;
               case EquipBaseAttribTypeConst.MPREGEN:
                  eq.changeReinforce(eq.getReinforceLevel() + 1,EquipBaseAttribTypeConst.MPREGEN,my_num);
            }
            pro.visible = true;
            this.dofunction(pro,1,eq.getFrame());
            ptSlot.addToSlot(eq,0);
            this.stOver();
         }
         else
         {
            pro.visible = true;
            this.dofunction(pro,2,eq.getFrame());
            ptSlot.addToSlot(eq,0);
         }
      }
      
      public function dofunction(pro:MovieClip, number:Number, frame:Number = -1) : void
      {
         pro.visible = true;
         pro.gotoAndStop(number);
         if(frame != -1)
         {
            pro.prompt_1.gotoAndStop(frame);
         }
      }
      
      public function strengthenSkillOver(type:int, slot:*, bag:Bag, pro:MovieClip, ptSlot:promptSlot, mc:MovieClip) : void
      {
         var gem:Gem = null;
         mc.visible = false;
         var ranNum:Number = 0;
         ranNum = Math.random() * this.pNum.getValue();
         gem = slot.getProp(0);
         if(ranNum < type)
         {
            gem = gem.setUpGem();
            pro.visible = true;
            this.dofunction(pro,1,gem.getFrame());
            ptSlot.addToSlot(gem,0);
            bag.addGemBag(gem);
            slot.clearSlot();
            this.stOver();
         }
         else
         {
            pro.visible = true;
            this.dofunction(pro,2,slot.getProp(0).getFrame());
            ptSlot.addToSlot(gem,0);
            bag.addGemBag(gem);
            slot.clearSlot();
         }
      }
      
      public function strengthenHcOver(type:int, slot:*, bag2:Bag, pro:MovieClip, ptSlot:promptSlot, mc:MovieClip) : void
      {
         var gem:Gem = null;
         var slotGem:Gem = null;
         var slotGem2:Gem = null;
         var slotGem3:Gem = null;
         var arr:Array = null;
         var arr2:Array = null;
         var arr3:Array = null;
         var i:uint = 0;
         var ranNum:Number = 0;
         ranNum = 100;
         mc.visible = false;
         if(bag2.backGemBagNum() > 0)
         {
            if(ranNum <= type)
            {
               slotGem = slot.getProp(0);
               slotGem2 = slot.getProp(1);
               if(slotGem.getUseLevel() >= slotGem2.getUseLevel())
               {
                  slotGem3 = slotGem;
               }
               else
               {
                  slotGem3 = slotGem2;
               }
               switch(slot.getType(0))
               {
                  case 0:
                     gem = GemFactory.createGemByCompose(1,slotGem.getStrengthenLevel() + 1,[]);
                     if(bag2.isGemBagEmpty(gem))
                     {
                        bag2.addGemBag(gem);
                     }
                     break;
                  case 1:
                     gem = GemFactory.createGemByCompose(2,slotGem.getStrengthenLevel(),[]);
                     if(bag2.isGemBagEmpty(gem))
                     {
                        bag2.addGemBag(gem);
                     }
                     break;
                  case 3:
                     arr = [];
                     arr2 = [];
                     arr3 = [];
                     arr2 = slot.getProp(0).getGemAttrib();
                     arr3 = slot.getProp(1).getGemAttrib();
                     for(i = 0; i < arr2.length; i++)
                     {
                        arr.push(arr2[i]);
                     }
                     for(i = 0; i < arr3.length; i++)
                     {
                        arr.push(arr3[i]);
                     }
                     gem = GemFactory.createGemByCompose(2,slotGem3.getStrengthenLevel(),arr);
                     if(bag2.isGemBagEmpty(gem))
                     {
                        bag2.addGemBag(gem);
                     }
                     arr = [];
               }
               pro.visible = true;
               this.dofunction(pro,5,gem.getFrame());
               ptSlot.addToSlot(gem,0);
               slot.clearSlot();
               this.stOver();
            }
         }
         else
         {
            bag2.addGemBag(slot.getProp(0));
            bag2.addGemBag(slot.getProp(1));
            slot.clearSlot();
         }
      }
      
      public function strengthenXqOver(type:int, slot:*, pro:MovieClip, ptSlot:promptSlot, mc:MovieClip) : void
      {
         mc.visible = false;
         var ranNum:Number = 0;
         ranNum = 100;
         if(ranNum <= type)
         {
            slot.getProp(0).setInGem(slot.getProp(1));
            pro.visible = true;
            this.dofunction(pro,7,slot.getProp(0).getFrame());
            ptSlot.addToSlot(slot.getProp(0),0);
            this.stOver();
         }
      }
      
      public function strengthenWkOver(type:int, slot:*, bag:Bag, pro:MovieClip, ptSlot:promptSlot, mc:MovieClip) : void
      {
         var ranNum:Number = NaN;
         var oldGem:Gem = null;
         mc.visible = false;
         ranNum = Math.random() * this.pNum.getValue();
         if(ranNum < type)
         {
            if(bag.backGemBagNum() > 0)
            {
               oldGem = slot.getProp(0).getOutGem();
               bag.addEquipBag(slot.getProp(0));
               bag.addGemBag(oldGem);
               pro.visible = true;
               this.dofunction(pro,3,slot.getProp(0).getFrame());
               ptSlot.addToSlot(slot.getProp(0),0);
               ptSlot.addToSlot(oldGem,1);
            }
            else
            {
               bag.addEquipBag(slot.getProp(0));
            }
            this.stOver();
         }
         else
         {
            oldGem = slot.getProp(0).getOutGem();
            bag.addEquipBag(slot.getProp(0));
            pro.visible = true;
            this.dofunction(pro,4,oldGem.getFrame());
            ptSlot.addToSlot(oldGem,0);
         }
         slot.clearSlot();
      }
      
      public function strengThenOverMoveEquip(state:Boolean, slot:*, bag1:Bag, bag2:Bag) : void
      {
         if(!state)
         {
            this.equipMoveToBag(slot.getProp(0),slot,bag1);
         }
         else
         {
            this.equipMoveToBag(slot.getProp(0),slot,bag2);
         }
         slot.clearSlot();
      }
      
      public function stOver() : void
      {
         Main.player_1.LoadPlayerLvData();
         if(Main.player_2 != null)
         {
            Main.player_2.LoadPlayerLvData();
         }
      }
   }
}

