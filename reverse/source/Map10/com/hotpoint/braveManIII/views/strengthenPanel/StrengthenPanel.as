package com.hotpoint.braveManIII.views.strengthenPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.Equip;
   import com.hotpoint.braveManIII.models.gem.Gem;
   import com.hotpoint.braveManIII.models.other.Otherobj;
   import com.hotpoint.braveManIII.models.player.PlayerData;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import src.*;
   
   public class StrengthenPanel extends MovieClip
   {
      
      public static var tooltip:ItemsTooltip;
      
      private static var targetMc:MovieClip;
      
      private static var oldX:int;
      
      private static var oldY:int;
      
      private static var _instance:StrengthenPanel;
      
      private static var childIndex:Number;
      
      private var okMove1:Boolean = true;
      
      private var stopTime:int = 80;
      
      private var luckGemProbaprobability2:Number = 0;
      
      private var strengLanPointArr:Array = [];
      
      private var ptSlot:promptSlot;
      
      private var playerState:Boolean = true;
      
      private var probability:Number = 0;
      
      private var deteleSlot:StrengthenDeleteSlot;
      
      private var downName:String;
      
      private var playerEquipArr1:Array = [];
      
      private var synthesisPointArr:Array = [];
      
      private var pcTowPointArr:Array = [];
      
      private var playerEquipArr2:Array = [];
      
      private var timerUi:Timer;
      
      private var slotBagArr:Array = [];
      
      private var mouseuup:Boolean;
      
      private var luckGemProbaprobability:Number = 0;
      
      private var other:Otherobj;
      
      private var taskArr1:Array = [];
      
      private var otherArr1:Array = [];
      
      private var taskArr2:Array = [];
      
      private var bag1:Bag;
      
      private var bag2:Bag;
      
      private var skillProbability:Number = 0;
      
      private var otherArr2:Array = [];
      
      private var myMenu:ContextMenu = new ContextMenu();
      
      private var pcOnePointArr:Array = [];
      
      private var timer:Timer;
      
      private var timerSys:Timer;
      
      private var times:int = 0;
      
      private var synthesisSlotArr:* = [];
      
      private var sysProbability:Number = 0;
      
      private var deteleSlotArr:* = [];
      
      private var mosaicPointArr:Array = [];
      
      private var synthesisState:* = 1;
      
      private var bagState:uint = 1;
      
      private var oldgold:Number;
      
      private var palyerSuppliesArr1:Array = [];
      
      private var player1:PlayerData;
      
      private var player2:PlayerData;
      
      private var palyerSuppliesArr2:Array = [];
      
      private var deletePointArr:Array = [];
      
      private var strengState:uint = 1;
      
      private var deleteProbability:Number = 0;
      
      private var mosaicSlotArr:* = [];
      
      private var mouseDownBo:Boolean;
      
      private var strMove:StrenthenPanlMove;
      
      private var timesSys:int = 0;
      
      private var mosaicSlot:StrengthenMosaicSlot;
      
      private var synthesisSlot:StrengthenSynthesisSlot;
      
      private var playerGemArr1:Array = [];
      
      private var randomNum:int = Math.random() * 100;
      
      private var okMove:Boolean = true;
      
      private var playerGemArr2:Array = [];
      
      private var equipProbability:Number = 0;
      
      private var skillSlot:SkillSlot;
      
      private var skillSlotArr:Array = [];
      
      private var typeNum:Number;
      
      private var slot:StrengthenSlot;
      
      public function StrengthenPanel(pvt:PrivateClass)
      {
         super();
      }
      
      public static function open(num:Number = 1) : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(StrengthenPanel._instance == null)
         {
            StrengthenPanel._instance = new StrengthenPanel(new PrivateClass());
            StrengthenPanel._instance.initMc();
         }
         StrengthenPanel._instance.x = 100;
         StrengthenPanel._instance.y = 50;
         Main._stage.addChild(StrengthenPanel._instance);
         StrengthenPanel._instance.visible = true;
         StrengthenPanel._instance.initAllBag(num);
         StrengthenPanel._instance.closeMast.visible = false;
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(StrengthenPanel._instance != null)
         {
            if(StrengthenPanel._instance.visible == true)
            {
               StrengthenPanel._instance.visible = false;
               StrengthenPanel._instance.closeMc();
               StrengthenPanel._instance.closeEvent();
               StrengthenPanel._instance.closeData();
            }
         }
      }
      
      public static function loseFocus(e:Event = null) : void
      {
         if(targetMc)
         {
            targetMc.stopDrag();
            targetMc.x = oldX;
            targetMc.y = oldY;
            _instance.addChildAt(targetMc,childIndex);
         }
      }
      
      private function bagMoveTosynthesisSlot(pcPoint:Array, pcPoint1:Array, pcPointwk:Array, _bag:Bag) : void
      {
         var targetX:int = 0;
         var targetY:int = 0;
         var bag:Bag = null;
         var myarr:Array = null;
         var pointX:Number = NaN;
         var pointY:Number = NaN;
         var i:uint = 0;
         targetX = mouseX;
         targetY = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         bag = _bag;
         myarr = [];
         if(synthesisState == 1)
         {
            for(i = 0; i < 3; i++)
            {
               if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(bagState)
               {
                  case 3:
                     myarr = [0,1,3];
                     if(bag.backGemBagNum() > 0)
                     {
                        if(bag.getGemFromBag(targetMc.id).getType() == 0 || bag.getGemFromBag(targetMc.id).getType() == 1 || bag.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(bag.getGemFromBag(targetMc.id).getColor() == 1)
                           {
                              if(pcPoint[i][0] == 0)
                              {
                                 sysOne(0,1,myarr,bag);
                                 if(synthesisSlot.getProp(0) != -1)
                                 {
                                    sysGl(100,0);
                                 }
                              }
                              if(pcPoint[i][0] == 1)
                              {
                                 myarr = [0,1,3];
                                 sysOne(1,0,myarr,bag);
                              }
                           }
                           else
                           {
                              trace("放入一级宝石");
                              ShortTip.open(9);
                           }
                        }
                        else
                        {
                           ShortTip.open(4);
                           trace("放入宝石不符合");
                        }
                     }
                     else
                     {
                        trace("请清空背包");
                        ShortTip.open(3);
                     }
                     break;
                  case 4:
                     if(pcPoint[i][0] == 2)
                     {
                        synthesisSlot.addToSlot(bag.delOtherobj(targetMc.id),2);
                     }
               }
            }
         }
         if(synthesisState == 2)
         {
            for(i = 0; i < 2; i++)
            {
               if(!(targetX >= pcPoint1[i][1] && targetX <= pcPoint1[i][1] + pc2_0.width && (targetY >= pcPoint1[i][2] && targetY <= pcPoint1[i][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(bagState)
               {
                  case 1:
                     if(mosaicSlot.getProp(1) == -1)
                     {
                        if(bag.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           strMove.equipMoveTostrenthen(pcPoint[i][0],targetMc.id,mosaicSlot,bag);
                           equipUpdate();
                           mosaicSlotUpdate();
                        }
                        else
                        {
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              trace("无法继续镶嵌");
                              ShortTip.open(8);
                           }
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == -1)
                           {
                              trace("没有孔");
                              ShortTip.open(7);
                           }
                        }
                     }
                     else if(bag.getEquipFromBag(targetMc.id).getDressLevel() >= mosaicSlot.getProp(1).getUseLevel())
                     {
                        if(bag.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           strMove.equipMoveTostrenthen(pcPoint[i][0],targetMc.id,mosaicSlot,bag);
                           equipUpdate();
                           mosaicSlotUpdate();
                        }
                        else
                        {
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              ShortTip.open(8);
                              trace("无法继续镶嵌");
                           }
                           if(bag.getEquipFromBag(targetMc.id).getGrid() == -1)
                           {
                              ShortTip.open(7);
                              trace("没有孔");
                           }
                        }
                     }
                     else
                     {
                        trace("等级不符合");
                        ShortTip.open(22);
                     }
                     if(mosaicSlot.getProp(0) != -1)
                     {
                        sysGl(100,0);
                     }
                     break;
                  case 3:
                     if(pcPoint1[i][0] == 1)
                     {
                        myarr = [3];
                        if(bag.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(mosaicSlot.getProp(0) == -1)
                           {
                              strMove.bagGemMoveToStr(1,targetMc,myarr,mosaicSlot,bag);
                              gemUpdate();
                              mosaicSlotUpdate();
                           }
                           else if(mosaicSlot.getProp(0).getDressLevel() >= bag.getGemFromBag(targetMc.id).getUseLevel())
                           {
                              strMove.bagGemMoveToStr(1,targetMc,myarr,mosaicSlot,bag);
                              gemUpdate();
                              mosaicSlotUpdate();
                           }
                           else
                           {
                              ShortTip.open(22);
                              trace("等级不符合");
                           }
                        }
                        else
                        {
                           ShortTip.open(4);
                        }
                     }
               }
            }
         }
         if(synthesisState == 3)
         {
            for(i = 0; i < 2; i++)
            {
               if(!(targetX >= pcPointwk[i][1] && targetX <= pcPointwk[i][1] + pc2_0.width && (targetY >= pcPointwk[i][2] && targetY <= pcPointwk[i][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(bagState)
               {
                  case 1:
                     if(bag.backGemBagNum() > 0)
                     {
                        if(bag.getEquipFromBag(targetMc.id).getGrid() == 0)
                        {
                           strMove.equipMoveTostrenthen(pcPointwk[i][0],targetMc.id,deteleSlot,bag);
                           equipUpdate();
                           deleteSlotUpdate();
                        }
                        else
                        {
                           trace("装备已挖空或无孔");
                           ShortTip.open(2);
                        }
                        if(deteleSlot.getProp(0) != -1)
                        {
                           if(deteleSlot.getProp(0).getGemSlot() != null)
                           {
                              deleteProbability = strMove.getEquipOuitGem(deteleSlot.getProp(0).getGemSlot());
                              sysGl(deleteProbability,luckGemProbaprobability2);
                           }
                        }
                     }
                     else
                     {
                        trace("请清空背包");
                        ShortTip.open(3);
                     }
                     break;
                  case 3:
                     if(pcPointwk[i][0] == 1)
                     {
                        myarr = [2];
                        if(bag.getGemFromBag(targetMc.id).getType() == 2)
                        {
                           strMove.bagGemMoveToStr(1,targetMc,myarr,deteleSlot,bag);
                           gemUpdate();
                           deleteSlotUpdate();
                           if(deteleSlot.getProp(1) != -1)
                           {
                              luckGemProbaprobability2 = strMove.getLuckGemPosition(deteleSlot.getProp(1));
                              sysGl(deleteProbability,luckGemProbaprobability2);
                           }
                        }
                        else
                        {
                           trace("类型不同");
                           ShortTip.open(4);
                        }
                     }
               }
            }
         }
      }
      
      public function skillSoltUpdate() : void
      {
         var i:uint = 0;
         skillSlotArr = skillSlot.slotArr();
         for(i = 0; i < 3; i++)
         {
            if(skillSlotArr[i] != -1)
            {
               this["qh_" + i].visible = true;
               this["qh_" + i].howNum.text = "";
               this["qh_" + i].gotoAndStop(skillSlotArr[i].getFrame());
               this["qhc_" + i].gotoAndStop(2);
            }
            else
            {
               this["qh_" + i].visible = false;
               this["qhc_" + i].gotoAndStop(1);
            }
         }
      }
      
      private function daojuMessageOut(e:DaoJuEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function overHandle(e:BtnEvent) : void
      {
         var nameStr:String = null;
         nameStr = e.target.name;
         tooltip.visible = true;
         if(nameStr == "prompt_1")
         {
            if(ptSlot.getPropEquip(0))
            {
               tooltip.equipTooltip(ptSlot.getProp(0),3);
            }
            if(ptSlot.getPropGem(0))
            {
               tooltip.gemTooltip(ptSlot.getProp(0),3);
            }
         }
         if(nameStr == "prompt_2")
         {
            tooltip.gemTooltip(ptSlot.getProp(1),3);
         }
         tooltip.x = mouseX + 10;
         tooltip.y = mouseY;
         pointY(tooltip);
      }
      
      private function strengthenEquipCondition() : void
      {
         if(slot.getProp(0) != -1 && slot.getProp(1) != -1)
         {
            typeNum = 1;
            closeMast.visible = true;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(2);
               goldSf(strMove.getStrenthenGold(slot.getProp(0)));
               oldgold = strMove.getStrenthenGold(slot.getProp(0));
            }
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      private function noInitPone() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            this["d1_" + i].visible = false;
            p1Gold.text = "";
         }
      }
      
      private function deleteToBagSty() : void
      {
         if(!playerState)
         {
            if(deteleSlot.getProp(0) != -1)
            {
               strMove.equipMoveToBag(deteleSlot.getProp(0),deteleSlot,bag1);
            }
            if(deteleSlot.getProp(1) != -1)
            {
               strMove.gemBackToBag(deteleSlot.getProp(1),bag1,deteleSlot,1);
            }
         }
         else
         {
            if(deteleSlot.getProp(0) != -1)
            {
               strMove.equipMoveToBag(deteleSlot.getProp(0),deteleSlot,bag2);
               deleteSlotUpdate();
               equipUpdate();
            }
            if(deteleSlot.getProp(1) != -1)
            {
               strMove.gemBackToBag(deteleSlot.getProp(1),bag2,deteleSlot,1);
            }
         }
      }
      
      private function sysOne(pointNum:Number, prop:Number, typeArr:Array, bag:Bag) : void
      {
         var gem1:Gem = null;
         var gem2:Gem = null;
         if(synthesisSlot.getProp(prop) == -1)
         {
            strMove.bagGemMoveToStr(pointNum,targetMc,typeArr,synthesisSlot,bag);
            gemUpdate();
            sysSlotUpdate();
         }
         else
         {
            gem1 = synthesisSlot.getProp(prop);
            gem2 = bag.getGemFromBag(targetMc.id);
            if(gem1.getType() == gem2.getType())
            {
               if(gem1.getType() == 1)
               {
                  if(gem1.getUseLevel() == gem2.getUseLevel())
                  {
                     strMove.bagGemMoveToStr(pointNum,targetMc,typeArr,synthesisSlot,bag);
                     gemUpdate();
                     sysSlotUpdate();
                  }
                  else
                  {
                     ShortTip.open(23);
                     trace("宝石使用等级不同");
                  }
               }
               else
               {
                  strMove.bagGemMoveToStr(pointNum,targetMc,typeArr,synthesisSlot,bag);
                  gemUpdate();
                  sysSlotUpdate();
               }
            }
            else
            {
               trace("类型不同");
               ShortTip.open(4);
            }
         }
      }
      
      private function closeHandle(e:BtnEvent) : void
      {
         var id:uint = 0;
         var mc_name:String = null;
         id = uint(e.target.id);
         mc_name = e.target.parent.name;
         if(mc_name == "gold_mc")
         {
            if(id == 1)
            {
               gold_mc.visible = false;
               if(!playerState)
               {
                  if(player1.payGold(oldgold))
                  {
                     p1Gold.text = player1.getGold().toString();
                     if(typeNum == 1)
                     {
                        okMove = false;
                        timer.start();
                        s1_mc.gotoAndPlay(2);
                        s2_mc.gotoAndPlay(2);
                     }
                     if(typeNum == 2)
                     {
                        timesSys = 0;
                        okMove1 = false;
                        timerSys.start();
                        s3_mc.gotoAndPlay(2);
                        s4_mc.gotoAndPlay(2);
                     }
                     removeClick();
                  }
                  else
                  {
                     trace("金币不足");
                     closeMast.visible = false;
                     ShortTip.open(16);
                     closeData();
                  }
               }
               else if(player2.payGold(oldgold))
               {
                  p2Gold.text = player2.getGold().toString();
                  if(typeNum == 1)
                  {
                     okMove = false;
                     timer.start();
                     s1_mc.gotoAndPlay(2);
                     s2_mc.gotoAndPlay(2);
                  }
                  if(typeNum == 2)
                  {
                     timesSys = 0;
                     okMove1 = false;
                     timerSys.start();
                     s3_mc.gotoAndPlay(2);
                     s4_mc.gotoAndPlay(2);
                  }
                  removeClick();
               }
               else
               {
                  trace("金币不足");
                  closeMast.visible = false;
                  ShortTip.open(16);
                  closeData();
               }
            }
            if(id == 2)
            {
               trace(22222222);
               closeMast.visible = false;
               gold_mc.visible = false;
               closeData();
            }
         }
         else
         {
            trace(33333333);
            if(id == 3)
            {
               close();
            }
            prompt.visible = false;
         }
      }
      
      private function onTimerSys(e:TimerEvent) : void
      {
         ++timesSys;
         if(timesSys == stopTime)
         {
            timesSys == 0;
            timerSys.stop();
            s3_mc.gotoAndStop(1);
            s4_mc.gotoAndStop(1);
            okMove1 = true;
            addClick();
            if(synthesisState == 1)
            {
               bagState = 3;
               btnIsClick(3);
               if(!playerState)
               {
                  strMove.strengthenHcOver(sysProbability,synthesisSlot,bag1,prompt,ptSlot,closeMast);
               }
               else
               {
                  strMove.strengthenHcOver(sysProbability,synthesisSlot,bag2,prompt,ptSlot,closeMast);
               }
               sysSlotUpdate();
               gemUpdate();
               closeSysGl();
            }
            if(synthesisState == 2)
            {
               bagState = 1;
               btnIsClick(1);
               strMove.strengthenXqOver(sysProbability,mosaicSlot,prompt,ptSlot,closeMast);
               strMove.strengThenOverMoveEquip(playerState,mosaicSlot,bag1,bag2);
               mosaicSlotUpdate();
               equipUpdate();
               closeSysGl();
            }
            if(synthesisState == 3)
            {
               bagState = 1;
               btnIsClick(1);
               if(!playerState)
               {
                  strMove.strengthenWkOver(sysProbability,deteleSlot,bag1,prompt,ptSlot,closeMast);
               }
               else
               {
                  strMove.strengthenWkOver(sysProbability,deteleSlot,bag2,prompt,ptSlot,closeMast);
               }
               deleteSlotUpdate();
               equipUpdate();
               closeSysGl();
               Main.Save();
            }
         }
      }
      
      private function strengthenLanMoveToBag(pcPoint:Array, bag:Bag) : void
      {
         var targetX:int = 0;
         var targetY:int = 0;
         var i:uint = 0;
         var equip1:Equip = null;
         var gem:Gem = null;
         var gem2:Gem = null;
         targetX = mouseX;
         targetY = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         for(i = 0; i < 24; i++)
         {
            if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
            {
               continue;
            }
            switch(bagState)
            {
               case 1:
                  if(slot.getPropEquip(targetMc.id))
                  {
                     equip1 = slot.getProp(targetMc.id);
                     strMove.equipMoveToBag(equip1,slot,bag,targetMc.id,pcPoint[i][0]);
                     equipUpdate();
                     soltUpdate();
                     equipProbability = 0;
                     strenthenGl(equipProbability,luckGemProbaprobability);
                  }
                  break;
               case 3:
                  if(strengState == 1)
                  {
                     if(slot.getPropGem(targetMc.id))
                     {
                        gem = slot.getProp(targetMc.id);
                        strMove.gemBackToBag(gem,bag,slot,targetMc.id,pcPoint[i][0]);
                        gemUpdate();
                        soltUpdate();
                        if(slot.getProp(1) == -1)
                        {
                           equipProbability = 0;
                           strenthenGl(equipProbability,luckGemProbaprobability);
                        }
                        if(slot.getProp(2) == -1)
                        {
                           luckGemProbaprobability = 0;
                           strenthenGl(equipProbability,luckGemProbaprobability);
                        }
                     }
                  }
                  if(strengState == 2)
                  {
                     gem2 = skillSlot.getProp(targetMc.id);
                     if(skillSlot.getPropGem(targetMc.id))
                     {
                        strMove.gemBackToBag(gem2,bag,skillSlot,targetMc.id,pcPoint[i][0]);
                        gemUpdate();
                        skillSoltUpdate();
                        if(skillSlot.getProp(0) == -1)
                        {
                           skillProbability = 0;
                           strenthenGl(skillProbability,luckGemProbaprobability);
                        }
                        if(skillSlot.getProp(2) == -1)
                        {
                           luckGemProbaprobability = 0;
                           strenthenGl(skillProbability,luckGemProbaprobability);
                        }
                     }
                  }
                  break;
               case 4:
                  break;
               case 5:
            }
         }
      }
      
      private function strengthenGemCondition() : void
      {
         if(skillSlot.getProp(0) != -1 && skillSlot.getProp(1) != -1)
         {
            closeMast.visible = true;
            typeNum = 1;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(2);
               goldSf(strMove.getGemUpGold(skillSlot.getProp(0)));
               oldgold = strMove.getGemUpGold(skillSlot.getProp(0));
            }
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      private function beginStrengthen() : void
      {
         switch(strengState)
         {
            case 1:
               strengthenEquipCondition();
               break;
            case 2:
               strengthenGemCondition();
         }
      }
      
      public function mosaicSlotUpdate() : void
      {
         var i:uint = 0;
         mosaicSlotArr = mosaicSlot.slotArr();
         for(i = 0; i < 2; i++)
         {
            if(mosaicSlotArr[i] != -1)
            {
               this["hc_" + i].visible = true;
               this["hc_" + i].howNum.text = "";
               this["hc_" + i].gotoAndStop(mosaicSlotArr[i].getFrame());
               this["hcc_" + i].gotoAndStop(2);
            }
            else
            {
               this["hc_" + i].visible = false;
               this["hcc_" + i].gotoAndStop(1);
            }
         }
      }
      
      public function deleteSlotUpdate() : void
      {
         var i:uint = 0;
         deteleSlotArr = deteleSlot.slotArr();
         for(i = 0; i < 2; i++)
         {
            if(deteleSlotArr[i] != -1)
            {
               this["hc_" + i].visible = true;
               this["hc_" + i].howNum.text = "";
               this["hc_" + i].gotoAndStop(deteleSlotArr[i].getFrame());
               this["hcc_" + i].gotoAndStop(2);
            }
            else
            {
               this["hc_" + i].visible = false;
               this["hcc_" + i].gotoAndStop(1);
            }
         }
      }
      
      private function bagMoveToStrengthenLan(pcPoint:Array, _bag:Bag) : void
      {
         var targetX:int = 0;
         var targetY:int = 0;
         var bag:Bag = null;
         var myarr:Array = null;
         var i:uint = 0;
         targetX = mouseX;
         targetY = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         bag = _bag as Bag;
         myarr = [];
         for(i = 0; i < 3; i++)
         {
            if(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height))
            {
               if(strengState == 1)
               {
                  switch(bagState)
                  {
                     case 1:
                        if(pcPoint[i][0] == 0)
                        {
                           if(bag.getEquipFromBag(targetMc.id).getDressLevel() < 50)
                           {
                              if(bag.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 strengthenEquipOne(0,bag);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(bag.getEquipFromBag(targetMc.id).getColor() == 1 || bag.getEquipFromBag(targetMc.id).getColor() == 2)
                           {
                              if(bag.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 strengthenEquipOne(0,bag);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(bag.getEquipFromBag(targetMc.id).getReinforceLevel() < 10)
                           {
                              strengthenEquipOne(0,bag);
                           }
                           else
                           {
                              trace("强化等级满");
                              ShortTip.open(5);
                           }
                        }
                        break;
                     case 3:
                        if(pcPoint[i][0] == 1)
                        {
                           myarr = [1];
                           if(bag.backGemBagNum() > 0)
                           {
                              if(bag.getGemFromBag(targetMc.id).getType() == 1)
                              {
                                 strengthenEquipTow(1,myarr,bag);
                              }
                              else
                              {
                                 ShortTip.open(4);
                              }
                           }
                           else
                           {
                              ShortTip.open(3);
                           }
                        }
                        if(pcPoint[i][0] == 2)
                        {
                           myarr = [2];
                           if(bag.backGemBagNum() > 0)
                           {
                              if(bag.getGemFromBag(targetMc.id).getType() == 2)
                              {
                                 strengthenEquipTow(2,myarr,bag);
                                 if(slot.getType(2) == 2)
                                 {
                                    luckGemProbaprobability = strMove.getLuckGemPosition(slot.getProp(2));
                                    strenthenGl(equipProbability,luckGemProbaprobability);
                                 }
                              }
                              else
                              {
                                 ShortTip.open(4);
                              }
                           }
                           else
                           {
                              ShortTip.open(3);
                           }
                        }
                  }
               }
               if(strengState == 2)
               {
                  if(bagState == 3)
                  {
                     if(pcPoint[i][0] == 0)
                     {
                        myarr = [4];
                        if(bag.backGemBagNum() > 0)
                        {
                           if(bag.getGemFromBag(targetMc.id).getType() == 4)
                           {
                              if(bag.getGemFromBag(targetMc.id).getStrengthenLevel() < 4)
                              {
                                 strMove.bagGemMoveToStr(0,targetMc,myarr,skillSlot,bag);
                                 skillSoltUpdate();
                                 gemUpdate();
                                 if(skillSlot.getType(0) == 4)
                                 {
                                    skillProbability = strMove.getGemUpLevel(skillSlot.getProp(0));
                                    strenthenGl(skillProbability,luckGemProbaprobability);
                                 }
                              }
                              else
                              {
                                 trace("强化等级已满");
                                 ShortTip.open(5);
                              }
                           }
                           else
                           {
                              ShortTip.open(4);
                           }
                        }
                        else
                        {
                           ShortTip.open(3);
                        }
                     }
                     if(pcPoint[i][0] == 1)
                     {
                        myarr = [0];
                        if(bag.backGemBagNum() > 0)
                        {
                           if(bag.getGemFromBag(targetMc.id).getType() == 0)
                           {
                              strMove.bagGemMoveToStr(1,targetMc,myarr,skillSlot,bag);
                              skillSoltUpdate();
                              gemUpdate();
                           }
                           else
                           {
                              ShortTip.open(4);
                           }
                        }
                        else
                        {
                           ShortTip.open(3);
                        }
                     }
                     if(pcPoint[i][0] == 2)
                     {
                        myarr = [2];
                        if(bag.backGemBagNum() > 0)
                        {
                           if(bag.getGemFromBag(targetMc.id).getType() == 2)
                           {
                              strMove.bagGemMoveToStr(2,targetMc,myarr,skillSlot,bag);
                              skillSoltUpdate();
                              gemUpdate();
                              if(skillSlot.getType(2) == 2)
                              {
                                 luckGemProbaprobability = strMove.getLuckGemPosition(skillSlot.getProp(2));
                                 strenthenGl(skillProbability,luckGemProbaprobability);
                              }
                           }
                           else
                           {
                              ShortTip.open(4);
                           }
                        }
                        else
                        {
                           ShortTip.open(3);
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function sysGl(p1:Number, p2:Number) : *
      {
         var num:Number = NaN;
         num = p1 + p2;
         sysProbability = num;
         if(sysProbability >= 100)
         {
            sysProbability = 100;
         }
         if(sysProbability <= 0)
         {
            sysProbability = 0;
         }
         if(sysProbability <= 0)
         {
            syspText.text = "";
         }
         else
         {
            syspText.text = sysProbability.toString() + "%";
         }
      }
      
      private function btnIsClick(num:Number) : void
      {
         var i:uint = 0;
         if(!playerState)
         {
            for(i = 1; i <= 4; i++)
            {
               this["p1_" + i].isClick = false;
            }
            this["p1_" + num].isClick = true;
         }
         else
         {
            for(i = 1; i <= 4; i++)
            {
               this["p2_" + i].isClick = false;
            }
            this["p2_" + num].isClick = true;
         }
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         ++times;
         if(times == stopTime)
         {
            times = 0;
            timer.stop();
            okMove = true;
            s1_mc.gotoAndStop(1);
            s2_mc.gotoAndStop(1);
            addClick();
            if(strengState == 1)
            {
               equipProbability = 0;
               bagState = 1;
               btnIsClick(1);
               strMove.strengthenOver(probability,slot.getProp(0),slot.getProp(1),slot,prompt,ptSlot,closeMast);
               strMove.strengThenOverMoveEquip(playerState,slot,bag1,bag2);
               soltUpdate();
               equipUpdate();
               closeStrengGl();
            }
            if(strengState == 2)
            {
               skillProbability = 0;
               bagState = 3;
               btnIsClick(3);
               if(playerState)
               {
                  strMove.strengthenSkillOver(probability,skillSlot,bag2,prompt,ptSlot,closeMast);
               }
               else
               {
                  strMove.strengthenSkillOver(probability,skillSlot,bag1,prompt,ptSlot,closeMast);
               }
               skillSoltUpdate();
               gemUpdate();
               closeStrengGl();
            }
            Main.Save();
         }
      }
      
      private function bagMoveInit(pcPoint:Array, bag:Bag) : void
      {
         var targetX:int = 0;
         var targetY:int = 0;
         var i:uint = 0;
         targetX = targetMc.x + targetMc.width / 2;
         targetY = targetMc.y + targetMc.height / 2;
         targetMc.x = oldX;
         targetMc.y = oldY;
         for(i = 0; i < 24; i++)
         {
            if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
            {
               continue;
            }
            switch(bagState)
            {
               case 1:
                  bag.equipBagMove(targetMc.id,pcPoint[i][0]);
                  equipUpdate();
                  break;
               case 2:
                  bag.suppliesBagMove(targetMc.id,pcPoint[i][0]);
                  supUpdate();
                  break;
               case 3:
                  bag.gemBagMove(targetMc.id,pcPoint[i][0]);
                  gemUpdate();
                  break;
               case 4:
                  bag.otherobjBagMove(targetMc.id,pcPoint[i][0]);
                  otherUpdate();
                  break;
               case 5:
                  bag.questBagMove(targetMc.id,pcPoint[i][0]);
                  taskUpdate();
            }
         }
      }
      
      private function daojuMessageDown(e:DaoJuEvent) : void
      {
         var mc:MovieClip = null;
         var nameStr:String = null;
         var id:Number = NaN;
         mouseuup = true;
         mc = e.target as MovieClip;
         nameStr = mc.name;
         downName = nameStr.substr(1,1);
         id = Number(nameStr.substr(3,2));
         mouseDownBo = true;
         mc.startDrag();
         tooltip.visible = false;
         targetMc = mc;
         targetMc.id = id;
         oldX = mc.x;
         oldY = mc.y;
         mc.x = mouseX - mc.width / 2;
         mc.y = mouseY - mc.height / 2;
         childIndex = this.getChildIndex(mc);
         this.addChildAt(mc,numChildren - 2);
      }
      
      public function taskUpdate() : void
      {
         var i:uint = 0;
         if(!playerState)
         {
            taskArr1 = bag1.getQuestBag();
            for(i = 0; i < 24; i++)
            {
               if(taskArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(taskArr1[i].getFrame());
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            taskArr2 = bag2.getQuestBag();
            for(i = 0; i < 24; i++)
            {
               if(taskArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(taskArr2[i].getFrame());
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function supUpdate() : void
      {
         var i:uint = 0;
         if(!playerState)
         {
            palyerSuppliesArr1 = bag1.getSuppliesBag();
            for(i = 0; i < 24; i++)
            {
               if(palyerSuppliesArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(palyerSuppliesArr1[i].getFrame());
                  this["d1_" + i].howNum.text = palyerSuppliesArr1[i].getTimes();
                  if(palyerSuppliesArr1[i].getTimes() <= 1)
                  {
                     this["d1_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            palyerSuppliesArr2 = bag2.getSuppliesBag();
            for(i = 0; i < 24; i++)
            {
               if(palyerSuppliesArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(palyerSuppliesArr2[i].getFrame());
                  this["d2_" + i].howNum.text = palyerSuppliesArr2[i].getTimes();
                  if(palyerSuppliesArr2[i].getTimes() <= 1)
                  {
                     this["d2_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      private function strengthenLanCao() : void
      {
         var i:uint = 0;
         for(i = 0; i < 3; i++)
         {
            strengLanPointArr[i] = [i,this["qhc_" + i].x,this["qhc_" + i].y];
            synthesisPointArr[i] = [i,this["hcc_" + i].x,this["hcc_" + i].y];
         }
      }
      
      private function strToBagSty() : void
      {
         if(!playerState)
         {
            if(slot.getProp(0) != -1)
            {
               strMove.equipMoveToBag(slot.getProp(0),slot,bag1);
               slot.addToSlot(-1,0);
            }
            if(slot.getProp(1) != -1)
            {
               strMove.gemBackToBag(slot.getProp(1),bag1,slot,1);
            }
            if(slot.getProp(2) != -1)
            {
               strMove.gemBackToBag(slot.getProp(2),bag1,slot,2);
            }
         }
         else
         {
            if(slot.getProp(0) != -1)
            {
               strMove.equipMoveToBag(slot.getProp(0),slot,bag2);
               slot.addToSlot(-1,0);
            }
            if(slot.getProp(1) != -1)
            {
               strMove.gemBackToBag(slot.getProp(1),bag2,slot,1);
            }
            if(slot.getProp(2) != -1)
            {
               strMove.gemBackToBag(slot.getProp(2),bag2,slot,2);
            }
         }
      }
      
      private function initMc() : void
      {
         keyMc = new KeyMc();
         this.addChild(keyMc);
         keyMc.x = 285.5;
         keyMc.y = 39.95;
         keyMc.visible = false;
         this.addChildAt(keyMc,numChildren - 3);
         help = new Help_mc();
         help.x = 126;
         help.y = 69;
         this.addChild(help);
         help.visible = false;
         this.addChildAt(help,numChildren - 1);
         prompt = new PromptMc();
         this.addChild(prompt);
         prompt.visible = false;
         gold_mc.visible = false;
         this.addChildAt(gold_mc,numChildren - 1);
         tooltip = new ItemsTooltip();
         this.addChild(tooltip);
         tooltip.visible = false;
         slot = StrengthenSlot.creatStrengThenSlot();
         skillSlot = SkillSlot.creatStriengSkill();
         synthesisSlot = StrengthenSynthesisSlot.creatSynthesisSlot();
         mosaicSlot = StrengthenMosaicSlot.creatMosaicSlot();
         deteleSlot = StrengthenDeleteSlot.creatDeleteSlot();
         ptSlot = promptSlot.creatDeleteSlot();
         strMove = StrenthenPanlMove.creatMove();
      }
      
      private function pointY(mc:MovieClip) : void
      {
         var myPoint:Point = null;
         myPoint = new Point(mc.x,mc.y);
         myPoint = this.localToGlobal(myPoint);
         if(myPoint.y + mc.height > 580)
         {
            mc.y = 580 - mc.height - 80;
            trace(mc.y + "!!!!!!");
         }
         if(myPoint.y < 0)
         {
            mc.y = 0;
         }
      }
      
      public function soltUpdate() : void
      {
         var i:uint = 0;
         slotBagArr = slot.slotArr();
         for(i = 0; i < 3; i++)
         {
            if(slotBagArr[i] != -1)
            {
               this["qh_" + i].visible = true;
               this["qh_" + i].howNum.text = "";
               this["qh_" + i].gotoAndStop(slotBagArr[i].getFrame());
               this["qhc_" + i].gotoAndStop(2);
            }
            else
            {
               this["qh_" + i].visible = false;
               this["qhc_" + i].gotoAndStop(1);
            }
         }
      }
      
      private function goldSf(goldNum:Number) : void
      {
         var gold:Number = NaN;
         var goldStr:String = null;
         var j:uint = 0;
         var i:int = 0;
         gold = int(goldNum);
         trace("面板显示的金币:" + gold);
         goldStr = gold.toString();
         for(j = 0; j < 5; j++)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + j].visible = false;
            }
         }
         for(i = 0; i < goldStr.length; i++)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + i].visible = true;
               if(goldStr.charAt(i) != "0")
               {
                  this.gold_mc.num_mc["num_" + i].gotoAndStop(goldStr.charAt(i));
               }
               else
               {
                  this.gold_mc.num_mc["num_" + i].gotoAndStop(10);
               }
            }
         }
      }
      
      private function daojuMessageOver(e:DaoJuEvent) : void
      {
         var mc:MovieClip = null;
         var nameStr:String = null;
         var nameId:String = null;
         var id:int = 0;
         mc = e.target as MovieClip;
         nameStr = mc.name;
         nameId = nameStr.substr(1,1);
         id = int(nameStr.substr(3,2));
         switch(nameId)
         {
            case "1":
               if(bagState == 1)
               {
                  tooltip.equipTooltip(bag1.getEquipFromBag(id),3);
               }
               if(bagState == 2)
               {
                  tooltip.suppliesTooltip(bag1.getSuppliesFromBag(id),3);
               }
               if(bagState == 3)
               {
                  tooltip.gemTooltip(bag1.getGemFromBag(id),3);
               }
               break;
            case "2":
               if(bagState == 1)
               {
                  tooltip.equipTooltip(bag2.getEquipFromBag(id),3);
               }
               if(bagState == 2)
               {
                  tooltip.suppliesTooltip(bag2.getSuppliesFromBag(id),3);
               }
               if(bagState == 3)
               {
                  tooltip.gemTooltip(bag2.getGemFromBag(id),3);
               }
               break;
            case "h":
               if(strengState == 1)
               {
                  if(slot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.equipTooltip(slot.getProp(id),3);
                     }
                  }
                  if(slot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(slot.getProp(1),3);
                     }
                  }
                  if(slot.getProp(2) != -1)
                  {
                     if(id == 2)
                     {
                        tooltip.gemTooltip(slot.getProp(2),3);
                     }
                  }
               }
               if(strengState == 2)
               {
                  if(skillSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.gemTooltip(skillSlot.getProp(id),3);
                     }
                  }
                  if(skillSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(skillSlot.getProp(id),3);
                     }
                  }
                  if(skillSlot.getProp(2) != -1)
                  {
                     if(id == 2)
                     {
                        tooltip.gemTooltip(skillSlot.getProp(2),3);
                     }
                  }
               }
               break;
            case "c":
               if(synthesisState == 1)
               {
                  if(synthesisSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.gemTooltip(synthesisSlot.getProp(id),3);
                     }
                  }
                  if(synthesisSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(synthesisSlot.getProp(id),3);
                     }
                  }
               }
               if(synthesisState == 2)
               {
                  if(mosaicSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.equipTooltip(mosaicSlot.getProp(id),3);
                     }
                  }
                  if(mosaicSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(mosaicSlot.getProp(id),3);
                     }
                  }
               }
               if(synthesisState == 3)
               {
                  if(deteleSlot.getProp(0) != -1)
                  {
                     if(id == 0)
                     {
                        tooltip.equipTooltip(deteleSlot.getProp(id),3);
                     }
                  }
                  if(mosaicSlot.getProp(1) != -1)
                  {
                     if(id == 1)
                     {
                        tooltip.gemTooltip(deteleSlot.getProp(id),3);
                     }
                  }
               }
         }
         if(!mouseDownBo)
         {
            tooltip.visible = true;
         }
         tooltip.x = mouseX + 10;
         tooltip.y = mouseY;
         pointY(tooltip);
         this.addChildAt(tooltip,numChildren - 1);
      }
      
      private function strengthenEquipOne(pointSlot:Number, bag:Bag) : void
      {
         var gem:Gem = null;
         var equip:Equip = null;
         if(slot.getProp(1) == -1)
         {
            strMove.equipMoveTostrenthen(pointSlot,targetMc.id,slot,bag);
            soltUpdate();
            equipUpdate();
         }
         else
         {
            gem = slot.getProp(1);
            equip = bag.getEquipFromBag(targetMc.id);
            if(equip.getReinforceLevel() < gem.getUseLevel())
            {
               strMove.equipMoveTostrenthen(pointSlot,targetMc.id,slot,bag);
               soltUpdate();
               equipUpdate();
               equipProbability = strMove.getEquipUpLevel(slot.getProp(0),gem);
               strenthenGl(equipProbability,luckGemProbaprobability);
            }
            else
            {
               trace("宝石使用等级不符合当前武器");
               ShortTip.open(24);
            }
         }
      }
      
      private function setXY() : void
      {
         var stageWidth:Number = NaN;
         var stageHeight:Number = NaN;
         trace("设置坐标");
         stageWidth = Main._stage.stageWidth / 2;
         stageHeight = Main._stage.stageHeight / 2;
         this.x = stageWidth - this.width / 2;
         this.y = 60;
      }
      
      private function beginSynthesis() : void
      {
         switch(synthesisState)
         {
            case 1:
               synthesisCondition();
               break;
            case 2:
               mosCondition();
               break;
            case 3:
               deCondition();
         }
      }
      
      private function closeStrengGl() : void
      {
         equipProbability = 0;
         skillProbability = 0;
         luckGemProbaprobability = 0;
         probability = 0;
         strengEquipText.text = "";
      }
      
      private function noInitPtow() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            this["d2_" + i].visible = false;
            p2Gold.text = "";
         }
      }
      
      private function strGemToBagSty() : void
      {
         var i:uint = 0;
         skillSlotArr = skillSlot.slotArr();
         if(!playerState)
         {
            for(i = 0; i < 3; i++)
            {
               if(skillSlotArr[i] != -1)
               {
                  strMove.gemBackToBag(skillSlotArr[i],bag1,skillSlot,i);
               }
            }
         }
         else
         {
            for(i = 0; i < 3; i++)
            {
               if(skillSlotArr[i] != -1)
               {
                  strMove.gemBackToBag(skillSlotArr[i],bag2,skillSlot,i);
               }
            }
         }
      }
      
      public function equipUpdate() : void
      {
         var i:uint = 0;
         if(!playerState)
         {
            playerEquipArr1 = bag1.getEquipBag();
            for(i = 0; i < 24; i++)
            {
               if(playerEquipArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(playerEquipArr1[i].getFrame());
                  this["d1_" + i].howNum.text = "";
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            playerEquipArr2 = bag2.getEquipBag();
            for(i = 0; i < 24; i++)
            {
               if(playerEquipArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(playerEquipArr2[i].getFrame());
                  this["d2_" + i].howNum.text = "";
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function gemUpdate() : void
      {
         var i:uint = 0;
         if(!playerState)
         {
            playerGemArr1 = bag1.getGemBag();
            for(i = 0; i < 24; i++)
            {
               if(playerGemArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(playerGemArr1[i].getFrame());
                  this["d1_" + i].howNum.text = playerGemArr1[i].getTimes();
                  if(playerGemArr1[i].getTimes() <= 1)
                  {
                     this["d1_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            playerGemArr2 = bag2.getGemBag();
            for(i = 0; i < 24; i++)
            {
               if(playerGemArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(playerGemArr2[i].getFrame());
                  this["d2_" + i].howNum.text = playerGemArr2[i].getTimes();
                  if(playerGemArr2[i].getTimes() <= 1)
                  {
                     this["d2_" + i].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      public function sysSlotUpdate() : void
      {
         var i:uint = 0;
         synthesisSlotArr = synthesisSlot.slotArr();
         for(i = 0; i < 3; i++)
         {
            if(synthesisSlotArr[i] != -1)
            {
               this["hc_" + i].visible = true;
               this["hc_" + i].howNum.text = "";
               this["hc_" + i].gotoAndStop(synthesisSlotArr[i].getFrame());
               this["hcc_" + i].gotoAndStop(2);
            }
            else
            {
               this["hc_" + i].visible = false;
               this["hcc_" + i].gotoAndStop(1);
            }
         }
      }
      
      private function strenthenGl(p1:Number, p2:Number) : void
      {
         var num:Number = NaN;
         num = p1 + p2;
         probability = num;
         if(probability >= 100)
         {
            probability = 100;
         }
         if(probability <= 0)
         {
            probability = 0;
         }
         if(probability <= 0)
         {
            strengEquipText.text = "";
         }
         else
         {
            strengEquipText.text = probability.toString() + "%";
         }
      }
      
      private function mosCondition() : void
      {
         if(mosaicSlot.getProp(0) != -1 && mosaicSlot.getProp(1) != -1)
         {
            closeMast.visible = true;
            typeNum = 2;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(3);
               goldSf(strMove.getMosicGold(mosaicSlot.getProp(0),mosaicSlot.getProp(1)));
               oldgold = strMove.getMosicGold(mosaicSlot.getProp(0),mosaicSlot.getProp(1));
               trace("镶嵌用的金币:" + oldgold);
            }
         }
         else
         {
            trace("放入必备物品");
            ShortTip.open(6);
         }
      }
      
      private function allstop() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            this["d1_" + i].stop();
            this["d2_" + i].stop();
         }
         for(i = 0; i < 3; i++)
         {
            this["qh_" + i].stop();
            this["qh_" + i].visible = false;
            this["hc_" + i].stop();
            this["hc_" + i].visible = false;
         }
      }
      
      private function synthesisToBagSty() : void
      {
         var i:uint = 0;
         synthesisSlotArr = synthesisSlot.slotArr();
         if(!playerState)
         {
            for(i = 0; i < 2; i++)
            {
               if(synthesisSlotArr[i] != -1)
               {
                  strMove.gemBackToBag(synthesisSlotArr[i],bag1,synthesisSlot,i);
               }
            }
         }
         else
         {
            for(i = 0; i < 2; i++)
            {
               if(synthesisSlotArr[i] != -1)
               {
                  strMove.gemBackToBag(synthesisSlotArr[i],bag2,synthesisSlot,i);
               }
            }
         }
      }
      
      private function daojuMessageUp(e:DaoJuEvent) : void
      {
         var mc:MovieClip = null;
         var nameStr:String = null;
         var nameId:String = null;
         var id:int = 0;
         mouseuup = false;
         mc = e.target as MovieClip;
         nameStr = mc.name;
         nameId = nameStr.substr(1,1);
         id = int(nameStr.substr(3,2));
         mouseDownBo = false;
         mc.stopDrag();
         this.addChildAt(mc,childIndex);
         if(!playerState)
         {
            if(nameId == "1")
            {
               if(mouseX > this.pc1_0.x)
               {
                  bagMoveInit(pcOnePointArr,bag1);
               }
               else if(mouseY < qhc_1.y + qhc_1.height)
               {
                  bagMoveToStrengthenLan(strengLanPointArr,bag1);
               }
               else
               {
                  bagMoveTosynthesisSlot(synthesisPointArr,mosaicPointArr,deletePointArr,bag1);
               }
            }
            else
            {
               if(nameId == "h")
               {
                  strengthenLanMoveToBag(pcOnePointArr,bag1);
               }
               if(nameId == "c")
               {
                  synthesisSlotLanMoveToBag(pcOnePointArr,bag1);
               }
            }
         }
         else if(nameId == "2")
         {
            if(mouseX > this.pc2_0.x)
            {
               bagMoveInit(pcTowPointArr,bag2);
            }
            else if(mouseY < qhc_1.y + qhc_1.height)
            {
               bagMoveToStrengthenLan(strengLanPointArr,bag2);
            }
            else
            {
               bagMoveTosynthesisSlot(synthesisPointArr,mosaicPointArr,deletePointArr,bag2);
            }
         }
         else
         {
            if(nameId == "h")
            {
               strengthenLanMoveToBag(pcTowPointArr,bag2);
            }
            if(nameId == "c")
            {
               synthesisSlotLanMoveToBag(pcTowPointArr,bag2);
            }
         }
      }
      
      private function outHandle(e:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function removeClick() : void
      {
         this.removeEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,daojuMessageOver);
         this.removeEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,daojuMessageOut);
         this.removeEventListener(DaoJuEvent.DAOJU_DOWN_MESSAGE,daojuMessageDown);
         this.removeEventListener(DaoJuEvent.DAOJU_UP_MESSAGE,daojuMessageUp);
      }
      
      private function addClick() : void
      {
         this.addEventListener(DaoJuEvent.DAOJU_OVER_MESSAGE,daojuMessageOver);
         this.addEventListener(DaoJuEvent.DAOJU_OUT_MESSAGE,daojuMessageOut);
         this.addEventListener(DaoJuEvent.DAOJU_DOWN_MESSAGE,daojuMessageDown);
         this.addEventListener(DaoJuEvent.DAOJU_UP_MESSAGE,daojuMessageUp);
      }
      
      private function synthesisSlotLanMoveToBag(pcPoint:Array, bag:Bag) : void
      {
         var targetX:int = 0;
         var targetY:int = 0;
         var i:uint = 0;
         var equip1:Equip = null;
         var equip2:Equip = null;
         var gem:Gem = null;
         var gem1:Gem = null;
         var gem2:Gem = null;
         targetX = mouseX;
         targetY = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         for(i = 0; i < 24; i++)
         {
            if(!(targetX >= pcPoint[i][1] && targetX <= pcPoint[i][1] + pc2_0.width && (targetY >= pcPoint[i][2] && targetY <= pcPoint[i][2] + pc2_0.height)))
            {
               continue;
            }
            switch(bagState)
            {
               case 1:
                  if(synthesisState == 2)
                  {
                     if(mosaicSlot.getPropEquip(targetMc.id))
                     {
                        equip1 = mosaicSlot.getProp(targetMc.id);
                        strMove.equipMoveToBag(equip1,mosaicSlot,bag,targetMc.id,pcPoint[i][0]);
                        equipUpdate();
                        mosaicSlotUpdate();
                        if(mosaicSlot.getProp(0) == -1)
                        {
                           sysGl(0,0);
                        }
                     }
                  }
                  if(synthesisState == 3)
                  {
                     if(deteleSlot.getPropEquip(targetMc.id))
                     {
                        equip2 = deteleSlot.getProp(targetMc.id);
                        strMove.equipMoveToBag(equip2,deteleSlot,bag,targetMc.id,pcPoint[i][0]);
                        equipUpdate();
                        deleteSlotUpdate();
                        deleteProbability = 0;
                        if(deteleSlot.getProp(0) == -1)
                        {
                           sysGl(deleteProbability,luckGemProbaprobability2);
                        }
                     }
                  }
                  break;
               case 3:
                  if(synthesisState == 1)
                  {
                     if(synthesisSlot.getPropGem(targetMc.id))
                     {
                        gem = synthesisSlot.getProp(targetMc.id);
                        strMove.gemBackToBag(gem,bag,synthesisSlot,targetMc.id,pcPoint[i][0]);
                        gemUpdate();
                        sysSlotUpdate();
                        if(synthesisSlot.getProp(0) == -1 && synthesisSlot.getProp(1) == -1)
                        {
                           sysGl(0,0);
                        }
                     }
                  }
                  if(synthesisState == 2)
                  {
                     if(mosaicSlot.getPropGem(targetMc.id))
                     {
                        gem1 = mosaicSlot.getProp(targetMc.id);
                        strMove.gemBackToBag(gem1,bag,mosaicSlot,targetMc.id,pcPoint[i][0]);
                        gemUpdate();
                        mosaicSlotUpdate();
                        if(mosaicSlot.getProp(0) == -1)
                        {
                           sysGl(0,0);
                        }
                     }
                  }
                  if(synthesisState == 3)
                  {
                     if(deteleSlot.getPropGem(targetMc.id))
                     {
                        gem2 = deteleSlot.getProp(targetMc.id);
                        strMove.gemBackToBag(gem2,bag,deteleSlot,targetMc.id,pcPoint[i][0]);
                        gemUpdate();
                        deleteSlotUpdate();
                        if(deteleSlot.getProp(1) == -1)
                        {
                           luckGemProbaprobability2 = 0;
                           sysGl(deleteProbability,luckGemProbaprobability2);
                        }
                     }
                  }
                  break;
               case 4:
                  bag.addOtherobjBag(synthesisSlot.slotArr[2]);
                  synthesisSlot.slotArr[2] = -1;
            }
         }
      }
      
      private function initP1orP2() : void
      {
         if(!playerState)
         {
            player1 = Main.player1;
            bag1 = player1.getBag();
            equipUpdate();
            btnIsClick(1);
            noInitPtow();
            keyMc.visible = true;
            keyMc.y = 252.65;
            mast_one.visible = false;
            p1Gold.text = player1.getGold().toString();
         }
         else
         {
            player2 = Main.player2;
            bag2 = player2.getBag();
            equipUpdate();
            btnIsClick(1);
            noInitPone();
            keyMc.visible = true;
            keyMc.y = 39.95;
            mast_tow.visible = false;
            p2Gold.text = player2.getGold().toString();
         }
      }
      
      private function initEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,changHandle);
         this.addEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.addEventListener(BtnEvent.DO_CLOSE,closeHandle);
         this.addEventListener(BtnEvent.DO_OVER,overHandle);
         this.addEventListener(BtnEvent.DO_OUT,outHandle);
         this.addEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.addEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         this.contextMenu = myMenu;
         Main._stage.addEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.addEventListener(MouseEvent.MOUSE_UP,loseFocus);
         timer = new Timer(1);
         timer.addEventListener(TimerEvent.TIMER,onTimer);
         timerSys = new Timer(1);
         timerSys.addEventListener(TimerEvent.TIMER,onTimerSys);
         addClick();
      }
      
      private function closeSysGl() : void
      {
         deleteProbability = 0;
         luckGemProbaprobability2 = 0;
         sysProbability = 0;
         syspText.text = "";
      }
      
      private function synpoint1() : void
      {
         var i:uint = 0;
         for(i = 0; i < 2; i++)
         {
            mosaicPointArr[i] = [i,this["hcc_" + i].x,this["hcc_" + i].y];
         }
      }
      
      private function closeEvent() : void
      {
         this.removeEventListener(BtnEvent.DO_CHANGE,changHandle);
         this.removeEventListener(BtnEvent.DO_CLOSE,closeHandle);
         this.removeEventListener(BtnEvent.DO_OVER,overHandle);
         this.removeEventListener(BtnEvent.DO_OUT,outHandle);
         this.removeEventListener(BtnEvent.DO_CLICK,clickHandle);
         this.removeEventListener(Event.DEACTIVATE,loseFocus);
         myMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,loseFocus);
         Main._stage.removeEventListener(Event.MOUSE_LEAVE,loseFocus);
         Main._stage.removeEventListener(MouseEvent.MOUSE_UP,loseFocus);
         removeClick();
      }
      
      private function synpoint2() : void
      {
         var i:uint = 0;
         for(i = 0; i < 2; i++)
         {
            deletePointArr[i] = [i,this["hcc_" + i].x,this["hcc_" + i].y];
         }
      }
      
      private function mosToBagSty() : void
      {
         if(!playerState)
         {
            if(mosaicSlot.getProp(0) != -1)
            {
               strMove.equipMoveToBag(mosaicSlot.getProp(0),mosaicSlot,bag1);
            }
            if(mosaicSlot.getProp(1) != -1)
            {
               strMove.gemBackToBag(mosaicSlot.getProp(1),bag1,mosaicSlot,1);
            }
         }
         else
         {
            if(mosaicSlot.getProp(0) != -1)
            {
               strMove.equipMoveToBag(mosaicSlot.getProp(0),mosaicSlot,bag2);
            }
            if(mosaicSlot.getProp(1) != -1)
            {
               strMove.gemBackToBag(mosaicSlot.getProp(1),bag2,mosaicSlot,1);
            }
         }
      }
      
      private function deCondition() : void
      {
         if(deteleSlot.getProp(0) != -1)
         {
            closeMast.visible = true;
            typeNum = 2;
            if(gold_mc.visible == false)
            {
               gold_mc.visible = true;
               gold_mc.gotoAndStop(1);
               goldSf(strMove.getDeleteGold(deteleSlot.getProp(0)));
               oldgold = strMove.getDeleteGold(deteleSlot.getProp(0));
            }
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      public function closeMc() : void
      {
         prompt.visible = false;
         gold_mc.visible = false;
      }
      
      private function closeData() : void
      {
         strToBagSty();
         strGemToBagSty();
         synthesisToBagSty();
         mosToBagSty();
         deleteToBagSty();
         closeStrengGl();
         closeSysGl();
         equipUpdate();
         soltUpdate();
         btnIsClick(1);
         bagState = 1;
         strengState = 1;
         textMc.gotoAndStop(1);
         str_tow.isClick = false;
         synthesisState = 1;
         this.hc_2.visible = true;
         this.hcc_2.visible = true;
         this.x3_mc.visible = true;
         this.hc_0.x = 56.15;
         this.hcc_0.x = 53.7;
         this.x1_mc.x = 50.35;
         this.hc_1.x = 132.15;
         this.hcc_1.x = 129.7;
         this.x2_mc.x = 126.35;
         sysSlotUpdate();
         this.syn_mc.gotoAndStop(1);
         this.syn_mc.hc.h2.gotoAndStop(1);
         sys_tow.isClick = false;
         sys_three.isClick = false;
         sys_one.isClick = true;
      }
      
      private function clickHandle(e:BtnEvent) : void
      {
         switch(e.id)
         {
            case 11:
               beginStrengthen();
               break;
            case 12:
               beginSynthesis();
               break;
            case 13:
               help.visible = true;
               break;
            case 14:
               help.gotoAndStop(1);
               break;
            case 15:
               help.gotoAndStop(3);
               break;
            case 16:
               help.gotoAndStop(4);
               break;
            case 17:
               help.gotoAndStop(5);
               break;
            case 18:
               help.visible = false;
               break;
            case 19:
               help.gotoAndStop(2);
         }
      }
      
      private function strengthenEquipTow(pointSlot:Number, typeArr:Array, bag:Bag) : void
      {
         var equip:Equip = null;
         var gem:Gem = null;
         if(slot.getProp(0) == -1)
         {
            strMove.bagGemMoveToStr(pointSlot,targetMc,typeArr,slot,bag);
            soltUpdate();
            gemUpdate();
         }
         else
         {
            equip = slot.getProp(0);
            gem = bag.getGemFromBag(targetMc.id);
            if(gem.getType() == 1)
            {
               if(equip.getReinforceLevel() < gem.getUseLevel())
               {
                  strMove.bagGemMoveToStr(pointSlot,targetMc,typeArr,slot,bag);
                  soltUpdate();
                  gemUpdate();
                  equipProbability = strMove.getEquipUpLevel(equip,slot.getProp(1));
                  strenthenGl(equipProbability,luckGemProbaprobability);
               }
               else
               {
                  trace("宝石使用等级不符合当前武器");
                  ShortTip.open(24);
               }
            }
            else
            {
               strMove.bagGemMoveToStr(pointSlot,targetMc,typeArr,slot,bag);
               soltUpdate();
               gemUpdate();
            }
         }
      }
      
      private function initAllBag(num:Number = 1) : void
      {
         if(num == 1)
         {
            playerState = false;
         }
         else if(num == 2)
         {
            playerState = true;
         }
         bagState = 1;
         s1_mc.stop();
         s2_mc.stop();
         s3_mc.stop();
         s4_mc.stop();
         str_one.isClick = true;
         sys_one.isClick = true;
         initP1orP2();
         strengthenBagCao();
         strengthenLanCao();
         initEvent();
         allstop();
      }
      
      private function changHandle(e:BtnEvent) : void
      {
         var nameStr:* = undefined;
         nameStr = e.target.name.substr(1,1);
         bagState = e.id;
         switch(e.id)
         {
            case 1:
               btnIsClick(1);
               equipUpdate();
               break;
            case 2:
               btnIsClick(2);
               supUpdate();
               break;
            case 3:
               btnIsClick(3);
               gemUpdate();
               break;
            case 4:
               btnIsClick(4);
               otherUpdate();
               break;
            case 5:
               btnIsClick(5);
               taskUpdate();
         }
         if(okMove)
         {
            if(e.id == 6)
            {
               strengState = 1;
               bagState = 1;
               textMc.gotoAndStop(1);
               str_tow.isClick = false;
               closeStrengGl();
               btnIsClick(1);
               strGemToBagSty();
               soltUpdate();
               equipUpdate();
               skillProbability = 0;
            }
            if(e.id == 7)
            {
               strengState = 2;
               bagState = 3;
               textMc.gotoAndStop(2);
               str_one.isClick = false;
               closeStrengGl();
               btnIsClick(3);
               strToBagSty();
               skillSoltUpdate();
               gemUpdate();
               equipProbability = 0;
            }
         }
         if(okMove1)
         {
            if(e.id == 8)
            {
               synthesisState = 1;
               bagState = 3;
               this.hc_2.visible = true;
               this.hcc_2.visible = true;
               this.x3_mc.visible = true;
               this.hc_0.x = 56.15;
               this.hcc_0.x = 53.7;
               this.x1_mc.x = 50.35;
               this.hc_1.x = 132.15;
               this.hcc_1.x = 129.7;
               this.x2_mc.x = 126.35;
               this.syn_mc.gotoAndStop(1);
               this.syn_mc.hc.h2.gotoAndStop(1);
               sys_tow.isClick = false;
               sys_three.isClick = false;
               closeSysGl();
               btnIsClick(3);
               mosToBagSty();
               deleteToBagSty();
               gemUpdate();
               sysSlotUpdate();
            }
            if(e.id == 9)
            {
               synthesisState = 2;
               bagState = 1;
               this.hc_2.visible = false;
               this.hcc_2.visible = false;
               this.x3_mc.visible = false;
               this.hc_0.x = 72;
               this.hcc_0.x = 70;
               this.x1_mc.x = 66.82;
               this.hc_1.x = 184;
               this.hcc_1.x = 182;
               this.x2_mc.x = 178.5;
               this.syn_mc.gotoAndStop(2);
               this.syn_mc.hc.h2.gotoAndStop(2);
               sys_three.isClick = false;
               sys_one.isClick = false;
               synpoint1();
               closeSysGl();
               btnIsClick(1);
               synthesisToBagSty();
               mosaicSlotUpdate();
               deleteToBagSty();
               equipUpdate();
            }
            if(e.id == 10)
            {
               synthesisState = 3;
               bagState = 1;
               this.hc_2.visible = false;
               this.hcc_2.visible = false;
               this.x3_mc.visible = false;
               this.hc_0.x = 72;
               this.hcc_0.x = 70;
               this.x1_mc.x = 66.82;
               this.hc_1.x = 184;
               this.hcc_1.x = 182;
               this.x2_mc.x = 178.5;
               this.syn_mc.gotoAndStop(3);
               this.syn_mc.hc.h2.gotoAndStop(3);
               sys_tow.isClick = false;
               sys_one.isClick = false;
               synpoint2();
               closeSysGl();
               btnIsClick(1);
               synthesisToBagSty();
               mosToBagSty();
               deleteSlotUpdate();
               equipUpdate();
            }
         }
      }
      
      private function synthesisCondition() : void
      {
         if(synthesisSlot.getProp(0) != -1 && synthesisSlot.getProp(1) != -1 && synthesisSlot.getProp(2) != -1)
         {
            closeMast.visible = true;
            timesSys = 0;
            okMove1 = false;
            timerSys.start();
            s3_mc.gotoAndPlay(2);
            s4_mc.gotoAndPlay(2);
            removeClick();
         }
         else
         {
            trace("放入必要物品");
            ShortTip.open(6);
         }
      }
      
      public function otherUpdate() : void
      {
         var i:uint = 0;
         if(!playerState)
         {
            otherArr1 = bag1.getOtherobjBag();
            for(i = 0; i < 24; i++)
            {
               if(otherArr1[i] != null)
               {
                  this["d1_" + i].visible = true;
                  this["d1_" + i].gotoAndStop(otherArr1[i].getFrame());
               }
               else
               {
                  this["d1_" + i].visible = false;
               }
            }
         }
         else
         {
            otherArr2 = bag2.getOtherobjBag();
            for(i = 0; i < 24; i++)
            {
               if(otherArr2[i] != null)
               {
                  this["d2_" + i].visible = true;
                  this["d2_" + i].gotoAndStop(otherArr2[i].getFrame());
               }
               else
               {
                  this["d2_" + i].visible = false;
               }
            }
         }
      }
      
      private function strengthenBagCao() : void
      {
         var i:uint = 0;
         for(i = 0; i < 24; i++)
         {
            pcOnePointArr[i] = [i,this["pc1_" + i].x,this["pc1_" + i].y];
            pcTowPointArr[i] = [i,this["pc2_" + i].x,this["pc2_" + i].y];
         }
      }
   }
}

class PrivateClass
{
   
   public function PrivateClass()
   {
      super();
   }
}
