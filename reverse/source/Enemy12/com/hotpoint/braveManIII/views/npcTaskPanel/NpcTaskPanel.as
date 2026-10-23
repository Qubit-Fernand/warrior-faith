package com.hotpoint.braveManIII.views.npcTaskPanel
{
   import com.hotpoint.braveManIII.events.*;
   import com.hotpoint.braveManIII.models.container.*;
   import com.hotpoint.braveManIII.models.equip.*;
   import com.hotpoint.braveManIII.models.gem.*;
   import com.hotpoint.braveManIII.models.other.*;
   import com.hotpoint.braveManIII.models.supplies.*;
   import com.hotpoint.braveManIII.models.task.*;
   import com.hotpoint.braveManIII.views.itemsTooltip.*;
   import com.hotpoint.braveManIII.views.playerTaskPanel.*;
   import com.hotpoint.braveManIII.views.setKeyPanel.*;
   import com.hotpoint.braveManIII.views.shortTip.*;
   import flash.display.*;
   import flash.text.*;
   import src.*;
   
   public class NpcTaskPanel extends MovieClip
   {
      
      private static var _instance:NpcTaskPanel;
      
      public static var npcNum:uint = 0;
      
      private var slot:NpcTaskSlot;
      
      private var jlNum:Number = 3;
      
      private var taskingNum:Number = 0;
      
      private var tooltip:ItemsTooltip;
      
      private var ii:uint = 0;
      
      private var textData:TaskText;
      
      private var taskNum:Number = 9;
      
      private var taskList:Array;
      
      public function NpcTaskPanel()
      {
         super();
      }
      
      public static function open(num:uint = 1) : void
      {
         Main.allClosePanel();
         Main.stopXX = true;
         if(NpcTaskPanel._instance == null)
         {
            NpcTaskPanel._instance = new NpcTaskPanel();
            NpcTaskPanel._instance.textData = new TaskText();
            NpcTaskPanel._instance.tooltip = new ItemsTooltip();
         }
         npcNum = num;
         PlayerTaskData.addGoodsNum();
         PlayerTaskData.addGold();
         NpcTaskPanel._instance.initNpcList(num);
         NpcTaskPanel._instance.initNpcTask(num);
         NpcTaskPanel._instance.initSlot();
         NpcTaskPanel._instance.initSlotVisble();
         NpcTaskPanel._instance.initText();
         NpcTaskPanel._instance.renwuInit();
         NpcTaskPanel._instance.btnStata();
         NpcTaskPanel._instance.initStataRenwu();
         Main._stage.addChild(NpcTaskPanel._instance);
         NpcTaskPanel._instance.addEvent();
         NpcTaskPanel._instance.visible = true;
         NpcTaskPanel._instance.tooltip.visible = false;
         NpcTaskPanel._instance.addChild(NpcTaskPanel._instance.tooltip);
         NpcTaskPanel._instance.x = 100;
         NpcTaskPanel._instance.y = 50;
         NpcTaskPanel._instance.mcGoTo(num);
         NpcTaskPanel._instance.btnStata();
      }
      
      public static function close() : void
      {
         Main.stopXX = false;
         if(NpcTaskPanel._instance != null)
         {
            if(NpcTaskPanel._instance.visible == true)
            {
               NpcTaskPanel._instance.visible = false;
            }
         }
      }
      
      public function ycJl() : void
      {
         var i:uint = 0;
         for(i = 0; i < 3; i++)
         {
            this["j_" + i].visible = false;
         }
      }
      
      public function initSlotVisble() : void
      {
         var arr:Array = null;
         var i:uint = 0;
         trace("显示名字");
         arr = slot.getSlotArr();
         trace(arr);
         for(i = 0; i < arr.length; i++)
         {
            if(arr[i] != -1)
            {
               this["t_" + i].visible = true;
               this["t_" + i].tx.text = (arr[i] as Task).getName();
            }
            else
            {
               this["t_" + i].visible = false;
            }
         }
      }
      
      private function isTaskOk() : void
      {
         var i:uint = 0;
         for(i = 0; i < taskNum; i++)
         {
            if(slot.getTask(i) != null)
            {
               if(slot.getTask(i).istaskOk())
               {
                  slot.getTask(i).setStata(2);
               }
            }
         }
      }
      
      public function needTextVisible(slot:Object, num:Number) : void
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var arr3:Array = null;
         var i:uint = 0;
         arr1 = textData.getAllId(slot,num);
         arr2 = textData.getAllNum(slot,num);
         arr3 = textData.getAllNuming(slot,num);
         textKong();
         for(i = 0; i < arr1.length; i++)
         {
            this["n" + i].text = arr1[i] + ":" + "(" + arr3[i] + "/" + arr2[i] + ")";
         }
      }
      
      private function doChange(e:BtnEvent) : void
      {
         var mc:MovieClip = null;
         var id:Number = NaN;
         mc = MovieClip(e.target);
         id = Number(mc.name.substr(2,1));
         initText(id);
         renwuInit(id);
         btnStata();
      }
      
      public function jieshaoText() : void
      {
         jieshao.text = "";
         need_1.text = "";
         goldText.text = "";
         expText.text = "";
      }
      
      private function bbb(type:Number, id:Number, num:Number, bag:Bag) : Boolean
      {
         if(type == 1)
         {
            trace(bag.canPutOtherNum(id) + "背包剩余数量_装备________");
            trace(num + "要放入的数量_装备+++++++");
            if(num <= bag.backequipBagNum())
            {
               return true;
            }
         }
         else if(type == 2)
         {
            if(num <= bag.backSuppliesBagNum())
            {
               return true;
            }
         }
         else if(type == 3)
         {
            if(num <= bag.canPutGemNum(id))
            {
               return true;
            }
         }
         else if(type == 4)
         {
            trace(bag.canPutOtherNum(id) + "背包剩余数量_其他");
            trace(num + "要放入的数量_其他");
            if(num <= bag.canPutOtherNum(id))
            {
               trace("其他栏没满" + bag.canPutOtherNum(id));
               return true;
            }
         }
         return false;
      }
      
      public function clearGoods(task:Task) : void
      {
         var arr:Array = null;
         var i:uint = 0;
         if(task.getGoodsId() != null)
         {
            arr = task.getGoodsId();
            for(i = 0; i < arr.length; i++)
            {
               clearP1orP2(arr[i],task.getId());
            }
         }
      }
      
      public function clearP1orP2(id:Number, taskId:Number) : void
      {
         if(taskId != 210002)
         {
            Main.player1.getBag().clearQuest(id);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearQuest(id);
            }
         }
         else
         {
            Main.player1.getBag().clearOther(id);
            if(Main.P1P2)
            {
               Main.player2.getBag().clearOther(id);
            }
         }
      }
      
      public function doClose(e:BtnEvent) : void
      {
         close();
      }
      
      public function initSlot() : void
      {
         var i:uint = 0;
         slot = NpcTaskSlot.creatSlot();
         for(i = 0; i < taskList.length; i++)
         {
            slot.addSlot(taskList[i]);
         }
         trace("存入槽");
      }
      
      private function p1orp2(ob:Object, bag:Bag) : void
      {
         if(ob as Equip)
         {
            bag.addEquipBag(ob);
         }
         else if(ob as Gem)
         {
            bag.addGemBag(ob);
         }
         else if(ob as Supplies)
         {
            bag.addSuppliesBag(ob);
         }
         else if(ob as Otherobj)
         {
            bag.addOtherobjBag(ob);
         }
      }
      
      private function getTaskStata0() : Task
      {
         if(slot.getTask(taskingNum) != null)
         {
            return slot.getTask(taskingNum);
         }
         return null;
      }
      
      private function mcGoTo(num:Number) : void
      {
         if(num == 1)
         {
            this.name_mc.gotoAndStop(1);
         }
         else if(num == 2)
         {
            this.name_mc.gotoAndStop(2);
         }
         else if(num == 3)
         {
            this.name_mc.gotoAndStop(3);
         }
      }
      
      public function initText(num:Number = 0) : void
      {
         if(slot.getTask(num))
         {
            jieshao.text = textData.getIntroduction(slot,num);
            need_1.text = textData.getDemand(slot,num);
            goldText.text = textData.getGold(slot,num);
            expText.text = textData.getExp(slot,num);
            needTextVisible(slot,num);
            jlVisible(textData.addJl(slot,num),textData.getAwrdNum(slot,num));
         }
         else
         {
            jieshaoText();
            textKong();
            ycJl();
         }
      }
      
      public function initStataRenwu() : void
      {
         var i:uint = 0;
         isTaskOk();
         for(i = 0; i < taskNum; i++)
         {
            if(slot.getTask(i))
            {
               if(slot.getTask(i).getStata() == 0)
               {
                  this["t_" + i].ox.text = "(未接取)";
               }
               else if(slot.getTask(i).getStata() == 1)
               {
                  this["t_" + i].ox.text = "(进行中)";
               }
               else if(slot.getTask(i).getStata() == 2)
               {
                  this["t_" + i].ox.text = "(已完成)";
               }
               else if(slot.getTask(i).getStata() == 3)
               {
                  this["t_" + i].ox.text = "(冷却中)";
               }
            }
         }
      }
      
      private function renwuInit(id:Number = 0) : void
      {
         var i:uint = 0;
         for(i = 0; i < taskNum; i++)
         {
            this["t_" + i].isClick = false;
         }
         this["t_" + id].isClick = true;
         taskingNum = id;
      }
      
      private function bagNum(task:Task) : Boolean
      {
         var arr:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         var i:uint = 0;
         arr = [];
         arr1 = textData.getAwardTypeAndId(slot,taskingNum);
         arr2 = textData.getAwrdNum(slot,taskingNum);
         if(arr1.length < 1)
         {
            return true;
         }
         for(i = 0; i < arr1.length; i++)
         {
            arr.push(bagHow(arr1[i][0],arr1[i][1],arr2[i],task));
         }
         for(i = 0; i < arr.length; i++)
         {
            if(arr[i] == false)
            {
               return false;
            }
         }
         return true;
      }
      
      private function bagHow(type:Number, id:Number, num:Number, task:Task) : Boolean
      {
         if(task.getWho() == 1)
         {
            return bbb(type,id,num,Main.player1.getBag());
         }
         if(task.getWho() == 2)
         {
            return bbb(type,id,num,Main.player2.getBag());
         }
         if(task.getWho() == 3)
         {
            if(Main.P1P2)
            {
               if(Boolean(bbb(type,id,num,Main.player1.getBag())) && Boolean(bbb(type,id,num,Main.player2.getBag())))
               {
                  return true;
               }
            }
            else if(bbb(type,id,num,Main.player1.getBag()))
            {
               return true;
            }
         }
         return false;
      }
      
      public function btnStata() : void
      {
         var task:Task = null;
         task = getTaskStata0();
         if(task != null)
         {
            if(task.getStata() == 0)
            {
               this.npcBtn.gotoAndStop(1);
               this.finish_btn.visible = false;
            }
            else
            {
               if(task.getStata() == 1)
               {
                  this.finish_btn.visible = false;
               }
               else if(task.getStata() == 2)
               {
                  this.finish_btn.visible = true;
               }
               this.npcBtn.gotoAndStop(2);
            }
         }
         else
         {
            this.finish_btn.visible = false;
            this.npcBtn.gotoAndStop(1);
         }
      }
      
      public function clearGold(task:Task) : void
      {
         if(task.getFinishGold() != -1)
         {
            Main.player1.payGold(task.getFinishGold());
            if(Main.P1P2)
            {
               Main.player2.payGold(task.getFinishGold());
            }
         }
      }
      
      public function addEvent() : void
      {
         this.addEventListener(BtnEvent.DO_CHANGE,doChange);
         this.addEventListener(BtnEvent.DO_CLICK,doClick);
         this.addEventListener(BtnEvent.DO_CLOSE,doClose);
         this.addEventListener(BtnEvent.DO_OVER,doOver);
         this.addEventListener(BtnEvent.DO_OUT,doOut);
      }
      
      private function tooVisible(ob:Object) : void
      {
         if(ob as Equip)
         {
            tooltip.equipTooltip(ob);
         }
         else if(ob as Gem)
         {
            tooltip.gemTooltip(ob);
         }
         else if(ob as Supplies)
         {
            tooltip.suppliesTooltip(ob);
         }
         else if(ob as Otherobj)
         {
            tooltip.otherTooltip(ob);
         }
      }
      
      private function doClick(e:BtnEvent) : void
      {
         var tasking:Task = null;
         var taskId:Number = NaN;
         trace(e.id);
         if(getTaskStata0() != null)
         {
            tasking = getTaskStata0();
            taskId = tasking.getId();
            if(e.id == 1)
            {
               if(NpcListData.getStata(taskId) == 0)
               {
                  NpcListData.setStata(taskId,1);
               }
            }
            else if(e.id == 2)
            {
               trace("放弃");
               if(NpcListData.getStata(taskId) == 1 || NpcListData.getStata(taskId) == 2)
               {
                  tasking.clearKong();
                  NpcListData.setStata(taskId,0);
                  PlayerTaskData.clearTask(taskId);
                  initText();
                  renwuInit();
                  taskingNum = 0;
               }
            }
            else if(e.id == 3)
            {
               if(NpcListData.getStata(taskId) == 2)
               {
                  if(bagNum(tasking))
                  {
                     overAward(tasking);
                     overGoldAncExp(tasking);
                     overPlayerStata(tasking);
                     clearGoods(tasking);
                     clearGold(tasking);
                     if(tasking.isAgin())
                     {
                        if(tasking.isRc())
                        {
                           NpcListData.setStata(taskId,3);
                        }
                        else
                        {
                           NpcListData.setStata(taskId,0);
                        }
                     }
                     else
                     {
                        NpcListData.clearTask(taskId);
                        PlayerTaskData.clearTask(taskId);
                        NpcListData.setOldTask(tasking);
                     }
                     initNpcList(npcNum);
                     initNpcTask(npcNum);
                     initSlot();
                     initSlotVisble();
                     initText();
                     renwuInit();
                     taskingNum = 0;
                  }
                  else
                  {
                     ShortTip.open(3);
                     trace("背包满");
                  }
               }
            }
            tasking.clearKong();
            initStataRenwu();
            btnStata();
         }
         else
         {
            trace("没有选择的任务");
         }
      }
      
      public function doOut(e:BtnEvent) : void
      {
         tooltip.visible = false;
      }
      
      public function jlVisible(arr:Array, arr1:Array) : void
      {
         var i:uint = 0;
         for(i = 0; i < jlNum; i++)
         {
            this["j_" + i].visible = false;
         }
         if(arr != null)
         {
            for(i = 0; i < arr.length; i++)
            {
               this["j_" + i].visible = true;
               this["j_" + i].howNum.text = arr1[i];
               this["j_" + i].gotoAndStop(arr[i][0].getFrame());
            }
         }
      }
      
      public function initNpcTask(num:Number = 1) : void
      {
         if(num == 1)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskZx());
         }
         else if(num == 2)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskZz());
            trace(taskList + "___________TASKlIST");
         }
         else if(num == 3)
         {
            taskList = NpcTaskData.levelOk(NpcListData.getTaskTs());
         }
      }
      
      private function overPlayerStata(task:Task) : void
      {
         if(task.getWho() == 1)
         {
            if(task.getAwardPlayerDate() == 1)
            {
               Main.player1.setRebirth();
            }
         }
         else if(task.getWho() == 2)
         {
            if(task.getAwardPlayerDate() == 1)
            {
               Main.player2.setRebirth();
            }
         }
         else if(task.getWho() == 3)
         {
            if(task.getAwardPlayerDate() == 1)
            {
               Main.player1.setRebirth();
            }
            if(Main.P1P2)
            {
               if(task.getAwardPlayerDate() == 1)
               {
                  Main.player2.setRebirth();
               }
            }
         }
      }
      
      private function overGoldAncExp(task:Task) : void
      {
         if(task.getWho() == 1)
         {
            Main.player1.addGold(textData.getGold(slot,taskingNum));
            Main.player_1.ExpUP(int(textData.getGold(slot,taskingNum)));
         }
         else if(task.getWho() == 2)
         {
            Main.player2.addGold(textData.getGold(slot,taskingNum));
            Main.player_2.ExpUP(int(textData.getGold(slot,taskingNum)));
         }
         else if(task.getWho() == 3)
         {
            Main.player1.addGold(textData.getGold(slot,taskingNum));
            Main.player_1.ExpUP(int(textData.getGold(slot,taskingNum)));
            if(Main.P1P2)
            {
               Main.player2.addGold(textData.getGold(slot,taskingNum));
               Main.player_2.ExpUP(int(textData.getGold(slot,taskingNum)));
            }
         }
      }
      
      private function overAward(task:Task) : void
      {
         var arrEqu:Array = null;
         var arrGem:Array = null;
         var arrSup:Array = null;
         var arrOth:Array = null;
         var i:uint = 0;
         arrEqu = textData.addJlEqu(slot,taskingNum);
         arrGem = textData.addJlGem(slot,taskingNum);
         arrSup = textData.addJlSup(slot,taskingNum);
         arrOth = textData.addJlOther(slot,taskingNum);
         if(arrEqu.length > 0)
         {
            for(i = 0; i < arrEqu.length; i++)
            {
               howAward(task,arrEqu[i]);
            }
         }
         if(arrGem.length > 0)
         {
            for(i = 0; i < arrGem.length; i++)
            {
               howAward(task,arrGem[i]);
            }
         }
         if(arrSup.length > 0)
         {
            for(i = 0; i < arrSup.length; i++)
            {
               howAward(task,arrSup[i]);
            }
         }
         if(arrOth.length > 0)
         {
            for(i = 0; i < arrOth.length; i++)
            {
               howAward(task,arrOth[i]);
            }
         }
      }
      
      private function howAward(task:Task, ob:Object) : void
      {
         var obj2:Object = null;
         if(task.getWho() == 1)
         {
            p1orp2(ob,Main.player1.getBag());
         }
         else if(task.getWho() == 2)
         {
            p1orp2(ob,Main.player2.getBag());
         }
         else if(task.getWho() == 3)
         {
            obj2 = new Object();
            obj2 = DeepCopyUtil.clone(ob);
            p1orp2(ob,Main.player1.getBag());
            if(Main.P1P2)
            {
               p1orp2(obj2,Main.player2.getBag());
            }
         }
      }
      
      public function initNpcList(num:Number = 1) : void
      {
         if(num == 1)
         {
            NpcListData.setTaskZx(NpcTaskData.updateOne());
         }
         else if(num == 2)
         {
            NpcListData.setTaskZz(NpcTaskData.updateTow());
         }
         else if(num == 3)
         {
            NpcListData.setTaskTs(NpcTaskData.updateThree());
         }
      }
      
      public function textKong() : void
      {
         var i:uint = 0;
         for(i = 0; i < 4; i++)
         {
            this["n" + i].text = "";
         }
      }
      
      private function doOver(e:BtnEvent) : void
      {
         var arr:Array = null;
         var id:Number = NaN;
         arr = textData.addJl(slot,taskingNum);
         id = Number(String(e.target.name).substr(2,1));
         switch(id)
         {
            case 0:
               tooVisible(arr[0][0]);
               break;
            case 1:
               tooVisible(arr[1][0]);
               break;
            case 2:
               tooVisible(arr[2][0]);
         }
         tooltip.x = mouseX;
         tooltip.y = mouseY;
         tooltip.visible = true;
      }
   }
}

