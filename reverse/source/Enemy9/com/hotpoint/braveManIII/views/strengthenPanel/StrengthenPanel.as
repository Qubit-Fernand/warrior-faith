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
      
      public function StrengthenPanel(param1:PrivateClass)
      {
         super();
      }
      
      public static function open(param1:Number = 1) : void
      {
         if(StrengthenPanel._instance == null)
         {
            StrengthenPanel._instance = new StrengthenPanel(new PrivateClass());
            StrengthenPanel._instance.initMc();
         }
         StrengthenPanel._instance.x = 100;
         StrengthenPanel._instance.y = 50;
         Main._stage.addChild(StrengthenPanel._instance);
         StrengthenPanel._instance.visible = true;
         StrengthenPanel._instance.initAllBag(param1);
         StrengthenPanel._instance.closeMast.visible = false;
      }
      
      public static function close() : void
      {
         if(StrengthenPanel._instance != null)
         {
            if(StrengthenPanel._instance.visible == true)
            {
               StrengthenPanel._instance.visible = false;
               StrengthenPanel._instance.closeEvent();
               StrengthenPanel._instance.closeData();
            }
         }
      }
      
      public static function loseFocus(param1:Event = null) : void
      {
         if(targetMc)
         {
            targetMc.stopDrag();
            targetMc.x = oldX;
            targetMc.y = oldY;
            _instance.addChildAt(targetMc,childIndex);
         }
      }
      
      private function bagMoveTosynthesisSlot(param1:Array, param2:Array, param3:Array, param4:Bag) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Bag = null;
         var _loc8_:Array = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         _loc5_ = mouseX;
         _loc6_ = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         _loc7_ = param4;
         _loc8_ = [];
         if(synthesisState == 1)
         {
            _loc11_ = 0;
            for(; _loc11_ < 3; _loc11_++)
            {
               if(!(_loc5_ >= param1[_loc11_][1] && _loc5_ <= param1[_loc11_][1] + pc2_0.width && (_loc6_ >= param1[_loc11_][2] && _loc6_ <= param1[_loc11_][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(bagState)
               {
                  case 3:
                     _loc8_ = [0,1,3];
                     if(_loc7_.backGemBagNum() > 0)
                     {
                        if(_loc7_.getGemFromBag(targetMc.id).getType() == 0 || _loc7_.getGemFromBag(targetMc.id).getType() == 1 || _loc7_.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(_loc7_.getGemFromBag(targetMc.id).getColor() == 1)
                           {
                              if(param1[_loc11_][0] == 0)
                              {
                                 sysOne(0,1,_loc8_,_loc7_);
                                 if(synthesisSlot.getProp(0) != -1)
                                 {
                                    sysGl(100,0);
                                 }
                              }
                              if(param1[_loc11_][0] == 1)
                              {
                                 _loc8_ = [0,1,3];
                                 sysOne(1,0,_loc8_,_loc7_);
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
                     if(param1[_loc11_][0] == 2)
                     {
                        synthesisSlot.addToSlot(_loc7_.delOtherobj(targetMc.id),2);
                     }
               }
            }
         }
         if(synthesisState == 2)
         {
            _loc11_ = 0;
            for(; _loc11_ < 2; _loc11_++)
            {
               if(!(_loc5_ >= param2[_loc11_][1] && _loc5_ <= param2[_loc11_][1] + pc2_0.width && (_loc6_ >= param2[_loc11_][2] && _loc6_ <= param2[_loc11_][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(bagState)
               {
                  case 1:
                     if(mosaicSlot.getProp(1) == -1)
                     {
                        if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           strMove.equipMoveTostrenthen(param1[_loc11_][0],targetMc.id,mosaicSlot,_loc7_);
                           equipUpdate();
                           mosaicSlotUpdate();
                        }
                        else
                        {
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              trace("无法继续镶嵌");
                              ShortTip.open(8);
                           }
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == -1)
                           {
                              trace("没有孔");
                              ShortTip.open(7);
                           }
                        }
                     }
                     else if(_loc7_.getEquipFromBag(targetMc.id).getDressLevel() >= mosaicSlot.getProp(1).getUseLevel())
                     {
                        if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 1)
                        {
                           strMove.equipMoveTostrenthen(param1[_loc11_][0],targetMc.id,mosaicSlot,_loc7_);
                           equipUpdate();
                           mosaicSlotUpdate();
                        }
                        else
                        {
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 0)
                           {
                              ShortTip.open(8);
                              trace("无法继续镶嵌");
                           }
                           if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == -1)
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
                     if(param2[_loc11_][0] == 1)
                     {
                        _loc8_ = [3];
                        if(_loc7_.getGemFromBag(targetMc.id).getType() == 3)
                        {
                           if(mosaicSlot.getProp(0) == -1)
                           {
                              strMove.bagGemMoveToStr(1,targetMc,_loc8_,mosaicSlot,_loc7_);
                              gemUpdate();
                              mosaicSlotUpdate();
                           }
                           else if(mosaicSlot.getProp(0).getDressLevel() >= _loc7_.getGemFromBag(targetMc.id).getUseLevel())
                           {
                              strMove.bagGemMoveToStr(1,targetMc,_loc8_,mosaicSlot,_loc7_);
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
            _loc11_ = 0;
            for(; _loc11_ < 2; _loc11_++)
            {
               if(!(_loc5_ >= param3[_loc11_][1] && _loc5_ <= param3[_loc11_][1] + pc2_0.width && (_loc6_ >= param3[_loc11_][2] && _loc6_ <= param3[_loc11_][2] + pc2_0.height)))
               {
                  continue;
               }
               switch(bagState)
               {
                  case 1:
                     if(_loc7_.backGemBagNum() > 0)
                     {
                        if(_loc7_.getEquipFromBag(targetMc.id).getGrid() == 0)
                        {
                           strMove.equipMoveTostrenthen(param3[_loc11_][0],targetMc.id,deteleSlot,_loc7_);
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
                     if(param3[_loc11_][0] == 1)
                     {
                        _loc8_ = [2];
                        if(_loc7_.getGemFromBag(targetMc.id).getType() == 2)
                        {
                           strMove.bagGemMoveToStr(1,targetMc,_loc8_,deteleSlot,_loc7_);
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
         var _loc1_:uint = 0;
         skillSlotArr = skillSlot.slotArr();
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(skillSlotArr[_loc1_] != -1)
            {
               this["qh_" + _loc1_].visible = true;
               this["qh_" + _loc1_].howNum.text = "";
               this["qh_" + _loc1_].gotoAndStop(skillSlotArr[_loc1_].getFrame());
               this["qhc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["qh_" + _loc1_].visible = false;
               this["qhc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function daojuMessageOut(param1:DaoJuEvent) : void
      {
         tooltip.visible = false;
      }
      
      private function overHandle(param1:BtnEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = param1.target.name;
         tooltip.visible = true;
         if(_loc2_ == "prompt_1")
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
         if(_loc2_ == "prompt_2")
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
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            this["d1_" + _loc1_].visible = false;
            p1Gold.text = "";
            _loc1_++;
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
      
      private function sysOne(param1:Number, param2:Number, param3:Array, param4:Bag) : void
      {
         var _loc5_:Gem = null;
         var _loc6_:Gem = null;
         if(synthesisSlot.getProp(param2) == -1)
         {
            strMove.bagGemMoveToStr(param1,targetMc,param3,synthesisSlot,param4);
            gemUpdate();
            sysSlotUpdate();
         }
         else
         {
            _loc5_ = synthesisSlot.getProp(param2);
            _loc6_ = param4.getGemFromBag(targetMc.id);
            if(_loc5_.getType() == _loc6_.getType())
            {
               if(_loc5_.getType() == 1)
               {
                  if(_loc5_.getUseLevel() == _loc6_.getUseLevel())
                  {
                     strMove.bagGemMoveToStr(param1,targetMc,param3,synthesisSlot,param4);
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
                  strMove.bagGemMoveToStr(param1,targetMc,param3,synthesisSlot,param4);
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
      
      private function closeHandle(param1:BtnEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         _loc2_ = uint(param1.target.id);
         _loc3_ = param1.target.parent.name;
         if(_loc3_ == "gold_mc")
         {
            if(_loc2_ == 1)
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
            if(_loc2_ == 2)
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
            if(_loc2_ == 3)
            {
               close();
            }
            prompt.visible = false;
         }
      }
      
      private function onTimerSys(param1:TimerEvent) : void
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
            }
         }
      }
      
      private function strengthenLanMoveToBag(param1:Array, param2:Bag) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:Equip = null;
         var _loc7_:Gem = null;
         var _loc8_:Gem = null;
         _loc3_ = mouseX;
         _loc4_ = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         _loc5_ = 0;
         for(; _loc5_ < 24; _loc5_++)
         {
            if(!(_loc3_ >= param1[_loc5_][1] && _loc3_ <= param1[_loc5_][1] + pc2_0.width && (_loc4_ >= param1[_loc5_][2] && _loc4_ <= param1[_loc5_][2] + pc2_0.height)))
            {
               continue;
            }
            switch(bagState)
            {
               case 1:
                  if(slot.getPropEquip(targetMc.id))
                  {
                     _loc6_ = slot.getProp(targetMc.id);
                     strMove.equipMoveToBag(_loc6_,slot,param2,targetMc.id,param1[_loc5_][0]);
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
                        _loc7_ = slot.getProp(targetMc.id);
                        strMove.gemBackToBag(_loc7_,param2,slot,targetMc.id,param1[_loc5_][0]);
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
                     _loc8_ = skillSlot.getProp(targetMc.id);
                     if(skillSlot.getPropGem(targetMc.id))
                     {
                        strMove.gemBackToBag(_loc8_,param2,skillSlot,targetMc.id,param1[_loc5_][0]);
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
         var _loc1_:uint = 0;
         mosaicSlotArr = mosaicSlot.slotArr();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            if(mosaicSlotArr[_loc1_] != -1)
            {
               this["hc_" + _loc1_].visible = true;
               this["hc_" + _loc1_].howNum.text = "";
               this["hc_" + _loc1_].gotoAndStop(mosaicSlotArr[_loc1_].getFrame());
               this["hcc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["hc_" + _loc1_].visible = false;
               this["hcc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      public function deleteSlotUpdate() : void
      {
         var _loc1_:uint = 0;
         deteleSlotArr = deteleSlot.slotArr();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            if(deteleSlotArr[_loc1_] != -1)
            {
               this["hc_" + _loc1_].visible = true;
               this["hc_" + _loc1_].howNum.text = "";
               this["hc_" + _loc1_].gotoAndStop(deteleSlotArr[_loc1_].getFrame());
               this["hcc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["hc_" + _loc1_].visible = false;
               this["hcc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function bagMoveToStrengthenLan(param1:Array, param2:Bag) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Bag = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         _loc3_ = mouseX;
         _loc4_ = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         _loc5_ = param2 as Bag;
         _loc6_ = [];
         _loc7_ = 0;
         while(_loc7_ < 3)
         {
            if(_loc3_ >= param1[_loc7_][1] && _loc3_ <= param1[_loc7_][1] + pc2_0.width && (_loc4_ >= param1[_loc7_][2] && _loc4_ <= param1[_loc7_][2] + pc2_0.height))
            {
               if(strengState == 1)
               {
                  switch(bagState)
                  {
                     case 1:
                        if(param1[_loc7_][0] == 0)
                        {
                           if(_loc5_.getEquipFromBag(targetMc.id).getDressLevel() < 50)
                           {
                              if(_loc5_.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 strengthenEquipOne(0,_loc5_);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(_loc5_.getEquipFromBag(targetMc.id).getColor() == 1 || _loc5_.getEquipFromBag(targetMc.id).getColor() == 2)
                           {
                              if(_loc5_.getEquipFromBag(targetMc.id).getReinforceLevel() < 6)
                              {
                                 strengthenEquipOne(0,_loc5_);
                              }
                              else
                              {
                                 trace("强化等级满");
                                 ShortTip.open(5);
                              }
                           }
                           else if(_loc5_.getEquipFromBag(targetMc.id).getReinforceLevel() < 10)
                           {
                              strengthenEquipOne(0,_loc5_);
                           }
                           else
                           {
                              trace("强化等级满");
                              ShortTip.open(5);
                           }
                        }
                        break;
                     case 3:
                        if(param1[_loc7_][0] == 1)
                        {
                           _loc6_ = [1];
                           if(_loc5_.backGemBagNum() > 0)
                           {
                              if(_loc5_.getGemFromBag(targetMc.id).getType() == 1)
                              {
                                 strengthenEquipTow(1,_loc6_,_loc5_);
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
                        if(param1[_loc7_][0] == 2)
                        {
                           _loc6_ = [2];
                           if(_loc5_.backGemBagNum() > 0)
                           {
                              if(_loc5_.getGemFromBag(targetMc.id).getType() == 2)
                              {
                                 strengthenEquipTow(2,_loc6_,_loc5_);
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
                     if(param1[_loc7_][0] == 0)
                     {
                        _loc6_ = [4];
                        if(_loc5_.backGemBagNum() > 0)
                        {
                           if(_loc5_.getGemFromBag(targetMc.id).getType() == 4)
                           {
                              if(_loc5_.getGemFromBag(targetMc.id).getStrengthenLevel() < 4)
                              {
                                 strMove.bagGemMoveToStr(0,targetMc,_loc6_,skillSlot,_loc5_);
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
                     if(param1[_loc7_][0] == 1)
                     {
                        _loc6_ = [0];
                        if(_loc5_.backGemBagNum() > 0)
                        {
                           if(_loc5_.getGemFromBag(targetMc.id).getType() == 0)
                           {
                              strMove.bagGemMoveToStr(1,targetMc,_loc6_,skillSlot,_loc5_);
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
                     if(param1[_loc7_][0] == 2)
                     {
                        _loc6_ = [2];
                        if(_loc5_.backGemBagNum() > 0)
                        {
                           if(_loc5_.getGemFromBag(targetMc.id).getType() == 2)
                           {
                              strMove.bagGemMoveToStr(2,targetMc,_loc6_,skillSlot,_loc5_);
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
            _loc7_++;
         }
      }
      
      private function sysGl(param1:Number, param2:Number) : *
      {
         var _loc3_:Number = NaN;
         _loc3_ = param1 + param2;
         sysProbability = _loc3_;
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
      
      private function btnIsClick(param1:Number) : void
      {
         var _loc2_:uint = 0;
         if(!playerState)
         {
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               this["p1_" + _loc2_].isClick = false;
               _loc2_++;
            }
            this["p1_" + param1].isClick = true;
         }
         else
         {
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               this["p2_" + _loc2_].isClick = false;
               _loc2_++;
            }
            this["p2_" + param1].isClick = true;
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
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
         }
      }
      
      private function bagMoveInit(param1:Array, param2:Bag) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         _loc3_ = targetMc.x + targetMc.width / 2;
         _loc4_ = targetMc.y + targetMc.height / 2;
         targetMc.x = oldX;
         targetMc.y = oldY;
         _loc5_ = 0;
         for(; _loc5_ < 24; _loc5_++)
         {
            if(!(_loc3_ >= param1[_loc5_][1] && _loc3_ <= param1[_loc5_][1] + pc2_0.width && (_loc4_ >= param1[_loc5_][2] && _loc4_ <= param1[_loc5_][2] + pc2_0.height)))
            {
               continue;
            }
            switch(bagState)
            {
               case 1:
                  param2.equipBagMove(targetMc.id,param1[_loc5_][0]);
                  equipUpdate();
                  break;
               case 2:
                  param2.suppliesBagMove(targetMc.id,param1[_loc5_][0]);
                  supUpdate();
                  break;
               case 3:
                  param2.gemBagMove(targetMc.id,param1[_loc5_][0]);
                  gemUpdate();
                  break;
               case 4:
                  param2.otherobjBagMove(targetMc.id,param1[_loc5_][0]);
                  otherUpdate();
                  break;
               case 5:
                  param2.questBagMove(targetMc.id,param1[_loc5_][0]);
                  taskUpdate();
            }
         }
      }
      
      private function daojuMessageDown(param1:DaoJuEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         mouseuup = true;
         _loc2_ = param1.target as MovieClip;
         _loc3_ = _loc2_.name;
         downName = _loc3_.substr(1,1);
         _loc4_ = Number(_loc3_.substr(3,2));
         mouseDownBo = true;
         _loc2_.startDrag();
         tooltip.visible = false;
         targetMc = _loc2_;
         targetMc.id = _loc4_;
         oldX = _loc2_.x;
         oldY = _loc2_.y;
         _loc2_.x = mouseX - _loc2_.width / 2;
         _loc2_.y = mouseY - _loc2_.height / 2;
         childIndex = this.getChildIndex(_loc2_);
         this.addChildAt(_loc2_,numChildren - 2);
      }
      
      public function taskUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!playerState)
         {
            taskArr1 = bag1.getQuestBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(taskArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(taskArr1[_loc1_].getFrame());
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            taskArr2 = bag2.getQuestBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(taskArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(taskArr2[_loc1_].getFrame());
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function supUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!playerState)
         {
            palyerSuppliesArr1 = bag1.getSuppliesBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(palyerSuppliesArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(palyerSuppliesArr1[_loc1_].getFrame());
                  this["d1_" + _loc1_].howNum.text = palyerSuppliesArr1[_loc1_].getTimes();
                  if(palyerSuppliesArr1[_loc1_].getTimes() <= 1)
                  {
                     this["d1_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            palyerSuppliesArr2 = bag2.getSuppliesBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(palyerSuppliesArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(palyerSuppliesArr2[_loc1_].getFrame());
                  this["d2_" + _loc1_].howNum.text = palyerSuppliesArr2[_loc1_].getTimes();
                  if(palyerSuppliesArr2[_loc1_].getTimes() <= 1)
                  {
                     this["d2_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      private function strengthenLanCao() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            strengLanPointArr[_loc1_] = [_loc1_,this["qhc_" + _loc1_].x,this["qhc_" + _loc1_].y];
            synthesisPointArr[_loc1_] = [_loc1_,this["hcc_" + _loc1_].x,this["hcc_" + _loc1_].y];
            _loc1_++;
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
      
      private function pointY(param1:MovieClip) : void
      {
         var _loc2_:Point = null;
         _loc2_ = new Point(param1.x,param1.y);
         _loc2_ = this.localToGlobal(_loc2_);
         if(_loc2_.y + param1.height > 580)
         {
            param1.y = 580 - param1.height - 80;
            trace(param1.y + "!!!!!!");
         }
         if(_loc2_.y < 0)
         {
            param1.y = 0;
         }
      }
      
      public function soltUpdate() : void
      {
         var _loc1_:uint = 0;
         slotBagArr = slot.slotArr();
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(slotBagArr[_loc1_] != -1)
            {
               this["qh_" + _loc1_].visible = true;
               this["qh_" + _loc1_].howNum.text = "";
               this["qh_" + _loc1_].gotoAndStop(slotBagArr[_loc1_].getFrame());
               this["qhc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["qh_" + _loc1_].visible = false;
               this["qhc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function goldSf(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         _loc2_ = int(param1);
         trace("面板显示的金币:" + _loc2_);
         _loc3_ = _loc2_.toString();
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + _loc4_].visible = false;
            }
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            if(this.gold_mc.num_mc)
            {
               this.gold_mc.num_mc["num_" + _loc5_].visible = true;
               if(_loc3_.charAt(_loc5_) != "0")
               {
                  this.gold_mc.num_mc["num_" + _loc5_].gotoAndStop(_loc3_.charAt(_loc5_));
               }
               else
               {
                  this.gold_mc.num_mc["num_" + _loc5_].gotoAndStop(10);
               }
            }
            _loc5_++;
         }
      }
      
      private function daojuMessageOver(param1:DaoJuEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = param1.target as MovieClip;
         _loc3_ = _loc2_.name;
         _loc4_ = _loc3_.substr(1,1);
         _loc5_ = int(_loc3_.substr(3,2));
         switch(_loc4_)
         {
            case "1":
               if(bagState == 1)
               {
                  tooltip.equipTooltip(bag1.getEquipFromBag(_loc5_),3);
               }
               if(bagState == 2)
               {
                  tooltip.suppliesTooltip(bag1.getSuppliesFromBag(_loc5_),3);
               }
               if(bagState == 3)
               {
                  tooltip.gemTooltip(bag1.getGemFromBag(_loc5_),3);
               }
               break;
            case "2":
               if(bagState == 1)
               {
                  tooltip.equipTooltip(bag2.getEquipFromBag(_loc5_),3);
               }
               if(bagState == 2)
               {
                  tooltip.suppliesTooltip(bag2.getSuppliesFromBag(_loc5_),3);
               }
               if(bagState == 3)
               {
                  tooltip.gemTooltip(bag2.getGemFromBag(_loc5_),3);
               }
               break;
            case "h":
               if(strengState == 1)
               {
                  if(slot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.equipTooltip(slot.getProp(_loc5_),3);
                     }
                  }
                  if(slot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(slot.getProp(1),3);
                     }
                  }
                  if(slot.getProp(2) != -1)
                  {
                     if(_loc5_ == 2)
                     {
                        tooltip.gemTooltip(slot.getProp(2),3);
                     }
                  }
               }
               if(strengState == 2)
               {
                  if(skillSlot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.gemTooltip(skillSlot.getProp(_loc5_),3);
                     }
                  }
                  if(skillSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(skillSlot.getProp(_loc5_),3);
                     }
                  }
                  if(skillSlot.getProp(2) != -1)
                  {
                     if(_loc5_ == 2)
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
                     if(_loc5_ == 0)
                     {
                        tooltip.gemTooltip(synthesisSlot.getProp(_loc5_),3);
                     }
                  }
                  if(synthesisSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(synthesisSlot.getProp(_loc5_),3);
                     }
                  }
               }
               if(synthesisState == 2)
               {
                  if(mosaicSlot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.equipTooltip(mosaicSlot.getProp(_loc5_),3);
                     }
                  }
                  if(mosaicSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(mosaicSlot.getProp(_loc5_),3);
                     }
                  }
               }
               if(synthesisState == 3)
               {
                  if(deteleSlot.getProp(0) != -1)
                  {
                     if(_loc5_ == 0)
                     {
                        tooltip.equipTooltip(deteleSlot.getProp(_loc5_),3);
                     }
                  }
                  if(mosaicSlot.getProp(1) != -1)
                  {
                     if(_loc5_ == 1)
                     {
                        tooltip.gemTooltip(deteleSlot.getProp(_loc5_),3);
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
      
      private function strengthenEquipOne(param1:Number, param2:Bag) : void
      {
         var _loc3_:Gem = null;
         var _loc4_:Equip = null;
         if(slot.getProp(1) == -1)
         {
            strMove.equipMoveTostrenthen(param1,targetMc.id,slot,param2);
            soltUpdate();
            equipUpdate();
         }
         else
         {
            _loc3_ = slot.getProp(1);
            _loc4_ = param2.getEquipFromBag(targetMc.id);
            if(_loc4_.getReinforceLevel() < _loc3_.getUseLevel())
            {
               strMove.equipMoveTostrenthen(param1,targetMc.id,slot,param2);
               soltUpdate();
               equipUpdate();
               equipProbability = strMove.getEquipUpLevel(slot.getProp(0),_loc3_);
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
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         trace("设置坐标");
         _loc1_ = Main._stage.stageWidth / 2;
         _loc2_ = Main._stage.stageHeight / 2;
         this.x = _loc1_ - this.width / 2;
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
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            this["d2_" + _loc1_].visible = false;
            p2Gold.text = "";
            _loc1_++;
         }
      }
      
      private function strGemToBagSty() : void
      {
         var _loc1_:uint = 0;
         skillSlotArr = skillSlot.slotArr();
         if(!playerState)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               if(skillSlotArr[_loc1_] != -1)
               {
                  strMove.gemBackToBag(skillSlotArr[_loc1_],bag1,skillSlot,_loc1_);
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               if(skillSlotArr[_loc1_] != -1)
               {
                  strMove.gemBackToBag(skillSlotArr[_loc1_],bag2,skillSlot,_loc1_);
               }
               _loc1_++;
            }
         }
      }
      
      public function equipUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!playerState)
         {
            playerEquipArr1 = bag1.getEquipBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(playerEquipArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(playerEquipArr1[_loc1_].getFrame());
                  this["d1_" + _loc1_].howNum.text = "";
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            playerEquipArr2 = bag2.getEquipBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(playerEquipArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(playerEquipArr2[_loc1_].getFrame());
                  this["d2_" + _loc1_].howNum.text = "";
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function gemUpdate() : void
      {
         var _loc1_:uint = 0;
         if(!playerState)
         {
            playerGemArr1 = bag1.getGemBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(playerGemArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(playerGemArr1[_loc1_].getFrame());
                  this["d1_" + _loc1_].howNum.text = playerGemArr1[_loc1_].getTimes();
                  if(playerGemArr1[_loc1_].getTimes() <= 1)
                  {
                     this["d1_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            playerGemArr2 = bag2.getGemBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(playerGemArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(playerGemArr2[_loc1_].getFrame());
                  this["d2_" + _loc1_].howNum.text = playerGemArr2[_loc1_].getTimes();
                  if(playerGemArr2[_loc1_].getTimes() <= 1)
                  {
                     this["d2_" + _loc1_].howNum.text = "";
                  }
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      public function sysSlotUpdate() : void
      {
         var _loc1_:uint = 0;
         synthesisSlotArr = synthesisSlot.slotArr();
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(synthesisSlotArr[_loc1_] != -1)
            {
               this["hc_" + _loc1_].visible = true;
               this["hc_" + _loc1_].howNum.text = "";
               this["hc_" + _loc1_].gotoAndStop(synthesisSlotArr[_loc1_].getFrame());
               this["hcc_" + _loc1_].gotoAndStop(2);
            }
            else
            {
               this["hc_" + _loc1_].visible = false;
               this["hcc_" + _loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      private function strenthenGl(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = param1 + param2;
         probability = _loc3_;
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
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            this["d1_" + _loc1_].stop();
            this["d2_" + _loc1_].stop();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this["qh_" + _loc1_].stop();
            this["qh_" + _loc1_].visible = false;
            this["hc_" + _loc1_].stop();
            this["hc_" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      private function synthesisToBagSty() : void
      {
         var _loc1_:uint = 0;
         synthesisSlotArr = synthesisSlot.slotArr();
         if(!playerState)
         {
            _loc1_ = 0;
            while(_loc1_ < 2)
            {
               if(synthesisSlotArr[_loc1_] != -1)
               {
                  strMove.gemBackToBag(synthesisSlotArr[_loc1_],bag1,synthesisSlot,_loc1_);
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 2)
            {
               if(synthesisSlotArr[_loc1_] != -1)
               {
                  strMove.gemBackToBag(synthesisSlotArr[_loc1_],bag2,synthesisSlot,_loc1_);
               }
               _loc1_++;
            }
         }
      }
      
      private function daojuMessageUp(param1:DaoJuEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         mouseuup = false;
         _loc2_ = param1.target as MovieClip;
         _loc3_ = _loc2_.name;
         _loc4_ = _loc3_.substr(1,1);
         _loc5_ = int(_loc3_.substr(3,2));
         mouseDownBo = false;
         _loc2_.stopDrag();
         this.addChildAt(_loc2_,childIndex);
         if(!playerState)
         {
            if(_loc4_ == "1")
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
               if(_loc4_ == "h")
               {
                  strengthenLanMoveToBag(pcOnePointArr,bag1);
               }
               if(_loc4_ == "c")
               {
                  synthesisSlotLanMoveToBag(pcOnePointArr,bag1);
               }
            }
         }
         else if(_loc4_ == "2")
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
            if(_loc4_ == "h")
            {
               strengthenLanMoveToBag(pcTowPointArr,bag2);
            }
            if(_loc4_ == "c")
            {
               synthesisSlotLanMoveToBag(pcTowPointArr,bag2);
            }
         }
      }
      
      private function outHandle(param1:BtnEvent) : void
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
      
      private function synthesisSlotLanMoveToBag(param1:Array, param2:Bag) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:Equip = null;
         var _loc7_:Equip = null;
         var _loc8_:Gem = null;
         var _loc9_:Gem = null;
         var _loc10_:Gem = null;
         _loc3_ = mouseX;
         _loc4_ = mouseY;
         targetMc.x = oldX;
         targetMc.y = oldY;
         _loc5_ = 0;
         for(; _loc5_ < 24; _loc5_++)
         {
            if(!(_loc3_ >= param1[_loc5_][1] && _loc3_ <= param1[_loc5_][1] + pc2_0.width && (_loc4_ >= param1[_loc5_][2] && _loc4_ <= param1[_loc5_][2] + pc2_0.height)))
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
                        _loc6_ = mosaicSlot.getProp(targetMc.id);
                        strMove.equipMoveToBag(_loc6_,mosaicSlot,param2,targetMc.id,param1[_loc5_][0]);
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
                        _loc7_ = deteleSlot.getProp(targetMc.id);
                        strMove.equipMoveToBag(_loc7_,deteleSlot,param2,targetMc.id,param1[_loc5_][0]);
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
                        _loc8_ = synthesisSlot.getProp(targetMc.id);
                        strMove.gemBackToBag(_loc8_,param2,synthesisSlot,targetMc.id,param1[_loc5_][0]);
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
                        _loc9_ = mosaicSlot.getProp(targetMc.id);
                        strMove.gemBackToBag(_loc9_,param2,mosaicSlot,targetMc.id,param1[_loc5_][0]);
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
                        _loc10_ = deteleSlot.getProp(targetMc.id);
                        strMove.gemBackToBag(_loc10_,param2,deteleSlot,targetMc.id,param1[_loc5_][0]);
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
                  param2.addOtherobjBag(synthesisSlot.slotArr[2]);
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
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            mosaicPointArr[_loc1_] = [_loc1_,this["hcc_" + _loc1_].x,this["hcc_" + _loc1_].y];
            _loc1_++;
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
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            deletePointArr[_loc1_] = [_loc1_,this["hcc_" + _loc1_].x,this["hcc_" + _loc1_].y];
            _loc1_++;
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
      
      private function clickHandle(param1:BtnEvent) : void
      {
         switch(param1.id)
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
      
      private function strengthenEquipTow(param1:Number, param2:Array, param3:Bag) : void
      {
         var _loc4_:Equip = null;
         var _loc5_:Gem = null;
         if(slot.getProp(0) == -1)
         {
            strMove.bagGemMoveToStr(param1,targetMc,param2,slot,param3);
            soltUpdate();
            gemUpdate();
         }
         else
         {
            _loc4_ = slot.getProp(0);
            _loc5_ = param3.getGemFromBag(targetMc.id);
            if(_loc5_.getType() == 1)
            {
               if(_loc4_.getReinforceLevel() < _loc5_.getUseLevel())
               {
                  strMove.bagGemMoveToStr(param1,targetMc,param2,slot,param3);
                  soltUpdate();
                  gemUpdate();
                  equipProbability = strMove.getEquipUpLevel(_loc4_,slot.getProp(1));
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
               strMove.bagGemMoveToStr(param1,targetMc,param2,slot,param3);
               soltUpdate();
               gemUpdate();
            }
         }
      }
      
      private function initAllBag(param1:Number = 1) : void
      {
         if(param1 == 1)
         {
            playerState = false;
         }
         else if(param1 == 2)
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
      
      private function changHandle(param1:BtnEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.target.name.substr(1,1);
         bagState = param1.id;
         switch(param1.id)
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
            if(param1.id == 6)
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
            if(param1.id == 7)
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
            if(param1.id == 8)
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
            if(param1.id == 9)
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
            if(param1.id == 10)
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
         var _loc1_:uint = 0;
         if(!playerState)
         {
            otherArr1 = bag1.getOtherobjBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(otherArr1[_loc1_] != null)
               {
                  this["d1_" + _loc1_].visible = true;
                  this["d1_" + _loc1_].gotoAndStop(otherArr1[_loc1_].getFrame());
               }
               else
               {
                  this["d1_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
         else
         {
            otherArr2 = bag2.getOtherobjBag();
            _loc1_ = 0;
            while(_loc1_ < 24)
            {
               if(otherArr2[_loc1_] != null)
               {
                  this["d2_" + _loc1_].visible = true;
                  this["d2_" + _loc1_].gotoAndStop(otherArr2[_loc1_].getFrame());
               }
               else
               {
                  this["d2_" + _loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      private function strengthenBagCao() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < 24)
         {
            pcOnePointArr[_loc1_] = [_loc1_,this["pc1_" + _loc1_].x,this["pc1_" + _loc1_].y];
            pcTowPointArr[_loc1_] = [_loc1_,this["pc2_" + _loc1_].x,this["pc2_" + _loc1_].y];
            _loc1_++;
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
